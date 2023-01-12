import 'package:image_picker/image_picker.dart';

// ignore: non_constant_identifier_names
Gallery() async {
  XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
  if (file != null) {
    return file.path;
  } else {
    return '';
  }
}

// ignore: non_constant_identifier_names
Camera() async {
  XFile? file = await ImagePicker()
      .pickImage(source: ImageSource.camera, imageQuality: 50);
  if (file != null) {
    return file.path;
  } else {
    return '';
  }
}
