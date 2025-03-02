import 'package:flutter/material.dart';
import 'package:fluttermangsir/routes/route_enum.dart';
import 'package:go_router/go_router.dart';



class Sample extends StatelessWidget {
  const Sample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Text('Sample'),
            ElevatedButton(onPressed: (){
              context.pushNamed(AppRoute.todo.name);
            }, child: Text('Todo Page'))
          ],
        ),
      ),
    );
  }
}
