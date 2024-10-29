import 'package:flutter/foundation.dart';

import 'category_model.dart';

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
  final int? quantityOrder;

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
    this.categories,
    this.quantityOrder,
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
          quantityOrder == other.quantityOrder);

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
      quantityOrder.hashCode;

  @override
  String toString() {
    return 'ProductModel{ title: $title, price: $price, image: $image, unit: $unit, request: $request, primeCost: $primeCost, promotionCost: $promotionCost, description: $description, categories: $categories, quantityOrder: $quantityOrder,}';
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
      quantityOrder: (map['quantityOrder'] as num?)?.toInt(),
    );
  }

//</editor-fold>
}
