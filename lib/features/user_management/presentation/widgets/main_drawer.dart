import 'package:donatelife/common_widgets/async_value_ui.dart';
import 'package:donatelife/common_widgets/async_value_widget.dart';
import 'package:donatelife/features/authentication/data/auth_repository.dart';
import 'package:donatelife/features/authentication/domain/app_user.dart';
import 'package:donatelife/routes/routes.dart';
import 'package:donatelife/utils/appstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MainDrawer extends ConsumerWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(currentUserProvider)!.uid;
    final userDataAsync = ref.watch(loadUserInformationProvider(userId));

    ref.listen<AsyncValue>(loadUserInformationProvider(userId), (_, state) {
      state.showAlertDialogOnError(context);
    });

    return AsyncValueWidget<AppUser>(
      value: userDataAsync,
      data: (userData) {
        return SafeArea(
          child: Drawer(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Appstyles.mainColor, Colors.black87],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: [
                  // Drawer Header
                  Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      // ignore: deprecated_member_use
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          // ignore: deprecated_member_use
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
                            'assets/unnamed.png',
                            height: 70,
                            width: 70,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Blood Donation App",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          userData.name,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          userData.email,
                          style: TextStyle(
                            color: Colors.white60,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Menu Options
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(10),
                      children: [
                        // Same BG Section
                        ListTile(
                          leading: Icon(
                            Icons.handshake,
                            color: Colors.redAccent,
                            size: 30,
                          ),
                          title: Text(
                            'Same BG as me',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () {
                            context.goNamed(AppRoutes.bloodGroupSelected.name,
                                extra: userData.bloodGroup);
                          },
                        ),
                        const Divider(color: Colors.white54),

                        // Blood Groups Section
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            "Blood Groups",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        ..._buildBloodGroupTiles(context),
                        const Divider(color: Colors.white54),

                        // Actions Section
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            "Actions",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.person_sharp,
                            color: Colors.blueAccent,
                            size: 30,
                          ),
                          title: Text(
                            'My Account',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () {
                            context.goNamed(AppRoutes.account.name);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Helper to build Blood Group Tiles
  List<Widget> _buildBloodGroupTiles(BuildContext context) {
    final bloodGroups = [
      {'name': 'A Positive', 'value': 'A+'},
      {'name': 'A Negative', 'value': 'A-'},
      {'name': 'B Positive', 'value': 'B+'},
      {'name': 'B Negative', 'value': 'B-'},
      {'name': 'AB Positive', 'value': 'AB+'},
      {'name': 'AB Negative', 'value': 'AB-'},
      {'name': 'O Positive', 'value': 'O+'},
      {'name': 'O Negative', 'value': 'O-'},
    ];

    return bloodGroups
        .map(
          (group) => ListTile(
            leading: Icon(Icons.bloodtype_rounded, color: Colors.redAccent),
            title: Text(
              group['name']!,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
            onTap: () {
              context.goNamed(AppRoutes.bloodGroupSelected.name,
                  extra: group['value']);
            },
          ),
        )
        .toList();
  }
}
