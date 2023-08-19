import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<String> getImageUrl(String imagePath) async {
    String downloadUrl = await _firebaseStorage.ref(imagePath).getDownloadURL();
    return downloadUrl;
  }
}
