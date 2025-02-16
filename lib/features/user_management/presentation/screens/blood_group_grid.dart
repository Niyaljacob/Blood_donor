// Blood Group Grid Widget
import 'package:donatelife/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';

class BloodGroupGrid extends StatelessWidget {
  BloodGroupGrid({super.key});

  final List<Map<String, String>> bloodGroups = [
    {'name': 'A Positive', 'value': 'A+'},
    {'name': 'A Negative', 'value': 'A-'},
    {'name': 'B Positive', 'value': 'B+'},
    {'name': 'B Negative', 'value': 'B-'},
    {'name': 'AB Positive', 'value': 'AB+'},
    {'name': 'AB Negative', 'value': 'AB-'},
    {'name': 'O Positive', 'value': 'O+'},
    {'name': 'O Negative', 'value': 'O-'},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: AnimationLimiter(
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Two blood groups per row
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 3, // Adjusts the height of the containers
          ),
          itemCount: bloodGroups.length,
          itemBuilder: (context, index) {
            final bloodGroup = bloodGroups[index];
            return AnimationConfiguration.staggeredGrid(
              position: index,
              duration: const Duration(milliseconds: 500),
              columnCount: 2,
              child: ScaleAnimation(
                scale: 0.5,
                child: FadeInAnimation(
                  child: GestureDetector(
                    onTap: () {
                      context.goNamed(
                        AppRoutes.bloodGroupSelected.name,
                        extra: bloodGroup['value'],
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255)
                            .withOpacity(0.8),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          bloodGroup['name']!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}