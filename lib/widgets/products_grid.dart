import 'package:flutter/material.dart';
import './product_item.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

class ProductsGrid extends StatelessWidget {
  // const ProductsGrid({
  //   Key key,
  //   @required this.loadedProducts,
  // }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final loadedProducts = productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: loadedProducts.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        childAspectRatio: 3 / 2,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return ChangeNotifierProvider(
          create: (context) => loadedProducts[index],
          child: ProductItem(
              // id: loadedProducts[index].id,
              // title: loadedProducts[index].title,
              // imageUrl: loadedProducts[index].imageUrl,
              ),
        );
      },
    );
  }
}
