### Part 2: Post Data

1. In `pages` folder, create a new page called `add_page.dart`.

```dart
class AddPage extends StatelessWidget {
  AddPage({Key? key}) : super(key: key);
  final titleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add a pet"),
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text("Fill those field to add a pet"),
          ],
        ),
      ),
    );
  }
}
```

2. Include this page within your routes in `main.dart`.

```dart
  final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/add',
        builder: (context, state) => AddPage(),
      ),
    ])
```

3. In your `home_page.dart` point the `add a new pet` button to the page we just created.

```dart
    onPressed: () {
        GoRouter.of(context).push('/add');
            },
```

4. In your widgets folder, create `add_form.dart` widget and inside it initialize a stateFul widget.

```dart
class AddPetForm extends StatefulWidget {
  @override
  AddPetFormState createState() {
    return AddPetFormState();
  }
}

class AddPetFormState extends State<AddPetForm> {
}
```

5. Create a global key for your form.

```dart
  final _formKey = GlobalKey<FormState>();
```

6. Create a `Form` widget and assign it the key we just created.

```dart
    return Form(
      key: _formKey,
    )
```

7. Create `TextFormField`s for our properties except `adopted`, `image` and `id`.

```dart
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Pet name',
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Pet Gender',
            ),
            maxLines: null,
          ),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Pet age',
            ),
          ),
        ],
      ),
    );
```

8. Create a button to submit our data.

```dart
Center(
            child: ElevatedButton(
              onPressed: () {},
              child: const Text("Add Pet"),
            ),
          )
```

9. Import your widget in the `add_page.dart` and render it.

```dart
child: Column(
          children: [
            const Text("Fill those field to add a book"),
            AddPetForm(),
          ],
        ),
```

10. Back to `add_form.dart`, add a validator to each field as following:

```
All fields should not be empty.
Age should be of type int.
Gender should be either female or male
```

11. In your submit button `onPressed`, run your `_formKey.currentState!.validate()` and test your form.

```dart
ElevatedButton(
              onPressed: () {
                _formKey.currentState!.validate()
              },
              child: const Text("Add Pet"),
            ),
```

12. On top of your form widget, create variables to hold our data.

```dart
  String name = "";
  String gender = "";
  int age = 0;
```

13. In your `TextFormField`s `onSaved` property, assign each value to a the variable you created for it.

```dart
children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Pet name',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "please fill out this field";
              } else {
                return null;
              }
            },
            onSaved: (value) {
              name = value!;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Pet Gender',
            ),
            maxLines: null,
            validator: (value) {
              if (value!.isEmpty) {
                return "please fill out this field";
              } else {
                return null;
              }
            },
            onSaved: (value) {
              gender = value!;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Pet age',
            ),
            validator: (value) {
              if (value == null) {
                return "please enter an age";
              } else if (int.tryParse(value) == null) {
                return "please enter a number";
              }
              return null;
            },
            onSaved: (value) {
              age = int.parse(value!);
            },
          ),
          [...]
```

14. In your submit button `onPressed` check if the return of `_formKey.currentState!.validate()` is `true`, and if so, run `_formKey.currentState!.save()`.

```dart
ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                }
              },
              child: const Text("Add Pet"),
            ),
```

15. Install the `image_picker` package.

```shell
flutter pub add image_picker
```

16. Import the package in `add_form.dart`.

```dart
import 'package:image_picker/image_picker.dart';
```

17. On the top of your widget, create a variable to hold our image, and initialize an `ImagePicker` instance.

```dart
  var _image;
  final _picker = ImagePicker();
```

18. Within your form after the text fields, Create a `Row` with a `GestureDetector` widget inside and a `Text` widget.

```dart
Row(
            children: [
              GestureDetector(
                onTap: () {
                },
                child: Container(
                  width: 100,
                  height: 100,
                  margin: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(color: Colors.blue[200]),
                  child: Container(
                          decoration: BoxDecoration(color: Colors.blue[200]),
                          width: 200,
                          height: 200,
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.grey[800],
                          ),
                    ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Image"),
              )
            ],
          ),
```

