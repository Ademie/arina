import 'dart:typed_data';
import 'package:arina/global.dart';
import 'package:http/http.dart' as http;

class ApiConsumer {
  Future<Uint8List> removeBgApi(String imagePath) async {
    // DEFINE REQUEST
    var requestAPI = http.MultipartRequest(
        "POST", Uri.parse("https://api.remove.bg/v1.0/removebg"));

    requestAPI.files
        .add(await http.MultipartFile.fromPath("image_file", imagePath));

    requestAPI.headers.addAll({"X-API-Key": ApiKeyRemoveBg});

    // SEND REQUEST AND RECEIVE RESPONSE
    final response = await requestAPI.send();

    if (response.statusCode == 200) {
      http.Response getTransparentImageFromResponse =
          await http.Response.fromStream(response);
      return getTransparentImageFromResponse.bodyBytes;
    } else {
      throw Exception("Error Occured::" + response.statusCode.toString());
    }
  }
}
