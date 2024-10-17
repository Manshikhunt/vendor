class VendorUserModel {
  final bool? approved;
  final String? vendorId;
  final String? businesName;
  final String? email;
  final String? phoneNumber;
  final String? storageImage;
  final String? countryValue;
  final String? stateValue;
  final String? cityValue;
  final String? taxRagisterd;
  final String? taxNumber;

  VendorUserModel(
      {required this.approved,
      required this.vendorId,
      required this.businesName,
      required this.email,
      required this.phoneNumber,
      required this.storageImage,
      required this.countryValue,
      required this.stateValue,
      required this.cityValue,
      required this.taxRagisterd,
      required this.taxNumber});

  // fromJson is used to convert json data into object
  VendorUserModel.fromJson(Map<String, Object?> json)
  : this(
    approved : json['approved'] as bool? ?? false,
    vendorId : json['vendorId'] as String? ?? '',
    businesName : json['businesName'] as String? ?? '',
    email : json['email'] as String? ?? '',
    phoneNumber : json['phoneNumber'] as String? ?? '',
    storageImage : json['storageImage'] as String? ?? '',
    countryValue : json['countryValue'] as String? ?? '',
    stateValue : json['stateValue'] as String? ?? '',
    cityValue : json['cityValue'] as String? ?? '',
    taxRagisterd : json['taxRagisterd'] as String? ?? '',
    taxNumber : json['taxNumber'] as String? ?? '',
  );

  // toJson is used to convert object to json data
  Map<String, Object?> toJson() {
    return {
    'approved' : approved,
    'vendorId' : vendorId,
    'businesName' : businesName,
    'email' : email,
    'phoneNumber' : phoneNumber,
    'storageImage' : storageImage,
    'countryValue' : countryValue,
    'stateValue' : stateValue,
    'cityValue' : cityValue,
    'taxRagisterd' : taxRagisterd,
    'taxNumber' : taxNumber,
   };
  }
}