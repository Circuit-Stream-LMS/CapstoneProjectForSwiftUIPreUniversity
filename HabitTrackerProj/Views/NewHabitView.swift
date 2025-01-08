//
//  NewHabitView.swift
//  HabitTrackerProj
//
//  Created by Marcelo Araujo on 24/12/24.
//

import SwiftUI
import SwiftData

struct NewHabitView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @StateObject private var viewModel = NewHabitViewModel()

    // 0=Sun,1=Mon,2=Tue,3=Wed,4=Thu,5=Fri,6=Sat
    private let daySymbols = ["S", "M", "T", "W", "T", "F", "S"]
    
    var body: some View {
        Form {
            Section(header: Text("Pick a name")) {
                TextField("Name your habit", text: $viewModel.name)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
            }
            
            Section(header: Text("Start date")) {
                DatePicker("Start Date", selection: $viewModel.startDate, displayedComponents: .date)
                    .datePickerStyle(.compact)
                    .labelsHidden()
            }
            
            Section(header: Text("Notes or description")) {
                TextField("Write your notes", text: $viewModel.notes, axis: .vertical)
                    .lineLimit(3, reservesSpace: true)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
            }
            
            Section(header: Text("Frequency")) {
                Toggle("Daily", isOn: $viewModel.isDaily)
                Toggle("Weekly", isOn: $viewModel.isWeekly)
                
                if viewModel.isWeekly {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Select Days:")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        HStack {
                            ForEach(daySymbols.indices, id: \.self) { index in
                                let daySymbol = daySymbols[index]
                                Button {
                                    viewModel.toggleDaySelection(dayIndex: index)
                                } label: {
                                    Text(daySymbol)
                                        .fontWeight(viewModel.isDaySelected(dayIndex: index) ? .bold : .regular)
                                        .foregroundColor(viewModel.isDaySelected(dayIndex: index) ? .blue : .primary)
                                        .frame(width: 36, height: 36)
                                        .background(
                                            Circle()
                                                .fill(
                                                    viewModel.isDaySelected(dayIndex: index)
                                                    ? Color.blue.opacity(0.15)
                                                    : Color.clear
                                                )
                                        )
                                }
                                .buttonStyle(.plain)
                                .contentShape(Circle())
                            }
                        }
                    }
                }
            }
            
            Section {
                Button {
                    viewModel.saveHabit(context: modelContext)
                    dismiss()
                } label: {
                    Text("Complete")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(.green)
            }
        }
        .navigationTitle("New Habit")
        .navigationBarTitleDisplayMode(.inline)
        .scrollContentBackground(.hidden)
        .formStyle(.automatic)
    }
}

