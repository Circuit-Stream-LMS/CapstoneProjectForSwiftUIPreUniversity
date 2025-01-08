# Habit Tracker Project

This project is a **Habit Tracker** built with **SwiftUI** and **SwiftData**, serving as a Capstone Project for a pre-university SwiftUI course. Its goal is to help users create and maintain daily or weekly habits while tracking their progress over time.

---

## Contents

- [Overview](#overview)
- [Key Features](#key-features)
- [Architecture](#architecture)
- [Folder Structure](#folder-structure)
- [Requirements](#requirements)
- [How to Run](#how-to-run)
- [Basic Usage](#basic-usage)
- [Demo](#demo)

---

## Overview

**HabitTrackerProj** is an iOS 17+ application that allows users to create new habits and track their progress daily or weekly. Users can quickly see how many times they have completed each habit compared to how many times they **should** have completed it by now.

---

## Key Features

1. **Create Habits**  
   - Define the habit’s name, start date, notes, and frequency (daily or weekly).  
   - Select specific days of the week for weekly habits.

2. **Habit List**  
   - Display all habits in a list.  
   - Shows how many times you’ve completed a habit vs. the expected number of completions.

3. **Increment Habit Count**  
   - A **+** button to update how many times a habit has been completed.

4. **Local Data Persistence**  
   - Uses SwiftData to store habits on the device.  
   - Data remains intact after closing the app.

---

## Architecture

The project follows a simplified MVVM + Repository approach:

- **Models (`@Model`)**  
  - `Habit.swift` defines the habit entity (properties, frequency, expected completion count).

- **Repositories**  
  - `HabitRepository` (protocol) declares CRUD operations.  
  - `SwiftDataHabitRepository` implements these operations using SwiftData.

- **ViewModels**  
  - `HomeViewModel` manages logic for displaying and incrementing habits on the main screen.  
  - `NewHabitViewModel` manages creation and setup of new habits.

- **Views**  
  - `HomeView` shows the list of habits, enables incrementing habits, and navigates to `NewHabitView`.  
  - `NewHabitView` is a form that creates a new habit.

- **SwiftData**  
  - A `ModelContainer` is configured in the app file to persist data locally.

---

## Folder Structure

The project is organized into the following structure:

```plaintext
HabitTrackerProj/
┣ App/
┃ ┗ HabitTrackerProjApp.swift            // Main App file
┣ Models/
┃ ┗ Habit.swift                          // Habit @Model
┣ Repositories/
┃ ┣ HabitRepository.swift                // Repository protocol
┃ ┗ SwiftDataHabitRepository.swift       // SwiftData-based repository
┣ ViewModels/
┃ ┣ HomeViewModel.swift                  // Logic for Home
┃ ┗ NewHabitViewModel.swift              // Logic for NewHabit
┣ Views/
┃ ┣ HomeView.swift                       // Main View listing habits
┃ ┗ NewHabitView.swift                   // View for creating a habit
┗ …
```
---

## Requirements

- **Xcode 15** or later (required for iOS 17 development).  
- **iOS 17** or later for running on a device or simulator.  

---

## How to Run

1. **Clone the repository**  
   ```bash
   git clone https://github.com/Circuit-Stream-LMS/CapstoneProjectForSwiftUIPreUniversity.git

2.	Open the project in Xcode
	- Double-click the .xcodeproj file.
3.	Select a simulator or device
    - Choose an iOS 17 device (e.g., iPhone 15) or a real device running iOS 17.
4.	Run the app
	- Press Cmd + R or click the “Play” button in Xcode.

## Basic Usage
1.	Home Screen (HomeView)
	- When the app launches, you’ll see a list of habits (initially empty).
	- Tap the ”+” button on any habit to increment its completed count.
	- The label shows completedCount / expectedCount.
2.	Create a New Habit
	- Tap the “New Habit” button at the bottom.
	- Fill out the form: name, start date, notes, and daily or weekly frequency.
	•	If weekly, select one or more days of the week.
	•	Tap “Complete” to save the new habit.
3.	Track Your Progress
	- Return to the home screen to see the updated list and progress.
	- The expectedCount is calculated based on the habit’s start date and frequency.

## Demo
   ![Demo](https://github.com/Circuit-Stream-LMS/CapstoneProjectForSwiftUIPreUniversity/blob/main/demo.gif)
