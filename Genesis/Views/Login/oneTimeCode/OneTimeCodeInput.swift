//
//  OneTimeCodeInput.swift
//  Genesis
//
//  Created by Iñaki Sigüenza on 06/08/23.
//

import SwiftUI

struct OneTimeCodeInput: UIViewRepresentable {
    typealias UIViewType = UITextField
    
    let index: Int
    @Binding var codeDict: [Int: String]
    @Binding var firstResponderIndex: Int
    var onCommit: (()->Void)?
    
    // MARK: - Internal Type
    
    class Coordinator: NSObject, UITextFieldDelegate {
        let index: Int
        @Binding var codeDict: [Int: String]
        @Binding var firstResponderIndex: Int
        
        private lazy var codeDigits: Int = codeDict.count
        
        init(index: Int, codeDict: Binding<[Int: String]>, firstResponderIndex: Binding<Int>) {
            self.index = index
            self._codeDict = codeDict
            self._firstResponderIndex = firstResponderIndex
        }
        
        @objc func textFieldEditingChanged(_ textField: UITextField) {
            print("textField.text!", textField.text!)
            
            guard textField.text!.count == codeDigits else { return }
            
            codeDict = textField.text!.enumerated().reduce(into: [Int: String](), { dict, tuple in
                let (index, char) = tuple
                dict.updateValue(String(char), forKey: index)
            })
            
            firstResponderIndex = codeDigits - 1
            
        }
        
        func textField(_ textField: UITextField,
                       shouldChangeCharactersIn range: NSRange,
                       replacementString string: String) -> Bool
        {
            print("replacementString", string)
            
            // 3. deleting
            if string.isBackspace {
                codeDict.updateValue("", forKey: index)
                firstResponderIndex = max(0, textField.text == "" ? index - 1 : index)
                return false
            }
            
            // 1. typing
            // 2. pasting
            for i in index..<min(codeDict.count, index + string.count) {
                codeDict.updateValue(string.stringAt(index: i - index), forKey: i)
//                print(codeDict)
                firstResponderIndex = min(codeDict.count - 1, index + string.count)
            }
            
            
            return true
        }
        
    }
    
    func makeCoordinator() -> Coordinator {
        .init(index: index, codeDict: $codeDict, firstResponderIndex: $firstResponderIndex)
    }
    
    // MARK: - Required Methods
    
    func makeUIView(context: Context) -> UITextField {
        let tf = BackspaceTextField(onDelete: {
            firstResponderIndex = max(0, index - 1)
        })
        tf.addTarget(context.coordinator, action: #selector(Coordinator.textFieldEditingChanged), for: .editingChanged)
        tf.delegate = context.coordinator
        tf.keyboardType = .numberPad
        tf.textContentType = .oneTimeCode
        tf.font = .preferredFont(forTextStyle: .largeTitle)
        tf.textAlignment = .center
        return tf
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = codeDict[index]
        
        if index == firstResponderIndex {
            uiView.becomeFirstResponder()
        }
        
        if index == firstResponderIndex,
            codeDict.values.filter({ !$0.isEmpty }).count == codeDict.count
        {
            onCommit?()
        }
    }
    
}


// MARK: - Backspace Textfield

extension OneTimeCodeInput {
    
    
    class BackspaceTextField: UITextField {
        
        var onDelete: (()->Void)?
        
        init(onDelete: (()->Void)?) {
            self.onDelete = onDelete
            
            super.init(frame: .zero)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func deleteBackward() {
            super.deleteBackward()
            
            onDelete?()
        }
    }
    
}
