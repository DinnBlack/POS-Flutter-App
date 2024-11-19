import 'package:pos_flutter_app/features/store/model/store_model.dart';

class UserModel {
  final String uid;
  final String email;
  final String displayName;
  final List<StoreModel>? stores;

//<editor-fold desc="Data Methods">
  const UserModel({
    required this.uid,
    required this.email,
    required this.displayName,
    this.stores,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserModel &&
          runtimeType == other.runtimeType &&
          uid == other.uid &&
          email == other.email &&
          displayName == other.displayName &&
          stores == other.stores);

  @override
  int get hashCode =>
      uid.hashCode ^ email.hashCode ^ displayName.hashCode ^ stores.hashCode;

  @override
  String toString() {
    return 'UserModel{' +
        ' uid: $uid,' +
        ' email: $email,' +
        ' displayName: $displayName,' +
        ' stores: $stores,' +
        '}';
  }

  UserModel copyWith({
    String? uid,
    String? email,
    String? displayName,
    List<StoreModel>? stores,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      stores: stores ?? this.stores,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': this.uid,
      'email': this.email,
      'displayName': this.displayName,
      'stores': this.stores,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      email: map['email'] as String,
      displayName: map['displayName'] as String,
      stores: map['stores'] as List<StoreModel>,
    );
  }

//</editor-fold>
}
