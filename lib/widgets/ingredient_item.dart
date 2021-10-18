import 'package:emilios_market/models/product_model.dart';
import 'package:flutter/material.dart';

class IngredientItem extends StatelessWidget {
  final Product product;
  final bool isSelected;
  final ValueChanged<Product> onSelectedIngr;

  const IngredientItem({
    Key key,
    @required this.product,
    @required this.isSelected,
    @required this.onSelectedIngr,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        product.desc,
      ),
    );
  }
}
