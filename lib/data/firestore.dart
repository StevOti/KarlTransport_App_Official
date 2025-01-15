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
    List<bool> functionalCheckValues,
    List<bool> carAccessoriesValues,
    List<bool> extraFunctionalCheckValues,
    List<bool> tankLevelValues,
    List<bool> commentValues,
    List<bool> tyreChangeValues,
    List<bool> insideDamageValues,
    List<bool> smokyVehicleValues,
    List<bool> tyreTypes,

    
    // After Journey Data
    String endDate,
    String endTime,
    String endStreet,
    String endStreetNo,
    String endPlz,
    String endCity,
    String endKeyNo,
    String endMileage,
    String transfereeName,
    String transfereeMail,
    String transfereeStreet,
    String transfereeHouseNo,
    String transfereePlz,
    String transfereeCity,
    String transfereeLand,
    String transfereeDob,
    String transfereeId,
    String transfereeIdValidity,

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
        "functionalCheckValues": functionalCheckValues,
        "carAccessoriesValues": carAccessoriesValues,
        "extraFunctionalCheckValues": extraFunctionalCheckValues,
        "tankLevelValues": tankLevelValues,
        "commentValues": commentValues,
        "tyreChangeValues": tyreChangeValues,
        "insideDamageValues": insideDamageValues,
        "smokyVehicleValues": smokyVehicleValues,
        "tyreTypes": tyreTypes,
        
        
        
        // After Journey Fields (initially empty)
        "endDate": endDate,
        "endTime": endTime,
        "endStreet": endStreet,
        "endStreetNo": endStreetNo,
        "endPlz": endPlz,
        "endCity": endCity,
        "endKeyNo": endKeyNo,
        "endMileage": endMileage,
        "transfereeName": transfereeName,
        "transfereeMail": transfereeMail,
        "transfereeStreet": transfereeStreet,
        "transfereeHouseNo": transfereeHouseNo,
        "transfereePlz": transfereePlz,
        "transfereeCity": transfereeCity,
        "transfereeLand": transfereeLand,
        "transfereeDob": transfereeDob,
        "transfereeId": transfereeId,
        "transfereeIdValidity": transfereeIdValidity,

      });
      return true;
    } catch (e) {
      return true;
    }
  }

  Future<bool> updateContractAfterJourney(
    String uuid, // You'll need the contract's ID to update it
    String endDate,
    String endTime,
    String endStreet,
    String endStreetNo,
    String endPlz,
    String endCity,
    String endKeyNo,
    String endMileage,
    String transfereeName,
    String transfereeMail,
    String transfereeStreet,
    String transfereeHouseNo,
    String transfereePlz,
    String transfereeCity,
    String transfereeLand,
    String transfereeDob,
    String transfereeId,
    String transfereeIdValidity,



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
        'endDate': endDate,
        'endTime': endTime,
        'endStreet': endStreet,
        'endStreetNo': endStreetNo,
        'endPlz': endPlz,
        'endCity': endCity,
        'endKeyNo': endKeyNo,
        'endMileage': endMileage,
        'transfereeName': transfereeName,
        'transfereeMail': transfereeMail,
        'transfereeStreet': transfereeStreet,
        'transfereeHouseNo': transfereeHouseNo,
        'transfereePlz': transfereePlz,
        'transfereeCity': transfereeCity,
        'transfereeLand': transfereeLand,
        'transfereeDob': transfereeDob,
        'transfereeId': transfereeId,
        'transfereeIdValidity': transfereeIdValidity,




      });
      return true;
    } catch (e) {
      print(e);
      return true;
    }
  }

  Future<bool> completeContract(
    String uuid,
    String endDate,
    String endTime,
    String endStreet,
    String endStreetNo,
    String endPlz,
    String endCity,
    String endKeyNo,
    String endMileage,
    String transfereeName,
    String transfereeMail,
    String transfereeStreet,
    String transfereeHouseNo,
    String transfereePlz,
    String transfereeCity,
    String transfereeLand,
    String transfereeDob,
    String transfereeId,
    String transfereeIdValidity,




  ) async {
    try {
      await _firestore.collection('users').doc(_auth.currentUser!.uid).collection('contracts').doc(uuid).update({
        "isJourneyCompleted": true,
        "isDon": true,
        "endDate": endDate,
        "endTime": endTime,
        "endStreet": endStreet,
        "endStreetNo": endStreetNo,
        "endPlz": endPlz,
        "endCity": endCity,
        "endKeyNo": endKeyNo,
        "endMileage": endMileage,
        "transfereeName": transfereeName,
        "transfereeMail": transfereeMail,
        "transfereeStreet": transfereeStreet,
        "transfereeHouseNo": transfereeHouseNo,
        "transfereePlz": transfereePlz,
        "transfereeCity": transfereeCity,
        "transfereeLand": transfereeLand,
        "transfereeDob": transfereeDob,
        "transfereeId": transfereeId,
        "transfereeIdValidity": transfereeIdValidity,


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

        // Convert the functionalCheckValues from List<dynamic> to List<bool>
      List<bool> functionalChecks = (data['functionalCheckValues'] as List)
          .map((item) => item as bool)
          .toList();

      List<bool> carAccessories = (data['carAccessoriesValues'] as List)
          .map((item) => item as bool)
          .toList();

      List<bool> extraFunctionalCheck = (data['extraFunctionalCheckValues'] as List)
          .map((item) => item as bool)
          .toList();

      List<bool> tankLevel = (data['tankLevelValues'] as List)
          .map((item) => item as bool)
          .toList();

      List<bool> comments = (data['commentValues'] as List)
          .map((item) => item as bool)
          .toList();

      List<bool> tyreChange = (data['tyreChangeValues'] as List)
          .map((item) => item as bool)
          .toList();

      List<bool> insideDamage = (data['insideDamageValues'] as List)
          .map((item) => item as bool)
          .toList();

      List<bool> smokyVehicle = (data['smokyVehicleValues'] as List)
          .map((item) => item as bool)
          .toList();

      List<bool> tyreTypes = (data['tyreTypes'] as List)
          .map((item) => item as bool)
          .toList();

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
          functionalChecks,
          carAccessories,
          extraFunctionalCheck,
          tankLevel,
          comments,
          tyreChange,
          insideDamage,
          smokyVehicle,
          tyreTypes,



          data['isDon'],

          // Add after journey fields
          data['endDate'],
          data['endTime'],
          data['endStreet'],
          data['endStreetNo'],
          data['endPlz'],
          data['endCity'],
          data['endKeyNo'],
          data['endMileage'],
          data['transfereeName'],
          data['transfereeMail'],
          data['transfereeStreet'],
          data['transfereeHouseNo'],
          data['transfereePlz'],
          data['transfereeCity'],
          data['transfereeLand'],
          data['transfereeDob'],
          data['transfereeId'],
          data['transfereeIdValidity'],

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
    String vehicleType, 
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
    List<bool> functionalCheckValues,
    List<bool> carAccessoriesValues,
    List<bool> extraFunctionalCheckValues,
    List<bool> tankLevelValues,
    List<bool> commentValues,
    List<bool> tyreChangeValues,
    List<bool> insideDamageValues,
    List<bool> smokyVehicleValues,
    List<bool> tyreTypes,



    // After Journey Data
    String endDate,
    String endTime,
    String endStreet,
    String endStreetNo,
    String endPlz,
    String endCity,
    String endKeyNo,
    String endMileage,
    String transfereeName,
    String transfereeMail,
    String transfereeStreet,
    String transfereeHouseNo,
    String transfereePlz,
    String transfereeCity,
    String transfereeLand,
    String transfereeDob,
    String transfereeId,
    String transfereeIdValidity,



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
        'functionalCheckValues': functionalCheckValues,
        'carAccessoriesValues': carAccessoriesValues,
        'extraFunctionalCheckValues': extraFunctionalCheckValues,
        'tankLevelValues': tankLevelValues,
        'commentValues': commentValues,
        'tyreChangeValues': tyreChangeValues,
        'insideDamageValues': insideDamageValues,
        'smokyVehicleValues': smokyVehicleValues,
        'tyreTypes': tyreTypes,




        // After Journey Fields
        'endDate': endDate,
        'endTime': endTime,
        'endStreet': endStreet,
        'endStreetNo': endStreetNo,
        'endPlz': endPlz,
        'endCity': endCity,
        'endKeyNo': endKeyNo,
        'endMileage': endMileage,
        'transfereeName': transfereeName,
        'transfereeMail': transfereeMail,
        'transfereeStreet': transfereeStreet,
        'transfereeHouseNo': transfereeHouseNo,
        'transfereePlz': transfereePlz,
        'transfereeCity': transfereeCity,
        'transfereeLand': transfereeLand,
        'transfereeDob': transfereeDob,
        'transfereeId': transfereeId,
        'transfereeIdValidity': transfereeIdValidity,

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