import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_sm/src/constants/Images.dart';
import 'package:test_sm/src/models/ProductModel.dart';
import 'package:test_sm/src/utils/utils.dart';
import 'package:test_sm/src/views/home/HomeScreenViewModel.dart';
import 'package:test_sm/src/views/home/components/animated_rating.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeScreenViewmodel _homeViewmodel;

  @override
  void initState() {
    super.initState();
    _homeViewmodel = HomeScreenViewmodel();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _homeViewmodel.init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => _homeViewmodel,

      child: Consumer<HomeScreenViewmodel>(
        builder: (context, viewModel, child) {
          if (viewModel.productList.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: viewModel.productList.length,
                  separatorBuilder: (context, index) => Utils.vertS(10),
                  itemBuilder: (context, index) {
                    final product = viewModel.productList[index];
                    return _buildShopItems(product);
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildShopItems(
    Product product, {
    bool showStock = true,
    Color? color,
  }) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: color ?? Colors.blue[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CachedNetworkImage(
                        imageUrl: product.thumbnail!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  if (product.discountPercentage! >= 1)
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                        child: Text("${product.discountPercentage!.round()}%"),
                      ),
                    ),
                ],
              ),
              Utils.horiS(10),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Utils.vertS(2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            ProductRating(
                              rating: product.rating,
                              colors: [Colors.amberAccent, Colors.yellowAccent],
                            ),
                            Utils.vertS(5),
                            AnimatedOpacity(
                              opacity: showStock ? 1 : 0,
                              curve: Curves.easeInBack,
                              duration: Duration(seconds: 1),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin:
                                        product.availabilityStatus ==
                                            "Low Stock"
                                        ? EdgeInsets.only(top: 8)
                                        : null,
                                    child: Image.asset(
                                      product.availabilityStatus == "Low Stock"
                                          ? AppImages.lowStock
                                          : AppImages.inStock,
                                      height: 20,
                                      width: 20,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Utils.horiS(5),
                                  Text(
                                    product.availabilityStatus!,
                                    style: TextStyle(
                                      color:
                                          product.availabilityStatus ==
                                              "Low Stock"
                                          ? Colors.red
                                          : Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      letterSpacing: -0.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '\$${product.price!}',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                letterSpacing: -0.5,
                              ),
                            ),
                            Utils.vertS(5),
                            SizedBox(
                              height: 35,
                              width: 50,
                              child: IconButton.filled(
                                alignment: Alignment.center,
                                onPressed: () {},
                                icon: Icon(
                                  Icons.add_shopping_cart_rounded,
                                  size: 20,
                                ),
                                color: Colors.white,
                                style: ButtonStyle(
                                  backgroundColor: WidgetStatePropertyAll(
                                    Colors.blue[900],
                                  ),
                                  shape: WidgetStatePropertyAll(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(100),
                                        bottomRight: Radius.circular(100),

                                        topLeft: Radius.circular(40),
                                        bottomLeft: Radius.circular(40),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
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
    );
  }
}
