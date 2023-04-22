import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({Key? key}) : super(key: key);

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  TextEditingController nameController = TextEditingController();
  File ? icon, image;
  ImagePicker picker = ImagePicker()

  getIconFromGallery()async{
    final pickImage = await picker.pickImage(source: ImageSource.gallery);
    if(pickImage!=null){
      setState(() {
        icon=File(pickImage.path);
      });
    }
  }
  getImageFromGallery()async{
    final pickImage = await picker.pickImage(source: ImageSource.gallery);
    if(pickImage!=null){
      setState(() {
        image=File(pickImage.path);
      });
    }
  }

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
              color: icon==null?Colors.grey : null,
              height: size. height * .2,
              width: size.width * .5,
              child:icon == null? InkWell(
                onTap: (){

                },
                child: Column(
                children: [
                  Icon(Icons.photo),
                  Text("Upload Icon")
                ],
            ),
              ): Stack(
                children: [
                  Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(icon!),
                    )
                  ),
            ),
                  Positioned(child: IconButton(onPressed: (){
                    setState(() {
                      icon = null;
                    });
                  }, icon: Icon(Icons.cancel_outlined)))
                ],
              )
            ),
            SizedBox(height: 20,),
            Text("Add Category item"),
            Container(
              color: image==null?Colors.grey:null,
              height: size.height * 2,
              width: size.width * .9,
                child:image == null? InkWell(
                  onTap: (){
                    getImageFromGallery;
                  },
                  child: Column(
                    children: [
                      Icon(Icons.photo),
                      Text("Upload Image")
                    ],
                  ),
                ): Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(image!),fit: BoxFit.cover,
                          )
                      ),
                    ),
                    Positioned(child: IconButton(onPressed: (){
                      setState(() {
                        image=null;
                      });
                    },
                      icon: Icon(Icons.cancel_outlined
                    ),))
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}
