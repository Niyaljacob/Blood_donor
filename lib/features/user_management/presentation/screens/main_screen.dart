import 'package:donatelife/common_widgets/async_value_ui.dart';
import 'package:donatelife/common_widgets/async_value_widget.dart';
import 'package:donatelife/features/authentication/domain/app_user.dart';
import 'package:donatelife/features/user_management/data/firestore_repository.dart';
import 'package:donatelife/features/user_management/presentation/widgets/main_drawer.dart';
import 'package:donatelife/features/user_management/presentation/widgets/user_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final donorsAsyncValue = ref.watch(loadDonorsProvider);

    ref.listen<AsyncValue>(loadDonorsProvider,(_, state){
      state.showAlertDialogOnError(context);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("Blood Donation"),
      ),
      drawer: const MainDrawer(),
      body: Padding(
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
    );
  }
}