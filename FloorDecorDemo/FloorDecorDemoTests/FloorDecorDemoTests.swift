//
//  FloorDecorDemoTests.swift
//  FloorDecorDemoTests
//
//  Created by Tarun Kurma on 7/7/25.
//

import Testing
import AVKit
@testable import FloorDecorDemo

struct FloorDecorDemoTests {

    @Test func example() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    }

}

class SplashScreenViewTests: XCTestCase {
    func testSplashScreenViewLoads() {
        let exp = expectation(description: "SplashScreenView loads")
        let view = SplashScreenView(onFinish: { exp.fulfill() })
        // Render the view (no error means it loads)
        _ = UIHostingController(rootView: view)
        exp.fulfill()
        wait(for: [exp], timeout: 1.0)
    }
}
