 // Import the functions you need from the SDKs you need
  import { initializeApp } from "https://www.gstatic.com/firebasejs/11.9.1/firebase-app.js";
  import { getAnalytics } from "https://www.gstatic.com/firebasejs/11.9.1/firebase-analytics.js";
  // TODO: Add SDKs for Firebase products that you want to use
  // https://firebase.google.com/docs/web/setup#available-libraries

  // Your web app's Firebase configuration
  // For Firebase JS SDK v7.20.0 and later, measurementId is optional
  const firebaseConfig = {
    apiKey: "AIzaSyArUhyPEOxrtCsH0Hjn8krYUnRSGqswo8w",
    authDomain: "ssu-primev2.firebaseapp.com",
    projectId: "ssu-primev2",
    storageBucket: "ssu-primev2.firebasestorage.app",
    messagingSenderId: "1066008620691",
    appId: "1:1066008620691:web:406ee033fab576011ba766",
    measurementId: "G-HQD7EP3FVM"
  };

  // Initialize Firebase
  const app = initializeApp(firebaseConfig);
  const analytics = getAnalytics(app);