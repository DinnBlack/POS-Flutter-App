import 'package:pos_flutter_app/models/user_model.dart';

class StoreModel {
  final String name;
  final String businessType;
  final DateTime createdAt;

//<editor-fold desc="Data Methods">
  const StoreModel({
    required this.name,
    required this.businessType,
    required this.createdAt,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StoreModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          businessType == other.businessType &&
          createdAt == other.createdAt);

  @override
  int get hashCode =>
      name.hashCode ^ businessType.hashCode ^ createdAt.hashCode;

  @override
  String toString() {
    return 'StoreModel{' +
        ' name: $name,' +
        ' businessType: $businessType,' +
        ' createdAt: $createdAt,' +
        '}';
  }

  StoreModel copyWith({
    String? name,
    String? businessType,
    DateTime? createdAt,
  }) {
    return StoreModel(
      name: name ?? this.name,
      businessType: businessType ?? this.businessType,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'businessType': this.businessType,
      'createdAt': this.createdAt.toIso8601String(),
    };
  }

  factory StoreModel.fromMap(Map<String, dynamic> map) {
    return StoreModel(
      name: map['name'] as String,
      businessType: map['businessType'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }

//</editor-fold>
}