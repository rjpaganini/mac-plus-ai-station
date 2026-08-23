# Meeting Notes and Decisions Log

*Last Updated: July 23rd, 2025*

## Purpose

This document tracks all project meetings, discussions, decisions, and action items related to Tino's Computer project. It serves as a historical record and reference for project decisions and evolution.

## Meeting Notes Template

```
## Meeting: [Title]

**Date**: [Date]
**Time**: [Start Time] - [End Time]
**Participants**: [Names]
**Location**: [Physical location or virtual platform]

### Agenda
1. [Item 1]
2. [Item 2]
3. [Item 3]

### Discussion Points
- [Topic 1]
  - [Details]
  - [Considerations]
- [Topic 2]
  - [Details]
  - [Considerations]

### Decisions Made
1. [Decision 1]
2. [Decision 2]

### Action Items
| Task | Responsible | Due Date | Status |
|------|-------------|----------|--------|
| [Task 1] | [Name] | [Date] | [Status] |
| [Task 2] | [Name] | [Date] | [Status] |

### Next Meeting
**Date**: [Date]
**Time**: [Time]
**Focus**: [Primary topics]
```

## Project Kickoff Meeting

**Date**: July 17th, 2025
**Time**: 10:00 AM - 11:30 AM
**Participants**: RJ (Project Lead)
**Location**: Home Office

### Agenda
1. Project overview and goals
2. Hardware component selection
3. Software approach
4. Timeline and milestones
5. Next steps

### Discussion Points
- **Project Vision**
  - Create a child-friendly computer for Tino using a vintage Macintosh Plus shell
  - Combine modern technology with classic aesthetic
  - Focus on simplicity, durability, and educational value
  - Include media playback, weather information, and potential for future expansion

- **Hardware Selection**
  - Beelink SER8 selected for its compact size and powerful specs
  - Waveshare 10.1" touchscreen fits well behind Mac Plus bezel
  - Custom acrylic bezel needed to mount display
  - 8BitDo controller provides simple, intuitive control method
  - USB speakers and microphone for audio I/O

- **Software Approach**
  - Windows 11 Pro or Ubuntu LTS as base OS
  - Custom Electron.js application for child-friendly UI
  - Kiosk mode to prevent access to system
  - Simple interface with large buttons and visual cues
  - Weather API integration for current conditions
  - Local media playback and possibly streaming services

- **Assembly Considerations**
  - Thermal management critical in enclosed space
  - Cable management will be challenging
  - Power distribution needs careful planning
  - Component mounting must be secure but allow for maintenance

- **Project Management**
  - Need comprehensive documentation for all aspects
  - Track hardware orders and deliveries
  - Document assembly process with photos
  - Create detailed software development plan

### Decisions Made
1. Proceed with Beelink SER8 and Waveshare 10.1" touchscreen as core components
2. Use custom-cut acrylic bezel from Ponoko.com for display mounting
3. Develop UI using Electron.js with React for component-based architecture
4. Implement kiosk mode with parental access via PIN
5. Create comprehensive project management documentation system
6. Focus on hardware acquisition and assembly first, then software development

### Action Items
| Task | Responsible | Due Date | Status |
|------|-------------|----------|--------|
| Create project management documentation structure | RJ | July 17, 2025 | Completed |
| Track ordered components and update delivery status | RJ | Ongoing | In Progress |
| Research kiosk mode implementation options | RJ | July 24, 2025 | Not Started |
| Create cardboard mockups for component placement | RJ | July 31, 2025 | Not Started |
| Set up development environment for UI | RJ | August 7, 2025 | Not Started |

### Next Meeting
**Date**: July 24th, 2025
**Time**: 10:00 AM
**Focus**: Hardware delivery status and assembly planning

## OS Installation and Hardware Progress Meeting

**Date**: July 23rd, 2025
**Time**: 9:00 AM - 10:00 AM
**Participants**: RJ (Project Lead)
**Location**: Home Office

### Agenda
1. Hardware delivery status
2. OS installation and configuration
3. Development environment setup
4. Power distribution strategy
5. Next steps

