import 'package:emilios_market/models/product_model.dart';
import 'package:emilios_market/providers/product_provider.dart';
import 'package:emilios_market/widgets/action_bar.dart';
import 'package:emilios_market/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuPage extends StatelessWidget {
  final ScrollController scrollController;
  static const routeName = '/MenuPage';

  const MenuPage({Key key, this.scrollController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    List<Product> productsList = productProvider.products;

    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: 140.0),
          child: ListView.builder(
            padding: EdgeInsets.only(bottom: 20.0),
            itemCount: productsList.length,
            itemBuilder: (context, index) {
              return ChangeNotifierProvider.value(
                value: productsList[index],
                child: MenuProducts(),
              );
            },
          ),
        ),
        ActionBar(),
      ],
    );
  }
}
