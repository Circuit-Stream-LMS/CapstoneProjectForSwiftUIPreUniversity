//
//  SwiftDataHabitRepository.swift
//  HabitTrackerProj
//
//  Created by Marcelo Araujo on 08/01/25.
//

import SwiftData

final class SwiftDataHabitRepository: HabitRepository {
    private let modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func createHabit(_ habit: Habit) {
        modelContext.insert(habit)
        saveContext()
    }
    
    func updateHabit(_ habit: Habit) {
        saveContext()
    }
    
    func deleteHabit(_ habit: Habit) {
        modelContext.delete(habit)
        saveContext()
    }
    
    private func saveContext() {
        do {
            try modelContext.save()
        } catch {
            print("Error saving to the database: \(error)")
        }
    }
}
