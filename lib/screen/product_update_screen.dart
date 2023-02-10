import 'package:crud_app/screen/product_gridView_screen.dart';
import 'package:flutter/material.dart';
import '../rest api/api.dart';
import '../style/reusable_style.dart';

class ProductUpdateScreen extends StatefulWidget {
  final Map productItem;
  const ProductUpdateScreen(this.productItem, {super.key});
  @override
  State<ProductUpdateScreen> createState() => _ProductUpdateScreenState();
}

class _ProductUpdateScreenState extends State<ProductUpdateScreen> {


  Map<String,String> FormValues={"Img":"", "ProductCode":"", "ProductName":"", "Qty":"", "TotalPrice":"", "UnitPrice":""};

  bool Loading=false;



  @override
  void initState(){
    super.initState();
    setState(() {
      FormValues.update("Img", (value) => widget.productItem['Img']);
      FormValues.update("ProductCode", (value) =>  widget.productItem['ProductCode']);
      FormValues.update("ProductName", (value) => widget.productItem['ProductName']) ;
      FormValues.update("Qty", (value) => widget.productItem['Qty']);
      FormValues.update("TotalPrice", (value) => widget.productItem['TotalPrice']) ;
      FormValues.update("UnitPrice", (value) =>widget.productItem['UnitPrice']) ;
    });
  }



  InputOnChange(MapKey, Textvalue){
    setState(() {
      FormValues.update(MapKey, (value) => Textvalue);
    });
  }


  FormOnSubmit() async{
    if(FormValues['Img']!.isEmpty){
      ErrorToast('Image Link Required !');
    }
    else if(FormValues['ProductCode']!.isEmpty){
      ErrorToast('Product Code Required !');
    }
    else if(FormValues['ProductName']!.isEmpty){
      ErrorToast('Product Name Required !');
    }
    else if(FormValues['Qty']!.isEmpty){
      ErrorToast('Product Qty Required !');
    }
    else if(FormValues['TotalPrice']!.isEmpty){
      ErrorToast('Total Price Required !');
    }
    else if(FormValues['UnitPrice']!.isEmpty){
      ErrorToast('Unit Price Required !');
    }
    else{
      setState(() {
        Loading=true;
      });
      await ProductUpdateRequest(FormValues,widget.productItem['_id']);

      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> ProductGridViewScreen()),
              (Route route)=>false
      );
    }
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update Product'),),
      body: Stack(
        children: [
          ScreenBackground(context),
          Container(
              child:Loading?(const Center(child: CircularProgressIndicator(),)):((SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [

                    TextFormField(
                      initialValue:FormValues['ProductName'],
                      onChanged: (Textvalue){
                        InputOnChange("ProductName",Textvalue);
                      },
                      decoration: AppInputDecoration('Product Name'),
                    ),

                    const SizedBox(height: 20),

                    TextFormField(
                      initialValue:FormValues['ProductCode'],
                      onChanged: (Textvalue){
                        InputOnChange("ProductCode",Textvalue);
                      },
                      decoration: AppInputDecoration('Product Code'),
                    ),

                    const SizedBox(height: 20),

                    TextFormField(
                      initialValue:FormValues['Img'],
                      onChanged: (Textvalue){
                        InputOnChange("Img",Textvalue);
                      },
                      decoration: AppInputDecoration('Product Image'),
                    ),

                    const SizedBox(height: 20),

                    TextFormField(
                      initialValue:FormValues['UnitPrice'],
                      onChanged: (Textvalue){
                        InputOnChange("UnitPrice",Textvalue);
                      },
                      decoration: AppInputDecoration('Unit Price'),
                    ),

                    const SizedBox(height: 20),

                    TextFormField(
                      initialValue:FormValues['TotalPrice'],
                      onChanged: (Textvalue){
                        InputOnChange("TotalPrice",Textvalue);
                      },
                      decoration: AppInputDecoration('Total Price'),
                    ),

                    const SizedBox(height: 20),

                    AppDropDownStyle(
                        DropdownButton(
                          value:FormValues['Qty'] ,
                          items:const [
                            DropdownMenuItem(child: Text('Select Qt'),value: "",),
                            DropdownMenuItem(child: Text('1 pcs'),value: "1 pcs",),
                            DropdownMenuItem(child: Text('2 pcs'),value: '2 pcs',),
                            DropdownMenuItem(child: Text('3 pcs'),value: '3 pcs',),
                            DropdownMenuItem(child: Text('4 pcs'),value: '4 pcs',),
                          ],
                          onChanged: (Textvalue){
                            InputOnChange("Qty",Textvalue);
                          },
                          underline: Container(),
                          isExpanded: true,
                        )
                    ),

                    SizedBox(height: 20),

                    Container(
                        child:ElevatedButton(
                            style: AppButtonStyle(),
                            onPressed: (){
                              FormOnSubmit();
                            },
                            child: SuccessButtonChild('Submit')
                        )
                    )
                  ],
                ),
              )))
          )
        ],
      ),
    );
  }
}
