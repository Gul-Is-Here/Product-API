import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_api/model/model.dart';
import 'package:product_api/model/networking.dart';
import 'package:product_api/screens/product_detail_screen.dart';

Networking networkingHelper = Networking();

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    networkingHelper.getProductData();
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: FutureBuilder(
            future: networkingHelper.getProductData(),
            builder: (context, AsyncSnapshot<List<Product>> snapshot) {
              if (snapshot.hasData) {
                return GridView.builder(
                    itemCount: snapshot.data!.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 2 / 3,
                            crossAxisSpacing: 20.0,
                            mainAxisSpacing: 20.0),
                    itemBuilder: (context, index) {
                      var productData = snapshot.data;
                      return Card(
                        color: const Color(0xFFFFFFFF),
                        elevation: 10,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadiusDirectional.only(
                          bottomStart: Radius.elliptical(40, 40),
                          topEnd: Radius.elliptical(
                            40,
                            40,
                          ),
                        )),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: Hero(
                                tag: productData![index].id,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return ProductDetailScreen(
                                          productData: productData[index]);
                                    }));
                                  },
                                  child: Image.network(
                                    productData[index].image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                color: Colors.purple,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.elliptical(
                                    40,
                                    40,
                                  ),
                                  topRight: Radius.elliptical(
                                    40,
                                    40,
                                  ),
                                ),
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Text(productData[index].title,
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: const Color(0xFFFFFFFF),
                                            fontFamily: GoogleFonts.montserrat()
                                                .fontFamily,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    // mainAxisAlignment:
                                    //     MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Text(
                                          "\$${productData[index].price.toString()}",
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Color(0xFFFFFFFF)),
                                        ),
                                      ),
                                      const Expanded(
                                        child: SizedBox(),
                                      ),
                                      const Icon(
                                        Icons.star,
                                        color: Color(0xFFFFFFFF),
                                        size: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Text(
                                            productData[index]
                                                .rating
                                                .rate
                                                .toString(),
                                            style: TextStyle(
                                                color: const Color(0xFFFFFFFF),
                                                fontFamily:
                                                    GoogleFonts.montserrat()
                                                        .fontFamily,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    });
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.purple,
                  ),
                );
              }
            }),
      ),
    );
  }
}
