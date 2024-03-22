const modeToggle = document.getElementById('mode-toggle');
const modeIcon = document.getElementById('mode-icon');

// Check user's preferred mode from local storage
const preferredMode = localStorage.getItem('mode');

// Set initial mode based on user preference or default to light mode
if (preferredMode === 'dark') {
    document.body.classList.add('dark-mode');
}

// Toggle mode when the button is clicked
modeToggle.addEventListener('click', function() {
    document.body.classList.toggle('dark-mode');

    // Update local storage to reflect user's preference
    const currentMode = document.body.classList.contains('dark-mode') ? 'dark' : 'light';
    localStorage.setItem('mode', currentMode);

    // Update button icon based on current mode
    updateModeIcon();
});

// Function to update button icon based on current mode
function updateModeIcon() {
    if (document.body.classList.contains('dark-mode')) {
        modeIcon.innerHTML = '<i class="fas fa-moon"></i>'; // Moon icon
    } else {
        modeIcon.innerHTML = '<i class="fas fa-sun"></i>'; // Sun icon
    }
}

// Call the function initially to set the correct icon based on current mode
updateModeIcon();
