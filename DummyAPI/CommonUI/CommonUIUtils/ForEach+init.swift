//
//  ForEach+init.swift
//  DummyAPI
//
//  Created by Karol Korzeń on 13/02/2023.
//

import SwiftUI

// source: https://www.swiftbysundell.com/tips/using-swiftui-foreach-with-raw-values/
public extension ForEach where Data.Element: Hashable, ID == Data.Element, Content: View {
    /// Allows Hashables to be used as an parameter of the ForEach
    init(values: Data, content: @escaping (Data.Element) -> Content) {
        self.init(values, id: \.self, content: content)
    }
}
