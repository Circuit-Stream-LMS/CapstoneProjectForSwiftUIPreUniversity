//
//  HabitTrackerProjApp.swift
//  HabitTrackerProj
//
//  Created by Marcelo Araujo on 24/12/24.
//

import SwiftUI
import SwiftData

@main
struct HabitTrackerProjApp: App {
    // Creation of ModelContainer that includes the `Habit` model
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Habit.self
        ])
        let configuration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [configuration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView()
            }
            .modelContainer(sharedModelContainer)
        }
    }
}
