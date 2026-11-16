import Foundation

// MODEL: just data, no UI and no logic.
struct Plant: Identifiable {
    var id = UUID()
    var name: String
    var room: String
    var light: String
    var wateringDays: String
    var water: String
    var isDone = false
}

extension Plant {
    static let samples = [
        Plant(name: "Monstera", room: "Kitchen", light: "Full sun", wateringDays: "Every day", water: "20-50 ml"),
        Plant(name: "Pothos", room: "Bedroom", light: "Full sun", wateringDays: "Every day", water: "20-50 ml", isDone: true),
        Plant(name: "Orchid", room: "Living Room", light: "Full sun", wateringDays: "Every day", water: "20-50 ml", isDone: true),
        Plant(name: "Spider", room: "Kitchen", light: "Full sun", wateringDays: "Every day", water: "20-50 ml", isDone: true)
    ]
}
