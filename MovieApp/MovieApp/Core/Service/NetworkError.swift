//
//  NetworkError.swift
//  MovieApp
//
//  Created by Sailau Almaz Maratuly on 12.02.2023.
//

import Foundation

enum NetworkError: String, Error {
    case missingURL
    case missingRequest
    case taskError
    case responseError
    case dataError
    case decodeError
}
