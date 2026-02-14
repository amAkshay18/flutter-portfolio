# Portfolio Flutter Web Application

A modern, responsive personal portfolio website built with **Flutter Web**, featuring Clean Architecture and Riverpod for state management. This is a **Flutter Web Application** that runs in web browsers, compiled from Dart to JavaScript.

## What is Flutter Web?

Flutter Web allows you to build web applications using the same Flutter framework and Dart language used for mobile apps. When you run `flutter run -d chrome` or `flutter build web`, Flutter compiles your Dart code to JavaScript and serves it through a web browser.

### Why `index.html`?

The `web/index.html` file is the **entry point** for Flutter web applications. Just like traditional web apps need an HTML file, Flutter web apps use `index.html` to:
- Load the Flutter engine and compiled JavaScript
- Set up the base HTML structure
- Include meta tags for SEO, mobile support, and PWA features
- Link to assets like favicons, manifests, and external scripts

When Flutter builds for web, it generates JavaScript bundles that are loaded by this HTML file, allowing your Dart/Flutter code to run in any modern web browser.

## Features

- ✅ **Clean Architecture** (Domain, Data, Presentation layers)
- ✅ **Riverpod** for state management
- ✅ **Responsive design** (mobile, tablet, and desktop)
- ✅ **Dark/Light theme** support with Flutter's official dark blue theme
- ✅ **Fixed header** with smooth scroll navigation
- ✅ **Hero section** with profile picture and introduction
- ✅ **About section** with professional description
- ✅ **Projects section** with horizontal scrolling
  - Industry Projects and Personal Projects categories
- ✅ **Achievements section** with LeetCode badges (horizontal scroll)
- ✅ **Certifications section** with Udemy certificates (horizontal scroll - 11 certifications)
- ✅ **Contact form** with validation (name, email, message)
- ✅ **Social media links** (LinkedIn, GitHub, LeetCode, Instagram, Twitter, Email)
- ✅ **Preloader animation**
- ✅ **Mobile menu** navigation
- ✅ **Form validation** with proper keyboard types and character limits

## Project Structure

```
lib/
├── core/
│   ├── constants/
│   │   ├── app_constants.dart      # App-wide constants (URLs, personal info)
│   │   └── app_strings.dart        # All user-facing strings
│   └── theme/
│       └── app_theme.dart          # Theme configuration (colors, typography)
├── domain/
│   ├── entities/
│   │   ├── contact_form.dart       # Contact form entity
│   │   ├── project.dart            # Project entity
│   │   └── skill.dart              # Skill entity
│   └── repositories/
│       └── portfolio_repository.dart  # Repository interface
├── data/
│   ├── datasources/
│   │   ├── portfolio_local_data_source.dart    # Local data source
│   │   └── portfolio_remote_data_source.dart   # Remote data source
│   ├── models/
│   │   ├── project_model.dart      # Project data model
│   │   └── skill_model.dart        # Skill data model
│   └── repositories/
│       └── portfolio_repository_impl.dart  # Repository implementation
└── presentation/
    ├── providers/
    │   ├── navigation_provider.dart     # Navigation state management
    │   ├── portfolio_provider.dart      # Portfolio data providers
    │   └── theme_provider.dart          # Theme state management
    ├── screens/
    │   ├── about/
    │   │   └── about_section.dart       # About section
    │   ├── achievements/
    │   │   └── achievements_section.dart # Achievements (LeetCode badges)
    │   ├── certifications/
    │   │   └── certifications_section.dart # Certifications (Udemy)
    │   ├── contact/
    │   │   └── contact_section.dart     # Contact form & social links
    │   ├── home/
    │   │   ├── footer.dart              # Footer component
    │   │   ├── hero_section.dart        # Hero/intro section
    │   │   └── home_screen.dart         # Main screen
    │   └── projects/
    │       └── projects_section.dart    # Projects display
    └── widgets/
        ├── custom_button.dart           # Reusable button widget
        ├── header.dart                  # Navigation header
        ├── mobile_menu.dart             # Mobile navigation menu
        └── preloader.dart               # Loading animation
```

## Getting Started

### Prerequisites

- **Flutter SDK** (>=3.0.0)
- **Dart SDK** (>=3.0.0)
- A modern web browser (Chrome, Firefox, Safari, Edge)

### Installation

1. **Clone or navigate to the project directory:**
```bash
cd portfolio_flutter
```

2. **Install dependencies:**
```bash
flutter pub get
```

3. **Run the web application:**
```bash
# Run in Chrome (development mode with hot reload)
flutter run -d chrome

# Or build for production
flutter build web
# Then serve the build/web directory using any web server
```

### Building for Production

