//
//  HomeCollectionViewControllerTests.swift
//  NetworkProjectTests
//
//  Created by Anton Aliokhna on 9/11/22.
//

import XCTest
@testable import NetworkProject

class HomeCollectionViewControllerTests: XCTestCase {

    var sut: HomeCollectionViewController!

    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc =
            storyboard.instantiateViewController(
            identifier: String(describing: HomeCollectionViewController.self))
        sut = vc as? HomeCollectionViewController
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
       sut = nil
    }

    func testCorrectLoadHomeCollectionViewController() {
        XCTAssertNotNil(sut)
    }

    func testCorrectSetTableViewDelegateAndTableViewDataSourseWhenLoadController() {
        XCTAssertNotNil(sut.collectionView.delegate)
        XCTAssertNotNil(sut.collectionView.dataSource)
    }

    func testNumberOfRowsInZeroSectionInCollectionViewEqualEnumCountCasesWhenLoadController() {
        let enumCountCases = ButtonAction.allCases.count
        XCTAssert(sut.collectionView.numberOfItems(inSection: 0) == enumCountCases)
    }

    func testCellForZeroIndexPathReturnHomeColletionViewCell() {
        let cell = sut.collectionView(sut.collectionView, cellForItemAt: IndexPath(row: 0, section: 0))
        let homeViewCell = cell as? HomeCollectionViewCell

        XCTAssertNotNil(homeViewCell)
    }

    func testNavBarItemsHomeCollectionViewControllerContainsSettingsButtonWhenLoadController() {
        let rightBarItem = sut.navigationItem.rightBarButtonItems?.first{ $0.title == "Settings" }
        XCTAssertNotNil(rightBarItem)
    }
}
