//
//  Config.swift
//  DummyAPI
//
//  Created by Karol Korzeń on 12/02/2023.
//

import Foundation

public struct AppConfig {
    private static var config = PlistConfig.current
    public static let current: Self = .init()
    
    public let scheme: String = config.scheme
    public let host: String = config.host
}

/// This object is used to retrieve raw values provided by the Info.plist
struct PlistConfig: Decodable {
    let scheme: String
    let host: String
}


struct PlistConfigContainer: Decodable { let Config: PlistConfig }

extension PlistConfig {
    static var current: PlistConfig = {
        guard
            let infoURL = Bundle.main.url(forResource: "Info", withExtension: "plist")
        else { fatalError("No Info.plist") }
        do {
            let infoData = try Data(contentsOf: infoURL)
            let decoder = PropertyListDecoder()
            let item = try decoder.decode(PlistConfigContainer.self, from: infoData)
            return item.Config
        } catch {
            fatalError("Parsing configuration files failed")
        }
    }()
}

