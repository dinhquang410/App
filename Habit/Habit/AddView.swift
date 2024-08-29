//
//  AddView.swift
//  Habit
//
//  Created by Quang Nguyen on 2/6/24.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var description = ""
    var activities: Activities
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                TextField("Description", text: $description)
            }
            .navigationTitle("Add New Activity")
            .toolbar {
                Button("Save") {
                    let item = ActivityItem(name: name, description: description, completionCount: 1)
                    activities.items.append(item)
                    dismiss()
                }
                .disabled(name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
        }
    }
}

#Preview {
    AddView(activities: Activities())
}
