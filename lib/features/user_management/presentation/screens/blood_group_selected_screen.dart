import 'package:donatelife/common_widgets/async_value_ui.dart';
import 'package:donatelife/common_widgets/async_value_widget.dart';
import 'package:donatelife/features/authentication/domain/app_user.dart';
import 'package:donatelife/features/user_management/data/firestore_repository.dart';
import 'package:donatelife/features/user_management/presentation/widgets/user_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BloodGroupSelectedScreen extends ConsumerWidget {
  const BloodGroupSelectedScreen(this.bloodGroup, {super.key});
  final String bloodGroup;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final donorsAsyncValue=ref.watch(loadSpecificBloodGroupDonorsProvider(bloodGroup));
    ref.listen<AsyncValue>(loadSpecificBloodGroupDonorsProvider(bloodGroup),(_, state){
state.showAlertDialogOnError(context);
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Blood Group: $bloodGroup',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: AsyncValueWidget<List<AppUser>>(
                  value: donorsAsyncValue, 
                  data: (donors){
                    return donors.isEmpty? const Center(
                        child: Text('No Donors Yest!'),
                    ):ListView.builder(
                      itemCount: donors.length,
                      itemBuilder: (ctx, index){
                        return UserItem(donors[index]);
                      });
                  }
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
