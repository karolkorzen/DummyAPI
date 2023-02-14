//
//  RESTError+errorDescription.swift
//  DummyAPI
//
//  Created by Karol Korzeń on 14/02/2023.
//

import Foundation
import Networking
import CommonResources

extension RESTError: LocalizedError {    
    public var errorDescription: String? {
        switch self {
        case let .wrongStatusResponse(_, data):
            return data?.message ?? L10n.unknownErrorHasOccured
        case .noInternetConnection:
            return L10n.noInternetConnection
        case .unknown: return L10n.unknownErrorHasOccured
        case let .customError(error):
            return error.localizedDescription
        }
    }
}
