import 'package:pos_flutter_app/models/customer_model.dart';
import 'package:pos_flutter_app/models/product_model.dart';

class OrderModel {
  final String? orderId;
  final List<ProductModel>? products;
  final int? discount;
  final int? shipping;
  final int? surcharge;
  final int? totalPrice;
  final CustomerModel? customer;
  final DateTime? orderTime;
  final String? status;
  final String? executor;
  final String? paymentStatus;
  final int? paidAmount;
  final String? note;
  final String? paymentMethod;
  //
  // int get finalTotalPrice {
  //   int basePrice = totalPrice ?? 0;
  //   return basePrice - (discount ?? 0) + (shipping ?? 0) - (surcharge ?? 0);
  // }

  const OrderModel({
    this.orderId,
    this.products,
    this.discount = 0,
    this.shipping = 0,
    this.surcharge = 0,
    this.totalPrice,
    this.customer,
    this.orderTime,
    this.status,
    this.executor,
    this.paymentStatus,
    this.paidAmount = 0, // Default to 0
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
              discount == other.discount &&
              shipping == other.shipping &&
              surcharge == other.surcharge &&
              totalPrice == other.totalPrice &&
              customer == other.customer &&
              orderTime == other.orderTime &&
              status == other.status &&
              executor == other.executor &&
              paymentStatus == other.paymentStatus && // Updated comparison
              paidAmount == other.paidAmount && // New field comparison
              note == other.note &&
              paymentMethod == other.paymentMethod);

  @override
  int get hashCode =>
      orderId.hashCode ^
      products.hashCode ^
      discount.hashCode ^
      shipping.hashCode ^
      surcharge.hashCode ^
      totalPrice.hashCode ^
      customer.hashCode ^
      orderTime.hashCode ^
      status.hashCode ^
      executor.hashCode ^
      paymentStatus.hashCode ^ // Updated hashCode
      paidAmount.hashCode ^ // New field hashCode
      note.hashCode ^
      paymentMethod.hashCode;

  @override
  String toString() {
    return 'OrderModel{' +
        ' orderId: $orderId,' +
        ' products: $products,' +
        ' discount: $discount,' +
        ' shipping: $shipping,' +
        ' surcharge: $surcharge,' +
        ' totalPrice: $totalPrice,' +
        ' customer: $customer,' +
        ' orderTime: $orderTime,' +
        ' status: $status,' +
        ' executor: $executor,' +
        ' paymentStatus: $paymentStatus,' +
        ' paidAmount: $paidAmount,' + // New field display
        ' note: $note,' +
        ' paymentMethod: $paymentMethod,' +
        '}';
  }

  OrderModel copyWith({
    String? orderId,
    List<ProductModel>? products,
    int? discount,
    int? shipping,
    int? surcharge,
    int? totalPrice,
    CustomerModel? customer,
    DateTime? orderTime,
    String? status,
    String? executor,
    String? paymentStatus, // Changed to String
    int? paidAmount, // New field
    String? note,
    String? paymentMethod,
  }) {
    return OrderModel(
      orderId: orderId ?? this.orderId,
      products: products ?? this.products,
      discount: discount ?? this.discount,
      shipping: shipping ?? this.shipping,
      surcharge: surcharge ?? this.surcharge,
      totalPrice: totalPrice ?? this.totalPrice,
      customer: customer ?? this.customer,
      orderTime: orderTime ?? this.orderTime,
      status: status ?? this.status,
      executor: executor ?? this.executor,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      paidAmount: paidAmount ?? this.paidAmount, // New field
      note: note ?? this.note,
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'products': products?.map((product) => product.toMap()).toList(),
      'discount': discount,
      'shipping': shipping,
      'surcharge': surcharge,
      'totalPrice': totalPrice,
      'customer': customer?.toMap(),
      'orderTime': orderTime?.toIso8601String(),
      'status': status,
      'executor': executor,
      'paymentStatus': paymentStatus,
      'paidAmount': paidAmount, // New field in map
      'note': note,
      'paymentMethod': paymentMethod,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      orderId: map['orderId'] as String?,
      products: (map['products'] as List<dynamic>)
          .map((product) => ProductModel.fromMap(Map<String, dynamic>.from(product)))
          .toList(),
      discount: map['discount'] as int? ?? 0,
      shipping: map['shipping'] as int? ?? 0,
      surcharge: map['surcharge'] as int? ?? 0,
      totalPrice: map['totalPrice'] as int?,
      customer: map['customer'] != null
          ? CustomerModel.fromMap(Map<String, dynamic>.from(map['customer']))
          : null,
      orderTime: map['orderTime'] != null ? DateTime.parse(map['orderTime']) : null,
      status: map['status'] as String?,
      executor: map['executor'] as String?,
      paymentStatus: map['paymentStatus'] as String?, // Changed to String
      paidAmount: map['paidAmount'] as int? ?? 0, // New field initialization
      note: map['note'] as String?,
      paymentMethod: map['paymentMethod'] as String?,
    );
  }
}
