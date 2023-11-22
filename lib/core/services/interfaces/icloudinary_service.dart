import 'package:image_picker/image_picker.dart';

abstract class ICloudinaryService {
  Future<String> uploadFile(XFile file);
}
