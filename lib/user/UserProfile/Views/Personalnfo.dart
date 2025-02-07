import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/jsonModels/UserDetails.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:accurate/utils/appColors.dart';
import 'package:flutter/material.dart';

class PersonalInfo extends StatefulWidget {

  UserDetails info;
  PersonalInfo({required this.info});

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50,),
              UiHelper.loadNetworkImage(imageUrl: widget.info?.data?.employee?.profileImage ?? "", height: 150),
              SizedBox(height: 20,),
              AppTextLabels.regularShortText(label: "Welcome", color: AppColors.appBlack, fontSize: 20) ,
              AppTextLabels.boldTextShort(label: widget.info?.data?.name ?? "", fontSize: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.appGreen
                    )
                  ),
                  child: Column(
                    children: [
                      Container(width: double.infinity,),
                      UiHelper.buildRow("Email", widget.info?.data?.email ?? ""),
                      UiHelper.buildRow("Contact", widget.info?.data?.employee?.phoneNumber ?? ""),
                      UiHelper.buildRow("Country", widget.info?.data?.employee?.country ?? "")

                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              AppTextLabels.regularShortText(label: "Emergency Contact", color: AppColors.appBlack, fontSize: 20) ,
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color: AppColors.appGreen
                      )
                  ),
                  child: Column(
                    children: [
                      Container(width: double.infinity,),
                      UiHelper.buildRow("Relative Name", widget.info?.data?.employee?.relativeName ?? ""),
                      UiHelper.buildRow("Relation", widget.info?.data?.employee?.relation ?? ""),
                      UiHelper.buildRow("Contact", widget.info?.data?.employee?.emergencyContact ?? "")

                    ],
                  ),
                ),
              )


            ],
          ),
        ))
      ],
    );
  }
}
