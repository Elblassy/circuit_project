import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemsComponent extends StatefulWidget {
  const ItemsComponent({
    Key? key,
    required this.componentName,
    required this.index,
    required this.selected,
    this.selectedIndex,
  }) : super(key: key);

  final String componentName;
  final int index;
  final selectedIndex;
  final Function(int) selected;

  @override
  _ItemsComponent createState() => _ItemsComponent();
}

class _ItemsComponent extends State<ItemsComponent> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.selected(widget.index);
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        width: ScreenUtil().screenWidth * .2,
        margin: EdgeInsetsDirectional.all(6.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: widget.selectedIndex == widget.index
              ? Colors.deepOrangeAccent
              : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5.0,
            )
          ],
        ),
        child: Center(
          child: Text(
            widget.componentName,
            textAlign: TextAlign.center,
            style: GoogleFonts.mPlusRounded1c(
              textStyle: TextStyle(
                color: Colors.black,
                fontSize: 38.sp,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
