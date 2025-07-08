//
//  FloorDecorDemoUITests.swift
//  FloorDecorDemoUITests
//
//  Created by Tarun Kurma on 7/7/25.
//

import XCTest

final class FloorDecorDemoUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    @MainActor
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }

    @MainActor
    func testLogoTapPresentsSplashScreen() throws {
        let app = XCUIApplication()
        app.launch()
        
        // Find the logo by its accessibility identifier or label
        let logo = app.buttons["Logo"]
        XCTAssertTrue(logo.waitForExistence(timeout: 2), "Logo button should exist on Home screen")
        logo.tap()
        
        // Check for splash screen content (e.g., tagline or video)
        let tagline = app.staticTexts["Your dream home.\n Our unbelievable prices."]
        XCTAssertTrue(tagline.waitForExistence(timeout: 2), "Splash screen should appear after tapping logo")
    }
}
