import 'dart:convert';

import 'package:circuit_project/models/component.dart';
import 'package:dio/dio.dart';
import 'dart:io';

Future<Map<String, dynamic>?> upload(File file) async {
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

Future<String?> solve(List<Component> component, String ground) async {
  final dio = Dio();
  final url1 = "https://graduationcircuits.000webhostapp.com/url.json";

  try {
    final response = await dio.get(url1);

    var urlFull = '';

    if (response.statusCode == 200) {
      print(response.data["url"]);

      urlFull = response.data["url"] + '/solve';
    } else {
      throw Exception("error in getting url");
    }

    var data = {
      "ground": ground,
      "components": component.map((e) => e.toJson()).toList()
    };

    final circuitResponse = await dio.post(urlFull,
        data: json.encode(data),
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }));

    print(circuitResponse.data);

    return circuitResponse.data;
  } catch (e) {
    print(e);
  }
}
