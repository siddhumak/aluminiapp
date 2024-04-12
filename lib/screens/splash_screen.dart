import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn, // Apply ease in curve
    );

    controller.forward(); // Start the animation in the forward direction
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: AnimatedBuilder(
              animation: animation,
              builder: (context, child) {
                return SizedBox(
                  height: 300,
                  width: 300,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Wheel image
                      Transform.rotate(
                        angle: animation.value * 2 * 3.14, // Rotate the wheel
                        child: SizedBox(
                          height: 90,
                          width: 100,
                          child: Image.asset('assets/earth.png'),
                        ),
                      ),
                      // People image
                      Positioned(
                        top: 75, // Half of the people.png image's height
                        child: Transform.translate(
                          offset:
                              Offset(2, -47), // Adjust the position as needed
                          child: SizedBox(
                            height: 210,
                            width: 210,
                            child: Image.asset('assets/people.png'),
                          ),
                        ),
                      ),
                      // Additional image below people.png
                      Positioned(
                        top:
                            210, // Adjust position based on people image's height
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.asset('assets/name.png'),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
