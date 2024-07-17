// ignore_for_file: unused_local_variable, file_names, prefer_typing_uninitialized_variables
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
// import 'consts.dart';
// ignore: depend_on_referenced_packages
// import 'package:sqflite/sqflite.dart';
import 'cubit/states.dart';
import 'cubit/cubit.dart';
// ignore: camel_case_types
class todoApp extends StatelessWidget {
  const todoApp({super.key});
  
  @override
  Widget build(BuildContext context) 
  {
   return BlocProvider(
    create: (context) =>Navigatorr()..createDatabase(),
     child: BlocConsumer<Navigatorr,NavigatorStates>(
      listener: (context, state) {},
      builder: (context, state)=> Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: const Text("Todo App"),
          ),
          // Navigatorr.get(context).screens[Navigatorr.get(context).index]
          body: ConditionalBuilder
          (condition:state is! GetDbLoad ,
           builder:(context) => Navigatorr.get(context).screens[Navigatorr.get(context).index],
            fallback:(context) =>const Center(child:CircularProgressIndicator()),
            ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.grey[300],
            elevation: 50.0,
            currentIndex: Navigatorr.get(context).index,
            onTap: (value) {
              Navigatorr.get(context).navigatorIndex(value);
            },
            items: const [
            BottomNavigationBarItem(icon: Icon(Icons.task),
            label: "Tasks",
            ),
             BottomNavigationBarItem(icon: Icon(Icons.done),
            label: "Done",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.archive_outlined),
            label: "Archived",
            )
          ]
          ),
          floatingActionButton: FloatingActionButton(onPressed: 
          ()
          {
             if(Navigatorr.get(context).isOpen)
              {
                if(formKey.currentState!.validate())
                {
              Navigatorr.get(context).insertDatabase(titleController.text,timeController.text,dateController.text).then((value)
              {
                titleController.text='';
                timeController.text='';
                dateController.text='';
              Navigator.pop(context);
              Navigatorr.get(context).isBottomSheet(false, Icons.add);
              });
                }
              }
              else
              {
               Navigatorr.get(context).isBottomSheet(Navigatorr.get(context).isOpen, Icons.edit);
               scaffoldKey.currentState?.showBottomSheet(
            (context)
            {
               return Container(
                 color: Colors.grey[200],
                 padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
                 child: Form(
                  key: formKey,
                   child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        validator: (String? value) {
                          if(value!.isEmpty)
                          {
                            return "Title must not be empty";
                          }
                          return null;
                        },
                        decoration:const InputDecoration(
                          prefixIcon: Icon(Icons.title_outlined),
                          label: Text("Title"),
                          border: OutlineInputBorder(borderRadius:BorderRadius.all(Radius.circular(2)))
                        ),
                        keyboardType: TextInputType.text,
                        controller: titleController,
                      ),
                      const SizedBox(height: 10.0),
                      TextFormField(
                        onTap: () {
                          showTimePicker
                          (context: context,
                           initialTime: TimeOfDay.now()
                          ).then((value){
                              timeController.text=value!.format(context);
                          });
                        },
                        validator: (String? value) {
                          if(value!.isEmpty)
                          {
                            return "Time must not be empty";
                          }
                          return null;
                        },
                      decoration:const InputDecoration(
                        prefixIcon: Icon(Icons.timer_outlined),
                        label: Text("Time"),
                        border: OutlineInputBorder(borderRadius:BorderRadius.all(Radius.circular(2)))
                        ),
                        keyboardType: TextInputType.datetime,
                        controller: timeController,
                      )
                      ,
                      const SizedBox(height: 10.0),
                      TextFormField(
                        validator: (String? value) {
                          if(value!.isEmpty)
                          {
                            return "Date must not be empty";
                          }
                          return null;
                        },
                        onTap: () {
                          showDatePicker(
                            context: context,
                           initialDate:DateTime.now(), 
                           firstDate: DateTime.now(),
                           lastDate: DateTime.parse("2023-09-27")
                           ).then((value) 
                            {
                                dateController.text=DateFormat.yMMMd().format(value!);
                            });
                        },
                        decoration:const InputDecoration(
                          prefixIcon: Icon(Icons.calendar_month_outlined),
                          label: Text("Date"),
                          border: OutlineInputBorder(borderRadius:BorderRadius.all(Radius.circular(2)))
                        ),
                        keyboardType: TextInputType.datetime,
                        controller: dateController,
                      )
                    ,const SizedBox(height: 10.0)
                    ],
                   ),
                 ),
               );
            }
          ).closed.then((value) 
          {
            Navigatorr.get(context).isBottomSheet(false, Icons.add);
          });
            Navigatorr.get(context).isBottomSheet(true,Navigatorr.get(context).floatingIcon);
              }
          },
          child: Icon(Navigatorr.get(context).floatingIcon),
          ),
        ),
     ),
   );
  }
}
//***********************Variables***************************** 

// ignore: non_constant_identifier_names
var scaffoldKey =GlobalKey<ScaffoldState>();
var formKey =GlobalKey<FormState>();
// ignore: non_constant_identifier_names
var titleController=TextEditingController();
var dateController=TextEditingController();
var timeController=TextEditingController();
//*************************************************************
