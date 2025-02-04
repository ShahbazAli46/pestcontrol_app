import 'package:accurate/components/MultiSelectCheckbox.dart';
import 'package:accurate/components/generic/SearchableDropdownWithID.dart';
import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/jsonModels/CilentsResponse.dart';
import 'package:accurate/jsonModels/ServiceAgreementResponse.dart';
import 'package:accurate/jsonModels/TermAndConditionsResponse.dart';
import 'package:accurate/jsonModels/TreatmentMethodsResponse.dart';
import 'package:accurate/superadmin/Components/AddServiceScreen.dart';
import 'package:accurate/superadmin/Components/ServiceAgreementScreen.dart';
import 'package:accurate/utils/APICall.dart';
import 'package:accurate/utils/AlertService.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../jsonModels/QuoteServices.dart';

class CreateQuoteController extends GetxController {

  var fetchingData = false.obs;
  List<ClientsData>? allClients = [];
  List<ClientsData>? filteredClients = [];
  List<String> clientNames = [];

  List<DropdownItem> firmNames = [];
  List<DropdownItem> addresses = [];
  var refreshAddress = true.obs;
  var sendingData = false.obs;

  APICall api = APICall();
  var selectedClientID = 0;
  var selectedSelectedAddressID = 0;
  var selectedTermAndConditionID = 0;


  TextEditingController subject = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController tag = TextEditingController();
  TextEditingController duration = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController numberOfJob = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController vat = TextEditingController();
  TextEditingController discount = TextEditingController();



  List<ServiceAgreementResponseData>? agreements = [];
  late RxList animalNames = [].obs;
  List<int> selectedAnimals = [];

  late RxList treatmentMethods = [].obs;
  List<String> billingMethods = [];
  List<int> selectedTreatmentMethods = [];
  List<String> termNames = [];
  late List<TermAndConditionsResponseData> allTerms;

  var refreshQuoteServices = false.obs;
  var refreshServiceView = false.obs;
  List<String> serviceNames = [];
  List<DropdownItem> allServices = [];
  late List<QuoteServices> quoteServices = [];
  int grandTotal = 0;
  double grandTotalWithVat = 0;
  String serviceTime = "";
  bool isMonthly = true;



  @override
  void onInit() {
    super.onInit();
    getClients();
    getServices();
    getTreatmentMethods();
    getTermsAndConditions();

  }

  void getClients() async {
    firmNames.clear();
    addresses.clear();
    allClients?.clear();
    filteredClients?.clear();

    fetchingData.value = true;
    String url = Urls.allClients;
    var response = await api.getDataWithToken(url);
    ClientsResponse clientsResponse = ClientsResponse.fromJson(response);
    allClients = clientsResponse.data;
    filteredClients = clientsResponse.data;
    clientsResponse.data?.forEach((item){
      firmNames.add(DropdownItem(name: item.client?.firmName ?? "", id: item.id ?? 0));
    });
    fetchingData.value = false;

  }

  void getAddresses (int id){
    refreshAddress.value = true;
    allClients?.forEach((item){
      if (item.id == id){
        item.client?.addresses?.forEach((address){
          addresses.add(DropdownItem(name: address.address ?? "", id: address.id ?? 0));
        });
      }
    });
    refreshAddress.value = false;

  }

  void getServices() async {
    String url = Urls.baseURL + "service";
    var response = await api.getDataWithToken(url);
    ServiceAgreementResponse agreementResponse = ServiceAgreementResponse.fromJson(response);
    agreements =  agreementResponse.data;
    agreements?.forEach((item){
      serviceNames.add("${item.serviceTitle} (${item.id})"  ?? "");
      allServices.add(DropdownItem(name: item.serviceTitle ?? "", id: item.id ?? 0));
      animalNames.value.add(CheckboxItem(value: item.pestName ?? "", id: "${item.id}", isSelected: false));
    });

  }

