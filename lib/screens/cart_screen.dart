import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_task/machine_test/homemodel.dart';
import 'package:sample_task/provider/db_provider.dart';

import '../generated/l10n.dart';
import 'favourites_screen.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
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
      appBar: AppBar(title:  Text('Cart'),backgroundColor: Colors.teal,
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

        }, icon: Icon(Icons.delete),)),
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Favourites()));
          },
              icon: Icon(Icons.favorite))
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
                subtitle: Row(children:[
                  Text(snapshot.cartModel?[index].value?.actualPrice?? ''),
                  IconButton(onPressed: ()async{
                    int count = snapshot.cartModel?[index].count ?? 0;
                    count = count + 1;
                        context.read<ContactsProvider>().updateCountfn(snapshot.cartModel?[index].id, count);
                  }, icon: Container(decoration:  BoxDecoration(shape: BoxShape.circle,color: Colors.grey[300]),child: Icon(Icons.add))),
                  Text('${snapshot.cartModel?[index].count}'),
                  IconButton(onPressed: (){
                    int countMinus = snapshot.cartModel?[index].count ?? 0;
                    countMinus = countMinus - 1;
                    if(countMinus <= 0){
                      context.read<ContactsProvider>().deleteData(snapshot.cartModel?[index].id);
                    }else{
                      context.read<ContactsProvider>().updateCountfn(snapshot.cartModel?[index].id, countMinus);
                    }
                  },icon: Container(decoration:  BoxDecoration(shape: BoxShape.circle,color: Colors.grey[300]),child: Icon(Icons.remove)),)
                ]),
                trailing: IconButton(
                  onPressed: (){
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
