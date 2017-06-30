//
//  DashUITests.swift
//  Dash iOS
//

import XCTest
import VSMobileCenterExtensions

class DashUITests: XCTestCase {

    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAddDocset() {
        let app = XCUIApplication()
        
        XCTAssertEqual(app.tables.cells.count, 0)
        
        MCLabel.labelStep("No docsets")
        
        app.navigationBars["Docsets"].buttons["Settings"].tap()
        MCLabel.labelStep("Open settings to download docsets")
        app.tables.cells.staticTexts["Cheat Sheets"].tap()
        
        let searchField = app.tables.searchFields["Find cheat sheets to download"]
        searchField.tap()
        searchField.typeText("NS")
        
        let emptyListTable = app.tables["Empty list"]
        emptyListTable.cells.containing(.staticText, identifier: "NSDateFormatter").buttons["download button arrow"].tap()
        MCLabel.labelStep("Downloading docset")
        emptyListTable.buttons["Cancel"].tap()
        
        let backButton = app.navigationBars.buttons.element(boundBy: 0)
        backButton.tap()
        
        let doneButton = app.navigationBars["Settings"].buttons["Done"]
        doneButton.tap()
        
        sleep(2)
        
        XCTAssertEqual(app.tables.cells.count, 1)
        MCLabel.labelStep("Docset downloaded")
    }


    func testCategoriesCount() {
        let tablesQuery = XCUIApplication().tables
        tablesQuery.staticTexts["NSDateFormatter"].tap()
        tablesQuery.staticTexts["Categories"].tap()
        
        XCTAssertEqual(tablesQuery.cells.count, 9)
    }
    
    func testHideDocsets() {
        let app = XCUIApplication()
        let originalCount = app.tables.cells.count
        XCTAssertGreaterThanOrEqual(originalCount, 1)
        
        MCLabel.labelStep("All downloaded docsets")

        let navBar = app.navigationBars["Docsets"]
        navBar.buttons["Edit"].tap()
        MCLabel.labelStep("Edit docsets")
        app.tables.staticTexts["NSDateFormatter"].tap()
        MCLabel.labelStep("Toggle docsets")
        navBar.buttons["Done"].tap()

        let newCount = originalCount - 1
        XCTAssertEqual(app.tables.cells.count, newCount)
        MCLabel.labelStep("One docset hidden")
    }

    
}
