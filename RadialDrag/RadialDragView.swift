//
//  RadialDragView.swift
//  RadialDrag
//
//  Created by Chon Torres on 4/14/22.
//

import SwiftUI

struct RadialDragView: View {
	@State var selectedPosition: DragPosition = .none {
		didSet {
			if selectedPosition != oldValue && selectedPosition != .none {
				haptic.notificationOccurred(.warning)
			}
		}
	}

	let haptic = UINotificationFeedbackGenerator()

	var body: some View {
		ZStack {
			Color.black.ignoresSafeArea()

			VStack {
				Spacer()

				displaySelection
					.greenGlow(width: 400, height: 100)

				Spacer()

				ZStack {
					AngularGradient(gradient: Gradient(colors: [.radarLight, .black, .radarDark]), center: .center)
						.blur(radius: 20)
						.opacity(0.3)
						.mask(Circle().frame(width: 300, height: 300))

					radarGrid
					radarCircles
					radarNumbers
					radarLines
					radarActiveRegion
				}
				.greenGlow(width: 325, height: 325)
				.opacity(0.8)

				Spacer()

				Text("Drag from the center to see the selected positions.")
					.font(.body)
					.foregroundColor(.white)

				Spacer()
			}
		}
	}

	var displaySelection: some View {
		VStack {
			Text("Selected Position")
				.font(.largeTitle)
				.foregroundColor(.white)
			Text("\(selectedPosition.descriptiveName)")
				.font(.title)
				.foregroundColor(.white)
		}
	}

	var radarGrid: some View {
		Group {
			ForEach(0..<12) { index in
				Line()
					.stroke(.white, style: StrokeStyle(lineWidth: 1, dash: [4]))
					.frame(width: 300)
					.offset(y: CGFloat(-150 + 25*index))
			}
			ForEach(0..<12) { index in
				Line()
					.stroke(.white, style: StrokeStyle(lineWidth: 1, dash: [4]))
					.frame(width: 300)
					.offset(y: CGFloat(-150 + 25*index))
			}
			.rotationEffect(.degrees(90))
		}
		.opacity(0.4)
		.mask(Circle().frame(width: 300, height: 300))
	}

	var radarCircles:  some View {
		Group {
			Circle()
				.fill(Color.radarLight)
				.frame(width: 50)
				.gesture(drag)
				.opacity(0.1)
			Circle()
				.stroke(.white, lineWidth: 2)
				.frame(width: 30)
			Circle()
				.stroke(.white, lineWidth: 2)
				.frame(width: 125)
			Circle()
				.stroke(.white, lineWidth: 2)
				.frame(width: 225)
			Circle()
				.stroke(.white, lineWidth: 2)
				.frame(width: 300)
			Circle()
				.stroke(.white, style: StrokeStyle(lineWidth: 7, dash: [1, 4]))
				.frame(width: 310)
		}
	}

	var radarNumbers: some View {
		ForEach(0..<8) { index in
			let theta = index * 45
			Text("\(theta)")
				.font(.caption)
				.foregroundColor(Color.radarLight)
				.offset(y: -170)
				.rotationEffect(.degrees(Double(theta)))
		}
	}

	var radarLines: some View {
		ForEach(0..<4) { index in
			Line()
				.stroke(.white, lineWidth: 1)
				.frame(width: 300)
				.rotationEffect(.degrees((Double(index*45))))
		}
	}

	var radarActiveRegion: some View {
		EighthOfACircle()
			.fill(Color.radarLight)
			.frame(width: 300, height: 300)
			.blur(radius: 3)
			.opacity(selectedPosition == .none ? 0.0 : 0.5)
			.rotationEffect(selectedPosition.rotationAngle)
	}

	var drag: some Gesture {
		DragGesture(minimumDistance: 50.0, coordinateSpace: .local)
			.onChanged { value in
				selectedPosition = DragPosition(value.translation)
			}
			.onEnded { _ in
				selectedPosition = .none
			}
	}
}

struct EighthOfACircle: Shape {
	func path(in rect: CGRect) -> Path {
		var path = Path()
		let center = CGPoint(x: rect.midX, y: rect.midY)
		path.move(to: center)
		path.addRelativeArc(center: center, radius: rect.midY, startAngle: .degrees(-112.5), delta: .degrees(45))
		return path
	}
}

struct Line: Shape {
	func path(in rect: CGRect) -> Path {
		var path = Path()
		path.move(to: CGPoint(x: rect.minX, y: rect.midY))
		path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
		return path
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		RadialDragView()
	}
}
