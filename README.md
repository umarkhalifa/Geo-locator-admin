# land_survey

Geo Nav
This is a Flutter project template built using Clean Architecture principles. Clean Architecture is an architectural approach that promotes separation of concerns, making your codebase more maintainable, testable, and scalable.

Project Structure
The project is structured into different layers to maintain a clear separation of concerns:

presentation: This layer contains the user interface components, such as screens, widgets, and view models. It is responsible for rendering data and handling user interactions.

domain: The domain layer contains the business logic and use cases of the application. It defines the core functionality of the app and is independent of any specific UI framework.

data: This layer deals with data sources, such as APIs or databases. It provides implementations for repositories and data sources used by the domain layer.

core: The core layer holds shared code and utilities that can be used across different parts of the application. It should not depend on any other layer.

Features
- [x] Location Services
- [x] Coordinates Conversion
- [x] Authentication
- [x] Marking Sites
- [ ] Navigation

Plugins
For this project you have to add two plugins:

firebase_core: Required for initializing Firebase and using any other Firebase plugins.
firebase_auth: For using Firebase Authentication service in Flutter.
cloud_firestore: CRUD firebase operations
google_maps: For using google maps
hooks_riverpod: State management
The latest version of both these plugins support null safety.
Getting Started
Usage
If you want to try out the this sample app, first you have to create and configure a Firebase project:

Clone the project:

https://github.com/umarkhalifa/land-survey.git
If you want to contribute to this project, instead of the above command -- fork this project and then clone using:

https://github.com/<your-user-id>/land-survey.git
Create a new Firebase project from the console.

Configure the Firebase for each platform.

Run the app using the command:

cd flutterfire-samples
flutter run

# Geo Nav
# Abstract
Land surveying is a discipline that demands unparalleled precision and versatility. GeoNav Pro is a ground-breaking application meticulously designed to meet the specific needs of land surveyors. This app serves as an indispensable tool for professionals in the field, revolutionizing the way surveys are conducted, data is managed, and locations are mapped.

# Introduction
Precision, efficiency, and agility are the pillars of success in the ever-changing world of land surveying. Enter GeoNav Pro, a game-changing program precisely designed to meet the unique needs of land surveyors. This new tool emerges as a critical companion for field professionals, altering how surveys are done, data is handled, and locations are mapped.
Land surveying, a very precise process, demands a tool that embraces modern improvements. ¬¬¬¬ Pro addresses this need by meeting the different needs of surveyors who labor hard to draw boundaries, designate control points, and determine azimuth orientations.
The value of precise mapping and location-based technologies cannot be stressed as metropolitan areas grow and distant places entice investigation. GeoNav Pro acknowledges this need and provides a solution.

# Objectives
The primary objectives of the GeoNav app include:
-	GeoNav Pro has a variety of map viewing modes, ranging from traditional topographical maps to satellite images and even 3D landscape models. Get the most up-to-date mapping data for your surveying project, assuring precision and context.
-	Location Services: Use the app's powerful location services to locate your precise coordinates with pinpoint precision. GeoNav Pro guarantees that your position is always known, whether you're doing boundary surveys, topographic mapping, or building planning.
-	Marking sites: Mark survey sites, control points, or boundary markers right on your map with ease. This tool makes fieldwork easier by allowing you to swiftly record vital data while also ensuring the consistency and accuracy of your surveys.
-	Compass and Distance Measurement: GeoNav Pro has a powerful compass tool that not only shows you the distance but also the direction.
-	Authentication System: Our strong authentication system prioritizes data security. Protect your survey data and make sure that only authorized people may access or change sensitive information.
-	Device Database Integration: Save and access your survey data on your device without requiring ongoing internet connectivity. The database connectivity in GeoNav Pro allows you to manage your survey information even in remote locations.
-	Convert between multiple coordinate systems with ease, improving survey data administration and compatibility with other tools and systems.
-	Search by Coordinates: Locate precise coordinates quickly, making it simple to cross-reference data or properly identify critical survey locations.

# Problem Statement
Accuracy, efficiency, and adaptability are the pillars of success in land surveying. Surveyors are responsible for charting borders, setting control points, and determining azimuth directions, all of which need the use of accurate instruments and dependable technology. Traditional surveying methods, on the other hand, frequently struggle to keep up with the demands of current surveying activities, which range from urban growth to distant exploration.
Existing equipment and technology are sometimes insufficient to provide the precision and efficiency required for land surveyors to flourish in their profession. Outdated mapping technologies, time-consuming data management systems, and restricted location-based services might result in mistakes, greater time investment, and data inconsistencies, eventually impeding land surveyors' Furthermore, there is a need for safe and efficient data sharing across organizations.

