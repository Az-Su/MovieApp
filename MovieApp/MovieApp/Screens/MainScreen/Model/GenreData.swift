//
//  GenreData.swift
//  MovieApp
//
//  Created by Sailau Almaz Maratuly on 12.02.2023.
//

import Foundation

struct GenreData: Decodable {
    let genres: [Genre]
    
    struct Genre: Decodable {
        let id: Int
        let name: String
    }
}
