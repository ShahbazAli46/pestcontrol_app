import 'package:flutter/material.dart';

class TempScreen extends StatefulWidget {
  const TempScreen({Key? key}) : super(key: key);

  @override
  State<TempScreen> createState() => _TempScreenState();
}

class _TempScreenState extends State<TempScreen> {

  int? a,b,c;
  String lable = "Add Button Value";
  String ans= "";

  TextEditingController aValueController = TextEditingController();
  TextEditingController bValueController = TextEditingController();




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Enter value for A "),
              TextField(
                controller: aValueController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter value For A',
                ),
              ),
              SizedBox(height: 20,),

              Text("Enter value for B "),
              TextField(
                controller: bValueController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter value For B',
                ),
              ),
              SizedBox(height: 20,),

              Text('Answer ${ans}'),

              GestureDetector(
                onTap: (){


                  String aValue = aValueController.text;
                  String bValue = bValueController.text;


                  int a = int.parse(aValue);
                  int b = int.parse(bValue);
                  int c = a+b;

                  ans = "${c}";
                  setState(() {
                  });


                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.purple
                  ),
                  child: Center(child: Text("Add", style: TextStyle(color: Colors.white),)),
                ),
              )


            ],
          ),
        ),
      ),
    );
  }
}
