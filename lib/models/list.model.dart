import 'package:app_lista_de_compras/models/item.model.dart';

class ListModel {
  final String name;
  final List<ItemModel> items;

  ListModel({required this.name, List<ItemModel>? items}) : items = items ?? [];

  int get totalItems => items.length;

  int get checkedItems => items.where((item) => item.isChecked).length;

  double get progress => totalItems == 0 ? 0 : checkedItems / totalItems;
}
