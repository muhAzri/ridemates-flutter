import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ridemates/features/counter/presentation/bloc/counter_cubit.dart';

class CounterText extends StatelessWidget {
  const CounterText({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final count = context.select<CounterCubit, int>((cubit) => cubit.state);
    return Text('$count', style: theme.textTheme.displayLarge);
  }
}
