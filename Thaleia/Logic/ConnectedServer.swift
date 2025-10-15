//
//  ConnectedServer.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 10/15/25.
//

import Foundation

public protocol ConnectedServer: Identifiable, Codable {
    var id: UUID { get }
    var name: String { get set }
    var baseURL: URL { get set }
    var apiKey: String { get set }
    var type: ConnectedServerType { get set }
    var status: ConnectedServerStatus { get }
    
    func getRequest(
        at path: String,
        headers: Dictionary<String, Any>,
        body: String
    ) -> Dictionary<String, Any>
    
    func postRequest(
        at path: String,
        headers: Dictionary<String, Any>,
        body: Dictionary<String, Any>
    )
}
