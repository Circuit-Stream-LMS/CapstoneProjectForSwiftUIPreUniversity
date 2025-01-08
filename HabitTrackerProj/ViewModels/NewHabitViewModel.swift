//
//  NewHabitViewModel.swift
//  HabitTrackerProj
//
//  Created by Marcelo Araujo on 24/12/24.
//

import SwiftUI
import SwiftData

@MainActor
final class NewHabitViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var startDate: Date = Date()
    @Published var notes: String = ""
    
    @Published var isDaily: Bool = true {
        didSet {
            if isDaily {
                isWeekly = false
                frequency = .daily
            }
        }
    }
    
    @Published var isWeekly: Bool = false {
        didSet {
            if isWeekly {
                isDaily = false
                frequency = .weekly
            }
        }
    }
    
    @Published var frequency: Frequency = .daily
    @Published var selectedDays: [Int] = []
    
    func saveHabit(context: ModelContext) {
        let newHabit = Habit(
            name: name,
            startDate: startDate,
            notes: notes,
            frequency: frequency,
            selectedDays: selectedDays
        )
        context.insert(newHabit)
        
        do {
            try context.save()
        } catch {
            print("Erro ao salvar novo hábito: \(error)")
        }
    }
    
    func toggleDaySelection(dayIndex: Int) {
        guard isWeekly else { return }
        
        if selectedDays.contains(dayIndex) {
            // If already selected, remove it.
            selectedDays.removeAll(where: { $0 == dayIndex })
        } else {
            selectedDays = [dayIndex]
        }
    }
    
    func isDaySelected(dayIndex: Int) -> Bool {
        selectedDays.contains(dayIndex)
    }
}
