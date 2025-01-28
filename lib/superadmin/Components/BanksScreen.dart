import 'package:accurate/components/generic/AppInput.dart';
import 'package:accurate/components/generic/AppSearchInput.dart';
import 'package:accurate/components/generic/CustomListView.dart';
import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/superadmin/Components/SingleBankDetailsScreen.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:accurate/utils/appColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controllers/BanksController.dart';

class BanksScreen extends StatefulWidget {
  const BanksScreen({Key? key}) : super(key: key);

  @override
  State<BanksScreen> createState() => _BanksScreenState();
}

class _BanksScreenState extends State<BanksScreen> {

  late BanksController controller;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(BanksController());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<BanksController>();
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
            AppTextLabels.boldTextShort(label: "Banks", color: AppColors.appBlack, fontSize: 20),
            SizedBox(height: 20,),
            AppSearchInput(title: "Filter by Name", controller: controller.filterController, onChanged: controller.filterBankByName,),
            Obx(()=>controller.fetchingData.value ? UiHelper.loader() : Expanded(
              child: Column(
                children: [
                  Container(
                    height: 50,
                    child: Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          child: Center(child: AppTextLabels.regularShortText(label: "Sr", color: AppColors.appBlack),),
                        ),
                        Expanded(child: Container(
                          child: Center(
                            child: AppTextLabels.boldTextShort(label: "Bank Name", fontSize: 15),
                          ),
                        )),
                        Container(
                          height: 50,
                          width: 150,
                          child: Center(child: AppTextLabels.regularShortText(label: "Balance", color: AppColors.appBlack),),
                        ),
                      ],
                    ),
                  ),
                  UiHelper.dashedBoarder(),
                  Expanded(child: CustomListView(
                    items: controller.data ?? [],
                    itemBuilder: (context, item , index)=> bankItem(index),
                  ))
                ],
              ),
            ))

          ],
        ),
      ),
    );
  }

  bankItem(int index){
    return GestureDetector(
      onTap: (){
        UiHelper.navigateToNextScreen(context, (SingleBankDetailsScreen(bankID : controller.data?[index].id ?? 0)));
      },
      child: Column(
        children: [
          Container(
            color: Colors.transparent,
            height: 50,
            child: Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  child: Center(child: AppTextLabels.regularShortText(label: "${index + 1}", color: AppColors.appBlack),),
                ),
                Expanded(child: Container(
                  child: Center(
                    child: AppTextLabels.boldTextShort(label: "${controller.data?[index].bankName}", fontSize: 15),
                  ),
                )),
                Container(
                  height: 50,
                  width: 150,
                  child: Center(child: AppTextLabels.regularShortText(label: controller.data?[index].balance ?? "", color: AppColors.appBlack),),
                ),
              ],
            ),
          ),
          UiHelper.dashedBoarder(),
        ],
      ),
    );
  }
}
