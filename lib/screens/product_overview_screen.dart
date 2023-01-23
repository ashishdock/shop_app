import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';
import '../screens/cart_screen.dart';
import '../widgets/products_grid.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';
import '../providers/products.dart';

enum FilterOptions { Favorites, All }

class ProductOverviewScreen extends StatefulWidget {
  // const ProductOverviewScreen({ Key? key }) : super(key: key);
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showOnlyFavorites = false;
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Provider.of<Products>(context, listen: false)
    // .fetchAndSetProducts(); // this won't work and give an error without listen: false
    // Future.delayed(Duration.zero).then((_) =>
    //     Provider.of<Products>(context, listen: false)
    //         .fetchAndSetProducts()); // this also only works with listen: false
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      // to make the below code run only when this page loads and not repeatedly on subsequent times
      setState(
        () {
          _isLoading = true;
        },
      );

      Provider.of<Products>(context)
          .fetchAndSetProducts()
          .then((_) => _isLoading = false); // this runs without listen: false
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Shop'),
        actions: [
          PopupMenuButton(
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text(
                  'Only Favorites',
                ),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text(
                  'Show All',
                ),
                value: FilterOptions.All,
              ),
            ],
            icon: Icon(
              Icons.more_vert,
            ),
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
          ),
          Consumer<Cart>(
            builder: (context, cart, ch) => Badge(
              child: ch,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart_rounded,
              ),
              onPressed: () => {
                Navigator.pushNamed(context, CartScreen.routeName),
              },
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.red,
                color: Colors.yellow,
                strokeWidth: 3,
                semanticsLabel: 'Semantics Label',
                semanticsValue: 'Semantics Value',
              ),
            )
          : ProductsGrid(showFavs: _showOnlyFavorites),
    );
  }
}
