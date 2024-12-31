import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:karltransportapp/data/firestore.dart';
import 'package:karltransportapp/widgets/contract_widget.dart';

class StreamContract extends StatelessWidget {

  bool done;
  StreamContract(this.done, {super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
          stream: FirestoreDatasource().stream(done),
          builder: (context, snapshot) {
            if(!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final contractsList = FirestoreDatasource().getContracts(snapshot);
            return ListView.builder(shrinkWrap: true,itemBuilder:(context, index) {
              final contract = contractsList[index];
              return  Dismissible(key: UniqueKey(), onDismissed: (direction) {
                FirestoreDatasource().deleteContract(contract.id);
              },child: ContractWidget(contract));
            },
            itemCount: contractsList.length,
            );
          }
        );
  }
}