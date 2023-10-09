//
//  CalculatorTests.swift
//  CalculatorTests
//
//  Created by Sho Tamaki on 2023/10/09.
//

import XCTest
@testable import Calculator

final class CalculatorTests: XCTestCase {
    
    let contentViewModel = ContentViewModel()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // MARK: - handleButton関数のテスト
    func test_clearAll_全てのプロパティの値がクリアされる() throws {
        contentViewModel.displayedNumber = "123"
        contentViewModel.bufferedNumber = 4
        contentViewModel.checkedOperator = "+"
        contentViewModel.bufferedOperator = "-"
        contentViewModel.clearAll()
        XCTAssertEqual(contentViewModel.displayedNumber, "0")
        XCTAssertEqual(contentViewModel.bufferedNumber, nil)
        XCTAssertEqual(contentViewModel.checkedOperator, nil)
        XCTAssertEqual(contentViewModel.bufferedOperator, nil)
    }
    
    func test_clearAll_偽の結果を仮定した場合に失敗する() throws {
        contentViewModel.displayedNumber = "123"
        contentViewModel.bufferedNumber = 4
        contentViewModel.checkedOperator = "+"
        contentViewModel.bufferedOperator = "-"
        contentViewModel.clearAll()
        XCTAssertNotEqual(contentViewModel.displayedNumber, "123")
        XCTAssertNotEqual(contentViewModel.bufferedNumber, 4)
        XCTAssertNotEqual(contentViewModel.checkedOperator, "+")
        XCTAssertNotEqual(contentViewModel.bufferedOperator, "-")
    }
    
    func test_deleteOneCharacter_ディスプレイの値が1文字削除される() throws {
        contentViewModel.displayedNumber = "123"
        contentViewModel.displayedNumber = contentViewModel.deleteOneCharacter(dn: contentViewModel.displayedNumber)
        XCTAssertEqual(contentViewModel.displayedNumber, "12")
    }
    
    func test_deleteOneCharacter_ディスプレイの値が1文字だった場合に0になる() throws {
        contentViewModel.displayedNumber = "3"
        contentViewModel.displayedNumber = contentViewModel.deleteOneCharacter(dn: contentViewModel.displayedNumber)
        XCTAssertEqual(contentViewModel.displayedNumber, "0")
    }
    
    func test_deleteOneCharacter_ディスプレイの値が0だった場合に変化しない() throws {
        contentViewModel.displayedNumber = "0"
        contentViewModel.displayedNumber = contentViewModel.deleteOneCharacter(dn: contentViewModel.displayedNumber)
        XCTAssertEqual(contentViewModel.displayedNumber, "0")
    }
    
    func test_deleteOneCharacter_偽の結果を仮定した場合に失敗する() throws {
        contentViewModel.displayedNumber = "123"
        contentViewModel.displayedNumber = contentViewModel.deleteOneCharacter(dn: contentViewModel.displayedNumber)
        XCTAssertNotEqual(contentViewModel.displayedNumber, "123")
    }
    
    func test_togglePlusMinus_ディスプレイの値が正だった場合に負になる() throws {
        contentViewModel.displayedNumber = "123"
        guard let dn = contentViewModel.togglePlusMinus(dn: contentViewModel.displayedNumber) else { return }
        contentViewModel.displayedNumber = dn
        XCTAssertEqual(contentViewModel.displayedNumber, "-123")
    }
    
    func test_togglePlusMinus_ディスプレイの値が負だった場合に正になる() throws {
        contentViewModel.displayedNumber = "-123"
        guard let dn = contentViewModel.togglePlusMinus(dn: contentViewModel.displayedNumber) else { return }
        contentViewModel.displayedNumber = dn
        XCTAssertEqual(contentViewModel.displayedNumber, "123")
    }
    
    func test_togglePlusMinus_ディスプレイの値が0だった場合に変化しない() throws {
        contentViewModel.displayedNumber = "0"
        guard let dn = contentViewModel.togglePlusMinus(dn: contentViewModel.displayedNumber) else { return }
        contentViewModel.displayedNumber = dn
        XCTAssertEqual(contentViewModel.displayedNumber, "0")
    }
    
