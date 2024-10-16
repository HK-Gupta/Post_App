# Post Sharing App

This is a simple Flutter application that displays posts, including text and image posts. The app fetches data from Firebase and allows users to share posts using the `share_plus` package.

## Features

- Display posts with text and image types.
- Share posts using a share button.
- Firebase integration to fetch posts.
- Bloc architecture using `flutter_bloc` for state management.

## Project Structure

- **business**: Contains `Cubit` and state management classes.
- **data**: Contains repository for Firebase-related operations.
- **presentation**: Contains UI widgets and pages.
- **widgets**: Custom reusable widgets, such as `PostWidget`.

---

## Firebase Setup

1. Set up a Firebase project and enable Firestore.
2. Add Firebase to your Flutter app:
   - Add the `google-services.json` file in the `android/app` directory.
   - Enable Firebase Firestore and configure rules for testing.
