# Loupang Eats - Multilingual & Allergy-Sensitive Food Delivery App
### Live Demo
https://youtu.be/qjtAtooVffc

[loupang_eats.pdf](https://github.com/user-attachments/files/16738657/loupang_eats.pdf)
![1](https://github.com/user-attachments/assets/6894120a-4e4b-414b-801f-5fef93e4ea4e)


## Overview

**Loupang Eats** is an advanced food delivery platform engineered to bridge language gaps and cater to the dietary needs of international users in Korea. Built with Flutter, our app integrates multilingual support, automatic allergen detection, and real-time currency conversion to enhance user experience and safety.

## Key Features

- **Multilingual Menu Translation**: Leverages dynamic localization to translate restaurant menus into the user's preferred language, ensuring clear and accurate comprehension.
- **Automated Food Restriction Filtering**: Utilizes a robust algorithm to identify and prioritize dishes that meet user-defined dietary restrictions, reducing the risk of allergic reactions.
- **Real-time Currency Conversion**: Implements a currency conversion API to provide accurate pricing in the user's local currency, updated in real-time.

## Tech Stack

- **Frontend**: [Flutter](https://flutter.dev/) - A cross-platform framework that enables the development of a seamless and responsive UI for both iOS and Android.
- **Backend**: [Dart](https://dart.dev/) - The core language for Flutter, providing the necessary performance and flexibility for managing app logic.
- **Localization**: Custom-built localization engine with support for multiple languages including English, Korean, Chinese, and Japanese.
- **API Integration**: Integration with external APIs for currency conversion and real-time data fetching.
- **State Management**: Provider/Bloc pattern for efficient state management across the application.

## Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Dart SDK](https://dart.dev/get-dart)
- A configured iOS/Android development environment ([Guide](https://flutter.dev/docs/get-started/editor))

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/diatomicC/loupang-eats.git
   ```
2. Navigate to the project directory:
   ```bash
   cd zzk
   ```
2a. Switch to the latest branch:
   ```
   git switch main2
   ```
3. Install the dependencies:
   ```bash
   flutter pub get
   ```
4. Run the app on an emulator or a physical device:
   ```bash
   flutter run
   ```

## Architecture Overview

Loupang Eats follows a **Modular Architecture**:

- **Core Module**: Manages global configurations, API clients, and shared utilities.
- **UI Module**: Contains all the UI components, following a component-based architecture with reusable widgets.
- **Logic Module**: Houses the business logic and state management layers, including services for localization, allergy detection, and currency conversion.
- **Data Module**: Handles data models, repository patterns, and API integrations.

### Key Components

- **Localization Service**: A custom service that loads translations dynamically based on user settings, falling back to English when necessary.
- **Allergy Detection Engine**: An algorithm that cross-references user dietary restrictions with menu items, automatically filtering out unsafe options.
- **Currency Conversion API**: Real-time integration with a currency conversion API to reflect up-to-date prices based on current exchange rates.

## Usage

### Onboarding Process

1. **Welcome Screen**: Users define their language preferences and dietary restrictions.
2. **Menu Browsing**: The app automatically translates the menu and filters items according to the user's restrictions.
3. **Order Placement**: Users can view prices in their local currency and place orders seamlessly.

### Demo

Experience our app with the following demo:

1. [Live Demo](https://youtu.be/qjtAtooVffc)


### Development Workflow

- **Feature Branching**: Each feature should be developed in its own branch, following the `feature/your-feature-name` naming convention.
- **Code Reviews**: All pull requests are subject to code review to ensure code quality and consistency.
- **Continuous Integration**: We use GitHub Actions for continuous integration and automated testing.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
