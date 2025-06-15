
/*

  Database Provider

    This provider is to separate the Firestore data handling and the UI of our app.

    - The database service class handles data to and from the Firebase.
    - The database provider class processes the data to display in our app.

    This is use to make the code more modular, cleaner, and easier to read and test.

    ( It can also be use if we decided to change our backend (Firebase -> to mySQL, etc. )
    It is much easier to manage and switch out different databases.

*/