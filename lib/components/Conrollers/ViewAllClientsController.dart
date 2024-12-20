import 'package:accurate/jsonModels/CilentsResponse.dart';
import 'package:accurate/utils/APICall.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:get/get.dart';

class ViewAllClientsController extends GetxController {
  var fetchingData = false.obs;

  List<ClientsData>? allClients;
  List<ClientsData>? filteredClients;
  ClientsData? selectedClient;

  @override
  void onInit() {
    super.onInit();
    getClients();
  }

  void getClients() async {
    APICall api = APICall();
    fetchingData.value = true;
    String url = Urls.allClients;
    var response = await api.getDataWithToken(url);
    ClientsResponse clientsResponse = ClientsResponse.fromJson(response);
    allClients = clientsResponse.data;
    filteredClients = clientsResponse.data;
    fetchingData.value = false;
  }

  filterClients(String value) {
    fetchingData.value = true;
    if (value.isEmpty) {
      filteredClients = allClients;
    } else {
      filteredClients = allClients?.where((client) {
        return (client.name?.toLowerCase().contains(value.toLowerCase()) ?? false) || (client.email!.toLowerCase().contains(value.toLowerCase()) ?? false) || (client.client!.phoneNumber!.toLowerCase().contains(value.toLowerCase()) ?? false);
      }).toList();
    }
    fetchingData.value = false;
  }

}