# 📱 Flutter Group Chat App (chatGroupApp)

A real-time group chat application built with **Flutter**, using **Firebase Firestore** and **BLoC (Cubit)** for clean, scalable state management.

---

## 🚀 Features

### 🔥 Firebase Integration

- Uses **Firebase Firestore** for real-time message synchronization.
- Messages are stored with:
  - Sender name
  - Email (ID)
  - Message content
  - Timestamp

### 💬 Group Chat

- Multiple users can chat in the same group at the same time.
- Messages appear instantly for all participants.

### 👤 Sender Info

- Each message displays the sender’s **name**.
- Visually distinguishes between:
  - Sent messages
  - Received messages

### 🧠 BLoC (Cubit) State Management

- `ChatCubit` handles:
  - Sending messages
  - Listening to Firestore updates in real-time
  - Rebuilding UI accordingly

---

## 🛠️ Project Status

✅ Chat functionality is fully working  
🔜 **Login & Register** will be managed via Cubit soon (coming within a week)

---

## 🧾 Getting Started

1. Clone the repo:
   ```bash
   git clone https://github.com/mhmedhossam/chatGroupApp.git
   cd chatGroupApp
   ```
