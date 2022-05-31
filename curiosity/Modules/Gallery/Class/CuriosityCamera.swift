//
//  CuriosityCamera.swift
//  curiosity
//
//  Created by Денис Наумов on 15.05.2022.
//  Copyright © 2022 Денис Наумов. All rights reserved.
//

import Foundation

struct CuriosityCamera: Decodable {
    let id: Int
    let shortName: String
    let fullName: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case shortName = "name"
        case fullName = "full_name"
    }
}
