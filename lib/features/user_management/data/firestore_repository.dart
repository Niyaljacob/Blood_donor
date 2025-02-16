import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donatelife/features/authentication/domain/app_user.dart';
import 'package:donatelife/features/user_management/domain/app_notification.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart'; // Use this for the @riverpod annotation
part 'firestore_repository.g.dart'; // Generated code will go here

class FirestoreRepository {
  FirestoreRepository(this._firestore);
  final FirebaseFirestore _firestore;
  Stream<List<AppUser>> loadDonor() {
    return _firestore
        .collection('users')
        .where('type', isEqualTo: 'Donor')
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((doc) => AppUser.fromMap(doc.data()))
            .toList());
  }

  Stream<List<AppUser>> loadSpecificBloodGroupDonors(String bloodGroup) {
    return _firestore
        .collection('users')
        .where('type', isEqualTo: 'Donor')
        .where('bloodGroup', isEqualTo: bloodGroup)
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((doc) => AppUser.fromMap(doc.data()))
            .toList());
  }

  Stream<List<AppUser>> loadSimilarBloodGroup(String bloodGroup) {
    return _firestore
        .collection('email')
        .where('type', isEqualTo: 'Donor')
        .where('bloodGroup', isEqualTo: bloodGroup)
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((doc) => AppUser.fromMap(doc.data()))
            .toList());
  }

  Future<void> saveIdsToDatabase(
      {required String recipientId, required String donorId}) async {
    await _firestore
        .collection('email')
        .doc(recipientId)
        .collection('user emailed')
        .add({recipientId: true});
  }

  Future<void> addNotifications(
      {required String recipientId,
      required String donorId,
      required AppNotification appNotification}) async {
    await _firestore
        .collection('notifications')
        .doc(donorId)
        .collection('user notifications')
        .add(appNotification.toMap());
    await _firestore
        .collection('notifications')
        .doc(recipientId)
        .collection('user notifications')
        .add(appNotification.toMap());
  }

  Stream<List<AppNotification>> loadNotifications(String userId) {
    return _firestore
        .collection('notifications')
        .doc(userId)
        .collection('user notifications')
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((doc) => AppNotification.fromMap(doc.data()))
            .toList());
  }

  Stream<List<String>> loadEmailedUserIds(String userId) {
    return _firestore
        .collection('email')
        .doc(userId)
        .collection('user emailed')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs
          .map((doc) => doc.data().keys.toList())
          .expand((keys) => keys)
          .toList();
    });
  }
}

@riverpod
FirestoreRepository firestoreRepository(FirestoreRepositoryRef ref) {
  return FirestoreRepository(FirebaseFirestore.instance);
}

@riverpod
Stream<List<AppUser>> loadDonors(LoadDonorsRef ref) {
  final firestoreRepository = ref.watch(firestoreRepositoryProvider);
  return firestoreRepository.loadDonor();
}

@riverpod
Stream<List<AppUser>> loadSpecificBloodGroupDonors(
    LoadSpecificBloodGroupDonorsRef ref, String bloodGroup) {
  final firestoreRepository = ref.watch(firestoreRepositoryProvider);
  return firestoreRepository.loadSpecificBloodGroupDonors(bloodGroup);
}

@riverpod
Stream<List<AppUser>> loadSimilarBloodGroups(
    LoadSimilarBloodGroupsRef ref, String bloodGroup) {
  final firestoreRepository = ref.watch(firestoreRepositoryProvider);
  return firestoreRepository.loadSimilarBloodGroup(bloodGroup);
}

@riverpod
Stream<List<AppNotification>> loadNotifications(
LoadNotificationsRef ref, String userId) {
final firestoreRepository =ref.watch(firestoreRepositoryProvider);
return firestoreRepository.loadNotifications(userId);
}

@riverpod
Stream<List<String>> loadEmailedUserIds(
LoadEmailedUserIdsRef ref, String userId) {
final firestoreRepository =ref.watch(firestoreRepositoryProvider);
return firestoreRepository.loadEmailedUserIds (userId);

}

