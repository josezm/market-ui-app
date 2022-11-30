import 'package:flutter/material.dart';
import 'package:marketplace/models/product_model.dart';
import 'package:marketplace/utils/colors.dart';
import 'package:marketplace/widgets/custom_buttom.dart';
import 'package:marketplace/widgets/custom_inputs.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    Product item = ModalRoute.of(context)?.settings.arguments as Product;
    return Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          children: [
            Form(
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                            child: Image.network(
                          item.image,
                          width: 50,
                        )),
                        SizedBox(width: 20),
                        Container(
                          width: 200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:[
                              Text(item.title),
                              Text("\$${item.price}"),
                            ]
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 30),
                    width: 300,
                    decoration: BoxDecoration(
                      border: Border.all(color: grey, width: 1.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 30),
                        const CustomText(
                            text: 'INGRESA TUS DATOS DE PAGO', size: 15),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: TextFormField(
                            maxLength: 16,
                            keyboardType: TextInputType.number,
                            style: TextStyle(color: black),
                            decoration: CustomInputs.loginInputDecoration(
                                isPrefixIcon: false, hint: 'Numero de tarjeta'),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: TextFormField(
                            maxLength: 3,
                            keyboardType: TextInputType.number,
                            style: TextStyle(color: black),
                            decoration: CustomInputs.loginInputDecoration(
                                isPrefixIcon: false, hint: 'CVV'),
                          ),
                        ),
                        CustomOutlinedButton(
                          isFilled: true,
                          onPressed: () async {
                            Uri uri = Uri.parse(
                                "https://wa.me/${958237782}?text=Hola! Quiero comprar el producto *${item.title}*");
                            await launch(uri.toString(), forceWebView: false);
                          },
                          text: 'Comprar',
                          loading: false,
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                  Container(
                    child: Image.asset(
                      'assets/images/people.png',
                      width: 250,
                      height: 250,
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}

class CustomText extends StatelessWidget {
  final String text;
  final double size;
  final FontWeight? fontWeight;

  const CustomText(
      {required this.text, this.size = 17, this.fontWeight = FontWeight.bold});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: TextAlign.center,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: primary,
          fontSize: size,
          fontWeight: fontWeight,
        ));
  }
}
