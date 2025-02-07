import 'package:accurate/components/generic/CustomListView.dart';
import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/jsonModels/UserDetails.dart';
import 'package:accurate/utils/DocumentProcessor.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DocumentScreen extends StatefulWidget {
  UserDetails info;
  DocumentScreen({required this.info});

  @override
  State<DocumentScreen> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {


  late List<DocumentStatus> docStatuses;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final requiredDocs = UiHelper.getDocumentsByProfession(widget.info.data?.employee?.profession ?? "");
    final uploadedDocs = widget.info.data?.employee?.documents;
    docStatuses = DocumentProcessor.processDocuments(requiredDocs, uploadedDocs ?? []);

  }



  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20, width: double.infinity,),
        Expanded(child: CustomListView(items: docStatuses ??  [],
          itemBuilder: (context, item, index)=>docItem(index),
        )),
        SizedBox(height: 20,),
      ],
    );
  }
  docItem(int index){
    return Container(
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
        ],)
      ,child: Column(
      children: [
        UiHelper.buildRow("Sr", "${index + 1}"),
        UiHelper.buildRow("Document Name ", docStatuses[index].name ?? ""),
        UiHelper.buildRow("Status ", docStatuses[index].status ?? ""),
        docStatuses[index]?.startDate == null ? Container() : Column(
          children: [
            UiHelper.buildRow("Start ",  convertDateFormat(docStatuses[index]?.startDate)),
            UiHelper.buildRow("Expire ",  convertDateFormat(docStatuses[index]?.expiryDate)),
            UiHelper.buildRow("Expire in  ",  "${docStatuses[index]?.getDaysUntilExpiry() ?? 0} Days"),
          ],
        )



      ],
    ),

    );
  }


  String convertDateFormat(DateTime? date) {
    if (date == null){
      return "";
    }
    else{
      final DateFormat formatter = DateFormat('dd MMM, yyyy');
      return formatter.format(date);
    }

  }
}
