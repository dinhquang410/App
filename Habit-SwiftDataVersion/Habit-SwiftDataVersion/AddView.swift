//
//  AddView.swift
//  Habit-SwiftDataVersion
//
//  Created by Dinh Quang Nguyen on 30/8/24.
//

import SwiftUI

struct AddView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var description = ""
    var activities: [Activity]
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                TextField("Description", text: $description)
            }
            .navigationTitle("Add New Activity")
            .toolbar {
                Button("Save") {
                    let item = Activity(name: name, descriptio: description, completionCount: 1)
                    modelContext.insert(item)
                    dismiss()
                }
                .disabled(name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
        }
    }
}

#Preview {
    AddView(activities: [Activity]())
}

