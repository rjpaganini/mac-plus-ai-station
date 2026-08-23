# Tino's Computer - Repository Structure

This repository contains the code and configuration for Tino's Computer, a child-friendly AI assistant and media station built inside a vintage Macintosh Plus shell.

## Repository Structure

- `/ui` - Frontend application code
  - Contains the user interface code (HTML/JS, Python Kivy, or PyQt)
  - UI components, styles, and assets specific to the interface

- `/scripts` - Utility scripts and tools
  - Bash scripts for setup and configuration
  - Maintenance and helper utilities
  - Installation scripts

- `/assets` - Media and static resources
  - Icons and images
  - Audio files
  - Fonts
  - Other static resources

- `/systemd` - System service definitions
  - Systemd service files for auto-starting the application
  - Configuration for startup logic

- `/project_management` - Project documentation and tracking
  - Progress tracking
  - Hardware specifications
  - Design documents
  - Meeting notes

## Development Environment

- **Host System**: Ubuntu 24.04.2 LTS (Noble Numbat)
- **Target Hardware**: Beelink SER8 (Ryzen 7 8845HS, 64GB RAM, 2TB SSD)
- **Display**: Waveshare 10.1" touchscreen (1280x800)
- **Development Workflow**: VS Code with Remote-SSH from MacBook Pro

## Getting Started

1. Clone this repository:
   ```bash
   git clone <repository-url>
   ```

2. Set up the development environment:
   ```bash
   cd tinos-computer
   ./scripts/setup-dev-environment.sh
   ```

3. Build and run the UI:
   ```bash
   cd ui
   # Commands will depend on the chosen UI framework
   ```

## Contributing

1. Create a new branch for your feature or bugfix
2. Make your changes
3. Test thoroughly
4. Submit a pull request

## License

This project is private and not licensed for public use or distribution.

## Contact

Project Lead: RJ (Tino's father)
