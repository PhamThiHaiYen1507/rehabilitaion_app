import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

enum MessageAttachType {
  image,
  video,
  audio,
  document,
  survey,
  select_location,
  send_current_location,
  unknow,
  ;

  factory MessageAttachType.from(String? value) =>
      values.firstWhereOrNull((element) => element.name == value) ??
      MessageAttachType.unknow;
}

class AttachSelectionBottomSheet extends StatelessWidget {
  final void Function(MessageAttachType type) onSelectOption;
  const AttachSelectionBottomSheet({super.key, required this.onSelectOption});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 3,
          margin: const EdgeInsets.symmetric(vertical: 10),
          width: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            // color: AppColors.mid_grey.withOpacity(0.7),
          ),
        ),
        // Wrap(
        //   children: state.chatboxMenus
        //       .map((e) => GestureDetector(
        //             onTap: () {
        //               AppRouter.pop();
        //               onSelectOption(MessageAttachType.from(e.key));
        //             },
        //             child: Container(
        //               margin: Insets.all8,
        //               width: (MediaQuery.of(context).size.width - 64) / 4,
        //               height: 98,
        //               child: Column(
        //                 children: [
        //                   Container(
        //                       padding: Insets.all18,
        //                       height: 60,
        //                       width: 60,
        //                       decoration: BoxDecoration(
        //                           borderRadius: BorderRadius.circular(50),
        //                           color: AppColors.ultra_light_grey),
        //                       child: VdiaryImage(path: e.imgIcon)),
        //                   Spaces.h4,
        //                   Container(
        //                     margin: Insets.h8,
        //                     child: Text(
        //                       e.name.tr(),
        //                       style: TextDefine.te2_R,
        //                       textAlign: TextAlign.center,
        //                       maxLines: 2,
        //                       overflow: TextOverflow.ellipsis,
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ))
        //       .toList(),
        // ),
      ],
    );
  }
}
