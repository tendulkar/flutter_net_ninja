import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangeNotifierExampleApp extends StatefulWidget {
  const ChangeNotifierExampleApp({super.key});

  @override
  State<ChangeNotifierExampleApp> createState() =>
      _ChangeNotifierExampleAppState();
}

class _ChangeNotifierExampleAppState extends State<ChangeNotifierExampleApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('ChangeNotifierProvider Example')),
        body: const ChangeNotifierProviderExample(),
      ),
    );
  }
}

class UserLogin extends ChangeNotifier {
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;
  void login() {
    _isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }
}

// class ChangeNotifierProviderExample extends StatelessWidget {
//   const ChangeNotifierProviderExample({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//         create: (ctx) => UserLogin(),
//         builder: (ctx, _) => Column(
//               children: [
//                 Text('Login Status: ${context.watch<UserLogin>().isLoggedIn}'),
//                 ElevatedButton(
//                   onPressed: () {
//                     context.read<UserLogin>().login();
//                   },
//                   child: const Text('Login'),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     context.read<UserLogin>().logout();
//                   },
//                   child: const Text('Logout'),
//                 ),
//               ],
//             ));
//   }
// }

class ChangeNotifierProviderExample extends StatelessWidget {
  const ChangeNotifierProviderExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => UserLogin(),
      child: const Center(child: ChangeNotifierColumn()),
    );
  }
}

class ChangeNotifierColumn extends StatelessWidget {
  const ChangeNotifierColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Login status: ${context.watch<UserLogin>().isLoggedIn}",
            style: const TextStyle(fontSize: 20)),
        ElevatedButton(
          onPressed: () => context.read<UserLogin>().login(),
          child: const Text("Login"),
        ),
        ElevatedButton(
          onPressed: () => context.read<UserLogin>().logout(),
          child: const Text("Logout"),
        ),
      ],
    );
  }
}
