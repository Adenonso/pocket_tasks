# POCKET TASKS

## Table of Content:
1. Getting Started
2. Storage medium
3. Settings Page
4. App support system

## Getting Started (Overview)

The Pocket Task application is not just one of the many task planner applications on both the Play and App stores.

Integrating your Google Calender, alongside AI, endless possibilities are unlocked through the use of this application.

Pocket Tasks is designed for students, entrepreneurs, managers, basically all works of life.


- Brief description of the app
- problem it solves
- target users (e,g students and professionals)
- key value proposition

## Demo /Preview
- Posket Tasks Welcome Screen
  
 ![alt text](<WhatsApp Image 2026-05-08 at 3.54.09 PM.jpeg>)
 
- Side Panel Screen

 ![alt text](<WhatsApp Image 2026-05-08 at 3.54.08 PM.jpeg>)
-  GIFs or screen recording
  
  <video controls src="App ScreenRecord.mp4" title="Title"></video>
<!-- -  Link to live demo (If avaialble)  -->
-  APK download

## Features
Break into sub categories:
* Core features
  * task creation
  * task editing and deleting
  * task completion tracking
* advanced features
  * goal-based task grouping
  * notification and remainders
  * offline support (e.g hive storage)
  * dark mode
* UX features
  * Drag and drop
  * filtering/sorting
  * search functionality

## Tech stack
- Frontend
  
  This project was built using Flutter framework for the front-end.

- Backend and Databse: 
  
  Hive local storage is being utilized for the data storage.
- State Mangment.:
- API/services:

## Architecture 
- App arcjitecture pattern (MVC, MVVM etc)
  
  The MVVM architecture is used for this application
- folder structure explanation
- data flow overview
  
## Installation and Setup
Step-by-step instructions:
1. Pre-requisites
2. Steps
3. Environemnt Setup


//The taskdatabase has the sub-task option to be able to add list of subtasks (but was not used in this app)

## Installation & Setup

Step-by-step instructions:

Prerequisites
Flutter SDK version
IDE (VS Code / Android Studio)
Steps
```git clone <repo-link>
cd <project-folder>
flutter pub get
flutter run
```

Environment Setup
API keys (if any)
Firebase setup (if used)

## Usage Guide
How to create a task
How to create goals
How to mark tasks as complete
Navigation overview

## Project Structure

Example:

```markdown
lib/
 ┣ models/
 ┣ views/
 ┣ controllers/
 ┣ services/
 ┣ widgets/
```
Brief explanation of each folder

## State Management Logic
How state is handled
Why you chose that approach

//The chosen state management approach is Provider. Tasks are stored in TaskDatabase.
 The Database file then handles the various TaskDatabase logic. 
 The TaskProvider file then handles in turn the Database functions.

## Data Storage
How data is stored (Hive, local DB)
Schema / model structure
Persistence strategy

This app makes use of Hive Local Storage method for user data storage.
The app is loaded from the main.dart file, which initializes the Hive box, registers the adapters and then loads then in HomeScreen page.

## Screens & UI Breakdown
Home screen
Task detail screen
Goal screen
Settings screen


//The HOME page displays the list of created tasks, with the option to sort them based on All Available, Active tasks, Completed tasks, Newest and Oldest tasks.

//When a task is tapped on, it displays the task details, which gives the user the option to set a due date, make additional notes.
//When a task is long tapped on, it pops up the delete task option

##TASK DETAILS SCREEN
//To select a due date, tap on the calendar icon.
//To add note, tap on the blank container space which pops up a dialog to inout the text.
//To edit note, long tap on the existing note.


## Performance Considerations
Optimization techniques used
Lazy loading, caching, etc.

## Challenges & Solutions
Real problems faced during development
How you solved them

## Future Improvements / Roadmap
Cloud sync
Multi-device support
Collaboration features
AI-based task suggestions

## Testing
Unit tests
Widget tests
Manual testing approach

## Deployment
How to build APK / IPA
Publishing steps (Play Store, etc.)

## Contributing
Guidelines for contributors
Code style rules
Branching strategy

## License
MIT / Apache / etc.

## Author
Daniel Balogun

Portfolio / GitHub / LinkedIn

## Acknowledgements
Libraries used
Inspiration
Mentors or resources

## FAQ (Optional but powerful)
Common issues
Troubleshooting steps

## Contact
balogundaniel06@gmail.com
