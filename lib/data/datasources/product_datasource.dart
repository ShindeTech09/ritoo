import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:retoverse/data/models/product_model.dart';

// class ProductDataSource {
//   final _firestore = FirebaseFirestore.instance.collection('products');
//
//   Future<List<ProductModel>> getAllProducts() async {
//     final snapshot = await _firestore.get();
//
//     return snapshot.docs
//         .map((doc) => ProductModel.fromMap(doc.data()))
//         .toList();
//   }
// }

class ProductDataSource {
  final _firestore = FirebaseFirestore.instance.collection('products');

  Future<RxList<ProductModel>> getAllProducts() async {
    try {
      final snapshot = await _firestore.get();
      return snapshot.docs
              .map((doc) => ProductModel.fromMap(doc.data()))
              .toList()
          as RxList<ProductModel>;
    } on FirebaseException catch (e) {
      // Handle Firebase-specific errors
      String errorMessage = "An error occurred while fetching products.";
      // You can check e.code for specific Firebase error codes
      // and customize the message accordingly.
      // For example:
      if (e.code == 'unavailable') {
        errorMessage =
            "The service is currently unavailable. Please try again later.";
      } else if (e.code == 'permission-denied') {
        errorMessage = "You do not have permission to access these products.";
      }
      // Log the specific Firebase error
      Get.snackbar(
        'FirebaseException fetching products',
        '${e.code} - ${e.message}',
      );
      Get.snackbar('Error', errorMessage);
      return RxList(); // Return an empty list or throw a custom exception
    } catch (e) {
      // Handle any other non-Firebase errors
      Get.snackbar('Error', 'An unexpected error occurred.');
      return RxList(); // Return an empty list or throw a custom exception
    }
  }
}
