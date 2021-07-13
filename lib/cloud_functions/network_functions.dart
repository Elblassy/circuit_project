import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

Future<Map<String,dynamic>?> upload(File file) async {
  final dio = Dio();
  final url1 = "https://graduationcircuits.000webhostapp.com/url.json";

  try {
    final response = await dio.get(url1);

    var urlFull = '';

    if (response.statusCode == 200) {
      print(response.data["url"]);

      urlFull = response.data["url"] + '/upload-image';
    } else {
      throw Exception("error in getting url");
    }

    String fileName = file.path.split('/').last;

    FormData data = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
    });

    final circuitResponse = await dio.post(urlFull, data: data);

    return circuitResponse.data;

  } catch (e) {
    print(e);
  }
}
