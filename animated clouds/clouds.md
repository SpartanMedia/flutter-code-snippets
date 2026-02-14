# AnimatedClouds Widget

A Flutter widget that creates a dreamy, floating cloud animation with a Lottie background and randomly drifting cloud images.

## Features

- **Lottie Background Animation**: Displays a looping Lottie animation as the background layer
- **Floating Cloud Images**: Two cloud images that drift smoothly in random directions
- **Smooth Transitions**: Uses `Curves.easeInOut` for natural, fluid motion
- **Random Movement**: Clouds move to new random positions every 2 seconds
- **Transparent Scaffold**: Overlay UI with transparent background

## Requirements

### Dependencies

Add these to your `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  lottie: ^3.0.0  # Or latest version
```

### Assets

You'll need the following assets in your project:

```yaml
flutter:
  assets:
    - assets/lottie/lt-animation.json
    - assets/images/cloud_1.png
    - assets/images/cloud_2.png
```

## Usage

```dart
import 'package:flutter/material.dart';
import 'animated_clouds.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const AnimatedClouds(),
    );
  }
}
```

## Example

(clouds.gif)

## How It Works

1. **Animation Controller**: A 2-second repeating animation controller manages the timing
2. **Random Offsets**: Each animation cycle generates a new random offset within a ±10 pixel range
3. **Tween Animation**: Smoothly interpolates between the current and new position
4. **Opposite Directions**: The two clouds move in opposite directions (one uses `-_animation.value`, the other uses `_animation.value`)
5. **Continuous Loop**: When an animation completes, a new random offset is generated automatically

## Customization

### Adjust Movement Range

Change the random offset range in `_generateNewOffset()`:

```dart
final newOffset = Offset(
  _random.nextDouble() * 40 - 20, // Larger range = more movement
  _random.nextDouble() * 40 - 20,
);
```

### Change Animation Speed

Modify the duration in `initState()`:

```dart
_controller = AnimationController(
  vsync: this,
  duration: const Duration(seconds: 4), // Slower
);
```

### Position Clouds

Adjust the `Positioned` widget parameters:

```dart
Positioned(
  top: 120,    // Vertical position
  right: 20,   // Horizontal position
  child: ...
)
```

### Cloud Size

Change the `width` parameter:

```dart
Image.asset('assets/images/cloud_1.png', width: 150), // Larger cloud
```

## License

This code is provided as-is for educational and commercial use.