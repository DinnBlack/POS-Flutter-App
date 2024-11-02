import 'package:pos_flutter_app/models/product_model.dart';

class OrderModel {
  final String? orderId;
  final List<ProductModel>? products;
  final int? totalPrice;
  final String? customerName;
  final DateTime? orderTime;
  final String? status;
  final String? executor;
  final bool? paymentStatus;
  final String? note;
  final String? paymentMethod;

//<editor-fold desc="Data Methods">
  const OrderModel({
    this.orderId,
    this.products,
    this.totalPrice,
    this.customerName,
    this.orderTime,
    this.status,
    this.executor,
    this.paymentStatus,
    this.note,
    this.paymentMethod,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrderModel &&
          runtimeType == other.runtimeType &&
          orderId == other.orderId &&
          products == other.products &&
          totalPrice == other.totalPrice &&
          customerName == other.customerName &&
          orderTime == other.orderTime &&
          status == other.status &&
          executor == other.executor &&
          paymentStatus == other.paymentStatus &&
          note == other.note &&
          paymentMethod == other.paymentMethod);

  @override
  int get hashCode =>
      orderId.hashCode ^
      products.hashCode ^
      totalPrice.hashCode ^
      customerName.hashCode ^
      orderTime.hashCode ^
      status.hashCode ^
      executor.hashCode ^
      paymentStatus.hashCode ^
      note.hashCode ^
      paymentMethod.hashCode;

  @override
  String toString() {
    return 'OrderModel{' +
        ' orderId: $orderId,' +
        ' products: $products,' +
        ' totalPrice: $totalPrice,' +
        ' customerName: $customerName,' +
        ' orderTime: $orderTime,' +
        ' status: $status,' +
        ' executor: $executor,' +
        ' paymentStatus: $paymentStatus,' +
        ' note: $note,' +
        ' paymentMethod: $paymentMethod,'
            '}';
  }

  OrderModel copyWith({
    String? orderId,
    List<ProductModel>? products,
    int? totalPrice,
    String? customerName,
    DateTime? orderTime,
    String? status,
    String? executor,
    bool? paymentStatus,
    String? note,
    String? paymentMethod,
  }) {
    return OrderModel(
      orderId: orderId ?? this.orderId,
      products: products ?? this.products,
      totalPrice: totalPrice ?? this.totalPrice,
      customerName: customerName ?? this.customerName,
      orderTime: orderTime ?? this.orderTime,
      status: status ?? this.status,
      executor: executor ?? this.executor,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      note: note ?? this.note,
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'orderId': this.orderId,
      'products': products?.map((product) => product.toMap()).toList(),
      'totalPrice': this.totalPrice,
      'customerName': this.customerName,
      'orderTime': orderTime?.toIso8601String(),
      'status': this.status,
      'executor': this.executor,
      'paymentStatus': this.paymentStatus,
      'note': this.note,
      'paymentMethod': this.paymentMethod,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      orderId: map['orderId'] as String,
      products: (map['products'] as List)
          .map((productMap) => ProductModel.fromMap(productMap))
          .toList(),
      totalPrice: map['totalPrice'] as int,
      customerName: map['customerName'] as String,
      orderTime: DateTime.parse(map['orderTime']),
      status: map['status'] as String,
      executor: map['executor'] as String,
      paymentStatus: map['paymentStatus'] as bool,
      note: map['note'] as String,
      paymentMethod: map['paymentMethod'] as String,
    );
  }

//</editor-fold>
}
