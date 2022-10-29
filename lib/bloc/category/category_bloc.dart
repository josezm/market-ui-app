import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:marketplace/api/settings_api.dart';
import 'package:meta/meta.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(Emptys());

  Map<String, dynamic> _map = Map<String, dynamic>();
  List<String> listCategory = [];

  @override
  Stream<CategoryState> mapEventToState(
    CategoryEvent event,
  ) async* {
    if (event is GetCategories) {
      yield* _getCategoriesProduct(event);
    }
  }

  Stream<CategoryState> _getCategoriesProduct(GetCategories event) async* {
    yield LoadingData();
    _map = await MarketApi.httpGet(path: '/products/categories');

    if (_map["code"] == 200) {
      listCategory = [..._map['data']];
      yield LoadedData(category: listCategory);
    } else {
      yield ErrorData(message: _map['message']);
    }
  }
}
