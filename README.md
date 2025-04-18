# Scroll Animation Toolkit
A flexible toolkit for adding scroll-based animations to your Flutter apps. This includes widgets for entrance animations triggered by scroll visibility, scroll-driven scaling, pinning effects, and more.

This package provides customizable scroll animations with ease, focusing on smooth UX, modular usage, and performance. Ideal for websites, portfolios, and scroll-based storytelling apps.


## Features
* Animate widgets into view when they enter the viewport.

* Detect when widgets leave the screen to reverse animations (optional).

* *Scale widgets horizontally based on scroll progress.

* Pin widgets in place during a specific scroll range.

* Lightweight and easy to drop into existing scroll views.

* Fine-grain control over animation duration, offset, and direction.




  # Demos

  <p float="left">
    <img src="https://github.com/NIKET898/Scrolling-Animation/blob/main/assets/demo_video.mp4" width="200" height="350"/>
  </p>

## Basic Usage
* Scroll-Triggered Entrance Animation
```dart

ScrollAnimatedWidget(
  triggerOffset: 200, 
  offset: Offset(0, 50), 
  duration: Duration(milliseconds: 600),
  reverseOnExit: true,
  child: YourWidget(),
)

```
* ScaleX Animation Based on Scroll Progress
```dart

ScrubScaleX(
  scrollOffset: currentScrollPosition,
  startOffset: 300,
  endOffset: 700,
  child: YourWidget(),
)

```
* Pin Widget During Scroll Range

```dart

PinOnScroll(
  scrollOffset: currentScrollPosition,
  startOffset: 1000,
  endOffset: 1500,
  child: YourWidget(),
)
```

## How It Works:
# ScrollAnimatedWidget
Uses VisibilityDetector to track when the widget enters the viewport and triggers an entrance animation using AnimatedBuilder. Optionally reverses the animation when scrolled out of view.

* triggerOffset: When to trigger animation relative to screen height.

* offset: Start position for slide animation.

* duration: How long the animation should last.

* reverseOnExit: Should it reverse when leaving viewport?


# ScrubScaleX
Scales a widget's width based on scroll offset. Useful for scroll progress indicators or revealing effects.

* scrollOffset: Current scroll position.

* startOffset: Scroll position to start animating.

* endOffset: Scroll position to complete animation.


# PinOnScroll
Pins a widget in place within a defined scroll range by wrapping it in a Positioned.fill. Great for headers, parallax sections, or section titles.



## Notes
Requires visibility_detector for entrance detection.

You’ll need to pass the current scroll offset from your ScrollController to ScrubScaleX and PinOnScroll.


## Coming Soon (Ideas)
Scroll-based rotation and opacity widgets.

Timeline animation builder.

Integration with AnimatedBGText (currently commented in code).