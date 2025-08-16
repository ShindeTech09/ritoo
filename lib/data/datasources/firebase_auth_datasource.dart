import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:retoverse/presentations/pages/cart_page/address.dart';

class FirebaseAuthDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User> signUp(String email, String password, String name) async {
    final cred = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return cred.user!;
  }

  Future<User> signIn(String email, String password) async {
    final cred = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return cred.user!;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<User> getCurrentUser() async => _auth.currentUser!;

  Future<Map<String, dynamic>?> getUserProfile(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();

    return doc.exists ? doc.data() : null;
  }

  Future<void> saveUserProfile(String uid, String name, String email) async {
    await _firestore.collection('users').doc(uid).set({
      'name': name,
      'email': email,
      'createdAt': DateTime.now().toUtc().toIso8601String(),
    });
  }

  Future<void> updateUserProfile({
    required String uid,
    required String name,
    required String email,
    String? phone,
    String? gender,
    String? dob,
  }) async {
    final currentUser = _auth.currentUser;

    if (currentUser == null) throw Exception("No logged-in user");

    if (currentUser.email != email) {
      await currentUser.verifyBeforeUpdateEmail(email);
    }

    final userDoc = _firestore.collection('users').doc(uid);
    final data = <String, dynamic>{
      'name': name,
      'email': email,
      if (phone != null) 'phone': phone,
      if (gender != null) 'gender': gender,
      if (dob != null) 'dob': dob,
    };

    await userDoc.update(data);
  }

  Future<void> updateUserAddresses(
    String uid,
    List<Map<String, dynamic>> addresses,
  ) async {
    final userDoc = _firestore.collection('users').doc(uid);
    await userDoc.update({'addresses': addresses});
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  Future<void> sendEmailVerificationMail() async {
    final user = _auth.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  Future<bool> isEmailVerified() async {
    final user = _auth.currentUser;
    await user?.reload();
    return user?.emailVerified ?? false;
  }

  Future<List<Address>> fetchUserAddresses(String userId) async {
    final doc = await _firestore.collection('users').doc(userId).get();
    final data = doc.data();
    if (data == null || data['addresses'] == null) return [];
    final List<dynamic> addressList = data['addresses'];
    debugPrint(addressList.toString());
    return addressList
        .map((json) => Address.fromJson(Map<String, dynamic>.from(json)))
        .toList();
  }
}
