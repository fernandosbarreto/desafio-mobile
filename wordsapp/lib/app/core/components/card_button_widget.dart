import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardButtonWidget extends StatelessWidget {
  final String label;
  final bool isSelected;
  final void Function()? onTap;

  const CardButtonWidget({
    super.key,
    required this.label,
    this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Material(
          color: isSelected ? Colors.black : Colors.white,
          child: InkWell(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  label,
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 16,
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
