//
//  LocalPushNotificationsSwiftUIView.swift
//  SwiftUIAd
//
//  Created by Yun Ni on 2024-07-24.
//

import SwiftUI
import UserNotifications
import CoreLocation

class NotificationManager {

    static let instance = NotificationManager() //singleton

    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success , error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else {
                print("SUCCESS")
            }
        }
    }

    func schduleNotification() {

        let content = UNMutableNotificationContent()
        content.title = "This is my first notification!"
        content.subtitle = "easy subtitle"
        content.sound = .default
        content.badge = 1

        // for trigger, we can choose, time, calander n location
        // time
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)

        // calander
//        var dateComponents = DateComponents()
//        // the day starts on Sunday, so its every Monday at 8:00 AM
//        dateComponents.hour = 8
//        dateComponents.minute = 0
//        dateComponents.day = 2

        // Location

        let coordinates = CLLocationCoordinate2D(
            latitude: 40.00,
            longitude: 50.00)

        let region = CLCircularRegion(
            center: coordinates,
            radius: 100,
            identifier: UUID().uuidString)

        let trigger = UNLocationNotificationTrigger(region: region, repeats: true)

        // repeat everyday
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        let request  = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger)

        UNUserNotificationCenter.current().add(request)
    }
}
struct LocalPushNotificationsSwiftUIView: View {

    var body: some View {
        VStack(spacing: 30) {
            Button("Request permisson") {
                NotificationManager.instance.requestAuthorization()
            }

            Button("schduleNotification") {
                NotificationManager.instance.schduleNotification()
            }
        }
        .onAppear {
            UNUserNotificationCenter.current().setBadgeCount(0)
        }
    }
}

#Preview {
    LocalPushNotificationsSwiftUIView()
}
