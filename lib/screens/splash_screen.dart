import 'package:demoapp/components/colors.dart';
import 'package:demoapp/onboarding_screen/onboarding_screen1.dart';
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
      duration: const Duration(seconds: 6),
    );

    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn, // Apply ease in curve
    );

    controller.forward(); // Start the animation in the forward direction

    // After 3 seconds, navigate to the OnboardingScreen
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>
              const OnBoardingScreen1(), // Navigate to OnboardingScreen
        ),
      );
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primarycolor,
      body: Stack(
        children: [
          Positioned(
            top: -80,
            right: 230,
            height: 240,
            child: Image.asset('assets/c5.png'),
          ),
          Positioned(
            top: 20,
            right: 120,
            height: 290,
            child: Image.asset('assets/c5.png'),
          ),
          Positioned(
            top: 0,
            right: 40,
            height: 70,
            child: Image.asset('assets/c5.png'),
          ),
          Positioned(
            top: 200,
            right: 5,
            height: 40,
            child: Image.asset('assets/c5.png'),
          ),
          Positioned(
            top: 70,
            left: 30,
            height: 150,
            child: Image.asset('assets/c5.png'),
          ),
          Positioned(
            top: 150,
            right: 80,
            height: 100,
            child: Image.asset('assets/c5.png'),
          ),

          Positioned(
            bottom: 70,
            left: 30,
            height: 150,
            child: Image.asset('assets/c5.png'),
          ),
          Positioned(
            bottom: 250,
            left: 30,
            height: 30,
            child: Image.asset('assets/c5.png'),
          ),
          Positioned(
            bottom: 100,
            left: 200,
            height: 120,
            child: Image.asset('assets/c5.png'),
          ),
          Positioned(
            bottom: 150,
            right: -150,
            height: 270,
            child: Image.asset('assets/c5.png'),
          ),
          Positioned(
            bottom: 30,
            right: -30,
            height: 100,
            child: Image.asset('assets/wave3.png'),
          ),
          Positioned(
            bottom: -5,
            right: 0,
            height: 200,
            child: Image.asset('assets/wave.png'),
          ),

          // Center content
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
                      Positioned(
                        child: Transform.rotate(
                          angle: animation.value * 2 * 3.14, // Rotate the wheel

                          child: Image.asset('assets/deslogo6.png'),
                        ),
                      ),
                      // People image
                      // Positioned(
                      //   top: 75, // Half of the people.png image's height
                      //   child: Transform.translate(
                      //     offset:
                      //         Offset(2, -47), // Adjust the position as needed
                      //     child: SizedBox(
                      //       height: 210,
                      //       width: 210,
                      //       child: Image.asset('assets/people.png'),
                      //     ),
                      //   ),
                      // ),
                      // Additional image below people.png
                      Positioned(
                        top: 80,
                        left: 55,
                        height:
                            125, // Adjust position based on people image's height
                        child: Image.asset('assets/deslogo5.png'),
                      ),
                      const Positioned(
                          bottom: 20,
                          left: 70,
                          child: Text(
                            "CONNECTING THE PAST EMPOERING THE FUTURE",
                            style: TextStyle(
                                fontSize: 7,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontStyle: FontStyle.normal),
                          ))
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
