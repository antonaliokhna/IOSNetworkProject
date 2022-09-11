//
//  CourseTests.swift
//  NetworkProjectTests
//
//  Created by Anton Aliokhna on 9/11/22.
//

import XCTest
@testable import NetworkProject

class CourseTests: XCTestCase {
    func testInitCourseModelWhenUsingParameters() {
        let course = Course(id: 1,
                            name: "1",
                            link: URL(string: "https://swiftbook.ru/contents/our-first-applications/")!,
                            imageUrl: URL(string: "https://swiftbook.ru/wp-content/uploads/2018/03/2-courselogo.jpg")!,
                            numberOfLessons: 1,
                            numberOfTests: 1)

        XCTAssertNotNil(course)
    }
}
