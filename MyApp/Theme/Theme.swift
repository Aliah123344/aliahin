//
//  Theme.swift
//  MyApp
//
//  Created by Aliah on 30/05/1448 AH.
//

import SwiftUI
 
extension Color {
    init(hex: UInt32, opacity: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255,
            opacity: opacity
        )
    }
 
    static let plantGreen = Color(hex: 0x338069)
    static let sheetBackground = Color(hex: 0x111111)
    static let fieldBackground = Color(hex: 0x262626)
    static let secondaryText = Color(hex: 0x999999)
    static let tagBackground = Color(hex: 0x1C1C1E)
    static let sunTag = Color(hex: 0xD9D67A)
    static let waterTag = Color(hex: 0xA9CBE8)
}
