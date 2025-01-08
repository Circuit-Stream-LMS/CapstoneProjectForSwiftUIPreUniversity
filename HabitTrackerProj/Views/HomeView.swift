//
//  HomeView.swift
//  HabitTrackerProj
//
//  Created by Marcelo Araujo on 24/12/24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    // MARK: - Environment
    @Environment(\.modelContext) private var modelContext

    // MARK: - Query
    @Query<Habit>(sort: [SortDescriptor(\.name, order: .forward)])
    private var habits: [Habit]
    
    // MARK: - ViewModel
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.blue.opacity(0.4),
                    Color.white
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                Text(viewModel.getFormattedCurrentDate())
                    .font(.largeTitle)
                    .bold()
                    .padding(.top, 40)
                    .padding(.horizontal)
                
                List {
                    Section {
                        ForEach(habits) { habit in
                            HabitRowView(habit: habit) {
                                viewModel.incrementHabit($0)
                            }
                        }
                    } header: {
                        Text("Your Habits")
                            .font(.title2)
                            .foregroundColor(.primary)
                    }
                }
                .scrollContentBackground(.hidden)
                .listStyle(.insetGrouped)
                
                Spacer()
                
                NavigationLink(destination: NewHabitView()) {
                    Text("New Habit")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(.blue)
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .onAppear {
            if viewModel.repository == nil {
                viewModel.repository = SwiftDataHabitRepository(modelContext: modelContext)
            }
        }
    }
}

// MARK: - HabitRowView

fileprivate struct HabitRowView: View {
    let habit: Habit
    let onIncrement: (Habit) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Button {
                    onIncrement(habit)
                } label: {
                    Text("+")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Color.blue)
                        .cornerRadius(6)
                }
                .buttonStyle(.plain)

                Text(habit.name)
                    .font(.headline)
                    .lineLimit(1)
                
                Spacer()
                
                Text("\(habit.completedCount)/\(habit.expectedCount)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Text("Frequency: \(habit.frequency.rawValue.capitalized)")
                .font(.footnote)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 6)
    }
}

#Preview{
    HomeView()
}
