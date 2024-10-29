import 'package:pos_flutter_app/models/product_model.dart';

class OrderModel {
  final String orderId;
  final List<ProductModel> products;
  final double totalPrice;
  final String customerName;
  final DateTime orderTime;
  final String status;
  final String? executor;
  final bool paymentStatus;

//<editor-fold desc="Data Methods">
  const OrderModel({
    required this.orderId,
    required this.products,
    required this.totalPrice,
    required this.customerName,
    required this.orderTime,
    required this.status,
    this.executor,
    required this.paymentStatus,
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
          paymentStatus == other.paymentStatus);

  @override
  int get hashCode =>
      orderId.hashCode ^
      products.hashCode ^
      totalPrice.hashCode ^
      customerName.hashCode ^
      orderTime.hashCode ^
      status.hashCode ^
      executor.hashCode ^
      paymentStatus.hashCode;

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
        '}';
  }

  OrderModel copyWith({
    String? orderId,
    List<ProductModel>? products,
    double? totalPrice,
    String? customerName,
    DateTime? orderTime,
    String? status,
    String? executor,
    bool? paymentStatus,
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
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'orderId': this.orderId,
      'products': this.products,
      'totalPrice': this.totalPrice,
      'customerName': this.customerName,
      'orderTime': this.orderTime,
      'status': this.status,
      'executor': this.executor,
      'paymentStatus': this.paymentStatus,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      orderId: map['orderId'] as String,
      products: map['products'] as List<ProductModel>,
      totalPrice: map['totalPrice'] as double,
      customerName: map['customerName'] as String,
      orderTime: map['orderTime'] as DateTime,
      status: map['status'] as String,
      executor: map['executor'] as String,
      paymentStatus: map['paymentStatus'] as bool,
    );
  }

//</editor-fold>
}
