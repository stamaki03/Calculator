//
//  ContentViewModel.swift
//  Calculator
//
//  Created by Sho Tamaki on 2023/10/09.
//

import Foundation

final class ContentViewModel: ObservableObject {
    @Published var displayedNumber = "0"
    @Published var bufferedNumber: Double? = nil
    @Published var checkedOperator: String? = nil
    @Published var bufferedOperator: String? = nil
    
    func handleButton(item: String) {
        if displayedNumber == "エラー" { displayedNumber = "0" }
        switch item {
        case "AC" :
            clearAll()
        case "delete.backward.fill" :
            displayedNumber = deleteOneCharacter(dn: displayedNumber)
        case "+/-" :
            guard let dn = togglePlusMinus(dn: displayedNumber) else { return }
            displayedNumber = dn
        case "%" :
            guard let returnedValue = multiplyPointZeroOne(dn: displayedNumber) else { return }
            let returnedValue2 = roundDownPointZero(value: returnedValue)
            let returnedValue3 = roundDownLongDecimals(dn: returnedValue2)
            displayedNumber = displayError(dn: returnedValue3)
            clearInfoAfterCalculation()
        case "." :
            guard let dn = addDot(dn: displayedNumber) else { return }
            displayedNumber = dn
        case "1", "2", "3", "4", "5", "6", "7", "8", "9", "0":
            if bufferedNumber == nil && checkedOperator != nil {
                bufferedNumber = convertStringToDouble(dn: displayedNumber)
                displayedNumber = item
                bufferedOperator = checkedOperator
                checkedOperator = nil
            } else {
                guard let dn = addNumber(item: item, dn: displayedNumber) else { return }
                displayedNumber = dn
            }
        case "÷", "×", "-", "+", "=":
            if bufferedNumber == nil {
                checkedOperator = selectOperator(item: item, dn: displayedNumber, co: checkedOperator)
            } else {
                let calculateNumber = convertStringToDouble(dn: displayedNumber)
                let returnedValue = calculate(bn: bufferedNumber!, cn: calculateNumber, bf: bufferedOperator)
                let returnedValue2 = roundDownPointZero(value: returnedValue)
                let returnedValue3 = roundDownLongDecimals(dn: returnedValue2)
                displayedNumber = displayError(dn: returnedValue3)
                checkedOperator = item
                clearInfoAfterCalculation()
            }
        default:
            return
        }
    }
    
    // case AC
    func clearAll() {
        displayedNumber = "0"
        bufferedNumber = nil
        checkedOperator = nil
        bufferedOperator = nil
    }
    
    // case delete.backward.fill
    func deleteOneCharacter(dn: String) -> String {
        if dn.count == 1 {
            return "0"
        } else  {
            return String(dn.dropLast())
        }
    }
    
    // case +/-
    func togglePlusMinus(dn: String) -> String? {
        if dn == "0" || dn == "0." { return nil }
        if dn.first == "-" {
            return String(dn.dropFirst())
        } else {
            return ("-" + dn)
        }
    }
    
    // case %
    func multiplyPointZeroOne(dn: String) -> String? {
        if dn == "0" || dn == "0." { return nil }
        return String((Double(dn) ?? 0) * 0.01)
    }
    
    // case .
    func addDot(dn: String) -> String? {
        if displayedNumber.contains(".") { return nil }
        return (dn + ".")
    }
    
    // case number
    func addNumber(item: String, dn: String) -> String? {
        let wordCount = 9
        if dn.count >= wordCount { return nil }
        if dn == "0" {
            return item
        } else {
            return dn + item
        }
    }
    
    // case operator
    func selectOperator(item: String, dn: String, co: String?) -> String? {
        if co == item {
            return nil
        } else {
            return item
        }
    }
    
    func calculate(bn: Double, cn: Double, bf: String?) -> String {
        switch bf {
        case "+" :
            return String(bn + cn)
        case "-" :
            return String(bn - cn)
        case "×" :
            return String(bn * cn)
        case "÷" :
            return String(bn / cn)
        default :
            return ""
        }
    }
    
    // MARK: - Helper Actions
    func roundDownLongDecimals(dn: String) -> String {
        let wordCount = 9
        if dn.contains(".") && dn.count >= wordCount {
            return dn.prefix(wordCount + 2).description
        }
        return dn
    }
    
    func displayError(dn: String) -> String {
        let wordCount = 15
        if (dn.count >= wordCount) || (dn.contains("e")) { return "エラー" }
        return dn
    }
    
    func clearInfoAfterCalculation() {
        bufferedNumber = nil
        bufferedOperator = nil
    }
    
    func convertStringToDouble(dn: String) -> Double {
        return (Double(dn) ?? 0)
    }
    
    func roundDownPointZero(value: String) -> String {
        let pattern = "^.*\\.0*$"
        if let regex = try? NSRegularExpression(pattern: pattern) {
            let checkingResults = regex.matches(in: value, range: NSRange(location: 0, length: value.count))
            if checkingResults.count > 0 {
                if let index = value.firstIndex(of: ".")?.utf16Offset(in: value){
                    return String(value.prefix(index))
                }
            }
        }
        return value
    }
}
