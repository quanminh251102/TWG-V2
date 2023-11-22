import 'package:cloudinary/cloudinary.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twg/core/services/interfaces/icloudinary_service.dart';

final cloudinary = Cloudinary.signedConfig(
  apiKey: '692676895115767',
  apiSecret: 'h1Ndj6maDQnyaNDx6ZxBX2HHON4',
  cloudName: 'du7jhlk4c',
);

class CloudinaryService implements ICloudinaryService {
  @override
  Future<String> uploadFile(XFile file) async {
    final response = await cloudinary.upload(
        file: file.path,
        //fileBytes: file.readAsBytesSync(),
        resourceType: CloudinaryResourceType.image,
        //folder: cloudinaryCustomFolder,
        fileName: file.name,
        progressCallback: (count, total) {
          print('Uploading image from file with progress: $count/$total');
        });

    if (response.isSuccessful) {
      print('Get your image from with ${response.secureUrl}');
      return response.secureUrl as String;
    }
    return "error";
  }
}
