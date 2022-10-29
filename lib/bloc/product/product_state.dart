part of 'product_bloc.dart';

@immutable
abstract class ProductState {}

class Empty extends ProductState {}

class LoadingProduct extends ProductState {}

class LoadedProduct extends ProductState {
  final List<Product> products;
  LoadedProduct({required this.products});
}

class Error extends ProductState {
  final String message;
  Error({required this.message});
}
