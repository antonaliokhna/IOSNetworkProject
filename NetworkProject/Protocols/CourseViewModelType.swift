//
//  CourseViewModelType.swift
//  NetworkProject
//
//  Created by Anton Aliokhna on 9/8/22.
//

import Foundation
import UIKit

protocol CourseViewModelType: AnyObject {
    var name: String { get }
    var countOfLessons: String { get }
    var countOfTests: String { get }
    var link: URL { get }
    var imageUrl: String { get }

    func getImage(completion: @escaping (UIImage?) -> () )
}
