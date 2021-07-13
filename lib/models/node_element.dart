class NodeElement {
  NodeElement({
    required this.name,
    required this.points,
  });

  String name;
  List<List<double>> points;

  factory NodeElement.fromJson(Map<String, dynamic> json) => NodeElement(
    name: json["name"],
    points: List<List<double>>.from(json["point"]
        .map((x) => List<double>.from(x.map((x) => x.toDouble())))),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "point": List<dynamic>.from(
        points.map((x) => List<dynamic>.from(x.map((x) => x)))),
  };
}
