import 'package:flutter/material.dart';
import 'package:pixabay_dummy/data/models/pixa_images_model.dart';

class FullImageScreen extends StatefulWidget {
  const FullImageScreen({super.key, required this.imageData});

  final PixaImageData imageData;

  @override
  State<FullImageScreen> createState() => _FullImageScreenState();
}

class _FullImageScreenState extends State<FullImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.imageData.tags),
      ),
      body: Center(
        child: Hero(
          tag: widget.imageData.id,
          child: Image.network(
            widget.imageData.webformatUrl,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
