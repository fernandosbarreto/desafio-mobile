import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:wordsapp/app/core/components/card_button_widget.dart';
import 'package:wordsapp/app/modules/words/pages/history/history_page.dart';
import 'package:wordsapp/app/modules/words/pages/home_controller.dart';
import 'package:wordsapp/app/modules/words/pages/word_list/word_list_page.dart';

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
  void dispose() {
    controller.pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFefefef),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
          child: Column(
            children: [
              Observer(builder: (context) {
                return Row(
                  children: [
                    CardButtonWidget(
                      label: 'Word List',
                      isSelected: controller.currentPage == 0,
                      onTap: () => controller.setPage(0),
                    ),
                    const SizedBox(width: 16),
                    CardButtonWidget(
                      label: 'History',
                      isSelected: controller.currentPage == 1,
                      onTap: () => controller.setPage(1),
                    ),
                    const SizedBox(width: 16),
                    CardButtonWidget(
                      label: 'Favorites',
                      isSelected: controller.currentPage == 2,
                      onTap: () => controller.setPage(2),
                    ),
                  ],
                );
              }),
              const SizedBox(height: 16),
              Expanded(
                child: PageView(
                  controller: controller.pageViewController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: const [
                    WordListPage(),
                    HistoryPage(),
                    Center(child: Text('3')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
