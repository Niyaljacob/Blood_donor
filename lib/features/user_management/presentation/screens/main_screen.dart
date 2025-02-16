import 'package:carousel_slider/carousel_slider.dart';
import 'package:donatelife/features/user_management/data/firestore_repository.dart';
import 'package:donatelife/features/user_management/presentation/screens/blood_group_grid.dart';
import 'package:donatelife/features/user_management/presentation/screens/view_blood_donor.dart';
import 'package:donatelife/features/user_management/presentation/widgets/footer.dart';
import 'package:donatelife/features/user_management/presentation/widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
              SizedBox(
                height: 30,
              ),
              Footer()
            ],
          ),
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
