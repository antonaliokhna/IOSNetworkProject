//
//  NetworkSession.swift
//  NetworkProject
//
//  Created by Anton Aliokhna on 9/8/22.
//

import Foundation

enum NetworkSession: String, CaseIterable {
    private static var detaultValue = NetworkSession.useAlamofire
    static var shared: NetworkSession = {
        guard let rawValue = UserDefaults.standard.string(forKey: "networkSesionType"),
              let value = NetworkSession(rawValue: rawValue) else { return detaultValue }
        return value
    }() {
        didSet {
            UserDefaults.standard.setValue(shared.rawValue, forKey: "networkSesionType")
        }
    }

    static var network: NetworkManagerType {
        return NetworkSession.shared == .useAlamofire ? AlamofireNetworkManager() : URLSessionNetworkManager()
    }

    case useURLSession = "URLSession"
    case useAlamofire = "Alamofire"
}
