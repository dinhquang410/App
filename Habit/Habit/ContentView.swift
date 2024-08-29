//
//  ContentView.swift
//  Habit
//
//  Created by Quang Nguyen on 2/6/24.
//

import SwiftUI

struct ActivityItem: Identifiable, Codable, Equatable, Hashable {
    var id = UUID()
    let name: String
    let description: String
    var completionCount: Int
}

@Observable
class Activities {
    var items = [ActivityItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ActivityItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        items = []
    }
}

struct ContentView: View {
    @State private var activities = Activities()
    @State private var showingAddActivity = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(activities.items) { item in
                    NavigationLink(value: item) {
                        VStack {
                            Text(item.name)
                                .font(.headline)
                                .foregroundStyle(.brown)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text(item.description)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("Habitual")
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
            .navigationDestination(for: ActivityItem.self) { activity in
                ActivityView(activity: activity, activities: activities)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        activities.items.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
