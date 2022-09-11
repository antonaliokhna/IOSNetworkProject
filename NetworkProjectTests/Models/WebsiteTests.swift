//
//  WebsiteTests.swift
//  NetworkProjectTests
//
//  Created by Anton Aliokhna on 9/11/22.
//

import XCTest
@testable import NetworkProject

class WebsiteTests: XCTestCase {

    func testInitWebsiteWitchoutUsingParameters() {
        let website = Website(courses: nil, websiteName: nil, websiteDescription: nil)
        XCTAssertNotNil(website)
    }

    func testInitWebsiteWithWebsiteNameParameter() {
        let website = Website(courses: nil, websiteName: "Foo", websiteDescription: nil)
        XCTAssertNotNil(website)
    }
}
