class CustomerModel {
  final String name;
  final int phoneNumber;
  final DateTime createdAt;

//<editor-fold desc="Data Methods">
  const CustomerModel({
    required this.name,
    required this.phoneNumber,
    required this.createdAt,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CustomerModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          phoneNumber == other.phoneNumber &&
          createdAt == other.createdAt);

  @override
  int get hashCode => name.hashCode ^ phoneNumber.hashCode ^ createdAt.hashCode;

  @override
  String toString() {
    return 'CustomerModel{' +
        ' name: $name,' +
        ' phoneNumber: $phoneNumber,' +
        ' createdAt: $createdAt,' +
        '}';
  }

  CustomerModel copyWith({
    String? name,
    int? phoneNumber,
    DateTime? createdAt,
  }) {
    return CustomerModel(
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'phoneNumber': this.phoneNumber,
      'createdAt': this.createdAt,
    };
  }

  factory CustomerModel.fromMap(Map<String, dynamic> map) {
    return CustomerModel(
      name: map['name'] as String,
      phoneNumber: map['phoneNumber'] as int,
      createdAt: map['createdAt'] as DateTime,
    );
  }

//</editor-fold>
}