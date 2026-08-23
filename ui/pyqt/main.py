#!/usr/bin/env python3

"""
Tino's Computer - PyQt5 UI
A child-friendly interface for Tino's Computer
"""

import sys
import os
import time
from datetime import datetime
from PyQt5.QtWidgets import (QApplication, QMainWindow, QWidget, QVBoxLayout, 
                            QHBoxLayout, QGridLayout, QPushButton, QLabel, 
                            QStackedWidget, QLineEdit, QFrame)
from PyQt5.QtCore import Qt, QTimer, QSize, pyqtSlot
from PyQt5.QtGui import QFont, QIcon, QColor

class MainWindow(QMainWindow):
    """Main window for Tino's Computer UI"""
    
    def __init__(self):
        super().__init__()
        
        # Set window properties
        self.setWindowTitle("Tino's Computer")
        self.setMinimumSize(1280, 800)
        
        # Initialize UI
        self.init_ui()
        
        # Start clock timer
        self.timer = QTimer(self)
        self.timer.timeout.connect(self.update_clock)
        self.timer.start(1000)  # Update every second
        
        # Initialize with home screen
        self.stacked_widget.setCurrentIndex(0)
        
        # Admin PIN
        self.admin_pin = "1234"  # Would be stored securely in a real app

    def init_ui(self):
        """Initialize the user interface"""
        
        # Create stacked widget for different screens
        self.stacked_widget = QStackedWidget()
        self.setCentralWidget(self.stacked_widget)
        
        # Create screens
        self.create_home_screen()
        self.create_music_screen()
        self.create_stories_screen()
        self.create_games_screen()
        self.create_settings_screen()
        
        # Set stylesheet for the entire application
        self.set_stylesheet()
        
    def create_home_screen(self):
        """Create the home screen with clock and app buttons"""
        
        home_widget = QWidget()
        layout = QVBoxLayout(home_widget)
        
        # Header with clock and weather
        header_frame = QFrame()
        header_frame.setObjectName("header")
        header_layout = QHBoxLayout(header_frame)
        
        # Clock container
        clock_widget = QWidget()
        clock_layout = QVBoxLayout(clock_widget)
        self.time_label = QLabel("12:00")
        self.time_label.setObjectName("time")
        self.date_label = QLabel("Monday")
        self.date_label.setObjectName("date")
        clock_layout.addWidget(self.time_label, alignment=Qt.AlignCenter)
        clock_layout.addWidget(self.date_label, alignment=Qt.AlignCenter)
        
        # Weather container
        weather_widget = QWidget()
        weather_layout = QVBoxLayout(weather_widget)
        weather_icon = QLabel("☀️")
        weather_icon.setObjectName("weather-icon")
        temperature = QLabel("72°")
        temperature.setObjectName("temperature")
        weather_layout.addWidget(weather_icon, alignment=Qt.AlignCenter)
        weather_layout.addWidget(temperature, alignment=Qt.AlignCenter)
        
        # Add clock and weather to header
        header_layout.addWidget(clock_widget)
        header_layout.addWidget(weather_widget)
        
        # App grid
        app_grid_widget = QWidget()
        app_grid = QGridLayout(app_grid_widget)
        app_grid.setSpacing(30)
        
        # Create app buttons
        self.music_btn = self.create_app_button("🎵", "Music", "music-button")
        self.stories_btn = self.create_app_button("📚", "Stories", "stories-button")
        self.games_btn = self.create_app_button("🎮", "Games", "games-button")
        self.settings_btn = self.create_app_button("⚙️", "Settings", "settings-button")
        
        # Connect button signals
        self.music_btn.clicked.connect(lambda: self.stacked_widget.setCurrentIndex(1))
        self.stories_btn.clicked.connect(lambda: self.stacked_widget.setCurrentIndex(2))
        self.games_btn.clicked.connect(lambda: self.stacked_widget.setCurrentIndex(3))
        self.settings_btn.clicked.connect(lambda: self.stacked_widget.setCurrentIndex(4))
        
        # Add buttons to grid
        app_grid.addWidget(self.music_btn, 0, 0)
        app_grid.addWidget(self.stories_btn, 0, 1)
        app_grid.addWidget(self.games_btn, 1, 0)
        app_grid.addWidget(self.settings_btn, 1, 1)
        
        # Add widgets to main layout
        layout.addWidget(header_frame)
        layout.addWidget(app_grid_widget, 1)  # 1 = stretch factor
        
        # Add to stacked widget
        self.stacked_widget.addWidget(home_widget)
        
    def create_music_screen(self):
        """Create the music player screen"""
        
        music_widget = QWidget()
        layout = QVBoxLayout(music_widget)
        
        # Header with back button
        header = QWidget()
        header_layout = QHBoxLayout(header)
        back_btn = QPushButton("← Back")
        back_btn.setObjectName("back-button")
        back_btn.clicked.connect(lambda: self.stacked_widget.setCurrentIndex(0))
        title = QLabel("Music Player")
        title.setObjectName("section-title")
        header_layout.addWidget(back_btn)
        header_layout.addWidget(title)
        header_layout.addStretch()
        
        # Music content
        content = QWidget()
        content_layout = QVBoxLayout(content)
        
        # Album art
        album_art = QLabel()
        album_art.setObjectName("album-art")
        album_art.setMinimumSize(300, 300)
        album_art.setAlignment(Qt.AlignCenter)
        album_art.setText("Album Art")
        
        # Song info
        song_info = QWidget()
        song_layout = QVBoxLayout(song_info)
        song_title = QLabel("Song Title")
        song_title.setObjectName("song-title")
        artist = QLabel("Artist")
        artist.setObjectName("artist")
        song_layout.addWidget(song_title, alignment=Qt.AlignCenter)
        song_layout.addWidget(artist, alignment=Qt.AlignCenter)
        
        # Player controls
        controls = QWidget()
        controls_layout = QHBoxLayout(controls)
        prev_btn = QPushButton("⏮️")
        play_btn = QPushButton("▶️")
        next_btn = QPushButton("⏭️")
        prev_btn.setObjectName("player-control")
        play_btn.setObjectName("player-control")
        next_btn.setObjectName("player-control")
        controls_layout.addWidget(prev_btn)
        controls_layout.addWidget(play_btn)
        controls_layout.addWidget(next_btn)
        
        # Add to content layout
        content_layout.addWidget(album_art, alignment=Qt.AlignCenter)
        content_layout.addWidget(song_info)
        content_layout.addWidget(controls)
        
        # Add to main layout
        layout.addWidget(header)
        layout.addWidget(content, 1)
        
        # Add to stacked widget
        self.stacked_widget.addWidget(music_widget)
        
    def create_stories_screen(self):
        """Create the stories screen"""
        
        stories_widget = QWidget()
        layout = QVBoxLayout(stories_widget)
        
        # Header with back button
        header = QWidget()
        header_layout = QHBoxLayout(header)
        back_btn = QPushButton("← Back")
        back_btn.setObjectName("back-button")
        back_btn.clicked.connect(lambda: self.stacked_widget.setCurrentIndex(0))
        title = QLabel("Stories")
        title.setObjectName("section-title")
        header_layout.addWidget(back_btn)
        header_layout.addWidget(title)
        header_layout.addStretch()
        
        # Stories grid
        stories_grid = QWidget()
        grid_layout = QGridLayout(stories_grid)
        grid_layout.setSpacing(20)
        
        # Create story items
        for i in range(4):
            story = QPushButton(f"Story {i+1}")
            story.setObjectName("story-item")
            story.setMinimumHeight(150)
            row, col = divmod(i, 2)
            grid_layout.addWidget(story, row, col)
        
        # Add to main layout
        layout.addWidget(header)
        layout.addWidget(stories_grid, 1)
        
        # Add to stacked widget
        self.stacked_widget.addWidget(stories_widget)
        
    def create_games_screen(self):
        """Create the games screen"""
        
        games_widget = QWidget()
        layout = QVBoxLayout(games_widget)
        
        # Header with back button
        header = QWidget()
        header_layout = QHBoxLayout(header)
        back_btn = QPushButton("← Back")
        back_btn.setObjectName("back-button")
        back_btn.clicked.connect(lambda: self.stacked_widget.setCurrentIndex(0))
        title = QLabel("Games")
        title.setObjectName("section-title")
        header_layout.addWidget(back_btn)
        header_layout.addWidget(title)
        header_layout.addStretch()
        
        # Games grid
        games_grid = QWidget()
        grid_layout = QGridLayout(games_grid)
        grid_layout.setSpacing(20)
        
        # Create game items
        for i in range(4):
            game = QPushButton(f"Game {i+1}")
            game.setObjectName("game-item")
            game.setMinimumHeight(150)
            row, col = divmod(i, 2)
            grid_layout.addWidget(game, row, col)
        
        # Add to main layout
        layout.addWidget(header)
        layout.addWidget(games_grid, 1)
        
        # Add to stacked widget
        self.stacked_widget.addWidget(games_widget)
        
    def create_settings_screen(self):
        """Create the settings screen with PIN entry"""
        
        settings_widget = QWidget()
        layout = QVBoxLayout(settings_widget)
        
        # Header with back button
        header = QWidget()
        header_layout = QHBoxLayout(header)
        back_btn = QPushButton("← Back")
        back_btn.setObjectName("back-button")
        back_btn.clicked.connect(lambda: self.stacked_widget.setCurrentIndex(0))
        title = QLabel("Settings")
        title.setObjectName("section-title")
        header_layout.addWidget(back_btn)
        header_layout.addWidget(title)
        header_layout.addStretch()
        
        # PIN entry
        pin_widget = QWidget()
        pin_layout = QVBoxLayout(pin_widget)
        
        pin_label = QLabel("Enter PIN to access settings")
        pin_label.setObjectName("pin-label")
        self.pin_input = QLineEdit()
        self.pin_input.setObjectName("pin-input")
        self.pin_input.setMaxLength(4)
        self.pin_input.setEchoMode(QLineEdit.Password)
        self.pin_input.setAlignment(Qt.AlignCenter)
        
        # Numpad
        numpad = QWidget()
        numpad_layout = QGridLayout(numpad)
        numpad_layout.setSpacing(10)
        
        # Create numpad buttons
        for i in range(9):
            num_btn = QPushButton(str(i + 1))
            num_btn.setObjectName("num-button")
            num_btn.setMinimumSize(60, 60)
            num_btn.clicked.connect(self.numpad_pressed)
            row, col = divmod(i, 3)
            numpad_layout.addWidget(num_btn, row, col)
        
        # Add 0, clear, and enter buttons
        clear_btn = QPushButton("C")
        clear_btn.setObjectName("num-button clear")
        clear_btn.setMinimumSize(60, 60)
        clear_btn.clicked.connect(lambda: self.pin_input.clear())
        
        zero_btn = QPushButton("0")
        zero_btn.setObjectName("num-button")
        zero_btn.setMinimumSize(60, 60)
        zero_btn.clicked.connect(self.numpad_pressed)
        
        enter_btn = QPushButton("✓")
        enter_btn.setObjectName("num-button enter")
        enter_btn.setMinimumSize(60, 60)
        enter_btn.clicked.connect(self.validate_pin)
        
        numpad_layout.addWidget(clear_btn, 3, 0)
        numpad_layout.addWidget(zero_btn, 3, 1)
        numpad_layout.addWidget(enter_btn, 3, 2)
        
        # Add to PIN layout
        pin_layout.addWidget(pin_label, alignment=Qt.AlignCenter)
        pin_layout.addWidget(self.pin_input, alignment=Qt.AlignCenter)
        pin_layout.addWidget(numpad, alignment=Qt.AlignCenter)
        pin_layout.addStretch()
        
        # Add to main layout
        layout.addWidget(header)
        layout.addWidget(pin_widget, 1, alignment=Qt.AlignCenter)
        
        # Add to stacked widget
        self.stacked_widget.addWidget(settings_widget)
    
    def create_app_button(self, icon_text, label_text, object_name):
        """Create an app button with icon and label"""
        
        button = QPushButton()
        button.setObjectName(object_name)
        button.setMinimumSize(200, 200)
        
        # Create layout for button content
        layout = QVBoxLayout(button)
        
        # Icon and label
        icon = QLabel(icon_text)
        icon.setObjectName("app-icon")
        label = QLabel(label_text)
        label.setObjectName("app-label")
        
        # Add to layout
        layout.addWidget(icon, alignment=Qt.AlignCenter)
        layout.addWidget(label, alignment=Qt.AlignCenter)
        
        return button
    
    def set_stylesheet(self):
        """Set the application stylesheet"""
        
        # Load stylesheet from file in a real app
        stylesheet = """
        /* Base styles */
        QMainWindow, QWidget {
            background-color: #E6F2FF;
            font-family: "Comic Sans MS", cursive, sans-serif;
        }
        
        /* Header */
        #header {
            background-color: rgba(255, 255, 255, 0.7);
            border-radius: 20px;
            padding: 10px;
        }
        
        /* Clock */
        #time {
            font-size: 48px;
            font-weight: bold;
            color: #4285F4;
        }
        
        #date {
            font-size: 24px;
            color: #34A853;
        }
        
        /* Weather */
        #weather-icon {
            font-size: 48px;
        }
        
        #temperature {
            font-size: 36px;
            font-weight: bold;
        }
        
        /* App buttons */
        QPushButton#music-button {
            background-color: #FFCDD2;
            border-radius: 20px;
        }
        
        QPushButton#stories-button {
            background-color: #C8E6C9;
            border-radius: 20px;
        }
        
        QPushButton#games-button {
            background-color: #BBDEFB;
            border-radius: 20px;
        }
        
        QPushButton#settings-button {
            background-color: #D1C4E9;
            border-radius: 20px;
        }
        
        /* App icons and labels */
        #app-icon {
            font-size: 64px;
        }
        
        #app-label {
            font-size: 24px;
            font-weight: bold;
        }
        
        /* Back button */
        #back-button {
            background-color: #4285F4;
            color: white;
            border: none;
            border-radius: 10px;
            padding: 10px 20px;
            font-size: 20px;
        }
        
        /* Section titles */
        #section-title {
            font-size: 36px;
            font-weight: bold;
        }
        
        /* Music player */
        #album-art {
            background-color: #ddd;
            border-radius: 10px;
        }
        
        #song-title {
            font-size: 28px;
            font-weight: bold;
        }
        
        #artist {
            font-size: 20px;
            color: #666;
        }
        
        #player-control {
            background: none;
            border: none;
            font-size: 48px;
        }
        
        /* Story and game items */
        #story-item, #game-item {
            background-color: white;
            border-radius: 15px;
            font-size: 24px;
            font-weight: bold;
        }
        
        /* PIN entry */
        #pin-label {
            font-size: 24px;
        }
        
        #pin-input {
            width: 200px;
            height: 60px;
            font-size: 36px;
            border: 2px solid #4285F4;
            border-radius: 10px;
            letter-spacing: 10px;
        }
        
        /* Numpad buttons */
        #num-button {
            background-color: white;
            border: 2px solid #4285F4;
            border-radius: 10px;
            font-size: 24px;
        }
        
        #num-button:hover {
            background-color: #E6F2FF;
        }
        
        #num-button.clear {
            background-color: #FBBC05;
        }
        
        #num-button.enter {
            background-color: #34A853;
            color: white;
        }
        """
        
        self.setStyleSheet(stylesheet)
    
    @pyqtSlot()
    def update_clock(self):
        """Update the clock display"""
        
        current_time = datetime.now().strftime("%H:%M:%S")
        current_day = datetime.now().strftime("%A")
        
        self.time_label.setText(current_time)
        self.date_label.setText(current_day)
    
    @pyqtSlot()
    def numpad_pressed(self):
        """Handle numpad button press"""
        
        button = self.sender()
        if len(self.pin_input.text()) < 4:
            self.pin_input.setText(self.pin_input.text() + button.text())
    
    @pyqtSlot()
    def validate_pin(self):
        """Validate the entered PIN"""
        
        if self.pin_input.text() == self.admin_pin:
            # PIN is correct - in a real app, this would show admin settings
            self.pin_input.clear()
            # Show admin settings (not implemented in this example)
            print("PIN correct! Admin access granted.")
        else:
            # PIN is incorrect
            self.pin_input.clear()
            print("Incorrect PIN. Please try again.")


def main():
    """Main application entry point"""
    
    app = QApplication(sys.argv)
    
    # Set application-wide font
    font = QFont("Comic Sans MS", 12)
    app.setFont(font)
    
    window = MainWindow()
    window.show()
    
    sys.exit(app.exec_())


if __name__ == "__main__":
    main()
