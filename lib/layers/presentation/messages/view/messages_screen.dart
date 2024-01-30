// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:commons/commons.dart';
import 'package:finplus/layers/data/repository/chat_repository_impl.dart';
import 'package:finplus/layers/presentation/messages/controller/messages_controller.dart';
import 'package:finplus/layers/presentation/widgets/selection_overlay/selection_overlay.dart';
import 'package:finplus/styles/styles.dart';
import 'package:finplus/utils/svg.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'attach_selection_widget.dart';
import 'friend_message.dart';
import 'message_option.dart';
import 'my_message.dart';

class MessagesScreen extends StatefulWidget {
  final int roomId;

  const MessagesScreen({
    super.key,
    required this.roomId,
  });

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final RefreshController refreshController = RefreshController();

  final ScrollController _scrollController = ScrollController();

  late final String userId;

  final ValueNotifier<bool> _recordNotifier = ValueNotifier(false);

  final ValueNotifier<int> _recordCountNotifier = ValueNotifier(0);

  final ValueNotifier<bool> _showScrollToStartNotifier = ValueNotifier(false);

  Timer? _recordTimer;

  @override
  void initState() {
    _scrollController.addListener(() {
      _showScrollToStartNotifier.value = _scrollController.position.pixels > 0;
    });
    super.initState();
  }

