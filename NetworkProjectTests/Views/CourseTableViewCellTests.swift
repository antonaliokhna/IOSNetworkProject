//
//  CourseTableViewCellTests.swift
//  NetworkProjectTests
//
//  Created by Anton Aliokhna on 9/11/22.
//

import XCTest
@testable import NetworkProject

class CourseTableViewCellTests: XCTestCase {

    var sut: CourseTableViewCell!

    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc =
        storyboard.instantiateViewController(
            identifier: String(describing: CourseViewController.self)) as! CourseViewController

        vc.loadViewIfNeeded()
        let tableView = vc.tableView

        sut = tableView?.dequeueReusableCell(withIdentifier: "cell") as? CourseTableViewCell
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testInitCourseTableViewCellTestsWhenLoadController() {
        XCTAssertNotNil(sut)
    }

    func testCorrectSetCourseTableViewCellParametersWhenSetViewModel() {
        let viewModel = CourseViewModel(
            course: Course(id: 1,
                           name: "1",
                           link: URL(string: "https://swiftbook.ru/contents/our-first-applications/")!,
                           imageUrl: URL(string: "https://swiftbook.ru/wp-content/uploads/2018/03/2-courselogo.jpg")!,
                           numberOfLessons: 1,
                           numberOfTests: 1)
        )

        sut.viewModel = viewModel

        XCTAssert(sut.nameLabel.text == viewModel.name )
        XCTAssert(sut.countOfCoursesLabel.text == "Count of lessons: \(viewModel.countOfLessons)" )
        XCTAssert(sut.countOfTestsLabel.text == "Count of tests: \(viewModel.countOfTests)" )
    }

}
