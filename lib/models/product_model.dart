import 'option_model.dart';

class ProductModel {
  final String title;
  final int price;
  final List<String>? image;
  final String? unit;
  final String? request;
  final int? primeCost;
  final int? promotionCost;
  final String? description;
  final List<String>? categories;
  int? quantityOrder;
  final List<OptionModel>? options;
  final String? note;
  final int? discount;
  final int? totalPride;

  //<editor-fold desc="Data Methods">
  ProductModel({
    required this.title,
    required this.price,
    this.image,
    this.unit,
    this.request,
    this.primeCost,
    this.promotionCost,
    this.description,
    this.categories,
    this.quantityOrder = 0,
    this.options,
    this.note,
    this.discount = 0,
    this.totalPride,
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
          categories == other.categories &&
          quantityOrder == other.quantityOrder &&
          options == other.options &&
          note == other.note &&
          discount == other.discount &&
          totalPride == other.totalPride);

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
      categories.hashCode ^
      quantityOrder.hashCode ^
      options.hashCode ^
      note.hashCode ^
      discount.hashCode ^
      totalPride.hashCode;

  @override
  String toString() {
    return 'ProductModel{ title: $title, price: $price, image: $image, unit: $unit, request: $request, primeCost: $primeCost, promotionCost: $promotionCost, description: $description, categories: $categories, quantityOrder: $quantityOrder, options: $options}, note: $note}';
  }

  ProductModel copyWith({
    String? title,
    int? price,
    List<String>? image,
    String? unit,
    String? request,
    int? primeCost,
    int? promotionCost,
    String? description,
    List<String>? categories,
    int? quantityOrder,
    List<OptionModel>? options,
    String? note,
    int? discount,
    int? totalPride,
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
      categories: categories ?? this.categories,
      quantityOrder: quantityOrder ?? this.quantityOrder,
      options: options ?? this.options,
      note: note ?? this.note,
      discount: discount ?? this.discount,
      totalPride: totalPride ?? this.totalPride,
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
      'categories': this.categories,
      'quantityOrder': this.quantityOrder,
      'options': this.options,
      'note': this.note,
      'discount': this.discount,
      'totalPride': this.totalPride,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      title: map['title'] as String,
      price: (map['price'] as num).toInt(),
      image: map['image'] != null ? List<String>.from(map['image']) : [],
      unit: map['unit'] as String?,
      request: map['request'] as String?,
      primeCost: (map['primeCost'] as num?)?.toInt(),
      promotionCost: (map['promotionCost'] as num?)?.toInt(),
      description: map['description'] as String?,
      categories:
          map['categories'] != null ? List<String>.from(map['categories']) : [],
      quantityOrder: (map['quantityOrder'] as num?)?.toInt() ?? 0,
      options:
          map['options'] != null ? List<OptionModel>.from(map['options']) : [],
      note: map['note'] as String?,
      discount: (map['discount'] as num?)?.toInt() ?? 0,
      totalPride: (map['totalPride'] as num?)?.toInt() ?? 0,
    );
  }

//</editor-fold>
}
