# Smart Ahwa Manager 📱☕

A Flutter application designed for Egyptian coffee house (ahwa) owners to streamline their daily operations, manage customer orders, and track business performance.

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)


## Screenshots:
<img width="1344" height="2992" alt="Screenshot_20250918_203924" src="https://github.com/user-attachments/assets/9a5d66e3-616d-4844-9c30-ad4fed8ce538" />
<img width="1344" height="2992" alt="Screenshot_20250918_204119" src="https://github.com/user-attachments/assets/93172478-be32-464b-bdec-a64fd8009495" />
<img width="1344" height="2992" alt="Screenshot_20250918_204058" src="https://github.com/user-attachments/assets/ed6be45c-0c4d-4991-aa7a-531e16f3045c" />
<img width="1344" height="2992" alt="Screenshot_20250918_204048" src="https://github.com/user-attachments/assets/872e92c7-3a71-4800-9616-3d05b3004d41" />
<img width="1344" height="2992" alt="Screenshot_20250918_204007" src="https://github.com/user-attachments/assets/2a2331e4-36ca-4ae6-b6cb-7a12663cdf2e" />


## 🎯 Project Overview

This app helps ahwa owners in Cairo efficiently manage their business by providing tools to:
- Add and track customer orders
- Manage different drink types with customizable options
- View pending orders in real-time
- Generate daily sales reports and analytics
- Track popular items and revenue

## ✨ Features

### 📋 Order Management
- **Add Orders**: Create new orders with customer names, drink selections, and special instructions
- **Pending Orders Dashboard**: View all pending orders with customer details and drink specifications
- **Order Completion**: Mark orders as completed with a single tap
- **Special Instructions**: Support for Egyptian ahwa expressions like "extra mint, ya rais"

### 🍵 Drink Types Supported
- **Shai (Egyptian Tea)**: Customizable with mint and sugar levels (0-3)
- **Turkish Coffee**: Available in three preparations (sada, mazbout, ziyada)
- **Hibiscus Tea (Karkade)**: Hot or cold options

### 📊 Analytics & Reports
- **Daily Sales Report**: Complete overview of daily performance
- **Top-Selling Drinks**: Track most popular beverages
- **Revenue Tracking**: Monitor daily earnings
- **Order Statistics**: Total orders served and completion rates

## 🏗️ Architecture & Design Patterns

This project demonstrates professional software development principles:

### SOLID Principles Implementation

#### 🎯 Single Responsibility Principle (SRP)
- `OrderService`: Handles order-related operations exclusively
- `ReportService`: Manages analytics and reporting functionality
- `OrderRepository`: Manages data persistence operations
- Each UI screen has a single, focused responsibility

#### 🔓 Open/Closed Principle (OCP)
- **Extensible Drink System**: New drink types can be added without modifying existing code
- **Factory Pattern**: `DrinkFactory` implementations allow easy addition of new beverages
- **Repository Pattern**: Different storage solutions can be plugged in seamlessly

#### 🔄 Dependency Inversion Principle (DIP)
- High-level services depend on abstract interfaces, not concrete implementations
- `OrderService` and `ReportService` use abstract `OrderRepository`
- Easy to test and swap different data storage solutions

### OOP Concepts Demonstrated

#### 🔗 Polymorphism
- `Drink` base class provides a unified interface
- Different drink types (`Shai`, `TurkishCoffee`, `Karkade`) override methods to handle custom logic
- The system treats all drinks uniformly while maintaining unique behaviors

#### 📦 Encapsulation
- Drink customization options (sugar levels, mint, hot/cold) are private to each class
- Controlled access through public getters and setters ensures data integrity

#### 🏛️ Abstraction
- Abstract classes (`Drink`) and interfaces (`OrderRepository`) define contracts
- Concrete implementations must adhere to business rules without exposing internal details

---

## 🛠️ Tech Stack

- **Frontend**: Flutter (Dart)
- **State Management**: Cubit (Bloc)
- **Backend**: Firebase Firestore for orders & reporting
- **Authentication**: Firebase Auth
- **UI**: Material Design + Custom Widgets
- **Reports & Analytics**: Local service layer with Firestore aggregation

---

## 🚀 Getting Started

### Prerequisites
- Install [Flutter](https://docs.flutter.dev/get-started/install) (latest stable)
- Install [Android Studio](https://developer.android.com/studio) or [VS Code](https://code.visualstudio.com/)
- Configure an emulator or connect a physical device
- Firebase project configured for:
  - Authentication
  - Firestore Database

### Installation
```bash
# Clone the repository
git clone https://github.com/your-username/smart-ahwa-manager.git

# Navigate to the project
cd smart-ahwa-manager

# Install dependencies
flutter pub get

# Run the app
flutter run
