import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:karltransportapp/components/image_pdf_api.dart';
import 'package:karltransportapp/components/save_and_open_pdf.dart';
import 'package:karltransportapp/components/simple_pdf_api.dart';
import 'package:karltransportapp/data/firestore.dart';
import 'package:karltransportapp/data/storage_service.dart';
import 'package:karltransportapp/themes/colors.dart';
import 'package:karltransportapp/widgets/custom_text_field.dart';
import 'package:karltransportapp/widgets/signature.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:signature/signature.dart';



class AddContractScreen extends StatefulWidget {
  const AddContractScreen({super.key});

  @override
  State<AddContractScreen> createState() => _AddContractScreenState();
}

class _AddContractScreenState extends State<AddContractScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late SignatureController signatureController;

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

  


  final List<String> _functionalChecks = ["Darkeness", "Rain", "Snow/Ice", "Dirty Outside", "Dirty Inside"];
  final List<bool> _functionalCheckValues = List.filled(5, false);

  final List<String> _carAccessories = ["Vehicle Registration Document", "Warning Triangle", "First Aid Kit", "Service Plan","Safety Vest", "Vehicle Manual", "Trunk Cover", "FB Auxiliary heating", "Tyre Fit", "Reserve Tyre", "Navigation", "SD/DVD", "On-Board Tools", "Car Mats", "Antenna", "Ash Tray"];
  final List<bool> _carAccessoriesValues = List.filled(16, false);

  final List<String> _extraFunctionalChecks = ["Oil level", "Wiper Water"];
  final List<bool> _extraFunctionalCheckValues = List.filled(2, false);

  final List<String> _tankLevel = ["Quarter", "Half", "Three Quarters", "Full-tank"];
  final List<bool> _tankLevelValues = List.filled(4, false);

  final List<String> _comments = ["Scratches", "Rock chips", "Dents", "Other Damages"];
  final List<bool> _commentValues = List.filled(4, false);

  final List<String> _tyreChange = ["Yes", "No"];
  final List<bool> _tyreChangeValues = List.filled(2, false);

  final List<String> _insideDamage = ["Front Seats", "Interior Panelling", "Headlining", "Fittings", "Rear seats", "Carpets", "Trunk", "Contamination"];
  final List<bool> _insideDamageValues = List.filled(8, false);

  final List<String> _smokyVehicle = ["Yes", "No"];
  final List<bool> _smokyVehicleValues = List.filled(2, false);

  final List<String> _tyreTypes = ["Sommerreifen", "Ganzjahresreifen", "Winterreifen"];
  final List<bool> _tyreTypeValues = List.filled(3, false);


  // After Journey Controllers
  final endDateController = TextEditingController();
  final endTimeController = TextEditingController();
  final endStreetController = TextEditingController();
  final endStreetNoController = TextEditingController();
  final endPlzController = TextEditingController();
  final endCityController = TextEditingController();
  final endKeyNoController = TextEditingController();
  final endMileageController = TextEditingController();
  final transfereeNameController = TextEditingController();
  final transfereeMailController = TextEditingController();
  final transfereeStreetController = TextEditingController();
  final transfereeHouseNoController = TextEditingController();
  final transfereePlzController = TextEditingController();
  final transfereeCityController = TextEditingController();
  final transfereeLandController = TextEditingController();
  final transfereeDobController = TextEditingController();
  final transfereeIdController = TextEditingController();
  final transfereeIdValidityController = TextEditingController();

  String contractId = DateTime.now().millisecondsSinceEpoch.toString();

  DateTime selectedDate = DateTime.now();
  String startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String endTime = DateFormat('hh:mm a').format(DateTime.now().add(const Duration(minutes: 15))).toString();

  @override
void initState() {
  super.initState();
  _tabController = TabController(length: 2, vsync: this);

  // Initialize the signature controller
    signatureController = SignatureController(
      penStrokeWidth: 5,
      penColor: Colors.black,
      exportBackgroundColor: Colors.white,
    );
  
  // Add this
  fetchAllImages();
}

