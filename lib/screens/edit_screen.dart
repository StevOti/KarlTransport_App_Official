import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:karltransportapp/components/image_pdf_api.dart';
import 'package:karltransportapp/components/save_and_open_pdf.dart';
import 'package:karltransportapp/components/simple_pdf_api.dart';
import 'package:karltransportapp/data/firestore.dart';
import 'package:karltransportapp/data/storage_service.dart';
import 'package:karltransportapp/models/contract_models.dart';
import 'package:karltransportapp/themes/colors.dart';
import 'package:karltransportapp/widgets/custom_text_field.dart';
import 'package:karltransportapp/widgets/signature.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:signature/signature.dart';

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
  late List<bool> _functionalCheckValues;
  late List<bool> _carAccessoriesValues;
  late List<bool> _extraFunctionalCheckValues;
  late List<bool> _tankLevelValues;
  late List<bool> _commentValues;
  late List<bool> _tyreChangeValues;
  late List<bool> _insideDamageValues;
  late List<bool> _smokyVehicleValues;
  late List<bool> _tyreTypeValues;

  // Signature Controller
  late SignatureController signatureController;
  

  // After Journey Controllers
  late TextEditingController endDate;
  late TextEditingController endTime;
  late TextEditingController endStreet;
  late TextEditingController endStreetNo;
  late TextEditingController endPlz;
  late TextEditingController endCity;
  late TextEditingController endKeyNo;
  late TextEditingController endMileage;
  late TextEditingController transfereeName;
  late TextEditingController transfereeMail;
  late TextEditingController transfereeStreet;
  late TextEditingController transfereeHouseNo;
  late TextEditingController transfereePlz;
  late TextEditingController transfereeCity;
  late TextEditingController transfereeLand;
  late TextEditingController transfereeDob;
  late TextEditingController transfereeId;
  late TextEditingController transfereeIdValidity;

  // In your AddContractScreen class, add a variable for contract ID
  String contractId = DateTime.now().millisecondsSinceEpoch.toString();
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
     _functionalCheckValues = List.from(widget.contract.functionalCheckValues);
    _carAccessoriesValues = List.from(widget.contract.carAccessoriesValues);
    _extraFunctionalCheckValues = List.from(widget.contract.extraFunctionalCheckValues);
    _tankLevelValues = List.from(widget.contract.tankLevelValues);
    _commentValues = List.from(widget.contract.commentValues);
    _tyreChangeValues = List.from(widget.contract.tyreChangeValues);
    _insideDamageValues = List.from(widget.contract.insideDamageValues);
    _smokyVehicleValues = List.from(widget.contract.smokyVehicleValues);
    _tyreTypeValues = List.from(widget.contract.tyreTypes);
    signatureController = SignatureController(
      penStrokeWidth: 5,
      penColor: Colors.black,
      exportBackgroundColor: Colors.white,
    );


    // after journey
    endDate = TextEditingController(text: widget.contract.endDate);
    endTime = TextEditingController(text: widget.contract.endTime);
    endStreet = TextEditingController(text: widget.contract.endStreet);
    endStreetNo = TextEditingController(text: widget.contract.endStreetNo);
    endPlz = TextEditingController(text: widget.contract.endPlz);
    endCity = TextEditingController(text: widget.contract.endCity);
    endKeyNo = TextEditingController(text: widget.contract.endKeyNo);
    endMileage = TextEditingController(text: widget.contract.endMileage);
    transfereeName = TextEditingController(text: widget.contract.transfereeName);
    transfereeMail = TextEditingController(text: widget.contract.transfereeMail);
    transfereeStreet = TextEditingController(text: widget.contract.transfereeStreet);
    transfereeHouseNo = TextEditingController(text: widget.contract.transfereeHouseNo);
    transfereePlz = TextEditingController(text: widget.contract.transfereePlz);
    transfereeCity = TextEditingController(text: widget.contract.transfereeCity);
    transfereeLand = TextEditingController(text: widget.contract.transfereeLand);
    transfereeDob = TextEditingController(text: widget.contract.transfereeDob);
    transfereeId = TextEditingController(text: widget.contract.transfereeId);
    transfereeIdValidity = TextEditingController(text: widget.contract.transfereeIdValidity);

  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF17203A),
          title: const Text(
            'Contract Details',
            style: TextStyle(color: Colors.white),
            selectionColor: Colors.white,
          ),
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(
                  Icons.departure_board,
                  color: Colors.white,
                  ),
                text: 'Before Journey',
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
            buildBeforeJourneyTab(context),
            buildAfterJourneyTab(context),
          ],
        ),
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
                    controller: date,
                    hintText: 'Select Date',
                    focusNode: FocusNode(),
                    widget: IconButton(
                      onPressed: () async => await _getDateFromUser(isAfterJourney: false),
                      icon: const Icon(Icons.calendar_today_outlined, color: Colors.grey),
                    ),
                  ),
                  CustomTextField(
                    focusNode: FocusNode(),
                    controller: startTime,
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
                    controller: driverName,
                    focusNode: FocusNode(),
                    hintText: 'Enter driver name',
                  ),
                  CustomTextField(
                    title: 'Vehicle Type',
                    controller: vehicleType,
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
                    controller: licensePlate,
                    focusNode: FocusNode(),
                    hintText: 'Enter license plate',
                  ),
                  CustomTextField(
                    title: 'Key Number',
                    controller: keyNumber,
                    focusNode: FocusNode(),
                    hintText: 'Key Number',
                  ),
                ),
                _buildInputPair(
                  CustomTextField(
                    title: 'Street',
                    controller: street,
                    hintText: 'Street',
                    focusNode: FocusNode(),
                  ),
                  CustomTextField(
                    title: 'PLZ',
                    controller: plz,
                    hintText: 'PLZ',
                    focusNode: FocusNode(),
                  ),
                ),
                _buildInputPair(
                  CustomTextField(
                    title: 'Mileage',
                    controller: mileage,
                    hintText: 'Mileage',
                    focusNode: FocusNode(),
                  ),
                  CustomTextField(
                    title: 'Number of Seats',
                    controller: seatNumber,
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
                    controller: frontLeft,
                    hintText: 'Front Left in mm',
                    focusNode: FocusNode(),
                  ),
                  CustomTextField(
                    title: 'Front Right',
                    controller: frontRight,
                    hintText: 'Front Right in mm',
                    focusNode: FocusNode(),
                  ),
                ),
                _buildInputPair(
                  CustomTextField(
                    title: 'Rear Left',
                    controller: rearLeft,
                    hintText: 'Rear Left in mm',
                    focusNode: FocusNode(),
                  ),
                  CustomTextField(
                    title: 'Rear Right',
                    controller: rearRight,
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
                    controller: transferorName,
                    hintText: 'Name of Transferor',
                    focusNode: FocusNode(),
                  ),
                  CustomTextField(
                    title: 'Email',
                    controller: transferorEmail,
                    hintText: 'Email of Transferor',
                    focusNode: FocusNode(),
                  ),
                ),
                CustomTextField(
                  title: 'Remarks',
                  controller: remarks,
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
                              

                              if (driverName.text.isNotEmpty && 
                                  vehicleType.text.isNotEmpty) {
                                try {
                                  // Prepare contract data for PDF
                                  final contractData = {
                                    // Before Journey Data
                                    'Vehicle Type': vehicleType.text,
                                    'Driver Name': driverName.text,
                                    'License Plate': licensePlate.text,
                                    'Date': date.text,
                                    'Start Time': startTime.text,
                                    'Street': street.text,
                                    'PLZ': plz.text,
                                    'Key Number': keyNumber.text,
                                    'Mileage': mileage.text,
                                    'Remarks': remarks.text,
                                    'Seat Number': seatNumber.text,
                                    'Front Left Tire': frontLeft.text,
                                    'Front Right Tire': frontRight.text,
                                    'Rear Left Tire': rearLeft.text,
                                    'Rear Right Tire': rearRight.text,
                                    'Transferor Name': transferorName.text,
                                    'Transferor Email': transferorEmail.text,
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
                                    'End Date': endDate.text,
                                    'End Time': endTime.text,
                                    'End Street': endStreet.text,
                                    'End Street No': endStreetNo.text,
                                    'End PLZ': endPlz.text,
                                    'End City': endCity.text,
                                    'End Key No': endKeyNo.text,
                                    'End Mileage': endMileage.text,
                                    'Transferee Name': transfereeName.text,
                                    'Transferee Email': transfereeMail.text,
                                    'Transferee Street': transfereeStreet.text,
                                    'Transferee House No': transfereeHouseNo.text,
                                    'Transferee PLZ': transfereePlz.text,
                                    'Transferee City': transfereeCity.text,
                                    'Transferee Land': transfereeLand.text,
                                    'Transferee DOB': transfereeDob.text,
                                    'Transferee ID': transfereeId.text,
                                    'Transferee ID Validity': transfereeIdValidity.text,
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
                    controller: endDate,
                    hintText: 'Select Date',
                    focusNode: FocusNode(),
                    widget: IconButton(
                      onPressed: () async => await _getDateFromUser(isAfterJourney: true),
                      icon: const Icon(Icons.calendar_today_outlined, color: Colors.grey),
                    ),
                  ),
                  CustomTextField(
                    focusNode: FocusNode(),
                    controller: endTime,
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
                    controller: endMileage,
                    hintText: 'Final Mileage',
                    focusNode: FocusNode(),
                  ),
                  CustomTextField(
                    title: 'End Key Number',
                    controller: endKeyNo,
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
                    controller: endStreet,
                    hintText: 'Street Name',
                    focusNode: FocusNode(),
                  ),
                  CustomTextField(
                    title: 'Street Number',
                    controller: endStreetNo,
                    hintText: 'Street Number',
                    focusNode: FocusNode(),
                  ),
                ),
                _buildInputPair(
                  CustomTextField(
                    title: 'PLZ',
                    controller: endPlz,
                    hintText: 'Postal Code',
                    focusNode: FocusNode(),
                  ),
                  CustomTextField(
                    title: 'City',
                    controller: endCity,
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
                    controller: transfereeName,
                    hintText: 'Full Name',
                    focusNode: FocusNode(),
                  ),
                  CustomTextField(
                    title: 'Email',
                    controller: transfereeMail,
                    hintText: 'Email Address',
                    focusNode: FocusNode(),
                  ),
                ),
                _buildInputPair(
                  CustomTextField(
                    title: 'Street',
                    controller: transfereeStreet,
                    hintText: 'Street Name',
                    focusNode: FocusNode(),
                  ),
                  CustomTextField(
                    title: 'House Number',
                    controller: transfereeHouseNo,
                    hintText: 'House Number',
                    focusNode: FocusNode(),
                  ),
                ),
                _buildInputPair(
                  CustomTextField(
                    title: 'PLZ',
                    controller: transfereePlz,
                    hintText: 'Postal Code',
                    focusNode: FocusNode(),
                  ),
                  CustomTextField(
                    title: 'City',
                    controller: transfereeCity,
                    hintText: 'City Name',
                    focusNode: FocusNode(),
                  ),
                ),
                _buildInputPair(
                  CustomTextField(
                    title: 'Country',
                    controller: transfereeLand,
                    hintText: 'Country',
                    focusNode: FocusNode(),
                  ),
                  CustomTextField(
                    title: 'Date of Birth',
                    controller: transfereeDob,
                    hintText: 'Date of Birth',
                    focusNode: FocusNode(),
                  ),
                ),
                _buildInputPair(
                  CustomTextField(
                    title: 'ID Number',
                    controller: transfereeId,
                    hintText: 'ID Number',
                    focusNode: FocusNode(),
                  ),
                  CustomTextField(
                    title: 'ID Validity',
                    controller: transfereeIdValidity,
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
                          

                          if (driverName.text.isNotEmpty && 
                              vehicleType.text.isNotEmpty) {
                            try {
                              // Prepare contract data for PDF
                              final contractData = {
                                // Before Journey Data
                                'Vehicle Type': vehicleType.text,
                                'Driver Name': driverName.text,
                                'License Plate': licensePlate.text,
                                'Date': date.text,
                                'Start Time': startTime.text,
                                'Street': street.text,
                                'PLZ': plz.text,
                                'Key Number': keyNumber.text,
                                'Mileage': mileage.text,
                                'Remarks': remarks.text,
                                'Seat Number': seatNumber.text,
                                'Front Left Tire': frontLeft.text,
                                'Front Right Tire': frontRight.text,
                                'Rear Left Tire': rearLeft.text,
                                'Rear Right Tire': rearRight.text,
                                'Transferor Name': transferorName.text,
                                'Transferor Email': transferorEmail.text,
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
                                'End Date': endDate.text,
                                'End Time': endTime.text,
                                'End Street': endStreet.text,
                                'End Street No': endStreetNo.text,
                                'End PLZ': endPlz.text,
                                'End City': endCity.text,
                                'End Key No': endKeyNo.text,
                                'End Mileage': endMileage.text,
                                'Transferee Name': transfereeName.text,
                                'Transferee Email': transfereeMail.text,
                                'Transferee Street': transfereeStreet.text,
                                'Transferee House No': transfereeHouseNo.text,
                                'Transferee PLZ': transfereePlz.text,
                                'Transferee City': transfereeCity.text,
                                'Transferee Land': transfereeLand.text,
                                'Transferee DOB': transfereeDob.text,
                                'Transferee ID': transfereeId.text,
                                'Transferee ID Validity': transfereeIdValidity.text,
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

  final List<String> _functionalChecks = ["Darkeness", "Rain", "Snow/Ice", "Dirty Outside", "Dirty Inside"];
  final List<String> _carAccessories = ["Vehicle Registration Document", "Warning Triangle", "First Aid Kit", "Service Plan","Safety Vest", "Vehicle Manual", "Trunk Cover", "FB Auxiliary heating", "Tyre Fit", "Reserve Tyre", "Navigation", "SD/DVD", "On-Board Tools", "Car Mats", "Antenna", "Ash Tray"];
  final List<String> _extraFunctionalChecks = ["Oil level", "Wiper Water"];
  final List<String> _tankLevel = ["Quarter", "Half", "Three Quarters", "Full-tank"];
  final List<String> _comments = ["Scratches", "Rock chips", "Dents", "Other Damages"];
  final List<String> _tyreChange = ["Yes", "No"];
  final List<String> _insideDamage = ["Front Seats", "Interior Panelling", "Headlining", "Fittings", "Rear seats", "Carpets", "Trunk", "Contamination"];
  final List<String> _smokyVehicle = ["Yes", "No"];
  final List<String> _tyreTypes = ["Sommerreifen", "Ganzjahresreifen", "Winterreifen"];
  


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
        endDate.text = DateFormat('yyyy-MM-dd').format(selectedDate); // Update the end date controller
      } else {
        date.text = DateFormat('yyyy-MM-dd').format(selectedDate); // Update the date controller
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
          initialEndTime = pickedTime.format(context);
          endTime.text = initialEndTime; // Update the end time controller
        } else {
          initialStartTime = pickedTime.format(context);
          startTime.text = initialStartTime; // Update the start time controller
        }
      }
    );
    }
  }

  Future<void> _validateAndSave(BuildContext context) async {
    if (
      driverName.text.isEmpty || 
      vehicleType.text.isEmpty
    ) {
      _showErrorSnackBar(context, 'All fields are required!');
    } else {

      // // Get the signature from the storage service
      // final storageService = Provider.of<StorageService>(context, listen: false);
      // final signatureUrls = storageService.imagesUrls
      //     .where((url) => url.contains('signatures/$contractId'))
      //     .toList();
      
      // final String? signatureUrl = signatureUrls.isNotEmpty ? signatureUrls.first : null;

      FirestoreDatasource().updateContract(
        widget.contract.id,
        
        // Before Journey Data
        vehicleType.text,
        driverName.text,
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
        endDate.text,
        endTime.text,
        endStreet.text,
        endStreetNo.text,
        endPlz.text,
        endCity.text,
        endKeyNo.text,
        endMileage.text,
        transfereeName.text,
        transfereeMail.text,
        transfereeStreet.text,
        transfereeHouseNo.text,
        transfereePlz.text,
        transfereeCity.text,
        transfereeLand.text,
        transfereeDob.text,
        transfereeId.text,
        transfereeIdValidity.text

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


}



