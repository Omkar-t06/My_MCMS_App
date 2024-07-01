import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:my_mcms/service/cloud/constants/cloud_storage_constant.dart';

@immutable
class UserModel {
  final String uid;
  final String displayName;
  final String? email;
  final String? phoneNumber;
  final String address;
  final String? avatarUrl;
  final String role;

  const UserModel({
    required this.uid,
    required this.displayName,
    this.email,
    this.phoneNumber,
    required this.address,
    this.avatarUrl,
    required this.role,
  });

  UserModel.fromSnapShot(
    QueryDocumentSnapshot<Map<String, dynamic>> snapshot,
  )   : uid = snapshot.data()[uidFieldName] as String,
        displayName = snapshot.data()[userNameFieldName] as String,
        email = snapshot.data()[emailFieldName] as String? ?? '',
        phoneNumber = snapshot.data()[phoneNumberFieldName] as String? ?? '',
        address = snapshot.data()[addressFieldName],
        avatarUrl = snapshot.data()[avatarUrlFieldName] as String? ?? '',
        role = snapshot.data()[roleFieldName] as String;
}
