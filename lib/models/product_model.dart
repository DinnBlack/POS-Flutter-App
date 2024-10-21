class ProductModel {
  final String title;
  final double price;
  final List<String>? image;
  final String? unit;
  final String? request;
  final double? primeCost;
  final double? promotionCost;
  final String? description;
  final String? category;

//<editor-fold desc="Data Methods">
  const ProductModel({
    required this.title,
    required this.price,
    this.image,
    this.unit,
    this.request,
    this.primeCost,
    this.promotionCost,
    this.description,
    this.category,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductModel &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          price == other.price &&
          image == other.image &&
          unit == other.unit &&
          request == other.request &&
          primeCost == other.primeCost &&
          promotionCost == other.promotionCost &&
          description == other.description &&
          category == other.category);

  @override
  int get hashCode =>
      title.hashCode ^
      price.hashCode ^
      image.hashCode ^
      unit.hashCode ^
      request.hashCode ^
      primeCost.hashCode ^
      promotionCost.hashCode ^
      description.hashCode ^
      category.hashCode;

  @override
  String toString() {
    return 'ProductModel{ title: $title, price: $price, image: $image, unit: $unit, request: $request, primeCost: $primeCost, promotionCost: $promotionCost, description: $description, category: $category,}';
  }

  ProductModel copyWith({
    String? title,
    double? price,
    List<String>? image,
    String? unit,
    String? request,
    double? primeCost,
    double? promotionCost,
    String? description,
    String? category,
  }) {
    return ProductModel(
      title: title ?? this.title,
      price: price ?? this.price,
      image: image ?? this.image,
      unit: unit ?? this.unit,
      request: request ?? this.request,
      primeCost: primeCost ?? this.primeCost,
      promotionCost: promotionCost ?? this.promotionCost,
      description: description ?? this.description,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': this.title,
      'price': this.price,
      'image': this.image,
      'unit': this.unit,
      'request': this.request,
      'primeCost': this.primeCost,
      'promotionCost': this.promotionCost,
      'description': this.description,
      'category': this.category,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      title: map['title'] as String,
      price: (map['price'] as num).toDouble(),
      image: map['image'] != null ? List<String>.from(map['image']) : [],
      unit: map['unit'] as String?,
      request: map['request'] as String?,
      primeCost: (map['primeCost'] as num?)?.toDouble(),
      promotionCost: (map['promotionCost'] as num?)?.toDouble(),
      description: map['description'] as String?,
      category: map['category'] as String?,
    );
  }


//</editor-fold>
}
