import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wordsapp/app/modules/words/components/card_button_widget.dart';
import 'package:wordsapp/app/modules/words/pages/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = Modular.get<HomeController>();

  @override
  void initState() {
    controller.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFefefef),
      body: Observer(builder: (context) {
        return controller.words.maybeWhen(
          data: (wordList) => SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      CardButtonWidget(
                        label: 'Word List',
                        isSelected: true,
                        onTap: () {},
                      ),
                      const SizedBox(width: 16),
                      CardButtonWidget(
                        label: 'History',
                        isSelected: false,
                        onTap: () {},
                      ),
                      const SizedBox(width: 16),
                      CardButtonWidget(
                        label: 'Favorites',
                        isSelected: false,
                        onTap: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
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
                      SliverGrid.builder(
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
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  wordList[index].word,
                                  style:
                                      GoogleFonts.playfairDisplay(fontSize: 16),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  )),
                ],
              ),
            ),
          ),
          orElse: () => const Center(
              child: CircularProgressIndicator(color: Colors.white)),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.increment();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
