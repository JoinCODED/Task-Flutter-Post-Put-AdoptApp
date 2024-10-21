import 'package:adopt_app/models/pet.dart';
import 'package:adopt_app/services/pets.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class PetsProvider extends ChangeNotifier {
  List<Pet> pets = [];

  Future<void> getPets() async {
    pets = await DioClient().getPets();
  }

  void createPet(Pet toAdded) async {
    try {
      var pet = await DioClient().createPet(pet: toAdded);
      pets.insert(0, pet);
      notifyListeners();
    } on DioException catch (e) {
      print(e.error);
    }
  }

  void updatePet(Pet pet) async {
    Pet newPet = await DioClient().updatePet(pet: pet);
    int index = pets.indexWhere((pet) => pet.id == newPet.id);
    pets[index] = newPet;
    notifyListeners();
  }

  void adoptPet(int petId) async {
    Pet newPet = await DioClient().adoptPet(petId: petId);
    int index = pets.indexWhere((pet) => pet.id == newPet.id);
    pets[index] = newPet;
    notifyListeners();
  }

  void deletePet(int petId) async {
    await DioClient().deletePet(petId: petId);
    pets.removeWhere((pet) => pet.id == petId);
    notifyListeners();
  }
}
