import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:marketplace/api/settings_api.dart';
import 'package:marketplace/models/product_model.dart';
import 'package:marketplace/utils/preferences.dart';
import 'package:meta/meta.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(Empty());
  Map<String, dynamic> _map = Map<String, dynamic>();
  List<Product> listProduct = [];
  UserPreferences _prefs = UserPreferences();
  late ProductModel _model;

  @override
  Stream<ProductState> mapEventToState(
    ProductEvent event,
  ) async* {
    if (event is GetProducts) {
      yield* _getProducts(event);
    } else if (event is AddProduct) {
      yield* _addProducts(event);
    } else if (event is FilterProduct) {
      yield* _filterProducts(event);
    }
  }

  Stream<ProductState> _getProducts(GetProducts event) async* {
    yield LoadingProduct();
    _map = await MarketApi.httpGet(path: '/products');

    if (_map["code"] == 200) {
      _model = ProductModel.fromMap(_map);
      listProduct = [..._model.data];

      _prefs.products = listProduct.toString();
      yield LoadedProduct(products: listProduct);
    } else {
      yield Error(message: _map['message']);
    }
  }

  Stream<ProductState> _addProducts(AddProduct event) async* {
    Map<String, dynamic> _product = {
      "id": event.id,
      "title": event.name,
      "price": event.price,
      "category": event.category,
      "image":
          'https://assets.stickpng.com/thumbs/580b57fcd9996e24bc43c325.png',
    };
    final newProduct = Product.fromMap(_product);
    listProduct.add(newProduct);
    _prefs.products = listProduct.toString();
    yield LoadedProduct(products: listProduct);
    Navigator.pop(event.context);
  }

  Stream<ProductState> _filterProducts(FilterProduct event) async* {
    List<Product> listProductFilter = [];
    listProduct.forEach((element) {
      if (element.category == event.nameCategory) {
        listProductFilter.add(element);
      }
    });
    yield LoadedProduct(products: listProductFilter);
  }
}