### Discussion Points
- **Hardware Status**
  - Beelink SER8 received and operational
  - Waveshare touchscreen and acrylic bezel (Order #1213021) still in transit
  - M3 standoff kits and mounting hardware ordered
  - Power distribution components ordered (6-port USB power strip, C14 inlet, C13 cable)
  - Speakers, mic, and controller added to Amazon cart

- **OS Installation**
  - Successfully installed Ubuntu 24.04.2 LTS (Noble Numbat) on Beelink SER8
  - Installed on nvme0n1 (one of two 1TB NVMe SSDs)
  - Selected default app selections and third-party drivers
  - No disk encryption for easier maintenance
  - Computer named "tinopaganini" with matching primary user account

- **System Configuration**
  - Modified sleep and screen lock behavior (no password on wake)
  - Screen configured to stay active for long sessions
  - Disabled Active Directory integration and telemetry
  - SSH configured with public key authentication
  - Current IP address: 192.0.2.10
  - Confirmed SSH access from MacBook Pro (username: rjpaganini)

- **Development Workflow**
  - All development will be authored on MacBook Pro using Visual Studio Code
  - Plan to use Remote-SSH VS Code extension for seamless development
  - File transfer via SSH (scp, rsync) or Git
  - Internet access and package installation working

- **Power Distribution Strategy**
  - Internal USB power will drive screen, mic, and speakers via 6-port USB power strip
  - Power strip will be hardwired to original Mac Plus rocker switch
  - Beelink will be powered via C14 inlet and blue C13 cable on same power rail

### Decisions Made
1. Use Ubuntu 24.04.2 LTS as the operating system (instead of Windows)
2. Implement VS Code Remote-SSH workflow for development
3. Use 6-port USB power strip for internal power distribution
4. Consider both web technologies (Electron.js) and Python-based UI frameworks (Tkinter/PyQT/Kivy)
5. Hardwire original Mac Plus rocker switch to control power

### Action Items
| Task | Responsible | Due Date | Status |
|------|-------------|----------|--------|
| Install VS Code Server or set up Remote SSH | RJ | July 25, 2025 | Not Started |
| Evaluate UI framework options | RJ | July 27, 2025 | Not Started |
| Build barebones UI prototype | RJ | July 31, 2025 | Not Started |
| Configure touchscreen when received | RJ | Upon delivery | Not Started |
| Complete Amazon order for peripherals | RJ | July 24, 2025 | Not Started |

### Next Meeting
**Date**: July 30th, 2025
**Time**: 10:00 AM
**Focus**: UI framework selection and development planning

## Hardware Planning Meeting

**Date**: [To be filled after meeting]
**Time**: [To be filled after meeting]
**Participants**: [To be filled after meeting]
**Location**: [To be filled after meeting]

### Agenda
1. Review hardware deliveries
2. Component testing results
3. Assembly plan and sequence
4. Tools and materials needed
5. Risk assessment

### Discussion Points
- [To be filled after meeting]

### Decisions Made
- [To be filled after meeting]

### Action Items
- [To be filled after meeting]

### Next Meeting
- [To be filled after meeting]

## Software Planning Meeting

**Date**: [To be filled after meeting]
**Time**: [To be filled after meeting]
**Participants**: [To be filled after meeting]
**Location**: [To be filled after meeting]

### Agenda
1. UI design review
2. Technology stack confirmation
3. Development environment setup
4. Feature prioritization
5. Testing approach

### Discussion Points
- [To be filled after meeting]

### Decisions Made
- [To be filled after meeting]

### Action Items
- [To be filled after meeting]

### Next Meeting
- [To be filled after meeting]

## Decision Log

| Date | Decision | Rationale | Impact |
|------|----------|-----------|--------|
| July 17, 2025 | Use Beelink SER8 as main computer | Compact size, powerful specs, good connectivity | Core hardware component, affects all other design decisions |
| July 17, 2025 | Use Waveshare 10.1" touchscreen | Fits Mac Plus bezel, good resolution, touch capability | Determines UI design constraints and user interaction model |
| July 17, 2025 | Create comprehensive project documentation | Ensure proper tracking and knowledge retention | Establishes project management framework |
| July 23, 2025 | Use Ubuntu 24.04.2 LTS as OS | Long-term support, community resources, better kiosk options | Defines software environment and development approach |
| July 23, 2025 | Use VS Code Remote-SSH for development | Seamless development experience, code on Mac, run on Beelink | Establishes development workflow |
| July 23, 2025 | Use 6-port USB power strip for internal power | Simplifies power distribution, uses original power switch | Defines power architecture |
| July 23, 2025 | Consider both web and Python UI frameworks | More options for child-friendly interface development | Opens additional technology options |

## Open Questions

| Date Added | Question | Status | Resolution Date | Resolution |
|------------|----------|--------|-----------------|------------|
| July 17, 2025 | Best approach for thermal management? | Open | | |
| July 17, 2025 | Single power supply or multiple? | Resolved | July 23, 2025 | Use 6-port USB power strip hardwired to original Mac Plus rocker switch |
| July 17, 2025 | Best weather API for simple display? | Open | | |
| July 17, 2025 | How to secure controller from damage? | Open | | |
| July 23, 2025 | Which UI framework to use (Electron vs Python)? | Open | | |
| July 23, 2025 | Best approach for touchscreen calibration? | Open | | |

## How to Use This Document

1. **Add Meeting Notes**: Create a new section for each meeting using the template
2. **Update Decision Log**: Add all significant decisions to the decision log table
3. **Track Open Questions**: Add questions as they arise, update when resolved
4. **Review Regularly**: Reference this document during project reviews
5. **Link to Other Documents**: Reference specific meeting notes in other project documents when relevant
