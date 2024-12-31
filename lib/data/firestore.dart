import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:karltransportapp/models/contract_models.dart';
import 'package:uuid/uuid.dart';

class FirestoreDatasource {
  final FirebaseFirestore _firestore =FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> createUser(String email) async {
    try {
      await _firestore.collection('users').doc(_auth.currentUser!.uid).set({
      "id": _auth.currentUser!.uid,
      "email": email,
    });
    return true;
    }
    catch (e) {
      return true;
    }
    
  }

  Future<bool> addContract(
    String vehicleType, 
    String driverName, 
    int image, 
    String licensePlate, 
    String fin,
    String street,
    String streetNumber,
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
    String startTime,
    String endTime,
    String date,
  ) async {
    try {
      var uuid = const Uuid().v4();
    DateTime data = DateTime.now();
    await _firestore.collection('users').doc(_auth.currentUser!.uid).collection('contracts').doc(uuid).set({
      "id": uuid,
      "vehicleType": vehicleType,
      "isDon": false,
      "image": image,
      "time": '${data.hour}: ${data.minute}',
      "driverName": driverName,
      "licensePlate": licensePlate,
      "fin": fin,
      "street": street,
      "streetNumber": streetNumber,
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
      "startTime": startTime,
      "endTime": endTime,
      "date": date,
    });
    return true;
    }
    catch (e) {
      return true;
    }
  }

  List getContracts(AsyncSnapshot snapshot) {
    try {
      final contractList = snapshot.data.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return Contract(
        data['id'],
        data['vehicleType'],
        data['driverName'],
        data['time'],
        data['image'],
        data['isDon'],
        data['licensePlate'],
        data['fin'],
        data['street'],
        data['streetNumber'],
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
        data['startTime'],
        data['endTime'],
        data['date'],
      );
    }).toList();
    return contractList;
    }catch(e){
      return[];
    }
  }

  Stream<QuerySnapshot> stream(bool isDone) {
  return _firestore.collection('users').doc(_auth.currentUser!.uid).collection('contracts').where('isDon', isEqualTo: isDone).snapshots();
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
    int image, 
    String driverName, 
    String  vehicleType, 
    String  licensePlate,  
    String  fin,
    String  street,
    String  streetNumber,
    String  plz,
    String  keyNumber,
    String  mileage,
    String  remarks,
    String  seatNumber,
    String  frontLeft,
    String  frontRight,
    String rearLeft,
    String rearRight,
    String transferorName,
    String transferorEmail,
    String startTime,
    String endTime,
    String date,
  ) async {
    try{
      DateTime data = DateTime.now();
      await _firestore.collection('users').doc(_auth.currentUser!.uid).collection('contracts').doc(uuid).update({
        'time': '${data.hour}: ${data.minute}',
        'vehicleType': vehicleType,
        'driverName': driverName,
        'image': image,
        'licensePlate': licensePlate,
        'fin': fin,
        'street': street,
        'streetNumber': streetNumber,
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
        'startTime': startTime,
        'endTime': endTime,
        'date': date,
      });
      return true;
    }catch(e) {
      print(e);
      return true;
    }
  }

  Future<bool> deleteContract(String uuid) async {
    try{
      await _firestore.collection('users').doc(_auth.currentUser!.uid).collection('contracts').doc(uuid).delete();
      return true;
    }catch(e) {
      print(e);
      return true;
    }
  }
}