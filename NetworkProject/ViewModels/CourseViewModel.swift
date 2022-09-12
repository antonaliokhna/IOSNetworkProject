//
//  CourseViewModel.swift
//  NetworkProject
//
//  Created by Anton Aliokhna on 9/8/22.
//

import Foundation
import UIKit

class CourseViewModel: CourseViewModelType {
    private var course: Course

    var name: String {
        course.name
    }

    var countOfLessons: String {
        course.numberOfLessons.description
    }

    var countOfTests: String {
        course.numberOfTests.description
    }

    var link: URL {
        course.link
    }

    var imageUrl: String {
        course.imageUrl.description
    }

    init(course: Course) {
        self.course = course
    }

    func fetchImage(completion: @escaping (UIImage?) -> ()) {
        NetworkSession.network.fetchImage(from: imageUrl) { image in
            completion(image)
        }
    }
}
