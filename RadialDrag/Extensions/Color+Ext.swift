//
//  Color+Ext.swift
//  RadialDrag
//
//  Created by Chon Torres on 4/14/22.
//

import SwiftUI

extension Color {
	init(hex: UInt, alpha: Double = 1) {
		self.init(
			.sRGB,
			red: Double((hex >> 16) & 0xff) / 255,
			green: Double((hex >> 08) & 0xff) / 255,
			blue: Double((hex >> 00) & 0xff) / 255,
			opacity: alpha
		)
	}

	static var radarLight = Color(hex: 0xb9fab6)
	static var radarDark = Color(hex: 0x056707)
}
