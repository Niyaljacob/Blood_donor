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
import 'package:flutter/cupertino.dart';
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
    final buttonLoadingProvider = StateProvider<bool>((ref) => false);

    ref.watch(mailRepositoryProvider);
    ref.listen<AsyncValue>(mailControllerProvider, (_, state) {
      state.showAlertDialogOnError(context);
    });

    return AsyncValueWidget<AppUser>(
        value: userDataAsync,
        data: (userData) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20), // Rounded corners
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // Shadow position
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        appUser.type == 'Donor'
                            ? 'assets/donar-rem.png'
                            : 'assets/recipient-rem.png',
                        height: SizeConfig.getProportionteHeight(60),
                        width: SizeConfig.getProportionteWidth(60),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            appUser.type.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Name: ${appUser.name}',
                            style: const TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Email: ${appUser.email}',
                    style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    'Phone: ${appUser.phoneNumber}',
                    style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    'Blood Group: ${appUser.bloodGroup}',
                    style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Center(
                    child: CupertinoButton(
                      color: Appstyles.mainColor,
                      borderRadius: BorderRadius.circular(12),
                      onPressed: () async {
                        ref.read(buttonLoadingProvider.notifier).state = true;

                        final result = await ref
                            .read(mailControllerProvider.notifier)
                            .sendEmail(
                                donorEmail: userData.email,
                                recipientEmail: userData.email,
                                recipientName: userData.name,
                                recipientPhone: userData.phoneNumber,
                                recipientBloodGroup: userData.bloodGroup);
                        ref.read(buttonLoadingProvider.notifier).state = false;

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
                                return CupertinoAlertDialog(
                                  title: const Text(
                                    "Donor Emailed Successfully",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18),
                                  ),
                                  content: const Icon(
                                    CupertinoIcons.check_mark_circled_solid,
                                    color: Colors.green,
                                    size: 100,
                                  ),
                                  actions: [
                                    CupertinoDialogAction(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("Okay"),
                                    ),
                                  ],
                                );
                              });
                        }
                      },
                      child: ref.watch(buttonLoadingProvider)
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            )
                          : const Text(
                              "EMAIL",
                              style: TextStyle(color: Colors.white),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