19. Within the `onTap` method, change it to `async` and call the `ImagePicker` instance to pick an image from the gallery.

```dart
onTap: () async {
                  final XFile? image =
                      await _picker.pickImage(source: ImageSource.gallery);
                },
```

20. Call `setState` and assign the result of the image picker to your `_image` variable your created earlier.

```dart
onTap: () async {
                  final XFile? image =
                      await _picker.pickImage(source: ImageSource.gallery);
                  setState(() {
                    _image = File(image!.path);
                  });
                },
```

21. Inside your `Container` check if the user selected an image and if so, display this image using the `Image.File` widget.

```dart
 child: Container(
                  width: 100,
                  height: 100,
                  margin: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(color: Colors.blue[200]),
                  child: _image != null
                      ? Image.file(
                          _image,
                          width: 200.0,
                          height: 200.0,
                          fit: BoxFit.fitHeight,
                        )
                      : Container(
                          decoration: BoxDecoration(color: Colors.blue[200]),
                          width: 200,
                          height: 200,
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.grey[800],
                          ),
                        ),
                ),
```

22. Back to `services/pets.dart`, create a new function that returns a future `Pet` object and takes a `Pet` argument.

```dart
  Future<Pet> createPet({required Pet pet}) async {
  }
```

23. Inside, Create a variable of type `Pet` and mark it as `late`.

```dart
  Future<Pet> createPet({required Pet pet}) async {
    late Pet retrievedPet;
  }
```

24. Create variable `data` of type `FormData` and assign it to `FormData.fromMap` and map your pet data inside it.

```dart
      FormData data = FormData.fromMap({
        "name": pet.name,
        "age": pet.age,
        "gender": pet.gender,
        "adopted": pet.adopted,
        "image": await MultipartFile.fromFile(
          pet.image,
        ),
      });
```

25. Create a request of type post to your endpoint and pass it the `data` variable we created:

```
Post, https://coded-pets-api-crud.herokuapp.com/pets
```

```dart
Response response = await _dio.post(_baseUrl + '/pets', data: data);
```

26. Assign the `late` variable we created to the response, and return that variable.

```dart
Response response = await _dio.post(_baseUrl + '/pets', data: data);
retrievedPet = Pet.fromJson(response.data);
```

27. Don't forget to wrap your call with a `try-catch` block.

```dart
 try {
      FormData data = FormData.fromMap({
        "name": pet.name,
        "age": pet.age,
        "gender": pet.gender,
        "image": await MultipartFile.fromFile(
          pet.image,
        ),
      });
      Response response = await _dio.post(_baseUrl + '/pets', data: data);
      retrievedPet = Pet.fromJson(response.data);
    } on DioError catch (error) {
      print(error);
    }
return retrievedPet;
```

28. Back to your `providers/pets.dart`, create a void function called `createPet` that takes an argument of type `Pet`.

```dart
  void createPet(Pet pet) async {}
```

29. Inside it, call `PetsServices().createPet()` and pass to it the argument.

```dart
    await PetsServices().createPet(pet: pet);
```

30. Store the result in a variable called `newPet`.

```dart
    Pet newPet = await PetsServices().createPet(pet: pet);
```

31. Insert this `newPet` in your `List` of pets in the provider.

```dart
    Pet newPet = await PetsServices().createPet(pet: pet);
    pets.insert(0, newPet);
```

32. Don't forget to call `notifyListeners`.

```dart
    notifyListeners();
```

33. Lastly, Go to your submit button, and call the provider `createPet` function with `listen` set to `false` and pass it the data of our form.
34. Pop the screen so the user get's back to the home page.

```dart
onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  print(age);
                  Provider.of<PetsProvider>(context, listen: false).createPet(
                      Pet(
                          name: name,
                          gender: gender,
                          image: _image.path,
                          age: age));
                  GoRouter.of(context).pop();
                }
              },
```

### Part 3: Put Data

1. As you did with the `add_page.dart`, create a page for updating a pet, as well as a form for that, both expects a `Pet` argument.

