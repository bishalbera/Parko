import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomContinueButton extends StatefulWidget {
  final String text;
  final Color color;
  final Color textColor;
  final VoidCallback onTap;
  const CustomContinueButton(
      {super.key,
      this.text = "Button",
      this.color = Colors.grey,
      this.textColor = Colors.black,
      required this.onTap});

  @override
  State<CustomContinueButton> createState() => _CustomContinueButtonState();
}

class _CustomContinueButtonState extends State<CustomContinueButton> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: size.height * 0.06,
        width: double.infinity,
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 40),
        alignment: Alignment.center,
        child: Text(
          widget.text,
          style: GoogleFonts.roboto(
              color: widget.textColor,
              fontSize: 18,
              fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}