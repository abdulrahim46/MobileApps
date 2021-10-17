//
//  MobileAppsUITests.swift
//  MobileAppsUITests
//
//  Created by Abdul Rahim on 11/10/21.
//

import XCTest

class MobileAppsUITests: XCTestCase {
    
    
    // testing segment switch o tap
    func test_tab_bar_switch() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let segmentioCollectionViewCollectionView = XCUIApplication().collectionViews["segmentio_collection_view"]
        let favouriteStaticText = segmentioCollectionViewCollectionView/*@START_MENU_TOKEN@*/.staticTexts["Favourite"]/*[[".cells.staticTexts[\"Favourite\"]",".staticTexts[\"Favourite\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        favouriteStaticText.tap()
        
        let allStaticText = segmentioCollectionViewCollectionView/*@START_MENU_TOKEN@*/.staticTexts["All"]/*[[".cells.staticTexts[\"All\"]",".staticTexts[\"All\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        allStaticText.tap()
        favouriteStaticText.tap()
        allStaticText.tap()
        
    }
    
    // test for sort button and alert
    func test_sort_button_and_alert_popup() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let sortButton = app.navigationBars["MobileApps.View"].buttons["Sort"]
        sortButton.tap()
        
        let elementsQuery = app.alerts["Sort"].scrollViews.otherElements
        let cancelButton = elementsQuery.buttons["Cancel"]
        cancelButton.tap()
        sortButton.tap()
        elementsQuery.buttons["Price low to high"].tap()
        sortButton.tap()
        elementsQuery.buttons["Price high to low"].tap()
        sortButton.tap()
        elementsQuery.buttons["Rating"].tap()
        sortButton.tap()
        cancelButton.tap()
    }
    
    // mobiles tableview swipe screen test
    func test_mobile_list_screen() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Moto G4 Plus").element/*[[".cells.containing(.staticText, identifier:\"Rating: 4.7\").element",".cells.containing(.staticText, identifier:\"Price: 179.0\").element",".cells.containing(.staticText, identifier:\"The spec for the G4 Plus is much the same as it was on the Moto G4, but it also comes with a fingerprint scanner and an improved camera. The 16MP rear shooter is arguably one of the most impressive phone cameras at the sub-£200 mark. There's no NFC so you won't be able to use Android Pay on the Moto G4 Plus, but a bright display and strong performance is sure to make up for it.\").element",".cells.containing(.staticText, identifier:\"Moto G4 Plus\").element"],[[[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
        
    }
    
    // test for navigation to detail view
    func test_navigate_to_detail_screen() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let tablesQuery = app.tables
        tablesQuery.staticTexts["Nokia 6"].tap()
        app.navigationBars["Nokia 6"].buttons["Back"].tap()
        
        tablesQuery.staticTexts["Moto G5"].tap()
        app.navigationBars["Moto G5"].buttons["Back"].tap()
    }
    
    // test for favourite button tap
    func test_favourite_button_tap() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
    
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Moto E4 Plus")/*[[".cells.containing(.staticText, identifier:\"Rating: 4.9\")",".cells.containing(.staticText, identifier:\"Price: 179.99\")",".cells.containing(.staticText, identifier:\"First place in our list goes to the excellent Moto E4 Plus. It's a cheap phone that features phenomenal battery life, a fingerprint scanner and a premium feel design, plus it's a lot cheaper than the Moto G5 below. It is a little limited with its power, but it makes up for it by being able to last for a whole two days from a single charge. If price and battery are the most important features for you, the Moto E4 Plus will suit you perfectly.\")",".cells.containing(.staticText, identifier:\"Moto E4 Plus\")"],[[[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.buttons["favorite"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Moto G5")/*[[".cells.containing(.staticText, identifier:\"Rating: 3.8\")",".cells.containing(.staticText, identifier:\"Price: 165.0\")",".cells.containing(.staticText, identifier:\"Motorola's Moto G5, a former best cheap phone in the world, has slipped a few places thanks to better priced alternatives, plus the introduction of the new G5S. The Moto G5 comes with a metal design, 1080p display and fingerprint scanner. You won't get the fastest chipset on this list or NFC with the Moto G5, but as an all-round product the cheap Motorola phone will serve you well.\")",".cells.containing(.staticText, identifier:\"Moto G5\")"],[[[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.buttons["favorite"].tap()
        app.collectionViews["segmentio_collection_view"]/*@START_MENU_TOKEN@*/.staticTexts["Favourite"]/*[[".cells.staticTexts[\"Favourite\"]",".staticTexts[\"Favourite\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    }
    
    
}
