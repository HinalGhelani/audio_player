import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final assetsAudioPlayer = AssetsAudioPlayer();

  bool play = true;
  bool start = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    assetsAudioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map s = ModalRoute.of(context)!.settings.arguments as Map;

    assetsAudioPlayer.open(Audio(s['path']),
        autoStart: true, showNotification: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Now Playing",
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            child: Image(
              image: Image.asset(
                "${s['image']}",
              ).image,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            height: 700,
            width: 360,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.8),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 90,
                ),
                Container(
                  height: 250,
                  width: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: Image.asset(
                        "${s['image']}",
                      ).image,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "${s['title']}",
                  style: const TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "${s['subtitle']}",
                  style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade300,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 35,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          assetsAudioPlayer.stop();
                        });
                      },
                      icon: const Icon(
                        Icons.stop,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 15),
                    // IconButton(
                    //   onPressed: () async {
                    //     play = !play;
                    //     if (play == true) {
                    //       await assetsAudioPlayer.play();
                    //     } else {
                    //       await assetsAudioPlayer.pause();
                    //     }
                    //   },
                    //   icon: (play == true)
                    //       ? const Icon(
                    //     Icons.play_arrow,
                    //     size: 30,
                    //     color: Colors.white,
                    //   )
                    //       : const Icon(
                    //     Icons.pause,
                    //     size: 30,
                    //     color: Colors.white,
                    //   ),
                    // ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            play = !play;
                            assetsAudioPlayer.playOrPause();
                          });
                        },
                        icon: (play == true)
                            ? const Icon(
                                Icons.pause,
                                color: Colors.white,
                              )
                            : const Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                              )),
                    const SizedBox(width: 15),
                    IconButton(
                        onPressed: () {
                          setState(() {});
                        },
                        icon: const Icon(
                          Icons.headphones,
                          size: 30,
                          color: Colors.white,
                        )),
                  ],
                ),
                StreamBuilder(
                    stream: assetsAudioPlayer.currentPosition,
                    builder: (context, snapshot) {
                      return Column(
                        children: [
                          Slider(
                            activeColor: Colors.green,
                            inactiveColor: Colors.white,
                            min: 0,
                            max: ((assetsAudioPlayer.current.value != null)
                                ? assetsAudioPlayer
                                        .current.value?.audio.duration.inSeconds
                                        .toDouble() ??
                                    0
                                : 0),
                            value: snapshot.data!.inSeconds.toDouble(),
                            onChanged: (val) {
                              assetsAudioPlayer
                                  .seek(Duration(seconds: val.toInt()));
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 23, right: 23),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  snapshot.data.toString().split(".")[0],
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400),
                                ),
                                (assetsAudioPlayer.current.value != null)
                                    ? Text(
                                        "${assetsAudioPlayer.current.value?.audio.duration.toString().split(".")[0]}",
                                        style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400),
                                      )
                                    : const Text(
                                        "0:00:00",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400),
                                      )
                              ],
                            ),
                          )
                        ],
                      );
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
