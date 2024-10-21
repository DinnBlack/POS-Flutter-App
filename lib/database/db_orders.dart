import 'package:pos_flutter_app/models/order_model.dart';
import 'package:pos_flutter_app/models/product_model.dart';

// Mock database of orders
final List<OrderModel> dbOrders = [
  OrderModel(
    orderId: '001',
    products: [
      const ProductModel(
        image: ['assets/images/product1.png'], // Changed to List<String>
        title: 'Coffee',
        unit: 'Cup',
        price: 50.0,
        request: 'Size L,Ít đá, Không đường',
      ),
      const ProductModel(
        image: ['assets/images/product2.png'], // Changed to List<String>
        title: 'Croissant',
        unit: 'Piece',
        price: 100.0,
      ),
      const ProductModel(
        image: ['assets/images/product3.png'], // Changed to List<String>
        title: 'Cake',
        unit: 'Piece',
        price: 125.0,
        request: 'Size L,Ít đá, Không đường',
      ),
      const ProductModel(
        image: ['assets/images/product4.png'], // Changed to List<String>
        title: 'Juice',
        unit: 'Bottle',
        price: 100.0,
      ),
      const ProductModel(
        image: ['assets/images/product1.png'], // Changed to List<String>
        title: 'Espresso',
        unit: 'Cup',
        price: 75.0,
      ),
      const ProductModel(
        image: ['assets/images/product2.png'], // Changed to List<String>
        title: 'Bagel',
        unit: 'Piece',
        price: 100.0,
        request: 'Size L,Ít đá, Không đường',
      ),
    ],
    totalPrice: 150.0,
    customerName: 'John Doe',
    orderTime: DateTime.now().subtract(const Duration(hours: 1)),
    status: 'Pending',
    paymentStatus: true,
  ),
  OrderModel(
    orderId: '002',
    products: [
      const ProductModel(
        image: ['assets/images/product1.png'], // Changed to List<String>
        title: 'Espresso',
        unit: 'Cup',
        price: 75.0,
      ),
      const ProductModel(
        image: ['assets/images/product2.png'], // Changed to List<String>
        title: 'Bagel',
        unit: 'Piece',
        price: 100.0,
        request: 'Size L,Ít đá, Không đường',
      ),
      const ProductModel(
        image: ['assets/images/product3.png'], // Changed to List<String>
        title: 'Juice',
        unit: 'Bottle',
        price: 75.0,
      ),
    ],
    totalPrice: 250.0,
    customerName: 'Jane Smith',
    orderTime: DateTime.now().subtract(const Duration(hours: 2)),
    status: 'Completed',
    paymentStatus: false,
  ),
];
