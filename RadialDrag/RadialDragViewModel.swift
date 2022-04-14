//
//  RadialDragViewModel.swift
//  RadialDrag
//
//  Created by Chon Torres on 4/14/22.
//

import SwiftUI

extension RadialDragView {
	final class ViewModel: ObservableObject {
		let haptic = UINotificationFeedbackGenerator()

		init() { }

		func setPositions(newPosition: DragPosition, oldPosition: DragPosition) {
			haptic.notificationOccurred(.warning)
		}
	}
}
