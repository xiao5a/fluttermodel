import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/cartprovider.dart';
import './cart_page/cart_bottom.dart';
import './cart_page/cartitem.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
      ),
      body: FutureBuilder(
          future: _getCartInfo(context),
          builder: (context, snapshot) {
            List cartList = Provide.value<CartProvider>(context).cartList;
            if (snapshot.hasData && cartList != null && cartList.length !=0) {
    return Stack(
                children: <Widget>[
                  Provide<CartProvider>(
                      builder: (context, child, childCategory) {
                    List cartList =
                        Provide.value<CartProvider>(context).cartList;
                    return ListView.builder(
                      itemCount: cartList.length,
                      itemBuilder: (context, index) {
                        //                      return ListTile(
                        //                          title:Text(cartList[index].goodsName+'数量'+cartList[index].count.toString())
                        //                      );

                        return CartItem(cartList[index]);
                      },
                    );
                  }),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: CartBottom(),
                  )
                ],
              );
            } else {
              return Text('正在加载');
            }
          }),
    );
  }

  Future<String> _getCartInfo(context) async {
    await Provide.value<CartProvider>(context).getCartInfo();
    return "end";
  }
}
