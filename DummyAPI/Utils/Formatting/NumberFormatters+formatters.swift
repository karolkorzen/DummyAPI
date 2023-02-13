//
//  NumberFormatters+formatters.swift
//  DummyAPI
//
//  Created by Karol Korzeń on 13/02/2023.
//

import Foundation

public extension NumberFormatter {
    /// Hardcoded style formatter for a price values in dollars
    static let usdPriceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        let locale = Locale(identifier: "en-US")
        formatter.locale = locale
        formatter.numberStyle = .currency
        formatter.usesGroupingSeparator = true
        formatter.generatesDecimalNumbers = true
        formatter.minimumFractionDigits = 2
        formatter.currencySymbol = locale.currencySymbol
        
        return formatter
    }()
}

public extension NumberFormatter {
    func string(from value: Decimal) -> String {
        string(from: NSDecimalNumber(decimal: value)) ?? "-"
    }
}
