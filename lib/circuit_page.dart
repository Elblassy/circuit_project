import 'package:circuit_project/item_component.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircuitPage extends StatefulWidget {
  final componentName = TextEditingController();

  @override
  _CircuitPageState createState() => _CircuitPageState();
}

class _CircuitPageState extends State<CircuitPage> {
  var listItem = ["R2", "R1", "R4", "R3", "V3"];
  int selectedComponent = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                width: double.infinity,
                child: Text(
                  widget.componentName.text,
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
                child: TextField(
                  decoration: InputDecoration.collapsed(
                    hintText: "value",
                  ),
                  keyboardType: TextInputType.number,
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
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                height: ScreenUtil().screenHeight * .065,
                child: ListView.builder(
                  itemCount: listItem.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return ItemsComponent(
                      componentName: listItem[index],
                      selectedIndex: selectedComponent,
                      index: index,
                      selected: (selected) {
                        setState(() {
                          selectedComponent = selected;
                          widget.componentName.text =
                              listItem[selectedComponent];
                        });
                      },
                    );
                  },
                ),
              ),
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
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    widget.componentName.text = listItem[selectedComponent];
  }
}
