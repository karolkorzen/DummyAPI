//
//  ProductsRESTRequest.swift
//  DummyAPI
//
//  Created by Karol Korzeń on 13/02/2023.
//

import Foundation
import Networking

enum ProductsRESTRequest: RESTRequest {
    case getProducts
    case searchProduct(String)
    
    var endpoint: String {
        switch self {
        case .getProducts:
            return "/products"
        case .searchProduct:
            return "/products/search"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getProducts:
            return .get
        case .searchProduct:
            return .get
        }
    }
    
    var queryParams: [String : String] {
        switch self {
        case .getProducts:
            return [:]
        case .searchProduct(let input):
            return ["q" : input]
        }
    }
}
