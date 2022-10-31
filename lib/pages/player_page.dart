import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PlayerPage extends StatefulWidget {
  const PlayerPage({Key? key}) : super(key: key);

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage>
    with SingleTickerProviderStateMixin {
  final skin_color = Color(0xFFF2C288);

  // play_pause animation controller
  late AnimationController _animationController;
  bool _isAudioPlaying = false;

  // Audio Player
  late AssetsAudioPlayer assetsAudioPlayer;
  final audios = [
    Audio('assets/audio/joohomin_jazz.mp3',
        metas: Metas(
            id: 'Jazz',
            title: '재즈란 말이죠',
            artist: '주호민 (Joo-Ho-Min)',
            album: '주펄 재즈 페스티벌',
            image: MetasImage.asset('assets/images/joohomin_profile.png'))),
    Audio('assets/audio/joohomin_jazz_remix.mp3',
        metas: Metas(
            id: 'Jazz',
            title: '재즈란 말이죠 Remix',
            artist: '주호민 (Joo-Ho-Min) / Sofa4844',
            album: '재즈가 아니게 되어버린 주펄의 스캣',
            image: MetasImage.asset(
                'assets/images/joohomin_profile_sunglasses.png'))),
  ];

  @override
  void initState() {
    super.initState();
    assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    openAudio();
  }

  // AnimatedIcon
  void _playpauseIconChange() {
    setState(() {
      _isAudioPlaying = !_isAudioPlaying;
      if (_isAudioPlaying) {
        _animationController.forward();
        playAudio();
      } else {
        _animationController.reverse();
        pauseAudio();
      }
    });
  }

  void openAudio() async {
    await assetsAudioPlayer.open(Playlist(audios: audios, startIndex: 0),
        autoStart: false,
        showNotification: true,
        loopMode: LoopMode.playlist //loop the full playlist
    );
  }

  void playAudio() async {
    await assetsAudioPlayer.play();
  }

  void pauseAudio() async {
    final Duration currentPosition = await assetsAudioPlayer.currentPosition.value;
    await assetsAudioPlayer.pause();
  }

  void stopAudio() async {
    await assetsAudioPlayer.stop();
  }

  void nextAudio() async {
    await assetsAudioPlayer.next();
  }

  void prevAudio() async {
    await assetsAudioPlayer.previous();
  }

  void seekAudio(int seconds) {
    Duration duration = Duration(seconds: seconds);
    assetsAudioPlayer.seekBy(duration);
  }

  void changeVolume(double value) {
    assetsAudioPlayer.setVolume(value);
  }

  @override
  void dispose() {
    super.dispose();
    assetsAudioPlayer.dispose();
  }

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
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
            child: StreamBuilder(
                stream: assetsAudioPlayer.current,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    final playing = snapshot.data!;
                    final myAudio = find(audios, playing.audio.assetAudioPath);
                    return Column(
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
                            myAudio.metas.title.toString().contains('Remix')
                                ? Image.asset(
                              myAudio.metas.image!.path,
                              width: 200,
                              height: 200,
                            )
                                : Image.asset(
                              myAudio.metas.image!.path,
                              width: 120,
                              height: 120,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Text(
                          myAudio.metas.title!.toString(),
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.5),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(myAudio.metas.artist!.toString(),
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white60,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.5)),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        playerSlider(),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    );
                  }
                  return SizedBox.shrink();
                }),
          ),
        ),
      ),
      bottomNavigationBar: playBar(),
    );
  }

  PlayerBuilder playerSlider() {
    return assetsAudioPlayer.builderRealtimePlayingInfos(
        builder: (context, RealtimePlayingInfos? infos) {
          if (infos == null) {
            return SizedBox();
          } else {
            String currentMinute =
            infos.currentPosition.toString().split('.')[0].split(':')[1];
            String currentSecond =
            infos.currentPosition.toString().split('.')[0].split(':')[2];
            String totalMinute =
            infos.duration.toString().split('.')[0].split(':')[1];
            String totalSecond =
            infos.duration.toString().split('.')[0].split(':')[2];
            return Container(
              constraints: BoxConstraints(maxWidth: 380),
              child: Column(
                children: [
                  Slider(
                    value: infos.currentPosition.inSeconds.toDouble(),
                    onChanged: (double value) {
                      setState(() {
                        Duration newDuration = Duration(seconds: value.toInt());
                        assetsAudioPlayer.seek(newDuration);
                        value = value;
                      });
                    },
                    max: infos.duration.inSeconds.toDouble(),
                    min: 0,
                    activeColor: Colors.red,
                    inactiveColor: Colors.white,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ''
                        '${currentMinute}:${currentSecond}',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text('${totalMinute}:${totalSecond}',
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ],
              ),
            );
          }
        });
  }

  Widget playBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: prevAudio,
          onDoubleTap: () {
            seekAudio(-2);
          },
          child:
          FaIcon(FontAwesomeIcons.backward, color: Colors.white, size: 25),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60),
          child: GestureDetector(
            onTap: _playpauseIconChange,
            child: AnimatedIcon(
                icon: AnimatedIcons.play_pause,
                size: 50,
                color: Colors.white,
                progress: _animationController),
          ),
        ),
        GestureDetector(
          onTap: nextAudio,
          onDoubleTap: () {
            seekAudio(2);
          },
          child:
          FaIcon(FontAwesomeIcons.forward, color: Colors.white, size: 25),
        ),
      ],
    );
  }
}
