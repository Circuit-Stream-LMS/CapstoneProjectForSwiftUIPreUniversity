//
//  HomeViewModel.swift
//  HabitTrackerProj
//
//  Created by Marcelo Araujo on 24/12/24.
//

import SwiftUI
import SwiftData

@MainActor
final class HomeViewModel: ObservableObject {
    var repository: HabitRepository?

    /// Function to increment the `completedCount`.
    func incrementHabit(_ habit: Habit) {
        guard let repository = repository else { return }
        
        if habit.completedCount < habit.expectedCount {
            habit.completedCount += 1
            repository.updateHabit(habit)
        }
    }
    
    func getFormattedCurrentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMMM d"
        return formatter.string(from: Date())
    }
}

