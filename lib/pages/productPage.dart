
import 'package:flutter/material.dart';
import 'package:marketplace/models/product_model.dart';
import 'package:marketplace/utils/colors.dart';
import 'package:marketplace/widgets/custom_buttom.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    Product item = ModalRoute.of(context)?.settings.arguments as Product;

    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 20),
                    height: 300,
                    child: Image.network(item.image),
                  ),
                  Expanded(
                      child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          item.title,
                          style: TextStyle(
                              color: primary,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Text(
                                "${item.description}${item.description}",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16)),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text("\$${item.price}",
                            style: TextStyle(
                                color: primary,
                                fontSize: 30,
                                fontWeight: FontWeight.bold)),
                        Spacer(),
                        CustomOutlinedButton(
                          isFilled: true,
                          onPressed: () async {
                            Uri uri = Uri.parse(
                                "https://wa.me/${958237782}?text=Hola! Quiero comprar el producto *${item.title}*");
                            await launch(uri.toString(), forceWebView: false);
                          },
                          text: 'Comprar',
                          loading: false,
                        )
                      ],
                    ),
                  )),
                ]),
          ),
        ));
  }
}
