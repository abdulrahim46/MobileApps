//
//  MobileAppsTests.swift
//  MobileAppsTests
//
//  Created by Abdul Rahim on 11/10/21.
//

import XCTest
@testable import MobileApps

class MobileAppsTests: XCTestCase {
    
    override class func tearDown() {
        
    }
    
    // test for mobile api logic
    func test_fetch_mobiles_from_api() {
        let mock = ApiMockResources()
        let fetcher = AllMobileViewModel(apiResource: mock)
        
        XCTAssertEqual(fetcher.mobiles.count, 0, "starting with no data...")
        let promise = expectation(description: "loading 5 news data count...")
        
        fetcher.getAllMobiles(completion: { mobile, error  in
            if let error = error {
                XCTFail()
                XCTAssertThrowsError(error)
            } else {
                if mobile?.count == 5 {
                    promise.fulfill()
                }
            }
        })
        wait(for: [promise], timeout: 2)
    }
    
    // Test for detail api logic
    func test_fetch_mobiles_details_from_api() {
        let mock = ApiMockResources()
        let fetcher = DetailViewModel(apiResource: mock)
        
        XCTAssertEqual(fetcher.details.count, 0, "starting with no data...")
        let promise = expectation(description: "loading 3 images data count...")
        
        fetcher.getAllImages(id: "1", completion:{ mobile, error  in
            if let error = error {
                XCTFail()
                XCTAssertThrowsError(error)
            } else {
                if mobile?.count == 3 {
                    promise.fulfill()
                }
            }
        })
        wait(for: [promise], timeout: 2)
    }
    
    // Test for firestore logic
    func test_fetch_favourite_mobiles_from_firestore() {
        let fetcher = FavouriteViewModel()
        
        XCTAssertEqual(fetcher.mobiles.count, 0, "starting with no data...")
        let promise = expectation(description: "loading data from firestore data count...")
        
        fetcher.getFavouriteMobile()
        if fetcher.mobiles.count == 0 {
            promise.fulfill()
        } else {
            XCTFail()
            XCTAssertThrowsError("error")
        }
        wait(for: [promise], timeout: 1)
    }
    
}
