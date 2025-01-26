import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_todo_tutorial/model/cat_fact.dart';

final dioProvider = Provider<Dio>((ref) => Dio(BaseOptions(baseUrl: 'https://catfact.ninja/')));
final catFactsProvider = FutureProvider<List<CatFact>>((ref) async {
  final dio = ref.watch(dioProvider);
  final result = await dio.get('facts');
  final List<Map<String, dynamic>> data = List.from(result.data['data']);
  final List<CatFact> catFactList = data.map((map) => CatFact.fromMap(map)).toList();
  return catFactList;
});

class UsingFutureProvider extends ConsumerWidget {
  const UsingFutureProvider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catFacts = ref.watch(catFactsProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Future Provider',
          style: TextStyle(color: Colors.deepPurple),
        ),
      ),
      body: SafeArea(
        child: catFacts.when(
          data: (catFacts) {
            return ListView.builder(
              itemCount: catFacts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(catFacts[index].fact),
                );
              },
            );
          },
          error: ((error, stackTrace) {
            return Center(
              child: Text('Error: $error'),
            );
          }),
          loading: (() {
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
        ),
      ),
    );
  }
}
