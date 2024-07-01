import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_mcms/constants/enums.dart';
import 'package:my_mcms/service/auth/auth_expections.dart';
import 'package:my_mcms/service/cloud/Models/user_model.dart';
import 'package:my_mcms/service/cloud/Models/complaints_model.dart';
import 'package:my_mcms/service/cloud/constants/cloud_exception.dart';
import 'package:my_mcms/service/cloud/constants/cloud_storage_constant.dart';

class FirebaseCloudStorage {
  final users = FirebaseFirestore.instance.collection('user');
  final complaints = FirebaseFirestore.instance.collection('complaints');

  Future<UserModel> createUserDetails({
    required String uid,
    required String userName,
    String? email,
    String? phoneNo,
    required String address,
    String? avatarUrl,
    String? userRole,
  }) async {
    final document = await users.add({
      uidFieldName: uid,
      userNameFieldName: userName,
      emailFieldName: email ?? "",
      phoneNumberFieldName: phoneNo ?? "",
      addressFieldName: address,
      avatarUrlFieldName: avatarUrl ?? "",
      roleFieldName: userRole ?? "user",
    });
    final fetchedUser = await document.get();
    return UserModel(
      uid: uid,
      displayName: fetchedUser.data()?[userNameFieldName] as String,
      email: fetchedUser.data()?[emailFieldName] as String?,
      phoneNumber: fetchedUser.data()?[phoneNumberFieldName] as String?,
      avatarUrl: fetchedUser.data()?[avatarUrlFieldName] as String?,
      address: fetchedUser.data()?[addressFieldName] as String,
      role: fetchedUser.data()?[roleFieldName],
    );
  }

  Future<ComplaintsModel> createComplaint({
    required String raisedBy,
  }) async {
    final document = await complaints.add({
      complaintRaisedByFieldName: raisedBy,
      complaintDescriptionFieldName: '',
      complaintLocationFieldName: '',
      complaintStatusFieldName: ComplaintStatus.pending,
      complaintDateFieldName: DateTime.now(),
      complaintDepartmentFieldName: '',
      complaintImageFieldName: <String>[],
    });
    final fetchedComplaint = await document.get();
    return ComplaintsModel(
      complaintId: fetchedComplaint.id,
      description:
          fetchedComplaint.data()?[complaintDescriptionFieldName] as String,
      location: fetchedComplaint.data()?[complaintLocationFieldName] as String,
      status: fetchedComplaint.data()?[complaintStatusFieldName],
      images: fetchedComplaint.data()?[complaintImageFieldName] as List<String>,
      raisedBy: raisedBy,
      department:
          fetchedComplaint.data()?[complaintDepartmentFieldName] as String,
      complainOn: DateTime.now(),
    );
  }

  Future<UserModel> getUser({required String uid}) async {
    try {
      final fetchedUser = await users
          .where(
            uidFieldName,
            isEqualTo: uid,
          )
          .get();
      if (fetchedUser.docs.isEmpty) {
        throw UserNotFoundException();
      }
      final user = fetchedUser.docs.first;
      return UserModel.fromSnapShot(user);
    } catch (e) {
      throw CouldNotGetUserException();
    }
  }

  Future<void> updateUserDetails({
    required String uid,
    required String userName,
    required String address,
    String? email,
    String? phoneNo,
    String? avatarUrl,
  }) async {
    try {
      final fetchedUser = await users
          .where(
            uidFieldName,
            isEqualTo: uid,
          )
          .get();
      if (fetchedUser.docs.isEmpty) {
        throw UserNotFoundException();
      }
      final user = fetchedUser.docs.first;
      await users.doc(user.id).update({
        uidFieldName: uid,
        userNameFieldName: userName,
        emailFieldName: email ?? "",
        phoneNumberFieldName: phoneNo ?? "",
        addressFieldName: address,
        avatarUrlFieldName: avatarUrl ?? "",
      });
    } catch (e) {
      throw CouldNotGetUserException();
    }
  }

  Future<void> updateComplaint({
    required String complaintId,
    required String description,
    required String location,
    required ComplaintStatus status,
    required List<String> images,
    required String department,
  }) async {
    try {
      final fetchedComplaint = await complaints.doc(complaintId).get();
      if (!fetchedComplaint.exists) {
        throw ComplaintNotFoundException();
      }
      await complaints.doc(complaintId).update({
        complaintDescriptionFieldName: description,
        complaintLocationFieldName: location,
        complaintStatusFieldName: status,
        complaintImageFieldName: images,
        complaintDepartmentFieldName: department,
      });
    } catch (e) {
      throw CouldNotUpdateComplaintException();
    }
  }

  Future<void> deleteUser({required String uid}) async {
    try {
      await users.doc(uid).delete();
    } catch (e) {
      throw CouldNotDeleteUserException();
    }
  }

  Future<void> deleteComplaint({required String complaintId}) async {
    try {
      await users.doc(complaintId).delete();
    } catch (e) {
      throw CouldNotDeleteUserException();
    }
  }

  Stream<Iterable<ComplaintsModel>> allComplaints({required String uid}) =>
      complaints.snapshots().map((event) =>
          event.docs.map((doc) => ComplaintsModel.fromSnapShot(doc)).where(
                (complaints) => complaints.raisedBy == uid,
              ));

  static final FirebaseCloudStorage _shared =
      FirebaseCloudStorage._sharedInstance();
  FirebaseCloudStorage._sharedInstance();
  factory FirebaseCloudStorage() => _shared;
}
