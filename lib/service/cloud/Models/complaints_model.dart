import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_mcms/constants/enums.dart';
import 'package:my_mcms/service/cloud/constants/cloud_storage_constant.dart';
import 'package:my_mcms/utils/extension/complaint_status.dart';

class CloudModel {
  final String documentId;
  final String complaintId;
  final String description;
  final ComplaintStatus status;
  final List<String> images;
  final String location;
  final String raisedBy;

  CloudModel({
    required this.documentId,
    required this.complaintId,
    required this.description,
    required this.status,
    required this.images,
    required this.location,
    required this.raisedBy,
  });

  CloudModel.fromSnapShot(
    QueryDocumentSnapshot<Map<String, dynamic>> snapshot,
  )   : documentId = snapshot.id,
        complaintId = snapshot.data()[complaintIdFieldName] as String,
        description = snapshot.data()[complaintDescriptionFieldName] as String,
        status = ComplaintStatusExtension.fromString(
            snapshot.data()[complaintStatusFieldName] as String),
        images = snapshot.data()[complaintImageFieldName] as List<String>,
        location = snapshot.data()[complaintLocationFieldName] as String,
        raisedBy = snapshot.data()[complaintRaisedByFieldName] as String;
}
