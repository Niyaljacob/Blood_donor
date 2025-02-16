import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Footer extends StatelessWidget {
  const Footer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Makes the container full width
      height: 200,
      decoration: BoxDecoration(),
      child: Stack(
        alignment: Alignment
            .center, // Center aligns the children in the Stack
        children: [
          // Lottie Animation
          Positioned.fill(
            child: Lottie.asset(
              'assets/Animation4.json',
              fit: BoxFit
                  .cover, // Ensures the animation fills the container
            ),
          ),
          // Text over Lottie
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Thank you for using our app!',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Colors
                      .white, // Ensure text is visible over Lottie
                ),
              ),
              const SizedBox(height: 3),
              const Text(
                'We hope you have a great experience.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 7),
              const Text(
                'Find Us',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const Text(
                '+91 8590168780\nniyaljacob76@gmail.com',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
