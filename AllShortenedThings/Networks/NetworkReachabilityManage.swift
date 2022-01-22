//
//  NetworkReachabilityManage.swift
//  AllShortenedThings
//
//  Created by Hasan Dag on 14.12.2021.
//

import Foundation
import Alamofire

final class NetworkReachabilityManage {
    static let shared = NetworkReachabilityManage()
    private init(){
        
    }
    let manager = NetworkReachabilityManager(host: "www.apple.com")
    var isReach = false
    
    func startListening() {
        manager?.startListening(onQueue: .main, onUpdatePerforming: { (networkStatus) in
            if networkStatus == .reachable(.cellular) || networkStatus == .reachable(.ethernetOrWiFi) {
                self.isReach = true
            }
            else{
                self.isReach = false
            }
        })
    }
    
    func isConnected() -> Bool {
        return self.isReach
    }
}

/* Notes:
    start startlistening(AppDelegate, Service Network classes) and look to isConnected state
 */
