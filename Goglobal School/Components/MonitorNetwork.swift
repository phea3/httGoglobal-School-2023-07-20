//
//  MonitorNetwork.swift
//  Goglobal School
//
//  Created by Leng Mouyngech on 12/9/22.
//

import Foundation
import Network

class Monitor: ObservableObject {
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "Monitor")
    @Published private(set) var connected: Bool = false
    func checkConnection() {
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                    self.connected = true
            } else {
                    self.connected = false
            }
        }
        monitor.start(queue: queue)
    }
}
