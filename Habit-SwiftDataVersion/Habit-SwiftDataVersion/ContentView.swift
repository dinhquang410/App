//
//  ContentView.swift
//  Habit-SwiftDataVersion
//
//  Created by Dinh Quang Nguyen on 30/8/24.
//

import SwiftData
import SwiftUI

@Model
class Activity: Identifiable, Equatable, Hashable {
    var id = UUID()
    var name: String
    var descriptio: String
    var completionCount: Int
    
    init(id: UUID = UUID(), name: String, descriptio: String, completionCount: Int) {
        self.id = id
        self.name = name
        self.descriptio = descriptio
        self.completionCount = completionCount
    }
}



struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [
        SortDescriptor(\Activity.name)
    ]) var activities: [Activity]
    @State private var showingAddActivity = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(activities) { item in
                    NavigationLink(value: item) {
                        VStack {
                            Text(item.name)
                                .font(.headline)
                                .foregroundStyle(.indigo)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text(item.descriptio)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("Habitual II")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: . topBarTrailing) {
                    Button("Add Activity", systemImage: "plus") {
                        showingAddActivity = true
                    }
                }
            }
            .sheet(isPresented: $showingAddActivity) {
                AddView(activities: activities)
            }
            .navigationDestination(for: Activity.self) { activity in
                ActivityView(activity: activity, activities: activities)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        for offset in offsets {
            let activity = activities[offset]
            modelContext.delete(activity)
        }
    }
}

#Preview {
    ContentView()
}

