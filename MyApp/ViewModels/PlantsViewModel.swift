import SwiftUI
import Combine

// VIEWMODEL for the My Plants / Today Reminder screens.
// Holds the state and the logic; the View only displays it.
final class PlantsViewModel: ObservableObject {
    @Published var plants: [Plant]

    init(plants: [Plant] = []) {
        self.plants = plants
    }

    var isEmpty: Bool { plants.isEmpty }

    var doneCount: Int { plants.filter(\.isDone).count }

    /// True when every plant is checked (shows the "All Done" screen).
    var allDone: Bool { !plants.isEmpty && plants.allSatisfy(\.isDone) }

    /// Progress bar value from 0 to 1.
    var doneFraction: Double {
        guard !plants.isEmpty else { return 0 }
        return Double(doneCount) / Double(plants.count)
    }

    /// Text above the progress bar (changes after you check plants).
    var statusMessage: String {
        doneCount == 0
            ? "Your plants are waiting for a sip 💦"
            : "\(doneCount) of your plants feel loved today ✨"
    }

    func add(_ plant: Plant) {
        plants.append(plant)
    }

    func update(_ plant: Plant) {
        guard let index = plants.firstIndex(where: { $0.id == plant.id }) else { return }
        plants[index] = plant
    }

    func delete(_ plant: Plant) {
        plants.removeAll { $0.id == plant.id }
    }

    func toggleDone(_ plant: Plant) {
        guard let index = plants.firstIndex(where: { $0.id == plant.id }) else { return }
        plants[index].isDone.toggle()
    }
}