// Add this method
Future<void> fetchAllImages() async {
  final storageService = Provider.of<StorageService>(context, listen: false);
  await Future.wait([
    storageService.fetchImages('functional_check_images'),
    storageService.fetchImages('extra_check_images'),
    storageService.fetchImages('inside_damage_images'),
    storageService.fetchImages('comment_images'),
  ]);
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
    endDateController.dispose();
    endTimeController.dispose();
    endStreetController.dispose();
    endStreetNoController.dispose();
    endPlzController.dispose();
    endCityController.dispose();
    endKeyNoController.dispose();
    endMileageController.dispose();
    transfereeNameController.dispose();
    transfereeMailController.dispose();
    transfereeStreetController.dispose();
    transfereeHouseNoController.dispose();
    transfereePlzController.dispose();
    transfereeCityController.dispose();
    transfereeLandController.dispose();
    transfereeDobController.dispose();
    transfereeIdController.dispose();
    transfereeIdValidityController.dispose();

    // Add this to your dispose method
    signatureController.dispose();


    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF17203A),
        title: const Text(
          'Add Contract',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          tabs: const [
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.departure_board, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    'Before Journey', 
                    style: TextStyle(fontSize: 16),
                    selectionColor: Colors.white,
                  ),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.access_time_filled_rounded, color: Colors.white),
                  SizedBox(width: 8),
                  Text('After Journey', style: TextStyle(fontSize: 16), selectionColor: Colors.white,),
                ],
              ),
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
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              'Basic Information',
              [
                _buildInputPair(
                  CustomTextField(
                    title: 'Date',
                    controller: dateController,
                    hintText: 'Select Date',
                    focusNode: FocusNode(),
                    widget: IconButton(
                      onPressed: () async => await _getDateFromUser(isAfterJourney: false),
                      icon: const Icon(Icons.calendar_today_outlined, color: Colors.grey),
                    ),
                  ),
                  CustomTextField(
                    focusNode: FocusNode(),
                    controller: startTimeController,
                    title: 'Start Time',
                    hintText: 'Select Time',
                    widget: IconButton(
                      onPressed: () async => await _getTimeFromUser(isStartTime: true, isAfterJourney: false),
                      icon: const Icon(Icons.access_time_rounded, color: Colors.grey),
                    ),
                  ),
                ),
                _buildInputPair(
                  CustomTextField(
                    title: 'Driver Name',
                    controller: driverNameController,
                    focusNode: FocusNode(),
                    hintText: 'Enter driver name',
                  ),
                  CustomTextField(
                    title: 'Vehicle Type',
                    controller: vehicleTypeController,
                    focusNode: FocusNode(),
                    hintText: 'Enter vehicle type',
                  ),
                ),
              ],
            ),

            // Continue in buildBeforeJourneyTab after the Basic Information section:
  
            _buildSection(
              'Vehicle Details',
              [
                _buildInputPair(
                  CustomTextField(
                    title: 'License Plate',
                    controller: licensePlateController,
                    focusNode: FocusNode(),
                    hintText: 'Enter license plate',
                  ),
                  CustomTextField(
                    title: 'Key Number',
                    controller: keyNumberController,
                    focusNode: FocusNode(),
                    hintText: 'Key Number',
                  ),
                ),
                _buildInputPair(
                  CustomTextField(
                    title: 'Street',
                    controller: streetController,
                    hintText: 'Street',
                    focusNode: FocusNode(),
                  ),
                  CustomTextField(
                    title: 'PLZ',
                    controller: plzController,
                    hintText: 'PLZ',
                    focusNode: FocusNode(),
                  ),
                ),
                _buildInputPair(
                  CustomTextField(
                    title: 'Mileage',
                    controller: mileageController,
                    hintText: 'Mileage',
                    focusNode: FocusNode(),
                  ),
                  CustomTextField(
                    title: 'Number of Seats',
                    controller: seatNumberController,
                    hintText: 'Number of Seats',
                    focusNode: FocusNode(),
                  ),
                ),
              ],
            ),

            _buildSection(
              'Tire Measurements (mm)',
              [
                _buildInputPair(
                  CustomTextField(
                    title: 'Front Left',
                    controller: frontLeftController,
                    hintText: 'Front Left in mm',
                    focusNode: FocusNode(),
                  ),
                  CustomTextField(
                    title: 'Front Right',
                    controller: frontRightController,
                    hintText: 'Front Right in mm',
                    focusNode: FocusNode(),
                  ),
                ),
                _buildInputPair(
                  CustomTextField(
                    title: 'Rear Left',
                    controller: rearLeftController,
                    hintText: 'Rear Left in mm',
                    focusNode: FocusNode(),
                  ),
                  CustomTextField(
                    title: 'Rear Right',
                    controller: rearRightController,
                    hintText: 'Rear Right in mm',
                    focusNode: FocusNode(),
                  ),
                ),
              ],
            ),

            _buildSection(
              'Transferor Information',
              [
                _buildInputPair(
                  CustomTextField(
                    title: 'Name',
                    controller: transferorNameController,
                    hintText: 'Name of Transferor',
                    focusNode: FocusNode(),
                  ),
                  CustomTextField(
                    title: 'Email',
                    controller: transferorEmailController,
                    hintText: 'Email of Transferor',
                    focusNode: FocusNode(),
                  ),
                ),
                CustomTextField(
                  title: 'Remarks',
                  controller: remarksController,
                  hintText: 'Additional remarks',
                  focusNode: FocusNode(),
                  // maxLines: 3,
                ),
              ],
            ),

            _buildChecklistSection(
              'Vehicle Condition',
              [
                _buildChecklistGroup(
                  'Functional Checks',
                  _functionalChecks,
                  _functionalCheckValues,
                  'functional_check_images',
                ),
                _buildChecklistGroup(
                  'Car Accessories',
                  _carAccessories,
                  _carAccessoriesValues,
                  null,
                ),
                _buildChecklistGroup(
                  'Extra Functional Checks',
                  _extraFunctionalChecks,
                  _extraFunctionalCheckValues,
                  'extra_check_images',
                ),

                _buildChecklistGroup(
                  'Extra Functional Checks',
                  _insideDamage,
                  _insideDamageValues,
                  'extra_check_images',
                ),

                _buildChecklistGroupTwo(
                  'Tank Level',
                  _tankLevel,
                  _tankLevelValues,
                  'Tank Level',
                ),

                _buildChecklistGroupTwo(
                  'Comments',
                  _comments,
                  _commentValues,
                  'Comments'

                ),

                _buildChecklistGroupTwo(
                  'Comments',
                  _comments,
                  _commentValues,
                  'Comments'

                ),

                _buildChecklistGroupTwo(
                  'Did a tyre change happed during the journey?',
                  _tyreChange,
                  _tyreChangeValues,
                  'Did a tyre change happed during the journey?'

                ), 

                _buildChecklistGroupTwo(
                  'Is the vehicle smoky?',
                  _smokyVehicle,
                  _smokyVehicleValues,
                  'Did a tyre change happed during the journey?'

                ),

                _buildChecklistGroupTwo(
                  'Is the vehicle smoky?',
                  _tyreTypes,
                  _tyreTypeValues,
                  'Is the vehicle smoky?'

                ),



                _buildSection(
                  'Signature',
                  [
                    const Text(
                      'Please sign below',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: SignaturePad(
                        controller: signatureController,
                        height: 200,
                        width: double.infinity,
                        backgroundColor: Colors.white,
                        contractId: contractId,
                      ),
                    ),
                  ],
                ),

                _buildSection(
                  'Actions',
                  [
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: custom_green,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            icon: const Icon(Icons.save),
                            label: const Text('Save Contract'),
                            onPressed: () => _validateAndSave(context),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            icon: const Icon(Icons.cancel),
                            label: const Text('Cancel'),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            icon: const Icon(Icons.share),
                            label: const Text('Share as PDF'),
                            onPressed: () async {
                              // Your existing PDF sharing logic
                              

                              if (driverNameController.text.isNotEmpty && 
                                  vehicleTypeController.text.isNotEmpty) {
                                try {
                                  // Prepare contract data for PDF
                                  final contractData = {
                                    // Before Journey Data
                                    'Vehicle Type': vehicleTypeController.text,
                                    'Driver Name': driverNameController.text,
                                    'License Plate': licensePlateController.text,
                                    'Date': dateController.text,
                                    'Start Time': startTimeController.text,
                                    'Street': streetController.text,
                                    'PLZ': plzController.text,
                                    'Key Number': keyNumberController.text,
                                    'Mileage': mileageController.text,
                                    'Remarks': remarksController.text,
                                    'Seat Number': seatNumberController.text,
                                    'Front Left Tire': frontLeftController.text,
                                    'Front Right Tire': frontRightController.text,
                                    'Rear Left Tire': rearLeftController.text,
                                    'Rear Right Tire': rearRightController.text,
                                    'Transferor Name': transferorNameController.text,
                                    'Transferor Email': transferorEmailController.text,
                                    'Functional Checks': _functionalCheckValues.toString(),
                                    'Car Accessories': _carAccessoriesValues.toString(),
                                    'Extra Functional Checks': _extraFunctionalCheckValues.toString(),
                                    'Tank Level': _tankLevelValues.toString(),
                                    'Comments': _commentValues.toString(),
                                    'Tyre Change': _tyreChangeValues.toString(),
                                    'Inside Damage': _insideDamageValues.toString(),
                                    'Smoky Vehicle': _smokyVehicleValues.toString(),
                                    'Tyre Type': _tyreTypeValues.toString(),

                                    // After Journey Data
                                    'End Date': endDateController.text,
                                    'End Time': endTimeController.text,
                                    'End Street': endStreetController.text,
                                    'End Street No': endStreetNoController.text,
                                    'End PLZ': endPlzController.text,
                                    'End City': endCityController.text,
                                    'End Key No': endKeyNoController.text,
                                    'End Mileage': endMileageController.text,
                                    'Transferee Name': transfereeNameController.text,
                                    'Transferee Email': transfereeMailController.text,
                                    'Transferee Street': transfereeStreetController.text,
                                    'Transferee House No': transfereeHouseNoController.text,
                                    'Transferee PLZ': transfereePlzController.text,
                                    'Transferee City': transfereeCityController.text,
                                    'Transferee Land': transfereeLandController.text,
                                    'Transferee DOB': transfereeDobController.text,
                                    'Transferee ID': transfereeIdController.text,
                                    'Transferee ID Validity': transfereeIdValidityController.text,
                                  };

                                  // Generate PDF
                                  final pdfFile = await SimplePdfApi.generateContractPdf(contractData);

                                  // Share the generated PDF
                                  await Share.shareXFiles(
                                    [XFile(pdfFile.path)],
                                    subject: 'Vehicle Contract',
                                    text: 'Please find the attached vehicle contract document.',
                                  );

                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Error generating PDF: ${e.toString()}'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              } else {
                                _showErrorSnackBar(context, 'All fields are required!');
                              }
                            }, 
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            icon: const Icon(Icons.image),
                            label: const Text('Share Images'),
                            onPressed: () async {
                              try {
                                // Provide a valid image path
                                const imagePath = 'assets/images/sample_image.jpg'; // Update this to your actual image path

                                // Generate the image-based PDF
                                final imagePdf = await ImagePdfApi.generateImagePdf(imagePath);

                                // Open the generated PDF
                                await SaveAndOpenDocument.openPdf(imagePdf);
                              } catch (e) {
                                // Show an error message in case of failure
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Error generating or sharing PDF: $e'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            },
                          ),
                        ),

                      ],
                    ),
                  ],
                ),

                
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF17203A),
            ),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInputPair(Widget input1, Widget input2) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: input1),
          const SizedBox(width: 16),
          Expanded(child: input2),
        ],
      ),
    );
  }

  

  // Add helper methods for building checklist sections
  Widget _buildChecklistSection(String title, List<Widget> groups) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF17203A),
            ),
          ),
          const SizedBox(height: 16),
          ...groups,
        ],
      ),
    );
  }

  Widget _buildChecklistGroup(
    String title,
    List<String> items,
    List<bool> values,
    String? imageFolderPath,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 0,
          children: List.generate(
            items.length,
            (index) => SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: CheckboxListTile(
                title: Text(
                  items[index],
                  style: const TextStyle(fontSize: 14),
                ),
                value: values[index],
                onChanged: (bool? value) {
                  setState(() {
                    values[index] = value!;
                  });
                },
                dense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ),
        if (imageFolderPath != null) ...[
          const SizedBox(height: 8),
          _buildImageSection(
            'Documentation',
            imageFolderPath,
            Provider.of<StorageService>(context, listen: false),
          ),
        ],
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildChecklistGroupTwo(
    String title,
    List<String> items,
    List<bool> values,
    String? imageFolderPath,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 0,
          children: List.generate(
            items.length,
            (index) => SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: CheckboxListTile(
                title: Text(
                  items[index],
                  style: const TextStyle(fontSize: 14),
                ),
                value: values[index],
                onChanged: (bool? value) {
                  setState(() {
                    values[index] = value!;
                  });
                },
                dense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ),
        // if (imageFolderPath != null) ...[
        //   const SizedBox(height: 8),
        //   _buildImageSection(
        //     'Documentation',
        //     imageFolderPath,
        //     Provider.of<StorageService>(context, listen: false),
        //   ),
        // ],
        const SizedBox(height: 16),
      ],
    );
  }

  Widget buildAfterJourneyTab(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              'Journey Completion Details',
              [
                _buildInputPair(
                  CustomTextField(
                    title: 'End Date',
                    controller: endDateController,
                    hintText: 'Select Date',
                    focusNode: FocusNode(),
                    widget: IconButton(
                      onPressed: () async => await _getDateFromUser(isAfterJourney: true),
                      icon: const Icon(Icons.calendar_today_outlined, color: Colors.grey),
                    ),
                  ),
                  CustomTextField(
                    focusNode: FocusNode(),
                    controller: endTimeController,
                    title: 'End Time',
                    hintText: 'Select Time',
                    widget: IconButton(
                      onPressed: () async => await _getTimeFromUser(isStartTime: false, isAfterJourney: true),
                      icon: const Icon(Icons.access_time_rounded, color: Colors.grey),
                    ),
                  ),
                ),
                _buildInputPair(
                  CustomTextField(
                    title: 'End Mileage',
                    controller: endMileageController,
                    hintText: 'Final Mileage',
                    focusNode: FocusNode(),
                  ),
                  CustomTextField(
                    title: 'End Key Number',
                    controller: endKeyNoController,
                    hintText: 'Key Number',
                    focusNode: FocusNode(),
                  ),
                ),
              ],
            ),

            _buildSection(
              'Return Location',
              [
                _buildInputPair(
                  CustomTextField(
                    title: 'Street',
                    controller: endStreetController,
                    hintText: 'Street Name',
                    focusNode: FocusNode(),
                  ),
                  CustomTextField(
                    title: 'Street Number',
                    controller: endStreetNoController,
                    hintText: 'Street Number',
                    focusNode: FocusNode(),
                  ),
                ),
                _buildInputPair(
                  CustomTextField(
                    title: 'PLZ',
                    controller: endPlzController,
                    hintText: 'Postal Code',
                    focusNode: FocusNode(),
                  ),
                  CustomTextField(
                    title: 'City',
                    controller: endCityController,
                    hintText: 'City Name',
                    focusNode: FocusNode(),
                  ),
                ),
              ],
            ),

            _buildSection(
              'Transferee Information',
              [
                _buildInputPair(
                  CustomTextField(
                    title: 'Full Name',
                    controller: transfereeNameController,
                    hintText: 'Full Name',
                    focusNode: FocusNode(),
                  ),
                  CustomTextField(
                    title: 'Email',
                    controller: transfereeMailController,
                    hintText: 'Email Address',
                    focusNode: FocusNode(),
                  ),
                ),
                _buildInputPair(
                  CustomTextField(
                    title: 'Street',
                    controller: transfereeStreetController,
                    hintText: 'Street Name',
                    focusNode: FocusNode(),
                  ),
                  CustomTextField(
                    title: 'House Number',
                    controller: transfereeHouseNoController,
                    hintText: 'House Number',
                    focusNode: FocusNode(),
                  ),
                ),
                _buildInputPair(
                  CustomTextField(
                    title: 'PLZ',
                    controller: transfereePlzController,
                    hintText: 'Postal Code',
                    focusNode: FocusNode(),
                  ),
                  CustomTextField(
                    title: 'City',
                    controller: transfereeCityController,
                    hintText: 'City Name',
                    focusNode: FocusNode(),
                  ),
                ),
                _buildInputPair(
                  CustomTextField(
                    title: 'Country',
                    controller: transfereeLandController,
                    hintText: 'Country',
                    focusNode: FocusNode(),
                  ),
                  CustomTextField(
                    title: 'Date of Birth',
                    controller: transfereeDobController,
                    hintText: 'Date of Birth',
                    focusNode: FocusNode(),
                  ),
                ),
                _buildInputPair(
                  CustomTextField(
                    title: 'ID Number',
                    controller: transfereeIdController,
                    hintText: 'ID Number',
                    focusNode: FocusNode(),
                  ),
                  CustomTextField(
                    title: 'ID Validity',
                    controller: transfereeIdValidityController,
                    hintText: 'ID Validity Date',
                    focusNode: FocusNode(),
                  ),
                ),
              ],
            ),

            _buildSection(
              'Signature',
              [
                const Text(
                  'Please sign below',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SignaturePad(
                    controller: signatureController,
                    height: 200,
                    width: double.infinity,
                    backgroundColor: Colors.white,
                    contractId: contractId,
                  ),
                ),
              ],
            ),

            _buildSection(
              'Actions',
              [
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: custom_green,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        icon: const Icon(Icons.save),
                        label: const Text('Save Contract'),
                        onPressed: () => _validateAndSave(context),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        icon: const Icon(Icons.cancel),
                        label: const Text('Cancel'),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        icon: const Icon(Icons.share),
                        label: const Text('Share as PDF'),
                        onPressed: () async {
                          // Your existing PDF sharing logic
                          if (vehicleTypeController.text.isEmpty &&
                              driverNameController.text.isEmpty &&
                              licensePlateController.text.isEmpty &&
                              dateController.text.isEmpty &&
                              startTimeController.text.isEmpty &&
                              streetController.text.isEmpty &&
                              plzController.text.isEmpty &&
                              keyNumberController.text.isEmpty &&
                              mileageController.text.isEmpty &&
                              remarksController.text.isEmpty &&
                              seatNumberController.text.isEmpty &&
                              frontLeftController.text.isEmpty &&
                              frontRightController.text.isEmpty &&
                              rearLeftController.text.isEmpty &&
                              rearRightController.text.isEmpty &&
                              transferorNameController.text.isEmpty &&
                              transferorEmailController.text.isEmpty &&
                              endDateController.text.isEmpty &&
                              endTimeController.text.isEmpty &&
                              endStreetController.text.isEmpty &&
                              endStreetNoController.text.isEmpty &&
                              endPlzController.text.isEmpty &&
                              endCityController.text.isEmpty &&
                              endKeyNoController.text.isEmpty &&
                              endMileageController.text.isEmpty &&
                              transfereeNameController.text.isEmpty &&
                              transfereeMailController.text.isEmpty &&
                              transfereeStreetController.text.isEmpty &&
                              transfereeHouseNoController.text.isEmpty &&
                              transfereePlzController.text.isEmpty &&
                              transfereeCityController.text.isEmpty &&
                              transfereeLandController.text.isEmpty &&
                              transfereeDobController.text.isEmpty &&
                              transfereeIdController.text.isEmpty &&
                              transfereeIdValidityController.text.isEmpty
                            ) {
                            try {
                              // Prepare contract data for PDF
                              final contractData = {
                                // Before Journey Data
                                'Vehicle Type': vehicleTypeController.text,
                                'Driver Name': driverNameController.text,
                                'License Plate': licensePlateController.text,
                                'Date': dateController.text,
                                'Start Time': startTimeController.text,
                                'Street': streetController.text,
                                'PLZ': plzController.text,
                                'Key Number': keyNumberController.text,
                                'Mileage': mileageController.text,
                                'Remarks': remarksController.text,
                                'Seat Number': seatNumberController.text,
                                'Front Left Tire': frontLeftController.text,
                                'Front Right Tire': frontRightController.text,
                                'Rear Left Tire': rearLeftController.text,
                                'Rear Right Tire': rearRightController.text,
                                'Transferor Name': transferorNameController.text,
                                'Transferor Email': transferorEmailController.text,
                                'Functional Checks': _functionalCheckValues.toString(),
                                'Car Accessories': _carAccessoriesValues.toString(),
                                'Extra Functional Checks': _extraFunctionalCheckValues.toString(),
                                'Tank Level': _tankLevelValues.toString(),
                                'Comments': _commentValues.toString(),
                                'Tyre Change': _tyreChangeValues.toString(),
                                'Inside Damage': _insideDamageValues.toString(),
                                'Smoky Vehicle': _smokyVehicleValues.toString(),
                                'Tyre Type': _tyreTypeValues.toString(),

                                // After Journey Data
                                'End Date': endDateController.text,
                                'End Time': endTimeController.text,
                                'End Street': endStreetController.text,
                                'End Street No': endStreetNoController.text,
                                'End PLZ': endPlzController.text,
                                'End City': endCityController.text,
                                'End Key No': endKeyNoController.text,
                                'End Mileage': endMileageController.text,
                                'Transferee Name': transfereeNameController.text,
                                'Transferee Email': transfereeMailController.text,
                                'Transferee Street': transfereeStreetController.text,
                                'Transferee House No': transfereeHouseNoController.text,
                                'Transferee PLZ': transfereePlzController.text,
                                'Transferee City': transfereeCityController.text,
                                'Transferee Land': transfereeLandController.text,
                                'Transferee DOB': transfereeDobController.text,
                                'Transferee ID': transfereeIdController.text,
                                'Transferee ID Validity': transfereeIdValidityController.text,
                              };

                              // Generate PDF
                              final pdfFile = await SimplePdfApi.generateContractPdf(contractData);

                              // Share the generated PDF
                              await Share.shareXFiles(
                                [XFile(pdfFile.path)],
                                subject: 'Vehicle Contract',
                                text: 'Please find the attached vehicle contract document.',
                              );

                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Error generating PDF: ${e.toString()}'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          } else {
                            _showErrorSnackBar(context, 'All fields are required!');
                          }
                        }, 
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        icon: const Icon(Icons.image),
                        label: const Text('Share Images'),
                        onPressed: () async {
                          try {
                            // Provide a valid image path
                            const imagePath = 'assets/images/sample_image.jpg'; // Update this to your actual image path

                            // Generate the image-based PDF
                            final imagePdf = await ImagePdfApi.generateImagePdf(imagePath);

                            // Open the generated PDF
                            await SaveAndOpenDocument.openPdf(imagePdf);
                          } catch (e) {
                            // Show an error message in case of failure
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Error generating or sharing PDF: $e'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                      ),
                    ),

                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection(String title, String folderPath, StorageService storageService) {
  // Filter images for this specific section
  final sectionImages = storageService.imagesUrls
      .where((url) => url.contains(folderPath))
      .toList();

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          IconButton(
            onPressed: () => storageService.uploadImage(folderPath),
            icon: const Icon(Icons.add_a_photo),
          ),
        ],
      ),
      SizedBox(
        height: 120,
        child: sectionImages.isEmpty
            ? const Center(
                child: Text('No images yet. Tap + to add images.'),
              )
            : ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: sectionImages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        Image.network(
                          sectionImages[index],
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: 20,
                            ),
                            onPressed: () =>
                                storageService.deleteImageS(sectionImages[index]),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
        ),
    ],
  );
}

Future<void> _validateAndSave(BuildContext context) async {
  if (
    vehicleTypeController.text.isEmpty ||
    driverNameController.text.isEmpty ||
    licensePlateController.text.isEmpty ||
    dateController.text.isEmpty ||
    startTimeController.text.isEmpty ||
    streetController.text.isEmpty ||
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
    endDateController.text.isEmpty ||
    endTimeController.text.isEmpty ||
    endStreetController.text.isEmpty ||
    endStreetNoController.text.isEmpty ||
    endPlzController.text.isEmpty ||
    endCityController.text.isEmpty ||
    endKeyNoController.text.isEmpty ||
    endMileageController.text.isEmpty ||
    transfereeNameController.text.isEmpty ||
    transfereeMailController.text.isEmpty ||
    transfereeStreetController.text.isEmpty ||
    transfereeHouseNoController.text.isEmpty ||
    transfereePlzController.text.isEmpty ||
    transfereeCityController.text.isEmpty ||
    transfereeLandController.text.isEmpty ||
    transfereeDobController.text.isEmpty ||
    transfereeIdController.text.isEmpty ||
    transfereeIdValidityController.text.isEmpty
  ) {
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
      _functionalCheckValues,
      _carAccessoriesValues,
      _extraFunctionalCheckValues,
      _tankLevelValues,
      _commentValues,
      _tyreChangeValues,
      _insideDamageValues,
      _smokyVehicleValues,
      _tyreTypeValues,

      // After Journey Data
      endDateController.text,
      endTimeController.text,
      endStreetController.text,
      endStreetNoController.text,
      endPlzController.text,
      endCityController.text,
      endKeyNoController.text,
      endMileageController.text,
      transfereeNameController.text,
      transfereeMailController.text,
      transfereeStreetController.text,
      transfereeHouseNoController.text,
      transfereePlzController.text,
      transfereeCityController.text,
      transfereeLandController.text,
      transfereeDobController.text,
      transfereeIdController.text,
      transfereeIdValidityController.text,
    );
    Navigator.pop(context);
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

    Future<void> _getDateFromUser ({required bool isAfterJourney}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015),
      lastDate: DateTime(2121),
    );
    setState(() {
      selectedDate = pickedDate!;
      if (isAfterJourney) {
        endDateController.text = DateFormat('yyyy-MM-dd').format(selectedDate); // Update the end date controller
      } else {
        dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate); // Update the date controller
      }
    });
    }

  Future<void> _getTimeFromUser ({required bool isStartTime, required bool isAfterJourney}) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        if (isAfterJourney) {
          endTime = pickedTime.format(context);
          endTimeController.text = endTime; // Update the end time controller
        } else {
          startTime = pickedTime.format(context);
          startTimeController.text = startTime; // Update the start time controller
        }
      });
    }
  }


}