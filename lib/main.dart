import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_in_flutter_with_api/model_classes/post_model_class.dart';
import 'package:riverpod_in_flutter_with_api/providers/globally_providers.dart';
import 'package:riverpod_in_flutter_with_api/providers/state_provider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postState = ref.watch(postApiProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('App bar'),
      ),
      body: Builder(
        builder: (context) {
          if (postState is PostInitialState) {
            return const InitialStateWidget();
          } else if (postState is PostLoadingState) {
            return const LoadingStateWidget();
          } else if (postState is PostLoadedState) {
            return LoadedStateWidget(listOfPost: postState.list);
          } else {
            return ErroeStateWidget(
                errorMessage: (postState as PostErrorState).message);
          }
        },
      ),
    );
  }
}

class InitialStateWidget extends ConsumerWidget {
  const InitialStateWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text('Click the given button to load data'),
          TextButton(
            onPressed: () {
              ref.read(postApiProvider.notifier).fetchDataS();
            },
            child: const Text('Click'),
          ),
        ],
      ),
    );
  }
}

class LoadingStateWidget extends ConsumerWidget {
  const LoadingStateWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.amber,
      ),
    );
  }
}

class LoadedStateWidget extends ConsumerWidget {
  const LoadedStateWidget({super.key, required this.listOfPost});
  final List<PostModelClass> listOfPost;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemCount: listOfPost.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: Text(
              listOfPost[index].id.toString(),
            ),
            subtitle: const Text('Text'),
            title: Text(
              listOfPost[index].body.toString(),
            ),
            trailing: Text(
              listOfPost[index].title.toString(),
            ),
          ),
        );
      },
    );
  }
}

class ErroeStateWidget extends ConsumerWidget {
  const ErroeStateWidget({super.key, required this.errorMessage});
  final String errorMessage;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Container(
        color: Colors.red,
        child: Text(errorMessage),
      ),
    );
  }
}
