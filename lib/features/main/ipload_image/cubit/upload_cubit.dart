import 'dart:io';

import 'package:dev_connected/core/services/cloudinary_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'upload_state.dart';

class UploadCubit extends Cubit<UploadState> {
  final CloudinaryService cloudinaryService;

  UploadCubit(this.cloudinaryService) : super(UploadInitial());

  Future<void> uploadImage(File image) async {
    emit(UploadLoading());

    try {
      final imageUrl = await cloudinaryService.uploadImage(image);

      emit(UploadSuccess(imageUrl));
    } catch (e) {
      emit(UploadFailure(e.toString()));
    }
  }
}
