import 'package:flutter/material.dart';
import 'package:flutter_coop_driver_mixay/Colors.dart/MxColors.dart';

//สร้าง SizedBox ต้นแบบ
class MenuBox extends StatelessWidget {
  final String text;
  final String imagePath;
  final double imageHeight; // New parameter for image height
  final double imageWidth;
  final double sizedboxwidth; // New parameter for image width
  final VoidCallback? onPressed;

  // final VoidCallback onPressed;
  const MenuBox({
    super.key,
    required this.text,
    required this.imagePath,
    required this.imageHeight,
    required this.imageWidth,
    required this.sizedboxwidth,
    this.onPressed,
    // required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3, left: 8, right: 8),
      child: SizedBox(
        width: double.infinity,
        height: 75,
        child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            )),
            backgroundColor: MaterialStateProperty.all(MxColors.mainColorWhite),
          ),
          onPressed: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.start, // Changed to MainAxisAlignment.start
              children: [
                Image.asset(
                  imagePath, // Replace with the actual path to your image
                  height:
                      imageHeight, // Adjust the height according to your image requirements
                  width:
                      imageWidth, // Adjust the width according to your image requirements
                ),
                SizedBox(
                    width:
                        sizedboxwidth), // Adding some spacing between image and text
                Expanded(
                  child: Text(
                    text,
                    style: const TextStyle(
                        fontSize: 25, color: MxColors.mainColorBlue),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
