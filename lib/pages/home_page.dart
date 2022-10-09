import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final background_color = Colors.grey[200];
  final skin_color = Color(0xFFF2C288);

  // Audio Player
  AudioPlayer audioPlayer = AudioPlayer();
  AudioCache audioCache =
      AudioCache(prefix: 'assets/audio/joohomin_jazz_remix.mp3');

  @override
  void initState() {
    super.initState();
    audioPlayer;
    audioCache;
  }

  void pauseAudio() async {
    await audioPlayer.pause();
  }

  void stopAudio() async {
    await audioPlayer.stop();
  }

  void resumeAudio() async {
    await audioPlayer.resume();
  }

  void playAudio() async {
    await audioPlayer
        .setSource(AssetSource('assets/audio/joohomin_jazz_remix.mp3'));
    // audioPlayer.play();
  }

  void changeVolume(double value) {
    audioPlayer.setVolume(value);
  }

  @override
  void dispose(){
    super.dispose();
    audioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    late String _total_duration;
    late String _current_postion;
    audioPlayer.getDuration().then((value){
      setState(() {
        _total_duration = value.toString();
      });
    });
    audioPlayer.getCurrentPosition().then((value){
      setState(() {
        _current_postion = value.toString();
      });
    });
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
      appBar: PreferredSize(
        preferredSize: Size.zero,
        child: Container(
            alignment: Alignment.topLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    padding: EdgeInsets.fromLTRB(30, 45, 0, 0),
                    onPressed: () {},
                    icon: Icon(
                      FontAwesomeIcons.chevronDown,
                      color: Colors.white,
                    )),
                IconButton(
                    padding: EdgeInsets.fromLTRB(0, 45, 30, 0),
                    onPressed: () {},
                    icon: Icon(
                      FontAwesomeIcons.volumeLow,
                      color: Colors.white,
                    ))
              ],
            )),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 70,
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
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      icon: FaIcon(FontAwesomeIcons.backward,
                          color: Colors.white, size: 25),
                    ),
                    IconButton(
                      padding: EdgeInsets.symmetric(horizontal: 65),
                      onPressed: playAudio,
                      icon: FaIcon(FontAwesomeIcons.play,
                          color: Colors.white, size: 40),
                    ),
                    IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        icon: FaIcon(FontAwesomeIcons.forward,
                            color: Colors.white, size: 25))
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
