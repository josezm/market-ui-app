part of 'category_bloc.dart';

@immutable
abstract class CategoryState {}

class Emptys extends CategoryState {}

class LoadingData extends CategoryState {}

class LoadedData extends CategoryState {
  final List<String> category;
  LoadedData({required this.category});
}

class ErrorData extends CategoryState {
  final String message;
  ErrorData({required this.message});
}
