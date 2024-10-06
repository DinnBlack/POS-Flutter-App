import 'package:pos_flutter_app/models/order_model.dart';
import 'package:pos_flutter_app/models/product_model.dart';

// Mock database of orders
final List<OrderModel> dbOrders = [
  OrderModel(
    orderId: '001',
    products: [
      const ProductModel(
        image: 'assets/images/product1.png',
        title: 'Coffee',
        unit: 'Cup',
        price: 50.0,
        request: 'Size L,Ít đá, Không đường',
      ),
      const ProductModel(
          image: 'assets/images/product2.png',
          title: 'Croissant',
          unit: 'Piece',
          price: 100.0),
      const ProductModel(
        image: 'assets/images/product3.png',
        title: 'Cake',
        unit: 'Piece',
        price: 125.0,
        request: 'Size L,Ít đá, Không đường',
      ),
      const ProductModel(
          image: 'assets/images/product4.png',
          title: 'Juice',
          unit: 'Bottle',
          price: 100.0),
      const ProductModel(
          image: 'assets/images/product1.png',
          title: 'Espresso',
          unit: 'Cup',
          price: 75.0),
      const ProductModel(
        image: 'assets/images/product2.png',
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
          image: 'assets/images/product1.png',
          title: 'Espresso',
          unit: 'Cup',
          price: 75.0),
      const ProductModel(
        image: 'assets/images/product2.png',
        title: 'Bagel',
        unit: 'Piece',
        price: 100.0,
        request: 'Size L,Ít đá, Không đường',
      ),
      const ProductModel(
          image: 'assets/images/product3.png',
          title: 'Juice',
          unit: 'Bottle',
          price: 75.0),
    ],
    totalPrice: 250.0,
    customerName: 'Jane Smith',
    orderTime: DateTime.now().subtract(const Duration(hours: 2)),
    status: 'Completed',
    paymentStatus: false,
  ),
  OrderModel(
    orderId: '003',
    products: [
      const ProductModel(
          image: 'assets/images/product1.png',
          title: 'Latte',
          unit: 'Cup',
          price: 75.0),
    ],
    totalPrice: 75.0,
    customerName: 'Mark Miller',
    orderTime: DateTime.now().subtract(const Duration(days: 1)),
    status: 'Delivered',
    paymentStatus: true,
  ),
  OrderModel(
    orderId: '004',
    products: [
      const ProductModel(
          image: 'assets/images/product1.png',
          title: 'Tea',
          unit: 'Cup',
          price: 50.0),
      const ProductModel(
        image: 'assets/images/product2.png',
        title: 'Muffin',
        unit: 'Piece',
        price: 75.0,
        request: 'Size L,Ít đá, Không đường',
      ),
      const ProductModel(
          image: 'assets/images/product3.png',
          title: 'Cake',
          unit: 'Piece',
          price: 125.0),
      const ProductModel(
        image: 'assets/images/product4.png',
        title: 'Juice',
        unit: 'Bottle',
        price: 100.0,
        request: 'Size L,Ít đá, Không đường',
      ),
    ],
    totalPrice: 350.0,
    customerName: 'Sarah Connor',
    orderTime: DateTime.now().subtract(const Duration(days: 2)),
    status: 'Pending',
    paymentStatus: true,
  ),
  OrderModel(
    orderId: '005',
    products: [
      const ProductModel(
        image: 'assets/images/product1.png',
        title: 'Cappuccino',
        unit: 'Cup',
        price: 80.0,
        request: 'Size L,Ít đá, Không đường',
      ),
      const ProductModel(
          image: 'assets/images/product2.png',
          title: 'Sandwich',
          unit: 'Piece',
          price: 100.0),
    ],
    totalPrice: 180.0,
    customerName: 'Luke Skywalker',
    orderTime: DateTime.now().subtract(const Duration(hours: 5)),
    status: 'Pending',
    paymentStatus: true,
  ),
  OrderModel(
    orderId: '006',
    products: [
      const ProductModel(
        image: 'assets/images/product1.png',
        title: 'Coffee',
        unit: 'Cup',
        price: 50.0,
        request: 'Size L,Ít đá, Không đường',
      ),
      const ProductModel(
          image: 'assets/images/product2.png',
          title: 'Croissant',
          unit: 'Piece',
          price: 100.0),
    ],
    totalPrice: 150.0,
    customerName: 'John Doe',
    orderTime: DateTime.now().subtract(const Duration(hours: 1)),
    status: 'Pending',
    paymentStatus: true,
  ),
  OrderModel(
    orderId: '007',
    products: [
      const ProductModel(
          image: 'assets/images/product1.png',
          title: 'Espresso',
          unit: 'Cup',
          price: 75.0),
      const ProductModel(
          image: 'assets/images/product2.png',
          title: 'Bagel',
          unit: 'Piece',
          price: 100.0),
      const ProductModel(
          image: 'assets/images/product3.png',
          title: 'Juice',
          unit: 'Bottle',
          price: 75.0),
    ],
    totalPrice: 250.0,
    customerName: 'Jane Smith',
    orderTime: DateTime.now().subtract(const Duration(hours: 2)),
    status: 'Completed',
    paymentStatus: false,
  ),
  OrderModel(
    orderId: '008',
    products: [
      const ProductModel(
          image: 'assets/images/product1.png',
          title: 'Latte',
          unit: 'Cup',
          price: 75.0),
    ],
    totalPrice: 75.0,
    customerName: 'Mark Miller',
    orderTime: DateTime.now().subtract(const Duration(days: 1)),
    status: 'Delivered',
    paymentStatus: true,
  ),
  OrderModel(
    orderId: '009',
    products: [
      const ProductModel(
          image: 'assets/images/product1.png',
          title: 'Tea',
          unit: 'Cup',
          price: 50.0),
      const ProductModel(
          image: 'assets/images/product2.png',
          title: 'Muffin',
          unit: 'Piece',
          price: 75.0),
      const ProductModel(
          image: 'assets/images/product3.png',
          title: 'Cake',
          unit: 'Piece',
          price: 125.0),
      const ProductModel(
          image: 'assets/images/product4.png',
          title: 'Juice',
          unit: 'Bottle',
          price: 100.0),
    ],
    totalPrice: 350.0,
    customerName: 'Sarah Connor',
    orderTime: DateTime.now().subtract(const Duration(days: 2)),
    status: 'Pending',
    paymentStatus: true,
  ),
  OrderModel(
    orderId: '010',
    products: [
      const ProductModel(
          image: 'assets/images/product1.png',
          title: 'Cappuccino',
          unit: 'Cup',
          price: 80.0),
      const ProductModel(
          image: 'assets/images/product2.png',
          title: 'Sandwich',
          unit: 'Piece',
          price: 100.0),
    ],
    totalPrice: 180.0,
    customerName: 'Luke Skywalker',
    orderTime: DateTime.now().subtract(const Duration(hours: 5)),
    status: 'Pending',
    paymentStatus: true,
  ),
  OrderModel(
    orderId: '011',
    products: [
      const ProductModel(
          image: 'assets/images/product1.png',
          title: 'Coffee',
          unit: 'Cup',
          price: 50.0),
      const ProductModel(
          image: 'assets/images/product2.png',
          title: 'Croissant',
          unit: 'Piece',
          price: 100.0),
    ],
    totalPrice: 150.0,
    customerName: 'John Doe',
    orderTime: DateTime.now().subtract(const Duration(hours: 1)),
    status: 'Pending',
    paymentStatus: true,
  ),
  OrderModel(
    orderId: '012',
    products: [
      const ProductModel(
          image: 'assets/images/product1.png',
          title: 'Espresso',
          unit: 'Cup',
          price: 75.0),
      const ProductModel(
          image: 'assets/images/product2.png',
          title: 'Bagel',
          unit: 'Piece',
          price: 100.0),
      const ProductModel(
          image: 'assets/images/product3.png',
          title: 'Juice',
          unit: 'Bottle',
          price: 75.0),
    ],
    totalPrice: 250.0,
    customerName: 'Jane Smith',
    orderTime: DateTime.now().subtract(const Duration(hours: 2)),
    status: 'Completed',
    paymentStatus: false,
  ),
  OrderModel(
    orderId: '013',
    products: [
      const ProductModel(
          image: 'assets/images/product1.png',
          title: 'Latte',
          unit: 'Cup',
          price: 75.0),
    ],
    totalPrice: 75.0,
    customerName: 'Mark Miller',
    orderTime: DateTime.now().subtract(const Duration(days: 1)),
    status: 'Delivered',
    paymentStatus: true,
  ),
  OrderModel(
    orderId: '014',
    products: [
      const ProductModel(
          image: 'assets/images/product1.png',
          title: 'Tea',
          unit: 'Cup',
          price: 50.0),
      const ProductModel(
          image: 'assets/images/product2.png',
          title: 'Muffin',
          unit: 'Piece',
          price: 75.0),
      const ProductModel(
          image: 'assets/images/product3.png',
          title: 'Cake',
          unit: 'Piece',
          price: 125.0),
      const ProductModel(
          image: 'assets/images/product4.png',
          title: 'Juice',
          unit: 'Bottle',
          price: 100.0),
    ],
    totalPrice: 350.0,
    customerName: 'Sarah Connor',
    orderTime: DateTime.now().subtract(const Duration(days: 2)),
    status: 'Pending',
    paymentStatus: true,
  ),
  OrderModel(
    orderId: '015',
    products: [
      const ProductModel(
          image: 'assets/images/product1.png',
          title: 'Cappuccino',
          unit: 'Cup',
          price: 80.0),
      const ProductModel(
          image: 'assets/images/product2.png',
          title: 'Sandwich',
          unit: 'Piece',
          price: 100.0),
    ],
    totalPrice: 180.0,
    customerName: 'Luke Skywalker',
    orderTime: DateTime.now().subtract(const Duration(hours: 5)),
    status: 'Pending',
    paymentStatus: true,
  ),
  OrderModel(
    orderId: '016',
    products: [
      const ProductModel(
          image: 'assets/images/product1.png',
          title: 'Coffee',
          unit: 'Cup',
          price: 50.0),
      const ProductModel(
          image: 'assets/images/product2.png',
          title: 'Croissant',
          unit: 'Piece',
          price: 100.0),
    ],
    totalPrice: 150.0,
    customerName: 'John Doe',
    orderTime: DateTime.now().subtract(const Duration(hours: 1)),
    status: 'Pending',
    paymentStatus: true,
  ),
  OrderModel(
    orderId: '017',
    products: [
      const ProductModel(
          image: 'assets/images/product1.png',
          title: 'Espresso',
          unit: 'Cup',
          price: 75.0),
      const ProductModel(
          image: 'assets/images/product2.png',
          title: 'Bagel',
          unit: 'Piece',
          price: 100.0),
      const ProductModel(
          image: 'assets/images/product3.png',
          title: 'Juice',
          unit: 'Bottle',
          price: 75.0),
    ],
    totalPrice: 250.0,
    customerName: 'Jane Smith',
    orderTime: DateTime.now().subtract(const Duration(hours: 2)),
    status: 'Completed',
    paymentStatus: false,
  ),
  OrderModel(
    orderId: '018',
    products: [
      const ProductModel(
          image: 'assets/images/product1.png',
          title: 'Latte',
          unit: 'Cup',
          price: 75.0),
    ],
    totalPrice: 75.0,
    customerName: 'Mark Miller',
    orderTime: DateTime.now().subtract(const Duration(days: 1)),
    status: 'Delivered',
    paymentStatus: true,
  ),
  OrderModel(
    orderId: '019',
    products: [
      const ProductModel(
          image: 'assets/images/product1.png',
          title: 'Tea',
          unit: 'Cup',
          price: 50.0),
      const ProductModel(
          image: 'assets/images/product2.png',
          title: 'Muffin',
          unit: 'Piece',
          price: 75.0),
      const ProductModel(
          image: 'assets/images/product3.png',
          title: 'Cake',
          unit: 'Piece',
          price: 125.0),
      const ProductModel(
          image: 'assets/images/product4.png',
          title: 'Juice',
          unit: 'Bottle',
          price: 100.0),
    ],
    totalPrice: 350.0,
    customerName: 'Sarah Connor',
    orderTime: DateTime.now().subtract(const Duration(days: 2)),
    status: 'Pending',
    paymentStatus: true,
  ),
  OrderModel(
    orderId: '020',
    products: [
      const ProductModel(
          image: 'assets/images/product1.png',
          title: 'Cappuccino',
          unit: 'Cup',
          price: 80.0),
      const ProductModel(
          image: 'assets/images/product2.png',
          title: 'Sandwich',
          unit: 'Piece',
          price: 100.0),
    ],
    totalPrice: 180.0,
    customerName: 'Luke Skywalker',
    orderTime: DateTime.now().subtract(const Duration(hours: 5)),
    status: 'Pending',
    paymentStatus: true,
  ),
];
