import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:karltransportapp/data/firestore.dart';
import 'package:karltransportapp/models/contract_models.dart';
import 'package:karltransportapp/themes/colors.dart';
import 'package:karltransportapp/widgets/custom_text_field.dart';

class EditContractScreen extends StatefulWidget {
  final Contract contract;

  const EditContractScreen(this.contract, {super.key});

  @override
  State<EditContractScreen> createState() => _EditContractScreenState();
}

class _EditContractScreenState extends State<EditContractScreen> {
  // Before Journey Controllers
  late TextEditingController driverName;
  late TextEditingController vehicleType;
  late TextEditingController licensePlate;
  late TextEditingController date;
  late TextEditingController startTime;
  late TextEditingController street;
  late TextEditingController plz;
  late TextEditingController keyNumber;
  late TextEditingController mileage;
  late TextEditingController remarks;
  late TextEditingController seatNumber;
  late TextEditingController frontLeft;
  late TextEditingController frontRight;
  late TextEditingController rearLeft;
  late TextEditingController rearRight;
  late TextEditingController transferorName;
  late TextEditingController transferorEmail;
  

  // After Journey Controllers
  late TextEditingController finalMileage;
  late TextEditingController finalRemarks;

  DateTime selectedDate = DateTime.now();
  String initialStartTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String initialEndTime = DateFormat('hh:mm a').format(DateTime.now().add(const Duration(minutes: 15))).toString();


