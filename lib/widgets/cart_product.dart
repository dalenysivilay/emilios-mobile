import 'package:flutter/material.dart';

Widget checkoutCard(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return InkWell(
    onTap: () {},
    child: Column(
      children: [
        //Product Card Size
        Container(
          width: size.width,
          height: 100.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          margin: EdgeInsets.symmetric(vertical: 14.0, horizontal: 14.0),
          child: Container(
            child: Row(
              children: [
                //Left Side of Product Card
                Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0),
                    ),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          "https://firebasestorage.googleapis.com/v0/b/emilios-market.appspot.com/o/1371597437923.jpeg?alt=media&token=7aa646c5-1740-4337-a57c-700ab1e8e405"),
                    ),
                  ),
                ),
                //Right Side of Product Card
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                        left: 16.0, top: 14.0, right: 14.0, bottom: 14.0),
                    child: Column(
                      children: [
                        //Food Name and Food Price Row
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  "Food Name",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                "\$ Price",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        //Food Meat Selection Row
                        Container(
                          child: Row(
                            children: [
                              Flexible(
                                child: Text(
                                  "Type of Meat",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //Space Between
                        Spacer(),
                        //Quantity Selector
                        Container(
                          //Quantity and Trash Row
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //Quantity Widget
                              Column(
                                children: [
                                  Row(children: [
                                    InkWell(
                                      borderRadius: BorderRadius.circular(4.0),
                                      splashColor:
                                          Theme.of(context).splashColor,
                                      onTap: () {},
                                      child: Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                        ),
                                        child: Icon(
                                          Icons.remove,
                                          color: Colors.white,
                                          size: 15.0,
                                        ),
                                      ),
                                    ),
                                    //Quantity Number
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                        "1",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    //Add Button
                                    InkWell(
                                      borderRadius: BorderRadius.circular(4.0),
                                      splashColor:
                                          Theme.of(context).splashColor,
                                      onTap: () {},
                                      child: Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          color: Colors.lightGreen,
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                        ),
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 15.0,
                                        ),
                                      ),
                                    ),
                                  ]),
                                ],
                              ),
                              //Trash or Remove Widget
                              Column(
                                children: [
                                  InkWell(
                                    borderRadius: BorderRadius.circular(4.0),
                                    splashColor: Theme.of(context).splashColor,
                                    onTap: () {},
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
