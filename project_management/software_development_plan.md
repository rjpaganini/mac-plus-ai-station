# Software Development Plan

*Last Updated: July 23rd, 2025*

## UI Design Considerations for Child-Friendly Interface

### Visual Design
- **Large, Simple Elements**: Oversized buttons and controls for easy interaction
- **High Contrast Colors**: Clear visual distinction between interactive elements
- **Limited Options**: Present only a few choices at once to avoid overwhelming
- **Consistent Layout**: Maintain the same basic structure across all screens
- **Visual Feedback**: Clear indication when buttons are pressed or actions occur
- **Animations**: Gentle, non-distracting animations to indicate transitions

### Interaction Design
- **Touch-First**: Optimize for touchscreen as primary input method
- **Controller Support**: Map 8BitDo controller buttons to simple navigation and actions
- **Error Prevention**: Design to minimize possibility of errors
- **Forgiving Interface**: Easy to return to home screen or previous state
- **Audio Feedback**: Sounds to confirm actions and provide feedback
- **No Text Input Required**: Use icons, images, and voice where possible

## Technology Stack

### Operating System
- **Ubuntu 24.04.2 LTS (Noble Numbat)**:
  - Installed on Beelink SER8 (nvme0n1)
  - Default app selections and third-party drivers
  - No disk encryption
  - Sleep and screen lock behavior modified (no password on wake)
  - Active Directory integration and telemetry disabled

### UI Framework Options

#### Option 1: Web Technologies
- **Electron.js**: For creating the desktop application
  - Allows web technologies to be used for desktop app
  - Cross-platform compatibility
  - Easy integration with system APIs

#### Option 2: Python-based UI
- **Tkinter**: Standard Python UI toolkit
  - Simple, lightweight, included with Python
  - Good for basic interfaces
- **PyQT/PySide**: More advanced UI framework
  - Rich component library
  - Modern look and feel
  - Better performance for complex UIs
- **Kivy**: Touch-focused Python framework
  - Designed for multi-touch applications
  - Cross-platform support
  - Good for interactive applications

### Frontend Technologies
- **HTML/CSS/JavaScript**: Base technologies
- **React**: For component-based UI development
  - Reusable components
  - State management
  - Virtual DOM for performance
- **Styled Components**: For component-specific styling
- **Framer Motion**: For smooth animations and transitions

### Backend/Integration
- **Node.js**: For backend processes and API integration
- **Electron IPC**: For communication between renderer and main processes
- **node-hid**: For gamepad/controller input
- **Electron Store**: For persistent configuration storage

## Development Environment Setup

### System Configuration
- **Host Computer**: Beelink SER8 (tinopaganini)
  - IP Address: 192.0.2.10
  - SSH access configured with public key authentication
  - No password required on wake, screen stays active for long sessions

### Development Workflow
- **Primary Development Machine**: MacBook Pro (username: rjpaganini)
- **Code Editing**: Visual Studio Code with Remote-SSH extension
- **File Transfer**: SSH (scp, rsync) or Git
- **Remote Access**: SSH configured for passwordless login

### Required Software
- **On Development Machine**:
  - Visual Studio Code with Remote-SSH extension
  - SSH client
  - Git
  
- **On Target System (Beelink)**:
  - Node.js (if using Electron/web technologies)
  - Python (if using Python-based UI)
  - VS Code Server (for Remote-SSH development)
  - Git

### Project Structure
```
tinos-ui/
├── package.json
├── electron/
│   ├── main.js           # Main Electron process
│   ├── preload.js        # Preload script for secure IPC
│   └── menu.js           # Application menu configuration
├── src/
│   ├── index.js          # Entry point for React
│   ├── App.js            # Main React component
│   ├── components/       # UI components
│   │   ├── Clock/
│   │   ├── Weather/
│   │   ├── MusicPlayer/
│   │   └── Navigation/
│   ├── hooks/            # Custom React hooks
│   ├── contexts/         # React contexts for state management
│   ├── services/         # API services and integrations
│   └── assets/           # Images, sounds, and other assets
├── public/
│   └── index.html        # HTML template
└── config/               # Build and configuration files
```

## External APIs and Resources

### Weather API
- **Options**:
  - OpenWeatherMap
  - WeatherAPI.com
  - National Weather Service (free)
- **Required Data**:
  - Current conditions
  - Simple forecast (sunny, rainy, etc.)
  - Temperature
- **Implementation Notes**:
  - Cache data to reduce API calls
  - Use location from system or hardcoded home location
  - Simple, icon-based representation

### Music Player
- **Local Option**:
  - Store MP3 files locally in designated directory
  - Use HTML5 Audio API or howler.js for playback
  - Simple playlist management
