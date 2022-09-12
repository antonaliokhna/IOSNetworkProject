//
//  CoursesViewModel.swift
//  NetworkProject
//
//  Created by Anton Aliokhna on 9/8/22.
//

import Foundation
import UIKit

class CoursesViewModel: CoursesViewModelType {

    var selectedCourse: Course?
    var delegate: RequestDelegateType?
    var networkType: NetworkManagerType!

    private var courses: [Course] = [] {
        didSet {
            DispatchQueue.main.async {
                self.delegate?.didUpdate()
            }
        }
    }

    func setSelectedItem(from indexPath: IndexPath) {
        selectedCourse = courses[indexPath.row]
    }

    func countCourse() -> Int {
        return courses.count
    }

    func fetchCourses(from stringUrl: String) {
        NetworkSession.network.fetchCourses(from: stringUrl) { [weak self] courses in
            self?.courses = courses
        }
    }

    func courseViewModel(from indexPath: IndexPath) -> CourseViewModelType? {
        let course = courses[indexPath.row]
        return CourseViewModel(course: course)
    }
}
