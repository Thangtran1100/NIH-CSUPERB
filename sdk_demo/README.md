# sdk_demo

A new Flutter project.

## Getting Started

# Project Structure
lib/                                    #The main directory
│
├── models/                             #Contains the data model class definitions (user).
│   └── user.dart                       #Defines the user model.
│
├── screens/                            #Contains the UI screens of the application.
│   ├── authenticate/                   #Contains the screens related to user authentication.
│   │   ├── authenticate.dart           #Handle the logic to decide whether to show the sign-in or registration screen.
│   │   ├── register.dart               #The screen that allows a new user to register.
│   │   └── sign_in.dart                #The screen that allows a user to sign in.
│   │
│   ├── home/                           #Contains screens that the user interacts with after authentication.
│   │   ├── drives.dart                 #Screen that shows a history of drives or trips.
│   │   ├── home.dart                   #The main dashboard screen after the user logs in.
│   │   └── profile.dart                #The user profile screen.
│   │
│   └── wrapper.dart                    #Handles the logic of displaying
│
└── services/                           #Contains the services that handle business logic and interactions with APIs.
    ├── auth.dart                       #Service that probably handles authentication logic.
    ├── telematics_service.dart         #Service that interacts with a telematics API.
    └── UnifiedAuthService.dart         #Service that unifies different authentication mechanisms.
│
└── main.dart                           #The entry point of the Flutter application, which sets up the app environment and launches the first scree (wrapper.dart).
