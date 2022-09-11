//
//  HomeCollectionViewCellTests.swift
//  NetworkProjectTests
//
//  Created by Anton Aliokhna on 9/11/22.
//

import XCTest
@testable import NetworkProject

class HomeCollectionViewCellTests: XCTestCase {

    var sut: HomeCollectionViewCell!

    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc =
        storyboard.instantiateViewController(
            identifier: String(describing: HomeCollectionViewController.self)) as! HomeCollectionViewController
        let collectionView = vc.collectionView

        sut = collectionView?.dequeueReusableCell(
            withReuseIdentifier: "cell", for: IndexPath(row: 0, section: 0)) as? HomeCollectionViewCell
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testInitHomeCollectionViewCellWhenLoadController() {
        XCTAssertNotNil(sut)
    }
}
