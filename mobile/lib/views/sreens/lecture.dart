// ignore_for_file: non_constant_identifier_names

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:mobile/commons/constances.dart';
import 'package:mobile/commons/style.dart';
import 'package:mobile/models/lecon_model.dart';
import 'package:mobile/models/module.dart';

class LectureScreen extends StatefulWidget {
  final Lecon lecon;
  final Module module;
  const LectureScreen({super.key, required this.lecon, required this.module});

  @override
  State<LectureScreen> createState() => _LectureScreenState();
}

class _LectureScreenState extends State<LectureScreen> {
  bool isPlaying = false;
  bool viewRest = false;
  double value = 0;
  final player = AudioPlayer();
  Duration? duration;

  void initPlayer() async {
    await player
        .setSource(UrlSource("$base_get_url${widget.lecon.lecon_voice}"));
    // await player.setSourceUrl('$base_get_url${widget.lecon.lecon_voice}');
    duration = await player.getDuration();
    player.onPositionChanged.listen(
      (Duration d) async {
        setState(() {
          value = d.inSeconds.toDouble();
        });
        if (d.inSeconds == duration!.inSeconds) {
          await initialisePlayer();
        }
      },
    );
    setState(() {});
  }

  initialisePlayer() async {
    isPlaying = false;
    await player.seek(Duration.zero);
    await player.pause();
    value = 0.0;
    setState(() {});
  }

  plyaMusic() async {
    setState(() => isPlaying = true);
    await player.resume();
  }

  pauseMusic() async {
    setState(() => isPlaying = false);
    await player.pause();
  }

//init the player
  @override
  void initState() {
    initPlayer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.module.module_name),
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            constraints: const BoxConstraints.expand(),
            height: 300.0,
            width: 300.0,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/speaker3.gif"),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaY: 28, sigmaX: 28),
              child: Container(
                color: Colors.black.withOpacity(0.6),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: Image.asset(
                  "assets/images8.png",
                  width: 250.0,
                ),
              ),
              spacerheight(10),
              Text(
                widget.lecon.lecon_title,
                style: const TextStyle(
                    color: Colors.white, fontSize: 36, letterSpacing: 6),
              ),
              //Setting the seekbar
              spacerheight(50),
              duration == null
                  ? const SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${(value / 60).floor()}: ${(value % 60).floor()}",
                            style: TextStyle(color: Colors.white),
                          ),
                          Expanded(
                            child: Slider.adaptive(
                              onChangeEnd: (new_value) async {
                                await player
                                    .seek(Duration(seconds: new_value.toInt()));
                                setState(() {
                                  value = new_value;
                                });
                              },
                              min: 0.0,
                              value: value,
                              max: duration!.inSeconds.toDouble(),
                              onChanged: (value) {},
                              activeColor: Colors.white,
                            ),
                          ),
                          InkWell(
                            onTap: () => setState(() => viewRest = !viewRest),
                            child:
                                // viewRest
                                //     ? Text(
                                //         "${duration!.inMinutes - (value / 60).floor()} : ${duration!.inSeconds % 60 - (value % 60).floor()}",
                                //         style: const TextStyle(color: Colors.white),
                                //       )
                                Text(
                              "${duration!.inMinutes} : ${duration!.inSeconds % 60}",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
              //setting the player controller
              spacerheight(40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60.0),
                      color: Colors.black87,
                      border: Border.all(color: Colors.white38),
                    ),
                    width: 50.0,
                    height: 50.0,
                    child: InkWell(
                      onTapDown: (details) {
                        player.setPlaybackRate(0.5);
                      },
                      onTapUp: (details) {
                        player.setPlaybackRate(1);
                      },
                      child: const Center(
                        child: Icon(
                          Icons.fast_rewind_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60.0),
                      color: Colors.black87,
                      border: Border.all(color: Colors.pink),
                    ),
                    width: 60.0,
                    height: 60.0,
                    child: InkWell(
                      onTap: () async {
                        if (!isPlaying) {
                          await plyaMusic();
                        } else {
                          await pauseMusic();
                        }
                      },
                      child: Center(
                        child: Icon(
                          isPlaying ? Icons.pause : Icons.play_arrow,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60.0),
                      color: Colors.black87,
                      border: Border.all(color: Colors.white38),
                    ),
                    width: 50.0,
                    height: 50.0,
                    child: InkWell(
                      onTapDown: (details) {
                        player.setPlaybackRate(2);
                      },
                      onTapUp: (details) {
                        player.setPlaybackRate(1);
                      },
                      child: const Center(
                        child: Icon(
                          Icons.fast_forward_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
