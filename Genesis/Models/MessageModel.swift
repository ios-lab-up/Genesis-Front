//
//  MessageModel.swift
//  Genesis
//
//  Created by Iñaki Sigüenza on 23/10/23.
//

import Foundation
import SocketIO


class SocketHelper {
    
    static let shared = SocketHelper()
    private var socket: SocketIOClient!
    private let manager: SocketManager
    
    private init() {
        // Replace 'AppUrls.socketURL' with your actual socket URL
        manager = SocketManager(socketURL: URL(string: APIEndpoints.baseURL)!, config: [.log(true)])
        socket = manager.defaultSocket
    }
    
    func connectSocket(completion: @escaping (Bool, Error?) -> Void) {
        disconnectSocket()
        socket.on(clientEvent: .connect) { [weak self] data, ack in
            print("Socket connected")
            self?.socket.removeAllHandlers()
            completion(true, Error?.none)
        }
        
        socket.on(clientEvent: .disconnect) { data, ack in
            print("Socket disconnected")
        }
        
        // Add other event handlers here...
        
        socket.connect()
    }
    
    func disconnectSocket() {
        socket.disconnect()
        print("Socket disconnected")
        socket.removeAllHandlers()
    }
    
    func isConnected() -> Bool {
        return socket.manager?.status == .connected
    }
    
    func joinRoom(username: String, room: String) {
        let data: [String: Any] = ["username": username, "room": room]
        SocketHelper.shared.socket.emit("join", data)
    }
    
    func leaveRoom(username: String, room: String) {
        let data: [String: Any] = ["username": username, "room": room]
        SocketHelper.shared.socket.emit("leave", data)
    }
    
    enum Events {
        case newMessage
        case joinRoom
        case leaveRoom
        // Add other cases as needed...
        
        var emitterName: String {
            switch self {
            case .newMessage:
                return "send_message"
            case .joinRoom:
                return "join"
            case .leaveRoom:
                return "leave"
            }
        }
        
        var listenerName: String {
            switch self {
            case .newMessage:
                return "new_message"
            case .joinRoom:
                return "join_room"
            case .leaveRoom:
                return "leave_room"
            }
        }
        
        func emit(params: [String: Any]) {
            SocketHelper.shared.socket.emit(emitterName, params)
        }
        
        func listen(completion: @escaping (Any) -> Void) {
            SocketHelper.shared.socket.on(listenerName) { response, emitter in
                completion(response)
            }
        }
        
        func off() {
            SocketHelper.shared.socket.off(listenerName)
        }
        
        
        
        enum Events {
            case newMessage
            case joinRoom
            case leaveRoom
            // Add other cases as needed...
            
            var emitterName: String {
                switch self {
                case .newMessage:
                    return "send_message"
                case .joinRoom:
                    return "join"
                case .leaveRoom:
                    return "leave"
                }
            }
            
            var listenerName: String {
                switch self {
                case .newMessage:
                    return "new_message"
                case .joinRoom:
                    return "join_room"
                case .leaveRoom:
                    return "leave_room"
                }
            }
            
            func emit(params: [String: Any]) {
                SocketHelper.shared.socket.emit(emitterName, params)
            }
            
            func listen(completion: @escaping (Any) -> Void) {
                SocketHelper.shared.socket.on(listenerName) { response, emitter in
                    completion(response)
                }
            }
            
            func off() {
                SocketHelper.shared.socket.off(listenerName)
            }
        }
    }
    
    struct Message: Identifiable {
        let id = UUID() // Conform to Identifiable
        var userUid: String
        var text: String
        var photoURL: String
        var createdAt: Date
        var isFromCurrentUser: Bool
        
        init(userUid: String, text: String, photoURL: String, createdAt: Date, isFromCurrentUser: Bool) {
            self.userUid = userUid
            self.text = text
            self.photoURL = photoURL
            self.createdAt = createdAt
            self.isFromCurrentUser = isFromCurrentUser
        }
        
        // This initializer is now updated to handle a date string
        init?(dictionary: [String: Any]) {
            guard let userUid = dictionary["userUid"] as? String,
                  let text = dictionary["text"] as? String,
                  let photoURL = dictionary["photoURL"] as? String,
                  let createdAtString = dictionary["createdAt"] as? String else {
                return nil
            }
            
            let dateFormatter = ISO8601DateFormatter()
            guard let createdAt = dateFormatter.date(from: createdAtString) else {
                return nil
            }
            
            self.init(userUid: userUid, text: text, photoURL: photoURL, createdAt: createdAt, isFromCurrentUser: false) // Determine isFromCurrentUser based on your logic
        }
    }
    
}
