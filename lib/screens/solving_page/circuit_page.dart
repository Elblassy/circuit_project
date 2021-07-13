import 'package:circuit_project/global_widgets/loading_layout.dart';
import 'package:circuit_project/screens/solving_page/widgets/item_component.dart';
import 'package:circuit_project/providers/data_provider.dart';
import 'package:circuit_project/screens/solving_page/widgets/resistance_widget.dart';
import 'package:circuit_project/screens/solving_page/widgets/voltage_widget.dart';
import 'package:circuit_project/utils/tools.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../models/node_element.dart';
import 'widgets/draw_circuit.dart';

class CircuitPage extends StatefulWidget {
  final componentName = TextEditingController();

  @override
  _CircuitPageState createState() => _CircuitPageState();
}

class _CircuitPageState extends State<CircuitPage> {
  final valueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            children: [
              Consumer<DataProvider>(
                builder: (context, provider, child) => Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    width: double.infinity,
                    child: Text(
                      provider.selectedComponent.name,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.mPlusRounded1c(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 82.sp,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: ScreenUtil().screenWidth * .3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: .1,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Consumer<DataProvider>(
                    builder: (context, provider, child) => TextField(
                      decoration: InputDecoration.collapsed(
                        hintText: provider.selectedComponent.value,
                      ),
                      controller: valueController,
                      onSubmitted: (String value) {
                        if (isNumeric(value)) {
                          Provider.of<DataProvider>(context, listen: false)
                              .setSelectedComponentValue(value);
                        } else {
                          final snackBar = SnackBar(
                            content: Text(
                              'Numbers only is allowed',
                              style: GoogleFonts.mPlusRounded1c(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32.sp,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                            backgroundColor: Colors.red[500],
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          valueController.text = "";
                        }
                      },
                      textAlign: TextAlign.center,
                      style: GoogleFonts.mPlusRounded1c(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 42.sp,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Consumer<DataProvider>(
                builder: (context, provider, child) => Container(
                  height: ScreenUtil().screenHeight * .065,
                  child: ListView.builder(
                    itemCount: provider.components.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return ItemsComponent(
                        componentName: provider.components[index].name,
                        selectedIndex: provider.selectedComponentIndex,
                        index: index,
                        onSelect: () {
                          setState(() {
                            valueController.text = Provider.of<DataProvider>(
                                    context,
                                    listen: false)
                                .selectedComponent
                                .value;
                          });
                        },
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 8.0, right: 8.0, bottom: 8.0, top: 18.0),
                  child: Container(
                    width: ScreenUtil().screenWidth,
                    decoration: BoxDecoration(
                      color: Color(0xFF421c4b),
                      shape: BoxShape.rectangle,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x55421c4b),
                          blurRadius: 0.5,
                          spreadRadius: -10,
                          offset: Offset(0, -30),
                        )
                      ],
                      borderRadius: BorderRadius.all(
                        Radius.circular(35.0),
                      ),
                    ),
                    child: Consumer<DataProvider>(
                      builder: (context, provider, child) => LayoutBuilder(
                        builder: (context, constraints) => Stack(
                          children: [
                            Container(
                                child: CustomPaint(
                                  painter: FaceOutLinePainter(provider.nodes),
                                ),
                                width: constraints.maxWidth,
                                height: constraints.maxHeight),

                            ...provider.components
                                .asMap()
                                .map((index, comp) {
                                  if (comp.name.contains('V')) {
                                    return MapEntry(
                                        index,
                                        Container(
                                          width: constraints.maxWidth,
                                          height: constraints.maxHeight,
                                          child: CustomPaint(
                                            painter: DrawCircle(
                                                xCenter: comp.xCenter *
                                                    constraints.maxWidth,
                                                yCenter: comp.yCenter *
                                                    constraints.maxHeight,
                                                height: comp.height *
                                                    constraints.maxHeight,
                                                selectedIndex: provider
                                                    .selectedComponentIndex,
                                                index: index),
                                          ),
                                        ));
                                  } else {
                                    return MapEntry(
                                      index,
                                      Resistance(
                                        topLeft: comp.topLeft,
                                        width: comp.width,
                                        height: comp.height,
                                        canvasWidth: constraints.maxWidth,
                                        canvasHeight: constraints.maxHeight,
                                        index: index,
                                        selectedIndex:
                                            provider.selectedComponentIndex,
                                      ),
                                    );
                                  }
                                })
                                .values
                                .toList(),
                            // for ( var i in text ) Text(i.toString())
                            // Resistance(topLeft: c, width: width, height: height, canvasWidth: canvasWidth, canvasHeight: canvasHeight)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF421c4b),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (_) => LoadingOverlay(
                          loadingText: "Solving Circuit...",
                        ),
                      );
                      await Provider.of<DataProvider>(context, listen: false)
                          .solveCircuit();
                      navKey.currentState?.pop();
                      showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        context: context,
                        builder: (context) => Container(
                          height: ScreenUtil().screenHeight * .5,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: const Radius.circular(20.0),
                                        topRight: const Radius.circular(20.0))),
                                child: Center(
                                  child: Text(
                                    Provider.of<DataProvider>(context,
                                            listen: false)
                                        .result,
                                    style: GoogleFonts.mPlusRounded1c(
                                      textStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 38.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xFF421c4b),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Text(
                                      "Done",
                                      style: GoogleFonts.mPlusRounded1c(
                                        textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 38.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "Solve Circuit",
                        style: GoogleFonts.mPlusRounded1c(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 38.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}

class FaceOutLinePainter extends CustomPainter {
  List<NodeElement> nodes;

  FaceOutLinePainter(this.nodes);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.white
      ..strokeWidth = 1;

    Path nodePath = Path();

    for (int i = 0; i < nodes.length; i++) {
      nodePath.moveTo(nodes[i].points[0][0] * size.width,
          nodes[i].points[0][1] * size.height);

      for (int j = 1; j < nodes[i].points.length; j++) {
        nodePath.lineTo(nodes[i].points[j][0] * size.width,
            nodes[i].points[j][1] * size.height);
      }
      nodePath.close();
      canvas.drawPath(nodePath, paint);
    }

    // TODO: implement paint
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
