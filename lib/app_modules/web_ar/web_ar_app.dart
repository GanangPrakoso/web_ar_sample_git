import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'bloc/web_ar_bloc.dart';
import 'screen/web_ar_screen.dart';

class WebArApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<WebArBloc>(
        create: (_) => WebArBloc(),
        dispose: (_, WebArBloc bloc) => bloc.dispose(),
        // child: Scaffold(body: WebArScreen1()),
        child: WebArScreen());
  }
}
