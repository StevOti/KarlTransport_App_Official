class Contract {
  // before journey
  String id;
  String driverName;
  String vehicleType;
  String licensePlate;
  String date;
  String startTime;
  String street;
  String plz;
  String keyNumber;
  String mileage;
  String remarks;
  String seatNumber;
  String frontLeft;
  String frontRight;
  String rearLeft;
  String rearRight;
  String transferorName;
  String transferorEmail;
  List<bool> functionalCheckValues;
  List<bool> carAccessoriesValues;
  List<bool> extraFunctionalCheckValues;
  List<bool> tankLevelValues;
  List<bool> commentValues;
  List<bool> tyreChangeValues;
  List<bool> insideDamageValues;
  List<bool> smokyVehicleValues;
  List<bool> tyreTypes;

  bool isDon;

  // after journey
  String endDate;
  String endTime;
  String endStreet;
  String endStreetNo;
  String endPlz;
  String endCity;
  String endKeyNo;
  String endMileage;
  String transfereeName;
  String transfereeMail;
  String transfereeStreet;
  String transfereeHouseNo;
  String transfereePlz;
  String transfereeCity;
  String transfereeLand;
  String transfereeDob;
  String transfereeId;
  String transfereeIdValidity;

  Contract(

    // before journey
    this.id,
    this.driverName,
    this.vehicleType,
    this.licensePlate,
    this.date,
    this.startTime,
    this.street,
    this.plz,
    this.keyNumber,
    this.mileage,
    this.remarks,
    this.seatNumber,
    this.frontLeft,
    this.frontRight,
    this.rearLeft,
    this.rearRight,
    this.transferorName,
    this.transferorEmail,
    this.functionalCheckValues,
    this.carAccessoriesValues,
    this.extraFunctionalCheckValues,
    this.tankLevelValues,
    this.commentValues,
    this.tyreChangeValues,
    this.insideDamageValues,
    this.smokyVehicleValues,
    this.tyreTypes,
    

    this.isDon,

    // after journey
    this.endDate,
    this.endTime,
    this.endStreet,
    this.endStreetNo,
    this.endPlz,
    this.endCity,
    this.endKeyNo,
    this.endMileage,
    this.transfereeName,
    this.transfereeMail,
    this.transfereeStreet,
    this.transfereeHouseNo,
    this.transfereePlz,
    this.transfereeCity,
    this.transfereeLand,
    this.transfereeDob,
    this.transfereeId,
    this.transfereeIdValidity,

  );
}
