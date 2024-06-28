enum EventType { startShift, endShift, startVisit, endVisit }

extension EventTypeExtension on EventType {
  String toMap() {
    switch (this) {
      case EventType.startShift:
        return 'start_shift';
      case EventType.endShift:
        return 'end_shift';
      case EventType.startVisit:
        return 'start_visit';
      case EventType.endVisit:
        return 'end_visit';
      default:
        return "";
    }
  }
}
