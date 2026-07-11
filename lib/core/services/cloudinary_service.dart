import 'dart:io';

import 'package:dio/dio.dart';

class CloudinaryService {
  final Dio dio;

  CloudinaryService(this.dio);

  static const String cloudName = "I90fhrid";
  static const String uploadPreset = "divconnected";

  Future<String> uploadImage(File image) async {
    final url = "https://api.cloudinary.com/v1_1/$cloudName/image/upload";

    final formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(image.path),

      "upload_preset": uploadPreset,
    });

    final response = await dio.post(url, data: formData);

    return response.data["secure_url"];
  }
}
