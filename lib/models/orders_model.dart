import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Orders with ChangeNotifier {
  final String orderId;
  final String orderNum;
  final String userId;
  final String productId;
  final String title;
  final String price;
  final String quantity;
  final Timestamp orderDate;

  Orders({
    this.orderId,
    this.orderNum,
    this.userId,
    this.productId,
    this.title,
    this.price,
    this.quantity,
    this.orderDate,
  });
}
