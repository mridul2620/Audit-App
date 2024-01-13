import 'package:audit_app/global_variable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import '../../fonts/fonts.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../category_model.dart';
import '../questions/ques.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class School {
  final String name;
  final String address;

  School({required this.name, required this.address});
}

class AuditDetails extends StatefulWidget {
  final String categoryName;
  final Category category;
  final int id;
  AuditDetails(
      {required this.categoryName, required this.category, required this.id});

  @override
  State<AuditDetails> createState() => _AuditDetailsState();
}

class _AuditDetailsState extends State<AuditDetails> {
  late SharedPreferences prefs;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String latitude = '';
  String longitude = '';
  String location = "";
  String address = '';
  String _dateTime = "";
  late DateTime selectedDate = DateTime.now();
  TextEditingController dateController = TextEditingController();
  List<School> schools = [];
  School? selectedSchool;
  double dropdownWidth = 0.0;
  TextEditingController _schoolController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchSchoolNames();
    _getCurrentDateTime();
    _getCurrentLocation();
    dateController.text =
        "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
  }

  void _getCurrentDateTime() {
    setState(() {
      _dateTime = DateTime.now().toString();
    });
  }

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      throw Exception('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      throw Exception(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    await _getaddress(position);
    return position;
  }

  Future<void> _getaddress(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks[0];
    setState(() {
      latitude = position.latitude.toString();
      longitude = position.longitude.toString();
      address =
          '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
      location = 'Lat: ${position.latitude}, Long: ${position.longitude}';
    });
  }

  Future<void> fetchSchoolNames() async {
    prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('access_token');
    final response = await http.get(Uri.parse(schoolAPI),
        headers: {'Authorization': 'Bearer $accessToken'});

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      List<School> fetchedSchools = [];
      for (var schoolData in jsonData['data']) {
        fetchedSchools.add(School(
          name: schoolData['school_name'],
          address: schoolData['address'],
        ));
      }
      setState(() {
        schools = fetchedSchools;
      });
    } else {
      throw Exception('Failed to load schools');
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateController.text =
            "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
      });
    }
  }

  Widget buildDropdownFormField() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: maincolor),
          borderRadius: BorderRadius.circular(5)),
      child: DropdownButtonFormField<School>(
        focusColor: maincolor,
        iconEnabledColor: maincolor,
        iconDisabledColor: maincolor,
        menuMaxHeight: 350.0,
        isExpanded: true,
        value: selectedSchool,
        onChanged: (newValue) {
          setState(() {
            selectedSchool = newValue;
            addressController.text = newValue!.address;
          });
        },
        items: schools.map((school) {
          return DropdownMenuItem<School>(
            value: school,
            child: Text(
              school.name,
              overflow: TextOverflow.ellipsis,
            ),
          );
        }).toList(),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 16)),
      ),
    );
  }

  Future<void> saveAuditId(int auditId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('audit_id', auditId);
  }

  Future<void> _startQuestionnaire() async {
    prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getInt('id').toString();
    String? accessToken = prefs.getString('access_token');
    String formattedDate = convertDateFormat(dateController.text);
    String formattedTime = extractTimeFromDateTime(_dateTime);
    Map<String, dynamic> requestData = {
      'user_id': userId,
      'category_id': widget.id.toString(),
      'audit_name': selectedSchool!.name,
      'address': addressController.text,
      'audit_date': formattedDate,
      'lattitude': latitude.toString(),
      'longitude': longitude.toString(),
      'current_location': address,
      'current_time': formattedTime,
    };
    print(requestData);
    final response = await http.post(
      Uri.parse(create_audit_api),
      headers: {
        'Authorization':
            'Bearer $accessToken', // Replace with your access token
      },
      body: requestData,
    );
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      int auditId = responseData['data']['id'];
      await saveAuditId(auditId);
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Questions(
            categoryName: widget.categoryName,
            questions: widget.category.questions,
          ),
        ),
      );
    } else {
      print("Failed");
    }
  }

  String extractTimeFromDateTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    String formattedTime =
        '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}';
    return formattedTime;
  }

  String convertDateFormat(String inputDate) {
    List<String> dateParts = inputDate.split('-');
    if (dateParts.length == 3) {
      String day = dateParts[0];
      String month = dateParts[1];
      String year = dateParts[2];
      return '$day/$month/$year';
    }
    return inputDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green.shade900,
        title: Text(
          "Audit Report",
          style:
              GoogleFonts.secularOne(textStyle: softbold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Audit Type",
                    style: GoogleFonts.secularOne(
                        fontSize: 13,
                        textStyle: softnormal,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 45,
                    color: Color.fromARGB(255, 249, 248, 248),
                    child: TextFormField(
                      enabled: false,
                      initialValue: widget.categoryName,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Date",
                    style: GoogleFonts.secularOne(
                        fontSize: 13,
                        textStyle: normalstyle,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    height: 45,
                    color: Color.fromARGB(255, 249, 248, 248),
                    child: TextFormField(
                      controller: dateController,
                      readOnly: true,
                      onTap: () => _selectDate(context),
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: maincolor, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 184, 184, 184),
                              width: 1.0),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "School Name",
                    style: GoogleFonts.secularOne(
                        fontSize: 13,
                        textStyle: normalstyle,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 6),
                  TypeAheadFormField<School>(
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: this._schoolController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: maincolor)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: maincolor), // Use the same green color
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                    ),
                    suggestionsCallback: (pattern) {
                      return schools.where((school) => school.name
                          .toLowerCase()
                          .contains(pattern.toLowerCase()));
                    },
                    itemBuilder: (context, School suggestion) {
                      return ListTile(
                        title: Text(suggestion.name),
                      );
                    },
                    onSuggestionSelected: (School suggestion) {
                      setState(() {
                        this._schoolController.text = suggestion.name;
                        selectedSchool = suggestion;
                        addressController.text = suggestion.address;
                      });
                    },
                    noItemsFoundBuilder: (context) {
                      return ListTile(
                        title: Text('No matching schools found'),
                      );
                    },
                    validator: (value) {
                      if (selectedSchool == null) {
                        return 'Please select a school from the list';
                      }
                      return null; // No validation error
                    },
                    keepSuggestionsOnSuggestionSelected: false,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Address",
                    style: GoogleFonts.secularOne(
                        fontSize: 13,
                        textStyle: normalstyle,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Container(
                    height: 45,
                    color: Color.fromARGB(255, 249, 248, 248),
                    child: TextFormField(
                      controller: addressController,
                      readOnly: selectedSchool != null,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the address';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: maincolor, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 184, 184, 184),
                              width: 1.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Date/Location",
                    style: GoogleFonts.secularOne(
                        fontSize: 13,
                        textStyle: normalstyle,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Card(
                    shadowColor: Colors.white,
                    color: Color.fromARGB(255, 249, 248, 248),
                    shape: RoundedRectangleBorder(
                        side: BorderSide.none,
                        borderRadius: BorderRadius.circular(8)),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1,
                              color: Color.fromARGB(255, 224, 221, 221)),
                          borderRadius: BorderRadius.circular(5)),
                      height: 160,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Date/Time:",
                              style: GoogleFonts.secularOne(
                                  fontSize: 13,
                                  textStyle: normalstyle,
                                  color: Colors.black),
                            ),
                            Text(
                              _dateTime,
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "Location:",
                              style: GoogleFonts.secularOne(
                                  fontSize: 13,
                                  textStyle: normalstyle,
                                  color: Colors.black),
                            ),
                            Text(
                              address,
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "Coordinates:",
                              style: GoogleFonts.secularOne(
                                  fontSize: 13,
                                  textStyle: normalstyle,
                                  color: Colors.black),
                            ),
                            Text(
                              location,
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // The form is valid, proceed with _startQuestionnaire
                            _startQuestionnaire();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade900,
                          minimumSize: Size(287, 40),
                        ),
                        child: Text(
                          'Next',
                          style: GoogleFonts.secularOne(
                              textStyle: normalstyle, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