# User Interface/ User Experience
![Screenshot_20230907-182736](https://github.com/umarkhalifa/land-survey/assets/112028682/2ef814ee-8d47-4999-9421-ef020ec5ed97)
![Screenshot_20230907-182626](https://github.com/umarkhalifa/land-survey/assets/112028682/ff587f9f-9485-4ee5-9e8a-472ae14abf8a)
![Screenshot_20230907-182622](https://github.com/umarkhalifa/land-survey/assets/112028682/cf4d76f7-0cac-404a-9a1a-e7a69c166fd5)
![Screenshot_20230907-182618](https://github.com/umarkhalifa/land-survey/assets/112028682/5f841fc8-eb39-4cc6-89da-e86d129f3446)
![Screenshot_20230907-182614](https://github.com/umarkhalifa/land-survey/assets/112028682/d261806b-b7e8-4b42-98c1-b81eb855439d)
![Screenshot_20230907-182608](https://github.com/umarkhalifa/land-survey/assets/112028682/3e979b80-cc32-4725-a4d2-6042d173fb3f)

 


# Components
**Programming Language: Dart (Flutter)**

Dart: Dart is a modern, object-oriented programming language developed by Google. It is the primary language used in Flutter app development. Dart is known for its simplicity, high performance, and strong support for asynchronous programming, making it well-suited for creating responsive and efficient mobile applications like GeoNav Pro.

**Flutter**: Flutter is an open-source UI software development framework created by Google. It is built using the Dart programming language and is specifically designed for developing cross-platform mobile applications with a single codebase. Flutter's key features include a rich set of customizable widgets, a hot reload feature for quick code changes and updates, and a vibrant community that contributes to a growing collection of plugins and packages. This framework will enable you to create a consistent and visually appealing user interface for GeoNav Pro on both iOS and Android platforms
Maps and Location Services: Google Maps API

**Google Maps API**: Google Maps API is a powerful and widely-used set of tools and services that provide access to the rich mapping and location-based data offered by Google. By integrating Google Maps API into GeoNav Pro, you can leverage features such as map rendering, geocoding (converting addresses to coordinates), reverse geocoding (converting coordinates to addresses), location tracking, and distance calculations. This API ensures that the app can deliver precise and reliable mapping and location-based services to land surveyors, meeting the high standards of accuracy required in the field.
Development Tools: Visual Studio Code, Git

**Visual Studio Code**: Visual Studio Code (VS Code) is a lightweight, open-source code editor developed by Microsoft. It has become one of the most popular choices among developers due to its extensibility, integrated debugging capabilities, and support for various programming languages. In the context of GeoNav Pro, VS Code provides a powerful development environment for writing Dart code, Flutter widgets, and managing project files efficiently. It also supports a wide range of extensions and plugins, enhancing productivity and code quality.

**Git**: Git is a distributed version control system that is essential for collaborative software development. It allows multiple developers to work on the same codebase simultaneously, keeping track of changes, merging code, and maintaining a history of project revisions. Git ensures that the development of GeoNav Pro remains organized and enables you to collaborate effectively with team members or contributors.

**Firebase**: Firebase is a comprehensive mobile and web application development platform provided by Google. It offers various services, including real-time databases, authentication, cloud storage, and more. Integrating Firebase into GeoNav Pro provides several benefits:
-Real-time Database: Firebase Realtime Database allows you to store and synchronize data in real-time across all connected devices. This is particularly useful for GeoNav Pro as it enables seamless collaboration among multiple    surveyors or users working on the same project. Any changes made to the database are immediately reflected across all devices, ensuring everyone has access to the latest survey data.
-Authentication: Firebase Authentication offers secure user authentication methods, helping you implement a robust user authentication system in GeoNav Pro. You can control access to sensitive survey data and features, ensuring that only authorized users can modify or view specific information.

**Hive for Local Storage:**

Hive: Hive is a lightweight, fast, and efficient NoSQL database designed specifically for local storage in Flutter applications. Here's how Hive enhances the functionality of GeoNav Pro:
-Local Data Storage: Hive provides a high-performance key-value store that allows GeoNav Pro to store critical data locally on the user's device. This includes cached map data, user preferences, and offline survey records. By utilizing Hive, the app can continue functioning even without an internet connection, making it reliable for land surveyors working in remote or offline environments.
-Efficient Data Access: Hive's performance optimizations make it a suitable choice for applications that require quick data retrieval. In GeoNav Pro, this translates to faster access to locally stored survey data, reducing latency and enhancing the user experience.
User Interface and User Experience

# Conclusion
Precision, efficiency, and versatility are not just desirable qualities in the field of land surveying; they are the basic basis upon which precise results and successful projects are constructed. In the effort to redefine borders and map new frontiers, the GeoNav Pro app emerges as a groundbreaking tool, precisely created to fulfill the special needs of land surveyors.
As we've seen in this detailed overview, GeoNav Pro employs cutting-edge technology to deliver an all-encompassing solution for land surveying experts. The app provides a smooth cross-platform experience by leveraging the power of Dart and Flutter, guaranteeing surveyors can execute their tasks with precision on both iOS and Android devices. This capability is enhanced by the incorporation of the Google Maps API, which provides a rich collection of mapping and location-based services critical for surveying accuracy.
GeoNav Pro's features and functionality, which include multi-mode maps and location services, point marking, compass-based distance and bearing calculations, and secure data management, have been methodically designed to meet the different needs of land surveyors. These capabilities enable surveyors to map metropolitan landscapes, explore isolated regions, and work in a variety of surveying conditions with remarkable precision and speed. 
Furthermore, the app uses Firebase for real-time database storage and authentication, allowing surveyors and project stakeholders to collaborate seamlessly and securely. Hive, as a local storage option, ensures the app's dependability. Surveyors can continue working without interruption in offline or low-connectivity circumstances.
To summarize, GeoNav Pro is a game changer in the world of land surveying. It enables professionals to confidently handle the intricacies of modern surveying tasks, producing exact findings while improving productivity and teamwork. GeoNav Pro exemplifies the land surveying community's commitment to quality by embracing cutting-edge technology and a user-centric approach.
Land surveyors may rely on GeoNav Pro as the ultimate companion as they redefine borders and map new vistas, ensuring that precision and efficiency remain their guiding principles. GeoNav Pro is present in every survey they conduct, allowing them to realize the full potential of their profession and redefine What is conceivable in the field of land surveying.


