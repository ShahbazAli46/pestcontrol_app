import 'package:accurate/components/UpcomignJobs/UpcomingJobs.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:accurate/utils/appColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/UpcomignJobs/UpcomingJobsController.dart';

class UpComingJobsScreen extends StatefulWidget {
  const UpComingJobsScreen({Key? key}) : super(key: key);

  @override
  State<UpComingJobsScreen> createState() => _UpComingJobsScreenState();
}

class _UpComingJobsScreenState extends State<UpComingJobsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            NavWithBack(),
            SizedBox(height: 20,),
            Expanded(child: UpComingJobs())
          ],
        ),
      ),
    );
  }
}
