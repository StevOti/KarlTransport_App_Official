import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:karltransportapp/data/firestore.dart';
import 'package:karltransportapp/models/contract_models.dart';
import 'package:karltransportapp/themes/colors.dart';
import 'package:karltransportapp/widgets/custom_text_field.dart';

class EditContractScreen extends StatefulWidget {
  final Contract _contract;

  const EditContractScreen(this._contract, {super.key});

  @override
  State<EditContractScreen> createState() => _EditContractScreenState();
}

class _EditContractScreenState extends State<EditContractScreen> {
  TextEditingController? driverName;
  TextEditingController? vehicleType;
  TextEditingController? licensePlateController;
  TextEditingController? finController;
  TextEditingController? streetController;
  TextEditingController? streetNumberController;
  TextEditingController? plzController;
  TextEditingController? keyNumberController;
  TextEditingController? mileageController;
  TextEditingController? remarksController;
  TextEditingController? seatNumberController;
  TextEditingController? frontLeftController;
  TextEditingController? frontRightController;
  TextEditingController? rearLeftController;
  TextEditingController? rearRightController;
  TextEditingController? transferorNameController;
  TextEditingController? transferorEmailController;
  TextEditingController? startTimeController;
  TextEditingController? endTimeController;
  TextEditingController? dateController;


  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final FocusNode _focusNode4 = FocusNode();
  final FocusNode _focusNode5 = FocusNode();
  final FocusNode _focusNode6 = FocusNode();
  final FocusNode _focusNode7 = FocusNode();
  final FocusNode _focusNode8 = FocusNode();
  final FocusNode _focusNode9 = FocusNode();
  final FocusNode _focusNode10 = FocusNode();
  final FocusNode _focusNode11 = FocusNode();
  final FocusNode _focusNode12 = FocusNode();
  final FocusNode _focusNode13 = FocusNode();
  final FocusNode _focusNode14 = FocusNode();
  final FocusNode _focusNode15 = FocusNode();
  final FocusNode _focusNode16 = FocusNode();
  final FocusNode _focusNode17 = FocusNode();
  final FocusNode _focusNode18 = FocusNode();
  final FocusNode _focusNode19 = FocusNode();
  final FocusNode _focusNode20 = FocusNode();
  final FocusNode _focusNode21 = FocusNode();
  final FocusNode _focusNode22 = FocusNode();

