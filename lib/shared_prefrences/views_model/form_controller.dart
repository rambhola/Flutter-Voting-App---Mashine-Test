import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'form_data_model.dart'; // Import the model

class FormController extends GetxController {
  final String _formDataKey = 'formDataKey';
  Rx<FormDataModel?> formData = Rx<FormDataModel?>(null);

  @override
  void onInit() {
    super.onInit();
    loadFormData();
  }

  // Save form data to SharedPreferences
  Future<void> saveFormData(FormDataModel data) async {
    final prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(data.toJson()); // Encode model to JSON string
    await prefs.setString(_formDataKey, jsonString);
    formData.value = data;
    print("Form data saved: $jsonString");
  }

  // get form data from SharedPreferences
  Future<void> loadFormData() async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(_formDataKey);
    if (jsonString != null && jsonString.isNotEmpty) {
      Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      formData.value = FormDataModel.fromJson(jsonMap);
      print("Form data loaded: ${formData.value?.title}");
    } else {
      print("No form data found");
    }
  }

  // Clear form data
  Future<void> clearFormData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_formDataKey);
    formData.value = null;
    print("Form data cleared");
  }
}
