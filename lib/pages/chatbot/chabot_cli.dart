import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';

import 'package:dialogflow_flutter/language.dart';
import 'package:dialogflow_flutter/googleAuth.dart';
import 'package:dialogflow_flutter/dialogflowFlutter.dart';

import 'package:farmacia/widgets/appbar_cli.dart';
import 'package:farmacia/utilitarios/logger.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  ChatBotScreenState createState() => ChatBotScreenState();
}

class ChatBotScreenState extends State<ChatBotScreen> {
  final messageInsert = TextEditingController();
  List<Map> messsages = <Map>[];
  void response(query) async {
    AuthGoogle authGoogle = await AuthGoogle(
      fileJson: "assets/dialogflowfarmacia-d453f24da4ec.json",
    ).build();

    DialogFlow dialogflow = DialogFlow(
      authGoogle: authGoogle,
      language: Language.spanishLatinAmerica,
    );

    AIResponse aiResponse = await dialogflow.detectIntent(query);

    setState(() {
      messsages.insert(0, {
        "data": 0,
        "message": aiResponse.getListMessage()?[0]["text"]["text"][0].toString()
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCli(title: "Carro"),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              reverse: true,
              itemCount: messsages.length,
              itemBuilder: (context, index) => chat(
                messsages[index]["message"].toString(),
                messsages[index]["data"],
              ),
            ),
          ),
          const Divider(
            height: 6.0,
          ),
          Container(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 20),
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: <Widget>[
                Flexible(
                  child: TextField(
                    controller: messageInsert,
                    decoration: const InputDecoration.collapsed(
                      hintText: "Send your message",
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: IconButton(
                      icon: const Icon(
                        Icons.send,
                        size: 30.0,
                      ),
                      onPressed: () {
                        if (messageInsert.text.isEmpty) {
                          logger.e("empty message");
                        } else {
                          setState(() {
                            messsages.insert(
                                0, {"data": 1, "message": messageInsert.text});
                          });
                          response(messageInsert.text);
                          messageInsert.clear();
                        }
                      }),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 15.0,
          )
        ],
      ),
    );
  }

  Widget chat(String message, int data) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Bubble(
          radius: const Radius.circular(15.0),
          color: data == 0 ? Colors.blue : Colors.orangeAccent,
          elevation: 0.0,
          alignment: data == 0 ? Alignment.topLeft : Alignment.topRight,
          nip: data == 0 ? BubbleNip.leftBottom : BubbleNip.rightTop,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: AssetImage(data == 0
                      ? "assets/img/bot.png"
                      : "assets/img/avatar.png"),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Flexible(
                    child: Text(
                  message,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ))
              ],
            ),
          )),
    );
  }
}
