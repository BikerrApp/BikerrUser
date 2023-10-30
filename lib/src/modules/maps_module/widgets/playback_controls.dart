import 'package:bikerr_partner_app/src/extensions/space_ext.dart';
import 'package:bikerr_partner_app/src/modules/maps_module/controllers/playback_controller.dart';
import 'package:bikerr_partner_app/src/utils/strings/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PlaybackControlsComp extends StatelessWidget {
  final PlaybackController pc;
  const PlaybackControlsComp({required this.pc, super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          color: whiteColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Container(
                      padding: EdgeInsets.only(left: 10.w),
                      child: GestureDetector(
                        onTap: pc.playPausePressed,
                        child: Icon(
                          pc.isPlayingIcon.value,
                          color: blackColor,
                          size: 35.0,
                        ),
                      )),
                  PopupMenuButton<Choice>(
                    onSelected: pc.select,
                    icon: Icon(
                      Icons.timer,
                      size: 30,
                      color: blackColor,
                    ),
                    itemBuilder: (BuildContext context) {
                      return pc.choices.map((Choice choice) {
                        return PopupMenuItem<Choice>(
                          value: choice,
                          child: Text(choice.title),
                        );
                      }).toList();
                    },
                  ),
                  Expanded(
                    child: Slider(
                      value: pc.sliderValue.value.toDouble(),
                      onChanged: (newSliderValue) {
                        pc.sliderValue.value = newSliderValue.toInt();
                        if (!pc.timerPlayBack.isActive) {
                          // pc.playUsingSlider(newSliderValue.toInt());
                        }
                      },
                      min: 0,
                      max: pc.sliderValueMax.value.toDouble(),
                    ),
                  ),
                ],
              ),
              15.height,
            ],
          ),
        ),
      );
    });
  }
}
