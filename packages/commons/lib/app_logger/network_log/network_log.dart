import 'dart:convert';

import 'package:commons/app_logger/app_logger.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:commons/commons.dart';

const _color = {
  'PENDING': Colors.amber,
  'ERROR': Colors.red,
  'SUCCESS': Colors.green
};

const _colorMethod = {
  'GET': Colors.green,
  'POST': Colors.amber,
  'PUT': Colors.blue,
  'DELETE': Colors.red,
};

class NetworkLog extends StatefulWidget {
  const NetworkLog({super.key});

  @override
  State<NetworkLog> createState() => _NetworkLogState();
}

class _NetworkLogState extends State<NetworkLog> {
  late final ScrollController _scrollController;
  late final List<NetWorkInfo> data;

  @override
  void initState() {
    data = AppLogger.listRequest.toList();

    _scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        controller: _scrollController,
        padding: const EdgeInsets.only(bottom: 200),
        itemBuilder: (_, i) {
          return ExpandableNotifier(
            child: ScrollOnExpand(
              child: ExpandablePanel(
                  theme: const ExpandableThemeData(hasIcon: false),
                  header: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text.rich(TextSpan(children: [
                          TextSpan(
                            text: data[i].method,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: _colorMethod[data[i].method],
                            ),
                          ),
                          const TextSpan(text: ' '),
                          TextSpan(text: data[i].uri),
                        ]))),
                        Column(
                          children: [
                            Text(
                              data[i].status,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: _color[data[i].status],
                              ),
                            ),
                            Text(
                              'STT: ${data[i].statusCode?.toString() ?? '-'}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  collapsed: const SizedBox(),
                  expanded: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Request headers:'),
                        SelectableText(const JsonEncoder.withIndent('    ')
                            .convert(data[i].headers)),
                        const SizedBox(height: 16),
                        const Text('Request body:'),
                        SelectableText(const JsonEncoder.withIndent('    ')
                            .convert(data[i].body)),
                        const SizedBox(height: 16),
                        const Text('Response body:'),
                        SelectableText(const JsonEncoder.withIndent('    ')
                            .convert(data[i].response)),
                      ],
                    ),
                  )),
            ),
          );
        },
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemCount: data.length,
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              data.clear();
              data.addAll(AppLogger.listRequest.toList());
              setState(() {});
            },
            icon: const Icon(Icons.refresh),
          ),
          IconButton(
            onPressed: () {
              AppLogger.listRequest.clear();
              data.clear();
              setState(() {});
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
