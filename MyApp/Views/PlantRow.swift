import SwiftUI

struct PlantRow: View {
    let plant: Plant
    let onToggle: () -> Void
    let onEdit: () -> Void

    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            Button(action: onToggle) {
                Image(systemName: plant.isDone ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 28, weight: .light))
                    .foregroundColor(plant.isDone ? .plantGreen : .secondaryText)
            }
            .buttonStyle(.plain)

            // Tapping the text area opens the edit screen
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Label("in \(plant.room)", systemImage: "location")
                        .font(.system(size: 13))
                        .foregroundColor(.secondaryText)

                    Text(plant.name)
                        .font(.system(size: 26))
                        .foregroundColor(plant.isDone ? .secondaryText : .white)

                    HStack(spacing: 8) {
                        tag(icon: "sun.max", text: plant.light, color: .sunTag)
                        tag(icon: "drop", text: plant.water, color: .waterTag)
                    }
                    .opacity(plant.isDone ? 0.5 : 1)
                }
                Spacer()
            }
            .contentShape(Rectangle())
            .onTapGesture(perform: onEdit)
        }
        .padding(.vertical, 14)
        .padding(.horizontal, 8)
    }

    private func tag(icon: String, text: String, color: Color) -> some View {
        HStack(spacing: 4) {
            Image(systemName: icon)
            Text(text)
        }
        .font(.system(size: 13, weight: .medium))
        .foregroundColor(color)
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(Color.tagBackground)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    PlantRow(plant: Plant.samples[0], onToggle: {}, onEdit: {})
        .background(Color.black)
}
