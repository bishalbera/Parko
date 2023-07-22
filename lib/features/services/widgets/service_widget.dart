import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ServiceWidget extends StatefulWidget {
  final String text;
  final String imageLocation;
  final VoidCallback onTap;
  const ServiceWidget(
      {super.key,
      required this.text,
      required this.imageLocation,
      required this.onTap});

  @override
  State<ServiceWidget> createState() => _ServiceWidgetState();
}

class _ServiceWidgetState extends State<ServiceWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return InkWell(
      onTap: () {
        widget.onTap();
      },
      child: Container(
        width: size.width * 0.58,
        height: size.height * 0.14,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.grey,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: Row(
            children: [
              Container(
                width: 90,
                child: Text(
                  "${widget.text}",
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                width: 3,
              ),
              Container(
                height: 200,
                width: 80,
                child: Image(
                  image: AssetImage('${widget.imageLocation}'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
