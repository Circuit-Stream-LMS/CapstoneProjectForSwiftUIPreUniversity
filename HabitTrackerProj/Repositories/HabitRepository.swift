//
//  HabitRepository.swift
//  HabitTrackerProj
//
//  Created by Marcelo Araujo on 08/01/25.
//

import SwiftData

/// Definition of a protocol for habit CRUD operations. 
protocol HabitRepository {
    func createHabit(_ habit: Habit)
    func updateHabit(_ habit: Habit)
    func deleteHabit(_ habit: Habit)
}
