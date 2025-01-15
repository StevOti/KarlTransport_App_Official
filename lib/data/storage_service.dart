// lib/data/storage_service.dart

import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class StorageService with ChangeNotifier {
  // Firebase Storage instance
  final firebaseStorage = FirebaseStorage.instance;

  // List to store all image URLs across all sections
  List<String> _imagesUrls = [];

  // Loading states
  bool _isLoading = false;
  bool _isUploading = false;

  // Getters
  List<String> get imagesUrls => _imagesUrls;
  bool get isLoading => _isLoading;
  bool get isUploading => _isUploading;

  // Fetch images from a specific folder in Firebase Storage
  Future<void> fetchImages(String folderPath) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Get list of all files in the specified folder
      final ListResult result = await firebaseStorage.ref(folderPath).listAll();
      
      // Get download URLs for all images in the folder
      final urls = await Future.wait(
        result.items.map((ref) => ref.getDownloadURL()),
      );
      
      // Update _imagesUrls while preserving images from other sections
      _imagesUrls = _imagesUrls
          .where((url) => !url.contains(folderPath))
          .toList()
        ..addAll(urls);
    } catch (e) {
      print("Error fetching images: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  // Upload a new image to a specific folder
  Future<void> uploadImage(String folderPath) async {
    _isUploading = true;
    notifyListeners();

    // Initialize image picker
    final ImagePicker picker = ImagePicker();
    
    // Let user pick an image from gallery
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    // Return if no image was selected
    if (image == null) {
      _isUploading = false;
      notifyListeners();
      return;
    }

    // Convert XFile to File
    File file = File(image.path);

    try {
      // Create a unique filename using timestamp
      String filePath = '$folderPath/${DateTime.now()}.png';
      
      // Upload file to Firebase Storage
      await firebaseStorage.ref(filePath).putFile(file);
      
      // Get the download URL of the uploaded file
      String downloadUrl = await firebaseStorage.ref(filePath).getDownloadURL();
      
      // Add new URL to the list
      _imagesUrls.add(downloadUrl);
    } catch (e) {
      print("Error uploading image: $e");
    }

    _isUploading = false;
    notifyListeners();
  }

  // Delete an image
  Future<void> deleteImageS(String imageUrl) async {
    try {
      // Remove the URL from our list
      _imagesUrls.remove(imageUrl);

      // Extract the path from the URL and delete from Firebase
      final String path = extractPathFromUrl(imageUrl);
      await firebaseStorage.ref(path).delete();
    } catch (e) {
      print("Error deleting image: $e");
    }

    notifyListeners();
  }

  // Add this method to your StorageService class
Future<String?> uploadSignature(Uint8List signatureBytes, String contractId) async {
  _isUploading = true;
  notifyListeners();

  String? downloadUrl;
  try {
    // Create a unique filename for the signature
    String filePath = 'signatures/${contractId}_${DateTime.now().millisecondsSinceEpoch}.png';
    
    // Upload signature to Firebase Storage
    await firebaseStorage
        .ref(filePath)
        .putData(
          signatureBytes,
          SettableMetadata(contentType: 'image/png'),
        );
    
    // Get the download URL
    downloadUrl = await firebaseStorage.ref(filePath).getDownloadURL();
    
    // Add to images list if needed
    _imagesUrls.add(downloadUrl);
    } catch (e) {
    print("Error uploading signature: $e");
    return null;
  } finally {
    _isUploading = false;
    notifyListeners();
  }

  return downloadUrl;
}

  // Helper function to extract Firebase Storage path from download URL
  String extractPathFromUrl(String url) {
    Uri uri = Uri.parse(url);
    String encodedPath = uri.pathSegments.last;
    return Uri.decodeFull(encodedPath);
  }
}