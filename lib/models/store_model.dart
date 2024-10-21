class StoreModel {
  final String id;
  final String name;
  final String businessType;
  final DateTime createdAt;

//<editor-fold desc="Data Methods">
  const StoreModel({
    required this.id,
    required this.name,
    required this.businessType,
    required this.createdAt,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is StoreModel &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              name == other.name &&
              businessType == other.businessType &&
              createdAt == other.createdAt);

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ businessType.hashCode ^ createdAt.hashCode;

  @override
  String toString() {
    return 'StoreModel{' +
        ' id: $id,' +
        ' name: $name,' +
        ' businessType: $businessType,' +
        ' createdAt: $createdAt,' +
        '}';
  }

  StoreModel copyWith({
    String? id,
    String? name,
    String? businessType,
    DateTime? createdAt,
  }) {
    return StoreModel(
      id: id ?? this.id,
      name: name ?? this.name,
      businessType: businessType ?? this.businessType,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'businessType': this.businessType,
      'createdAt': this.createdAt.toIso8601String(),
    };
  }

  factory StoreModel.fromMap(Map<String, dynamic> map, String id) {
    return StoreModel(
      id: id, // Set id from the parameter
      name: map['name'] as String,
      businessType: map['businessType'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }

//</editor-fold>
}
