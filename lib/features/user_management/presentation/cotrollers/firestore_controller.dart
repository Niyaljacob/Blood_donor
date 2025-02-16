import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart'; // Use this for the @riverpod annotation

import 'package:donatelife/features/user_management/data/firestore_repository.dart';
import 'package:donatelife/features/user_management/domain/app_notification.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
part 'firestore_controller.g.dart';

@riverpod
class FirestoreController extends _$FirestoreController {
  @override
  FutureOr<void> build() {}
  Future<void> saveIdsToDatabase({
    required String recipientId,
    required String donorId,
  }) async {
    final firestoreRepository = ref.read(firestoreRepositoryProvider);
    state = await AsyncValue.guard(() async {
      await firestoreRepository.saveIdsToDatabase(
        recipientId: recipientId,
        donorId: donorId,
      );
    });
  }

  Future<void> addNotifications({
    required String recipientId,
    required String donorId,
    required AppNotification appNotification,
  }) async {
    final firestoreRepository = ref.read(firestoreRepositoryProvider);
    state = await AsyncValue.guard(() async {
      await firestoreRepository.addNotifications(
        recipientId: recipientId,
        donorId: donorId,
        appNotification: appNotification,
      );
    });
  }
}
