import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:karltransportapp/models/contract_models.dart';
import 'package:uuid/uuid.dart';

class FirestoreDatasource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> createUser(String email) async {
    try {
      await _firestore.collection('users').doc(_auth.currentUser!.uid).set({
        "id": _auth.currentUser!.uid,
        "email": email,
      });
      return true;
    } catch (e) {
      return true;
    }
  }

  Future<bool> addContract(
    // Before Journey Data
    String vehicleType,
    String driverName,
    String licensePlate,
    String date,
    String startTime,
    String street,
    String plz,
    String keyNumber,
    String mileage,
    String remarks,
    String seatNumber,
    String frontLeft,
    String frontRight,
    String rearLeft,
    String rearRight,
    String transferorName,
    String transferorEmail,

    
    // After Journey Data
    String finalMileage,
    String finalRemarks,

  ) async {
    try {
      var uuid = const Uuid().v4();
      DateTime data = DateTime.now();
      await _firestore.collection('users').doc(_auth.currentUser!.uid).collection('contracts').doc(uuid).set({
        "id": uuid,
        "isDon": false,
        "isJourneyStarted": true,
        "isJourneyCompleted": false,

        "time": '${data.hour}:${data.minute}',
        
        // Before Journey Fields
        "driverName": driverName,
        "vehicleType": vehicleType,
        "licensePlate": licensePlate,
        "date": date,
        "startTime": startTime,
        "street": street,
        "plz": plz,
        "keyNumber": keyNumber,
        "mileage": mileage,
        "remarks": remarks,
        "seatNumber": seatNumber,
        "frontLeft": frontLeft,
        "frontRight": frontRight,
        "rearLeft": rearLeft,
        "rearRight": rearRight,
        "transferorName": transferorName,
        "transferorEmail": transferorEmail,
        
        
        
        // After Journey Fields (initially empty)
        "finalMileage": finalMileage,
        "finalRemarks": finalRemarks,
      });
      return true;
    } catch (e) {
      return true;
    }
  }

  Future<bool> updateContractAfterJourney(
    String uuid, // You'll need the contract's ID to update it
    String finalMileage,
    String finalRemarks,
  ) async {
    try {
      DateTime data = DateTime.now();
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('contracts')
          .doc(uuid)
          .update({
        'isDon': true, // Mark the contract as completed
        'isJourneyCompleted': true,
        'completionTime': '${data.hour}:${data.minute}',
        'finalMileage': finalMileage,
        'finalRemarks': finalRemarks,
      });
      return true;
    } catch (e) {
      print(e);
      return true;
    }
  }

  Future<bool> completeContract(
    String uuid,
    String finalMileage,
    String finalRemarks,
  ) async {
    try {
      await _firestore.collection('users').doc(_auth.currentUser!.uid).collection('contracts').doc(uuid).update({
        "isJourneyCompleted": true,
        "isDon": true,
        "finalMileage": finalMileage,
        "finalRemarks": finalRemarks,
      });
      return true;
    } catch (e) {
      return true;
    }
  }

  List getContracts(AsyncSnapshot snapshot) {
    try {
      final contractList = snapshot.data.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Contract(
          data['id'],
          data['driverName'],
          data['vehicleType'],
          data['licensePlate'],
          data['startTime'],
          data['date'],
          data['street'],
          data['plz'],
          data['keyNumber'],
          data['mileage'],
          data['remarks'],
          data['seatNumber'],
          data['frontLeft'],
          data['frontRight'],
          data['rearLeft'],
          data['rearRight'],
          data['transferorName'],
          data['transferorEmail'],



          data['isDon'],

          // Add after journey fields
          data['finalMileage'],
          data['finalRemarks'],
          
        );
      }).toList();
      return contractList;
    } catch (e) {
      return [];
    }
  }

  Stream<QuerySnapshot> stream(bool isDone) {
    return _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .collection('contracts')
        .where('isDon', isEqualTo: isDone)
        .snapshots();
  }


    Future<bool> isdone(String uuid, bool isDon) async {
    try{
      await _firestore.collection('users').doc(_auth.currentUser!.uid).collection('contracts').doc(uuid).update({
        'isDon': isDon
      });
      return true;
    }catch(e) {
      print(e);
      return true;
    }
  }

  Future<bool> updateContract(
    String uuid, 

    // Before Journey Data
    String driverName, 
    String  vehicleType, 
    String  licensePlate, 
    String date,
    String startTime,
    String street,
    String plz,
    String keyNumber,
    String mileage,
    String remarks,
    String seatNumber,
    String frontLeft,
    String frontRight,
    String rearLeft,
    String rearRight,
    String transferorName,
    String transferorEmail,



    // After Journey Data
    String finalMileage,
    String finalRemarks,
  ) async {
    try{
      DateTime data = DateTime.now();
      await _firestore.collection('users').doc(_auth.currentUser!.uid).collection('contracts').doc(uuid).update({
        'time': '${data.hour}: ${data.minute}',

        // Before Journey Fields
        'driverName': driverName,
        'vehicleType': vehicleType,
        'licensePlate': licensePlate,
        'date': date,
        'startTime': startTime,
        'street': street,
        'plz': plz,
        'keyNumber': keyNumber,
        'mileage': mileage,
        'remarks': remarks,
        'seatNumber': seatNumber,
        'frontLeft': frontLeft,
        'frontRight': frontRight,
        'rearLeft': rearLeft,
        'rearRight': rearRight,
        'transferorName': transferorName,
        'transferorEmail': transferorEmail,




        // After Journey Fields
        'finalMileage': finalMileage,
        'finalRemarks': finalRemarks,

      });
      return true;
    }catch(e) {
      print(e);
      return true;
    }
  }


  Future<bool> deleteContract(String uuid) async {
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('contracts')
          .doc(uuid)
          .delete();
      return true;
    } catch (e) {
      return true;
    }
  }
}