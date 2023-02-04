import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

import 'GlobalVar.dart';
import 'detailPage.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      '/': (context) => const MyApp(),
      'detail': (context) => const DetailPage(),
    },
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final assetsAudioPlayer = AssetsAudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Music Player",
          style: TextStyle(
              fontWeight: FontWeight.w400, fontSize: 18, color: Colors.white),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: GlobalVar.song.length,
          itemBuilder: (context, i) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  Navigator.of(context)
                      .pushNamed('detail', arguments: GlobalVar.song[i]);
                  assetsAudioPlayer.playOrPause();
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 7, bottom: 7),
                child: Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: GlobalVar.song[i]['bgColor'],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green,
                            image: DecorationImage(
                                image: Image.asset(
                                  "${GlobalVar.song[i]['image']}",
                                  fit: BoxFit.contain,
                                ).image,
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${GlobalVar.song[i]['title']}",
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "${GlobalVar.song[i]['subtitle']}",
                              style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                      const Expanded(
                        flex: 1,
                        child: Icon(
                          Icons.play_arrow,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
            //   ListTile(
            //   onTap: () {
            //     setState(() {
            //       assetsAudioPlayer.playOrPause();
            //     });
            //   },
            //   leading: CircleAvatar(
            //     radius: 40,
            //     backgroundImage: AssetImage("${GlobalVar.song[i]['image']}"),
            //   ),
            //   title: Text("${GlobalVar.song[i]['title']}"),
            //   subtitle: Text("${GlobalVar.song[i]['subtitle']}"),
            //   trailing: const
            //   tileColor: GlobalVar.song[i]['bgColor'],
            // );
          }),
      backgroundColor: Colors.black,
    );
  }
}
