import 'package:flutter/material.dart';
import 'package:tb_e_health/screens/shared/common_app_bar.dart';
import 'package:tb_e_health/screens/shared/info_card.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Faq extends StatelessWidget {
  final List<dynamic> items;

  Faq({
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId:
          (YoutubePlayer.convertUrlToId("https://youtu.be/Vy5yEEVHovQ"))
              .toString(),
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: true,
      ),
    );
    return Scaffold(
      appBar: CommonAppBar(title: 'FAQ'),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Container(
              color: Colors.black,
              child: Column(
                children: [
                  TabBar(
                    tabs: [
                      Tab(
                        text: 'General FAQs',
                      ),
                      Tab(
                        text: 'Video Guides',
                      ),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // order
                  items.length > 0
                      ? Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount: items.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin:
                                        EdgeInsets.fromLTRB(8.0, 5.0, 8.0, 5.0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey[100],
                                        border: Border.all(color: Colors.grey)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InfoCardWidget(
                                        primaryText: '${index + 1}) ' +
                                            items[index].title,
                                        secondaryText: items[index].text,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 30.0),
                          ],
                        )
                      : Container(),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'How do I submit a video?',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      YoutubePlayerBuilder(
                          player: YoutubePlayer(
                            controller: _controller,
                          ),
                          builder: (context, player) {
                            return Column(
                              children: [
                                // some widgets
                                player,
                                //some other widgets
                              ],
                            );
                          }),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
