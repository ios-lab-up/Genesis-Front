//
//  GlobalDataModel.swift
//  Genesis
//
//  Created by Luis Cedillo M on 06/11/23.
//

import Foundation

class GlobalDataModel: ObservableObject {
    static let shared = GlobalDataModel()
    @Published var user: User?

    private init() {} // Private initializer to enforce singleton usage
}
