part of 'upload_cubit.dart';



abstract class UploadState{}



class UploadInitial extends UploadState{}



class UploadLoading extends UploadState{}



class UploadSuccess extends UploadState{

 final String imageUrl;


 UploadSuccess(
   this.imageUrl
 );

}



class UploadFailure extends UploadState{

 final String message;


 UploadFailure(
   this.message
 );

}