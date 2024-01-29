import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

enum MessageOptionType {
  reply,
  forward,
  detail,
  pin,
  copy,
  evict,
  select,
  calendar,
  mark,
  delete,
  unknow,
  ;

  factory MessageOptionType.from(String? value) =>
      values.firstWhereOrNull((element) => element.name == value) ??
      MessageOptionType.unknow;
}

class MessageOption extends StatelessWidget {
  const MessageOption({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Color(0xff4284F3),
              offset: Offset(0, 1),
              blurRadius: 9,
            )
          ]),
      // child: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   mainAxisSize: MainAxisSize.min,
      //   children: Utils.chunks(state.messageOption, 4)
      //       .map((row) => Row(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             mainAxisSize: MainAxisSize.min,
      //             children: row
      //                 .map((e) => Container(
      //                       margin: const EdgeInsets.symmetric(vertical: 8),
      //                       width: 90,
      //                       height: 36,
      //                       child: Column(
      //                         children: [
      //                           VdiaryImage(path: e.imgIcon),
      //                           Spaces.h4,
      //                           Text(
      //                             e.name.tr(),
      //                             style: TextDefine.P3_R,
      //                           ),
      //                         ],
      //                       ),
      //                     ))
      //                 .toList(),
      //           ))
      //       .toList(),
      // ),
    );
  }
}