```bash
# Build optimized release version
flutter build web --release

# The output will be in build/web/
# You can deploy this to any static hosting service like:
# - GitHub Pages
# - Firebase Hosting
# - Netlify
# - Vercel
# - AWS S3 + CloudFront
```

## Web-Specific Configuration

### index.html

The `web/index.html` file serves as the entry point for the Flutter web app. It:
- Loads the Flutter engine (`flutter_bootstrap.js`)
- Sets up meta tags for SEO and mobile support
- Includes favicon and PWA manifest
- Can include external scripts (like Google Maps API if needed)

### manifest.json

Located in `web/manifest.json`, this file enables Progressive Web App (PWA) features, allowing users to install the portfolio as an app on their devices.

## Architecture

### Clean Architecture Layers

1. **Domain Layer**: Contains business logic entities and repository interfaces (pure Dart, no Flutter dependencies)
2. **Data Layer**: Implements repositories and handles data sources (local/remote data fetching)
3. **Presentation Layer**: UI components, providers, and screens (Flutter widgets)

### State Management

- **Riverpod**: Used for all state management
- **Providers**: 
  - `portfolioProvider`: Manages portfolio data (projects, skills)
  - `contactFormProvider`: Manages contact form state and submission
  - `navigationProvider`: Manages navigation state (mobile menu)
  - `themeProvider`: Manages theme mode (dark/light)

### Widget Architecture

All widgets use Riverpod's `ConsumerWidget` for reactive updates, avoiding `StatefulWidget` where possible for cleaner code.

## Customization

### Personal Information

Update your personal details in `lib/core/constants/app_constants.dart`:
- Name, email, phone
- Social media URLs
- Resume URL
- Contact form endpoint URL

### Projects

Add or modify projects in `lib/data/datasources/portfolio_local_data_source.dart`

### Theme

Customize colors, fonts, and styling in `lib/core/theme/app_theme.dart`

### Content

Update all user-facing strings in `lib/core/constants/app_strings.dart`

## Sections Overview

### Hero Section
- Profile picture
- Introduction text
- Professional title and description

### About Section
- Professional description about being a Flutter developer

### Projects Section
- **Industry Projects**: Professional work projects
- **Personal Projects**: Personal/portfolio projects
- Horizontal scrolling cards with project images and links

### Certifications Section
- 11 Udemy certificates
- Horizontal scrolling layout
- Each certificate includes title, description, and link

### Achievements Section
- 2 LeetCode badges
- Horizontal scrolling layout
- Links to LeetCode profile

### Contact Section
- Contact form with validation:
  - Name (letters and spaces only)
  - Email (valid email format)
  - Message (max 200 characters, required)
- Social media links with hover effects

## Contact Form

The contact form submits to a Google Apps Script endpoint. Update the URL in `lib/core/constants/app_constants.dart` (`contactFormUrl`) with your own endpoint.

## Browser Support

Flutter Web supports all modern browsers:
- ✅ Chrome/Edge (Chromium)
- ✅ Firefox
- ✅ Safari
- ✅ Opera

## Deployment

### GitHub Pages (Recommended - Free & Automatic)

This project includes automated deployment to GitHub Pages via GitHub Actions. 

**Quick Start:**
1. Enable GitHub Pages in your repository settings (Settings → Pages → Source: GitHub Actions)
2. Push your code to the `main` branch
3. The site will automatically deploy to: `https://<your-username>.github.io/portfolio_flutter/`
4. **Updates are automatic**: Every push triggers a new deployment (2-5 minutes)

**📖 For detailed deployment instructions, see [DEPLOYMENT.md](DEPLOYMENT.md)**

**Benefits:**
- ✅ **Free hosting** - No cost
- ✅ **Automatic deployments** - Updates go live within minutes of pushing code
- ✅ **Easy sharing** - One link to share with recruiters
- ✅ **No manual steps** - GitHub Actions handles everything

### Other Hosting Options

After building with `flutter build web`, you can also deploy the `build/web` directory to:

- **Firebase Hosting**: `firebase deploy`
- **Netlify**: Drag and drop `build/web` folder or connect GitHub repo
- **Vercel**: Connect GitHub repo or upload folder
- **AWS S3 + CloudFront**: Upload to S3 bucket and configure CloudFront

## Assets

The following assets are required:

- `assets/images/` - All portfolio images (projects, profile, etc.)
- `assets/fonts/` - Custom fonts (Recoleta)
- `web/favicon.png` - Website favicon
- `web/icons/` - PWA icons

## License

Copyright © 2025 | All Rights Reserved with Akshay Pulikkottil

---

**Built with Flutter Web** 💙 | **Clean Architecture** 🏗️ | **Riverpod** 🎯