- **Streaming Option**:
  - TIDAL integration via webview or API
  - Spotify Web Playback SDK
  - YouTube Music (if preferred)
- **Implementation Notes**:
  - Create simple, large controls (play, pause, next, previous)
  - Album art display
  - Volume control mapped to controller

### Voice Input (Future)
- **Options**:
  - Web Speech API (basic, requires internet)
  - Whisper.cpp (local, offline capable)
- **Implementation Notes**:
  - Simple command recognition
  - Feedback when voice is detected
  - Visual indication of listening state

## Kiosk Mode Implementation

### Electron Configuration (if using web technologies)
```javascript
// Example main.js configuration for kiosk mode
const mainWindow = new BrowserWindow({
  width: 1280,
  height: 800,
  kiosk: true,  // Full screen mode
  autoHideMenuBar: true,
  frame: false,  // No window frame
  webPreferences: {
    nodeIntegration: false,
    contextIsolation: true,
    preload: path.join(__dirname, 'preload.js')
  }
});

// Prevent new windows from opening
app.on('web-contents-created', (event, contents) => {
  contents.on('new-window', (event, navigationUrl) => {
    event.preventDefault();
  });
});

// Auto-launch on startup
const AutoLaunch = require('auto-launch');
const appAutoLauncher = new AutoLaunch({
  name: 'TinosComputer',
  path: app.getPath('exe'),
});
appAutoLauncher.enable();
```

### Python Autostart (if using Python-based UI)
```bash
# Example .xprofile or systemd service for autostarting Python UI
python3 /path/to/tinos_ui.py
```

### Ubuntu-specific Lockdown
- Auto-login to dedicated user account
- Autostart application via systemd or .xprofile
- Disable screen lock and password requirements (already configured)
- Configure lightweight window manager if needed

## Controller Integration

### 8BitDo Ultimate 2C Mapping
- **D-pad**: Navigation between main UI elements
- **A Button**: Select/Confirm
- **B Button**: Back/Cancel
- **X Button**: Home screen
- **Y Button**: Context-specific action
- **L1/R1**: Previous/Next item in lists
- **L2/R2**: Volume down/up
- **Start**: Play/Pause media
- **Select**: Toggle between app sections

### Implementation
```javascript
// Example controller detection and mapping
const { HID } = require('node-hid');

// Find 8BitDo controller
const devices = HID.devices();
const controller = devices.find(d => 
  d.vendorId === 11720 && d.productId === 24576
);

if (controller) {
  const gamepad = new HID.HID(controller.path);
  
  gamepad.on('data', data => {
    // Map button presses to UI actions
    // Example mapping logic
  });
}
```

## Testing Strategy

### Usability Testing
- **Child Testing**: Observe Tino using the interface
- **Metrics**: Time to complete tasks, error rate, engagement level
- **Adjustments**: Iterate based on observations

### Technical Testing
- **Performance**: Ensure smooth animations and transitions
- **Stability**: Test for crashes and memory leaks
- **Offline Functionality**: Ensure core features work without internet
- **Power Management**: Test sleep/wake behavior

## Deployment

### Build Process
- Use electron-builder for packaging
- Create auto-updater for future updates (if needed)
- Script for restoring to known-good state

### Installation
- Auto-start configuration
- Environment variable setup
- Local data storage initialization

## Next Development Tasks

1. **Development Environment Setup**:
   - Install VS Code Server or configure Remote-SSH for development from Mac
   - Set up version control and file synchronization

2. **UI Framework Selection and Setup**:
   - Evaluate and select between web technologies and Python-based UI
   - Set up basic project structure and dependencies

3. **Core Module Development**:
   - Create music player module (local MP3 + Tidal integration)
   - Develop weather widget with API integration
   - Build calendar/day information display

4. **System Integration**:
   - Configure touchscreen rotation, calibration, and interaction zones
   - Set up autostart via systemd or .xprofile
   - Implement controller input mapping

5. **Kiosk Mode Implementation**:
   - Configure lightweight window manager if needed
   - Set up restricted environment for child use

## Resources and References

- [Electron Documentation](https://www.electronjs.org/docs)
- [React Documentation](https://reactjs.org/docs)
- [Python Tkinter Documentation](https://docs.python.org/3/library/tkinter.html)
- [PyQT Documentation](https://www.riverbankcomputing.com/static/Docs/PyQt5/)
- [Kivy Documentation](https://kivy.org/doc/stable/)
- [Child UI Design Guidelines](https://www.nngroup.com/articles/childrens-websites-usability-issues/)
- [8BitDo Controller Documentation](https://support.8bitdo.com/)
- [Ubuntu 24.04 Documentation](https://help.ubuntu.com/)
- [VS Code Remote Development](https://code.visualstudio.com/docs/remote/remote-overview)
