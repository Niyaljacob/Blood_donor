import 'package:donatelife/common_widgets/async_value_widget.dart';
import 'package:donatelife/features/authentication/domain/app_user.dart';
import 'package:donatelife/features/user_management/data/firestore_repository.dart';
import 'package:donatelife/features/user_management/presentation/widgets/user_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserListPage extends ConsumerWidget {
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final donorsAsyncValue = ref.watch(loadDonorsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Donors List"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AsyncValueWidget<List<AppUser>>(
          value: donorsAsyncValue,
          data: (donors) {
            return donors.isEmpty
                ? const Center(
                    child: Text(
                      'No Donors Yet!',
                      style: TextStyle(fontSize: 18, color: Colors.black54),
                    ),
                  )
                : ListView.builder(
                    itemCount: donors.length,
                    itemBuilder: (ctx, index) {
                      return UserItem(donors[index]);
                    },
                  );
          },
        ),
      ),
    );
  }
}
