//
//  DragPosition.swift
//  RadialDrag
//
//  Created by Chon Torres on 4/14/22.
//

import SwiftUI

enum DragPosition: Int, Identifiable {
	case top
	case topTrailing
	case trailing
	case bottomTrailing
	case bottom
	case bottomLeading
	case leading
	case topLeading
	case none

	var id: Int {
		self.rawValue
	}

	init (_ size: CGSize) {
		let hypotenuse = size.width*size.width + size.height*size.height

		// Enforce a minimum length of the drag vector so that it is easy to cancel
		// if this is used for a radial menu, by dragging to the center until this
		// guard condition is hit.
		guard hypotenuse > 2500 else {
			self = .none
			return
		}

		// Using CGSize for the vector as that is what the gesture outputs. It makes for
		// some slightly confused notation. The math is minimal.
		//
		// The cosine of the angle is the dot product of the normalized drag vector and
		// the y unit vector: (0, -1).
		let cosineTheta = -size.height / sqrt(hypotenuse)

		if cosineTheta > 0.924 {
			self = .top
		} else if cosineTheta < -0.924 {
			self = .bottom
		} else if size.width > 0.0 {
			if cosineTheta > 0.383 {
				self = .topTrailing
			} else if cosineTheta > -0.383 {
				self = .trailing
			} else {
				self = .bottomTrailing
			}
		} else {
			if cosineTheta > 0.383 {
				self = .topLeading
			} else if cosineTheta > -0.383 {
				self = .leading
			} else {
				self = .bottomLeading
			}
		}
	}

	var sweptAngle: Angle {
		Angle.degrees(360.0 / 8.0)
	}

	// The value to rotate the wedge indicating the actively selected area.
	var rotationAngle: Angle {
		switch self {
		case .none:
			return .zero
		default:
			return Angle.degrees(Double(self.rawValue) * sweptAngle.degrees)
		}
	}

	var descriptiveName: String {
		switch self {
		case .top:
			return ".top"
		case .topTrailing:
			return ".topTrailing"
		case .trailing:
			return ".trailing"
		case .bottomTrailing:
			return ".bottomTrailing"
		case .bottom:
			return ".bottom"
		case .bottomLeading:
			return ".bottomLeading"
		case .leading:
			return ".leading"
		case .topLeading:
			return ".topLeading"
		case .none:
			return ".none"
		}
	}
}
