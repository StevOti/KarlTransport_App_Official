import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';
import 'package:provider/provider.dart';
import 'package:karltransportapp/data/storage_service.dart';

class SignaturePad extends StatefulWidget {
  final SignatureController controller;
  final double height;
  final double width;
  final Color backgroundColor;
  final String contractId; // Add this

  const SignaturePad({
    super.key, 
    required this.controller,
    required this.height,
    required this.width,
    required this.backgroundColor,
    required this.contractId, // Add this
  });

  @override
  State<SignaturePad> createState() => _SignaturePadState();
}

class _SignaturePadState extends State<SignaturePad> {
  Uint8List? exportedImage;
  String? signatureUrl;
  bool isUploading = false;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            color: widget.backgroundColor,
          ),
          child: Signature(
            controller: widget.controller,
            backgroundColor: widget.backgroundColor,
            width: widget.width,
            height: widget.height,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: isUploading ? null : () async {
                final storageService = Provider.of<StorageService>(context, listen: false);
                
                setState(() {
                  isUploading = true;
                });

                try {
                  // Get signature as PNG bytes
                  final Uint8List? bytes = await widget.controller.toPngBytes();
                  
                  if (bytes != null) {
                    // Upload to Firebase
                    final url = await storageService.uploadSignature(
                      bytes,
                      widget.contractId,
                    );
                    
                    if (url != null) {
                      setState(() {
                        signatureUrl = url;
                        exportedImage = bytes;
                      });
                      
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Signature saved successfully'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error saving signature: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                } finally {
                  setState(() {
                    isUploading = false;
                  });
                }
              },
              child: isUploading 
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(color: Colors.white)
                  )
                : const Text('Save'),
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: () {
                widget.controller.clear();
                setState(() {
                  exportedImage = null;
                  signatureUrl = null;
                });
              },
              child: const Text('Clear'),
            ),
          ],
        ),
        if (exportedImage != null) ...[
          const SizedBox(height: 20),
          Image.memory(
            exportedImage!,
            height: 100,
            width: 100,
          ),
        ],
      ],
    );
  }
}