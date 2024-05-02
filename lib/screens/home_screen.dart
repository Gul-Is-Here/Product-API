import 'package:flutter/material.dart';
import 'package:product_api/model/networking.dart';

Networking networkingHelper = Networking();

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    networkingHelper.getProductData();
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Text('Inshallah Soon Api Data Shown here'),
        ),
      ),
    );
  }
}
