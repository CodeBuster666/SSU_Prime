// Import Firebase auth functions
import { signUpUser, loginUser } from './firebaseauth.js';

function showSignIn() {
    console.log('showSignIn called');
    document.getElementById('signInForm').style.display = 'block';
    document.getElementById('signUpForm').style.display = 'none';
    document.getElementById('forgotPasswordForm').style.display = 'none';
    clearErrors();
}

function showSignUp() {
    console.log('showSignUp called');
    document.getElementById('signInForm').style.display = 'none';
    document.getElementById('signUpForm').style.display = 'block';
    document.getElementById('forgotPasswordForm').style.display = 'none';
    clearErrors();
}

function showForgotPassword() {
    console.log('showForgotPassword called');
    document.getElementById('signInForm').style.display = 'none';
    document.getElementById('signUpForm').style.display = 'none';
    document.getElementById('forgotPasswordForm').style.display = 'block';
    clearErrors();
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
        const result = await loginUser(email, password);
        if (result.success) {
            alert('Successfully logged in!');
            window.location.href = 'dashboard.html';
        } else {
            alert('Login failed: ' + result.error);
        }
    }
}

async function handleSignUp() {
    const email = document.getElementById('signUpEmail').value;
    const password = document.getElementById('signUpPassword').value;
    let valid = true;

    clearErrors();

    if (!validateEmail(email)) {
        document.getElementById('signUpEmailError').style.display = 'block';
        valid = false;
    }
    if (password.length < 6) {
        document.getElementById('signUpPasswordError').style.display = 'block';
        valid = false;
    }

    if (valid) {
        const result = await signUpUser(email, password);
        if (result.success) {
            alert("You've successfully signed up!");
            window.location.href = 'dashboard.html';
        } else {
            alert('Signup failed: ' + result.error);
        }
    }
}

function handleForgotPassword() {
    const email = document.getElementById('forgotEmail').value;
    if (!validateEmail(email)) {
        document.getElementById('forgotEmailError').style.display = 'block';
    } else {
        alert('Password reset email sent! (Demo)');
        showSignIn();
    }
}

// Add event listeners when DOM is loaded
document.addEventListener('DOMContentLoaded', () => {
    console.log('DOM loaded, adding event listeners');
    // Toggle links
    const signUpLink = document.querySelector('#signInForm .toggle-link a');
    if (signUpLink) {
        signUpLink.addEventListener('click', (e) => {
            e.preventDefault();
            showSignUp();
        });
    }
    const signInLink = document.querySelector('#signUpForm .toggle-link a');
    if (signInLink) {
        signInLink.addEventListener('click', (e) => {
            e.preventDefault();
            showSignIn();
        });
    }
    const forgotPasswordLink = document.querySelector('#signInForm .forgot-password a');
    if (forgotPasswordLink) {
        forgotPasswordLink.addEventListener('click', (e) => {
            e.preventDefault();
            showForgotPassword();
        });
    }
    const signInLinkForgot = document.querySelector('#forgotPasswordForm .toggle-link a');
    if (signInLinkForgot) {
        signInLinkForgot.addEventListener('click', (e) => {
            e.preventDefault();
            showSignIn();
        });
    }

    // Buttons
    const signInButton = document.querySelector('#signInForm button');
    if (signInButton) {
        signInButton.addEventListener('click', handleSignIn);
    }
    const signUpButton = document.querySelector('#signUpForm button');
    if (signUpButton) {
        signUpButton.addEventListener('click', handleSignUp);
    }
    const resetPasswordButton = document.querySelector('#forgotPasswordForm button');
    if (resetPasswordButton) {
        resetPasswordButton.addEventListener('click', handleForgotPassword);
    }
});

// Debug: Confirm script loaded
console.log('script.js loaded');