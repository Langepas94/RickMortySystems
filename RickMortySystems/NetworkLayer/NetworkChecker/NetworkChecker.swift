//
//  NetworkChecker.swift
//  RickMortySystems
//
//  Created by Артём Тюрморезов on 18.08.2023.
//

import Foundation
import Network

final class NetworkChecker {
    static let shared = NetworkChecker()
    private let monitor: NWPathMonitor
    
    private(set) var isConnected = false
    private(set) var isExpensive = false
    private(set) var currentConnectionType: NWInterface.InterfaceType?
    
    private let queue = DispatchQueue(label: "com.ArtemApp.NetworkConnectivityMonitor")
    
    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status != .unsatisfied
            self?.isExpensive = path.isExpensive
            self?.currentConnectionType = NWInterface.InterfaceType.allCases.filter { path.usesInterfaceType($0)}.first
        }
        monitor.start(queue: queue)
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
    
    
    private init() {
        monitor = NWPathMonitor()
    }
}

extension NWInterface.InterfaceType: CaseIterable {
    public static var allCases: [NWInterface.InterfaceType] = [
      .other,
      .wifi,
      .cellular,
      .loopback,
      .wiredEthernet
      ]
}
