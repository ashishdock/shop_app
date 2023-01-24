import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/products.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './providers/auth.dart';

import './screens/auth_screen.dart';
import './screens/edit_product_screen.dart';
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
          create: (context) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (context) => null,
          update: (context, auth, previous) {
            return Products(auth.token, auth.userId,
                previous == null ? [] : previous.items);
          },
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        //++++++++++++++++++++++++++++++++++++++++++++++++++++
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (context) => null,
          update: (context, auth, previous) {
            return Orders(previous == null ? [] : previous.orders, auth.token);
          },
        ),
        //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      ],
      child: Consumer<Auth>(
        builder: (context, auth, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'MyShop',
            theme: ThemeData(
              primarySwatch: Colors.purple,
              accentColor: Colors.deepOrange,
              fontFamily: 'Lato',
            ),
            home: auth.isAuth ? ProductOverviewScreen() : AuthScreen(),
            routes: {
              ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
              CartScreen.routeName: (context) => CartScreen(),
              OrdersScreen.routeName: (context) => OrdersScreen(),
              UserProductsScreen.routeName: (context) => UserProductsScreen(),
              EditProductScreen.routeName: (context) => EditProductScreen(),
              // ProductOverviewScreen.routeName: (context) => ProductOverviewScreen(),
            },
          );
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
