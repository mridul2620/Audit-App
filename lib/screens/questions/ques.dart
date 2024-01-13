import 'package:audit_app/global_variable.dart';
import 'package:audit_app/screens/home/homepage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../fonts/fonts.dart';
import '../category_model.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class Questions extends StatefulWidget {
  final String categoryName;
  final List<Question> questions;

  Questions({required this.categoryName, required this.questions});

  @override
  _QuestionsState createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  int currentQuestionIndex = 0;
  List<QuestionData> questionDataList = [];
  int selectedMethodology = -1;
  int selectedRiskLevel = -1;
  List<File?> imageFiles = [null, null, null];

  final TextEditingController observationController = TextEditingController();
  final TextEditingController recommendationController =
      TextEditingController();

  bool validateFields() {
    return selectedMethodology != -1 &&
        selectedRiskLevel != -1 &&
        observationController.text.isNotEmpty &&
        recommendationController.text.isNotEmpty;
  }

  Future<void> _getImage(int index, ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);

    setState(() {
      if (pickedImage != null) {
        imageFiles[index] = File(pickedImage.path);
      }
    });
  }

  Future<http.Response> _sendDataToAPI(QuestionData questionData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('access_token');
    int? auditId = prefs.getInt('audit_id');
    prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('id');

    var request = http.MultipartRequest('POST', Uri.parse(ques_api));
    request.headers['Authorization'] = 'Bearer $accessToken';

    request.fields['user_id'] = userId.toString();
    request.fields['audit_id'] = auditId.toString();
    request.fields['document_reference'] = "";
    request.fields['question_id'] = questionData.question.id.toString();
    request.fields['checking_methodology'] = questionData.selectedMethodology;
    request.fields['recommendation'] = questionData.recommendation;
    request.fields['observation'] = questionData.observation;
    request.fields['risk_level'] = _getRiskLevelString(selectedRiskLevel);

    if (questionData.evidenceImage1 != null) {
      request.files.add(await http.MultipartFile.fromPath(
          'evidence_image_1', questionData.evidenceImage1!.path));
    }

    if (questionData.evidenceImage2 != null) {
      request.files.add(await http.MultipartFile.fromPath(
          'evidence_image_2', questionData.evidenceImage2!.path));
    }

    if (questionData.evidenceImage3 != null) {
      request.files.add(await http.MultipartFile.fromPath(
          'evidence_image_3', questionData.evidenceImage3!.path));
    }
    var response = await request.send();
    return http.Response.fromStream(response);
  }

  void _nextQuestion() async {
    if (currentQuestionIndex < widget.questions.length - 1) {
      Question currentQuestion = widget.questions[currentQuestionIndex];
      QuestionData questionData = QuestionData(
        question: currentQuestion,
        selectedMethodology: selectedMethodology.toString(),
        observation: observationController.text,
        recommendation: recommendationController.text,
        riskLevel: _getRiskLevelString(selectedRiskLevel),
        evidenceImage1: imageFiles[0],
        evidenceImage2: imageFiles[1],
        evidenceImage3: imageFiles[2],
      );
      questionDataList.add(questionData);
      final response = await _sendDataToAPI(questionDataList.last);
      if (response.statusCode == 200) {
        print('Data sent to API successfully');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Color.fromARGB(255, 85, 192, 89),
          content: Text(
            'Records Saved Sucessfully',
            style: GoogleFonts.secularOne(fontSize: 12),
          ),
          duration: Duration(seconds: 3),
        ));
        setState(() {
          currentQuestionIndex++;
          selectedRiskLevel = -1;
          selectedMethodology = -1;
          imageFiles = [null, null, null];
          observationController.clear();
          recommendationController.clear();
        });
      } else {
        print('Error sending data to API: ${response.statusCode}');
      }
    } else {
      Question currentQuestion = widget.questions[currentQuestionIndex];
      QuestionData questionData = QuestionData(
        question: currentQuestion,
        selectedMethodology: selectedMethodology.toString(),
        observation: observationController.text,
        recommendation: recommendationController.text,
        riskLevel: _getRiskLevelString(selectedRiskLevel),
        evidenceImage1: imageFiles[0],
        evidenceImage2: imageFiles[1],
        evidenceImage3: imageFiles[2],
      );
      questionDataList.add(questionData);
      final response = await _sendDataToAPI(questionDataList.last);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Color.fromARGB(255, 85, 192, 89),
          content: Text(
            'Records Saved Sucessfully',
            style: GoogleFonts.secularOne(fontSize: 12),
          ),
          duration: Duration(seconds: 3),
        ));
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Home()));
      } else {
        print("Data not sent");
      }
    }
  }

  void _saveAndExit() async {
    Question currentQuestion = widget.questions[currentQuestionIndex];
    QuestionData questionData = QuestionData(
      question: currentQuestion,
      selectedMethodology: selectedMethodology.toString(),
      observation: observationController.text,
      recommendation: recommendationController.text,
      riskLevel: _getRiskLevelString(selectedRiskLevel),
      evidenceImage1: imageFiles[0],
      evidenceImage2: imageFiles[1],
      evidenceImage3: imageFiles[2],
    );

    questionDataList.add(questionData);
    final response = await _sendDataToAPI(questionDataList.last);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Color.fromARGB(255, 85, 192, 89),
        content: Text(
          'Records Saved Sucessfully',
          style: GoogleFonts.secularOne(fontSize: 12),
        ),
        duration: Duration(seconds: 3),
      ));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Home()));
    } else {
      print('Error sending data to API: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    int totalQuestions = widget.questions.length;
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    double progress = (currentQuestionIndex + 1) / totalQuestions;
    return Scaffold(
      backgroundColor: maincolor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: maincolor,
        title: Text(
          widget.categoryName,
          style:
              GoogleFonts.secularOne(textStyle: softbold, color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Color.fromARGB(255, 85, 192, 89),
              content: Text(
                'Records Saved Sucessfully',
                style: GoogleFonts.secularOne(fontSize: 12),
              ),
              duration: Duration(seconds: 3),
            ));
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => const Home()));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: _height,
          width: double.infinity,
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                fit: BoxFit.fitHeight,
                child: Container(
                  color: maincolor,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        color: Color(0xFFFFDD63),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 12, bottom: 12, left: 8, right: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Q" +
                                widget.questions[currentQuestionIndex].questionNo
                                    .toString() +
                                '.',
                            style: GoogleFonts.secularOne(
                                textStyle: normalstyle,
                                fontSize: 13,
                                color: Colors.black),
                            textAlign: TextAlign.start,
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              widget.questions[currentQuestionIndex].questionName,
                              style: GoogleFonts.secularOne(
                                  textStyle: normalstyle,
                                  fontSize: 13,
                                  color: Colors.black),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          minHeight: 12,
                          value: progress,
                          backgroundColor: bodyColor,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            maincolor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${currentQuestionIndex + 1}/$totalQuestions',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: EdgeInsets.only(left: 14),
                child: Text(
                  'Checking Methodology',
                  style: GoogleFonts.secularOne(
                      fontSize: 13, textStyle: normalstyle, color: Colors.black),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildMethodologyOption(0, 'Visually'),
                    _buildMethodologyOption(1, 'Docs'),
                    _buildMethodologyOption(2, 'Both'),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              // Image Containers
              Padding(
                padding: EdgeInsets.only(left: 14),
                child: Text(
                  'Photographs/ Evidence',
                  style: GoogleFonts.secularOne(
                      fontSize: 13, textStyle: normalstyle, color: Colors.black),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildImageContainer(0),
                  _buildImageContainer(1),
                  _buildImageContainer(2),
                ],
              ),
      
              const SizedBox(height: 8),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Observation',
                  style: GoogleFonts.secularOne(
                      fontSize: 13, textStyle: normalstyle, color: Colors.black),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                  style: GoogleFonts.inter(
                      fontSize: 13, fontWeight: FontWeight.w400),
                  controller: observationController,
                  decoration: InputDecoration(
                    fillColor: Color.fromARGB(255, 249, 248, 248),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: maincolor, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 184, 184, 184), width: 1.0),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    // counterText: '${observationController.text.length}/500'
                  ),
                  //maxLength: 500,
                  maxLines: 2,
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Recommendation',
                  style: GoogleFonts.secularOne(
                      fontSize: 13, textStyle: normalstyle, color: Colors.black),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                  style: GoogleFonts.inter(
                      fontSize: 13, fontWeight: FontWeight.w400),
                  controller: recommendationController,
                  decoration: InputDecoration(
                    focusColor: Color.fromARGB(255, 249, 248, 248),
                    fillColor: Color.fromARGB(255, 249, 248, 248),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: maincolor, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 184, 184, 184), width: 1.0),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    // counterText:
                    //     '${recommendationController.text.length}/500'
                  ),
                  //maxLength: 500,
                  maxLines: 2,
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Risk Level',
                  style: GoogleFonts.secularOne(
                      fontSize: 13, textStyle: normalstyle, color: Colors.black),
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildRiskOption(0, 'Low'),
                    _buildRiskOption(1, 'Normal'),
                    _buildRiskOption(2, 'High'),
                    _buildRiskOption(3, 'No Risk'),
                  ],
                ),
              ),
              const SizedBox(height: 2),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: (_width / 2) - 15,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              validateFields() ? maincolor : bodyColor,
                        ),
                        onPressed: validateFields() ? _saveAndExit : null,
                        child: Text(
                          'SAVE/EXIT',
                          style: GoogleFonts.secularOne(
                              textStyle: normalstyle, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: (_width / 2) - 15,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              validateFields() ? maincolor : bodyColor,
                        ),
                        onPressed: validateFields() ? _nextQuestion : null,
                        child: Text(
                          'SAVE/NEXT',
                          style: GoogleFonts.secularOne(
                              textStyle: normalstyle, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRiskOption(int index, String label) {
    bool isSelected = selectedRiskLevel == index;
    return GestureDetector(
      onTap: () => _selectRiskLevel(index),
      child: Container(
        height: 55,
        width: 55,
        child: Column(
          children: [
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: isSelected
                    ? index == 0
                        ? Colors.green
                        : index == 1
                            ? Color(0xFFFFDD63)
                            : index == 2
                                ? Color.fromARGB(255, 203, 2, 2)
                                : Colors.black
                    : Color.fromARGB(255, 249, 248, 248),
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                    width: 2,
                    strokeAlign: BorderSide.strokeAlignOutside,
                    color: index == 0
                        ? Colors.green
                        : index == 1
                            ? Color(0xFFFFDD63)
                            : index == 2
                                ? Color.fromARGB(255, 203, 2, 2)
                                : Colors.black),
              ),
              child: isSelected
                  ? const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16,
                    )
                  : null,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected
                    ? index == 0
                        ? Colors.green
                        : index == 1
                            ? Color(0xFFFFDD63)
                            : index == 2
                                ? Color.fromARGB(255, 203, 2, 2)
                                : Colors.black
                    : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMethodologyOption(int index, String label) {
    bool isSelected = selectedMethodology == index;
    return GestureDetector(
      onTap: () => _selectMethodology(index),
      child: Container(
        height: 40,
        width: 110,
        decoration: BoxDecoration(
          color: isSelected ? maincolor : Color.fromARGB(255, 249, 248, 248),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: isSelected ? maincolor : Colors.grey),
        ),
        child: Row(
          children: [
            Radio<int>(
              activeColor: Color(0xFFFFDD63),
              value: index,
              groupValue: selectedMethodology,
              onChanged: (_) => _selectMethodology(index),
              materialTapTargetSize:
                  MaterialTapTargetSize.shrinkWrap, // Remove extra space
            ),
            SizedBox(
                width: 4), // Add a small space between radio button and text
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageContainer(int index) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListTile(
                    tileColor: Color.fromARGB(255, 249, 248, 248),
                    onTap: () {
                      _getImage(index, ImageSource.camera);
                    },
                    title: Text("Camera"),
                  ),
                  ListTile(
                    tileColor: Color.fromARGB(255, 249, 248, 248),
                    onTap: () {
                      _getImage(index, ImageSource.gallery);
                    },
                    title: Text("Gallery"),
                  ),
                ],
              );
            });
      },
      child: Container(
        width: 102,
        height: 72,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 249, 248, 248),
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: imageFiles[index] != null
            ? Image.file(
                imageFiles[index]!,
                fit: BoxFit.cover,
              )
            : Icon(Icons.camera_alt),
      ),
    );
  }

  void _selectMethodology(int index) {
    setState(() {
      selectedMethodology = index;
    });
  }

  void _selectRiskLevel(int index) {
    setState(() {
      selectedRiskLevel = index;
    });
  }
}

String _getRiskLevelString(int index) {
  switch (index) {
    case 0:
      return 'Low';
    case 1:
      return 'Normal';
    case 2:
      return 'High';
    case 3:
      return 'No Risk';
    default:
      return '';
  }
}
