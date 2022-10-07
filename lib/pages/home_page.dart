import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:typed_data';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final background_color = Colors.grey[200];
  final skin_color = Color(0xFFF2C288);

  // 주호민 재즈 음악 File Path
  String joohomin_jazz = 'assets/audio/joohomin_jazz.mp3';
  String joohomin_jazz_remix = 'assets/audio/joohomin_jazz_remix.mp3';

  // Audio Player 인스턴스 생성
  final audio_player = AudioPlayer();

  // Initiate the audio into the Player
  // void initPlayer(){
  //   await audio_player.setSource(AssetSource(path))
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      // extendBodyBehindAppBar: true,
      backgroundColor: Colors.black87,
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(110),
      //   child: Container(
      //     margin: EdgeInsets.fromLTRB(25, 40, 25, 0),
      //     height: 70,
      //     color: Colors.white60,
      //   ),
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      child: Image.asset(
                        'assets/images/LP.png',
                        width: 310,
                        height: 310,
                      ),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                color: skin_color.withOpacity(.7),
                                spreadRadius: 1,
                                blurRadius: 15)
                          ]),
                    ),
                    Image.asset(
                      'assets/images/joohomin_profile.png',
                      width: 120,
                      height: 120,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  '재즈는 말이죠 Remix',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.5),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text('주호민 (Joo Ho-Min)',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white60,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.5)),
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  constraints: BoxConstraints(maxWidth: 380),
                  child: Slider(
                    value: 10,
                    onChanged: (v) {},
                    max: 100,
                    min: 0,
                    activeColor: Colors.red,
                    inactiveColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      icon: FaIcon(FontAwesomeIcons.backward,
                          color: Colors.white, size: 30),
                    ),
                    IconButton(
                      padding: EdgeInsets.symmetric(horizontal: 65),
                      onPressed: () {},
                      icon: FaIcon(FontAwesomeIcons.play,
                          color: Colors.white, size: 50),
                    ),
                    IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        icon: FaIcon(FontAwesomeIcons.forward,
                            color: Colors.white, size: 30))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
