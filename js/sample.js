// Import Firebase auth functions
import { registerUser, loginUser } from './firebaseauth.js';

// Show Sign In Form
function showSignIn(event) {
    if (event) event.preventDefault(); // Prevent default anchor behavior
    const signInForm = document.getElementById('signInForm');
    const signUpForm = document.getElementById('signUpForm');
    if (signInForm && signUpForm) {
        signInForm.style.display = 'block';
        signUpForm.style.display = 'none';
        clearErrors();
        console.log('Switched to Sign In form');
    } else {
        console.error('Form elements not found:', { signInForm, signUpForm });
    }
}

// Show Sign Up Form
function showSignUp(event) {
    if (event) event.preventDefault(); // Prevent default anchor behavior
    const signInForm = document.getElementById('signInForm');
    const signUpForm = document.getElementById('signUpForm');
    if (signInForm && signUpForm) {
        signInForm.style.display = 'none';
        signUpForm.style.display = 'block';
        clearErrors();
        console.log('Switched to Sign Up form'); // Debug log
    } else {
        console.error('Form elements not found:', { signInForm, signUpForm });
    }
}

function clearErrors() {
    const errors = document.querySelectorAll('.error');
    errors.forEach(error => error.style.display = 'none');
}

function validateEmail(email) {
    const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return re.test(email);
}

async function handleSignIn() {
    const email = document.getElementById('signInEmail').value;
    const password = document.getElementById('signInPassword').value;
    let valid = true;

    if (!validateEmail(email)) {
        document.getElementById('signInEmailError').style.display = 'block';
        valid = false;
    }
    if (!password) {
        document.getElementById('signInPasswordError').style.display = 'block';
        valid = false;
    }

    if (valid) {
        try {
            await loginUser(email, password);
            alert('Sign-in successful!');
            window.location.href = 'dashboard.html'; // Redirect to dashboard
        } catch (error) {
            console.error('Login failed:', error.message);
            if (error.code === 'auth/user-not-found' || error.code === 'auth/wrong-password') {
                document.getElementById('signInEmailError').style.display = 'block';
                document.getElementById('signInPasswordError').style.display = 'block';
            }
        }
    }
}

async function handleSignUp() {
    const name = document.getElementById('signUpName').value;
    const email = document.getElementById('signUpEmail').value;
    const password = document.getElementById('signUpPassword').value;
    let valid = true;

    if (!name) {
        document.getElementById('signUpNameError').style.display = 'block';
        valid = false;
    }
    if (!validateEmail(email)) {
        document.getElementById('signUpEmailError').style.display = 'block';
        valid = false;
    }
    if (password.length < 6) {
        document.getElementById('signUpPasswordError').style.display = 'block';
        valid = false;
    }

    if (valid) {
        try {
            await registerUser(email, password);
            alert('Sign-up successful!');
            window.location.href = 'dashboard.html'; // Redirect to dashboard
        } catch (error) {
            console.error('Sign-up failed:', error.message);
            if (error.code === 'auth/email-already-in-use') {
                document.getElementById('signUpEmailError').style.display = 'block';
            } else if (error.code === 'auth/weak-password') {
                document.getElementById('signUpPasswordError').style.display = 'block';
            }
        }
    }
}

// Initial load
window.addEventListener('load', () => {
    showSignIn(); // Ensure sign-in form is shown on load
    console.log('Page loaded, initial form set to Sign In');
});

// Expose functions globally for HTML onclick events
window.showSignIn = showSignIn;
window.showSignUp = showSignUp;
window.handleSignIn = handleSignIn;
window.handleSignUp = handleSignUp;