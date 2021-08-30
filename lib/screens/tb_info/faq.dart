import 'package:flutter/material.dart';
import 'package:tb_e_health/screens/chatbot/live_chat.dart';
import 'package:tb_e_health/screens/shared/common_app_bar.dart';
import 'package:tb_e_health/screens/shared/info_card.dart';

class Faq extends StatelessWidget {
  final List<dynamic> items;

  Faq({
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: 'FAQ'),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () =>
      //       Navigator.push(context, MaterialPageRoute(builder: (context) {
      //     return LiveChat();
      //   })),
      //   child: Icon(Icons.live_help_outlined),
      //   backgroundColor: Colors.black,
      // ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25.0, 8.0, 25.0, 15.0),
        child: Column(
          children: [
            // Display the data loaded from sample.json
            items.length > 0
                ? Expanded(
                    child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[100],
                              border: Border.all(color: Colors.grey)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InfoCardWidget(
                              primaryText: '${index+1}) '+items[index].title,
                              secondaryText: items[index].text,
                            ),
                            // child: Text(
                            //   items[index].title + '\n' + items[index].text,
                            //   style: TextStyle(fontSize: 18),
                            // ),
                          ),
                        );
                      },
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
