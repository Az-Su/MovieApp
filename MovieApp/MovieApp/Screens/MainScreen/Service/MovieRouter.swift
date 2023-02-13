//
//  MovieRouter.swift
//  MovieApp
//
//  Created by Sailau Almaz Maratuly on 12.02.2023.
//

import Foundation

enum MovieRouter: Router {
    case stocks(currency: String, count: String)
    
    var api: String {
        "b6e80992124a3aacbadb112ae8ab8e5f"
    }
    
    var baseUrl: String {
        "https://api.coingecko.com"
    }
    
    var path: String {
        switch self {
        case .stocks:
            return "/api/v3/coins/markets"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .stocks:
            return .get
        }
    }
    
    var parameters: Parameters {
        switch self {
        case .stocks(let currency, let count):
            return ["vs_currency": currency, "per_page": count]
        }
    }
}
