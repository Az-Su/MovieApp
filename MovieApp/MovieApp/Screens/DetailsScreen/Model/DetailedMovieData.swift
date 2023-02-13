//
//  DetailedMovieData.swift
//  MovieApp
//
//  Created by Sailau Almaz Maratuly on 12.02.2023.
//

import Foundation

struct DetailedMovieData: Decodable {
    let poster_path: String
    let backdrop_path: String
    let title: String
    let tagline: String
    let overview: String
}
