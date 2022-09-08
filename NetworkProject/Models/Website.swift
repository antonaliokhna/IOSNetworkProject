//
//  Website.swift
//  NetworkProject
//
//  Created by Anton Aliokhna on 9/8/22.
//

import Foundation

struct Website: Decodable {
    let courses: [Course]?
    let websiteName: String?
    let websiteDescription: String?
}

