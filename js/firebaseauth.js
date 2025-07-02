// Import the functions you need from the SDKs you need
  import { initializeApp } from "https://www.gstatic.com/firebasejs/11.9.1/firebase-app.js";
  import { getAuth, createUserWithEmailAndPassword, signInWithEmailAndPassword } from "https://www.gstatic.com/firebasejs/11.9.1/firebase-auth.js";
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
const auth = getAuth(app);

// Registration function
//function signUpForm() {
  //  const email = document.getElementById('registerEmail').value;
  //  const password = document.getElementById('registerPassword').value;
  //  firebase.auth().createUserWithEmailAndPassword(email, password)
  //  .then((userCredential) => {
  //  console.log('User registered:', userCredential.user);
  //  })
  //  .catch((error) => {
  //  console.error('Error registering user:', error.message);
  //  });
//}

// Registration function
export function signUpUser(email, password) {
    return createUserWithEmailAndPassword(auth, email, password)
        .then((userCredential) => {
            console.log('User registered:', userCredential.user);
            return { success: true, user: userCredential.user };
        })
        .catch((error) => {
            console.error('Error registering user:', error.message);
            return { success: false, error: error.message };
        });
}

// Login function
export function loginUser(email, password) {
    return signInWithEmailAndPassword(auth, email, password)
        .then((userCredential) => {
            console.log('User logged in:', userCredential.user);
            return { success: true, user: userCredential.user };
        })
        .catch((error) => {
            console.error('Error logging in:', error.message);
            return { success: false, error: error.message };
        });
}

// Login function
//function loginUser() {
//const email = document.getElementById('loginEmail').value;
//const password = document.getElementById('loginPassword').value;
//firebase.auth().signInWithEmailAndPassword(email, password)
//.then((userCredential) => {
//console.log('User logged in:', userCredential.user);
//})
//.catch((error) => {
//console.error('Error logging in:', error.message);
//});
//}

// Debug: Confirm script loaded
console.log('firebaseauth.js loaded');