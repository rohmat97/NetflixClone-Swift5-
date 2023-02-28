//
//  Upcoming.swift
//  Netflix Clone
//
//  Created by Rohmat Dasuki on 16/02/23.
//

import Foundation
struct UpcomingMovieResponse: Codable {
    let results:[UpcomingMovie]
}

struct UpcomingMovie: Codable {
    let id: Int
    let media_type: String?
    let original_name: String?
    let original_title: String?
    let poster_path: String?
    let overview: String?
    let vote_count: Int
    let release_date: String?
    let vote_average: Double
}
