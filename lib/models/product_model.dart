class ProductModel {
  final String image;
  final String title;
  final String unit;
  final double price;
  final String? request;

//<editor-fold desc="Data Methods">
  const ProductModel({
    required this.image,
    required this.title,
    required this.unit,
    required this.price,
    this.request,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is ProductModel &&
              runtimeType == other.runtimeType &&
              image == other.image &&
              title == other.title &&
              unit == other.unit &&
              price == other.price &&
              request == other.request);

  @override
  int get hashCode =>
      image.hashCode ^
      title.hashCode ^
      unit.hashCode ^
      price.hashCode ^
      (request?.hashCode ?? 0);

  @override
  String toString() {
    return 'ProductModel{ image: $image, title: $title, unit: $unit, price: $price, request: $request,}'; // Thêm yêu cầu vào toString
  }

  ProductModel copyWith({
    String? image,
    String? title,
    String? unit,
    double? price,
    String? request,
  }) {
    return ProductModel(
      image: image ?? this.image,
      title: title ?? this.title,
      unit: unit ?? this.unit,
      price: price ?? this.price,
      request: request ?? this.request,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'image': this.image,
      'title': this.title,
      'unit': this.unit,
      'price': this.price,
      'request': this.request,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      image: map['image'] as String,
      title: map['title'] as String,
      unit: map['unit'] as String,
      price: map['price'] as double,
      request: map['request'] as String?,
    );
  }

//</editor-fold>
}
