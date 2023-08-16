import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wordsapp/app/core/components/resize_on_tap_widget.dart';
import 'package:wordsapp/app/modules/words/pages/favorites/favorites_controller.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final controller = Modular.get<FavoritesController>();

  @override
  void initState() {
    controller.getFavoriteWords();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Favorites',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(height: 8),
              if (controller.favoriteWords.isNotEmpty)
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
                          itemCount: controller.favoriteWords.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GridTile(
                              child: ResizeOnTapWidget(
                                child: GestureDetector(
                                  onTap: () async {
                                    await controller.getWordDetail(
                                        controller.favoriteWords[index].word ??
                                            '');

                                    controller.wordDetail.maybeWhen(
                                      data: (data) {
                                        Modular.to
                                            .pushNamed('/word-detail')
                                            .then((value) =>
                                                controller.getFavoriteWords());
                                      },
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
                                        controller.favoriteWords[index].word ??
                                            '',
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
      );
    });
  }
}
