import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wordsapp/app/core/components/word_detail_card_widget.dart';
import 'package:wordsapp/app/core/models/word_definition/word_definition_model.dart';
import 'package:wordsapp/app/modules/words/pages/word_detail/word_detail_controller.dart';

class WordDetailPage extends StatefulWidget {
  const WordDetailPage({super.key});

  @override
  State<WordDetailPage> createState() => _WordDetailPageState();
}

class _WordDetailPageState extends State<WordDetailPage> {
  final controller = Modular.get<WordDetailController>();

  @override
  void initState() {
    controller.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFefefef),
      body: SafeArea(
        child: Observer(builder: (context) {
          List<WordDefinitionModel> meanings =
              controller.wordDetail?.results ?? [];
          return SingleChildScrollView(
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
                      isFavorite: controller.isFavorite,
                      onTapFavorite: () =>
                          controller.setFavoriteWord(controller.wordDetail),
                      description:
                          controller.wordDetail?.pronunciation?.all ?? '',
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => controller.speech(),
                        icon: controller.ttsState == TtsState.playing
                            ? const Icon(Icons.pause)
                            : const Icon(Icons.play_arrow),
                      ),
                      Expanded(
                        child: TweenAnimationBuilder<double>(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeInOut,
                          tween: Tween<double>(
                            begin: 0,
                            end: controller.progress,
                          ),
                          builder: (context, value, _) =>
                              LinearProgressIndicator(
                            value: value,
                            backgroundColor: Colors.white,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (meanings.isNotEmpty)
                    Text(
                      'Meanings',
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ListView.builder(
                    itemCount: meanings.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          '- ${meanings[index].definition}',
                          style: GoogleFonts.playfairDisplay(fontSize: 16),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  if (controller.wordDetail?.frequency != null)
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
          );
        }),
      ),
    );
  }
}
