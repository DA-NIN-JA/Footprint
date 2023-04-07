import 'package:flutter/material.dart';

import '../coupons.dart';
import '../const.dart';

class RewardPage extends StatefulWidget {
  final userCoins;

  RewardPage([this.userCoins = 40]);

  @override
  State<RewardPage> createState() => _RewardPageState();
}

class _RewardPageState extends State<RewardPage> with TickerProviderStateMixin {
  int currentPageIndex = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kwhiteColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "assets/textlogo_grey.png",
                    height: 40,
                    width: 115,
                  ),
                  const Icon(
                    Icons.more_vert_rounded,
                    color: kgreyColor,
                    size: 22,
                  ),
                ],
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(top: 30),
                child: const Text(
                  "Rewards",
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w800,
                      color: kgreyColor),
                ),
              ),

              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                    boxShadow: [
                      const BoxShadow(
                        color: Colors.black12,
                        blurStyle: BlurStyle.outer,
                        blurRadius: 10,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: kwhiteColor)),
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                  ),
                ),
              ),
              TabBar(
                controller: _tabController,
                indicatorColor: kgreenColor,
                labelColor: kgreyColor,
                splashFactory: InkSparkle.splashFactory,
                tabs: const <Widget>[
                  Tab(
                    text: "Coupon",
                    icon: Icon(Icons.discount),
                  ),
                  Tab(
                    text: "Health Products",
                    icon: Icon(Icons.shopping_cart),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: <Widget>[
                    Center(
                      child: CouponList(),
                    ),
                    Center(
                      child: ProductList(),
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

class ProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView(
      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.80, // Change
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: dummyHealthProducts
          .map((data) => ProductCard(data.title, data.imageUrl, data.donations))
          .toList(),
    );
  }
}

class CouponList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView(
      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.80, // Change
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: coupons
          .map((data) => ProductCard(data.title, data.imageUrl, data.donations))
          .toList(),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final String donation;

  ProductCard(this.title, this.imagePath, this.donation);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      // mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: const BoxDecoration(
            color: kgreyColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          height: 150,
          width: double.maxFinite,
          child: Image.asset(imagePath, fit: BoxFit.cover),
        ),
        Container(
          color: kmutedwhiteColor,
          padding: EdgeInsets.symmetric(vertical: 6),
          width: double.maxFinite,
          child: RichText(
            text: TextSpan(
              text: title,
              style: TextStyle(color: kgreyColor, fontSize: 16),
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            color: kgreenColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.lock_rounded,
                  color: kwhiteColor,
                ),
                Container(
                  child: Text(
                    donation,
                    style: TextStyle(color: kwhiteColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