  DateTime selectedDate = DateTime.now();
  String startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 15)))
      .toString();

  int indexx = 0;

  @override
  void initState() {
    super.initState();
    driverName = TextEditingController(text: widget._contract.driverName);
    vehicleType = TextEditingController(text: widget._contract.vehicleType);
    licensePlateController = TextEditingController(text: widget._contract.licensePlate);
    finController = TextEditingController(text: widget._contract.fin);
    streetController = TextEditingController(text: widget._contract.street);
    streetNumberController = TextEditingController(text: widget._contract.streetNumber);
    plzController = TextEditingController(text: widget._contract.plz);
    keyNumberController = TextEditingController(text: widget._contract.keyNumber);
    mileageController = TextEditingController(text: widget._contract.mileage);
    remarksController = TextEditingController(text: widget._contract.remarks);
    seatNumberController = TextEditingController(text: widget._contract.seatNumber);
    frontLeftController = TextEditingController(text: widget._contract.frontLeft);
    frontRightController = TextEditingController(text: widget._contract.frontRight);
    rearLeftController = TextEditingController(text: widget._contract.rearLeft);
    rearRightController = TextEditingController(text: widget._contract.rearRight);
    transferorNameController = TextEditingController(text: widget._contract.transferorName);
    transferorEmailController = TextEditingController(text: widget._contract.transferorEmail);
    startTimeController = TextEditingController(text: widget._contract.startTime);
    endTimeController = TextEditingController(text: widget._contract.endTime);
    dateController = TextEditingController(text: widget._contract.date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0), // Adjust padding as needed
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                CustomTextField(
                  title: 'Date',
                  controller: dateController!,
                  hintText: 'Select Date', // Add a hintText
                  focusNode: _focusNode20, // Add a focusNode
                  widget: IconButton(
                    onPressed: () => _getDateFromUser(),
                    icon: const Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Row(
                    children: [
                      // Start Time Input Field
                      Expanded(
                        child: CustomTextField(
                          focusNode: _focusNode18,
                          controller: startTimeController!,
                          title: 'Start Time',
                          hintText: 'Select Time',
                          widget: IconButton(
                            onPressed: () => _getTimeFromUser(isStartTime: true),
                            icon: const Icon(
                              Icons.access_time_rounded,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      
                      // End Time Input Field
                      Expanded(
                        child: CustomTextField(
                          focusNode: _focusNode19,
                          title: 'End Time',
                          hintText: 'Select Time',
                          controller: endTimeController!,
                          widget: IconButton(
                            onPressed: () => _getTimeFromUser(isStartTime: false),
                            icon: const Icon(
                              Icons.access_time_rounded,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 20),
                CustomTextField(
                  title: 'Driver Name',
                  controller: driverName!,
                  focusNode: _focusNode1,
                  hintText: 'Driver Name',
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  title: 'Vehicle Type',
                  controller: vehicleType!,
                  focusNode: _focusNode2,
                  hintText: 'Vehicle Type',
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  title: 'License Plate',
                  controller: licensePlateController!,
                  hintText: 'License Plate',
                  focusNode: _focusNode3,
                ),
                const SizedBox(height: 30),
                imageSlides(),
                const SizedBox(height: 20),
                CustomTextField(
                  title: 'FIN',
                  controller: finController!,
                  hintText: 'FIN',
                  focusNode: _focusNode4,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  title: 'Street',
                  controller: streetController!,
                  hintText: 'Street',
                  focusNode: _focusNode5,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  title: 'Street Number',
                  controller: streetNumberController!,
                  hintText: 'Street Number',
                  focusNode: _focusNode6,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  title: 'PLZ',
                  controller: plzController!,
                  hintText: 'PLZ',
                  focusNode: _focusNode7,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  title: 'Key Number',
                  controller: keyNumberController!,
                  hintText: 'Key Number',
                  focusNode: _focusNode8,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  title: 'Mileage',
                  controller: mileageController!,
                  hintText: 'Mileage',
                  focusNode: _focusNode9,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  title: 'Remarks',
                  controller: remarksController!,
                  hintText: 'Remarks',
                  focusNode: _focusNode10,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  title: 'Number of Seats',
                  controller: seatNumberController!,
                  hintText: 'Number of Seats',
                  focusNode: _focusNode11,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  title: 'Front Left in mm',
                  controller: frontLeftController!,
                  hintText: 'Front Left in mm',
                  focusNode: _focusNode12,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  title: 'Front Left in mm',
                  controller: frontRightController!,
                  hintText: 'Front Left in mm',
                  focusNode: _focusNode13,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  title: 'Rear Left in mm',
                  controller: rearLeftController!,
                  hintText: 'Rear Left in mm',
                  focusNode: _focusNode14,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  title: 'Rear Right in mm',
                  controller: rearRightController!,
                  hintText: 'Rear Right in mm',
                  focusNode: _focusNode15,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  title: 'Name of Transferor',
                  controller: transferorNameController!,
                  hintText: 'Name of Transferor',
                  focusNode: _focusNode16,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  title: 'Email of Transferor',
                  controller: transferorEmailController!,
                  hintText: 'Email of Transferor',
                  focusNode: _focusNode17,
                ),
                const SizedBox(height: 20),

                buttons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buttons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: custom_green,
            minimumSize: const Size(170, 48),
          ),
          onPressed: () {
            FirestoreDatasource().updateContract(
              widget._contract.id,
              indexx,
              driverName!.text,
              vehicleType!.text,
              licensePlateController!.text,
              finController!.text,
              streetController!.text,
              streetNumberController!.text,
              plzController!.text,
              keyNumberController!.text,
              mileageController!.text,
              remarksController!.text,
              seatNumberController!.text,
              frontLeftController!.text,
              frontRightController!.text,
              rearLeftController!.text,
              rearRightController!.text,
              transferorNameController!.text,
              transferorEmailController!.text,
              startTimeController!.text,
              endTimeController!.text,
              dateController!.text,
            );
            Navigator.pop(context);
          },
          child: const Text('Save'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            minimumSize: const Size(170, 48),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }

  Widget imageSlides() {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        itemCount: 6,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                indexx = index;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 2,
                  color: indexx == index ? custom_green : Colors.grey,
                ),
              ),
              width: 140,
              margin: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Image.asset('images/$index.png'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }


// Function to pick a date from the date picker
_getDateFromUser() async {
  DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015),
      lastDate: DateTime(2121));

  if (pickedDate != null && pickedDate != selectedDate) {
    setState(() {
      selectedDate = pickedDate;
      dateController?.text = DateFormat('yyyy-MM-dd').format(selectedDate); // Format date and set in controller
    });
  }
}

// Function to get time from the user, either for Start Time or End Time
_getTimeFromUser({required bool isStartTime}) async {
  var pickedTime = await _showTimePicker(isStartTime: isStartTime);

  if (pickedTime != null) {
    String formattedTime = pickedTime.format(context);

    setState(() {
      if (isStartTime) {
        startTime = formattedTime;
        startTimeController?.text = startTime; // Set start time in controller
      } else {
        endTime = formattedTime;
        endTimeController?.text = endTime; // Set end time in controller
      }
    });
  }
}


// Show the time picker
_showTimePicker({required bool isStartTime}) {
  TimeOfDay initialTime = TimeOfDay.now(); // Default to current time

  // Set initialTime based on whether it's for start time or end time
  if (isStartTime && startTime.isNotEmpty) {
    initialTime = TimeOfDay(
      hour: int.parse(startTime.split(':')[0]),
      minute: int.parse(startTime.split(':')[1].split(' ')[0]),
    );
  } else if (!isStartTime && endTime.isNotEmpty) {
    initialTime = TimeOfDay(
      hour: int.parse(endTime.split(':')[0]),
      minute: int.parse(endTime.split(':')[1].split(' ')[0]),
    );
  }

  return showTimePicker(
    initialEntryMode: TimePickerEntryMode.input,
    context: context,
    initialTime: initialTime,
  );
}
}
