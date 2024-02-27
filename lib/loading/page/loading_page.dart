import "package:auto_route/auto_route.dart";
import "package:bank/bank_observer.dart";
import "package:bank/loading/page/components/loading_icon.dart";
import "package:bank/routes/bank_auto_router.gr.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";

@RoutePage()
class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => LoadingPageState();
}

class LoadingPageState extends State<LoadingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  int count = 0;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color(0xffffffff),
        statusBarIconBrightness: Brightness.light,
      ),
    );

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    final tween = Tween<double>(begin: 0.0, end: 1.0);
    _scaleAnimation = tween.animate(_controller);
    _controller
      ..addStatusListener((status) {
        logger.i(count);
        Future<void>.delayed(
          const Duration(seconds: 1),
          () {
            if (count > 2) {
              context.replaceRoute(const DashBoardPage());
            }
            if (status == AnimationStatus.completed) {
              _controller
                ..reset()
                ..forward();
              count++;
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
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Center(
        child: AnimatedBuilder(
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
        ),
      ),
    );
  }
}
