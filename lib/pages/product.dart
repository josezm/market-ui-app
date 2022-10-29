import 'dart:math';

import 'package:flutter/material.dart';
import 'package:marketplace/bloc/category/category_bloc.dart';
import 'package:marketplace/bloc/product/product_bloc.dart';
import 'package:marketplace/utils/colors.dart';
import 'package:marketplace/widgets/custom_avatar.dart';
import 'package:marketplace/widgets/custom_buttom.dart';
import 'package:marketplace/widgets/custom_inputs.dart';
import 'package:marketplace/widgets/picked_images.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login.dart';

class NewProduct extends StatefulWidget {
  const NewProduct({Key? key}) : super(key: key);

  @override
  _NewProductState createState() => _NewProductState();
}

class _NewProductState extends State<NewProduct> {
  final _formKey = GlobalKey<FormState>();

  String? _name, _price;
  late List<String> _category;
  String? categorySelected;
  String? imagepath;

  @override
  Widget build(BuildContext context) {
    _category = context.watch<CategoryBloc>().listCategory;
    List<DropdownMenuItem<String>> getOptionsDropDown() {
      List<DropdownMenuItem<String>> categories = [];
      _category.forEach((element) {
        categories.add(DropdownMenuItem(
          child: Text(element),
          value: element,
        ));
      });
      return categories;
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            children: [
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          children: const [
                            CustomText(text: 'Instant buy', size: 20),
                            Spacer(),
                            CustomAvatar()
                          ],
                        ),
                      ),
                      Row(
                        children: const [
                          BackButton(color: primary),
                          Text(
                            'publica un nuevo producto',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        child: TextFormField(
                          style: TextStyle(color: black),
                          decoration: CustomInputs.loginInputDecoration(
                              borderside: true,
                              fillcolor: Colors.transparent,
                              isPrefixIcon: false,
                              hint: 'Nombre producto'),
                          validator: (value) {
                            this._name = value;
                            return (value == null || value.isEmpty)
                                ? 'Nombre invalido'
                                : null;
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          style: TextStyle(color: black),
                          decoration: CustomInputs.loginInputDecoration(
                              borderside: true,
                              fillcolor: Colors.transparent,
                              isPrefixIcon: false,
                              hint: 'Precio'),
                          validator: (value) {
                            this._price = value;
                            return (value == null || value.isEmpty)
                                ? 'precio invalido'
                                : null;
                          },
                        ),
                      ),
                      Container(
                        child: DropdownButtonFormField(
                          elevation: 8,
                          items: getOptionsDropDown(),
                          value: categorySelected,
                          decoration: CustomInputs.dropdownDecoration(),
                          validator: (dynamic opt) {
                            return (opt == null || opt.isEmpty)
                                ? 'Seleccione una categoria'
                                : null;
                          },
                          onChanged: (dynamic opt) {
                            setState(() {
                              categorySelected = opt;
                            });
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        child: PickedImages(
                          initialvalue: '',
                          validator: (dynamic value) {
                            this.imagepath = value;
                            return (value.toString().isEmpty)
                                ? 'imagen obligatorio'
                                : null;
                          },
                        ),
                      ),
                      CustomOutlinedButton(
                        isFilled: true,
                        onPressed: () => onformSubmit(),
                        text: 'Publicar',
                        loading: false,
                      ),
                      const SizedBox(height: 20),
                    ],
                  )),
            ],
          ),
        ));
  }

  void onformSubmit() {
    if (_formKey.currentState!.validate()) {
      final double price = double.tryParse(_price!)!;
      Random random = new Random();
      context.read<ProductBloc>().add(AddProduct(
          context: context,
          category: categorySelected!,
          name: _name!,
          price: price,
          pathImage: imagepath!,
          id: random.nextInt(100)));
    }
  }
}
