//
//  ActivityView.swift
//  Habit
//
//  Created by Quang Nguyen on 2/6/24.
//

import SwiftUI

struct ActivityView: View {
    var activity: ActivityItem
    var activities: Activities
    
    var body: some View {
        ScrollView {
            VStack {
                Text(activity.name)
                    .font(.title.bold())
                Spacer()
                Text("Activity count: \(activity.completionCount)")
                Spacer()
                Text(activity.description)
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
        var newActivity = activity
        newActivity.completionCount += 1
        if let index = activities.items.firstIndex(of: activity) {
            activities.items[index] = newActivity
        }
    }
}

#Preview {
    ActivityView(activity: ActivityItem(name: "name", description: "description", completionCount: 1), activities: Activities())
}
