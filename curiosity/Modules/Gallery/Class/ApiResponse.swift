//
//  ApiResponse.swift
//  curiosity
//
//  Created by user156854 on 8/17/19.
//  Copyright © 2019 Денис Наумов. All rights reserved.
//

import UIKit

struct CuriosityPhoto: Decodable {
    let id: Int
    let remoteURL: URL
    let date: Date
    let camera: CuriosityCamera
    
    enum CodingKeys: String, CodingKey {
        case id
        case date = "earth_date"
        case remoteURL = "img_src"
        case camera
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        let dateString = try values.decode(String.self, forKey: .date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        date = dateFormatter.date(from: dateString)!

        remoteURL = try values.decode(URL.self, forKey: .remoteURL)
        camera = try values.decode(CuriosityCamera.self, forKey: .camera)
    }
 }

struct CuriosityCamera: Decodable {
    let id: Int
    let shortName: String
    let fullName: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case fullName = "full_name"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        shortName = try values.decode(String.self, forKey: .name)
        fullName = try values.decode(String.self, forKey: .fullName)
    }
}

struct ServerResponseData: Decodable {
    enum CodingKeys: String, CodingKey {
        case photos
    }
    let photos: [CuriosityPhoto]
}
