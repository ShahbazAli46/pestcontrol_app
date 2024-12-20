import 'package:accurate/components/generic/CustomListView.dart';
import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/superadmin/Controllers/SingleVehicleDetailsController.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:accurate/utils/appColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SingleVehicleDetailsScreen extends StatefulWidget {
  int vehicleId;
  SingleVehicleDetailsScreen({required this.vehicleId});

  @override
  State<SingleVehicleDetailsScreen> createState() => _SingleVehicleDetailsScreenState();
}

class _SingleVehicleDetailsScreenState extends State<SingleVehicleDetailsScreen> {


  late SingleVehicleDetailsController controller;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(SingleVehicleDetailsController(id: widget.vehicleId));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<SingleVehicleDetailsController>();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(child: Column(
      children: [
        NavWithBack(),
        SizedBox(height: 20,),
        AppTextLabels.boldTextShort(label: "Vehicle Expense", fontSize: 20),
        SizedBox(height: 20,),

        Obx(()=> controller.fetchingData.value ? UiHelper.loader() : Expanded(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.appGreen,
                        width: 1,

                      ),
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.appGreen,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            height: 50,
                            child: Container(
                              width: double.infinity,
                              margin: EdgeInsets.only(left: 10),
                              child: Row(
                                children: [
                                  AppTextLabels.boldTextShort(label: "Assigned To", fontSize: 20, color: Colors.white),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 20,),
                          AppTextLabels.boldTextShort(label: "${controller.user?.name ?? ""}", fontSize: 20)

                        ],
                      ),
                    ),
                  ),
                ),
              ),
              AppTextLabels.boldTextShort(label: "Expense Details", fontSize: 20),
              SizedBox(height: 20,),
              Expanded(child: CustomListView(items: controller.vehicleExpenses ?? [], itemBuilder: (context, item, index)=>expenseItem(index)))
            ],
          ),
        ))
      ],
    )));
  }

  Widget expenseItem( int index) {
    return Card(
      color: Colors.white, // Explicitly set the card color to white
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _buildRow('Sr.', "${index + 1}"),
            _buildRow('Date', "${UiHelper.formatDateToMonthYear(controller.vehicleExpenses?[index].expenseDate ?? "")}"),
            _buildRow('Fuel', controller.vehicleExpenses?[index].fuelAmount ?? ""),
            _buildRow('Maintenance', controller.vehicleExpenses?[index].maintenanceAmount ?? ""),
            _buildRow('Oil', controller.vehicleExpenses?[index].oilAmount ?? ""),
            _buildRow('Next Oil Change Limit', controller.vehicleExpenses?[index].oilChangeLimit ?? ""),

          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String areaObject) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              height: 50,
              decoration: BoxDecoration(color: Color(0xffF9FAFB)),
              child: Center(
                  child: AppTextLabels.regularShortText(
                      label: label,
                      color: AppColors.appBlack,
                      textAlign: TextAlign.center)),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              height: 50,
              decoration: BoxDecoration(),
              child: Center(
                  child: AppTextLabels.regularShortText(
                      label: areaObject,
                      color: AppColors.appBlack,
                      textAlign: TextAlign.center)),
            ),
          ),
        ],
      ),
    );
  }
}
