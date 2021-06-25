import 'package:fungsi_tanggal/ahlStatusModel.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class StatusFileController extends GetxController {
  var isLoading = true.obs;
  var dataFrekuansi = AhlStatusModel().obs;
  var isUserLogin = false.obs;

  static var _client = http.Client();

  @override
  void onInit() {
    fetchRemoteLogin();
    super.onInit();
  }

  Future fetchRemoteLogin() async {
    isLoading(true);
    try {
      var questions = await _fetchLoginResponse();

      if (questions != null) {
        dataFrekuansi.value = questions;
      }
    } finally {
      isLoading(false);
    }
  }

  Future<AhlStatusModel> _fetchLoginResponse() async {
    var url = 'https://aviasi-solusi.com/pdf/test-data.php';
    var response = await _client.post(url, body: {
      "key": '****',
    });

    if (response.statusCode == 200) {
      var jsonString = response.body;

      print(response.body);

      return ahlStatusModelFromJson(jsonString);
    } else {
      print('error message');
      return null;
    }
  }
}
