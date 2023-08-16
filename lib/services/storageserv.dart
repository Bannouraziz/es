import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;

  StorageService._internal();

  Future<String> getImageUrl(String imagePath) async {
    try {
      final Reference ref = FirebaseStorage.instance.ref(imagePath);
      final String downloadURL = await ref.getDownloadURL();
      return downloadURL;
    } catch (error) {
      print('Error getting image URL: $error');
      return '';
    }
  }
}
