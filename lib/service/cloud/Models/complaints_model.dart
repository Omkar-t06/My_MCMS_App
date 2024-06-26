import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_mcms/constants/enums.dart';
import 'package:my_mcms/service/cloud/constants/cloud_storage_constant.dart';
import 'package:my_mcms/utils/extension/complaint_status.dart';

class ComplaintsModel {
  final String complaintId;
  final String description;
  final ComplaintStatus status;
  final List<String> images;
  final String location;
  final String raisedBy;
  final String department;
  final DateTime complainOn;

  ComplaintsModel({
    required this.complaintId,
    required this.description,
    required this.status,
    required this.images,
    required this.location,
    required this.raisedBy,
    required this.department,
    required this.complainOn,
  });

  ComplaintsModel.fromSnapShot(
    QueryDocumentSnapshot<Map<String, dynamic>> snapshot,
  )   : complaintId = snapshot.id,
        description = snapshot.data()[complaintDescriptionFieldName] as String,
        status = ComplaintStatusExtension.fromString(
            snapshot.data()[complaintStatusFieldName] as String),
        images = snapshot.data()[complaintImageFieldName] as List<String>,
        location = snapshot.data()[complaintLocationFieldName] as String,
        raisedBy = snapshot.data()[complaintRaisedByFieldName] as String,
        department = snapshot.data()[complaintDepartmentFieldName] as String,
        complainOn = snapshot.data()[complaintDateFieldName] as DateTime;
}
