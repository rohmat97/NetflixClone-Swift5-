//
//  YoutubeSearchResults.swift
//  Netflix Clone
//
//  Created by Rohmat Dasuki on 28/02/23.
//

import Foundation



struct YoutubeSearchResponse: Codable {
    let items: [VideoElement]
}


struct VideoElement: Codable {
    let id: IdVideoElement
}


struct IdVideoElement: Codable {
    let kind: String
    let videoId: String
}
