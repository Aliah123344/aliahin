import SwiftUI

struct SetReminderView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: SetReminderViewModel

    /// ✓ tapped: returns the new / edited plant to the list screen.
    private let onSave: (Plant) -> Void
    /// "Delete Reminder" tapped (only shown when editing).
    private let onDelete: () -> Void

    init(plant: Plant? = nil,
         onSave: @escaping (Plant) -> Void = { _ in },
         onDelete: @escaping () -> Void = {}) {
        _viewModel = StateObject(wrappedValue: SetReminderViewModel(plant: plant))
        self.onSave = onSave
        self.onDelete = onDelete
    }

    var body: some View {
        ZStack {
            Color.sheetBackground.ignoresSafeArea()

            VStack(spacing: 24) {
                header

                HStack(spacing: 8) {
                    Text("Plant Name")
                        .foregroundColor(.white)
                    Rectangle()
                        .fill(Color.plantGreen)
                        .frame(width: 1.5, height: 20)
                    TextField("", text: $viewModel.plantName,
                              prompt: Text("Pothos").foregroundColor(.secondaryText))
                        .foregroundColor(.white)
                }
                .font(.system(size: 17))
                .padding(.horizontal, 20)
                .frame(height: 56)
                .background(Color.fieldBackground)
                .clipShape(RoundedRectangle(cornerRadius: 28))

                card {
                    pickerRow(icon: "location", title: "Room",
                              selection: $viewModel.room, options: viewModel.rooms)
                    Divider().background(Color.white.opacity(0.15))
                    pickerRow(icon: "sun.max", title: "Light",
                              selection: $viewModel.light, options: viewModel.lights)
                }

                card {
                    pickerRow(icon: "drop", title: "Watering Days",
                              selection: $viewModel.wateringDays, options: viewModel.days)
                    Divider().background(Color.white.opacity(0.15))
                    pickerRow(icon: "drop", title: "Water",
                              selection: $viewModel.water, options: viewModel.amounts)
                }

                if viewModel.isEditing {
                    Button {
                        onDelete()
                        dismiss()
                    } label: {
                        Text("Delete Reminder")
                            .font(.system(size: 17, weight: .medium))
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity)
                            .frame(height: 52)
                            .background(Color.fieldBackground)
                            .clipShape(RoundedRectangle(cornerRadius: 26))
                    }
                }

                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
        }
    }

    private var header: some View {
        HStack {
            Button { dismiss() } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(width: 44, height: 44)
                    .background(Color.white.opacity(0.15))
                    .clipShape(Circle())
            }

            Spacer()

            Text("Set Reminder")
                .font(.system(size: 17, weight: .semibold))
                .foregroundColor(.white)

            Spacer()

            Button {
                onSave(viewModel.makePlant())
                dismiss()
            } label: {
                Image(systemName: "checkmark")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(width: 44, height: 44)
                    .background(Color.plantGreen)
                    .clipShape(Circle())
            }
            .disabled(!viewModel.canSave)
            .opacity(viewModel.canSave ? 1 : 0.5)
        }
        .padding(.bottom, 12)
    }

    private func card<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        VStack(spacing: 0) { content() }
            .padding(.horizontal, 16)
            .padding(.vertical, 4)
            .background(Color.fieldBackground)
            .clipShape(RoundedRectangle(cornerRadius: 24))
    }

    private func pickerRow(icon: String,
                           title: String,
                           selection: Binding<String>,
                           options: [String]) -> some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.white)
                .frame(width: 24)
            Text(title)
                .foregroundColor(.white)
            Spacer()
            Picker(title, selection: selection) {
                ForEach(options, id: \.self) { Text($0).tag($0) }
            }
            .pickerStyle(.menu)
            .tint(.secondaryText)
        }
        .font(.system(size: 17))
        .frame(height: 48)
    }
}

#Preview("Add") { SetReminderView() }
#Preview("Edit") { SetReminderView(plant: Plant.samples[0]) }
