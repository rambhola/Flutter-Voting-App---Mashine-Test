# Startup Idea Evaluator AI Voting App

##  App Description
**Startup Idea Evaluator** is a mobile app that lets users submit startup ideas and get instant AI-generated ratings (0-100). Browse all ideas, upvote your favorites, and check the leaderboard to see top-rated concepts. Perfect for entrepreneurs, investors, and startup enthusiasts to discover and vote on the next big thing.

##  Tech Stack Used
```
Frontend: Flutter (Dart) - Cross-platform mobile
State Management: GetX (RxList, Obx, Get.find)
Responsive UI: flutter_screenutil
UI Components: Custom gradient cards, shadows, animations
Storage: Local (GetX state persistence)
Theming: Custom light/dark theme controller
```

##  Features Implemented

###  Idea Submission Screen
- **Form Fields**: Startup Name, Tagline, Description (all validated)
- **AI Rating**: Fake AI score generation (0-100) on submit
- **Real-time Feedback**: SnackBar with rating and success message
- **Auto-navigation**: Goes to Listing screen after submission

###  Idea Listing Screen
- **All Ideas Display**: Shows name, tagline, description, rating, votes
- **Search**: Real-time search across title, tagline, description
- **Sort Options**: Toggle between Rating or Name sorting
- **Favorites**: Heart button to mark favorite ideas
- **Empty State**: "No ideas found" message

### Features to Build
```
1. Upvote System
 One vote per idea using AsyncStorage/local storage
 Vote count display on cards
 Prevent duplicate votes

2. Read More Feature  
 Expandable description on cards
 "Read more" / "Show less" toggle

 3. Leaderboard Screen
 Top 5 ideas (votes or ratings)
badges with gradients/shadows
 Separate leaderboard tab/screen
```

## How to Run Locally

### Prerequisites
- Flutter SDK >= 3.0.0
- Android Studio / Xcode
- GetX dependency

### Clone & Run
```bash
git clone https://github.com/rambhola/Flutter-Voting-App---Mashine-Test.git
cd startup-idea-evaluator
flutter pub get
flutter pub run flutter_screenutil:init
flutter run
```

### APK Installation
1. Build APK: `flutter build apk --release`
2. Find APK: `build/app/outputs/flutter-apk/app-release.apk`
3. Install on Android device



***

**Built with ❤️ for startup enthusiasts! 🚀**
