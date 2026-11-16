//
//  EditPlantView.swift
//  MyApp
//

import SwiftUI

// VIEW: Set Reminder sheet. isNew = true -> Add mode (no delete button).
struct EditPlantView: View {
    @StateObject private var viewModel: EditPlantViewModel
    @State private var showDeleteAlert = false
    @Environment(\.dismiss) private var dismiss

    let isNew: Bool
    let onSave: (Plant) -> Void
    let onDelete: (Plant) -> Void

    init(plant: Plant,
         isNew: Bool = false,
         onSave: @escaping (Plant) -> Void,
         onDelete: @escaping (Plant) -> Void = { _ in }) {
        _viewModel = StateObject(wrappedValue: EditPlantViewModel(plant: plant))
        self.isNew = isNew
        self.onSave = onSave
        self.onDelete = onDelete
    }

    var body: some View {
        VStack(spacing: 20) {
            header

            TextField("Plant name (e.g. Pothos)", text: $viewModel.plant.name)
                .padding()
                .background(Color.fieldBackground, in: RoundedRectangle(cornerRadius: 14))

            VStack(spacing: 0) {
                pickerRow("Room", icon: "location", selection: $viewModel.plant.room, options: viewModel.rooms)
                Divider()
                pickerRow("Light", icon: "sun.max", selection: $viewModel.plant.light, options: viewModel.lights)
            }
            .background(Color.fieldBackground, in: RoundedRectangle(cornerRadius: 14))

            VStack(spacing: 0) {
                pickerRow("Watering Days", icon: "drop", selection: $viewModel.plant.wateringDays, options: viewModel.wateringDays)
                Divider()
                pickerRow("Water", icon: "drop", selection: $viewModel.plant.water, options: viewModel.waterAmounts)
            }
            .background(Color.fieldBackground, in: RoundedRectangle(cornerRadius: 14))

            Spacer()

            if !isNew {
                Button(role: .destructive) {
                    showDeleteAlert = true
                } label: {
                    Text("Delete Reminder")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundStyle(.red)
                        .background(Color.fieldBackground, in: RoundedRectangle(cornerRadius: 14))
                }
            }
        }
        .padding()
        .background(Color.sheetBackground.ignoresSafeArea())
        .preferredColorScheme(.dark)
        .alert("Delete this reminder?", isPresented: $showDeleteAlert) {
            Button("Delete", role: .destructive) {
                onDelete(viewModel.plant)
                dismiss()
            }
            Button("Cancel", role: .cancel) {}
        }
    }

    private var header: some View {
        HStack {
            Button { dismiss() } label: {
                Image(systemName: "xmark")
                    .padding(12)
                    .background(Color.fieldBackground, in: Circle())
            }
            Spacer()
            Text("Set Reminder").font(.headline)
            Spacer()
            Button {
                onSave(viewModel.plant)
                dismiss()
            } label: {
                Image(systemName: "checkmark")
                    .padding(12)
                    .background(viewModel.canSave ? Color.plantGreen : Color.fieldBackground, in: Circle())
            }
            .disabled(!viewModel.canSave)
        }
        .foregroundStyle(.white)
    }

    private func pickerRow(_ title: String, icon: String,
                           selection: Binding<String>, options: [String]) -> some View {
        HStack {
            Label(title, systemImage: icon)
            Spacer()
            Picker(title, selection: selection) {
                ForEach(options, id: \.self) { Text($0).tag($0) }
            }
            .tint(Color.secondaryText)
        }
        .padding(.horizontal)
        .padding(.vertical, 6)
    }
}

#Preview {
    EditPlantView(plant: EditPlantViewModel.blankPlant(), isNew: true, onSave: { _ in })
}
