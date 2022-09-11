//
//  Course.swift
//  NetworkProject
//
//  Created by Anton Aliokhna on 9/8/22.
//

import Foundation

struct Course: Decodable {
    let id: Int
    let name: String
    let link: URL
    let imageUrl: URL
    let numberOfLessons: Int
    let numberOfTests: Int
}
