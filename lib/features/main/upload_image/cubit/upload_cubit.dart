import 'dart:io';

import 'package:dev_connected/core/services/cloudinary_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'upload_state.dart';

class UploadCubit extends Cubit<UploadState> {
  final CloudinaryService cloudinaryService;
  File? selectedImage;
  final ImagePicker _picker = ImagePicker();

  UploadCubit(this.cloudinaryService) : super(UploadInitial());

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile == null) return;

    selectedImage = File(pickedFile.path);

    emit(UploadInitial());
  }

  Future<void> uploadImage(File image) async {
    emit(UploadLoading());

    try {
      final imageUrl = await cloudinaryService.uploadImage(image);
      emit(UploadSuccess(imageUrl));
    } catch (e, stackTrace) {
      debugPrint('===== UPLOAD ERROR =====');
      debugPrint(e.toString());
      debugPrint(stackTrace.toString());
      debugPrint('=========================');
      emit(UploadFailure(e.toString()));
    }
  }
}
