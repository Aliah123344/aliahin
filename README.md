# Planto 🌱

An iOS app that helps you remember to water your plants. Add a plant, choose where it lives, how much light it gets and how often it needs water, and Planto reminds you with a notification.

Built with **SwiftUI** and the **MVVM** design pattern, based on a high-fidelity design made in Sketch.

## Features

- **Empty state** welcoming new users with a button to add the first plant reminder
- **Add a reminder** with plant name, room, light, watering days and water amount
- **Today list** showing every plant with its room, light and water tags
- **Progress bar** and a message that updates as you mark plants as watered
- **All Done screen** when every plant has been watered
- **Edit a plant** by tapping it, or **delete it** with the "Delete Reminder" button
- **Swipe to delete** a plant straight from the list
- **Local notifications** ("Hey! let's water your plant") scheduled according to each plant's watering days

## Tech stack

- **Language:** Swift
- **UI:** SwiftUI
- **Architecture:** MVVM (Models, ViewModels, Views)
- **Notifications:** UserNotifications (local notifications)
- **Design:** Sketch

## Project structure

```
MyApp
├── App          // App entry point, ContentView, NotificationService
├──
