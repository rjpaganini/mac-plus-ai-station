#!/usr/bin/env python3

"""
Tino's Computer - Kivy UI
A child-friendly interface for Tino's Computer
"""

import os
import time
from datetime import datetime

from kivy.app import App
from kivy.clock import Clock
from kivy.core.window import Window
from kivy.uix.screenmanager import ScreenManager, Screen, SlideTransition
from kivy.uix.boxlayout import BoxLayout
from kivy.uix.gridlayout import GridLayout
from kivy.uix.button import Button
from kivy.uix.label import Label
from kivy.uix.image import Image
from kivy.uix.textinput import TextInput
from kivy.properties import StringProperty, ObjectProperty, BooleanProperty
from kivy.lang import Builder

# Set window size to match the touchscreen resolution
Window.size = (1280, 800)

# Load the KV file
Builder.load_file(os.path.join(os.path.dirname(__file__), 'tinos_computer.kv'))


class HomeScreen(Screen):
    """Home screen with clock and app buttons"""
    
    current_time = StringProperty('12:00')
    current_date = StringProperty('Monday')
    
    def __init__(self, **kwargs):
        super(HomeScreen, self).__init__(**kwargs)
        # Start the clock update
        Clock.schedule_interval(self.update_clock, 1)
        self.update_clock(0)
    
    def update_clock(self, dt):
        """Update the clock display"""
        self.current_time = datetime.now().strftime("%H:%M:%S")
        self.current_date = datetime.now().strftime("%A")


class MusicScreen(Screen):
    """Music player screen"""
    
    song_title = StringProperty('Song Title')
    artist_name = StringProperty('Artist')
    is_playing = BooleanProperty(False)
    
    def toggle_play(self):
        """Toggle play/pause state"""
        self.is_playing = not self.is_playing
        print(f"Music {'playing' if self.is_playing else 'paused'}")
    
    def previous_song(self):
        """Play previous song"""
        print("Previous song")
    
    def next_song(self):
        """Play next song"""
        print("Next song")


class StoriesScreen(Screen):
    """Stories screen"""
    
    def open_story(self, story_number):
        """Open a specific story"""
        print(f"Opening story {story_number}")


class GamesScreen(Screen):
    """Games screen"""
    
    def open_game(self, game_number):
        """Open a specific game"""
        print(f"Opening game {game_number}")


class SettingsScreen(Screen):
    """Settings screen with PIN entry"""
    
    pin_input = StringProperty('')
    admin_pin = '1234'  # Would be stored securely in a real app
    
    def add_digit(self, digit):
        """Add a digit to the PIN input"""
        if len(self.pin_input) < 4:
            self.pin_input += digit
    
    def clear_pin(self):
        """Clear the PIN input"""
        self.pin_input = ''
    
    def validate_pin(self):
        """Validate the entered PIN"""
        if self.pin_input == self.admin_pin:
            print("PIN correct! Admin access granted.")
            self.clear_pin()
            # Would show admin settings in a real app
        else:
            print("Incorrect PIN. Please try again.")
            self.clear_pin()


class TinosComputerApp(App):
    """Main application class"""
    
    def build(self):
        """Build the application"""
        # Create the screen manager
        sm = ScreenManager(transition=SlideTransition())
        
        # Add screens
        sm.add_widget(HomeScreen(name='home'))
        sm.add_widget(MusicScreen(name='music'))
        sm.add_widget(StoriesScreen(name='stories'))
        sm.add_widget(GamesScreen(name='games'))
        sm.add_widget(SettingsScreen(name='settings'))
        
        return sm


if __name__ == '__main__':
    TinosComputerApp().run()
