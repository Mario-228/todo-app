import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/cubit/states.dart';
import 'package:todoapp/reusable_components.dart';
import 'cubit/cubit.dart';


// ignore: camel_case_types
class archived extends StatelessWidget {
  const archived({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<Navigatorr,NavigatorStates>(
      listener: (context, state) {},
      builder: (context, state) {
         var result = Navigatorr.get(context).archivedTasks;
        return ConditionalBuilder(
          // ignore: prefer_is_empty
          condition:result.length>0,
          builder: (context) => ListView.separated(
        itemBuilder: (context,index)=>card(result[index]['time'],result[index]['date'],result[index]['title'],result[index]['id'],context), 
        separatorBuilder: (context,index)=>Padding(
        padding: const EdgeInsets.only(left:20.0),
        child: Container(width: double.infinity,height: 1.0,color: Colors.grey[300],),
      ),
       itemCount: result.length),
          fallback: (context) =>const Center(
            child:  CircleAvatar(
             radius: 60.0,
              backgroundColor: Color.fromARGB(115, 98, 83, 83),
              child: Text("No Archived Tasks",textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
              ),
            ),
          ) ,
        );
      },
    );
  }
}