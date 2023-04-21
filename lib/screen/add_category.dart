import 'package:flutter/material.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({Key? key}) : super(key: key);

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Text("Add categ0ry"),
            SizedBox(height: 20,),

            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: "Enter the category name"
              ),
            ),
            SizedBox(height: 20,),

            Text("Add Icon"),
            Container(
              color: Colors.red,
              height: size. height * .2,
              width: size.width * .5,
            ),
            SizedBox(height: 20,),
            Text("Add Category item"),
            Container(
              color: Colors.teal,
              height: size.height * 2,
              width: size.width * .9,
            )
          ],
        ),
      ),
    );
  }
}
