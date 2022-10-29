part of 'product_bloc.dart';

@immutable
abstract class ProductEvent {}

class GetProducts extends ProductEvent {}

class FilterProduct extends ProductEvent {
  final String nameCategory;

  FilterProduct(this.nameCategory);
}

class AddProduct extends ProductEvent {
  final BuildContext context;
  final int id;
  final String name;
  final double price;
  final String category;
  final String pathImage;

  AddProduct(
      {required this.context,
      required this.id,
      required this.name,
      required this.price,
      required this.category,
      required this.pathImage});
}
