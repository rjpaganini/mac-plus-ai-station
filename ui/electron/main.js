const { app, BrowserWindow, ipcMain } = require('electron');
const path = require('path');
const Store = require('electron-store');

// Initialize persistent storage
const store = new Store();

// Keep a global reference of the window object to prevent garbage collection
let mainWindow;

function createWindow() {
  // Create the browser window
  mainWindow = new BrowserWindow({
    width: 1280,
    height: 800,
    kiosk: false, // Set to true for production kiosk mode
    autoHideMenuBar: true,
    frame: true, // Set to false for frameless window in production
    webPreferences: {
      nodeIntegration: false,
      contextIsolation: true,
      preload: path.join(__dirname, 'preload.js')
    }
  });

  // Load the index.html file
  mainWindow.loadFile('index.html');

  // Open DevTools in development mode
  // Comment out for production
  mainWindow.webContents.openDevTools();

  // Prevent new windows from opening
  mainWindow.webContents.setWindowOpenHandler(() => {
    return { action: 'deny' };
  });

  // Emitted when the window is closed
  mainWindow.on('closed', () => {
    // Dereference the window object
    mainWindow = null;
  });
}

// Create window when Electron has finished initialization
app.whenReady().then(() => {
  createWindow();

  app.on('activate', () => {
    // On macOS it's common to re-create a window when the dock icon is clicked
    if (mainWindow === null) createWindow();
  });
});

// Quit when all windows are closed, except on macOS
app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') app.quit();
});

// IPC handlers for renderer process communication
ipcMain.handle('get-time', () => {
  return new Date().toLocaleTimeString();
});

ipcMain.handle('get-date', () => {
  return new Date().toLocaleDateString();
});

// Example of storing and retrieving data
ipcMain.handle('store-value', (event, key, value) => {
  store.set(key, value);
  return true;
});

ipcMain.handle('get-value', (event, key) => {
  return store.get(key);
});

// Handle app ready to show
app.on('ready', () => {
  console.log('Tino\'s Computer UI is ready!');
});
