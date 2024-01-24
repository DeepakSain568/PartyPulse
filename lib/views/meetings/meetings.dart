import 'package:flutter/material.dart';
import 'package:newupdate/utils/constants.dart';
import 'package:newupdate/utils/widgets/meetingtabs/meetingslist.dart';
import 'package:newupdate/utils/widgets/meetingtabs/meetingsscheduler.dart';

class Meetings extends StatefulWidget {
  const Meetings({super.key});

  @override
  State<Meetings> createState() => _MeetingsState();
}

class _MeetingsState extends State<Meetings> {
 
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        extendBody: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(105),
          child: AppBar(
            centerTitle: true,
            backgroundColor: constants().Themecolor,
            title: const Text("Meetings"),
            bottom:const  TabBar(
                indicatorColor: Colors.white,
                indicatorWeight: 4,
                indicatorSize: TabBarIndicatorSize.label,
                tabs: [
                  Tab(icon: Icon(Icons.add), text: "Schedule Meetings"),
                  Tab(icon: Icon(Icons.list), text: "Scheduled Meetings")
                ]),
          ),
        ),
        body: const TabBarView(children: [
          MeetingsScheduler(),
          meetingsList( )
        ]),
      ),
    );
  }
}
