//
//  Video.swift
//  YoutubeAPI
//
//  Created by Đạt on 23/07/2020.
//  Copyright © 2020 Đạt. All rights reserved.
//

import Foundation
struct Video : Decodable{
    var videoId=""
    var title=""
    var description=""
    var thumbnail=""
    var published=""
    enum CodingKeys : String, CodingKey {
        
        case snippet
        case thumbnails
        case high
        case resourceId
        case published = "publishedAt"
        case title
        case description
        case thumbnail = "url"
        case videoId
    }
    init(from decoder : Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self);
        let snippetContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .snippet);
        
        self.title = try snippetContainer.decode(String.self, forKey: .title);
        
        self.description = try snippetContainer.decode(String.self, forKey: .description);
        
        self.published = try snippetContainer.decode(String.self, forKey: .published);
        
        let thumnailContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .thumbnails);
        
        let highContainer = try thumnailContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .high);
        
        self.thumbnail = try highContainer.decode(String.self, forKey: .thumbnail);
        
        let resourceIdContainer = try snippetContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .resourceId);
        
        self.videoId = try resourceIdContainer.decode(String.self, forKey: .videoId);
        
    }
}
struct ApiResponses : Codable {
    let items :[Item]?
}
struct Item : Codable {
    let kind : String
    let etag : String
    let id : Id
    let snippet :Snippet
}
struct Id : Codable {
    let kind : String
    let videoId : String
}
struct Snippet : Codable {
    let publishedAt : String
    let title : String
    let description : String
    let thumbnails : Thumbnail
    let channelTitle : String
}
struct Thumbnail : Codable{
    let high : High
}
struct High : Codable {
    let url : String
}
