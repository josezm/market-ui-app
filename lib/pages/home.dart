import 'package:flutter/material.dart';
import 'package:marketplace/bloc/category/category_bloc.dart';
import 'package:marketplace/bloc/product/product_bloc.dart';
import 'package:marketplace/models/product_model.dart';
import 'package:marketplace/utils/colors.dart';
import 'package:marketplace/utils/preferences.dart';
import 'package:marketplace/widgets/custom_avatar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserPreferences _prefs = UserPreferences();
  late List<String> listcategory;
  @override
  void initState() {
    context.read<CategoryBloc>().add(GetCategories());
    context.read<ProductBloc>().add(GetProducts());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      const CustomText(text: 'Instant buy', size: 20),
                      Spacer(),
                      IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/newProduct');
                          },
                          icon: Icon(Icons.add, color: secondary, size: 30))
                    ],
                  ),
                ),
                Row(
                  children: [
                    CustomAvatar(),
                    Text('${_prefs.username} ${_prefs.userlastname}')
                  ],
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 60,
                  child: BlocBuilder<CategoryBloc, CategoryState>(
                    builder: (context, state) {
                      if (state is LoadedData) {
                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.category.length,
                            itemBuilder: (_, index) {
                              return Categories(state.category[index]);
                            });
                      } else {
                        return Center(
                            child:
                                Container(child: CircularProgressIndicator()));
                      }
                    },
                  ),
                ),
                Expanded(
                  child: BlocBuilder<ProductBloc, ProductState>(
                    builder: (context, state) {
                      if (state is LoadedProduct) {
                        return ListView.builder(
                            padding: EdgeInsets.only(top: 30),
                            itemCount: state.products.length,
                            itemBuilder: (_, index) {
                              return ItemProduct(state.products[index]);
                            });
                      }
                      return Container();
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class ItemProduct extends StatelessWidget {
  final Product item;
  const ItemProduct(this.item);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/product', arguments: item);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: grey, width: 1.5),
                  ),
                ),
                Image.network(
                  item.image,
                  height: 170,
                  width: 170,
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 30),
              child: Row(
                children: [
                  Expanded(child: CustomText(text: '${item.title}', size: 14)),
                  Spacer(),
                  Text(item.price.toString())
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Categories extends StatelessWidget {
  final String text;
  const Categories(this.text);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<ProductBloc>().add(FilterProduct(text));
      },
      child: Container(
        margin: const EdgeInsets.only(right: 20),
        alignment: Alignment.center,
        width: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: grey, width: 1.5),
        ),
        child: Text(text),
      ),
    );
  }
}
