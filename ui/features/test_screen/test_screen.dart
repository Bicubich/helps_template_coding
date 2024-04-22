import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helps_flutter/ui/features/helps_template/helps_template.dart';
import 'package:helps_flutter/ui/features/test_screen/cubit/test_screen_cubit.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return HelpsTemplate(
        body: BlocProvider(
      create: (context) => TestScreenCubit(),
      child: BlocBuilder<TestScreenCubit, TestScreenState>(
        builder: (testScreenContext, state) {
          return Column(
            children: [
              SizedBox(
                height: 500,
                child: ListView.separated(
                    itemBuilder: (context, index) =>
                        Text((state).stringList[index].toString()),
                    separatorBuilder: (context, index) => SizedBox(
                          height: 15.h,
                        ),
                    itemCount: (state as TestScreenInitial).stringList.length),
              ),
              ElevatedButton.icon(
                  onPressed: () =>
                      testScreenContext.read<TestScreenCubit>().addString(),
                  icon: Icon(Icons.add),
                  label: Text('Прибавить'))
            ],
          );
        },
      ),
    ));
  }
}