  @override
  void dispose() {
    refreshController.dispose();
    _recordNotifier.dispose();
    _recordCountNotifier.dispose();
    _showScrollToStartNotifier.dispose();
    _scrollController.dispose();
    _recordTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MessagesController>(
      init: MessagesController(ChatRepositoryImpl(), widget.roomId),
      builder: (c) => GestureDetector(
        child: Scaffold(
          body: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xffE9A237), Color(0xff9A0000)]),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        BackButton(color: theme.neutral10),
                        Expanded(
                            child: Obx(
                          () => Text(
                            c.roomInfo?.name ?? '',
                            style: TextStyle(
                              color: theme.neutral10,
                              fontSize: 14,
                              height: 1.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )),
                        Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: GestureDetector(
                              onTap: () {},
                              child: Icon(Icons.phone, color: theme.neutral10),
                            )),
                        Container(

                            // Set the desired width of the IconButton

                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: GestureDetector(
                              onTap: () {},
                              child: Icon(Icons.video_call,
                                  color: theme.neutral10),
                            )),
                        Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: GestureDetector(
                              onTap: () {},
                              child: Icon(Icons.more_horiz,
                                  color: theme.neutral10),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Obx(
                  () => SmartRefresher(
                    reverse: true,
                    scrollController: _scrollController,
                    controller: refreshController,
                    enablePullDown: false,
                    enablePullUp: true,
                    // onLoading: () => bloc.add(MessagesBlocGetMessages()),
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      reverse: true,
                      itemCount: c.messages.length,
                      itemBuilder: (_, i) {
                        final message = c.messages[i];
                        final nextMessage = i + 1 < c.messages.length
                            ? c.messages[i + 1]
                            : null;
                        final previousMessage =
                            i - 1 >= 0 ? c.messages[i - 1] : null;

                        //if (message.userId != userId)
                        return Align(
                          alignment: Alignment.centerLeft,
                          child: WidgetSelectionOverlay(
                            onLeft: true,
                            option: const MessageOption(),
                            optionHeight: 170,
                            child: FriendMessage(
                              nextMessage: nextMessage,
                              previousMessage: previousMessage,
                              message: message,
                              // showAvatar: c.roomInfo?.isGroup == true,
                            ),
                          ),
                        );

                        return Align(
                          alignment: Alignment.centerRight,
                          child: WidgetSelectionOverlay(
                            child: MyMessage(
                              nextMessage: nextMessage,
                              previousMessage: previousMessage,
                              message: message,
                            ),
                            option: const MessageOption(),
                            optionHeight: 170,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Container(
                // padding: Insets.v2,
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                    blurRadius: 7,
                    spreadRadius: 2,
                    color: Colors.black.withOpacity(0.03),
                  )
                ]),
                child: SafeArea(
                  child: Column(
                    children: [
                      ValueListenableBuilder(
                        valueListenable: _recordNotifier,
                        builder: (context, isRecording, child) {
                          return Row(
                            children: [
                              if (!isRecording) ...[
                                SizedBox.square(
                                  dimension: 36,
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: _showAttachSelection,
                                    icon: Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        // color: AppColors.blue_core,
                                      ),
                                      // child: SvgPicture.asset(
                                      //   SvgIcon.plus.path,
                                      //   color: Colors.white,
                                      // ),
                                    ),
                                  ),
                                ),
                                const SizedBox.square(
                                  dimension: 36,
                                  // child: IconButton(
                                  //   padding: const EdgeInsets.all(9),
                                  //   onPressed: () =>
                                  //       bloc.add(SelectImageMessagesEvent()),
                                  //   icon: SvgPicture.asset(
                                  //       SvgIcon.add_image.path),
                                  // ),
                                )
                              ] else
                                const SizedBox.square(
                                  dimension: 36,
                                  // child: IconButton(
                                  //   padding: EdgeInsets.zero,
                                  //   onPressed: () => _stopRecord(true),
                                  //   icon: Container(
                                  //     padding: const EdgeInsets.all(2),
                                  //     decoration: const BoxDecoration(
                                  //       shape: BoxShape.circle,
                                  //       color: AppColors.blue_core,
                                  //     ),
                                  //     child: SvgPicture.asset(
                                  //       SvgIcon.close.path,
                                  //       color: Colors.white,
                                  //       width: 14,
                                  //       height: 14,
                                  //     ),
                                  //   ),
                                  // ),
                                ),
                              Expanded(
                                child: AnimatedSize(
                                  duration: const Duration(milliseconds: 200),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                      // color: AppColors.ultra_light_grey,
                                    ),
                                    child: TextField(
                                      onTap: () {},
                                      controller: c.messageInput,
                                      maxLines: 3,
                                      minLines: 1,
                                      decoration: const InputDecoration(
                                        isDense: true,
                                        hintText: 'Message...',
                                        // hintStyle: TextDefine.P3_R.copyWith(
                                        //     color: AppColors.mac_grey),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 10),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                        ),
                                        suffixIconConstraints:
                                            BoxConstraints(maxHeight: 36),
                                        // suffixIcon: IconButton(
                                        //   padding: const EdgeInsets.all(8),
                                        //   onPressed: () => bloc.add(
                                        //       ToggleSendStickerMessagesEvent()),
                                        //   icon: SvgPicture.asset(
                                        //       SvgIcon.sticker.path),
                                        // ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox.square(
                                dimension: 44,
                                child: IconButton(
                                  padding: const EdgeInsets.all(12),
                                  onPressed: c.sendMessage,
                                  icon: SvgPicture.asset(SvgIcon.cancle),
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          // bottomNavigationBar:
          //     Consumer<ScreenHeight>(builder: (context, res, child) {
          //   bloc.setKeyboardHeight(res.keyboardHeight);

          //   return KeyboardVisibilityBuilder(
          //       builder: (context, isKeyboardVisible) {
          //     bloc.add(KeyboardShowMessagesEvent(isKeyboardVisible));

          //     return bloc.builder(
          //       buildWhen: (previous, current) =>
          //           previous.visibleSticker != current.visibleSticker,
          //       builder: (context, state) {
          //         final keyboardHeight = StorageLocal.get(KEY.KEYBOARD_HEIGHT);

          //         final realHeight =
          //             keyboardHeight != 0 && keyboardHeight != null
          //                 ? keyboardHeight
          //                 : 250.0;

          //         return AnimatedWidgetVisible(
          //           duration: const Duration(milliseconds: 100),
          //           visible: state.visibleSticker,
          //           builder: () => SizedBox(
          //             height: realHeight,
          //             child: bloc.builder(
          //               buildWhen: (previous, current) =>
          //                   previous.isSendSticker != current.isSendSticker,
          //               builder: (context, state) => AnimatedWidgetVisible(
          //                 duration: const Duration(milliseconds: 100),
          //                 visible: state.isSendSticker,
          //                 builder: () => SizedBox(
          //                   height: realHeight,
          //                   child: BlocBuilder<HomeCubit, HomeState>(
          //                     buildWhen: (previous, current) =>
          //                         previous.stickers != current.stickers,
          //                     builder: (context, state) => StickerPopup(
          //                       stickers: state.stickers,
          //                       isScroll: true,
          //                       onSelectedSticker: (stickerPath) => bloc
          //                           .add(SendStickerMessageEvent(stickerPath)),
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           ),
          //         );
          //       },
          //     );
          //   });
          // }),
          floatingActionButton: ValueListenableBuilder(
            valueListenable: _showScrollToStartNotifier,
            builder: (context, value, child) => value
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 44),
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: const BoxDecoration(
                        // color: AppColors.light_grey,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () => _scrollController.animateTo(
                          0,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeIn,
                        ),
                        icon: const Icon(
                          Icons.keyboard_arrow_down_sharp,
                          // color: AppColors.textMessage,
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
          ),
        ),
      ),
    );
  }

  void _onSelectAttachAction(MessageAttachType type) {
    switch (type) {
      case MessageAttachType.image:
        break;
      case MessageAttachType.video:
        break;
      case MessageAttachType.audio:
        break;
      case MessageAttachType.document:
        break;
      case MessageAttachType.select_location:
        break;
      case MessageAttachType.send_current_location:
        break;
      default:
    }
  }

  void _showAttachSelection() {
    showModalBottomSheet(
      context: context,
      builder: (context) => AttachSelectionBottomSheet(
        onSelectOption: _onSelectAttachAction,
      ),
      useRootNavigator: true,
      isScrollControlled: true,
      isDismissible: true,
    );
  }
}
