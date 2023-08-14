import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wordsapp/app/core/components/resize_on_tap_widget.dart';

class WordDetailCardWidget extends StatelessWidget {
  final String label;
  final String description;
  final bool isFavorite;
  final void Function()? onTapFavorite;

  const WordDetailCardWidget({
    super.key,
    required this.label,
    required this.description,
    this.onTapFavorite,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    label,
                    style: GoogleFonts.playfairDisplay(fontSize: 32),
                  ),
                  if (description != '')
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Text(
                        description,
                        style: GoogleFonts.notoSerif(
                          fontSize: 32,
                          color: Colors.black45,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          right: 10,
          top: 10,
          child: ResizeOnTapWidget(
            child: GestureDetector(
              onTap: onTapFavorite,
              child: Icon(
                Icons.star,
                size: 40,
                color:
                    isFavorite ? Colors.black : Colors.black.withOpacity(0.2),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
