import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
 
class ProfileWidget extends StatefulWidget {
  final Icon icon;
  final String text;
 
  const ProfileWidget({super.key, required this.icon, required this.text});
 
  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}
 
class _ProfileWidgetState extends State<ProfileWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
 
    return Container(
      width: size.width * 0.35,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: size.height * 0.14,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.icon,
          const SizedBox(
            height: 10,
          ),
          Text(
            "${widget.text}",
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}