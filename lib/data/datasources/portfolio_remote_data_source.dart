import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/config/firebase_config.dart';
import '../../domain/entities/contact_form.dart';

class PortfolioRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> submitContactForm(ContactForm form) async {
    try {
      // Add the form data to Firestore
      await _firestore.collection(FirebaseConfig.contactFormsCollection).add({
        'name': form.name,
        'email': form.email,
        'message': form.message,
        'timestamp': FieldValue.serverTimestamp(), // Automatically sets server timestamp
      });
      
      return true;
    } catch (e) {
      print('Error submitting form to Firestore: $e');
      return false;
    }
  }
}

