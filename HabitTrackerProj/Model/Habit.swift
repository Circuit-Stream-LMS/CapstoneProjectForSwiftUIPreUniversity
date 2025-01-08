//
//  Habit.swift
//  HabitTrackerProj
//
//  Created by Marcelo Araujo on 24/12/24.
//

import Foundation
import SwiftData

/// enum to represent a habit's frequency
enum Frequency: String, Codable {
    case daily
    case weekly
}

@Model
final class Habit {
    var id: UUID
    var name: String
    var startDate: Date
    var notes: String

    var frequency: Frequency
    
    /// Selected days (only for weekly frequency)
    /// 0 = Sunday, 1 = Monday, etc
    var selectedDays: [Int]
    
    /// Tracking how many times the habit has been completed
    var completedCount: Int

    init(
        id: UUID = UUID(),
        name: String,
        startDate: Date,
        notes: String,
        frequency: Frequency,
        selectedDays: [Int] = [],
        completedCount: Int = 0
    ) {
        self.id = id
        self.name = name
        self.startDate = startDate
        self.notes = notes
        self.frequency = frequency
        self.selectedDays = selectedDays
        self.completedCount = completedCount
    }
    
    /// Calculate how many times the user SHOULD have done the habit up to now
    var expectedCount: Int {
        let today = Date()
        guard startDate <= today else {
            return 0
        }
        
        let calendar = Calendar.current
        let startOfStartDate = calendar.startOfDay(for: startDate)
        let startOfToday = calendar.startOfDay(for: today)
        
        switch frequency {
        case .daily:
            let dayCount = calendar.dateComponents([.day], from: startOfStartDate, to: startOfToday).day ?? 0
            return dayCount + 1
            
        case .weekly:
            var count = 0
            var current = startOfStartDate
            
            while current <= startOfToday {
                let weekday = calendar.component(.weekday, from: current)
                let indexForThisDay = (weekday - 1) % 7
                if selectedDays.contains(indexForThisDay) {
                    count += 1
                }
                guard let nextDay = calendar.date(byAdding: .day, value: 1, to: current) else {
                    break
                }
                current = nextDay
            }
            return count
        }
    }
}
