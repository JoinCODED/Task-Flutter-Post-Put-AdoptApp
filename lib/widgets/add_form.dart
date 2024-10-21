import 'package:adopt_app/models/pet.dart';
import 'package:adopt_app/providers/pets_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

final _picker = ImagePicker();

class AddForm extends StatefulWidget {
  const AddForm({Key? key}) : super(key: key);

  @override
  State<AddForm> createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  final _formKey = GlobalKey<FormState>();
  String name = "";
  int age = 0;
  String gender = "";
  XFile? image;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Name",
            ),
            onSaved: (value) {
              name = value!;
            },
            validator: (value) {
              if (value!.isEmpty) {
                return "Name canot be empty";
              }

              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Age",
            ),
            onSaved: (value) {
              age = int.parse(value!);
            },
            validator: (value) {
              // validate if empty
              if (value!.isEmpty) {
                return "Age canot be empty";
              }

              // validate if number
              if (int.tryParse(value) == null) {
                return "Age must be a number";
              }

              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Gender",
            ),
            onSaved: (value) {
              gender = value!;
            },
            validator: (value) {
              if (value!.isEmpty) {
                return "Gender canot be empty";
              }

              if (value != 'male' && value != 'female') {
                return "Must be male or female";
              }
              return null;
            },
          ),
          Row(
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () async {
                  var im = await _picker.pickImage(source: ImageSource.gallery);
                  if (im == null) return;

                  setState(() {
                    image = im;
                  });
                },
                child: SizedBox(
                  height: 300,
                  width: 300,
                  child: image != null
                      ? Image.network(image!.path)
                      : const Center(
                          child: Icon(Icons.camera_alt_outlined),
                        ),
                ),
              ),
              const Text("Select an Image"),
            ],
          ),
          FilledButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  context.read<PetsProvider>().createPet(Pet(
                        name: name,
                        image: image!.path,
                        age: age,
                        gender: gender,
                      ));
                }
              },
              child: const Text("Add")),
        ],
      ),
    );
  }
}
