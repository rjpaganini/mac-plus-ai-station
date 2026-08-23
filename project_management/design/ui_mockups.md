# UI Design Mockups and Wireframes

*Last Updated: July 17th, 2025*

## Design Principles for Child-Friendly Interface

### Visual Design Principles
1. **Simplicity**: Minimize visual complexity and cognitive load
2. **Clarity**: Clear visual hierarchy and obvious interactive elements
3. **Consistency**: Maintain consistent patterns throughout the interface
4. **Engagement**: Use playful elements without being distracting
5. **Accessibility**: Large touch targets, high contrast, clear visuals

### Interaction Design Principles
1. **Forgiving**: Easy to recover from mistakes
2. **Immediate Feedback**: Clear response to all interactions
3. **Limited Choices**: Present only a few options at once
4. **Guided Exploration**: Intuitive navigation with clear paths
5. **Multi-Input**: Support for both touch and controller input

## Color Scheme

### Primary Colors
- **Background**: Soft blue (#E6F2FF) - Calm, non-distracting base
- **Primary Elements**: Bright blue (#4285F4) - Clear, engaging interactive elements
- **Secondary Elements**: Teal (#34A853) - Complementary color for variety
- **Accents**: 
  - Yellow (#FBBC05) - Attention, highlights
  - Red (#EA4335) - Important actions or alerts
  - Purple (#9C27B0) - Special features or rewards

### Color Usage Guidelines
- Use high contrast between text and backgrounds (minimum 4.5:1 ratio)
- Limit color palette to avoid overwhelming
- Use color consistently to indicate similar functions
- Provide additional cues beyond color (icons, shapes) for accessibility

## Typography

- **Primary Font**: Comic Neue or similar rounded, friendly font
- **Sizes**:
  - Very Large (48px+): Main titles, time display
  - Large (36px): Section headers, main navigation
  - Medium (24px): Labels, secondary information
  - Small (18px): Only for non-critical information
- **Weight**: Primarily medium to bold for better visibility
- **Case**: Mixed case for better readability (not all caps)

## Home Screen Mockup

```
+------------------------------------------------------+
|                                                      |
|  +------------------+      +---------------------+   |
|  |                  |      |                     |   |
|  |  12:30           |      |       SUNNY         |   |
|  |  MONDAY          |      |       72°           |   |
|  |                  |      |                     |   |
|  +------------------+      +---------------------+   |
|                                                      |
|  +------------------+      +---------------------+   |
|  |                  |      |                     |   |
|  |     MUSIC        |      |      STORIES        |   |
|  |    [ICON]        |      |      [ICON]         |   |
|  |                  |      |                     |   |
|  +------------------+      +---------------------+   |
|                                                      |
|  +------------------+      +---------------------+   |
|  |                  |      |                     |   |
|  |     GAMES        |      |      SETTINGS       |   |
|  |    [ICON]        |      |      [ICON]         |   |
|  |                  |      |                     |   |
|  +------------------+      +---------------------+   |
|                                                      |
+------------------------------------------------------+
```

### Home Screen Elements
- **Clock/Date**: Large, prominent display of current time and day
- **Weather**: Current conditions with simple icon and temperature
- **Main Navigation**: Four large, equally-sized buttons for primary functions
- **Icons**: Simple, recognizable symbols for each function
- **Layout**: Grid layout with ample spacing between elements

## Music Player Mockup

```
+------------------------------------------------------+
|                                                      |
|  +------------------+                                |
|  |                  |                                |
|  |    HOME          |                                |
|  |    [ICON]        |                                |
|  |                  |                                |
|  +------------------+                                |
|                                                      |
|  +------------------------------------------------+  |
|  |                                                |  |
|  |                 ALBUM ART                      |  |
|  |                                                |  |
|  |                                                |  |
|  |                                                |  |
|  +------------------------------------------------+  |
|                                                      |
|  +------------------------------------------------+  |
|  |                                                |  |
|  |              SONG TITLE                        |  |
|  |                                                |  |
|  +------------------------------------------------+  |
|                                                      |
|  +-----+      +-----+      +-----+      +-----+     |
|  |     |      |     |      |     |      |     |     |
|  | <<  |      |  ▶  |      | ||  |      |  >> |     |
|  |     |      |     |      |     |      |     |     |
|  +-----+      +-----+      +-----+      +-----+     |
|                                                      |
+------------------------------------------------------+
```

### Music Player Elements
- **Home Button**: Easy return to main screen
- **Album Art**: Large, central display of current song's album art
- **Song Title**: Clear display of current track
- **Playback Controls**: Large, well-spaced buttons for:
  - Previous track
  - Play
  - Pause
  - Next track
- **Volume Control**: Mapped to controller buttons (not shown on screen)

## Weather Screen Mockup

```
+------------------------------------------------------+
|                                                      |
|  +------------------+                                |
|  |                  |                                |
|  |    HOME          |                                |
|  |    [ICON]        |                                |
|  |                  |                                |
|  +------------------+                                |
|                                                      |
|  +------------------------------------------------+  |
|  |                                                |  |
|  |                  SUNNY                         |  |
|  |                 [ICON]                         |  |
|  |                                                |  |
|  |                   72°                          |  |
|  |                                                |  |
|  +------------------------------------------------+  |
|                                                      |
|  +--------+  +--------+  +--------+  +--------+     |
|  |        |  |        |  |        |  |        |     |
|  | TODAY  |  |  TUE   |  |  WED   |  |  THU   |     |
|  | [ICON] |  | [ICON] |  | [ICON] |  | [ICON] |     |
|  |  72°   |  |  68°   |  |  70°   |  |  65°   |     |
|  |        |  |        |  |        |  |        |     |
|  +--------+  +--------+  +--------+  +--------+     |
|                                                      |
+------------------------------------------------------+
```

### Weather Screen Elements
- **Home Button**: Easy return to main screen
- **Current Weather**: Large icon and temperature
- **Forecast**: Simple 4-day forecast with:
  - Day name
  - Weather icon
  - Temperature
- **Simplified Information**: Focus on visual representation rather than detailed data

## Stories Screen Mockup

```
+------------------------------------------------------+
|                                                      |
|  +------------------+                                |
|  |                  |                                |
|  |    HOME          |                                |
|  |    [ICON]        |                                |
|  |                  |                                |
|  +------------------+                                |
|                                                      |
|  +--------+  +--------+  +--------+  +--------+     |
|  |        |  |        |  |        |  |        |     |
|  | STORY  |  | STORY  |  | STORY  |  | STORY  |     |
|  |   1    |  |   2    |  |   3    |  |   4    |     |
|  | [ICON] |  | [ICON] |  | [ICON] |  | [ICON] |     |
|  |        |  |        |  |        |  |        |     |
|  +--------+  +--------+  +--------+  +--------+     |
|                                                      |
|  +--------+  +--------+  +--------+  +--------+     |
|  |        |  |        |  |        |  |        |     |
|  | STORY  |  | STORY  |  | STORY  |  | STORY  |     |
|  |   5    |  |   6    |  |   7    |  |   8    |     |
|  | [ICON] |  | [ICON] |  | [ICON] |  | [ICON] |     |
|  |        |  |        |  |        |  |        |     |
|  +--------+  +--------+  +--------+  +--------+     |
|                                                      |
+------------------------------------------------------+
```

### Stories Screen Elements
- **Home Button**: Easy return to main screen
- **Story Selection**: Grid of large buttons with:
  - Simple numbering or title
  - Representative icon or image
  - Equal sizing and spacing
- **Navigation**: Scrolling not required, limited to visible options

## Settings Screen Mockup (Parent Access)

```
+------------------------------------------------------+
|                                                      |
|  +------------------+                                |
|  |                  |                                |
|  |    HOME          |                                |
|  |    [ICON]        |                                |
|  |                  |                                |
|  +------------------+                                |
|                                                      |
|  +------------------------------------------------+  |
|  |                                                |  |
|  |  PARENT PIN: [____]                            |  |
|  |                                                |  |
|  +------------------------------------------------+  |
|                                                      |
|  +-----+  +-----+  +-----+                          |
|  |     |  |     |  |     |                          |
|  |  1  |  |  2  |  |  3  |                          |
|  |     |  |     |  |     |                          |
|  +-----+  +-----+  +-----+                          |
|                                                      |
|  +-----+  +-----+  +-----+                          |
|  |     |  |     |  |     |                          |
|  |  4  |  |  5  |  |  6  |                          |
|  |     |  |     |  |     |                          |
|  +-----+  +-----+  +-----+                          |
|                                                      |
|  +-----+  +-----+  +-----+                          |
|  |     |  |     |  |     |                          |
|  |  7  |  |  8  |  |  9  |                          |
|  |     |  |     |  |     |                          |
|  +-----+  +-----+  +-----+                          |
|                                                      |
|           +-----+                                    |
|           |     |                                    |
|           |  0  |                                    |
|           |     |                                    |
|           +-----+                                    |
|                                                      |
+------------------------------------------------------+
```

### Settings Screen Elements
- **Home Button**: Easy return to main screen
- **PIN Entry**: Simple numeric entry for parent access
- **Numeric Keypad**: Large, well-spaced buttons
- **Purpose**: Gate to prevent child access to advanced settings

## Navigation Flow

```
                  +-------------+
                  |             |
                  | HOME SCREEN |
                  |             |
                  +------+------+
                         |
           +-------------+-------------+-------------+
           |             |             |             |
+----------v---+ +-------v-----+ +-----v-------+ +---v-----------+
|              | |             | |             | |               |
| MUSIC PLAYER | |   WEATHER   | |   STORIES   | | SETTINGS (PIN)|
|              | |             | |             | |               |
+----------+---+ +-------+-----+ +-----+-------+ +---+-----------+
           |             |             |             |
           |             |             |             |
+----------v---+ +-------v-----+ +-----v-------+ +---v-----------+
|              | |             | |             | |               |
| SONG DETAILS | | DAILY VIEW  | | STORY LIST  | | PARENT MENU   |
|              | |             | |             | |               |
+--------------+ +-------------+ +-----+-------+ +---------------+
                                      |
                               +-----v-------+
                               |             |
                               | STORY PLAYER|
                               |             |
                               +-------------+
```

## Controller Mapping Visualization

```
                   [Y]
                   Stories
                    
[X] Weather     [ANALOG]     [A] Select/Play
                   
                   [B]
                   Back/Home

[L1] Previous    [R1] Next
[L2] Vol Down    [R2] Vol Up

[SELECT] App Menu    [START] Play/Pause
```

## Touch Interaction Guidelines

1. **Tap**: Primary selection action
2. **Swipe**: Used only for simple navigation between related screens
3. **Long Press**: Not used (too complex for young children)
4. **Pinch/Zoom**: Not used (too complex for young children)
5. **Touch Targets**: Minimum 48×48dp with adequate spacing

## Animation Guidelines

1. **Transitions**: Simple slide or fade transitions between screens
2. **Feedback**: Subtle scale or color change on button press
3. **Loading**: Simple, engaging animations for loading states
4. **Duration**: Keep animations brief (300-500ms)
5. **Purpose**: Use animation to guide attention, not distract

## Implementation Notes

1. **Responsive Design**: UI should adapt to the 1280×800 display resolution
2. **Performance**: Optimize for smooth animations and transitions
3. **Offline First**: All critical UI elements should work without internet
4. **Error States**: Minimal, non-technical error messages with visual cues
5. **Testing**: Observe actual child interaction to refine design

## Next Steps for UI Design

1. Create higher-fidelity mockups with actual colors and icons
2. Develop interactive prototype for testing
3. Refine based on usability testing with Tino
4. Implement in Electron.js with React components
5. Iterate based on ongoing feedback
