
import 'package:flutter/material.dart';
import '../service/RequestServiceHelper.dart';
class DeleteData extends StatefulWidget {
  const DeleteData({Key? key}) : super(key: key);
  @override
  _DeleteDataState createState() => _DeleteDataState();
}
class _DeleteDataState extends State<DeleteData> {
  late RequestService serviceHelper;
  late TextEditingController _idController;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    _idController=TextEditingController();
    serviceHelper= RequestService();
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
            const SizedBox(height: 100,),
            const Text("Enter the id of the record you want to delete"),
            const SizedBox(height: 20),
            idFieldContainer,
            SendIconButton
          ],
        ),
      ),
    );
  }

  IconButton get SendIconButton{
    return  IconButton(
        onPressed: (){
          if(formKey.currentState!.validate()){
            final result = serviceHelper.deleteData(int.parse(_idController.text));
            result.then((value) => {
              if(value!){
                scaffoldKey.currentState?.showSnackBar(
                    const SnackBar(content: Text("Deleted Succesfuly")))
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