```dart
class UpdatePage extends StatelessWidget {
  final Pet pet;
  const UpdatePage({Key? key, required this.pet}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update a pet"),
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text("Fill those field to update a book"),
            UpdatePetForm(
              pet: pet,
            ),
          ],
        ),
      ),
    );
  }
}
```

```dart
class UpdatePetForm extends StatefulWidget {
  final Pet pet;
  UpdatePetForm({required this.pet});
  @override
  UpdateFormState createState() {
    return UpdateFormState();
  }
}

class UpdateFormState extends State<UpdatePetForm> {
}
```

2. Add your new page to your routes in `main.dart`, this time create a route param called `petId`.

```dart
      GoRoute(
        path: '/update/:petId',
        builder: (context, state) {
          return UpdatePage(pet: pet);
        },
      ),
```

3. Call your provider, look for the pet using the `petId` param, and pass it to the update page.

```dart
      GoRoute(
        path: '/update/:petId',
        builder: (context, state) {
          final pet = Provider.of<PetsProvider>(context).pets.firstWhere(
              (pet) => pet.id.toString() == (state.params['petId']!));
          return UpdatePage(pet: pet);
        },
      ),
```

4. In the `pet_card.dart` you have an edit icon, clicking on it should take the user to the update page and pass the pet id with it.

```dart
    IconButton(
        onPressed: () {
            GoRouter.of(context).push('/update/${pet.id}');
                        ,
        icon: const Icon(Icons.edit)),
```

5. In your form, access the pet argument using `widget.pet`.
6. Using this, add an initial value to your field.

```dart
  Widget build(BuildContext context) {
    Pet pet = widget.pet;
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Pet name',
            ),
            initialValue: pet.name,
            validator: (value) {
              if (value!.isEmpty) {
                return "please fill out this field";
              } else {
                return null;
              }
            },
            onSaved: (value) {
              name = value!;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Pet Gender',
            ),
            initialValue: pet.gender,
            maxLines: null,
            validator: (value) {
              if (value!.isEmpty) {
                return "please fill out this field";
              } else {
                return null;
              }
            },
            onSaved: (value) {
              gender = value!;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Pet age',
            ),
            initialValue: pet.age.toString(),
            validator: (value) {
              if (value == null) {
                return "please enter an age";
              } else if (int.tryParse(value) == null) {
                return "please enter a number";
              }
              return null;
            },
            onSaved: (value) {
              age = int.parse(value!);
            },
          ),
[...]
```

7. Back to `services/pets.dart`, create a function that returns future `Pet`, requires an argument of type `Pet` and complete this function similarly to the `createPet` function you did.

```dart
  Future<Pet> updatePet({required Pet pet}) async {
    late Pet retrievedPet;
    try {
      FormData data = FormData.fromMap({
        "name": pet.name,
        "age": pet.age,
        "adopted": pet.adopted,
        "gender": pet.gender,
        "image": await MultipartFile.fromFile(
          pet.image,
        ),
      });

      Response response =
          await _dio.put(_baseUrl + '/pets/${pet.id}', data: data);
      retrievedPet = Pet.fromJson(response.data);
    } on DioError catch (error) {
      print(error);
    }
    return retrievedPet;
  }
```

8. In your provider, create a function `updatePet` that takes a `Pet` argument and call the `PetsServices().updatePet(pet: pet)`

```dart
  void updatePet(Pet pet) async {
    Pet newPet = await PetsServices().updatePet(pet: pet);
  }
```

9. Finally, find the index of the pet we want to replace, and replace the pet with the response we got and call `notifyListeners`.

```dart
  void updatePet(Pet pet) async {
    Pet newPet = await PetsServices().updatePet(pet: pet);
    int index = pets.indexWhere((pet) => pet.id == newPet.id);
    pets[index] = newPet;
    notifyListeners();
  }
```

10. In your update form submit button, call the provider function we just created and pass the form data.

```dart
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a Snackbar.
                  _formKey.currentState!.save();
                  Provider.of<PetsProvider>(context, listen: false).updatePet(
                      Pet(
                          id: pet.id,
                          name: name,
                          gender: gender,
                          image: _image.path,
                          age: age));
                  GoRouter.of(context).pop();
                }
              },
```