    func test_togglePlusMinus_ディスプレイの値が0小数点のみだった場合に変化しない() throws {
        contentViewModel.displayedNumber = "0."
        guard let dn = contentViewModel.togglePlusMinus(dn: contentViewModel.displayedNumber) else { return }
        contentViewModel.displayedNumber = dn
        XCTAssertEqual(contentViewModel.displayedNumber, "0.")
    }
    
    func test_togglePlusMinus_偽の結果を仮定した場合に失敗する() throws {
        contentViewModel.displayedNumber = "123"
        guard let dn = contentViewModel.togglePlusMinus(dn: contentViewModel.displayedNumber) else { return }
        contentViewModel.displayedNumber = dn
        XCTAssertNotEqual(contentViewModel.displayedNumber, "123")
    }
    
    func test_multiplyPointZeroOne_ディスプレイの値に100分の1をかけた値になる() throws {
        contentViewModel.displayedNumber = "123"
        guard let returnedValue = contentViewModel.multiplyPointZeroOne(dn: contentViewModel.displayedNumber) else { return }
        let returnedValue2 = contentViewModel.roundDownPointZero(value: returnedValue)
        let returnedValue3 = contentViewModel.roundDownLongDecimals(dn: returnedValue2)
        contentViewModel.displayedNumber = contentViewModel.displayError(dn: returnedValue3)
        XCTAssertEqual(contentViewModel.displayedNumber, "1.23")
    }
    
    func test_multiplyPointZeroOne_ディスプレイの値が0だった場合に変化しない() throws {
        contentViewModel.displayedNumber = "0"
        guard let returnedValue = contentViewModel.multiplyPointZeroOne(dn: contentViewModel.displayedNumber) else { return }
        let returnedValue2 = contentViewModel.roundDownPointZero(value: returnedValue)
        let returnedValue3 = contentViewModel.roundDownLongDecimals(dn: returnedValue2)
        contentViewModel.displayedNumber = contentViewModel.displayError(dn: returnedValue3)
        XCTAssertEqual(contentViewModel.displayedNumber, "0")
    }
    
    func test_multiplyPointZeroOne_ディスプレイの値が0小数点のみだった場合に変化しない() throws {
        contentViewModel.displayedNumber = "0."
        guard let returnedValue = contentViewModel.multiplyPointZeroOne(dn: contentViewModel.displayedNumber) else { return }
        let returnedValue2 = contentViewModel.roundDownPointZero(value: returnedValue)
        let returnedValue3 = contentViewModel.roundDownLongDecimals(dn: returnedValue2)
        contentViewModel.displayedNumber = contentViewModel.displayError(dn: returnedValue3)
        XCTAssertEqual(contentViewModel.displayedNumber, "0.")
    }
    
    func test_multiplyPointZeroOne_偽の結果を仮定した場合に失敗する() throws {
        contentViewModel.displayedNumber = "123"
        guard let returnedValue = contentViewModel.multiplyPointZeroOne(dn: contentViewModel.displayedNumber) else { return }
        let returnedValue2 = contentViewModel.roundDownPointZero(value: returnedValue)
        let returnedValue3 = contentViewModel.roundDownLongDecimals(dn: returnedValue2)
        contentViewModel.displayedNumber = contentViewModel.displayError(dn: returnedValue3)
        XCTAssertNotEqual(contentViewModel.displayedNumber, "123")
    }
        
    func test_addDot_ディスプレイの値に小数点を加えた値になる() throws {
        contentViewModel.displayedNumber = "1"
        guard let dn = contentViewModel.addDot(dn: contentViewModel.displayedNumber) else { return }
        contentViewModel.displayedNumber = dn
        XCTAssertEqual(contentViewModel.displayedNumber, "1.")
    }
    
    func test_addDot_ディスプレイの値に小数点が入っている場合値が変わらない() throws {
        contentViewModel.displayedNumber = "1."
        guard let dn = contentViewModel.addDot(dn: contentViewModel.displayedNumber) else { return }
        contentViewModel.displayedNumber = dn
        XCTAssertEqual(contentViewModel.displayedNumber, "1.")
    }
    
    func test_addDot_偽の結果を仮定した場合に失敗する() throws {
        contentViewModel.displayedNumber = "1"
        guard let dn = contentViewModel.addDot(dn: contentViewModel.displayedNumber) else { return }
        contentViewModel.displayedNumber = dn
        XCTAssertNotEqual(contentViewModel.displayedNumber, "1")
    }
    
