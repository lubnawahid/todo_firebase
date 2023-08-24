import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Todo_firebase extends StatefulWidget {
  const Todo_firebase({Key? key}) : super(key: key);

  @override
  State<Todo_firebase> createState() => _Todo_firebaseState();
}

class _Todo_firebaseState extends State<Todo_firebase> {
  List item=['shirt','pants','churidhar'];
  List price=['800','750','2000'];
  final CollectionReference _product =  FirebaseFirestore.instance.collection('products');
  final TextEditingController pnameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  Future<void>update(DocumentSnapshot? documentSnapshot) async{
    if(documentSnapshot != null){
      pnameController.text=documentSnapshot['name'];
      priceController.text = documentSnapshot['price'].toString();
    }
await showDialog(
  context: context,
  builder: (context)=>AlertDialog(
    title: Text(
      'Update item',
      style: TextStyle(fontSize: 19,fontWeight: FontWeight.w600),

    ),
    content: SizedBox(
      height: MediaQuery.of(context).size.height* .3,
      child: Column(
        children: [
          TextField(
            controller: pnameController,
            decoration: InputDecoration(
              labelText: "Name",
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.brown),
              ),
            ),
          ),
          TextField(
            controller: priceController,
            decoration: InputDecoration(
              labelText: "Price",
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.brown),
              ),
            ),
          ),
    SizedBox(
    height: 50,
    ),
    ElevatedButton(
    onPressed: () async {
      final String name = pnameController.text;
      final double? price = double.parse(priceController.text);
      if (price != null) {
        await _product.doc(documentSnapshot!.id).update(
            {'name': name, 'price': price});
        pnameController.text = '';
        priceController.text = '';
      }
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Todo_firebase()));
    },
    child: Text('Update'),
style: ElevatedButton.styleFrom(backgroundColor: Colors.red)
    )
        ],
      ),
  ),
),
);
  }
  Future<void> delete(String product)async{
    await _product.doc(product).delete();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a product')));
  }


  ))

  }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
