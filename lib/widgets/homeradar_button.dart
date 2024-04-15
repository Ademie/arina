import 'package:flutter/material.dart';

class HomeRadarButton extends StatelessWidget {
  const HomeRadarButton({
    super.key,
    this.text,
    this.onPressed,
    this.width,
    this.height,
    this.isLoading = false,
  });
  final String? text;
  final Function()? onPressed;
  final double? width;
  final double? height;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF232323),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        shadowColor: const Color(0x3F303030),
        elevation: 10,
      ),
      child: SizedBox(
          // width: width ?? 260,
          // height: height ?? 50,
          child: Center(
              child: isLoading
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : Text(
                      text ?? "Button",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Nunito Sans',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ))),
    );
  }
}
