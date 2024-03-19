import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:m3m_tennis_booking/common/services/storage_service.dart';
import 'package:m3m_tennis_booking/routes/app_routes.dart';
import 'package:m3m_tennis_booking/utils/app_constants.dart';

class ProfileController extends GetxController {
  final RxString _imagePath = RxString('');

  String get imagePath => _imagePath.value;

  Future<void> pickImage(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);

      if (pickedFile != null) {
        _imagePath.value = pickedFile.path;
        StorageService.instance.save(AppConstants.userProfileImage, pickedFile.path);
      } else {
        // show snackbar
        Get.snackbar("Error", "No image selected");
      }
    } catch (e) {
      print(e);
      Get.snackbar("Error", e.toString());
    }
  }

  logout() {
    StorageService.instance.clearAll();
    Get.offAllNamed(AppRoutes.initialRoute);
  }
}
