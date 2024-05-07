import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zawiid/Authentication/SignIn.dart';
import 'package:zawiid/Color&Icons/color.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
            onTap: (){
              context.push(context.namedLocation('SignIn'));
              },
            child: Text('asdasd',style: TextStyle(color: tdBlack),)),
      ),
    );
  }
}