    func test_addNumber_ディスプレイの値が0だった場合に選択した数字が表示される() throws {
        contentViewModel.displayedNumber = "0"
        let item = "3"
        guard let dn = contentViewModel.addNumber(item: item, dn: contentViewModel.displayedNumber) else { return }
        contentViewModel.displayedNumber = dn
        XCTAssertEqual(contentViewModel.displayedNumber, "3")
    }
    
    func test_addNumber_ディスプレイの値が0以外だった場合に選択した数字が追加される() throws {
        contentViewModel.displayedNumber = "1"
        let item = "3"
        guard let dn = contentViewModel.addNumber(item: item, dn: contentViewModel.displayedNumber) else { return }
        contentViewModel.displayedNumber = dn
        XCTAssertEqual(contentViewModel.displayedNumber, "13")
    }
    
    func test_addNumber_偽の結果を仮定した場合に失敗する() throws {
        contentViewModel.displayedNumber = "1"
        let item = "3"
        guard let dn = contentViewModel.addNumber(item: item, dn: contentViewModel.displayedNumber) else { return }
        contentViewModel.displayedNumber = dn
        XCTAssertNotEqual(contentViewModel.displayedNumber, "1")
    }
    
    func test_selectOperator_選択されている演算子と異なる演算子を選択した場合に演算子が更新される() throws {
        contentViewModel.checkedOperator = "-"
        let item = "+"
        contentViewModel.checkedOperator = contentViewModel.selectOperator(item: item, dn: contentViewModel.displayedNumber, co: contentViewModel.checkedOperator)
        XCTAssertEqual(contentViewModel.checkedOperator, "+")
    }
    
    func test_selectOperator_選択されている演算子と同じ演算子を選択した場合に演算子が解除される() throws {
        contentViewModel.checkedOperator = "-"
        let item = "-"
        contentViewModel.checkedOperator = contentViewModel.selectOperator(item: item, dn: contentViewModel.displayedNumber, co: contentViewModel.checkedOperator)
        XCTAssertEqual(contentViewModel.checkedOperator, nil)
    }
    
    func test_selectOperator_偽の結果を仮定した場合に失敗する() throws {
        contentViewModel.checkedOperator = "-"
        contentViewModel.displayedNumber = "1"
        let item = "+"
        contentViewModel.checkedOperator = contentViewModel.selectOperator(item: item, dn: contentViewModel.displayedNumber, co: contentViewModel.checkedOperator)
        XCTAssertNotEqual(contentViewModel.checkedOperator, "-")
    }
    
    func test_calculate_ディスプレイの値とバッファの値をバッファの演算子で計算する() throws {
        contentViewModel.displayedNumber = "1"
        contentViewModel.bufferedNumber = 4
        contentViewModel.bufferedOperator = "+"
        let calculateNumber = contentViewModel.convertStringToDouble(dn: contentViewModel.displayedNumber)
        let returnedValue = contentViewModel.calculate(bn: contentViewModel.bufferedNumber!, cn: calculateNumber, bf: contentViewModel.bufferedOperator)
        let returnedValue2 = contentViewModel.roundDownPointZero(value: returnedValue)
        let returnedValue3 = contentViewModel.roundDownLongDecimals(dn: returnedValue2)
        contentViewModel.displayedNumber = contentViewModel.displayError(dn: returnedValue3)
        contentViewModel.clearInfoAfterCalculation()
        XCTAssertEqual(contentViewModel.displayedNumber, "5")
    }
    
    func test_calculate_偽の結果を仮定した場合に失敗する() throws {
        contentViewModel.displayedNumber = "1"
        contentViewModel.bufferedNumber = 4
        contentViewModel.bufferedOperator = "+"
        let calculateNumber = contentViewModel.convertStringToDouble(dn: contentViewModel.displayedNumber)
        let returnedValue = contentViewModel.calculate(bn: contentViewModel.bufferedNumber!, cn: calculateNumber, bf: contentViewModel.bufferedOperator)
        let returnedValue2 = contentViewModel.roundDownPointZero(value: returnedValue)
        let returnedValue3 = contentViewModel.roundDownLongDecimals(dn: returnedValue2)
        contentViewModel.displayedNumber = contentViewModel.displayError(dn: returnedValue3)
        contentViewModel.clearInfoAfterCalculation()
        XCTAssertNotEqual(contentViewModel.displayedNumber, "1")
    }
    
