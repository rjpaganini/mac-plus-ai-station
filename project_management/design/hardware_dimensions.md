# Hardware Dimensions and Specifications

*Last Updated: July 17th, 2025*

## Macintosh Plus Shell Dimensions

### External Dimensions
- **Height**: ~340mm (~13.4 inches)
- **Width**: ~246mm (~9.7 inches)
- **Depth**: ~276mm (~10.9 inches)
- **Weight** (original): ~7.5kg (~16.5 lbs)
- **Weight** (retrofitted): TBD

### Internal Cavity
- **Note**: Exact internal dimensions to be measured when shell is available
- **Estimated usable space**: ~220mm × ~200mm × ~240mm (H×W×D)
- **Critical internal constraints**: 
  - CRT support structures
  - Front bezel mounting points
  - Rear port openings

## Display Component

### Waveshare 10.1" Touchscreen (10.1DP-CAPLCD)
- **Screen Dimensions**: 239mm × 147mm (active area)
- **Total Dimensions**: ~260mm × ~170mm (including controller board)
- **Thickness**: ~10mm (screen only), ~20mm (with controller board)
- **Resolution**: 1280 × 800 pixels
- **Aspect Ratio**: 16:10
- **Connections**: HDMI (video), USB (touch)
- **Power**: 12V DC via barrel jack
- **Mounting Points**: VESA 75mm × 75mm pattern
- **Weight**: ~400g

### Custom Acrylic Bezel
- **Material**: 3mm matte black acrylic
- **Outer Dimensions**: Match internal front bezel of Mac Plus
- **Opening**: 239mm × 147mm (exact match to screen dimensions)
- **Mounting**: TBD - likely adhesive to shell interior or brackets

## Computer Component

### Beelink SER8
- **Dimensions**: 126mm × 113mm × 40mm (L×W×H)
- **Weight**: ~500g
- **CPU**: AMD Ryzen 7 8845HS
- **RAM**: 64GB DDR5
- **Storage**: 2TB SSD
- **Ports**:
  - 2× HDMI
  - 1× USB-C
  - 3× USB-A 3.0
  - 1× Ethernet
  - 1× 3.5mm Audio
- **Power**: 19V DC via barrel jack
- **Mounting**: Horizontal or vertical orientation possible
- **Thermal Considerations**: 
  - Requires adequate airflow
  - Vents on multiple sides
  - Consider adding small fan for additional cooling

## Peripherals

### Linogren 8W Speakers
- **Dimensions**: ~80mm × ~80mm × ~100mm (each)
- **Weight**: ~300g (pair)
- **Power**: USB-A
- **Mounting**: Double-sided tape or brackets
- **Cable Length**: ~1.5m

### USB-C Lavalier Microphone
- **Dimensions**: ~10mm × ~10mm × ~30mm (mic only)
- **Cable Length**: ~1.5m
- **Mounting**: Clip or adhesive
- **Positioning**: Front of case, near top

### 8BitDo Ultimate 2C Controller
- **Dimensions**: ~150mm × ~100mm × ~60mm
- **Connection**: Bluetooth
- **Charging**: USB-C
- **Storage**: External to Mac Plus shell

## Power Requirements

### Total Power Needs
- **Beelink SER8**: 19V, ~65W
- **Waveshare Display**: 12V, ~10W
- **USB Peripherals**: 5V, ~5W (combined)
- **Total**: ~80W

### Power Distribution Options
1. **Option 1**: Separate power supplies for PC and display
   - Pros: Simpler wiring, original components
   - Cons: Two power cables required
2. **Option 2**: Single power supply with voltage regulators
   - Pros: Single power cable
   - Cons: More complex internal wiring, heat generation

## Clearance and Mounting Considerations

### Critical Clearances
- **Display to Shell**: <1mm tolerance width-wise
- **PC to Display**: Minimum 10mm for cables and airflow
- **Ventilation**: Minimum 20mm clearance around PC vents
- **Cable Routing**: Allow 30mm radius for cable bends

### Mounting Solutions
- **Display**: 
  - VESA mount to custom bracket
  - Alternatively, direct mounting to acrylic bezel
- **PC**: 
  - M3 nylon standoffs to base of shell
  - Consider vibration dampening
- **Speakers**:
  - Double-sided tape to interior sides
  - Position for optimal sound projection
- **Microphone**:
  - Small bracket near top of shell
  - Position away from speakers to prevent feedback

## Assembly Sequence (Preliminary)

1. Test fit all components outside of shell
2. Mount acrylic bezel to shell interior
3. Attach display to acrylic bezel
4. Install PC with adequate clearance from display
5. Mount speakers and microphone
6. Connect all cables (video, USB, power)
7. Secure cables with management solutions
8. Test all components before final closure

## Thermal Management

### Considerations
- Original Mac Plus had vents at top for passive cooling
- Beelink SER8 generates significant heat under load
- Enclosed space will trap heat

### Solutions
- Add supplemental quiet fan (~80mm) for active cooling
- Position PC near original vent openings
- Consider adding additional vent holes if necessary
- Monitor temperatures during testing phase

## Diagram Placeholders

### Front View Layout
```
+----------------------------------+
|                                  |
|  +----------------------------+  |
|  |                            |  |
|  |         DISPLAY            |  |
|  |                            |  |
|  +----------------------------+  |
|                                  |
|                                  |
|                                  |
|                                  |
+----------------------------------+
```

### Side View Layout
```
+----------------------------------+
|                                  |
|  +------------+                  |
|  |  DISPLAY   |                  |
|  +------------+                  |
|                                  |
|                                  |
|          +----------+            |
|          |    PC    |            |
|          +----------+            |
|                                  |
+----------------------------------+
```

### Top View Layout
```
+----------------------------------+
|                                  |
|  +----------------------------+  |
|  |         DISPLAY            |  |
|  +----------------------------+  |
|                                  |
|  +--------+          +--------+  |
|  |SPEAKER |          |SPEAKER |  |
|  +--------+          +--------+  |
|                                  |
|          +----------+            |
|          |    PC    |            |
|          +----------+            |
|                                  |
+----------------------------------+
```

## Notes for Future Documentation

- Add actual photos of components when available
- Create precise CAD drawings for mounting brackets
- Document exact measurements of shell interior when available
- Update thermal performance data after testing
- Add cable routing diagram
