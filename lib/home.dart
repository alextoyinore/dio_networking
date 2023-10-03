import 'package:dio_networking/dioclient.dart';
import 'package:dio_networking/userinfo/notifier/userinfo_notifier.dart';
import 'package:dio_networking/userinfo/userinfo.dart';
import 'package:dio_networking/userinfo/userinfo_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final DioClient _client = DioClient();

  late UserInfoController _controller;

  @override
  void initState() {
    // TODO: implement initState
    _controller = UserInfoController(ref: ref);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Watch Providers
    ref.watch(userInfoNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dio Networking'),
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                onChanged: (value) {
                  ref
                      .read(userInfoNotifierProvider.notifier)
                      .onNameChange(value);
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter your name',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                onChanged: (value) {
                  ref
                      .read(userInfoNotifierProvider.notifier)
                      .onJobChange(value);
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter your job',
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.deepOrange),
                  foregroundColor: MaterialStateProperty.resolveWith(
                    (states) => Colors.white,
                  ),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5))),
                  fixedSize: MaterialStateProperty.all(const Size(370, 55)),
                  elevation: MaterialStateProperty.all(0),
                ),
                onPressed: () async {
                  // Perform GET request to the endpoint "/users/2"
                  var user = await _client.getUser(id: '2');
                  var userinfo = await _client.createUser(
                      userInfo: UserInfo(
                          name: ref
                              .read(userInfoNotifierProvider.notifier)
                              .state
                              .name,
                          job: ref
                              .read(userInfoNotifierProvider.notifier)
                              .state
                              .job));
                  // ignore: use_build_context_synchronously
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Container(
                          height: MediaQuery.of(context).size.height * .2,
                          child: Column(
                            children: [
                              Image.network(user!.data.avatar),
                              Text(
                                  'First name: ${user.data.firstName}\nLast name: ${user.data.lastName}'),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: const Text(
                  'Get User',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