  @override
  void initState() {
    super.initState();

    // before journey
    driverName = TextEditingController(text: widget.contract.driverName);
    vehicleType = TextEditingController(text: widget.contract.vehicleType);
    licensePlate = TextEditingController(text: widget.contract.licensePlate);
    date = TextEditingController(text: widget.contract.date);
    startTime = TextEditingController(text: widget.contract.startTime);
    street = TextEditingController(text: widget.contract.street);
    plz = TextEditingController(text: widget.contract.plz);
    keyNumber = TextEditingController(text: widget.contract.keyNumber);
    mileage = TextEditingController(text: widget.contract.mileage);
    remarks = TextEditingController(text: widget.contract.remarks);
    seatNumber = TextEditingController(text: widget.contract.seatNumber);
    frontLeft = TextEditingController(text: widget.contract.frontLeft);
    frontRight = TextEditingController(text: widget.contract.frontRight);
    rearLeft = TextEditingController(text: widget.contract.rearLeft);
    rearRight = TextEditingController(text: widget.contract.rearRight);
    transferorName = TextEditingController(text: widget.contract.transferorName);
    transferorEmail = TextEditingController(text: widget.contract.transferorEmail);


    // after journey
    finalMileage = TextEditingController(text: widget.contract.finalMileage);
    finalRemarks = TextEditingController(text: widget.contract.finalRemarks);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF17203A),
          title: const Text('Contract Details'),
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(
                  Icons.departure_board,
                  color: Colors.white,
                  ),
                text: 'Before Journey'
                ),
              Tab(
                icon: Icon(
                  Icons.access_time_filled_rounded,
                  color: Colors.white,
                  ),
                text: 'After Journey'
                ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            buildBeforeJourneyTab(),
            buildAfterJourneyTab(),
          ],
        ),
      ),
    );
  }

  Widget buildBeforeJourneyTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          const SizedBox(height: 20),

        CustomTextField(
          title: 'Date',
          controller: startTime, // Dynamically updates with the selected date
          hintText: 'Select Date',
          focusNode: FocusNode(),
          widget: IconButton(
            onPressed: () async {
              await _getDateFromUser(); // Fetch the selected date
              date.text = DateFormat('yyyy-MM-dd').format(selectedDate); // Update the controller with the formatted date
            },
            icon: const Icon(
              Icons.calendar_today_outlined,
              color: Colors.grey,
            ),
          ),
        ),


          const SizedBox(height: 20),

          CustomTextField(
            focusNode: FocusNode(),
            controller: date, // Dynamically updates with the selected time
            title: 'Start Time',
            hintText: 'Select Time',
            widget: IconButton(
              onPressed: () async {
                await _getTimeFromUser(isStartTime: true); // Fetch the selected time
                startTime.text = initialStartTime; // Update the controller with the selected time
              },
              icon: const Icon(
                Icons.access_time_rounded,
                color: Colors.grey,
              ),
            ),
          ),


          CustomTextField(
            title: 'Driver Name',
            controller: driverName,
            focusNode: FocusNode(),
            hintText: 'Enter driver name',
          ),
          const SizedBox(height: 20),
          CustomTextField(
            title: 'Vehicle Type',
            controller: vehicleType,
            focusNode: FocusNode(),
            hintText: 'Enter vehicle type',
          ),
          const SizedBox(height: 20),
          CustomTextField(
            title: 'License Plate',
            controller: licensePlate,
            focusNode: FocusNode(),
            hintText: 'Enter license plate',
          ),


          const SizedBox(height: 20),

          CustomTextField(
            title: 'Street',
            controller: street,
            hintText: 'Street',
            focusNode: FocusNode(),
          ),

          const SizedBox(height: 20),

          CustomTextField(
            title: 'PLZ',
            controller: plz,
            hintText: 'PLZ',
            focusNode: FocusNode(),
          ),

          const SizedBox(height: 20),

          CustomTextField(
            title: 'Key Number',
            controller: keyNumber,
            hintText: 'Key Number',
            focusNode: FocusNode(),
          ),

          const SizedBox(height: 20),
          CustomTextField(
            title: 'Mileage',
            controller: mileage,
            hintText: 'Mileage',
            focusNode: FocusNode(),
          ),

          const SizedBox(height: 20),
          CustomTextField(
            title: 'Remarks',
            controller: remarks,
            hintText: 'Remarks',
            focusNode: FocusNode(),
          ),

          const SizedBox(height: 20),
          CustomTextField(
            title: 'Number of Seats',
            controller: seatNumber,
            hintText: 'Number of Seats',
            focusNode: FocusNode(),
          ),

          const SizedBox(height: 20),
          CustomTextField(
            title: 'Front Left in mm',
            controller: frontLeft,
            hintText: 'Front Left in mm',
            focusNode: FocusNode(),
          ),

          const SizedBox(height: 20),
          CustomTextField(
            title: 'Front Right in mm',
            controller: frontRight,
            hintText: 'Front Right in mm',
            focusNode: FocusNode(),
          ),

          const SizedBox(height: 20),
          CustomTextField(
            title: 'Rear Left in mm',
            controller: rearLeft,
            hintText: 'Rear Left in mm',
            focusNode: FocusNode(),
          ),

          const SizedBox(height: 20),
          CustomTextField(
            title: 'Rear Right in mm',
            controller: rearRight,
            hintText: 'Rear Right in mm',
            focusNode: FocusNode(),
          ),

          const SizedBox(height: 20),
          CustomTextField(
            title: 'Name of Transferor',
            controller: transferorName,
            hintText: 'Name of Transferor',
            focusNode: FocusNode(),
          ),

          const SizedBox(height: 20),
          CustomTextField(
            title: 'Email of Transferor',
            controller: transferorEmail,
            hintText: 'Email of Transferor',
            focusNode: FocusNode(),
          ),

          // buildDateAndTimePickers(),
          const SizedBox(height: 20),
          buttons(),
        ],
      ),
    );
  }

  Widget buildAfterJourneyTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          const SizedBox(height: 20),
        CustomTextField(
          title: 'Final Mileage',
          controller: finalMileage,
          focusNode: FocusNode(),
          hintText: 'Enter final mileage',
        ),
        const SizedBox(height: 20),
        CustomTextField(
          title: 'Final Remarks',
          focusNode: FocusNode(),
          controller: finalRemarks,
          hintText: 'Enter final remarks',
        ),
          const SizedBox(height: 20),
          buttons(),
        ],
      ),
    );
  }

  Widget buttons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: custom_green),
          onPressed: () {
            FirestoreDatasource().updateContract(
              widget.contract.id,

              // Before Journey Data
              driverName.text,
              vehicleType.text,
              licensePlate.text,
              date.text,
              startTime.text,
              street.text,
              plz.text,
              keyNumber.text,
              mileage.text,
              remarks.text,
              seatNumber.text,
              frontLeft.text,
              frontRight.text,
              rearLeft.text,
              rearRight.text,
              transferorName.text,
              transferorEmail.text,



              // After Journey Data
              finalMileage.text,
              finalRemarks.text,
              
            );
            Navigator.pop(context);
          },
          child: const Text('Save'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }

  Future<void> _getDateFromUser () async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015),
      lastDate: DateTime(2121),
    );
    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
        date.text = DateFormat('yyyy-MM-dd').format(selectedDate); // Update the date controller here
      });
    }
  }

  Future<void> _getTimeFromUser ({required bool isStartTime}) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        if (isStartTime) {
          initialStartTime = pickedTime.format(context);
          startTime.text = initialStartTime; // Update the startTime controller here
        } else {
          // If you have an end time controller, you can update it here
          // endTime.text = pickedTime.format(context);
        }
      });
    }
  }

}
