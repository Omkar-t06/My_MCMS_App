import 'package:my_mcms/constants/enums.dart';

extension ComplaintStatusExtension on ComplaintStatus {
  String get status {
    switch (this) {
      case ComplaintStatus.pending:
        return "pending";
      case ComplaintStatus.inProgress:
        return "inProgress";
      case ComplaintStatus.resolved:
        return "resolved";
      case ComplaintStatus.closed:
        return "closed";
    }
  }

  static ComplaintStatus fromString(String status) {
    switch (status) {
      case "pending":
        return ComplaintStatus.pending;
      case "inProgress":
        return ComplaintStatus.inProgress;
      case "resloved":
        return ComplaintStatus.resolved;
      case "closed":
        return ComplaintStatus.closed;
      default:
        throw Exception("Invalid Status");
    }
  }
}
