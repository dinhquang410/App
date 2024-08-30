//
//  Habit_SwiftDataVersionApp.swift
//  Habit-SwiftDataVersion
//
//  Created by Dinh Quang Nguyen on 30/8/24.
//

import SwiftData
import SwiftUI

@main
struct Habit_SwiftDataVersionApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Activity.self)
    }
}
