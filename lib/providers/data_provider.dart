import 'package:circuit_project/cloud_functions/network_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../models/node_element.dart';
import 'dart:io';
import '../models/component.dart';

class DataProvider with ChangeNotifier {
  List<NodeElement> _nodes = [];
  List<Component> _components = [];
  String _ground = "";
  String _result = "";

  int _selectedComponentIndex = 0;

  getCircuitData(File croppedImage) async {
    try {
      final jsonData = await upload(croppedImage);
      print(jsonData);

      if (jsonData == null) {
        return;
      }
      List<NodeElement> resultNodes = [];
      for (Map<String, dynamic> item in List.from(jsonData['nodes'])) {
        NodeElement node = NodeElement.fromJson(item);
        resultNodes.add(node);
      }
      List<Component> resultComponent = [];
      for (Map<String, dynamic> item in List.from(jsonData['components'])) {
        Component component = Component.fromJson(item);
        resultComponent.add(component);
      }

      _ground = jsonData['ground'];

      _nodes = resultNodes;
      _components = resultComponent;
      _selectedComponentIndex = 0;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  solveCircuit() async {
    try {
      _result = "";
      final jsonData = await solve(components, ground);
      _result = jsonData ?? "";

      var tempResults = _result.split("\n");
      for (var i in tempResults) {
        if (i.trim().isEmpty)
          continue;
        for (var c in components) {
          if (c.name == i.substring(0, i.indexOf("=")).trim()) {
            c.current = i.substring(i.indexOf("C"), i.indexOf(","));
            c.voltage = i.substring(i.indexOf("V"), i.length);
            break;
          }
          print(c.current);
          print( c.voltage);

        }
      }
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  List<NodeElement> get nodes {
    return _nodes;
  }

  String get result {
    return _result;
  }

  String get ground {
    return _ground;
  }

  List<Component> get components {
    return _components;
  }

  int get selectedComponentIndex {
    return _selectedComponentIndex;
  }

  Component get selectedComponent {
    return components[selectedComponentIndex];
  }

  void setSelectedIndex(int index) {
    _selectedComponentIndex = index;
    notifyListeners();
  }

  void setSelectedComponentValue(String value) {
    components[selectedComponentIndex].value = value;
  }
}
