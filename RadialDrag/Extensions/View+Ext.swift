//
//  View+Ext.swift
//  RadialDrag
//
//  Created by Chon Torres on 4/14/22.
//
//

import SwiftUI

extension View {
	func greenGlow(width: CGFloat = 500, height: CGFloat = 500) -> some View {
		ZStack {
			ForEach(0..<2) { index in
				Rectangle()
					.fill(Color.green)
					.frame(width: width, height: height)
					.mask(self.blur(radius: 10))
					.overlay(self.blur(radius: CGFloat(5 - index*5)))
			}
		}
	}
}
