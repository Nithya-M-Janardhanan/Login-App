import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_task/machine_test/homemodel.dart';
import 'package:sample_task/provider/db_provider.dart';

import '../generated/l10n.dart';

class FavScreen extends StatefulWidget {
  @override
  _FavScreenState createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  CartModel? cartModel;
  @override
  void initState() {
    Future.microtask(() => context.read<ContactsProvider>().loadProducts());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final translated = S.of(context);
    return Scaffold(
      appBar: AppBar(title:  Text(translated.favouritesScreen),backgroundColor: Colors.teal,
        actions: [
        Padding(padding: EdgeInsets.only(right: 20.0),child: IconButton(onPressed: () {
            showDialog(context: context,
                builder: (BuildContext context){
                  return AlertDialog(
                    content: Text("Are you sure want to delete all items?"),
                    actions: [
                      TextButton(onPressed: (){
                        Navigator.pop(context);
                      }, child: Text('No')),
                      TextButton(onPressed: (){
                        context.read<ContactsProvider>().deleteAllData();
                        Navigator.pop(context);
                      }, child: Text('Yes'))
                    ],
                  );
                }
                );

          //showAlertDialog();

        }, icon: Icon(Icons.delete),))
      ],),
      body:  Consumer<ContactsProvider>(
        builder: (context, snapshot,child) {
          if(snapshot.cartModel == null){
            return const SizedBox();
          }
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                leading: Image.network(snapshot.cartModel?[index].value?.image??''),
                title: Text(snapshot.cartModel?[index].value?.name??''),
                subtitle: Text(snapshot.cartModel?[index].value?.actualPrice?? ''),
                trailing: IconButton(
                  onPressed: (){
                    print('????????????${snapshot.cartModel?[index].count}');
                     context.read<ContactsProvider>().deleteData(snapshot.cartModel?[index].id);
                  },
                  icon: Icon(Icons.delete),
                ),
              ),
            );
          },
            itemCount: snapshot.cartModel?.length,
          );
        }
      )
    );
  }
}
