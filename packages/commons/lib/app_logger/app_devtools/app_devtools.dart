import 'package:commons/commons.dart';
import 'package:flutter/material.dart';

import '../network_log/network_log.dart';

class AppDevTools extends StatelessWidget {
  const AppDevTools({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              const TabBar(labelColor: Colors.amber, tabs: [
                Tab(text: 'Console log'),
                Tab(text: 'Net work'),
              ]),
              Expanded(
                  child: TabBarView(children: [
                LogConsole(),
                const NetworkLog(),
              ])),
            ],
          )),
    );
  }
}
