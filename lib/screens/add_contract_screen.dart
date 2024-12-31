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

class _AddContractScreenState extends State<AddContractScreen> {
  final driverNameController = TextEditingController();
  final vehicleTypeController = TextEditingController();
  final licensePlateController = TextEditingController();
  final finController = TextEditingController();
  final streetController = TextEditingController();
  final streetNumberController = TextEditingController();
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
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();
  final dateController = TextEditingController();

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

  int indexx = 0;

  DateTime selectedDate = DateTime.now();
  String startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 15)))
      .toString();

  void _validateAndSave(BuildContext context) {
    // Check if required fields are empty
    if (
        driverNameController.text.isEmpty ||
        vehicleTypeController.text.isEmpty ||
        licensePlateController.text.isEmpty ||
        finController.text.isEmpty ||
        streetController.text.isEmpty ||
        streetNumberController.text.isEmpty ||
        plzController.text.isEmpty ||
        keyNumberController.text.isEmpty ||
        mileageController.text.isEmpty ||
        remarksController.text.isEmpty ||
        seatNumberController.text.isEmpty ||
        frontLeftController.text.isEmpty ||
        frontRightController.text.isEmpty ||
        rearLeftController.text.isEmpty ||
        rearRightController.text.isEmpty ||
        transferorNameController.text.isEmpty ||
        transferorEmailController.text.isEmpty ||
        startTimeController.text.isEmpty ||
        endTimeController.text.isEmpty ||
        dateController.text.isEmpty
      ) {
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.white,
          content: Row(
            children: [
              const Icon(
                Icons.warning_amber_rounded,
                color: Colors.red,
              ),
              const SizedBox(width: 12),
              Text(
                'All fields are required!',
                style: TextStyle(color: Colors.pink[400]),
              ),
            ],
          ),
          duration: const Duration(seconds: 3),
        ),
      );
    } else {
      // If all required fields are filled, proceed with saving
      FirestoreDatasource().addContract(
        vehicleTypeController.text,
        driverNameController.text,
        indexx,
        licensePlateController.text,
        finController.text,
        streetController.text,
        streetNumberController.text,
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
        startTimeController.text,
        endTimeController.text,
        dateController.text,
      );
      Navigator.pop(context);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                CustomTextField(
                  title: 'Date',
                  controller: dateController,
                  hintText: 'Select Date',
                  focusNode: _focusNode20,
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
                    Expanded(
                      child: CustomTextField(
                        focusNode: _focusNode18,
                        controller: startTimeController,
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
                    Expanded(
                      child: CustomTextField(
                        focusNode: _focusNode19,
                        title: 'End Time',
                        hintText: 'Select Time',
                        controller: endTimeController,
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
                CustomTextField(
                  title: 'Driver Name',
                  controller: driverNameController,
                  hintText: 'Driver Name',
                  focusNode: _focusNode1,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  title: 'Vehicle Type',
                  controller: vehicleTypeController,
                  hintText: 'Vehicle Type',
                  focusNode: _focusNode2,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  title: 'License Plate',
                  controller: licensePlateController,
                  hintText: 'License Plate',
                  focusNode: _focusNode3,
                ),
                const SizedBox(height: 30),
                imageSlides(),
                const SizedBox(height: 20),
                CustomTextField(
                  title: 'FIN',
                  controller: finController,
                  hintText: 'FIN',
                  focusNode: _focusNode4,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  title: 'Street',
                  controller: streetController,
                  hintText: 'Street',
                  focusNode: _focusNode5,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  title: 'Street Number',
                  controller: streetNumberController,
                  hintText: 'Street Number',
                  focusNode: _focusNode6,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  title: 'PLZ',
                  controller: plzController,
                  hintText: 'PLZ',
                  focusNode: _focusNode7,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  title: 'Key Number',
                  controller: keyNumberController,
                  hintText: 'Key Number',
                  focusNode: _focusNode8,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  title: 'Mileage',
                  controller: mileageController,
                  hintText: 'Mileage',
                  focusNode: _focusNode9,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  title: 'Remarks',
                  controller: remarksController,
                  hintText: 'Remarks',
                  focusNode: _focusNode10,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  title: 'Number of Seats',
                  controller: seatNumberController,
                  hintText: 'Number of Seats',
                  focusNode: _focusNode11,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  title: 'Front Left in mm',
                  controller: frontLeftController,
                  hintText: 'Front Left in mm',
                  focusNode: _focusNode12,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  title: 'Front Right in mm',
                  controller: frontRightController,
                  hintText: 'Front Right in mm',
                  focusNode: _focusNode13,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  title: 'Rear Left in mm',
                  controller: rearLeftController,
                  hintText: 'Rear Left in mm',
                  focusNode: _focusNode14,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  title: 'Rear Right in mm',
                  controller: rearRightController,
                  hintText: 'Rear Right in mm',
                  focusNode: _focusNode15,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  title: 'Name of Transferor',
                  controller: transferorNameController,
                  hintText: 'Name of Transferor',
                  focusNode: _focusNode16,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  title: 'Email of Transferor',
                  controller: transferorEmailController,
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
              backgroundColor: custom_green, minimumSize: const Size(170, 48)),
          onPressed: () => _validateAndSave(context),
          child: const Text('Save'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red, minimumSize: const Size(170, 48)),
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
                  )),
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

  _getDateFromUser() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2121));

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
        dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
      });
    }
  }

  _getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker(isStartTime: isStartTime);

    if (pickedTime != null) {
      String formattedTime = pickedTime.format(context);

      setState(() {
        if (isStartTime) {
          startTime = formattedTime;
          startTimeController.text = startTime;
        } else {
          endTime = formattedTime;
          endTimeController.text = endTime;
        }
      });
    }
  }

  _showTimePicker({required bool isStartTime}) {
    TimeOfDay initialTime = TimeOfDay.now();

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