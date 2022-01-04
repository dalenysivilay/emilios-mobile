import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emilios_grocery/models/orders_model.dart';
import 'package:emilios_grocery/services/firebase_services.dart';
import 'package:flutter/cupertino.dart';

class OrdersProvider with ChangeNotifier {
  List<Orders> _orders = [];
  List<Orders> get getOrders {
    return _orders;
  }

  Future<void> fetchOrders() async {
    FirebaseServices _firebaseServices = FirebaseServices();
    var _uid = _firebaseServices.getUserId();
    await FirebaseFirestore.instance
        .collection('orders')
        .where('userId', isEqualTo: _uid)
        .get()
        .then((QuerySnapshot ordersSnapshot) {
      _orders.clear();
      ordersSnapshot.docs.map((element) {
        _orders.insert(
            0,
            Orders(
              orderId: element.get('orderId'),
              orderNum: element.get('orderNum'),
              productId: element.get('productId'),
              userId: element.get('userId'),
              price: element.get('price').toString(),
              quantity: element.get('quantity').toString(),
              title: element.get('title'),
              orderDate: element.get('orderDate'),
            ));
      });
    });
  }
}