    // MARK: - calculate関数の詳細テスト
    func test_calculate_足し算() throws {
        let calculateNumber: Double = 1
        contentViewModel.bufferedNumber = 4
        contentViewModel.bufferedOperator = "+"
        let returnedValue = contentViewModel.calculate(bn: contentViewModel.bufferedNumber!, cn: calculateNumber, bf: contentViewModel.bufferedOperator)
        let returnedValue2 = contentViewModel.roundDownLongDecimals(dn: returnedValue)
        let returnedValue3 = contentViewModel.roundDownPointZero(value: returnedValue2)
        XCTAssertEqual(returnedValue3, "5")
    }
    
    func test_calculate_引き算() throws {
        let calculateNumber: Double = 4
        contentViewModel.bufferedNumber = 1
        contentViewModel.bufferedOperator = "-"
        let returnedValue = contentViewModel.calculate(bn: contentViewModel.bufferedNumber!, cn: calculateNumber, bf: contentViewModel.bufferedOperator)
        let returnedValue2 = contentViewModel.roundDownPointZero(value: returnedValue)
        let returnedValue3 = contentViewModel.roundDownLongDecimals(dn: returnedValue2)
        contentViewModel.displayedNumber = contentViewModel.displayError(dn: returnedValue3)
        XCTAssertEqual(contentViewModel.displayedNumber, "-3")
    }
    
    func test_calculate_掛け算() throws {
        let calculateNumber: Double = 1_000_000_000_000
        contentViewModel.bufferedNumber = 10
        contentViewModel.bufferedOperator = "×"
        let returnedValue = contentViewModel.calculate(bn: contentViewModel.bufferedNumber!, cn: calculateNumber, bf: contentViewModel.bufferedOperator)
        let returnedValue2 = contentViewModel.roundDownPointZero(value: returnedValue)
        let returnedValue3 = contentViewModel.roundDownLongDecimals(dn: returnedValue2)
        contentViewModel.displayedNumber = contentViewModel.displayError(dn: returnedValue3)
        XCTAssertEqual(contentViewModel.displayedNumber, "10000000000000")
    }
    
    func test_calculate_掛け算_結果が15桁以上でエラー出力() throws {
        let calculateNumber: Double = 10_000_000_000_000
        contentViewModel.bufferedNumber = 10
        contentViewModel.bufferedOperator = "×"
        let returnedValue = contentViewModel.calculate(bn: contentViewModel.bufferedNumber!, cn: calculateNumber, bf: contentViewModel.bufferedOperator)
        let returnedValue2 = contentViewModel.roundDownPointZero(value: returnedValue)
        let returnedValue3 = contentViewModel.roundDownLongDecimals(dn: returnedValue2)
        contentViewModel.displayedNumber = contentViewModel.displayError(dn: returnedValue3)
        XCTAssertEqual(contentViewModel.displayedNumber, "エラー")
    }
    
    func test_calculate_割り算() throws {
        let calculateNumber: Double = 10
        contentViewModel.bufferedNumber = 0.001
        contentViewModel.bufferedOperator = "÷"
        let returnedValue = contentViewModel.calculate(bn: contentViewModel.bufferedNumber!, cn: calculateNumber, bf: contentViewModel.bufferedOperator)
        let returnedValue2 = contentViewModel.roundDownPointZero(value: returnedValue)
        let returnedValue3 = contentViewModel.roundDownLongDecimals(dn: returnedValue2)
        contentViewModel.displayedNumber = contentViewModel.displayError(dn: returnedValue3)
        XCTAssertEqual(contentViewModel.displayedNumber, "0.0001")
    }
    
    func test_calculate_割り算_e出力でエラー出力() throws {
        let calculateNumber: Double = 10
        contentViewModel.bufferedNumber = 0.0001
        contentViewModel.bufferedOperator = "÷"
        let returnedValue = contentViewModel.calculate(bn: contentViewModel.bufferedNumber!, cn: calculateNumber, bf: contentViewModel.bufferedOperator)
        let returnedValue2 = contentViewModel.roundDownPointZero(value: returnedValue)
        let returnedValue3 = contentViewModel.roundDownLongDecimals(dn: returnedValue2)
        contentViewModel.displayedNumber = contentViewModel.displayError(dn: returnedValue3)
        XCTAssertEqual(contentViewModel.displayedNumber, "エラー")
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
