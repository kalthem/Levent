## Overview
Levent is an iOS application designed for users to explore and manage events seamlessly. The app supports two user types: **Users** (event attendees) and **Organizers** (event managers). Levent provides personalized event recommendations, ticket management, and organizer-specific tools.

The app is built using **UIKit**, **Storyboards**, and follows the **MVC Architecture**. Data is persisted locally using the `Codable` protocol and stored in the app's documents directory.

---

## Features
### User Features:
1. **Splash Screen**: Initial loading screen that redirects users based on their login status.
2. **Welcome Screen**: Entry point for new users, offering login and registration.
3. **User Home Screen**:
   - Displays personalized event recommendations.
   - Provides access to main events and user tickets.
   - Tab bar navigation to **Tickets** and **Explore**.
4. **Notifications**:
   - Lists user notifications in a vertical collection view.
   - Hardcoded notifications for MVP.
5. **Tickets Page**:
   - Displays tickets purchased by the user.
   - Includes event details and user comments.
6. **Explore Page**:
   - Grid-based layout for browsing all available events.
   - Includes search and filter functionality.

### Organizer Features:
1. **Organizer Home Screen**:
   - Displays organizer-specific statistics and events.
   - Allows access to event management tools.
2. **Event Management**:
   - Create, edit, and manage events.
   - View event-specific statistics.

---

## Screens
1. **Splash Screen**
2. **Welcome Screen**
3. **Login Screen**
4. **Registration Screen**
   - Includes a toggle for signing up as an organizer.
5. **Interests Screen**
6. **User Home Screen**
7. **Notifications Screen**
8. **Tickets Screen**
9. **Explore Screen**
10. **Organizer Home Screen**
11. **Event Details Screen**
12. **Event Management Screen**

---

## Development Setup
### Prerequisites:
- Xcode 15 or later
- Swift 5.8 or later
- macOS Ventura or later

### Steps to Run:
1. Clone the repository.
2. Open the `Levent.xcodeproj` file in Xcode.
3. Build and run the app on the iOS Simulator or a physical device.

---

## File Structure
### **Controllers:**
- Handles UI logic for each screen (e.g., `UserHomeViewController`, `NotificationsViewController`).

### **Views:**
- Custom view components and `.xib` files (e.g., `EventCollectionViewCell`, `NotificationCell`).

### **Models:**
- Data models using `Codable` (e.g., `User`, `Event`, `Ticket`).

### **Extensions:**
- Utility extensions (e.g., `UIViewController+Navigation.swift`).

---

## Future Improvements
1. **Dark Mode Support**
2. **Push Notifications**
3. **Cloud Sync for Data**
4. **Enhanced Event Management for Organizers**
5. **Advanced Analytics for Events**
