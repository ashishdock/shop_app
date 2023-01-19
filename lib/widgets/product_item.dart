import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import '../model/product.dart';
import '../screens/product_detail_screen.dart';
import '../providers/product.dart';
import '../providers/cart.dart';

class ProductItem extends StatelessWidget {
  // const ProductItem({ Key? key }) : super(key: key);
  // final String id;
  // final String title;
  // final String imageUrl;

  // ProductItem({this.id, this.title, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);

    print('Product rebuilds');
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: GridTile(
        child: GestureDetector(
          onTap: () => Navigator.pushNamed(
              context, ProductDetailScreen.routeName,
              arguments: product.id),
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black45,
          leading: Consumer<Product>(
            builder: (context, product, child) => IconButton(
              color: Colors.yellowAccent,
              icon: Icon(
                product.isFavorite
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded,
              ),
              onPressed: () => product.toggleFavoriteStatus(),
            ),
          ),
          title: Text(
            product.title,
            style: TextStyle(),
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart_rounded),
            color: Colors.yellow[200],
            onPressed: () =>
                cart.addItem(product.id, product.price, product.title),
          ),
        ),
      ),
    );
  }
}
