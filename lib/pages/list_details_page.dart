import 'package:app_lista_de_compras/models/bottom_sheet.model.dart';
import 'package:app_lista_de_compras/models/item.model.dart';
import 'package:app_lista_de_compras/models/list.model.dart';
import 'package:flutter/material.dart';

class ListDetailsPage extends StatefulWidget {
  final ListModel list;

  const ListDetailsPage({super.key, required this.list});

  @override
  State<ListDetailsPage> createState() => _ListDetailsPageState();
}

class _ListDetailsPageState extends State<ListDetailsPage> {
  double get totalChecked => widget.list.items
      .where((item) => item.isChecked)
      .fold(0, (sum, item) => sum + item.price);

  double get totalUnchecked => widget.list.items
      .where((item) => !item.isChecked)
      .fold(0, (sum, item) => sum + item.price);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 4,
        iconTheme: const IconThemeData(color: Colors.white),
        title: null,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 24),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            key: const Key("updateListBtn"),
            onPressed: () {
              setState(() {
                widget.list.items.removeWhere((item) => item.isChecked);
              });
            },
            child: const Text(
              "Atualizar",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Text(
              widget.list.name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              height: 0.5,
              width: double.infinity,
              color: Colors.black,
            ),
          ),

          widget.list.items.isEmpty
              ? const Center()
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.list.items.length,
                  itemBuilder: (context, index) {
                    final item = widget.list.items[index];
                    return ListTile(
                      leading: GestureDetector(
                        key: const Key("productCheckbox"),
                        onTap: () {
                          setState(() {
                            item.isChecked = !item.isChecked;
                          });
                        },
                        child: Icon(
                          item.isChecked
                              ? Icons.check_circle
                              : Icons.radio_button_unchecked,
                          color: item.isChecked ? Colors.green : Colors.blue,
                          size: 28,
                        ),
                      ),

                      title: Text(
                        item.name,
                        style: TextStyle(
                          fontSize: 16,
                          color: item.isChecked ? Colors.grey : Colors.black,
                        ),
                      ),

                      trailing: Text(
                        "R\$ ${item.price.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    );
                  },
                ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Não marcados", style: TextStyle(fontSize: 14)),
                    Text(
                      "R\$ ${totalUnchecked.toStringAsFixed(2)}",
                      style: const TextStyle(color: Colors.blue, fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(width: 32),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Marcados", style: TextStyle(fontSize: 14)),
                    Text(
                      "R\$ ${totalChecked.toStringAsFixed(2)}",
                      style: const TextStyle(color: Colors.green, fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        height: 44,
        child: FloatingActionButton.extended(
          key: const Key("addNewItemBtn"),
          backgroundColor: Colors.blue,
          label: const Text(
            "Adicionar",
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          onPressed: () async {
            final result = await showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => const AddItemBottomSheet(),
            );

            if (result != null && result is ItemModel) {
              setState(() {
                widget.list.items.add(result);
              });
            }
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
    );
  }
}
