import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {},
              child: Text(
                "SKIP",
                style: Theme.of(context).textTheme.labelLarge,
              )),
          SizedBox()
        ],
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            Image.asset('assets/pngegg.png'),
            Text(
              "Lorem Ipsum",
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            Text(
              "Lorem Ipsum lkjhgf ljhgf",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(),
            ),
            CircleAvatar(
              radius: 35,
              backgroundColor: Color.fromARGB(255, 1, 27, 69),
              child: Icon(Icons.arrow_forward),
            ),
          ],
        ),
      ),
    );
  }
}
