import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttermangsir/sample_dispose/todo_provider.dart';


class TodoPage extends ConsumerWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoState = ref.watch(getTodosProvider);
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: RefreshIndicator(
            onRefresh: ()async{
              await Future.delayed(Duration(seconds: 1));
              ref.invalidate(getTodosProvider);
            },
            child: todoState.when(
                data: (data){
                  return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) => Text(data[index].desc));
                },
                error: (err, st) => Text('$err'),
                loading: () => const Center(child: CircularProgressIndicator(),),
            ),
          ),
        ),
      ),
    );
  }
}