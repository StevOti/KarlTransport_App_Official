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

  bool isDon;

  // after journey
  String finalMileage;
  String finalRemarks;

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
    

    this.isDon,

    // after journey
    this.finalMileage,
    this.finalRemarks,
  );
}
