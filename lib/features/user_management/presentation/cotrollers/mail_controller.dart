import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart'; // Use this for the @riverpod annotation

import 'package:donatelife/features/user_management/data/mail_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
part 'mail_controller.g.dart';

@riverpod
class MailController extends _$MailController {
  @override
  FutureOr<void> build() {}
  Future<bool> sendEmail({
    required String donorEmail,
    required String recipientEmail,
    required String recipientName,
    required String recipientPhone,
    required String recipientBloodGroup,
  }) async {
    try {
      state = const AsyncLoading();
      await ref.read(mailRepositoryProvider).sendEmail(
            donorEmail: donorEmail,
            recipientEmail: recipientEmail,
            recipientName: recipientName,
            recipientPhone: recipientPhone,
            recipientBloodGroup: recipientBloodGroup,
          );
      state = const AsyncData(null);

      return true;
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
      return false;
    }
  }
}
