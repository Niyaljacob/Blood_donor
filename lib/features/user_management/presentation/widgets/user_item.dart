import 'package:donatelife/common_widgets/async_value_ui.dart';
import 'package:donatelife/common_widgets/async_value_widget.dart';
import 'package:donatelife/features/authentication/data/auth_repository.dart';
import 'package:donatelife/features/authentication/domain/app_user.dart';
import 'package:donatelife/features/user_management/data/mail_repository.dart';
import 'package:donatelife/features/user_management/domain/app_notification.dart';
import 'package:donatelife/features/user_management/presentation/cotrollers/firestore_controller.dart';
import 'package:donatelife/features/user_management/presentation/cotrollers/mail_controller.dart';
import 'package:donatelife/utils/appstyles.dart';
import 'package:donatelife/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserItem extends ConsumerWidget {
  const UserItem(this.appUser, {super.key});
  final AppUser appUser;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SizeConfig.init(context);

    final userId = ref.watch(currentUserProvider)!.uid;
    final userDataAsync = ref.watch(loadUserInformationProvider(userId));

    final state = ref.watch(mailRepositoryProvider);
    ref.listen<AsyncValue>(mailControllerProvider, (_, state) {
      state.showAlertDialogOnError(context);
    });

    return AsyncValueWidget<AppUser>(
        value: userDataAsync,
        data: (userData) {
          return Card(
            child: ListTile(
              leading: Image.asset(
                appUser.type == 'Donor'
                    ? 'assets/donar-rem.png'
                    : 'assets/recipient-rem.png',
                height: SizeConfig.getProportionteHeight(80),
                width: SizeConfig.getProportionteWidth(80),
              ),
              title: Column(
                children: [
                  Text(
                    appUser.type.toUpperCase(),
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 14),
                  ),
                  Text(
                    'Name: ${appUser.name}',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 14),
                  ),
                  Text(
                    'Email: ${appUser.email}',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 14),
                  ),
                  Text(
                    'phone: ${appUser.phoneNumber}',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 14),
                  ),
                  Text(
                    'Blood Group: ${appUser.bloodGroup}',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 14),
                  ),
                ],
              ),
              trailing: ElevatedButton(
                  onPressed: () async {
                    final result = await ref
                        .read(mailControllerProvider.notifier)
                        .sendEmail(
                            donorEmail: userData.email,
                            recipientEmail: userData.email,
                            recipientName: userData.name,
                            recipientPhone: userData.phoneNumber,
                            recipientBloodGroup: userData.bloodGroup);
                    if (result) {
                      ref
                          .read(firestoreControllerProvider.notifier)
                          .saveIdsToDatabase(
                              recipientId: userData.userId,
                              donorId: appUser.userId);
                      final date = DateTime.now().toString();
                      final myNotification = AppNotification(
                          text: 'Requested Blood Donation',
                          date: date,
                          donorId: appUser.userId,
                          recipientId: userData.userId);

                      ref
                          .read(firestoreControllerProvider.notifier)
                          .addNotifications(
                              recipientId: userData.userId,
                              donorId: appUser.userId,
                              appNotification: myNotification);

                      showDialog(
                          context: context,
                          builder: (ctx) {
                            return AlertDialog(
                              title: const Text(
                                "Donor Emailed Successfully",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                              icon: const Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 120,
                              ),
                              alignment: Alignment.center,
                              actions: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                Appstyles.mainColor),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text(
                                          'Okay',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ))
                                  ],
                                )
                              ],
                            );
                          });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Appstyles.mainColor,
                  ),
                  child: const Text("EMAIL")),
            ),
          );
        });
  }
}
