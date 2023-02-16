import 'package:crud_app/screen/product_create_screen.dart';
import 'package:crud_app/screen/product_update_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../rest api/api.dart';
import '../style/reusable_style.dart';

class ProductGridViewScreen extends StatefulWidget {
  const ProductGridViewScreen({Key? key}) : super(key: key);
  @override
  State<ProductGridViewScreen> createState() => _ProductGridViewScreenState();
}

class _ProductGridViewScreenState extends State<ProductGridViewScreen> {

  List ProductList=[];
  bool Loading=true;

  @override
  void initState(){
    CallData();
    super.initState();
  }


  CallData() async{
    Loading=true;
    var data= await ProductGridViewListRequest();
    setState(() {
      ProductList=data;
      Loading=false;
    });
  }




  DeleteItem(id) async{
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: const Text("Delete !"),
            content: const Text("Onece delete, you can't get it back"),
            actions: [
              OutlinedButton(onPressed: () async {

                Navigator.pop(context);
                setState(() {Loading=true;});
                await ProductDeleteRequest(id);
                await CallData();

              }, child: const Text('Yes')),
              OutlinedButton(onPressed: (){
                Navigator.pop(context);
              }, child: const Text('No')),
            ],
          );

        }
    );
  }

  GotoUpdate(context,productItem){
    Navigator.push(context,
        MaterialPageRoute(builder: (builder)=> ProductUpdateScreen(productItem)
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(' Product List'),),
      body: Stack(
        children: [
          ScreenBackground(context),
          Container(
              child: Loading?(const Center(child: CircularProgressIndicator())):RefreshIndicator(
                  onRefresh: () async {
                    await CallData();
                  },
                  child: GridView.builder(
                      gridDelegate: ProductGridViewStyle(),
                      itemCount: ProductList.length,
                      itemBuilder: (context,index){
                        var productlist = List.from(ProductList.reversed);
                        return Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(child: Image.network(productlist[index]['Img'].toString()
                                  ,fit: BoxFit.fill)
                              ),
                              Container(
                                padding: const EdgeInsets.fromLTRB(5,5,5,8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(productlist[index]['ProductName'].toString()),
                                    const SizedBox(height: 7),
                                    Text("Price: "+productlist[index]['UnitPrice'].toString()+" BDT"),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        OutlinedButton(onPressed: (){
                                          GotoUpdate(context,productlist[index]);
                                        }, child: const Icon(
                                          CupertinoIcons.ellipsis_vertical_circle,
                                          size: 18,
                                          color: colorGreen,
                                        )),
                                        const SizedBox(width: 4),
                                        OutlinedButton(onPressed: (){
                                          DeleteItem(productlist[index]['_id'].toString());
                                        }, child: const Icon(
                                          CupertinoIcons.delete,
                                          size: 18,
                                          color: colorRed,
                                        ))
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      }
                  )
              )
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context,
              MaterialPageRoute(
                  builder: (builder)=>
                      ProductCreateScreen()
              )
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
