import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_appointment_app/features/home/data/models/category_model.dart';

class CategoryService {
  Future<List<CategoryModel>> getCategories() async {
    try {
      final firestore = FirebaseFirestore.instance;
      final snapshot = await firestore.collection('categories').get();
      return snapshot.docs.map((doc) => CategoryModel.fromJson(doc.data(), doc.id)).toList();
    } catch (e) {
      // Handle error
      return [];
    }
  }
}
