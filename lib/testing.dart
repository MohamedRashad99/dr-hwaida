import 'package:DrHwaida/models/consultantApi.dart';
import 'package:flutter/material.dart';

class Testing extends StatefulWidget {
  @override
  _TestingState createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: ConsultantApi.fetchConsultantById(2),
        builder: (contant, snapshot) {
          return (snapshot.data == null)
              ? Container(
                  child: Center(child: CircularProgressIndicator()),
                )
              : Container(
                  child: Text(snapshot.data.name),
                );
        },
      ),
    );
  }
}
