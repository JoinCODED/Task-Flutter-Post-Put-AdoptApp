import 'package:flutter/material.dart';

import '../widgets/add_form.dart';

class AddPage extends StatelessWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Pet Page"),
      ),
      body: const AddForm(),
    );
  }
}
