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
    final userId=ref.watch(currentUserProvider)!.uid;

    final userDataAsync = ref.watch(loadUserInformationProvider(userId));

    ref.listen<AsyncValue>(loadUserInformationProvider(userId),(_, state){
      state.showAlertDialogOnError(context);
    });
    
    return AsyncValueWidget<AppUser>(value: userDataAsync, data: (userData){
      return SafeArea(
        child: Drawer(
      child: Column(
        children: [
          DrawerHeader(
              child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: Appstyles.mainColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.white,
                  style: BorderStyle.solid,
                  width: 2,
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/unnamed.png',
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                ),
                Text(
                  "Blood Donation App",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
                Text(
                  userData.name,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
                Text(
                  userData.email,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          )),
          Expanded(
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Appstyles.mainColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.white,
                    style: BorderStyle.solid,
                    width: 2,
                  )),
              child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: Icon(
                            Icons.home,
                            color: Colors.black,
                            size: 30,
                          ),
                          title: Text(
                            'Home',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () {},
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.check_circle,
                            color: Colors.black,
                            size: 30,
                          ),
                          title: Text(
                            'Donors Emailed!',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () {},
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.handshake,
                            color: Colors.black,
                            size: 30,
                          ),
                          title: Text(
                            'Same BG as me',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            context.goNamed(AppRoutes.bloodGroupSelected.name,extra: userData.bloodGroup);
                          },
                        ),
                        const Divider(
                          color: Colors.white,
                          height: 2,
                        ),
                        const Text(
                          "Blood Groups",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        ListTile(
                          leading: Image.asset(
                            'assets/A+-rem.png',
                            width: 30,
                            height: 30,
                          ),
                          title: Text('A Positive',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              )),
                          onTap: () {
                            context.goNamed(AppRoutes.bloodGroupSelected.name, extra: 'A+');
                          },
                        ),
                        ListTile(
                          leading: Image.asset(
                            'assets/A--rem.png',
                            width: 30,
                            height: 30,
                          ),
                          title: Text('A Negative',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              )),
                          onTap: () {
                            context.goNamed(AppRoutes.bloodGroupSelected.name, extra: 'A-');
                          },
                        ),
                        ListTile(
                          leading: Image.asset(
                            'assets/B+-rem.png',
                            width: 30,
                            height: 30,
                          ),
                          title: Text('B Positive',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              )),
                          onTap: () {
                            context.goNamed(AppRoutes.bloodGroupSelected.name, extra: 'B+');
                          },
                        ),
                        ListTile(
                          leading: Image.asset(
                            'assets/B--rem.png',
                            width: 30,
                            height: 30,
                          ),
                          title: Text('B Negative',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              )),
                          onTap: () {
                            context.goNamed(AppRoutes.bloodGroupSelected.name, extra: 'B-');
                          },
                        ),
                        ListTile(
                          leading: Image.asset(
                            'assets/AB+-rem.png',
                            width: 30,
                            height: 30,
                          ),
                          title: Text('AB Positive',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              )),
                          onTap: () {
                            context.goNamed(AppRoutes.bloodGroupSelected.name, extra: 'AB+');
                          },
                        ),
                        ListTile(
                          leading: Image.asset(
                            'assets/AB--rem.png',
                            width: 30,
                            height: 30,
                          ),
                          title: Text('AB Negative',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              )),
                          onTap: () {
                            context.goNamed(AppRoutes.bloodGroupSelected.name, extra: 'AB-');
                          },
                        ),
                        ListTile(
                          leading: Image.asset(
                            'assets/O+-rem.png',
                            width: 30,
                            height: 30,
                          ),
                          title: Text('O Positive',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              )),
                          onTap: () {
                            context.goNamed(AppRoutes.bloodGroupSelected.name, extra: 'O+');
                          },
                        ),
                        ListTile(
                          leading: Image.asset(
                            'assets/O--rem.png',
                            width: 30,
                            height: 30,
                          ),
                          title: Text('O Negative',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              )),
                          onTap: () {
                            context.goNamed(AppRoutes.bloodGroupSelected.name, extra: 'O+');
                          },
                        ),
                        const Divider(
                          color: Colors.white,
                          height: 2,
                        ),
                        const Text(
                          "Actions",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.notifications,
                            color: Colors.black,
                            size: 30,
                          ),
                          title: Text('Notifications',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              )),
                          onTap: () {
                          },
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.person_sharp,
                            color: Colors.black,
                            size: 30,
                          ),
                          title: Text('My Account',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              )),
                          onTap: () {
                            context.goNamed(AppRoutes.account.name);
                          },
                        ),
                      ],
                    )),
              ),
            ),
          )
        ],
      ),
    ));
    });
  }
}
