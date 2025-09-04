# 🎬 MoviX - Your Ultimate Movie Discovery App

<div align="center">
  <img src="assets/images/movix_logo.png" alt="MoviX Logo" width="120" height="120">
  
  <h3>🎭 Discover Movies Like Never Before 🎭</h3>
  
  [![Flutter](https://img.shields.io/badge/Flutter-3.9.0-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
  [![Dart](https://img.shields.io/badge/Dart-3.9.0-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
  [![TMDB API](https://img.shields.io/badge/TMDB-API-01B4E4?style=for-the-badge&logo=themoviedatabase&logoColor=white)](https://www.themoviedb.org)
  [![GetX](https://img.shields.io/badge/GetX-State%20Management-9C27B0?style=for-the-badge)](https://pub.dev/packages/get)
  [![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)](LICENSE)
</div>

<div align="center">
  
  ### 🌟 A Modern Flutter Movie App with Clean Architecture 🌟
  
</div>

---

## 🎭 About MoviX

**MoviX** is a cutting-edge movie discovery application built with **Flutter** and powered by **The Movie Database (TMDB) API**. The app showcases modern UI/UX design with a **Cinema Neon Theme**, featuring stunning gradient colors and smooth animations that bring the movie experience to life.

### ✨ Key Features

🔥 **Movie Discovery**  
- Browse trending movies with auto-scroll hero slider
- Explore now playing, top rated, and upcoming movies
- Detailed movie information with cast, crew, and trailers

🎯 **Smart Search System**  
- Real-time search with instant suggestions
- Search history and popular movie recommendations
- Advanced filtering and sorting options

📱 **Modern UI/UX**  
- Cinema Neon theme with gradient colors
- Responsive design for all screen sizes
- Smooth animations and transitions
- Custom loading effects with shimmer

⚡ **High Performance**  
- Image caching for faster loading
- Optimized API calls with error handling
- Clean Architecture with MVVM pattern
- State management with GetX

---

## 📱 App Screenshots

<div align="center">

### 🌟 Splash Screen
<img src="screenshot/splash_screen.png" alt="Splash Screen" width="250" style="border-radius: 15px; box-shadow: 0 4px 20px rgba(0,0,0,0.3);">

### 🏠 Home Screen
<img src="screenshot/home_screen.jpg" alt="Home Screen" width="250" style="border-radius: 15px; box-shadow: 0 4px 20px rgba(0,0,0,0.3);">

### 🔍 Search Experience
<div style="display: flex; gap: 10px; justify-content: center;">
  <img src="screenshot/search_screen.jpg" alt="Search Screen" width="245" style="border-radius: 15px; box-shadow: 0 4px 20px rgba(0,0,0,0.3);">
  <img src="screenshot/search_screen2.png" alt="Search Results" width="245" style="border-radius: 15px; box-shadow: 0 4px 20px rgba(0,0,0,0.3);">
</div>

### 🎬 Movie Categories
<div style="display: flex; gap: 15px; justify-content: center; flex-wrap: wrap;">
  <img src="screenshot/now_play_screen.jpg" alt="Now Playing" width="160" style="border-radius: 15px; box-shadow: 0 4px 20px rgba(0,0,0,0.3);">
  <img src="screenshot/top_rated.jpg" alt="Top Rated" width="160" style="border-radius: 15px; box-shadow: 0 4px 20px rgba(0,0,0,0.3);">
  <img src="screenshot/upcoming_movie_screen.jpg" alt="Upcoming" width="160" style="border-radius: 15px; box-shadow: 0 4px 20px rgba(0,0,0,0.3);">
</div>

### 🎭 Movie Details
<div style="display: flex; gap: 10px; justify-content: center;">
  <img src="screenshot/movie_details_screen.jpg" alt="Movie Details 1" width="245" style="border-radius: 15px; box-shadow: 0 4px 20px rgba(0,0,0,0.3);">
  <img src="screenshot/movie_details_screen2.png" alt="Movie Details 2" width="245" style="border-radius: 15px; box-shadow: 0 4px 20px rgba(0,0,0,0.3);">
</div>

</div>

---

## 🏗️ Clean Architecture

MoviX follows **Clean Architecture** principles with **MVVM pattern** for maintainable and scalable code:

```
📁 lib/
├── 🎨 presentation/           # UI Layer
│   ├── screens/              # App Screens
│   ├── controllers/          # State Management (GetX)
│   └── widgets/              # Reusable UI Components
├── 🏢 domain/                # Business Logic Layer  
│   ├── entities/             # Core Business Models
│   ├── repositories/         # Abstract Repository Interfaces
│   └── usecases/             # Business Use Cases
├── 🗃️ data/                  # Data Layer
│   ├── models/               # API Data Models
│   ├── repositories/         # Repository Implementations
│   └── services/             # API Services
└── ⚙️ core/                  # Core Utilities
    ├── theme/                # App Theme & Colors
    ├── constants/            # App Constants
    ├── di/                   # Dependency Injection
    └── routes/               # Navigation Routes
```

---

## 🛠️ Technologies & Packages

<div align="center">

### 📱 Core Framework
![Flutter](https://img.shields.io/badge/Flutter-3.9.0-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.9.0-0175C2?style=for-the-badge&logo=dart&logoColor=white)

### 🏗️ State Management & Navigation
![GetX](https://img.shields.io/badge/GetX-4.6.6-9C27B0?style=for-the-badge)

### 🌐 API & Networking
![HTTP](https://img.shields.io/badge/HTTP-1.1.0-4CAF50?style=for-the-badge)
![TMDB](https://img.shields.io/badge/TMDB-API-01B4E4?style=for-the-badge&logo=themoviedatabase&logoColor=white)

### 🎨 UI & Design
![Google Fonts](https://img.shields.io/badge/Google%20Fonts-6.2.1-4285F4?style=for-the-badge&logo=google&logoColor=white)
![Cached Network Image](https://img.shields.io/badge/Cached%20Network%20Image-3.3.0-FF6B35?style=for-the-badge)
![Shimmer](https://img.shields.io/badge/Shimmer-3.0.0-FFD700?style=for-the-badge)

### 💾 Data & Storage
![Shared Preferences](https://img.shields.io/badge/Shared%20Preferences-2.3.2-8BC34A?style=for-the-badge)

### 🌐 Web & External Links
![WebView Flutter](https://img.shields.io/badge/WebView%20Flutter-4.4.2-2196F3?style=for-the-badge)
![URL Launcher](https://img.shields.io/badge/URL%20Launcher-6.2.4-FF9800?style=for-the-badge)

</div>

### 📦 Complete Package List

```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # State Management & Navigation
  get: ^4.6.6                    # State management, routing, dependency injection
  
  # HTTP & API
  http: ^1.1.0                   # HTTP client for API calls
  url_launcher: ^6.2.4           # Launch URLs and external links
  webview_flutter: ^4.4.2        # In-app web browser
  
  # UI & Styling
  google_fonts: ^6.2.1           # Custom fonts from Google Fonts
  cached_network_image: ^3.3.0   # Efficient image loading and caching
  shimmer: ^3.0.0                # Loading animations
  
  # Storage
  shared_preferences: ^2.3.2     # Local key-value storage
  
  # Utils
  cupertino_icons: ^1.0.8        # iOS style icons
  intl: ^0.20.2                  # Internationalization
```

---

## 🎨 Design System & Color Palette

### 🌈 Cinema Neon Theme Colors

<div align="center">

| Color | Hex Code | Usage | Preview |
|-------|----------|-------|---------|
| 🟣 **Primary Purple** | `#8B5CF6` | Main brand color, buttons | ![#8B5CF6](https://via.placeholder.com/20/8B5CF6/000000?text=+) |
| 🔵 **Electric Blue** | `#3B82F6` | Accents, links | ![#3B82F6](https://via.placeholder.com/20/3B82F6/000000?text=+) |
| 🔷 **Cyan Accent** | `#06B6D4` | Highlights, icons | ![#06B6D4](https://via.placeholder.com/20/06B6D4/000000?text=+) |
| 🟠 **Bright Orange** | `#FF8C00` | Call-to-action, ratings | ![#FF8C00](https://via.placeholder.com/20/FF8C00/000000?text=+) |
| 🟡 **Golden Yellow** | `#FFD700` | Stars, premium elements | ![#FFD700](https://via.placeholder.com/20/FFD700/000000?text=+) |

</div>

### 🌑 Dark Theme Palette

<div align="center">

| Color | Hex Code | Usage | Preview |
|-------|----------|-------|---------|
| ⚫ **Dark Background** | `#0A0B1E` | Main background | ![#0A0B1E](https://via.placeholder.com/20/0A0B1E/FFFFFF?text=+) |
| 🔘 **Surface Dark** | `#1A1B3A` | Cards, surfaces | ![#1A1B3A](https://via.placeholder.com/20/1A1B3A/FFFFFF?text=+) |
| 🎴 **Card Dark** | `#252652` | Elevated cards | ![#252652](https://via.placeholder.com/20/252652/FFFFFF?text=+) |
| 📝 **Text Primary** | `#FFFFFF` | Main text | ![#FFFFFF](https://via.placeholder.com/20/FFFFFF/000000?text=+) |
| 📖 **Text Secondary** | `#E2E8F0` | Secondary text | ![#E2E8F0](https://via.placeholder.com/20/E2E8F0/000000?text=+) |

</div>

### 🎭 Typography System

<div align="center">

| Font Family | Usage | Weight | Example |
|-------------|-------|--------|---------|
| **🚀 Orbitron** | Logo, main titles | Bold (700) | `MoviX` |
| **🎬 Oswald** | Section headers | Semi-Bold (600) | `Now Playing` |
| **📝 Roboto** | Body text, descriptions | Regular (400) | `Movie descriptions` |
| **✨ Inter** | Small text, captions | Light (300) | `Release date, ratings` |

</div>

---

## 🚀 Getting Started

### 📋 Prerequisites

Before you begin, ensure you have met the following requirements:

- **Flutter SDK**: 3.9.0 or higher
- **Dart**: 3.9.0 or higher  
- **IDE**: Android Studio, VS Code, or IntelliJ IDEA
- **Git**: For version control
- **TMDB API Key**: Free API key from The Movie Database

### ⚙️ Installation Guide

1. **📥 Clone the Repository**
```bash
git clone https://github.com/your-username/movix-flutter-app.git
cd movix-flutter-app
```

2. **📦 Install Dependencies**
```bash
flutter pub get
```

3. **🔑 Setup TMDB API Key**

Get your free API key from [TMDB](https://www.themoviedb.org/settings/api):

```dart
// lib/core/constants/api_constants.dart
class ApiConstants {
  static const String apiKey = 'YOUR_TMDB_API_KEY_HERE';
  // ... rest of the constants
}
```

4. **▶️ Run the App**
```bash
# For debug mode
flutter run

# For release mode
flutter run --release

# For specific platform
flutter run -d android
flutter run -d ios
```

5. **🏗️ Build APK (Android)**
```bash
flutter build apk --release
```

---

## 🎯 Use Cases & Features

### 🎬 Movie Management Use Cases

- **`GetTrendingMoviesUseCase`** - Fetch daily trending movies
- **`GetNowPlayingMoviesUseCase`** - Get currently playing in theaters  
- **`GetTopRatedMoviesUseCase`** - Retrieve highest-rated movies
- **`GetUpcomingMoviesUseCase`** - Fetch upcoming movie releases

### 🔍 Search & Discovery

- **`SearchMoviesUseCase`** - Search movies by title with real-time results
- **`GetMovieDetailsUseCase`** - Get comprehensive movie information
- **`GetMovieCreditsUseCase`** - Fetch cast, crew, and production details
- **`GetMovieVideosUseCase`** - Get trailers, teasers, and behind-the-scenes

---

## 🌟 Advanced Features

### ⚡ Performance Optimizations

- **🖼️ Smart Image Caching**: Efficient loading with `cached_network_image`
- **✨ Shimmer Loading**: Beautiful skeleton screens during data loading
- **🔄 Debounced Search**: Optimized search with intelligent debouncing
- **📱 Lazy Loading**: Load content only when needed
- **🗜️ Memory Management**: Proper disposal of controllers and resources

### 🎨 User Experience Features

- **📐 Responsive Design**: Adaptive layouts for phones, tablets, and foldables
- **🎭 Smooth Animations**: Fluid transitions with custom curve animations  
- **❌ Error Handling**: Comprehensive error states with retry options
- **⬇️ Pull-to-Refresh**: Intuitive gesture-based content refresh
- **🎪 Hero Animations**: Seamless navigation between screens

### 🔒 Security & Reliability

- **🌐 Network Security**: Configured network security for API calls
- **🛡️ Input Validation**: Sanitized user inputs and API responses
- **🔄 State Persistence**: Reliable state management with GetX
- **📊 Error Boundaries**: Robust error handling at all levels

---

## 🎮 How to Use the App

### 🏠 Home Screen Navigation

1. **🎪 Hero Slider**: 
   - Auto-scrolling showcase of trending movies
   - Tap any movie for detailed information
   - Swipe manually to browse different movies

2. **📋 Movie Categories**:
   - **Now Playing**: Movies currently in theaters
   - **Top Rated**: Highest-rated movies of all time
   - **Upcoming**: Movies releasing soon

3. **🔍 Quick Search**: 
   - Tap the search icon in the app bar
   - Access advanced search functionality

### 🔍 Search Functionality

1. **⚡ Instant Search**:
   - Type movie name for real-time results
   - See suggestions as you type
   - Tap any suggestion for quick access

2. **📚 Search History**:
   - View your recent searches
   - Tap any previous search to repeat
   - Clear history when needed

3. **🎯 Popular Suggestions**:
   - Discover trending search terms
   - Explore popular movie categories
   - Find new movies to watch

### 🎬 Movie Details Experience

1. **📊 Comprehensive Information**:
   - Movie rating and review scores
   - Release date and runtime
   - Genre tags and movie overview

2. **👥 Cast & Crew Details**:
   - View complete cast with photos
   - Director and producer information
   - Tap any actor for their filmography

3. **🎥 Media Content**:
   - Watch official trailers
   - Behind-the-scenes content
   - Movie posters and screenshots

---

## 🔮 Future Enhancements

### 🆕 Planned Features

- [ ] **❤️ Favorites System**: Save and organize favorite movies
- [ ] **⭐ User Reviews**: Rate movies and write personal reviews
- [ ] **📤 Social Sharing**: Share movies on social media platforms
- [ ] **🔔 Push Notifications**: Get notified about new releases
- [ ] **🌙 Theme Switching**: Toggle between dark and light themes
- [ ] **🌍 Multi-language**: Support for multiple languages
- [ ] **📱 Watch Lists**: Create custom movie watch lists
- [ ] **🎮 Movie Quiz**: Interactive movie trivia games

### 🛠️ Technical Roadmap

- [ ] **🗄️ Local Database**: SQLite integration for offline access
- [ ] **🧪 Testing Suite**: Unit, widget, and integration tests
- [ ] **🔄 CI/CD Pipeline**: Automated building and deployment
- [ ] **📊 Analytics**: Firebase Analytics and Crashlytics
- [ ] **🎯 Performance**: Advanced performance monitoring
- [ ] **♿ Accessibility**: Enhanced accessibility features

---

## 🤝 Contributing

We welcome contributions from the community! Here's how you can help make MoviX even better:

### 🐛 Reporting Bugs

1. **🔍 Check Existing Issues**: Search for similar issues first
2. **📝 Create Detailed Report**: Include steps to reproduce
3. **📸 Add Screenshots**: Visual aids help understand the problem
4. **🏷️ Add Labels**: Help categorize the issue properly

### ✨ Suggesting Features

1. **💡 Feature Request**: Use the feature request template
2. **📋 Explain Use Case**: Describe why this feature is needed
3. **🎨 Provide Mockups**: Visual examples are always helpful
4. **💬 Community Discussion**: Engage with other contributors

### 🔧 Code Contributions

1. **🍴 Fork the Repository**: Create your own copy
2. **🌿 Create Feature Branch**: `git checkout -b feature/amazing-feature`
3. **✅ Write Quality Code**: Follow Flutter best practices
4. **🧪 Add Tests**: Ensure your code is well-tested
5. **📝 Document Changes**: Update relevant documentation
6. **🚀 Submit Pull Request**: Create a detailed PR description

### 📏 Coding Standards

- Follow [Flutter Style Guide](https://flutter.dev/docs/development/tools/formatting)
- Use meaningful variable and function names
- Add comments for complex logic
- Maintain consistent code formatting
- Write comprehensive documentation

---

## 📄 License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for complete details.

```
MIT License

Copyright (c) 2024 MoviX App

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction...
```

---

## 👨‍💻 Developer

<div align="center">
  
<img src="https://readme-typing-svg.herokuapp.com?font=Orbitron&weight=700&size=24&pause=1000&color=8B5CF6&background=0A0B1E&center=true&vCenter=true&width=600&lines=Built+with+%E2%9D%A4%EF%B8%8F+using+Flutter;Clean+Architecture+%26+Modern+Design;Powered+by+TMDB+API" alt="Typing SVG" />

### 🌟 **Flutter Developer & UI/UX Enthusiast**

📧 **Email**: your.email@example.com  
🐱 **GitHub**: [@your-username](https://github.com/your-username)  
💼 **LinkedIn**: [Your Professional Profile](https://linkedin.com/in/your-profile)  
🐦 **Twitter**: [@your_handle](https://twitter.com/your_handle)  
🌐 **Portfolio**: [your-portfolio.com](https://your-portfolio.com)

---

### ⭐ **If you found this project helpful, please give it a star!**

<a href="https://github.com/your-username/movix-flutter-app">
  <img src="https://img.shields.io/github/stars/your-username/movix-flutter-app?style=social" alt="GitHub stars">
</a>

</div>

---

## 🙏 Acknowledgments & Credits

<div align="center">

### 🎬 **Special Thanks To:**

**[The Movie Database (TMDB)](https://www.themoviedb.org/)**  
*For providing comprehensive movie data and beautiful poster images*

**[Flutter Team](https://flutter.dev/)**  
*For creating this amazing cross-platform framework*  

**[Google Fonts](https://fonts.google.com/)**  
*For the beautiful typography that makes our app shine*

**[GetX Community](https://pub.dev/packages/get)**  
*For the powerful state management solution*

**[Open Source Community](https://opensource.org/)**  
*For continuous inspiration and collaborative spirit*

---

### 🌟 **Built with these amazing tools:**

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Android Studio](https://img.shields.io/badge/Android%20Studio-3DDC84?style=for-the-badge&logo=android-studio&logoColor=white)
![VS Code](https://img.shields.io/badge/VS%20Code-007ACC?style=for-the-badge&logo=visual-studio-code&logoColor=white)
![Git](https://img.shields.io/badge/Git-F05032?style=for-the-badge&logo=git&logoColor=white)

</div>

---

<div align="center">
  
<img src="assets/images/neon_logo.png" alt="MoviX Neon Logo" width="100" height="100">

### 🎭 **MoviX - Where Movies Come to Life!** 🎭

<img src="https://readme-typing-svg.herokuapp.com?font=Orbitron&weight=600&size=16&pause=1000&color=06B6D4&background=0A0B1E&center=true&vCenter=true&width=500&lines=Discover+%E2%80%A2+Explore+%E2%80%A2+Enjoy;Your+Ultimate+Movie+Companion;Built+with+Flutter+%26+Love" alt="Typing SVG" />

---

**🌟 Made with ❤️ by the Flutter Community**

<sub>© 2024 MoviX App. All rights reserved.</sub>

</div>
