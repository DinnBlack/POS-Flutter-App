class CustomerModel {
  final String name;
  final int phoneNumber;
  final DateTime createdAt;
  final int? purchaseCount;
  final String? imageUrl;

//<editor-fold desc="Data Methods">
  const CustomerModel({
    required this.name,
    required this.phoneNumber,
    required this.createdAt,
    this.purchaseCount,
    this.imageUrl,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CustomerModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          phoneNumber == other.phoneNumber &&
          createdAt == other.createdAt &&
          purchaseCount == other.purchaseCount &&
          imageUrl == other.imageUrl);

  @override
  int get hashCode =>
      name.hashCode ^
      phoneNumber.hashCode ^
      createdAt.hashCode ^
      purchaseCount.hashCode ^
      imageUrl.hashCode;

  @override
  String toString() {
    return 'CustomerModel{' +
        ' name: $name,' +
        ' phoneNumber: $phoneNumber,' +
        ' createdAt: $createdAt,' +
        ' purchaseCount: $purchaseCount,' +
        ' imageUrl: $imageUrl,' +
        '}';
  }

  CustomerModel copyWith({
    String? name,
    int? phoneNumber,
    DateTime? createdAt,
    int? purchaseCount,
    String? imageUrl,
  }) {
    return CustomerModel(
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      createdAt: createdAt ?? this.createdAt,
      purchaseCount: purchaseCount ?? this.purchaseCount,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'phoneNumber': this.phoneNumber,
      'createdAt': this.createdAt,
      'purchaseCount': this.purchaseCount,
      'imageUrl': this.imageUrl,
    };
  }

  factory CustomerModel.fromMap(Map<String, dynamic> map) {
    return CustomerModel(
      name: map['name'] as String,
      phoneNumber: map['phoneNumber'] as int,
      createdAt: map['createdAt'] as DateTime,
      purchaseCount: map['purchaseCount'] as int,
      imageUrl: map['imageUrl'] as String,
    );
  }

//</editor-fold>
}