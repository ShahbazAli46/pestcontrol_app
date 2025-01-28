import 'package:accurate/components/generic/AppDropdown.dart';
import 'package:accurate/components/generic/AppInput.dart';
import 'package:accurate/components/generic/GreenButton.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/superadmin/Controllers/AddClientController.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddClientScreen extends StatefulWidget {
  const AddClientScreen({Key? key}) : super(key: key);

  @override
  State<AddClientScreen> createState() => _AddClientScreenState();
}

class _AddClientScreenState extends State<AddClientScreen> {

  late AddClientController controller;

  @override
  void initState() {
    super.initState();  // Always call super.initState() first
    controller = Get.put(AddClientController(), tag: "addClient", permanent: false);

  }

  @override
  void dispose() {
    if (Get.isRegistered<AddClientController>(tag: "addClient")) {
      Get.delete<AddClientController>(tag: "addClient");
    }
    super.dispose();
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
            AppTextLabels.boldTextShort(label: "Add Clients", fontSize: 20),
            SizedBox(height: 20,),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    AppInput(title: "Name", controller: controller.clientName),
                    AppInput(title: "Firm Name", controller: controller.firmName),
                    AppInput(title: "Email", controller: controller.email, inputType: TextInputType.emailAddress,),
                    AppInput(title: "Phone", controller: controller.phone, inputType: TextInputType.phone,),
                    AppInput(title: "Mobile", controller: controller.mobile, inputType: TextInputType.phone,),
                    AppInput(title: "Industry", controller: controller.industryName),
                    Obx(()=> controller.fetchingData.value ?  Container() : AppDropdown(title: "Refferences",options: controller.employeeNames ?? [], onChanged: controller.getId,)),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GreenButton(title: "Add Client", sendingData: controller.sendingData, onTap: controller.addClient),
                    )


                  ],
                ),
              ),
            ),



          ],
        ),
      ),
    );
  }

  onChanged(value, index) {
    print(value);
  }
}
