import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'form_data_model.dart';

class FormController extends GetxController {
  final String _formDataKey = 'formDataKey';
  var formData = Rx<FormDataModel?>(null);
// cleaner null-safe Rx

  @override
  void onInit() {
    super.onInit();
    loadFormData();
  }

  Future<void> saveFormData(FormDataModel data) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_formDataKey, jsonEncode(data.toJson()));
      formData.value = data;
      debugPrint("Form data saved: ${data.title}");
    } catch (e) {
      debugPrint("Error saving form data: $e");
    }
  }

  Future<void> loadFormData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? jsonString = prefs.getString(_formDataKey);
      if (jsonString != null && jsonString.isNotEmpty) {
        formData.value = FormDataModel.fromJson(jsonDecode(jsonString));
        debugPrint("Form data loaded: ${formData.value?.title}");
      } else {
        debugPrint("No form data found");
      }
    } catch (e) {
      debugPrint("Error loading form data: $e");
    }
  }

  Future<void> clearFormData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_formDataKey);
      formData.value = null;
      debugPrint("Form data cleared");
    } catch (e) {
      debugPrint("Error clearing form data: $e");
    }
  }
}
