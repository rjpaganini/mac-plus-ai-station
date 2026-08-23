const { contextBridge, ipcRenderer } = require('electron');

// Expose protected methods that allow the renderer process to use
// the ipcRenderer without exposing the entire object
contextBridge.exposeInMainWorld(
  'api', {
    // Time and date functions
    getTime: () => ipcRenderer.invoke('get-time'),
    getDate: () => ipcRenderer.invoke('get-date'),
    
    // Data storage functions
    storeValue: (key, value) => ipcRenderer.invoke('store-value', key, value),
    getValue: (key) => ipcRenderer.invoke('get-value', key),
    
    // System information
    getSystemInfo: () => {
      return {
        platform: process.platform,
        arch: process.arch,
        version: process.version
      };
    },
    
    // Event listeners
    on: (channel, callback) => {
      // Whitelist channels
      const validChannels = ['time-update', 'system-event'];
      if (validChannels.includes(channel)) {
        // Deliberately strip event as it includes `sender` 
        ipcRenderer.on(channel, (event, ...args) => callback(...args));
      }
    },
    
    // Send events to main process
    send: (channel, data) => {
      // Whitelist channels
      const validChannels = ['user-action', 'app-event'];
      if (validChannels.includes(channel)) {
        ipcRenderer.send(channel, data);
      }
    }
  }
);

// Log when preload script has loaded
console.log('Preload script loaded');
