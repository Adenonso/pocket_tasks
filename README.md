//POCKET TASKS

//This app makes use of Hive Local Storage method for user data storage.
//The app is loaded from the main.dart file, which initializes the Hive box, registers the adapters and then loads then in HomeScreen page.

//The chosen state management approach is Provider. Tasks are stored in TaskDatabase.
 The Database file then handles the various TaskDatabase logic. 
 The TaskProvider file then handles in turn the Database functions.


//The MVVM architecture is used for this application.


//The HOME page displays the list of created tasks, with the option to sort them based on All Available, Active tasks, Completed tasks, Newest and Oldest tasks.

//When a task is tapped on, it displays the task details, which gives the user the option to set a due date, make additional notes.
//When a task is long tapped on, it pops up the delete task option

##TASK DETAILS SCREEN
//To select a due date, tap on the calendar icon.
//To add note, tap on the blank container space which pops up a dialog to inout the text.
//To edit note, long tap on the existing note.

//The taskdatabase has the sub-task option to be able to add list of subtasks (but was not used in this app)