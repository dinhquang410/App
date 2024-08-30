//
//  ActivityView.swift
//  Habit-SwiftDataVersion
//
//  Created by Dinh Quang Nguyen on 30/8/24.
//

import SwiftUI

struct ActivityView: View {
    var activity: Activity
    @State var activities: [Activity]
    
    var body: some View {
        ScrollView {
            VStack {
                Text(activity.name)
                    .font(.title.bold())
                Spacer()
                Text("Activity count: \(activity.completionCount)")
                Spacer()
                Text(activity.descriptio)
                    .font(.caption)
            }
            .toolbar {
                Button("Increase completion count") {
                    incrementCompletion()
                }
            }
        }
    }
    
    func incrementCompletion() {
        let newActivity = activity
        newActivity.completionCount += 1
        if let index = activities.firstIndex(of: activity) {
            activities[index] = newActivity
        }
    }
}

#Preview {
    ActivityView(activity: Activity(name: "name", descriptio: "description", completionCount: 1), activities: [Activity]())
}
