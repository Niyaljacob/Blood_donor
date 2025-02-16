class AppNotification {
  final String text;
  final String date;
  final String donorId;
  final String recipientId;

  // Constructor
  AppNotification({
    required this.text,
    required this.date,
    required this.donorId,
    required this.recipientId,
  });

  // Factory constructor to create an instance from a map (Firestore data)
  factory AppNotification.fromMap(Map<String, dynamic> map) {
    return AppNotification(
      text: map['text'] as String,
      date: map['date'] as String,
      donorId: map['donorId'] as String,
      recipientId: map['recipientId'] as String,
    );
  }

  // Method to convert the instance into a map (for Firestore)
  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'date': date,
      'donorId': donorId,
      'recipientId': recipientId,
    };
  }

  // Equality operator override for comparisons
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppNotification &&
        other.text == text &&
        other.date == date &&
        other.donorId == donorId &&
        other.recipientId == recipientId;
  }

  // Hashcode override for use in hash-based collections
  @override
  int get hashCode {
    return text.hashCode ^
        date.hashCode ^
        donorId.hashCode ^
        recipientId.hashCode;
  }

  // ToString for easier debugging
  @override
  String toString() {
    return 'AppNotification(text: $text, date: $date, donorId: $donorId, recipientId: $recipientId)';
  }
}
