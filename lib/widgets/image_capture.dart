import 'package:flutter/material.dart';
import 'package:karltransportapp/data/storage_service.dart';
import 'package:provider/provider.dart';

class ImageCapture extends StatefulWidget {
  const ImageCapture({super.key});

  @override
  State<ImageCapture> createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {

  @override
  void initState() {
    super.initState();

    fetchImages();
  }

  // fetch images

  Future<void> fetchImages() async {
    await Provider.of<StorageService>(context, listen: false).fetchImages('folderPath');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer <StorageService>(
      builder: (context, storageService, child) {

        // list of image urls
        final List<String> imagesUrls = storageService.imagesUrls;

        // The UI
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () => storageService.uploadImage('folderPath'),
            child: const Icon(Icons.add),
          ),
          body: ListView.builder(
            itemCount: imagesUrls.length,
            itemBuilder: (context, index){
              // get each individual image
              final String imageUrl = imagesUrls[index];

              // post image on UI
              return Image.network(imageUrl); 
            },

          ),
        );
      } 
    );
  }
}