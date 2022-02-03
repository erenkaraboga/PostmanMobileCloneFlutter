
import 'package:untitled2/service/RequestServiceHelper.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/model/BrandModel.dart';
class GetData extends StatefulWidget {
  const GetData({Key? key}) : super(key: key);
  @override
  _GetDataState createState() => _GetDataState();
}
class _GetDataState extends State<GetData>with AutomaticKeepAliveClientMixin {
late RequestService serviceHelper;
  @override
  void initState() {
    serviceHelper= RequestService();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton,
      body: FutureBuilder<List<BrandModel>?>(
        future: serviceHelper.getData(),
        builder: (context, snap){
          if(snap.connectionState==ConnectionState.done){
            if(snap.hasData){
              return ListView.builder(
                itemCount: snap.data?.length,
                itemBuilder: (context,index){
                  var model = BrandModel();
                  model=snap.data![index];
                  model.imageUrl ??= "https://carstroage.blob.core.windows.net/carscover/images.png191b8b16-454f-48a5-8da3-95756f4f8dfb";
                  return Column(
                    children: [
                      ListTile(
                      leading: CircleAvatar(
                       child: GestureDetector(
                         onTap: () async {
                           await showDialog(
                               context: context,
                               builder: (_) =>showBigImage(model)
                           );
                         },
                       ),
                        backgroundImage: NetworkImage(model.imageUrl.toString()),
                      ),
                        title: Text(model.name.toString()),
                        subtitle: Text(model.madeby.toString()),
                        trailing: Text("id: "+model.id.toString()),
                    )
                   ],
                  );
                },
              );
            }
            else {
              return const Text("data");
            }
          }
          else{
            return  const Center(
              child: CircularProgressIndicator(

              )
            );
          }
        },
      ),
    );
  }

  FloatingActionButton get floatingActionButton{
    return FloatingActionButton(
      child: const Icon(Icons.refresh),
      onPressed:(){
        setState(() {

        });
      },
    );
  }
  Dialog showBigImage(BrandModel model) {
    return Dialog(
      child: Container(
        width: 400,
        height: 200,
        decoration: BoxDecoration(
            image: DecorationImage(
                image:
                NetworkImage(model.imageUrl.toString()),
                fit: BoxFit.cover
            )
        ),
      ),
    );
  }
  @override
  bool get wantKeepAlive =>true;
}
