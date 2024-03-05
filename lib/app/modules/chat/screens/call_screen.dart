import 'dart:async';
import 'dart:convert';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/core/values/app_consts.dart';
import 'package:dafa/app/core/values/app_text_style.dart';
import 'package:dafa/app/models/message.dart';
import 'package:dafa/app/modules/chat/chat_controller.dart';
import 'package:dafa/app/modules/sign_in/sign_in_controller.dart';
import 'package:dafa/app/routes/app_routes.dart';
import 'package:dafa/app/services/database_service.dart';
import 'package:dafa/app/services/firebase_messaging_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class CallScreen extends StatefulWidget {
  final String token;
  final String channelName;
  final String callId;
  const CallScreen(
      {super.key,
      required this.channelName,
      required this.token,
      required this.callId});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  final ChatController chatController = Get.put(ChatController());
  final SignInController signInController = Get.find<SignInController>();
  final databaseService = DatabaseService();

  RtcEngine? rtcEngine;
  int? remoteUid;
  bool? isVideoCall;
  bool? isMute;
  bool? isRemoteVideoMute;
  Timer? waitingTimer;
  Duration remainingWaitingTime = Duration(seconds: 300);
  Timer? countingTimer;
  Duration currentTime = Duration(seconds: 0);
  String callingTime = '00 : 00 : 00';

  @override
  void initState() {
    setState(() {
      isVideoCall = widget.channelName.contains('videoCall');
      isRemoteVideoMute = true;
      isMute = false;
    });
    InitForAgora();
    StartWaitingTimer();
    InitNotifyMessaging();
    super.initState();
  }

  @override
  void dispose() {
    if (remoteUid == null)
      databaseService.UpdateCallMessage(widget.callId, 'rejected');
    else {
      databaseService.UpdateCallMessage(
          widget.callId, 'accepted' + callingTime);
    }
    if (waitingTimer != null) waitingTimer!.cancel();
    if (countingTimer != null) countingTimer!.cancel();
    if (rtcEngine != null) {
      rtcEngine!.release();
      rtcEngine!.leaveChannel();
    }
    super.dispose();
  }

  Future<void> InitForAgora() async {
    await [Permission.microphone, Permission.camera].request();
    setState(() {
      rtcEngine = createAgoraRtcEngine();
    });
    await rtcEngine
        ?.initialize(const RtcEngineContext(appId: AppConsts.agoraAppId));

    await rtcEngine?.enableVideo();

    rtcEngine?.registerEventHandler(
      RtcEngineEventHandler(
        onRemoteVideoStateChanged:
            (connection, remoteUid, state, reason, elapsed) {
          setState(() {
            if (state == RemoteVideoState.remoteVideoStateStarting)
              isRemoteVideoMute = false;
            if (state == RemoteVideoState.remoteVideoStateStopped)
              isRemoteVideoMute = true;
          });
        },
        onUserJoined: (connection, _remoteUid, elapsed) {
          setState(() {
            remoteUid = _remoteUid;
            isRemoteVideoMute = isVideoCall == true ? false : true;
          });
          StartCountingTimer();
        },
        onLeaveChannel: (connection, stats) {
          Get.toNamed(AppRoutes.message);
        },
        onUserOffline: (connection, _remoteUid, reason) {
          if (remoteUid == null)
            databaseService.UpdateCallMessage(widget.callId, 'rejected');
          else {
            databaseService.UpdateCallMessage(
                widget.callId, 'accepted' + callingTime);
          }
          setState(() {
            remoteUid = null;
          });
          if (waitingTimer != null) waitingTimer!.cancel();
          if (countingTimer != null) countingTimer!.cancel();
          if (rtcEngine != null) {
            rtcEngine!.release();
            rtcEngine!.leaveChannel();
          }
          Get.toNamed(AppRoutes.message);
        },
      ),
    );

    await rtcEngine?.startPreview();

    ChannelMediaOptions options = const ChannelMediaOptions(
      clientRoleType: ClientRoleType.clientRoleBroadcaster,
      channelProfile: ChannelProfileType.channelProfileCommunication,
    );

    await rtcEngine?.joinChannel(
      token: widget.token,
      channelId: widget.channelName,
      uid: int.tryParse(signInController.user.phoneNumber)!,
      options: options,
    );
    if (isVideoCall == false) await rtcEngine?.enableLocalVideo(false);
  }

  void StartWaitingTimer() {
    waitingTimer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        if (remainingWaitingTime > Duration.zero) {
          setState(() {
            remainingWaitingTime -= Duration(seconds: 1);
          });
        } else {
          timer.cancel();
          if (countingTimer != null) countingTimer!.cancel();
          if (rtcEngine != null) {
            rtcEngine!.release();
            rtcEngine!.leaveChannel();
          }
        }
      },
    );
  }

  void StartCountingTimer() {
    countingTimer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        setState(() {
          currentTime += Duration(seconds: 1);
          callingTime = ConvertFromSecond(currentTime);
        });
      },
    );
  }

  String ConvertFromSecond(Duration timer) {
    int hour = 0;
    int minute = 0;
    int second = 0;
    int data = timer.inSeconds;
    String res = '';

    if (data >= 3600) {
      hour = (data / 3600).floor();
      data -= hour * 3600;
    }
    if (data >= 60) {
      minute = (data / 60).floor();
      data -= minute * 60;
    }

    second = data;

    if (hour < 10) {
      res += '0';
      if (hour < 1) {
        res += '0';
      } else {
        res += hour.toString();
      }
    } else {
      res += hour.toString();
    }
    res += ' : ';

    if (minute < 10) {
      res += '0';
      if (minute < 1) {
        res += '0';
      } else {
        res += minute.toString();
      }
    } else {
      res += minute.toString();
    }
    res += ' : ';

    if (second < 10) {
      res += '0';
      if (second < 1) {
        res += '0';
      } else {
        res += second.toString();
      }
    } else {
      res += second.toString();
    }

    return res;
  }

  void InitNotifyMessaging() {
    if (chatController.compatibleUserList.length <
        signInController.compatibleList.length) {
      for (int i = 0; i < signInController.matchListForChat.length; i++) {
        for (int j = 0; j < signInController.compatibleList.length; j++) {
          if (signInController.matchListForChat[i].user!.phoneNumber ==
                  signInController.compatibleList[j] &&
              chatController.compatibleUserList
                      .contains(signInController.matchListForChat[i]) ==
                  false) {
            chatController.compatibleUserList
                .add(signInController.matchListForChat[i]);
          }
        }
      }
    }
    if (signInController.notifySenderId != '') {
      for (int i = 0; i < chatController.compatibleUserList.length; i++) {
        if (chatController.compatibleUserList[i].user!.phoneNumber ==
            signInController.notifySenderId) {
          chatController.UpdateCurrIndex(i);
        }
      }
      signInController.notifySenderId = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('messages')
                .doc(widget.callId)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                String callState = snapshot.data!['content'];
                if (callState == 'rejected') {
                  if (waitingTimer != null) waitingTimer!.cancel();
                  if (countingTimer != null) countingTimer!.cancel();
                  if (rtcEngine != null) {
                    rtcEngine!.release();
                    rtcEngine!.leaveChannel();
                  }
                }
              }
              return Stack(
                children: [
                  //Remote user video
                  Center(
                    child: isRemoteVideoMute == true
                        ? Container(
                            decoration: BoxDecoration(
                              color: AppColors.thirdColor,
                            ),
                            child: Positioned.fill(
                              child: Align(
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 100.sp,
                                      backgroundImage: NetworkImage(
                                          chatController
                                              .compatibleUserList[chatController
                                                  .currIndex.value]
                                              .user!
                                              .images
                                              .first),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 20.h),
                                      child: Text(
                                        callingTime != '00 : 00 : 00'
                                            ? callingTime
                                            : 'Calling...',
                                        style: CustomTextStyle.messageStyle(
                                          AppColors.secondaryColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : AgoraVideoView(
                            controller: VideoViewController.remote(
                              rtcEngine: rtcEngine!,
                              canvas: VideoCanvas(uid: remoteUid),
                              connection:
                                  RtcConnection(channelId: widget.channelName),
                            ),
                          ),
                  ),
                  // Local user video
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            20.sp,
                          ),
                          color: AppColors.secondaryColor,
                        ),
                        width: 200.w,
                        height: 300.h,
                        child: isVideoCall == true
                            ? AgoraVideoView(
                                controller: VideoViewController(
                                  rtcEngine: rtcEngine!,
                                  canvas: VideoCanvas(
                                    uid: 0,
                                  ),
                                ),
                              )
                            : Container(
                                padding: EdgeInsets.symmetric(horizontal: 40.w),
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      signInController.user.images.first),
                                ),
                              ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 80.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                if (isVideoCall == true)
                                  await rtcEngine?.switchCamera();
                              },
                              child: Container(
                                padding: EdgeInsets.all(16.sp),
                                margin: EdgeInsets.only(right: 20.w),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.disabledBackground,
                                ),
                                child: Icon(
                                  Icons.flip_camera_ios_rounded,
                                  color: AppColors.white,
                                  size: 70.sp,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                await rtcEngine?.enableLocalAudio(isMute!);
                                setState(() {
                                  isMute = isMute == true ? false : true;
                                });
                              },
                              child: isMute == false
                                  ? Container(
                                      padding: EdgeInsets.all(16.sp),
                                      margin: EdgeInsets.only(right: 20.w),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.disabledBackground,
                                      ),
                                      child: Icon(
                                        Icons.mic_outlined,
                                        color: AppColors.white,
                                        size: 70.sp,
                                      ),
                                    )
                                  : Container(
                                      padding: EdgeInsets.all(16.sp),
                                      margin: EdgeInsets.only(right: 20.w),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.white,
                                      ),
                                      child: Icon(
                                        Icons.mic_off_sharp,
                                        color: AppColors.secondaryColor,
                                        size: 70.sp,
                                      ),
                                    ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (remoteUid == null)
                                  databaseService.UpdateCallMessage(
                                      widget.callId, 'rejected');
                                else {
                                  databaseService.UpdateCallMessage(
                                      widget.callId, 'accepted' + callingTime);
                                }
                                if (waitingTimer != null)
                                  waitingTimer!.cancel();
                                if (countingTimer != null)
                                  countingTimer!.cancel();
                                if (rtcEngine != null) {
                                  rtcEngine!.release();
                                  rtcEngine!.leaveChannel();
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.all(16.sp),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.red,
                                ),
                                child: Icon(
                                  Icons.call_end_rounded,
                                  color: Colors.white,
                                  size: 70.sp,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                setState(() {
                                  isVideoCall =
                                      isVideoCall == true ? false : true;
                                });
                                await rtcEngine?.enableLocalVideo(isVideoCall!);
                                if (isVideoCall == true) {
                                  ChannelMediaOptions options =
                                      const ChannelMediaOptions(
                                    clientRoleType:
                                        ClientRoleType.clientRoleBroadcaster,
                                    channelProfile: ChannelProfileType
                                        .channelProfileCommunication,
                                  );
                                  await rtcEngine
                                      ?.updateChannelMediaOptions(options);
                                }
                              },
                              child: isVideoCall == true
                                  ? Container(
                                      padding: EdgeInsets.all(16.sp),
                                      margin: EdgeInsets.only(left: 20.w),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.disabledBackground,
                                      ),
                                      child: Icon(
                                        Icons.videocam,
                                        color: AppColors.white,
                                        size: 70.sp,
                                      ),
                                    )
                                  : Container(
                                      padding: EdgeInsets.all(16.sp),
                                      margin: EdgeInsets.only(left: 20.w),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.white,
                                      ),
                                      child: Icon(
                                        Icons.videocam_off,
                                        color: AppColors.secondaryColor,
                                        size: 70.sp,
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
