import 'package:flutter/material.dart';
import 'package:todoapp/cubit/cubit.dart';
Widget card(String time,String date,String title ,int id , BuildContext context) => Dismissible(
  key: Key("$id"),
  onDismissed: (direction) 
  {
    Navigatorr.get(context).deleteDatabase(id);
  },
  child:Padding(
        padding: const EdgeInsets.only(left: 20.0 ,top: 10.0,bottom: 10.0),
        child:  Row(
          children: [
            CircleAvatar(
              radius: 40.0,
              child: Text(time),
            ),
            const SizedBox(width: 20.0),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                Text(title,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0),),
               const  SizedBox(height: 8.0,),
                Text(date,style: const TextStyle(color: Colors.grey),),
              ],
              ),
            ),
            const SizedBox(width: 20.0),
            IconButton(onPressed:(){
              Navigatorr.get(context).updateDatabase("done", id);
            }, icon:const Icon(Icons.check_box,color: Colors.green,)),
            const SizedBox(width: 5.0),
            IconButton(onPressed: (){
               Navigatorr.get(context).updateDatabase("Archived", id);
            }, icon:const Icon(Icons.archive,color: Colors.black38)),
          ],
        ),
      ),
);