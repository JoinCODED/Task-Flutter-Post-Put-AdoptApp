# Pets Adoption App 🦄

- Endpoints:

```
Get pets, type: Get, https://coded-pets-api-crud.herokuapp.com/pets
Create a new pet, type: Post, https://coded-pets-api-crud.herokuapp.com/pets
Update a pet, type: Put, https://coded-pets-api-crud.herokuapp.com/pets/{petId}
Delete a pet, type: Delete, https://coded-pets-api-crud.herokuapp.com/pets/{petId}
Adopt a pet, type: Post, https://coded-pets-api-crud.herokuapp.com/pets/{petId}
```

### Part 2: Post Data

1. In `pages` folder, create a new page called `add_page.dart`.
2. Include this page within your routes in `main.dart`.
3. In your `home_page.dart` point the `add a new pet` button to the page we just created.

4. In your widgets folder, create `add_form.dart` widget and inside it initialize a stateFul widget.
5. Create a global key for your form.
6. Create a `Form` widget and assign it the key we just created.
7. Create `TextFormField`s for our properties except `adopted`, `image` and `id`.
8. Create a button to submit our data.
9. Import your widget in the `add_page.dart` and render it.
10. Back to `add_form.dart`, add a validator to each field as following:

```
All fields should not be empty.
Age should be of type int.
Gender should be either female or male
```

11. In your submit button `onPressed`, run your `_formKey.currentState!.validate()` and test your form.
12. On top of your form widget, create variables to hold our data.
13. In your `TextFormField`s `onSaved` property, assign each value to a the variable you created for it.
14. In your submit button `onPressed` check if the return of `_formKey.currentState!.validate()` is `true`, and if so, run `_formKey.currentState!.save()`.

15. Install the `image_picker` package.

```shell
flutter pub add image_picker
```

16. Import the package in `add_form.dart`.
17. On the top of your widget, create a variable to hold our image, and initialize an `ImagePicker` instance.
18. Within your form after the text fields, Create a `Row` with a `GestureDetector` widget inside and a `Text` widget.
19. Within the `onTap` method, change it to `async` and call the `ImagePicker` instance to pick an image from the gallery.
20. Call `setState` and assign the result of the image picker to your `_image` variable your created earlier.
21. Inside your `Container` check if the user selected an image and if so, display this image using the `Image.File` widget.
22. Back to `services/pets.dart`, create a new function that returns a future `Pet` object and takes a `Pet` argument.
23. Inside, Create a variable of type `Pet` and mark it as `late`.
24. Create variable `data` of type `FormData` and assign it to `FormData.fromMap` and map your pet data inside it.
25. Create a request of type post to your endpoint and pass it the `data` variable we created:

```
Post, https://coded-pets-api-crud.herokuapp.com/pets
```

26. Assign the `late` variable we created to the response, and return that variable.
27. Don't forget to wrap your call with a `try-catch` block.

28. Back to your `providers/pets.dart`, create a void function called `createPet` that takes an argument of type `Pet`.
29. Inside it, call `DioClient().createPet()` and pass to it the argument.
30. Store the result in a variable called `newPet`.
31. Insert this `newPet` in your `List` of pets in the provider.
32. Don't forget to call `notifyListeners`.

33. Lastly, Go to your submit button, and call the provider `createPet` function with `listen` set to `false` and pass it the data of our form.
34. Pop the screen so the user get's back to the home page.

### Part 3: Put Data

1. As you did with the `add_page.dart`, create a page for updating a pet, as well as a form for that, both expects a `Pet` argument.
2. Add your new page to your routes in `main.dart`, this time create a route param called `petId`.
3. Call your provider, look for the pet using the `petId` param, and pass it to the update page.

4. In the `pet_card.dart` you have an edit icon, clicking on it should take the user to the update page and pass the pet id with it.
5. In your form, access the pet argument using `widget.pet`.
6. Using this, add an initial value to your field.

7. Back to `services/pets.dart`, create a function that returns future `Pet`, requires an argument of type `Pet` and complete this function similarly to the `createPet` function you did.
8. Your endpoint is:

```
Put, https://coded-pets-api-crud.herokuapp.com/pets/{petId}
```

9. Using string interpolation, inject the `pet.id` value within the url, and pass the `data` as a second argument.
10. In your provider, create a function `updatePet` that takes a `Pet` argument and call the `DioClient().updatePet(pet: pet)`
11. Finally, find the index of the pet we want to replace, and replace the pet with the response we got and call `notifyListeners`.

12. In your update form submit button, call the provider function we just created and pass the form data.
13. Pop your screen so the user gets back to the `home_page`.
