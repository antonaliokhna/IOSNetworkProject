//
//  NetworkManagerType.swift
//  NetworkProject
//
//  Created by Anton Aliokhna on 9/8/22.
//

import Foundation
import UIKit

protocol NetworkManagerType {
    func getQuery(from stringUrl: String, completion: @escaping (Data?) -> () )
    func postQuery(from stringUrl: String, data: [String: String], completion: @escaping (Data?) -> ())
    func uploadImage(from stringUrl: String, image: UIImage, completion: @escaping (Data?) -> ())

    func fetchImage(from stringUrl: String, completion: @escaping (_ image: UIImage?) -> () )
    func fetchCourses(from stringUrl: String, completion: @escaping (_ courses: [Course]) -> ())
}
