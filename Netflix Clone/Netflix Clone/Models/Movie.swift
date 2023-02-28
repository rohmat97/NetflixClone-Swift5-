//
//  Movie.swift
//  Netflix Clone
//
//  Created by Rohmat Dasuki on 16/02/23.
//

import Foundation

struct MovieResponse: Codable {
    let results:[Movie]
}

struct Movie: Codable {
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
/*
 {
     adult = 0;
     "backdrop_path" = "/nlUSVN7bUhPfQGvOMEM77TjlO3h.jpg";
     "genre_ids" =             (
         878,
         28,
         12
     );
     id = 298618;
     "media_type" = movie;
     "original_language" = en;
     "original_title" = "The Flash";
     overview = "When his attempt to save his family inadvertently alters the future, Barry Allen becomes trapped in a reality in which General Zod has returned and there are no Super Heroes to turn to. In order to save the world that he is in and return to the future that he knows, Barry's only hope is to race for his life. But will making the ultimate sacrifice be enough to reset the universe?";
     popularity = "213.434";
     "poster_path" = "/58quDLcapkNuptBmaZlgKBEeWRO.jpg";
     "release_date" = "2023-06-14";
     title = "The Flash";
     video = 0;
     "vote_average" = 0;
     "vote_count" = 0;
 }
 */
