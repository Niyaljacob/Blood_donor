class AppUser {
  final String name;
  final String phoneNumber;
  final String bloodGroup;
  final String email;
  final String type;
  final String userId;

  AppUser({
    required this.name,
    required this.phoneNumber,
    required this.bloodGroup,
    required this.email,
    required this.type,
    required this.userId,
  });

  /// Converts the object to a Map (for Firestore or other databases)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'bloodGroup': bloodGroup,
      'email': email,
      'type': type,
      'userId': userId,
    };
  }

  /// Factory constructor to create an object from a Map
  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      name: map['name'] as String,
      phoneNumber: map['phoneNumber'] as String,
      bloodGroup: map['bloodGroup'] as String,
      email: map['email'] as String,
      type: map['type'] as String,
      userId: map['userId'] as String,
    );
  }

  /// Creates a copy of the current object with modified fields
  AppUser copyWith({
    String? name,
    String? phoneNumber,
    String? bloodGroup,
    String? email,
    String? type,
    String? userId,
  }) {
    return AppUser(
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      email: email ?? this.email,
      type: type ?? this.type,
      userId: userId ?? this.userId,
    );
  }

  /// Overrides the `==` operator to compare objects by value
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppUser &&
        other.name == name &&
        other.phoneNumber == phoneNumber &&
        other.bloodGroup == bloodGroup &&
        other.email == email &&
        other.type == type &&
        other.userId == userId;
  }

  /// Computes a unique hash code for the object
  @override
  int get hashCode {
    return name.hashCode ^
        phoneNumber.hashCode ^
        bloodGroup.hashCode ^
        email.hashCode ^
        type.hashCode ^
        userId.hashCode;
  }

  /// Provides a readable string representation of the object
  @override
  String toString() {
    return 'AppUser(name: $name, phoneNumber: $phoneNumber, bloodGroup: $bloodGroup, email: $email, type: $type, userId: $userId)';
  }
}
