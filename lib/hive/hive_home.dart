import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

class HomPageHive extends StatefulWidget {
  const HomPageHive({Key? key}) : super(key: key);

  @override
  State<HomPageHive> createState() => _HomPageHiveState();
}

class _HomPageHiveState extends State<HomPageHive> {
  List<Map<String, dynamic>> items = [];
  final shoppingBox = Hive.box('shopping_box');
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  /// Get all items from the database
  void refreshItems() {
    final data = shoppingBox.keys.map((key) {
      final value = shoppingBox.get(key);
      return {"key": key, "name": value["name"], "quantity": value["quantity"]};
    }).toList();
    setState(() {
      items = data.reversed.toList();
    });
  }

  /// Create new item
  Future<void> createItem(Map<String, dynamic> newItem) async {
    await shoppingBox.add(newItem);
    refreshItems();
  }

  /// Retrieve a single item from the database by using its key
  Map<String, dynamic> readItem(int key) {
    final item = shoppingBox.get(key);
    return item;
  }

  /// Update a single item
  Future<void> updateItem(int itemKey, Map<String, dynamic> item) async {
    await shoppingBox.put(itemKey, item);
    refreshItems();
  }

  /// Delete a single item
  Future<void> deleteItem(int itemKey) async {
    await shoppingBox.delete(itemKey);
    refreshItems();
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An item has been deleted')));
  }

  /// This function will be triggered when the floating button is pressed
  /// It will also be triggered when you want to update an item

  void showForm(BuildContext context, int? itemKey) async {
    // itemKey == null -> create new item
    // itemKey != null -> update an existing item

    if (itemKey != null) {
      final existingItem =
      items.firstWhere((element) => element['key'] == itemKey);
      _nameController.text = existingItem['name'];
      _quantityController.text = existingItem['quantity'];
    }

    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => Container(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              top: 15,
              left: 15,
              right: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(hintText: 'Name'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _quantityController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: 'Quantity'),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (itemKey == null) {
                      createItem({
                        "name": _nameController.text,
                        "quantity": _quantityController.text
                      });
                    }
                    if (itemKey != null) {
                      updateItem(itemKey, {
                        'name': _nameController.text.trim(),
                        'quantity': _quantityController.text.trim()
                      });
                    }
                    _nameController.text = '';
                    _quantityController.text = '';
                    Navigator.of(context).pop();
                  },
                  child: Text(itemKey == null ? 'Create' : 'Update')),
              const SizedBox(
                height: 15,
              )
            ],
          ),
        ));
  }

  @override
  void initState() {
    super.initState();
    refreshItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KindaCode.com'),
      ),
      body: items.isEmpty
          ? const Center(
        child: Text(
          'No Data',
          style: TextStyle(fontSize: 30),
        ),
      )
          : ListView.builder(
        // the list of items
          itemCount: items.length,
          itemBuilder: (_, index) {
            final currentItem = items[index];
            return Card(
              color: Colors.orange.shade100,
              margin: const EdgeInsets.all(10),
              elevation: 3,
              child: ListTile(
                  title: Text(currentItem['name']),
                  subtitle: Text(currentItem['quantity'].toString()),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Edit button
                      IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () =>
                              showForm(context, currentItem['key'])),
                      // Delete button
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => deleteItem(currentItem['key']),
                      ),
                    ],
                  )),
            );
          }),
      // Add new item button
      floatingActionButton: FloatingActionButton(
        onPressed: () => showForm(context, null),
        child: const Icon(Icons.add),
      ),
    );
  }
}
