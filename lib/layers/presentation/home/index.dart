import 'package:commons/commons.dart';
import 'package:finplus/constant/assets.gen.dart';
import 'package:finplus/layers/presentation/chat_room/index.dart';
import 'package:finplus/screens/Home/index.dart';
import 'package:finplus/styles/styles.dart';
import 'package:flutter/material.dart';

import 'controller.dart';

class _Menu {
  final String icon;

  final String label;

  _Menu(this.icon, this.label);
}

final _menus = [
  _Menu(Assets.icons.home, 'Trang chủ'),
  _Menu(Assets.icons.heart, 'Sức khỏe'),
  _Menu(Assets.icons.chat, 'Nhắn tin'),
  _Menu(Assets.icons.userInfo, 'Cá nhân'),
];

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (c) => Scaffold(
        body: Obx(() => _getBody(c.selectedIndex)),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(canvasColor: secondary02),
          child: Obx(() => BottomNavigationBar(
                selectedItemColor: tertiary09,
                unselectedItemColor: Colors.white,
                currentIndex: c.selectedIndex,
                onTap: (value) => c.selectedIndex = value,
                items: _menus
                    .mapIndexed(
                      (i, e) => BottomNavigationBarItem(
                        icon: SvgPicture.asset(
                          e.icon,
                          color:
                              c.selectedIndex == i ? tertiary09 : Colors.white,
                        ),
                        label: e.label,
                      ),
                    )
                    .toList(),
              )),
        ),
      ),
    );
  }

  Widget _getBody(int index) {
    switch (index) {
      case 3:
        return const HomePage();
      case 2:
        return const ChatRoom();

      default:
        return const SizedBox();
    }
  }
}
