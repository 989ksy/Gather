//
//  SocketManager.swift
//  Purple
//
//  Created by Seungyeon Kim on 2/16/24.
//

import Foundation
import SocketIO

/*
 socket.IO 메서드
  - socket.connect(): 설정 주소/포트로 소켓 연결
  - socket.disconnect(): 소켓 연결 해제
  - socket.emit(“event”, [“data”]): 이벤트명으로 데이터 송신
  - socket.on(“event”): 이벤트명으로 송신된 이벤트 수신
 */

class SocketIOManager: NSObject {
    
    static let shared = SocketIOManager()
    
    var manager: SocketManager!
    var socket: SocketIOClient!
    
    private let baseURL = URL(string: BaseServer.base)
    
    var isOpen = false // 소켓 연결 상태 파악용
    
    override init() {
        super.init()
        
        self.manager = SocketManager(socketURL: baseURL!, config: [
            .log(true), //debug 가능
            .compress //websocket 전송에서 compression을 가능하게 함.
        ])
        
        socket = self.manager.defaultSocket // 디폴트로 "/"로 된 룸
        
        // socket.on; .connect로 된 이벤트 수신
        // ack : "잘받음" 의미
        socket.on(clientEvent: .connect) { data, ack in
            print("SOCKET IS CONNECTED : ", data, ack)
        }
        
        // 소켓 연결 해제 메서드
        socket.on(clientEvent: .disconnect) { data, ack in
            print("SOCKET IS DISCONNECTED : ", data, ack)
        }
        
        
    }
    
    // 소켓 연결
    func establisheConnection(_ channelID: Int) {
        
        socket = self.manager.socket(forNamespace: "/ws-channel-\(channelID)")
        socket.connect() // 설정한 주소와 포트로 소켓 연결 시도
        self.isOpen = true
        
        print("----🚪 소켓 열림")
        
    }
    
    // 소켓 연결 해제
    func closeConnection() {
        
        socket.disconnect() //소켓 연결 종료
        socket.removeAllHandlers()
        self.isOpen = false
        
        print("----🚪 소켓 닫힘")
        
    }
    
    // 메세지 수신
    func listenForMessages(completion: @escaping (CreateChannelChatResponse) -> Void) {
        socket.on("channel") { data, ack in
            guard let jsonData = data[0] as? [String: Any] else { return }
            
            print("---", jsonData)

            do {
                let jsonData = try JSONSerialization.data(withJSONObject: jsonData, options: [])
                let messageData = try JSONDecoder().decode(CreateChannelChatResponse.self, from: jsonData)
                
                print("+++++++", messageData)
                completion(messageData)
                
            } catch {
                print("Error decoding message data: \(error)")
            }
        }
    }
    
    
    
}
