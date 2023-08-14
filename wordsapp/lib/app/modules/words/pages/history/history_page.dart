import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wordsapp/app/core/components/resize_on_tap_widget.dart';
import 'package:wordsapp/app/modules/words/pages/history/history_controller.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final controller = Modular.get<HistoryController>();

  @override
  void initState() {
    controller.updateHistory();
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
                  'History',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(height: 8),
              if (controller.wordHistory.isNotEmpty)
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
                        itemCount: controller.wordHistory.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GridTile(
                            child: ResizeOnTapWidget(
                              child: GestureDetector(
                                onTap: () => controller.getWordDetail(
                                    controller.wordHistory[index].word ?? ''),
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: Text(
                                      controller.wordHistory[index].word ?? '',
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
