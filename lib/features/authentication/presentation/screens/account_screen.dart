import 'package:donatelife/common_widgets/async_value_ui.dart';
import 'package:donatelife/common_widgets/async_value_widget.dart';
import 'package:donatelife/common_widgets/common_button.dart';
import 'package:donatelife/features/authentication/data/auth_repository.dart';
import 'package:donatelife/features/authentication/domain/app_user.dart';
import 'package:donatelife/routes/routes.dart';
import 'package:donatelife/utils/appstyles.dart';
import 'package:donatelife/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SizeConfig.init(context);

    final userId = ref.watch(currentUserProvider)!.uid;

    final userDataAsync = ref.watch(loadUserInformationProvider(userId));

    ref.listen<AsyncValue>(loadUserInformationProvider(userId), (_, state) {
      state.showAlertDialogOnError(context);
    });

    void logOut() {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Are you sure?'),
                icon: const Icon(
                  Icons.logout,
                  size: 50,
                  color: Appstyles.mainColor,
                ),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Appstyles.mainColor,
                      ),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      )),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        ref.read(authRepositoryProvider).signOut();
                        ref.read(goRouterProvider).go('/signIn');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Appstyles.mainColor,
                      ),
                      child: const Text(
                        'Log Out',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ))
                ],
              ));
    }

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 255, 255, 255), // Light gradient color
            Color.fromARGB(255, 175, 89, 74), // Darker gradient color
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor:
            Colors.transparent, // Make Scaffold background transparent

        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              context.goNamed(AppRoutes.main.name);
            },
          ),
          title: const Text(
            'My Profile',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Appstyles.mainColor,
        ),
        body: AsyncValueWidget<AppUser>(
          value: userDataAsync,
          data: (userData) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    // Profile Image
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage(
                          userData.type == 'Donor'
                              ? 'assets/donar-rem.png'
                              : 'assets/recipient-rem.png',
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Name and Info Card
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Name: ${userData.name}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Blood Group: ${userData.bloodGroup}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Email: ${userData.email}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Phone: ${userData.phoneNumber}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // User Type
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Center(
                          child: Text(
                            "User Type: ${userData.type}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Appstyles.mainColor,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Sign Out Button
                    CommonButton(
                      onTap: logOut,
                      title: 'Sign Out',
                      isLoading: false,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
