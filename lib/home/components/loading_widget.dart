import "package:bank/loading/page/components/loading_icon.dart";
import "package:flutter/material.dart";

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({required this.onLoad, super.key});
  final void Function() onLoad;

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    final tween = Tween<double>(begin: 0.0, end: 1.0);
    _scaleAnimation = tween.animate(_controller);
    _controller
      ..addStatusListener((status) {
        Future<void>.delayed(
          const Duration(seconds: 1),
          () {
            if (status == AnimationStatus.completed) {
              widget.onLoad.call();
            }
          },
        );
      })
      ..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const LoadingIcon(),
            LoadingIcon(
              color: _scaleAnimation.value > 0.3
                  ? const Color(0xffE6B014)
                  : Colors.transparent,
            ),
            LoadingIcon(
              color: _scaleAnimation.value > 0.6
                  ? const Color(0xff022E64)
                  : Colors.transparent,
            ),
          ],
        );
      },
    );
  }
}
