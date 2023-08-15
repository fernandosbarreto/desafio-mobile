import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wordsapp/app/core/components/resize_on_tap_widget.dart';
import 'package:wordsapp/app/modules/words/pages/word_list/word_list_controller.dart';

class WordListPage extends StatefulWidget {
  const WordListPage({super.key});

  @override
  State<WordListPage> createState() => _WordListPageState();
}

class _WordListPageState extends State<WordListPage> {
  final controller = Modular.get<WordListController>();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return controller.words.maybeWhen(
        data: (wordList) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Word list',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Divider(height: 8),
                Expanded(
                  child: CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SliverPadding(
                        padding: const EdgeInsets.only(bottom: 16),
                        sliver: SliverGrid.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                            childAspectRatio: 1.0,
                          ),
                          itemCount:
                              wordList.length, // Número total de itens na grade
                          itemBuilder: (BuildContext context, int index) {
                            return GridTile(
                              child: ResizeOnTapWidget(
                                child: GestureDetector(
                                  onTap: () async {
                                    await controller
                                        .getWordDetail(wordList[index].word);

                                    controller.wordDetail.maybeWhen(
                                      data: (data) async => await Modular.to
                                          .pushNamed('/word-detail'),
                                      orElse: () {
                                        final snackBar = SnackBar(
                                          content: const Text(
                                              'Sorry, could not find definition of the word'),
                                          action: SnackBarAction(
                                            label: 'Done',
                                            onPressed: () {},
                                          ),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      },
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: Text(
                                        wordList[index].word,
                                        style: GoogleFonts.playfairDisplay(
                                            fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        orElse: () =>
            const Center(child: CircularProgressIndicator(color: Colors.white)),
      );
    });
  }
}
