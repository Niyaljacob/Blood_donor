import 'package:carousel_slider/carousel_slider.dart';
import 'package:donatelife/features/user_management/data/firestore_repository.dart';
import 'package:donatelife/features/user_management/presentation/screens/view_blood_donor.dart';
import 'package:donatelife/features/user_management/presentation/widgets/main_drawer.dart';
import 'package:donatelife/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<String> bannerImages = [
      'assets/banner1.jpg', // Replace with your own image paths
      'assets/banner2.jpg',
      'assets/banner3.jpg',
    ];

    // Fetching donor list
    final donorsAsyncValue = ref.watch(loadDonorsProvider);

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
    color: Colors.black, // Set the drawer icon color to black
  ),
        backgroundColor: Colors.white,
        title: const Text("Blood Donation"),
      ),
      drawer: const MainDrawer(),
      body: Container(
        decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color.fromARGB(255, 255, 255, 255), // Light gradient color
          Color.fromARGB(255, 198, 38, 10), // Darker gradient color
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              // Sliding Banner
              Banner(bannerImages: bannerImages),
              const SizedBox(height: 10),
              const Divider(color: Color.fromARGB(255, 214, 214, 214)),
              const SizedBox(height: 10),
          
              
          
              const SizedBox(height: 20),
              ViewBloodDonor(donorsAsyncValue: donorsAsyncValue),
              // Blood Groups Grid Section
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "Select Blood Group",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              BloodGroupGrid(),
            ],
          ),
        ),
      ),
    );
  }
}

// Blood Group Grid Widget
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
// Sliding Banner Widget
class Banner extends StatelessWidget {
  const Banner({
    super.key,
    required this.bannerImages,
  });

  final List<String> bannerImages;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: bannerImages
          .map(
            (imagePath) => ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          )
          .toList(),
      options: CarouselOptions(
        height: 200,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        enlargeCenterPage: true,
        aspectRatio: 16 / 9,
        viewportFraction: 0.85,
      ),
    );
  }
}
