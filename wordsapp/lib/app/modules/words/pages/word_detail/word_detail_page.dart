import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wordsapp/app/core/components/word_detail_card_widget.dart';
import 'package:wordsapp/app/modules/words/pages/word_detail/word_detail_controller.dart';

class WordDetailPage extends StatefulWidget {
  const WordDetailPage({super.key});

  @override
  State<WordDetailPage> createState() => _WordDetailPageState();
}

class _WordDetailPageState extends State<WordDetailPage> {
  final controller = Modular.get<WordDetailController>();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Scaffold(
        backgroundColor: const Color(0xFFefefef),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () => Modular.to.pop(),
                    child: const SizedBox(
                      height: 40,
                      width: 40,
                      child: Center(child: Icon(Icons.close)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: WordDetailCardWidget(
                      label: controller.wordDetail?.word ?? '',
                      description:
                          controller.wordDetail?.pronunciation?.all ?? '',
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Meanings',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ListView.builder(
                    itemCount: controller.wordDetail?.results?.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          '- ${controller.wordDetail?.results?[index].definition}',
                          style: GoogleFonts.playfairDisplay(fontSize: 16),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Text(
                        'Frequency: ${controller.wordDetail?.frequency}',
                        style: GoogleFonts.playfairDisplay(fontSize: 16),
                      ),
                      const SizedBox(width: 12),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: LinearProgressIndicator(
                          color: Colors.black45,
                          backgroundColor: Colors.white,
                          value: controller.calculatedFrequency(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
