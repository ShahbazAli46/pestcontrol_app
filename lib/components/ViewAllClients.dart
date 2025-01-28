import 'package:accurate/components/ViewClientInvoicesScreen.dart';
import 'package:accurate/components/generic/AppSearchInput.dart';
import 'package:accurate/components/generic/CustomListView.dart';
import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/superadmin/Components/AddClientScreen.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:accurate/utils/appColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Conrollers/ViewAllClientsController.dart';

class ViewAllClients extends StatefulWidget {
  ClientScreenViewTypes type;

  ViewAllClients({required this.type});

  @override
  State<ViewAllClients> createState() => _ViewAllClientsState();
}

class _ViewAllClientsState extends State<ViewAllClients> {
  TextEditingController searchController = TextEditingController();

  ViewAllClientsController? clientsController;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    clientsController =
        Get.put(ViewAllClientsController(), tag: Constants.allClients);
    return Scaffold(
      floatingActionButton: addButton(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            NavWithBack(),
            SizedBox(
              height: 20,
            ),
            AppTextLabels.boldTextShort(label: "All Clients", fontSize: 20),
            AppSearchInput(
                title: "Filter Clients",
                controller: searchController,
                onChanged: (value) {
                  clientsController?.filterClients(value);
                }),
            Obx(() => clientsController?.fetchingData.value ?? false
                ? UiHelper.loader()
                : Expanded(
                    child: CustomListView(
                    items: clientsController?.filteredClients ?? [],
                    itemBuilder: (context, job, index) => clientCard(index),
                    onRefresh: () async {
                      clientsController?.getClients();
                    },
                  )))
          ],
        ),
      ),
    );
  }

  Widget clientCard(index) {
    return GestureDetector(
      onTap: () {
        if (widget.type == ClientScreenViewTypes.forPayment) {
          clientsController?.selectedClient =
              clientsController?.filteredClients?[index];
          UiHelper.navigateToNextScreen(context, ViewClientInvoicesScreen());
        }
      },
      child: Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
              ),
              AppTextLabels.regularShortText(
                  label: "Client Name", color: AppColors.appGreen),
              AppTextLabels.boldText(
                  label: clientsController?.filteredClients?[index]?.name ?? "",
                  color: AppColors.appBlack,
                  fontSize: 20),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    Icons.email,
                    size: 20,
                    color: AppColors.appBlack,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  AppTextLabels.regularText(
                      label: clientsController?.filteredClients?[index].email ??
                          "",
                      color: AppColors.appBlack)
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    Icons.phone,
                    size: 20,
                    color: AppColors.appBlack,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  AppTextLabels.regularText(
                      label: clientsController
                              ?.filteredClients?[index].client?.phoneNumber ??
                          "",
                      color: AppColors.appBlack)
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    Icons.link,
                    size: 20,
                    color: AppColors.appBlack,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  AppTextLabels.regularText(
                      label: "Reference By",
                      color: AppColors.appBlack,
                      fontSize: 10)
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  AppTextLabels.regularText(
                      label: clientsController?.filteredClients?[index].client
                              ?.referencable?.name ??
                          "",
                      color: AppColors.appBlack,
                      fontSize: 14)
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    Icons.link,
                    size: 20,
                    color: AppColors.appBlack,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  AppTextLabels.regularText(
                      label: "Balance: ",
                      color: AppColors.appBlack,
                      fontSize: 10)
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  AppTextLabels.regularText(
                      label: clientsController
                              ?.filteredClients?[index].current_balance ??
                          "",
                      color: AppColors.appBlack,
                      fontSize: 14)
                ],
              ),
            ],
          )),
    );
  }

  Widget addButton (){
    return GestureDetector(
      onTap: (){
        UiHelper.navigateToNextScreen(context, AddClientScreen());
      },
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: AppColors.appGreen,
          borderRadius: BorderRadius.circular(25)
        ),
        child: Center(child: Text("+", style: TextStyle(color: Colors.white, fontSize: 30),),),
      ),
    );
  }
}

// enum is to handle different stats to move from Client screen to forward
enum ClientScreenViewTypes {
  forPayment,
  forView
}
