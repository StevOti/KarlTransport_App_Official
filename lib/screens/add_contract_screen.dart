import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:karltransportapp/data/firestore.dart';
import 'package:karltransportapp/themes/colors.dart';
import 'package:karltransportapp/widgets/custom_text_field.dart';

class AddContractScreen extends StatefulWidget {
  const AddContractScreen({super.key});

  @override
  State<AddContractScreen> createState() => _AddContractScreenState();
}

class _AddContractScreenState extends State<AddContractScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Before Journey Controllers
  final driverNameController = TextEditingController();
  final vehicleTypeController = TextEditingController();
  final licensePlateController = TextEditingController();
  final dateController = TextEditingController();
  final startTimeController = TextEditingController();
  final streetController = TextEditingController();
  final plzController = TextEditingController();
  final keyNumberController = TextEditingController();
  final mileageController = TextEditingController();
  final remarksController = TextEditingController();
  final seatNumberController = TextEditingController();
  final frontLeftController = TextEditingController();
  final frontRightController = TextEditingController();
  final rearLeftController = TextEditingController();
  final rearRightController = TextEditingController();
  final transferorNameController = TextEditingController();
  final transferorEmailController = TextEditingController();


  // After Journey Controllers
  final finalMileageController = TextEditingController();
  final finalRemarksController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  String startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String endTime = DateFormat('hh:mm a').format(DateTime.now().add(const Duration(minutes: 15))).toString();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    // Before Journey Controllers
    driverNameController.dispose();
    vehicleTypeController.dispose();
    licensePlateController.dispose();
    dateController.dispose();
    startTimeController.dispose();
    streetController.dispose();
    plzController.dispose();
    keyNumberController.dispose();
    mileageController.dispose();
    remarksController.dispose();
    seatNumberController.dispose();
    frontLeftController.dispose();
    frontRightController.dispose();
    rearLeftController.dispose();
    rearRightController.dispose();
    transferorNameController.dispose();
    transferorEmailController.dispose();

    // After Journey Controllers
    finalMileageController.dispose();
    finalRemarksController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: const Color(0xFF17203A),
        title: const Text('Add Contract'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              icon: Icon(Icons.departure_board, color: Colors.white),
              text: 'Before Journey',
            ),
            Tab(
              icon: Icon(Icons.access_time_filled_rounded, color: Colors.white),
              text: 'After Journey',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          buildBeforeJourneyTab(context),
          buildAfterJourneyTab(context),
        ],
      ),
    );
  }

  Widget buildBeforeJourneyTab(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          CustomTextField(
            title: 'Date',
            controller: dateController, // Updates dynamically with the selected date
            hintText: 'Select Date',
            focusNode: FocusNode(),
            widget: IconButton(
              onPressed: () async {
                await _getDateFromUser(); // Fetch the selected date
                dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate); // Update the controller
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
            controller: startTimeController, // Dynamically updates with the selected time
            title: 'Start Time',
            hintText: 'Select Time',
            widget: IconButton(
              onPressed: () async {
                await _getTimeFromUser(isStartTime: true); // Fetch the selected time
                startTimeController.text = startTime; // Update the controller with the selected time
              },
              icon: const Icon(
                Icons.access_time_rounded,
                color: Colors.grey,
              ),
            ),
          ),

          const SizedBox(height: 20),


          CustomTextField(
            title: 'Driver Name',
            controller: driverNameController,
            focusNode: FocusNode(),
            hintText: 'Enter driver name',
          ),
          const SizedBox(height: 20),
          CustomTextField(
            title: 'Vehicle Type',
            controller: vehicleTypeController,
            focusNode: FocusNode(),
            hintText: 'Enter vehicle type',
          ),
          const SizedBox(height: 20),
          CustomTextField(
            title: 'License Plate',
            controller: licensePlateController,
            focusNode: FocusNode(),
            hintText: 'Enter license plate',
          ),

          const SizedBox(height: 20),

          CustomTextField(
            title: 'Street',
            controller: streetController,
            hintText: 'Street',
            focusNode: FocusNode(),
          ),
          const SizedBox(height: 20),

          CustomTextField(
            title: 'PLZ',
            controller: plzController,
            hintText: 'PLZ',
            focusNode: FocusNode(),
          ),

          const SizedBox(height: 20),
          CustomTextField(
            title: 'Key Number',
            controller: keyNumberController,
            hintText: 'Key Number',
            focusNode: FocusNode(),
          ),

          const SizedBox(height: 20),
          CustomTextField(
            title: 'Mileage',
            controller: mileageController,
            hintText: 'Mileage',
            focusNode: FocusNode(),
          ),
          
          const SizedBox(height: 20),
          CustomTextField(
            title: 'Remarks',
            controller: remarksController,
            hintText: 'Remarks',
            focusNode: FocusNode(),
          ),

          const SizedBox(height: 20),
          CustomTextField(
            title: 'Number of Seats',
            controller: seatNumberController,
            hintText: 'Number of Seats',
            focusNode: FocusNode(),
          ),

          const SizedBox(height: 20),
          CustomTextField(
            title: 'Front Left in mm',
            controller: frontLeftController,
            hintText: 'Front Left in mm',
            focusNode: FocusNode(),
          ),

          const SizedBox(height: 20),
          CustomTextField(
            title: 'Front Right in mm',
            controller: frontRightController,
            hintText: 'Front Right in mm',
            focusNode: FocusNode(),
          ),

          const SizedBox(height: 20),
          CustomTextField(
            title: 'Rear Left in mm',
            controller: rearLeftController,
            hintText: 'Rear Left in mm',
            focusNode: FocusNode(),
          ),

          const SizedBox(height: 20),
          CustomTextField(
            title: 'Rear Right in mm',
            controller: rearRightController,
            hintText: 'Rear Right in mm',
            focusNode: FocusNode(),
          ),

          const SizedBox(height: 20),
          CustomTextField(
            title: 'Name of Transferor',
            controller: transferorNameController,
            hintText: 'Name of Transferor',
            focusNode: FocusNode(),
          ),

          const SizedBox(height: 20),
          CustomTextField(
            title: 'Email of Transferor',
            controller: transferorEmailController,
            hintText: 'Email of Transferor',
            focusNode: FocusNode(),
          ),
          
          const SizedBox(height: 20),
          buttons(context),
        ],
      ),
    );
  }

  Widget buildAfterJourneyTab(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          TextButton(
          onPressed: _getDateFromUser,
          child: Text('Select Date: ${DateFormat('yyyy-MM-dd').format(selectedDate)}'),
          ),
          CustomTextField(
            title: 'Final Mileage',
            controller: finalMileageController,
            focusNode: FocusNode(),
            hintText: 'Enter final mileage',
          ),
          const SizedBox(height: 20),
          CustomTextField(
            title: 'Final Remarks',
            controller: finalRemarksController,
            focusNode: FocusNode(),
            hintText: 'Enter final remarks',
          ),
          const SizedBox(height: 20),
          TextButton(
              onPressed: () => _getTimeFromUser(isStartTime: false),
              child: Text('End Time: $endTime'),
            ),
          buttons(context),
        ],
      ),
    );
  }

  Widget buttons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: custom_green),
          onPressed: () {
            _validateAndSave(context);
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

  void _validateAndSave(BuildContext context) {
    if (driverNameController.text.isEmpty || vehicleTypeController.text.isEmpty) {
      _showErrorSnackBar(context, 'All fields are required!');
    } else {
      FirestoreDatasource().addContract(
        // Before Journey Data
        vehicleTypeController.text,
        driverNameController.text,
        licensePlateController.text,
        dateController.text,
        startTimeController.text,
        streetController.text,
        plzController.text,
        keyNumberController.text,
        mileageController.text,
        remarksController.text,
        seatNumberController.text,
        frontLeftController.text,
        frontRightController.text,
        rearLeftController.text,
        rearRightController.text,
        transferorNameController.text,
        transferorEmailController.text,
        

        // After Journey Data
        finalMileageController.text,
        finalRemarksController.text,
      );
      Navigator.pop(context);
    }
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
        dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate); // Update the date controller here
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
          startTime = pickedTime.format(context);
          startTimeController.text = startTime; // Update the start time controller here
        } else {
          endTime = pickedTime.format(context);
          // If you have an end time controller, you can update it here
          // endTimeController.text = endTime; // Uncomment if you have an end time controller
        }
      });
    }
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.white,
        content: Row(
          children: [
            const Icon(Icons.warning_amber_rounded, color: Colors.red),
            const SizedBox(width: 12),
            Text(message, style: TextStyle(color: Colors.pink[400])),
          ],
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
