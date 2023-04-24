import 'dart:convert';
import 'dart:io';

import 'package:admin_app_ecommerce/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../custome_http/custome_http_request.dart';
import '../provider/category_provider.dart';
import '../widget/custome_widget.dart';
import 'package:http/http.dart' as http;

class EditCategoryPage extends StatefulWidget {
  EditCategoryPage({Key? key,this.categoryModel}) : super(key: key);
  CategoryModel ? categoryModel;
  @override
  State<EditCategoryPage> createState() => _EditCategoryPageState();
}

class _EditCategoryPageState extends State<EditCategoryPage> {
  TextEditingController ? nameController;
  File ? icon, image;
  ImagePicker picker = ImagePicker();
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    nameController = TextEditingController(text: widget.categoryModel!.name);
    super.initState();
  }

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
    return ModalProgressHUD(
      inAsyncCall: isLoading==true,
      opacity: 0.5,
      progressIndicator: spinkit,
      blur: .3,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                      getIconFromGallery();
                    },
                    child: Image.network("${imgBaseUrl}${widget.categoryModel!.icon}",fit: BoxFit.cover,),
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
                      getImageFromGallery();
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
              ),
              SizedBox(height: 40,),
              MaterialButton(onPressed: (){
                uploadCategory();
              },
                height: 50,
                minWidth: double.infinity,
                color: Colors.teal,
                child: Text("Upload"),
              )
            ],
          ),
        ),
      ),
    );
  }
  uploadCategory()async{
    try{
      var url = "${baseUrl}category/${widget.categoryModel!.id}/update";
      setState(() {
        isLoading = true;
      });
      var request = await http.MultipartRequest('POST',Uri.parse(url));
      request.headers.addAll(await CustomHttpRequest.getHeaderWithToken());
      request.fields['name'] = nameController!.text.toString();
      if(icon!=null){
        var icn = await http.MultipartFile.fromPath("icon", icon!.path);
        request.files.add(icn);
      }

      if(image!=null){
        var img = await http.MultipartFile.fromPath("image", image!.path);
        request.files.add(img);
      }
      var responce = await request.send();
      setState(() {
        isLoading = false;
      });
      var responceData = await responce.stream.toBytes();
      var responceString = String.fromCharCodes(responceData);
      var data = jsonDecode(responceString);
      print(data);
      print(responce.statusCode);
      if(responce.statusCode == 201){
        showInToast("Category updated successfull");
        Provider.of<CategoryProvider>(context).getCategoryData();
        Navigator.pop(context);
      }else{
        showInToast("Somthing wrong, please try again");
      }
    }catch(e){
      setState(() {
        isLoading = false;
      });
      print("Somthing is wrong $e");
    }


  }
}
