import SwiftUI

struct CustomTextField: View {
    @Binding var text: String
    var label: String
    var placeholder: String
    var sfSymbol: String
    @FocusState private var isFocused: Bool

    var body: some View {
        ZStack(alignment: .leading) {
            TextField(placeholder, text: $text)
                .focused($isFocused)
                .font(.system(size: 14, weight: .semibold))
                .padding(.vertical, 23)
                .padding(.leading, 10)
                .padding(.trailing, 40)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(isFocused ? Color("Primary") : Color.clear, lineWidth: 2)
                )
                .foregroundColor(.black)
                .overlay(
                    HStack {
                        Spacer()
                        Image(systemName: sfSymbol)
                            .foregroundColor(isFocused ? Color("Primary") : Color("textSecondary"))
                            .padding(.trailing)
                            .font(.title3)
                    }
                )
                .background(RoundedRectangle(cornerRadius: 8).foregroundColor(Color("Secondary")))
            
            Text(label)
                .foregroundColor(Color("textSecondary"))
                .offset(y: text.isEmpty && !isFocused ? 0 : -25)
                .scaleEffect(text.isEmpty && !isFocused ? 1 : 0.8, anchor: .leading)
                .animation(.spring(response: 0.4, dampingFraction: 0.5))
                .bold()
                .padding(.leading, 10)
                .padding(.vertical, 20)
                .font(.system(size: 14, weight: .medium))
        }
        .padding(.top, 15)
    }
}

struct CustomSecureTextField: View {
    @Binding var text: String
    var label: String
    var placeholder: String
    var sfSymbol: String
    @FocusState private var isFocused: Bool

    var body: some View {
        ZStack(alignment: .leading) {
            SecureField(placeholder, text: $text)
                .focused($isFocused)
                .font(.system(size: 14, weight: .semibold))
                .padding(.vertical, 23)
                .padding(.leading, 10)
                .padding(.trailing, 40)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(isFocused ? Color("Primary") : Color.clear, lineWidth: 2)
                )
                .foregroundColor(.black)
                .overlay(
                    HStack {
                        Spacer()
                        Image(systemName: sfSymbol)
                            .foregroundColor(isFocused ? Color("Primary") : Color("textSecondary"))
                            .padding(.trailing)
                            .font(.title3)
                    }
                )
                .background(RoundedRectangle(cornerRadius: 8).foregroundColor(Color("Secondary")))
            
            Text(label)
                .foregroundColor(Color("textSecondary"))
                .offset(y: text.isEmpty && !isFocused ? 0 : -25)
                .scaleEffect(text.isEmpty && !isFocused ? 1 : 0.8, anchor: .leading)
                .animation(.spring(response: 0.4, dampingFraction: 0.5))
                .bold()
                .padding(.leading, 10)
                .padding(.vertical, 20)
                .font(.system(size: 14, weight: .medium))
        }
        .padding(.top, 15)
    }
}

struct CustomDatePicker: View {
    @Binding var date: Date
    var label: String
    var sfSymbol: String

    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(Color("Secondary"))
                .frame(height: 60)

            HStack {
                Text(label)
              
                    .foregroundColor(Color("textSecondary"))
                    .bold()
                    .font(.system(size: 14, weight: .medium))

                Spacer()

                DatePicker("", selection: $date, displayedComponents: .date)
                    .datePickerStyle(.compact)
                    .labelsHidden()
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.black)
                  

                Image(systemName: sfSymbol)
                    .foregroundColor(Color("textSecondary"))
                    .padding(.trailing)
                    .font(.title3)
            }
            .padding(.leading, 10)
            .padding(.vertical, 20)
        }
        .padding(.top, 15)
    }
}




