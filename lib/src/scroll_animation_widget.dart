import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ScrollAnimatedWidget extends StatefulWidget {
  final Widget child;
  final double triggerOffset;
  final Duration duration;
  final Offset offset;
  final bool reverseOnExit;

  const ScrollAnimatedWidget({
    super.key,
    required this.child,
    required this.triggerOffset,
    this.duration = const Duration(milliseconds: 500),
    this.offset = const Offset(0, 50),
    this.reverseOnExit = true,
  });

  @override
  _ScrollAnimatedWidgetState createState() => _ScrollAnimatedWidgetState();
}

class _ScrollAnimatedWidgetState extends State<ScrollAnimatedWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);

    _offsetAnimation = Tween<Offset>(
      begin: widget.offset,
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller);
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    final screenHeight = MediaQuery.of(context).size.height;
    final widgetTop = info.visibleBounds.top;
    final widgetBottom = info.visibleBounds.bottom;
    final triggerPoint = screenHeight - widget.triggerOffset;

    final isInView = widgetTop < triggerPoint && widgetBottom > 0;

    if (isInView) {
      if (!_controller.isAnimating && !_controller.isCompleted) {
        _controller.forward();
      }
    } else {
      if (widget.reverseOnExit &&
          !_controller.isAnimating &&
          _controller.isCompleted) {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.child.hashCode.toString()),
      onVisibilityChanged: _onVisibilityChanged,
      child: AnimatedBuilder(
        animation: _controller,
        builder:
            (context, child) => Opacity(
              opacity: _opacityAnimation.value,
              child: Transform.translate(
                offset: _offsetAnimation.value,
                child: widget.child,
              ),
            ),
      ),
    );
  }
}

// Animate scaleX based on scroll progress
class ScrubScaleX extends StatelessWidget {
  final double scrollOffset;
  final double startOffset;
  final double endOffset;
  final Widget child;

  const ScrubScaleX({
    super.key,
    required this.scrollOffset,
    required this.startOffset,
    required this.endOffset,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final progress = ((scrollOffset - startOffset) / (endOffset - startOffset))
        .clamp(0.0, 1.0);
    return Transform(
      alignment: Alignment.centerLeft,
      transform: Matrix4.identity()..scale(progress, 1.0),
      child: child,
    );
  }
}

// Pin a widget during scroll range
class PinOnScroll extends StatelessWidget {
  final double scrollOffset;
  final double startOffset;
  final double endOffset;
  final Widget child;

  const PinOnScroll({
    super.key,
    required this.scrollOffset,
    required this.startOffset,
    required this.endOffset,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final isPinned = scrollOffset >= startOffset && scrollOffset <= endOffset;
    return isPinned ? Positioned.fill(child: child) : const SizedBox.shrink();
  }
}

// Animate background + text scale + opacity
// class AnimatedBGText extends StatelessWidget {
//   final double scrollOffset;

//   const AnimatedBGText({super.key, required this.scrollOffset});

//   @override
//   Widget build(BuildContext context) {
//     const double startOffset = 1600;
//     const double endOffset = 2400;
//     final progress = ((scrollOffset - startOffset) / (endOffset - startOffset))
//         .clamp(0.0, 1.0);

//     final color = Color.lerp(Colors.purple, Colors.green, progress)!;
//     final scale = 0.3 + (progress * 0.7);
//     final opacity = progress;

//     return Container(
//       color: color,
//       child: Center(
//         child: Opacity(
//           opacity: opacity,
//           child: Transform.scale(
//             scale: scale,
//             child: const Text(
//               'Scroll Animated Text',
//               style: TextStyle(fontSize: 32, color: Colors.white),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
