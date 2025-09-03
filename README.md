# Wedding Planner App 🎉

A Flutter-based mobile application to help plan weddings with ease.  
This app was built as part of an **interview assignment** and demonstrates use of **Flutter, SQLite, JSON, Provider, and Material UI**.

---

## ✨ Features

- **Splash Screen** → Custom intro screen with app logo  
- **Wedding Checklist** → Add, update, delete, and mark tasks as completed (SQLite database)  
- **Venues** → Venue list loaded from JSON with detail page & Hero animation  
- **Budget Calculator** → Simple budget breakdown for wedding expenses  
- **Guest List** → Add and manage guest details using SQLite  
- **Dark/Light Mode Toggle** → Switch themes from AppBar  
- **Bottom Navigation** → Navigate between all sections easily  

---

## 🛠️ Tech Stack

- **Flutter (3.19.0+)**
- **Dart (3.9.0+)**
- **SQLite** via `sqflite` package  
- **JSON (assets/venues.json)** for venues  
- **Provider** for state management  
- **Google Fonts** for UI polish  

---

## 📂 Project Structure

```

lib/
│
├── main.dart             # Entry point + navigation + theme toggle
├── splash\_screen.dart    # Splash screen
├── db\_helper.dart        # SQLite database helper
├── venues\_page.dart      # Venues list + details
├── budget\_page.dart      # Budget breakdown
├── guest\_page.dart       # Guest management
└── ...                   # Checklist, models, utils
assets/
└── venues.json           # Sample venues data

````

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK installed (`flutter doctor` should be clean)  
- Android Studio / VS Code with Flutter plugin  
- Emulator or physical Android device connected  

### Steps to Run
```bash
git clone https://github.com/<your-username>/wedding_planner_app.git
cd wedding_planner_app
flutter pub get
flutter run
````

### Build Release APK

```bash
flutter build apk --release
```

APK output:

```
build/app/outputs/flutter-apk/app-release.apk
```

---

## 📱 Demo

🎥 Watch the 2–3 min demo video here:
👉 [Demo Video Link](https://drive.google.com/file/d/1zg4mNoA8qVGR6dbGpZY1PTJ3E5qJAtTz/view?usp=drive_link)

---

## 👨‍💻 Author

**Shivam Gupta**

* Flutter & Java Enthusiast
* [LinkedIn](https://www.linkedin.com/in/shivam-gupta-cse/)

```
