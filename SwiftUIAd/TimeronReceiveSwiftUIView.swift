//
//  TimeronReceiveSwiftUIView.swift
//  SwiftUIAd
//
//  Created by Yun Ni on 2024-07-26.
//

import SwiftUI

struct TimeronReceiveSwiftUIView: View {

    //autoconnect() is as soon as load the screen, the publisher will be loaded
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()

    // 1. Current time
//    @State var currentDate: Date = Date()
//    var dateFormatter: DateFormatter {
//        let formatter = DateFormatter()
//        formatter.timeStyle = .medium
//        return formatter
//    }

    // 2. countdown
//
//    @State var count: Int = 20
//    @State var finishedText: String? = nil

    // 3. countdown to date
//    @State var timeRemiaining: String = ""
//    // add 1 day, if its not working, add todays date
//    let futureDate: Date = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
//
//    func updateTimeRemaining() {
//        let remaining = Calendar.current.dateComponents([.hour, .minute, .second], from: Date(), to: futureDate)
//        let hour = remaining.hour ?? 0
//        let minute = remaining.minute ?? 0
//        let second = remaining.second ?? 0
//        timeRemiaining = "\(hour):\(minute):\(second)"
//    }


    // 4. Animation counter
    @State var count: Int = 0

    var body: some View {
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: [Color.red, Color.blue]),
                center: .center,
                startRadius: 5,
                endRadius: 500)
            .ignoresSafeArea()


            //5. auto change the view

            TabView(selection: $count) {
                Rectangle()
                    .foregroundColor(.blue)
                    .tag(1)
                Rectangle()
                    .foregroundColor(.yellow)
                    .tag(2)
                Rectangle()
                    .foregroundColor(.orange)
                    .tag(3)
                Rectangle()
                    .foregroundColor(.red)
                    .tag(4)
                Rectangle()
                    .foregroundColor(.green)
                    .tag(5)
            }
            .tabViewStyle(PageTabViewStyle())
            .frame(height: 200)
//            HStack {
//                Circle()
//                    .offset(y: count == 1 ? -20 : 0)
//                Circle()
//                    .offset(y: count == 2 ? -20 : 0)
//                Circle()
//                    .offset(y: count == 3 ? -20 : 0)
//            }
//            .frame(width: 150)
//            .foregroundColor(.white)

            //            Text(timeRemiaining)
            //                .font(.system(size: 100, weight: .semibold, design: .rounded))
            //                .foregroundStyle(.white)
            //                .lineLimit(1)
            //                .minimumScaleFactor(0.1)
            //        }
            //        .onReceive(timer, perform: { value in
            //            currentDate = value
            //        })

            //        .onReceive(timer, perform: { _ in
            //            if count <= 1 {
            //                finishedText = "WoW!"
            //            } else {
            //                count -= 1
            //            }
            //        })
            //        .onReceive(timer, perform: { _ in
            //            updateTimeRemaining()
            //        })
        }
        .onReceive(timer, perform: { _ in
            withAnimation(.easeIn(duration: 0.5)) {
                count = count == 3 ? 0 : count + 1
            }
        })
    }
}

#Preview {
    TimeronReceiveSwiftUIView()
}
