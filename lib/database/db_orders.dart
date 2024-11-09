import 'package:pos_flutter_app/models/customer_model.dart';
import 'package:pos_flutter_app/models/order_model.dart';
import 'package:pos_flutter_app/models/product_model.dart';

// Mock database of orders
final List<OrderModel> dbOrders = [
  OrderModel(
    orderId: '001',
    products: [
       ProductModel(
        image: ['assets/images/product1.png'], // Changed to List<String>
        title: 'Coffee',
        unit: 'Cup',
        price: 50,
        request: 'Size L,Ít đá, Không đường',
      ),
       ProductModel(
        image: ['assets/images/product2.png'], // Changed to List<String>
        title: 'Croissant',
        unit: 'Piece',
        price: 100,
      ),
       ProductModel(
        image: ['assets/images/product3.png'], // Changed to List<String>
        title: 'Cake',
        unit: 'Piece',
        price: 125,
        request: 'Size L,Ít đá, Không đường',
      ),
       ProductModel(
        image: ['assets/images/product4.png'], // Changed to List<String>
        title: 'Juice',
        unit: 'Bottle',
        price: 100,
      ),
       ProductModel(
        image: ['assets/images/product1.png'], // Changed to List<String>
        title: 'Espresso',
        unit: 'Cup',
        price: 75,
      ),
       ProductModel(
        image: ['assets/images/product2.png'], // Changed to List<String>
        title: 'Bagel',
        unit: 'Piece',
        price: 100,
        request: 'Size L,Ít đá, Không đường',
      ),
    ],
    totalPrice: 150,
    customer: CustomerModel(name: 'Khách lẻ', phoneNumber: ''),
    orderTime: DateTime.now().subtract( Duration(hours: 1)),
    status: 'Pending',
    paymentStatus: true,
  ),
  OrderModel(
    orderId: '002',
    products: [
      ProductModel(
        image: ['assets/images/product1.png'], // Changed to List<String>
        title: 'Espresso',
        unit: 'Cup',
        price: 75,
      ),
      ProductModel(
        image: ['assets/images/product2.png'], // Changed to List<String>
        title: 'Bagel',
        unit: 'Piece',
        price: 100,
        request: 'Size L,Ít đá, Không đường',
      ),
       ProductModel(
        image: ['assets/images/product3.png'], // Changed to List<String>
        title: 'Juice',
        unit: 'Bottle',
        price: 75,
      ),
    ],
    totalPrice: 250,
    customer: CustomerModel(name: 'Khách lẻ', phoneNumber: ''),
    orderTime: DateTime.now().subtract( Duration(hours: 2)),
    status: 'Completed',
    paymentStatus: false,
  ),
];
