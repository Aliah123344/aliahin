import SwiftUI
import Combine

// VIEWMODEL for the Set Reminder form.
// Works in two modes: adding a new plant, or editing an existing one.
final class SetReminderViewModel: ObservableObject {
    @Published var plantName = ""
    @Published var room = "Bedroom"
    @Published var light = "Full sun"
    @Published var wateringDays = "Every day"
    @Published var water = "20-50 ml"

    private let original: Plant?

    let rooms = ["Bedroom", "Living Room", "Kitchen", "Balcony", "Bathroom"]
    let lights = ["Full sun", "Partial sun", "Low light"]
    let days = ["Every day", "Every 2 days", "Every 3 days", "Once a week", "Every 10 days", "Every 2 weeks"]
    let amounts = ["20-50 ml", "50-100 ml", "100-200 ml", "200-300 ml"]

    /// Pass a plant to edit it; pass nil to add a new one.
    init(plant: Plant? = nil) {
        original = plant
        if let plant {
            plantName = plant.name
            room = plant.room
            light = plant.light
            wateringDays = plant.wateringDays
            water = plant.water
        }
    }

    var isEditing: Bool { original != nil }

    var canSave: Bool {
        !plantName.trimmingCharacters(in: .whitespaces).isEmpty
    }

    func makePlant() -> Plant {
        Plant(id: original?.id ?? UUID(),
              name: plantName.trimmingCharacters(in: .whitespaces),
              room: room,
              light: light,
              wateringDays: wateringDays,
              water: water,
              isDone: original?.isDone ?? false)
    }
}
