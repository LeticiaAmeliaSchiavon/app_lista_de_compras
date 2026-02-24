import 'package:flutter/material.dart';

class CreateListController {
  final TextEditingController nameController = TextEditingController();
  bool isLoading = false;

  Future<String?> createList() async {
    if (nameController.text.isEmpty) return null;

    await Future.delayed(const Duration(seconds: 2));

    return nameController.text;
  }

  void dispose() {
    nameController.dispose();
  }
}
