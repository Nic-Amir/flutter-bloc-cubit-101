import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_state_management/counter_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BloC eg',
      theme: ThemeData.dark(),
      home: BlocProvider(
          create: (context) => CounterCubit(), child: const MyHomePage()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late CounterCubit cubit;

  @override
  void didChangeDependencies() {
    cubit = BlocProvider.of<CounterCubit>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bloc example'),
      ),
      body: BlocConsumer<CounterCubit, int>(
          bloc: cubit,
          listener: (BuildContext context, int state) {
            const snackbar = SnackBar(content: Text('ENUFF!!'));
            if (state == 5) {
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
            }
          },
          builder: (BuildContext context, int state) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$state',
                    style: TextStyle(
                      fontSize: 100,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            cubit.decrement();
                          },
                          child: Text('-')),
                      ElevatedButton(
                          onPressed: () {
                            cubit.setToZero();
                          },
                          child: Text('reset')),
                      ElevatedButton(
                          onPressed: () {
                            cubit.increment();
                          },
                          child: Text('+')),
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }
}
