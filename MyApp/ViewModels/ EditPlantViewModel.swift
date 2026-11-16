//
//  EditPlantViewModel.swift
//  MyApp
//

import Foundation
import Combine

// VIEWMODEL for the Set Reminder sheet (used for both Add and Edit).
class EditPlantViewModel: ObservableObject {
    @Published var plant: Plant

    let rooms = ["Bedroom", "Living Room", "Kitchen", "Balcony", "Bathroom"]
    let lights = ["Full sun", "Partial sun", "Low light"]
    let wateringDays = ["Every day", "Every 2 days", "Every 3 days", "Once a week"]
    let waterAmounts = ["20-50 ml", "50-100 ml", "100-200 ml"]

    init(plant: Plant) {
        self.plant = plant
    }

    var canSave: Bool {
        !plant.name.trimmingCharacters(in: .whitespaces).isEmpty
    }

    // A blank plant for the "Add" flow
    static func blankPlant() -> Plant {
        Plant(name: "", room: "Bedroom", light: "Full sun",
              wateringDays: "Every day", water: "20-50 ml")
    }
}
