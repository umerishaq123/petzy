import 'package:flutter/material.dart';
import 'package:pet_app/widgets/image_grid_widget.dart';
import 'package:pet_app/widgets/search_text_form_field.dart';

class DiscoveryScreen extends StatelessWidget {
  const DiscoveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Discover"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SearchFieldWidget(),
            ImageGridWidget(),
          ],
        ),
      ),
    );
  }
}
