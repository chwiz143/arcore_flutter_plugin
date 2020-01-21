import 'arcore_pose.dart';

enum TrackingState {
  TRACKING,
  PAUSED,
  STOPPED,
}

class ARCoreAnchor {
  TrackingState trackingState;
  double extentX;
  double extentZ;
  ArCorePose centerPose;

  ARCoreAnchor.fromMap(Map<dynamic, dynamic> map) {
    String trackStr = map["trackingState"];
    switch (trackStr) {
      case "TRACKING":
        this.trackingState = TrackingState.TRACKING;
        break;
      case "PAUSED":
        this.trackingState = TrackingState.PAUSED;
        break;
      default:
        this.trackingState = TrackingState.STOPPED;
    }

    this.extentX = map["extentX"];
    this.extentZ = map["extentZ"];
    this.centerPose = ArCorePose.fromMap(map["centerPose"]);
  }
}

class ARCorePlane extends ARCoreAnchor {
  ARCorePlaneType type;

  ARCorePlane.fromMap(Map map) : super.fromMap(map) {
    this.type = ARCorePlaneType.values[map["type"] ?? 0];
  }
}

enum ARCorePlaneType {
  HORIZONTAL_UPWARD_FACING,
  HORIZONTAL_DOWNWARD_FACING,
  VERTICAL,
}

enum TrackingMethod {
  FULL_TRACKING,
  LAST_KNOWN_POSE,
  NOT_TRACKING,
}

class ARCoreMarker extends ARCoreAnchor {
  String name;
  TrackingMethod trackingMethod;

  ARCoreMarker.fromMap(Map map) : super.fromMap(map) {
    this.name = map["name"];
    String trackMethod = map["trackingMethod"];
    switch (trackMethod) {
      case "FULL_TRACKING":
        this.trackingMethod = TrackingMethod.FULL_TRACKING;
        break;
      case "LAST_KNOWN_POSE":
        this.trackingMethod = TrackingMethod.LAST_KNOWN_POSE;
        break;
      case "NOT_TRACKING":
      default:
        this.trackingMethod = TrackingMethod.NOT_TRACKING;
    }
  }
}
