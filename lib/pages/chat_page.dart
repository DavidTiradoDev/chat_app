import 'dart:io';

import 'package:chat_app/common/widgets/widgets.dart';
import 'package:chat_app/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  bool isWriting = false;

  List<BubbleChat> _messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        title: Column(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue[100],
              maxRadius: 15,
              child: Text('NE', style: TextStyle(fontSize: 12)),
            ),
            SizedBox(height: 3),
            Text('Nombre Test', style: TextStyle(fontSize: 15)),
          ],
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) => _messages[index],
            ),
          ),
          Divider(height: 1),
          Container(color: AppColors.whiteColor, child: _inputChat()),
        ],
      ),
    );
  }

  Widget _inputChat() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmit,
                onChanged: (String text) {
                  setState(() {
                    text.trim().isNotEmpty
                        ? isWriting = true
                        : isWriting = false;
                  });
                },
                decoration: InputDecoration.collapsed(
                  hintText: 'Enviar mensaje',
                ),
                focusNode: _focusNode,
              ),
            ),

            // Boton de enviar
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              child:
                  Platform.isIOS
                      ? Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: CupertinoButton(
                          color: isWriting ? Colors.blue[300] : Colors.white,
                          onPressed:
                              isWriting
                                  ? () => _handleSubmit(_textController.text)
                                  : null,
                          child: Text(
                            'Enviar',
                            style: TextStyle(
                              color: isWriting ? Colors.white : Colors.grey,
                            ),
                          ),
                        ),
                      )
                      : Container(
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        child: IconButton(
                          highlightColor: Colors.transparent,
                          onPressed:
                              isWriting
                                  ? () => _handleSubmit(_textController.text)
                                  : null,
                          icon: Icon(
                            Icons.send,
                            color: isWriting ? Colors.blue[300] : Colors.grey,
                          ),
                        ),
                      ),
            ),
          ],
        ),
      ),
    );
  }

  _handleSubmit(String text) {
    if (text.isEmpty) return;
    debugPrint(text);
    _textController.clear();
    final newMessage = BubbleChat(
      text: text,
      uid: '123',
      animationController: AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 500),
      ),
    );
    _messages.insert(0, newMessage);
    newMessage.animationController.forward();
    setState(() {
      isWriting = false;
    });
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    // TODO: Off del socket

    for (BubbleChat message in _messages) {
      message.animationController.dispose();
    }

    super.dispose();
  }
}
