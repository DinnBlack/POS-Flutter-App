class ItemOptionModel {
  final String name;
  final double price;

//<editor-fold desc="Data Methods">
  const ItemOptionModel({
    required this.name,
    required this.price,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ItemOptionModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          price == other.price);

  @override
  int get hashCode => name.hashCode ^ price.hashCode;

  @override
  String toString() {
    return 'ItemOptionModel{' + ' name: $name,' + ' price: $price,' + '}';
  }

  ItemOptionModel copyWith({
    String? name,
    double? price,
  }) {
    return ItemOptionModel(
      name: name ?? this.name,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'price': this.price,
    };
  }

  factory ItemOptionModel.fromMap(Map<String, dynamic> map) {
    return ItemOptionModel(
      name: map['name'] as String,
      price: map['price'] as double,
    );
  }

//</editor-fold>
}