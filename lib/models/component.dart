class Component {
  Component({
    required this.bottomRight,
    required this.height,
    required this.minimumDistance,
    required this.name,
    required this.nodes,
    required this.points,
    required this.topLeft,
    required this.value,
    required this.width,
    required this.xCenter,
    required this.yCenter,
  });

  List<double> bottomRight;
  double height;
  double minimumDistance;
  String name;
  List<String> nodes;
  List<List<int>> points;
  List<double> topLeft;
  String value;
  String? current;
  String? voltage;
  double width;
  double xCenter;
  double yCenter;

  factory Component.fromJson(Map<String, dynamic> json) => Component(
        bottomRight:
            List<double>.from(json["bottom_right"].map((x) => x.toDouble())),
        height: json["height"].toDouble(),
        minimumDistance: json["minimum_distance"].toDouble(),
        name: json["name"],
        nodes: List<String>.from(json["nodes"].map((x) => x)),
        points: List<List<int>>.from(
            json["points"].map((x) => List<int>.from(x.map((x) => x)))),
        topLeft: List<double>.from(json["top_left"].map((x) => x.toDouble())),
        value: json["value"],
        width: json["width"].toDouble(),
        xCenter: json["x_center"].toDouble(),
        yCenter: json["y_center"].toDouble(),

      );

  Map<String, dynamic> toJson() => {
        "bottom_right": List<dynamic>.from(bottomRight.map((x) => x)),
        "height": height,
        "minimum_distance": minimumDistance,
        "name": name,
        "nodes": List<dynamic>.from(nodes.map((x) => x)),
        "points": List<dynamic>.from(
            points.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "top_left": List<dynamic>.from(topLeft.map((x) => x)),
        "value": value,
        "width": width,
        "x_center": xCenter,
        "y_center": yCenter,
      };
}
