import 'package:flutter/material.dart';
import 'package:emilios_market/constants.dart';

class CartFull extends StatefulWidget {
  @override
  _CartFullState createState() => _CartFullState();
}

class _CartFullState extends State<CartFull> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Cart"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 18.0),
            //Cart Item Start
            CartProduct(),
            //Cart Item End
            SizedBox(height: 20.0),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Subtotal",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    )),
                Text("4.99",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    )),
              ],
            ),
            SizedBox(height: 4.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Taxes",
                    style: TextStyle(
                      fontSize: 14.0,
                    )),
                Text("4.99",
                    style: TextStyle(
                      fontSize: 14.0,
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Total",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    )),
                Text("4.99",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    )),
              ],
            ),
            Spacer(),
            ClipRRect(
              borderRadius: BorderRadius.circular(29),
              child: MaterialButton(
                onPressed: () {},
                color: kPrimaryColor,
                height: 50.0,
                minWidth: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                child: Text("CONTINUE TO PAYMENT",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    )),
              ),
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}

class CartProduct extends StatelessWidget {
  const CartProduct({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      margin: EdgeInsets.symmetric(vertical: 8.0),
      padding: EdgeInsets.all(18.0),
      child: Row(
        children: <Widget>[
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/images/sample-food.jpg"),
              ),
              borderRadius: BorderRadius.circular(100.0),
            ),
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(children: [
                  Container(
                    width: 180,
                    child: Text(
                      "Food Name",
                      style: TextStyle(fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Spacer(),
                  //FOOD PRICE
                  Text(
                    "4.99",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ]),
                Row(children: [
                  Container(
                    width: 180,
                    child: Text(
                      "Description",
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                  ),
                ]),
                SizedBox(height: 8.0),
                Row(children: <Widget>[
                  InkWell(
                    borderRadius: BorderRadius.circular(4.0),
                    splashColor: Theme.of(context).splashColor,
                    onTap: () {},
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Icon(
                        Icons.remove,
                        color: Colors.white,
                        size: 15.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "1",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(4.0),
                    splashColor: Theme.of(context).splashColor,
                    onTap: () {},
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.lightGreen,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 15.0,
                      ),
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    borderRadius: BorderRadius.circular(4.0),
                    splashColor: Theme.of(context).splashColor,
                    onTap: () {},
                    child: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  )
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
