import 'dart:async';

import 'package:finplus/core/utils/background_uploader/background_uploader.dart';
import 'package:finplus/layers/domain/entities/message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SendingMessage extends StatefulWidget {
  final MessageModel messsage;
  const SendingMessage({super.key, required this.messsage});

  @override
  State<SendingMessage> createState() => _SendingMessageState();
}

class _SendingMessageState extends State<SendingMessage> {
  StreamController<num>? streamController;
  @override
  void initState() {
    streamController = BackgroundUploader()
        .getSendingMessage(widget.messsage.id.toString())
        ?.stream;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<num>(
      stream: streamController?.stream,
      builder: (context, snapshot) => Align(
        alignment: Alignment.centerRight,
        child: SizedBox(
          width: 36,
          height: 36,
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              // color: AppColors.blue_core,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: const [
                SpinKitRing(
                  color: Colors.white,
                  size: 36.0,
                ),
                // Text(
                //   Utils.formatNumber(
                //     snapshot.data,
                //     pattern: NumberPattern.PERCENT_PATTERN_INTERGER,
                //   ),
                //   style: TextDefine.P3_M.copyWith(color: Colors.white),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
