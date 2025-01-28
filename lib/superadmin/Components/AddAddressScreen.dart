import 'package:accurate/components/AddressSection.dart';
import 'package:accurate/components/generic/AppInput.dart';
import 'package:accurate/components/generic/GreenButton.dart';
import 'package:accurate/components/generic/SelectableButtonGroup.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/superadmin/Controllers/AddClientController.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddAddressScreen extends StatefulWidget {
  int clientID;
  AddAddressScreen({required this.clientID});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {

  late AddClientController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.find(tag: "addClient" );
    controller.clientID = widget.clientID;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<AddClientController>();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            NavWithBack(),
            SizedBox(height: 20,),
            AppTextLabels.boldTextShort(label: "Add Address", fontSize: 20),
            SizedBox(height: 20,),
            Expanded(child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SelectableButtonGroup(titles: ["From Google Map", "Custom"], onSelect: (selectedIndex){
                          controller.selectedButtonType.value = selectedIndex;
                    }),
                  ),
                  Obx(()=>controller.selectedButtonType.value == 0 ? Column(
                    children: [
                      AddressPicker(onLocationSelected: (Map<String, Object> value ) {
                        controller.lat.text = "${value["latitude"]}";
                        controller.long.text = "${value["longitude"]}";
                        controller.address.text = "${value["address"]}";
                        controller.area.text = "${value["area"]}";
                        controller.country = "${value["country"]}";
                        controller.state = "${value["state"]}";
                        controller.city = "${value["city"]}";
                      },
                      ),

                    ],
                  ) : Column(
                    children: [
                      AppInput(title: "Address", controller: controller.address),
                      AppInput(title: "Latitude", controller: controller.lat, inputType: TextInputType.number,),
                      AppInput(title: "Longitude", controller: controller.long, inputType: TextInputType.number,),
                      AppInput(title: "Area", controller: controller.area,),
                      SizedBox(height: 20,),

                    ],
                  )),
                  Padding(padding: EdgeInsets.all(8),
                    child:GreenButton(title: "Add Address", sendingData: controller.addingAddress, onTap: (){
                      controller.addAddress();
                    },),)


                ],
              ),
            ))

          ],
        ),
      ),
    );
  }
}
