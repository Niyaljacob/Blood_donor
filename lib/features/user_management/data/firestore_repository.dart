import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donatelife/features/authentication/domain/app_user.dart';
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