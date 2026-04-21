# Doctor Appointment App

A modern Flutter-based doctor appointment application that allows users to explore medical specialties, browse doctors, book appointments, manage bookings, and chat with doctors through a clean, scalable, and production-oriented mobile experience.

---

## Overview

**Doctor Appointment App** is a complete healthcare booking mobile application built with **Flutter** and powered by **Firebase**.

The app is designed to provide a smooth and intuitive user journey, starting from splash and onboarding, moving through authentication and doctor discovery, and ending with appointment booking, messaging, and profile management.

The project follows a **feature-based architecture** and uses **BLoC** for state management, making the codebase clean, maintainable, and easy to scale for future enhancements.

---

## Key Features

### Authentication
- Register with email and password
- Login with email and password
- Google Sign-In
- Logout
- Input validation
- Forgot password flow

### Onboarding & Splash
- Custom splash screen
- Onboarding flow for first-time users
- Smooth entry experience for new users

### Home
- Personalized welcome section
- Medical categories preview
- Top doctors preview
- Search UI
- Clean and modern layout

### Categories
- View all medical categories
- Dynamic category loading from Firebase
- Icon mapping based on category data

### Doctors
- View top doctors
- View all doctors
- Doctor details screen
- Doctor information, specialty, pricing, and description

### Appointments
- Book appointments
- Select date and time
- Add optional notes
- View booked appointments
- Delete appointments
- Real-time appointment status updates

### Appointment Status Support
- Pending
- Completed
- Cancelled

### Messages & Chat
- Real-time chat using Firestore
- Automatic conversation creation
- Doctor conversation list
- Real-time message loading
- Send/receive chat flow

### Profile
- User profile screen
- Logout functionality
- Reusable profile tiles
- Clean and organized UI sections

---

## Tech Stack

- **Flutter**
- **Dart**
- **BLoC**
- **Firebase Authentication**
- **Cloud Firestore**
- **Cloudinary**
- **Material Design**

---

## Architecture

This project is built using a **feature-based architecture**, where each feature is separated into dedicated layers for better maintainability, scalability, and code organization.

### Main Layers
- `data`
- `models`
- `services`
- `repositories`
- `presentation`
- `screens`
- `widgets`
- `bloc`

This structure makes the project easier to maintain and highly extensible for future production-level improvements.

---

## Project Structure

```bash
lib/
│
├── app/
│   ├── app.dart
│   └── routes/
│
├── core/
│   ├── helpers/
│   ├── loading/
│   ├── services/
│   └── utils/
│
├── features/
│   ├── auth/
│   ├── home/
│   ├── all_categories/
│   ├── all_doctors/
│   ├── appointments/
│   ├── message/
│   ├── onboarding/
│   ├── profile/
│   └── splash/
│
├── firebase_options.dart
└── main.dart
Screenshots
Splash Screen
<p align="center"> <img src="images/screenshot/splash_screen.png" width="230"/> </p>
Login Screen
<p align="center"> <img src="images/screenshot/login_screen.png" width="230"/> </p>
Register Screen
<p align="center"> <img src="images/screenshot/register_screen.png" width="230"/> </p>
Google Sign-In
<p align="center"> <img src="images/screenshot/goggle_signin.png" width="230"/> </p>
Home Screen
<p align="center"> <img src="images/screenshot/home_screen.png" width="230"/> <img src="images/screenshot/home_screen_1.png" width="230"/> </p>
All Categories
<p align="center"> <img src="images/screenshot/all_categories.png" width="230"/> </p>
All Doctors
<p align="center"> <img src="images/screenshot/all_doctors.png" width="230"/> </p>
Doctor Details
<p align="center"> <img src="images/screenshot/doctor_detail_1.png" width="230"/> <img src="images/screenshot/doctor_detail_2.png" width="230"/> </p>
New Appointment
<p align="center"> <img src="images/screenshot/new_appointment.png" width="230"/> </p>
Appointment Details
<p align="center"> <img src="images/screenshot/appointment_detail.png" width="230"/> </p>
Appointments Screen
<p align="center"> <img src="images/screenshot/appointments_screen.png" width="230"/> </p>
Delete Appointment
<p align="center"> <img src="images/screenshot/delete_appointment.png" width="230"/> </p>
Success Screen
<p align="center"> <img src="images/screenshot/sucess_screen.png" width="230"/> </p>
Messages Screen
<p align="center"> <img src="images/screenshot/message_screen.png" width="230"/> </p>
Chat Screen
<p align="center"> <img src="images/screenshot/chat_screen.png" width="230"/> </p>
Profile Screen
<p align="center"> <img src="images/screenshot/profile_screen.png" width="230"/> </p>
Logout
<p align="center"> <img src="images/screenshot/logout.png" width="230"/> <img src="images/screenshot/logout_2.png" width="230"/> </p>
