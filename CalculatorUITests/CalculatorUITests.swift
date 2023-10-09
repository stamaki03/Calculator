//
//  CalculatorUITests.swift
//  CalculatorUITests
//
//  Created by Sho Tamaki on 2023/10/09.
//

import XCTest

final class CalculatorUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_Displayed_入力は9文字まで() throws {
        let app = XCUIApplication()
        let text = app.staticTexts["DisplayedNumber"]
        app.launch()
        app.buttons["1"].tap()
        app.buttons["2"].tap()
        app.buttons["3"].tap()
        app.buttons["4"].tap()
        app.buttons["5"].tap()
        app.buttons["6"].tap()
        app.buttons["7"].tap()
        app.buttons["8"].tap()
        app.buttons["9"].tap()
        app.buttons["0"].tap()
        XCTAssertEqual(text.label, "123456789")
    }
    
    func test_Displayed_1行目の各ボタンが機能する() throws {
        let app = XCUIApplication()
        let text = app.staticTexts["DisplayedNumber"]
        app.launch()
        app.buttons["1"].tap()
        app.buttons["2"].tap()
        app.buttons["3"].tap()
        app.buttons["4"].tap()
        app.buttons["5"].tap()
        XCTAssertEqual(text.label, "12345")
        app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .button).element(boundBy: 1).tap()
        XCTAssertEqual(text.label, "1234")
        app.buttons["+/-"].tap()
        XCTAssertEqual(text.label, "-1234")
        app.buttons["+/-"].tap()
        XCTAssertEqual(text.label, "1234")
        app.buttons["%"].tap()
        XCTAssertEqual(text.label, "12.34")
    }
    
    func test_Displayed_入力9文字まで() throws {
        let app = XCUIApplication()
        app.launch()
        app.buttons["6"].tap()
        app.buttons["9"].tap()
        app.buttons["."].tap()
        app.buttons["5"].tap()
        app.buttons["+"].tap()
        app.buttons["4"].tap()
        app.buttons["-"].tap()
        app.buttons["8"].tap()
        app.buttons["7"].tap()
        app.buttons["×"].tap()
        app.buttons["3"].tap()
        app.buttons["÷"].tap()
        app.buttons["1"].tap()
        app.buttons["2"].tap()
        app.buttons["="].tap()
        let text = app.staticTexts["DisplayedNumber"]
        XCTAssertEqual(text.label, "-3.375")
    }
        
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
