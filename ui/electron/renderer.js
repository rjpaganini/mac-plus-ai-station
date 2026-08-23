// Tino's Computer - Renderer Process

// DOM Elements
const timeElement = document.getElementById('time');
const dateElement = document.getElementById('date');
const musicButton = document.getElementById('music-button');
const storiesButton = document.getElementById('stories-button');
const gamesButton = document.getElementById('games-button');
const settingsButton = document.getElementById('settings-button');
const backButtons = document.querySelectorAll('.back-button');
const musicPlayer = document.getElementById('music-player');
const storiesSection = document.getElementById('stories-section');
const gamesSection = document.getElementById('games-section');
const settingsSection = document.getElementById('settings-section');
const playButton = document.getElementById('play-button');
const pauseButton = document.getElementById('pause-button');
const prevButton = document.getElementById('prev-button');
const nextButton = document.getElementById('next-button');
const pinInput = document.getElementById('pin-input');
const numButtons = document.querySelectorAll('.num-button');

// Constants
const ADMIN_PIN = '1234'; // This would be stored securely in a real app

// Initialize the app
function initApp() {
    updateClock();
    setInterval(updateClock, 1000);
    addEventListeners();
    
    // Log system info
    console.log('System Info:', window.api.getSystemInfo());
}

// Update the clock display
async function updateClock() {
    try {
        const time = await window.api.getTime();
        const date = await window.api.getDate();
        
        timeElement.textContent = time;
        dateElement.textContent = new Date().toLocaleDateString('en-US', { weekday: 'long' });
    } catch (error) {
        console.error('Error updating clock:', error);
    }
}

// Add event listeners to UI elements
function addEventListeners() {
    // Main navigation buttons
    musicButton.addEventListener('click', () => showSection(musicPlayer));
    storiesButton.addEventListener('click', () => showSection(storiesSection));
    gamesButton.addEventListener('click', () => showSection(gamesSection));
    settingsButton.addEventListener('click', () => showSection(settingsSection));
    
    // Back buttons
    backButtons.forEach(button => {
        button.addEventListener('click', hideAllSections);
    });
    
    // Music player controls
    playButton.addEventListener('click', togglePlayPause);
    pauseButton.addEventListener('click', togglePlayPause);
    prevButton.addEventListener('click', playPreviousSong);
    nextButton.addEventListener('click', playNextSong);
    
    // Numpad buttons for PIN entry
    numButtons.forEach(button => {
        button.addEventListener('click', handleNumpadInput);
    });
}

// Show a specific section and hide others
function showSection(section) {
    hideAllSections();
    section.classList.remove('hidden');
}

// Hide all sections
function hideAllSections() {
    musicPlayer.classList.add('hidden');
    storiesSection.classList.add('hidden');
    gamesSection.classList.add('hidden');
    settingsSection.classList.add('hidden');
}

// Toggle play/pause in music player
function togglePlayPause() {
    playButton.classList.toggle('hidden');
    pauseButton.classList.toggle('hidden');
    
    // In a real app, this would control actual music playback
    console.log('Toggle play/pause');
}

// Play previous song
function playPreviousSong() {
    // In a real app, this would play the previous song
    console.log('Play previous song');
}

// Play next song
function playNextSong() {
    // In a real app, this would play the next song
    console.log('Play next song');
}

// Handle numpad input for PIN entry
function handleNumpadInput(event) {
    const button = event.currentTarget;
    
    if (button.classList.contains('clear')) {
        // Clear PIN input
        pinInput.value = '';
    } else if (button.classList.contains('enter')) {
        // Validate PIN
        validatePIN();
    } else {
        // Add digit to PIN (if not at max length)
        if (pinInput.value.length < 4) {
            pinInput.value += button.textContent;
        }
    }
}

// Validate the entered PIN
function validatePIN() {
    if (pinInput.value === ADMIN_PIN) {
        // PIN is correct - in a real app, this would show admin settings
        alert('PIN correct! Admin access granted.');
        pinInput.value = '';
    } else {
        // PIN is incorrect
        alert('Incorrect PIN. Please try again.');
        pinInput.value = '';
    }
}

// Handle gamepad/controller input
function setupGamepadSupport() {
    // This would be expanded in a real app to handle the 8BitDo controller
    window.addEventListener('gamepadconnected', (event) => {
        console.log('Gamepad connected:', event.gamepad);
    });
    
    window.addEventListener('gamepaddisconnected', (event) => {
        console.log('Gamepad disconnected:', event.gamepad);
    });
}

// Initialize the app when the DOM is loaded
document.addEventListener('DOMContentLoaded', initApp);
