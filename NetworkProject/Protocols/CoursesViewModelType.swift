//
//  CoursesViewModelType.swift
//  NetworkProject
//
//  Created by Anton Aliokhna on 9/8/22.
//

import Foundation

protocol CoursesViewModelType {
    var selectedCourse: Course? { get }
    var delegate: RequestDelegateType? { get set }

    func countCourse() -> Int
    func fetchCourses(from stringUrl: String)
    func setSelectedItem(from indexPath: IndexPath)
    func courseViewModel(from indexPath: IndexPath) -> CourseViewModelType?
}

