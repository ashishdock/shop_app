import 'package:flutter/material.dart';
// import '../model/product.dart';
import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  // const ProductItem({ Key? key }) : super(key: key);
  final String id;
  final String title;
  final String imageUrl;

  ProductItem({this.id, this.title, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: GridTile(
        child: GestureDetector(
          onTap: () => Navigator.pushNamed(
              context, ProductDetailScreen.routeName,
              arguments: id),
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black45,
          leading: IconButton(
            color: Colors.yellowAccent,
            icon: Icon(Icons.favorite_rounded),
            onPressed: () => print(""),
          ),
          title: Text(
            title,
            style: TextStyle(),
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart_rounded),
            color: Colors.yellow[200],
            onPressed: () => print(""),
          ),
        ),
      ),
    );
  }
}
