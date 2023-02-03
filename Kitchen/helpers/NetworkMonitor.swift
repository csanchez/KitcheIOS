//
//  NetworkMonitor.swift
//  AppIIS
//
//  Created by Tecnologias iis on 30/01/23.
// https://www.youtube.com/watch?v=WjJBRhPiM_I

import Foundation
import Network



class NetworkMonitor {
    static let shared = NetworkMonitor()

    private let monitor: NWPathMonitor
    private let queue  = DispatchQueue.global()
    
    
    
   /* private var status: NWPath.Status = .requiresConnection
    var isReachable: Bool { status == .satisfied }
    var isReachableOnCellular: Bool = true*/
    
    
    public private(set)  var isConected: Bool = false
    
    
    private init(){
        monitor = NWPathMonitor()
    }
    
    
    func startMonitoring() {
       monitor.start(queue: queue)
       monitor.pathUpdateHandler = { [weak self] path in
           print("checando internet")
           print(path.status)
           self?.isConected = path.status == .satisfied
           
           
           
       }

       
   }
    
    /*
     func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.status = path.status
            self?.isReachableOnCellular = path.isExpensive

            if path.status == .satisfied {
                print("We're connected!")
                // post connected notification
            } else {
                print("No connection.")
                // post disconnected notification
            }
            print(path.isExpensive)
        }

        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }
     */

    func stopMonitoring() {
        monitor.cancel()
    }
}
