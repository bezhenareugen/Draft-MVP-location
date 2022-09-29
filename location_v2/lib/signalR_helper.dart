import 'package:flutter/material.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';

class SignalRHelper {
  //final url = 'https://localhost:7295/chat';
  final url = 'http://api.app.roofest.online/chat';
  late HubConnection hubConnection;
  String textMessage = '';

  void connect() {
    hubConnection = HubConnectionBuilder().withUrl(url).build();
    hubConnection.on('ReceiveMessage', receiveMessageHandler);
    hubConnection.start();
    print("Hub SignalR was invoked");
  }

  void sendMessage(String name) {
    hubConnection.invoke('SendMessage', args: [name]);
    // messageList.add(Message(
    //     name: name,
    //     message: message,
    //     isMine: true));
    // textMessage = '';
  }

  void disconnect() {
    hubConnection.stop();
  }

  receiveMessageHandler(args) {
    print(args);
  }
}
