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
                title: const Text('Are yoy sure'),
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
                        "cancel",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      )),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        ref.read(authRepositoryProvider).signOut();
            ref.read(goRouterProvider).go('/signIn'); // Explicitly navigate to signIn
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

    return Scaffold(
        appBar: AppBar(
  leading: IconButton(
    icon: const Icon(Icons.arrow_back, color: Colors.white),
    onPressed: () {
      context.goNamed(AppRoutes.main.name, );
    },
  ),
  title: const Text(
    'My Profile Information',
    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
  ),
),
        body: AsyncValueWidget<AppUser>(
            value: userDataAsync,
            data: (userData) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Text(
                      "Type: ${userData.type}",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: SizeConfig.getProportionteHeight(20),
                    ),
                    Image.asset(
                      userData.type == 'Donor'
                          ? 'assets/donar-rem.png'
                          : 'assets/recipient-rem.png',
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      height: SizeConfig.getProportionteHeight(20),
                    ),
                    Text(
                      'Name: ${userData.name}',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      'Blood Group: ${userData.bloodGroup}',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      'Email: ${userData.email}',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      'Phone: ${userData.phoneNumber}',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.getProportionteHeight(20),
                    ),
                    CommonButton(
                        onTap: () {
                          logOut();
                        },
                        title: 'Sign Out',
                        isLoading: false)
                  ],
                ),
              );
            }));
  }
}
