# My-List Todo Application

## Overview
My-List is designed to be a versatile and user-friendly tool for managing tasks. It is compatible with a wide range of operating systems, including **macOS**, **iOS**, **Android**, **Windows**, and **Linux**.

## Features
- **Cross-Platform Compatibility**: Access your tasks from any device, be it a smartphone, tablet, or computer.
- **Firebase Firestore Integration**: Reliably store and manage your tasks in the cloud.
- **Google and Email Authentication**: Securely sign in using your Google account or email.

## How to Use
Feel free to use the live web application by visiting: [My-List](https://my-list-dcc10.firebaseapp.com/)

## Getting Started

### Prerequisites
To get started with the development or to run the project locally, ensure you have the following installed:
- Flutter SDK
- Dart SDK
- A suitable IDE (e.g., Android Studio, Visual Studio Code)

### Installation
1. Clone the repository:
    ```bash
    git clone https://github.com/dumbun/my-list.git
    ```
2. Navigate to the project directory:
    ```bash
    cd my-list
    ```
3. Install the required dependencies:
    ```bash
    flutter pub get
    ```

### Configuration
1. Set up your Firebase project and Firestore database.
2. Update the Firebase configuration in your project with your project's credentials. This typically involves updating the `google-services.json` file for Android and `GoogleService-Info.plist` for iOS.

### Running the Application
To start the application on your device or emulator, run:
```bash
flutter run
```

### Building for Production
To build the application for production, use the following commands:

#### Android
```bash
flutter build apk
```
#### iOS
```bash
flutter build ios
```
#### Web
```bash
flutter build web
```

## Deployment
To deploy the web application, follow the standard Firebase deployment process:
1. Install the Firebase CLI if you haven't already:
    ```bash
    npm install -g firebase-tools
    ```
2. Initialize Firebase in your project directory:
    ```bash
    firebase init
    ```
3. Deploy the application:
    ```bash
    firebase deploy
    ```

## Technologies Used
- **Flutter**: For building the cross-platform user interface.
- **Firebase Firestore**: For database management.
- **Firebase Authentication**: For user authentication.

## Contributing
We welcome contributions! Please follow these steps to contribute:
1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Commit your changes (`git commit -m 'Add new feature'`).
4. Push to the branch (`git push origin feature-branch`).
5. Open a pull request.

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contact
If you have any questions or feedback, feel free to contact us at [vamsikrishna2644@gmail.com](mailto:vamsikrishna2644@gmail.com).

Enjoy using My-List and happy task managing!