  void processClientInfo(){
    if (selectedClientID == 0){
        AlertService.showAlert("Alert", "Please Select Client");
    } else if (selectedSelectedAddressID == 0){
      AlertService.showAlert("Alert", "Please Select Address");
    } else  if (title.text.isEmpty){
      AlertService.showAlert("Alert", "Please Enter Title");
    } else if (subject.text.isEmpty){
      AlertService.showAlert("Alert", "Please Enter Subject");
    } else if (tag.text.isEmpty) {
      AlertService.showAlert("Alert", "Please enter tag");
    } else if (duration.text.isEmpty) {
      AlertService.showAlert("Alert", "Please enter Duration in months");
    } else if (double.tryParse(duration.text) == null) {
      AlertService.showAlert("Alert", "Duration must be a valid number");
    } else if (desc.text.length < 5){
      AlertService.showAlert("Alert", "Please enter description");
    }
    else{
      UiHelper.navigateToNextScreenGetX(ServiceAgreementScreen());
    }
  }

  void setAnimals(list){
    selectedAnimals.clear();
    selectedAnimals = list;
  }

  void getTreatmentMethods()async {
    String url = Urls.baseURL + "treatment_method";
    var response  = await api.getDataWithToken(url);
    TreatmentMethodsResponse methodsResponse = TreatmentMethodsResponse.fromJson(response);
    methodsResponse.data?.forEach((item){
      treatmentMethods.value.add(CheckboxItem(value: "${item.name}" ?? "", id: "${item.id}", isSelected: false));
    });
  }

  setTreatmentMethods(value){
    selectedTreatmentMethods.clear();
    selectedTreatmentMethods = value;
  }

  void getTermsAndConditions()async{
      String url = Urls.baseURL + "terms_and_condition";
      var response = await api.getDataWithToken(url);
      TermAndConditionsResponse termAndConditionsResponse = TermAndConditionsResponse.fromJson(response);
      allTerms = termAndConditionsResponse.data ?? [];
      termAndConditionsResponse.data?.forEach((item){
        termNames.add(item.name ?? "");
      });
  }

  void setTermID(int index){
    selectedTermAndConditionID = allTerms[index].id ?? 0;
  }

  addService(){

    // refreshQuoteServices.value = true;
    // List<QuoteServicesDetail> details = [];
    // details.add(QuoteServicesDetail(jobType : "monthly", rate: 0, noOfJobs: 0));
    // quoteServices.add(QuoteServices(serviceId: allServices[0].id, detail: details));
    // refreshQuoteServices.value = false;
  }

  addServiceInArray(value){
    refreshServiceView.value = true;
    quoteServices.add(value);
    resetGrandTotal();
    refreshServiceView.value = false;
  }
  void resetGrandTotal (){
    grandTotal = 0;
    quoteServices.forEach((item){
      grandTotal +=  int.parse(item.jobsCount) * int.parse("${item.detail?[0].rate}");
    });
    bool hasQuarterlyService = quoteServices.any((item) => item.serviceType == Constants.quarterly);
    if (hasQuarterlyService) {
      isMonthly = false;
    }
    billingMethods.clear();
    if (isMonthly){
      billingMethods.add("Monthly");
      billingMethods.add("Service");
      billingMethods.add("Yearly");

    }
    else{
      billingMethods.add("Service");
      billingMethods.add("Yearly");
    }
    addVat(vat.text == "" ? "0" : vat.text);
    calculateDiscount(discount.text == "" ? "0"  : discount.text);
  }

  addVat(percentage){
    refreshServiceView.value = true;
    double vatPercentage = double.parse(percentage);
    double vatAmount = grandTotal * (vatPercentage / 100);
    grandTotalWithVat = double.parse("${grandTotal + vatAmount.round()}");
    refreshServiceView.value = false;
  }

  calculateDiscount(String value){
    if (value == ""){
      refreshServiceView.value = true;
      double vatPercentage = double.parse(vat.text);
      double vatAmount = grandTotal * (vatPercentage / 100);
      grandTotalWithVat = double.parse("${grandTotal + vatAmount.round()}");
      refreshServiceView.value = false;
    }
    else{
      refreshServiceView.value = true;
      double vatPercentage = double.parse(vat.text == "" ? "0" : vat.text);
      double vatAmount = grandTotal * (vatPercentage / 100);
      grandTotalWithVat = double.parse("${grandTotal + vatAmount.round()}");
      double disAmount = double.parse(value);
      refreshServiceView.value = true;
      grandTotalWithVat = (grandTotalWithVat - disAmount);
      refreshServiceView.value = false;
    }

  }




}