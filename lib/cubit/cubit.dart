import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/archived.dart';
import 'package:todoapp/cubit/states.dart';
import 'package:todoapp/done.dart';
import 'package:todoapp/tasks.dart';
class Navigatorr extends Cubit<NavigatorStates>
{
 Navigatorr():super(InitialNavigatorState());
 static Navigatorr get(BuildContext context) =>BlocProvider.of(context);
 List<Widget>screens=const 
 [
  tasks(),
  done(),
  archived(),
];
// ignore: prefer_typing_uninitialized_variables
// ignore: non_constant_identifier_names
List<Map> newTasks=[];
List<Map> doneTasks=[];
List<Map> archivedTasks=[];
// ignore: non_constant_identifier_names
Database ? DB;
int index=0;


void navigatorIndex(int indexx)
{
  index=indexx;
  emit(NavigatorIndexState());
}

void createDatabase() 
{
     openDatabase(
    'todo.db',
    version: 1,
    onCreate: (db, version)
    {
      db.execute('''CREATE TABLE tasks 
      (
       id INTEGER PRIMARY KEY,
       title TEXT,
       date TEXT,
       time TEXT,
       status TEXT
       )''').
      then(
        (value)
      {
        // ignore: avoid_print
        print("tables created");
      }
        ).
      catchError(
      (error)
      {
        // ignore: avoid_print
        print("error=>${error.toString()}");
      }
      );
      // ignore: avoid_print
      print("Database created");
    },
    onOpen: (db) async
    {
      getData(db);
      // ignore: avoid_print
      print('Database opened');
    },
  ).then((value) 
  {
    DB=value;
    emit(CreateDb());
  });
}
/*
 title TEXT,
 date TEXT,
 time TEXT,
 status TEXT
*/
 insertDatabase(String title,String time,String date,)async
{
  await DB?.transaction (
    (txn)
    {
     return txn.rawInsert('''
          INSERT INTO tasks
          (title, date, time,status)
          VALUES("${title.toString()}","${date.toString()}","${time.toString()}","New")
          '''
          ).then((value)
          {
            // ignore: avoid_print
            print("Row $value inserted successfully");
            emit(InsertDb());

           getData(DB!);
           emit(GetDb());
            }
            )
            .catchError(
              (error)
              {
              // ignore: avoid_print
              print("error =>${error.toString()}"
              );
              }
              );
          // ignore: avoid_print
    }
  );
}

// ignore: non_constant_identifier_names
void getData(Database DB) 
{
  emit(GetDbLoad());
  DB.rawQuery("SELECT * FROM tasks").then((value)
      {
     newTasks=[];
     doneTasks=[];
     archivedTasks=[];
      // ignore: avoid_function_literals_in_foreach_calls
      value.forEach((element) 
      {
        if(element['status']=="New") {
          newTasks.add(element);
        } else if(element['status']=="done") {
          doneTasks.add(element);
        } else {
          archivedTasks.add(element);
        }
      },
      );
      emit(GetDb());
      });
}

bool isOpen=false;
IconData floatingIcon=Icons.add;

void isBottomSheet(bool isShow,IconData icon)
{
  isOpen=isShow;
  floatingIcon=icon;
  emit(ChangeFloatingAction());
}

void updateDatabase(String status , int id)
{
  DB!.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
  [status,id]).then(
    (value) 
    {
      getData(DB!);
      emit(UpdateDb());
    }
    );
}
void deleteDatabase(int id)
{
  DB!.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then(
    (value) 
    {
      getData(DB!);
      emit(DeleteDb());
    }
    );
}
}