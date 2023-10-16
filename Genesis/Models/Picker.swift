//
//  Picker.swift
//  Genesis
//
//  Created by Iñaki Sigüenza on 11/10/23.
//

import UIKit

enum Picker {
    enum Source {
        case library, camera
    }
    
    static func checkPermissions() -> Bool {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            return true
        } else {
            return false
        }
    }
}
