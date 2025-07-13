// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:test_sm/src/components/Button.dart';
import 'package:test_sm/src/components/Text.dart';
import 'package:test_sm/src/constants/Colors.dart';
import 'package:test_sm/src/helpers/NavHelper.dart';
import 'package:test_sm/src/utils/utils.dart';
import 'package:test_sm/src/views/home/HomeScreen.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  final List<LanguageModel> _languages = [
    LanguageModel(name: "English", code: "us", selected: true),
    LanguageModel(name: "Afghanistan", code: "af", selected: false),
    LanguageModel(name: "Algeria", code: "dz", selected: false),
    LanguageModel(name: "Andorra", code: "ad", selected: false),
    LanguageModel(name: "Argentina", code: "ar", selected: false),
    LanguageModel(name: "Bangladesh", code: "bd", selected: false),
    LanguageModel(name: "Belarus", code: "by", selected: false),
    LanguageModel(name: "Bermuda", code: "bm", selected: false),
    LanguageModel(name: "Indonesia", code: "id", selected: false),
    LanguageModel(name: "Ghana", code: "gh", selected: false),
    LanguageModel(name: "Malaysia", code: "my", selected: false),
    LanguageModel(name: "Ukraine", code: "ua", selected: false),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leadingWidth: 45,

        leading: InkWell(
          borderRadius: BorderRadius.circular(100),
          onTap: () {
            NavHelper.remove();
          },
          child: Container(
            margin: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.placeHolder, width: 2),
            ),
            child: Icon(Icons.arrow_back_ios_new, size: 18),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        child: Stack(
          children: [
            SizedBox(
              height: 80,

              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: SizedBox(height: 80, width: double.infinity),
              ),
            ),

            ActionButton(
              isLoading: false,
              btnText: 'Continue',
              btnTap: () {
                NavHelper.removeAllAndOpen(HomeScreen());
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  'What is Your Mother Language',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                Utils.vertS(10),
                AppText(
                  'Discover what is a podcast description and podcast summary.',
                  fontSize: 16,
                  fontColor: AppColors.placeHolder,
                  textAlignment: TextAlign.start,
                ),

                Utils.vertS(30),

                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _languages.length,
                  separatorBuilder: (context, index) => Utils.vertS(4),
                  itemBuilder: (context, index) {
                    LanguageModel language = _languages[index];
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            for (var element in _languages) {
                              element.selected = false;
                            }
                            language.selected = true;
                            setState(() {});
                          },
                          borderRadius: BorderRadius.circular(25),

                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 20,
                            ),
                            decoration: BoxDecoration(
                              color: language.selected
                                  ? Colors.white
                                  : AppColors.placeHolder.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: language.selected
                                  ? [
                                      BoxShadow(
                                        color: AppColors.semiDark,
                                        blurRadius: 40,
                                        spreadRadius: 2,
                                        offset: Offset(0, 15),
                                      ),
                                    ]
                                  : null,
                            ),
                            child: Row(
                              children: [
                                Utils.horiS(10),
                                AppText(
                                  language.name,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                                Spacer(),
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: AppText(
                                      Utils.countryFromCode(language.code),
                                      fontSize: 25,
                                      textAlignment: TextAlign.justify,
                                    ),
                                  ),
                                ),
                                Utils.horiS(20),
                              ],
                            ),
                          ),
                        ),
                        if (language.selected) Utils.vertS(10),
                        if (index == _languages.length - 1) Utils.vertS(80),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LanguageModel {
  String name;
  String code;
  bool selected;
  LanguageModel({
    required this.name,
    required this.code,
    required this.selected,
  });

  LanguageModel copyWith({String? name, String? code, bool? selected}) {
    return LanguageModel(
      name: name ?? this.name,
      code: code ?? this.code,
      selected: selected ?? this.selected,
    );
  }
}
