import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bmi_calculator/components/icon_content.dart';
import 'package:bmi_calculator/components/reusable_card.dart';
import 'package:bmi_calculator/constants.dart';
import 'package:bmi_calculator/screens/results_page.dart';
import 'package:bmi_calculator/components/round_icon_button.dart';
import 'package:bmi_calculator/components/bottom_button.dart';
import 'package:bmi_calculator/calculator_brain.dart';

enum Gender {
  male,
  female,
}

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {

  Gender selectedGender;
  int height = 180;
  int weight = 50;
  int age = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('BMI CALCULATOR')),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Row(
            children: <Widget>[
              Expanded(
                child: ReusableCard(
                    onPress:(){
                      setState(() {
                        selectedGender = Gender.male;
                      });
                    },
                    colour: selectedGender == Gender.male ? kActiveCardColour : kInactiveCardColour,
                  cardChild: IconContent(icon: FontAwesomeIcons.mars, label: 'MALE',),
                ),
    ),
          Expanded(child: ReusableCard(
            onPress: (){
              setState(() {
                selectedGender = Gender.female;
              });
            },
              colour: selectedGender == Gender.female ? kActiveCardColour : kInactiveCardColour,
            cardChild: IconContent(
              icon: FontAwesomeIcons.venus,
              label: 'FEMALE',
            ),
          ),
          ),
          ],
          )),
          Expanded(
               child: ReusableCard(
               colour: kInactiveCardColour,
               cardChild: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: <Widget>[
                   Text('HEIGHT', style: kLabelTextStyle,
                   ),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment.baseline,
                     textBaseline: TextBaseline.alphabetic,
                     children: <Widget>[
                       Text(
                         height.toString(),
                         style: kNumberTextStyle,
                       ),
                       Text(
                         'cm',
                         style: kLabelTextStyle,
                       )
                     ],
                   ),
                   SliderTheme(
                     data: SliderTheme.of(context).copyWith(
                       activeTrackColor: Colors.white,
                       inactiveTrackColor: Color(0xFF8D8E98),
                       thumbColor: Color(0xFFEB1555),
                       overlayColor: Color(0x29EB1555),
                       thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15.0),
                       overlayShape: RoundSliderOverlayShape(overlayRadius: 30.0),
                     ),
                     child: Slider(
                        value: height.toDouble(),
                        min: 120.0,
                       max: 220.0,
//                       activeColor: Colors.white,

                       onChanged: (double newValue){
                         setState(() {
                           height = newValue.toInt();
                         });
                       },
                     ),
                   ),
                 ],
               ),
               ),
    ),
          Expanded(child: Row(
            children: <Widget>[
              Expanded(child: ReusableCard(
                  colour: kInactiveCardColour,
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'WEIGHT',
                      style: kLabelTextStyle,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: <Widget>[
                        Text(
                          weight.toString(),
                          style: kNumberTextStyle,
                        ),
                        Text(
                          'kg',
                          style: kLabelTextStyle,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RoundIconButton(
                            icon: FontAwesomeIcons.minus,
                          onPressed: (){
                              setState(() {
                                weight -- ;
                              });
                          },
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        RoundIconButton(icon: FontAwesomeIcons.plus,
                        onPressed: (){
                          setState(() {
                            weight++;
                          });
                        },),
                      ],
                    )
                  ],
                ),
              ),
    ),
              Expanded(
                child: ReusableCard(
                    colour: kInactiveCardColour,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('AGE', style: kLabelTextStyle,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: <Widget>[
                            Text(
                              age.toString(),
                              style: kNumberTextStyle,
                            ),
                            Text(
                              'yrs',
                              style: kLabelTextStyle,
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RoundIconButton(
                              icon: FontAwesomeIcons.minus,
                              onPressed: (){
                                setState(() {
                                  age -- ;
                                });
                              },
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            RoundIconButton(icon: FontAwesomeIcons.plus,
                              onPressed: (){
                                setState(() {
                                  age++;
                                });
                              },),
                          ],
                        )
                      ],
                    ) ,),
    ),
            ],
          )),
          BottomButton(
            buttonTitle: 'CALCULATE',
            onTap: (){

              CalculatorBrain calc = CalculatorBrain(height: height, weight: weight);

            Navigator.push(context, MaterialPageRoute(builder: (context) => ResultsPage(
              bmiResults: calc.calculateBMI(),
              resultText: calc.getResults(),
              interpretation: calc.getInterpretation(),
            ),
            ),
            );
          },),
        ],
    ),
    );
  }
}



