import SwiftUI

/// Which version of the Set Reminder sheet is open.
enum ReminderSheet: Identifiable {
    case add
    case edit(Plant)

    var id: String {
        switch self {
        case .add: return "add"
        case .edit(let plant): return plant.id.uuidString
        }
    }
}

struct MyPlantsView: View {
    @StateObject private var viewModel: PlantsViewModel
    @State private var sheet: ReminderSheet?

    // Pass Plant.samples in the preview to see the list.
    init(plants: [Plant] = []) {
        _viewModel = StateObject(wrappedValue: PlantsViewModel(plants: plants))
    }

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Color.black.ignoresSafeArea()

            VStack(alignment: .leading, spacing: 0) {
                Text("My Plants 🌱")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    .padding(.bottom, 16)

                Divider().background(Color.white.opacity(0.2))

                if viewModel.isEmpty {
                    emptyState
                } else if viewModel.allDone {
                    allDoneState
                } else {
                    todayList
                }
            }

            if !viewModel.isEmpty {
                Button { sheet = .add } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(width: 56, height: 56)
                        .background(Color.plantGreen)
                        .clipShape(Circle())
                }
                .padding(.trailing, 24)
                .padding(.bottom, 32)
            }
        }
        .sheet(item: $sheet) { mode in
            switch mode {
            case .add:
                SetReminderView(onSave: { viewModel.add($0) })
            case .edit(let plant):
                SetReminderView(plant: plant,
                                onSave: { viewModel.update($0) },
                                onDelete: { viewModel.delete(plant) })
            }
        }
    }

    // MARK: Empty state

    private var emptyState: some View {
        VStack {
            Spacer()

            VStack(spacing: 16) {
                Image("planto")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)

                Text("Start your plant journey!")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.top, 20)

                Text("Now all your plants will be in one place and\nwe will help you take care of them :)🪴")
                    .font(.system(size: 15))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondaryText)
            }
            .frame(maxWidth: .infinity)

            Spacer()

            Button { sheet = .add } label: {
                Text("Set Plant Reminder")
                    .font(.system(size: 17, weight: .medium))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.plantGreen)
                    .clipShape(Capsule())
            }
            .padding(.horizontal, 40)
            .padding(.bottom, 60)
        }
    }

    // MARK: All Reminders Completed

    private var allDoneState: some View {
        VStack(spacing: 12) {
            Spacer()

            Image("plantowink")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)

            Text("All Done! 🎉")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.white)
                .padding(.top, 20)

            Text("All Reminders Completed")
                .font(.system(size: 15))
                .foregroundColor(.secondaryText)

            Spacer()
        }
        .frame(maxWidth: .infinity)
    }

    // MARK: Today Reminder list (tap = edit, swipe left = delete)

    private var todayList: some View {
        VStack(spacing: 0) {
            VStack(spacing: 12) {
                Text(viewModel.statusMessage)
                    .font(.system(size: 16))
                    .foregroundColor(.white)

                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        Capsule().fill(Color.fieldBackground)
                        Capsule()
                            .fill(Color.plantGreen)
                            .frame(width: geo.size.width * viewModel.doneFraction)
                            .animation(.easeInOut, value: viewModel.doneFraction)
                    }
                }
                .frame(height: 6)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 20)

            List {
                ForEach(viewModel.plants) { plant in
                    PlantRow(
                        plant: plant,
                        onToggle: { withAnimation { viewModel.toggleDone(plant) } },
                        onEdit: { sheet = .edit(plant) }
                    )
                    .listRowBackground(Color.black)
                    .listRowSeparatorTint(Color.white.opacity(0.15))
                    .listRowInsets(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12))
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            withAnimation { viewModel.delete(plant) }
                        } label: {
                            Image(systemName: "trash")
                        }
                        .tint(.red)
                    }
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
        }
    }
}

#Preview("Empty") { MyPlantsView() }
#Preview("List (3 done)") { MyPlantsView(plants: Plant.samples) }
#Preview("All Done") {
    MyPlantsView(plants: Plant.samples.map { var p = $0; p.isDone = true; return p })
}
