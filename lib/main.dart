import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'cubit/click_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

List<String> text = [];
int count = 0;
int newCount = 0;
void main() {
  runApp(MyApp());
}

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/themeName.txt');
}

Future<File> writeTheme(String theme, String count) async {
  final file = await _localFile;

  // Write the file
  return file.writeAsString('$theme$count');
}

Future<String> readTheme() async {
  final file = await _localFile;

  // Read the file
  String contents = await file.readAsString();

  return contents;
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SwitchCubit>(
      create: (context) => SwitchCubit(),
      child: BlocBuilder<SwitchCubit, SwitchState>(
        builder: (context, state) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: state.theme,
              home: BlocProvider(
                create: (context) => ClickCubit(),
                child: const MyHomePage(),
              ));
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                String theme = await readTheme();
                if (theme.contains("Black")) {
                  text.add("${theme.substring(5)} - ${theme.substring(0, 5)}");
                  newCount = int.parse(theme.substring(5));
                  context.read<ClickCubit>().onClick(0);
                  context.read<SwitchCubit>().onSwitch(false, true);
                } else if (theme.contains("White")) {
                  text.add("${theme.substring(5)} - ${theme.substring(0, 5)}");
                  count = int.parse(theme.substring(5));
                  context.read<ClickCubit>().onClick(0);
                  context.read<SwitchCubit>().onSwitch(true, true);
                }
              },
              child: const Icon(Icons.save),
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              'Текущее число:',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            BlocBuilder<ClickCubit, ClickState>(
              builder: (context, state) {
                if (state is ClickError) {
                  return Text(
                    state.message,
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                }
                if (state is Click) {
                  if (text.isNotEmpty) {
                    if (count != state.sum) {
                      text.add("${state.sum} - ${state.themeName}");
                    }
                  } else {
                    text.add("${state.sum} - ${state.themeName}");
                  }
                  count = state.sum;
                  context.read<SwitchCubit>().onSwitch(null, false);
                  return Text(
                    state.sum.toString(),
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                }
                return Container();
              },
            ),
            const SizedBox(
              width: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.read<ClickCubit>().onClick(1);
                  },
                  child: const Icon(Icons.add),
                ),
                SizedBox(width: 15),
                Container(
                  width: 300,
                  height: 400,
                  child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: text.length,
                      itemBuilder: (BuildContext context, int index) {
                        return BlocBuilder<ClickCubit, ClickState>(
                          builder: (context, state) {
                            if (state is Click) {
                              return Text(text[index],
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium);
                            }
                            return Container();
                          },
                        );
                      }),
                ),
                const SizedBox(width: 15),
                ElevatedButton(
                  onPressed: () {
                    context.read<ClickCubit>().onClick(-1);
                  },
                  child: const Icon(Icons.remove),
                ),
              ],
            ),
            const SizedBox(height: 15),
            BlocBuilder<SwitchCubit, SwitchState>(
              builder: (context, state) {
                return ToggleSwitch(
                  cornerRadius: 20.0,
                  initialLabelIndex: 1,
                  totalSwitches: 2,
                  labels: const ['Black', 'White'],
                  activeBgColor: const [Color(0xFFf7cf01)],
                  inactiveBgColor: Colors.black26,
                  activeFgColor: Colors.black,
                  onToggle: (index) {
                    if (index == 0) {
                      if (text.isNotEmpty) {
                        writeTheme(
                            "Black",
                            text[text.length - 1].substring(
                                0, text[text.length - 1].length - 8));
                        context.read<SwitchCubit>().onSwitch(false, true);
                      }
                    } else {
                      if (text.isNotEmpty) {
                        writeTheme(
                            "White",
                            text[text.length - 1].substring(
                                0, text[text.length - 1].length - 8));
                        context.read<SwitchCubit>().onSwitch(true, true);
                      }
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
