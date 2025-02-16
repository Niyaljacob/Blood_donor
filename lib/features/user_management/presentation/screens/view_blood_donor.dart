import 'package:donatelife/common_widgets/async_value_widget.dart';
import 'package:donatelife/features/authentication/domain/app_user.dart';
import 'package:donatelife/features/user_management/presentation/screens/user_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ViewBloodDonor extends StatelessWidget {
  const ViewBloodDonor({
    super.key,
    required this.donorsAsyncValue,
  });

  final AsyncValue<List<AppUser>> donorsAsyncValue;

  @override
  Widget build(BuildContext context) {
    return AsyncValueWidget<List<AppUser>>(
      value: donorsAsyncValue,
      data: (donors) {
        final topDonors = donors.take(3).toList(); // Limiting to 3 donors
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Top Donors",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const UserListPage(),
                        ),
                      );
                    },
                    child: const Text(
                      "View All >",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 82, 136, 179),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 150, // Height for horizontal list
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: topDonors.length,
                itemBuilder: (ctx, index) {
                  final donor = topDonors[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Container(
                      width: 250,
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          // Dummy Profile Image
                          ClipOval(
                            child: Image.asset(
                              'assets/banner1.jpg', // Replace with dummy image path
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 10),
                          // Donor Details
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                donor.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "Blood Group: ${donor.bloodGroup}",
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
