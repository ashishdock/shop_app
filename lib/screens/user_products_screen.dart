import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/user_product_item.dart';
import '../providers/products.dart';
import '../screens/user_products_screen.dart';

class UserProductsScreen extends StatelessWidget {
  // const UserProductsScreen({ Key? key }) : super(key: key);
  static const routeName = '/user-products';

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          const IconButton(
            icon: const Icon(
              Icons.add,
            ),
            onPressed: null,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: productsData.items.length,
          itemBuilder: (context, index) {
            return UserProductItem(
              title: productsData.items[index].title,
              imageUrl: productsData.items[index].imageUrl,
            );
          },
        ),
      ),
    );
  }
}
