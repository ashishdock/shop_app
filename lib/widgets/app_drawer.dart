import 'package:flutter/material.dart';
import '../screens/orders_screen.dart';

class AppDrawer extends StatelessWidget {
  // const AppDrawer({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Hello Friend!'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop_rounded),
            title: Text('Shop'),
            onTap: () => Navigator.pushReplacementNamed(context, '/'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment_rounded),
            title: Text('Orders'),
            onTap: () =>
                Navigator.pushReplacementNamed(context, OrdersScreen.routeName),
          ),
        ],
      ),
    );
  }
}
