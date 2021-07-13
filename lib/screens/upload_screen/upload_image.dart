import 'package:circuit_project/global_widgets/loading_layout.dart';
import 'package:circuit_project/providers/data_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../solving_page/circuit_page.dart';
import '../../utils/crop_image.dart';
import '../../utils/show_picker_dialog.dart';
import 'dart:io';
import 'package:provider/provider.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({Key? key}) : super(key: key);

  @override
  _UploadImageState createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  final ImagePicker _picker = ImagePicker();
  ValueNotifier<bool> _loading = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                Text(
                  "Circuit Solver",
                  style: GoogleFonts.mPlusRounded1c(
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 60.sp,
                    ),
                  ),
                ),
                ValueListenableBuilder<bool>(
                  builder: (context, value, child) =>
                      Lottie.asset('assets/main_lottie.json', animate: !value),
                  valueListenable: _loading,
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF421c4b),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    onPressed: () {
                      uploadAndProcessImage(context, _picker, _loading);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.upload_outlined),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            "Upload Image",
                            style: GoogleFonts.mPlusRounded1c(
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 38.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          ValueListenableBuilder<bool>(
            builder: (context, loading, child) =>
                loading ? LoadingOverlay() : Container(),
            valueListenable: _loading,
          )
        ],
      ),
    );
  }
}

void uploadAndProcessImage(
    BuildContext context, ImagePicker picker, ValueNotifier loading) async {
  final result = await showPickerDialog(context);

  if (result == null) return;

  final PickedFile? pickedFile;
  if (result) {
    pickedFile =
        await picker.getImage(source: ImageSource.camera, imageQuality: 50);
  } else {
    pickedFile =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 50);
  }
  if (pickedFile == null) return;

  final File? croppedImage = await cropImage(pickedFile.path);

  if (croppedImage != null) {
    loading.value = true;
    await Provider.of<DataProvider>(context,listen: false).solveCircuit(croppedImage);
    loading.value = false;
    Navigator.of(context).push(CupertinoPageRoute(
      builder: (context) => CircuitPage(),
    ));
  }
}
