import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/products.dart';
import './providers/cart.dart';
import './providers/orders.dart';

import './screens/user_products_screen.dart';
import './screens/orders_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/product_overview_screen.dart';
import './screens/cart_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Products(),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (context) => Orders(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        home: ProductOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
          CartScreen.routeName: (context) => CartScreen(),
          OrdersScreen.routeName: (context) => OrdersScreen(),
          UserProductsScreen.routeName: (context) => UserProductsScreen(),
        },
      ),
    );
  }
}



// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('MyShop'),
//       ),
//       body: Center(
//         child: Text('Let\'s build a shop!'),
//       ),
//     );
//   }
// }
