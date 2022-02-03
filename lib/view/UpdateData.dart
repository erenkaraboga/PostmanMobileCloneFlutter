
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


import '../../service/RequestServiceHelper.dart';
class UpdateData extends StatefulWidget {
  const UpdateData({Key? key}) : super(key: key);
  @override
  _UpdateDataState createState() => _UpdateDataState();
}
class _UpdateDataState extends State<UpdateData> {
  late RequestService serviceHelper;
  File? image;
  late TextEditingController _idController;
  late TextEditingController _nameController;
  late TextEditingController _madebyController;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    _idController=TextEditingController();
    _nameController= TextEditingController();
    _madebyController= TextEditingController();
    serviceHelper= RequestService();
  }
  Future getImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(pickedFile==null){
      image=null;
    }
    final tempImage= File(pickedFile!.path);
    setState(() {
      image = tempImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10,),
            InkWell(
                onTap: (){
                  getImage();
                },
                child: ImagePickerCircleButton
            ),
            const SizedBox(height: 20),
            idFieldContainer,
            const SizedBox(height: 20),
            nameFieldContainer,
            const SizedBox(height: 20),
            madeByFieldContainer,
            SendIconButton
          ],
        ),
      ),
    );
  }
  Card get ImagePickerCircleButton{
    return Card(
        color: Colors.white70,
        child: Column(
          children: [
            CircleAvatar(
                radius: 90,
                child: image != null
                    ? CircleAvatar(
                    radius: 90,
                    backgroundImage: FileImage(
                      File(image!.path),
                    )
                )
                    : const CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 90,
                  child: Icon(Icons.image,size: 75,color: Colors.black,),
                )
            ),
            const Text("Pick Image",style: TextStyle(fontSize: 20),)
          ],
        )
    );
  }
  IconButton get SendIconButton{
    return  IconButton(
        onPressed: (){
          if(formKey.currentState!.validate()){
            var result = serviceHelper.updateData(image, int.parse(_idController.text), _nameController.text, _madebyController.text);
            result.then((value) => {
              if(value!){
                scaffoldKey.currentState?.showSnackBar(
                    const SnackBar(content: Text("Posted Succesfuly")))
              }
              else{
                scaffoldKey.currentState?.showSnackBar(
                    const SnackBar(content: Text("Error")))
              }
            });
          }
        },
        icon: const Icon(Icons.send)
    );
  }
  Container get madeByFieldContainer{
    return Container(
      margin: const EdgeInsets.only(left: 10,right: 10),
      child: TextFormField(
        controller: _madebyController,
        decoration: const InputDecoration(
            labelText: "MadeBy",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(50))
            )
        ),
        validator: (val) {
          if (val!.isEmpty) {
            return "It Cant be Empty";
          }
          else {
            return null;
          }
        },
      ),
    );
  }
  Container get nameFieldContainer{
    return  Container(
      margin: const EdgeInsets.only(left: 10,right: 10),
      child: TextFormField(
        controller: _nameController,
        decoration: const InputDecoration(
            labelText: "Name",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(50))
            )
        ),
        validator: (val) {
          if (val!.isEmpty) {
            return "It Cant be Empty";
          }
          else {
            return null;
          }
        },
      ),
    );
  }

  Container get idFieldContainer{
    return  Container(
      margin: const EdgeInsets.only(left: 10,right: 10),
      child: TextFormField(
        keyboardType: TextInputType.number,
        controller: _idController,
        decoration: const InputDecoration(
            labelText: "Id",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(50))
            )
        ),
        validator: (val) {
          if (val!.isEmpty) {
            return "It Cant be Empty";
          }
          else {
            return null;
          }
        },
      ),
    );
  }
}
