import 'package:app_lista_de_compras/models/list.model.dart';
import 'package:app_lista_de_compras/pages/create_list.page.dart';
import 'package:app_lista_de_compras/pages/list_details_page.dart';
import 'package:flutter/material.dart';

class HomeListsPage extends StatefulWidget {
  const HomeListsPage({super.key});

  @override
  State<HomeListsPage> createState() => _HomeListsPageState();
}

class _HomeListsPageState extends State<HomeListsPage> {
  List<ListModel> lists = [];

  void _addNewList(String name) {
    setState(() {
      lists.add(ListModel(name: name));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 4,
        centerTitle: true,
        title: const Text(
          "Minhas listas",
          key: Key("appBarTitle"),
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Icon(Icons.diamond, color: Colors.orange[400], size: 32),
          ),
        ],
      ),

      body: lists.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/lista-de-compras.png",
                    key: Key("emptyListImage"),
                    width: 100,
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Crie sua primeira lista\nToque no botão azul",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: lists.length,
              itemBuilder: (context, index) {
                final list = lists[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: InkWell(
                    key: const Key("shoppingListCard"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ListDetailsPage(list: list),
                        ),
                      ).then((_) {
                        setState(() {});
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                list.name,
                                style: const TextStyle(fontSize: 14),
                              ),
                              Text(
                                "${list.checkedItems}/${list.totalItems}",
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          LinearProgressIndicator(
                            value: list.progress,
                            backgroundColor: Colors.grey,
                            color: Colors.green,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        key: const Key("addListBtn"),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CreateListPage()),
          );

          if (result != null && result is String) {
            _addNewList(result);
          }
        },
        shape: const CircleBorder(),
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
