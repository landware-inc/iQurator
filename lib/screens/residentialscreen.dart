

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kakao_login_test/screens/regidentiallistview.dart';

import '../status/controller.dart';

class ResidentialScreen extends StatefulWidget {
  const ResidentialScreen({Key? key}) : super(key: key);

  @override
  State<ResidentialScreen> createState() => _ResidentialScreenState();
}

class _ResidentialScreenState extends State<ResidentialScreen> {
  final _authentication = FirebaseAuth.instance;
  final controller = Get.put(Controller());
  User? loggedInUser;
  String? userName;
  String result = '';
  List<bool> isSelected = [true, false, false];
  RangeValues values =   RangeValues(0, 150000);
  RangeValues values2 =  RangeValues(0, 50000);
  RangeValues values3 =  RangeValues(0, 45000);
  RangeValues values4 =  RangeValues(0, 150);
  RangeValues values5 =  RangeValues(0, 300);
  double pickerValue = 0;
  PageController _controller = PageController(initialPage: 0, keepPage: false);
  TextEditingController _textEditingControllerMin = TextEditingController();
  TextEditingController _textEditingControllerMax = TextEditingController();
  List<Widget> _list = [Text('모든가격')];



  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    initRangeVlues();
  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: const Text('주거용 검색 조건'),
        actions: [
          IconButton(
            onPressed: () {
              _authentication.signOut();
              Get.back();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              key: ValueKey(1),
              validator: (value) {
                return null;
              },
              onSaved: (value) {
                controller.selectCallname(value!);
              },
              onChanged: (value) {
                controller.selectCallname(value!);
              },
              decoration: InputDecoration(
                hintText: '단지명 (없으면 모든 단지)',
                hintStyle: TextStyle(
                  color: Theme.of(context).colorScheme.outline,
                  letterSpacing: 1.0,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                contentPadding: EdgeInsets.all(10),
                prefixIcon: Icon(
                  Icons.account_circle,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.outlineVariant,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
              ),
            ),



            Column(
              children: [
                ToggleButtons(
                    children: <Widget>[
                      Container(width: (MediaQuery.of(context).size.width - 36)/3, child: new Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[new Icon(Icons.domain,size: 20.0,color: Colors.red,),new SizedBox(width: 4.0,), new Text("매매",style: TextStyle(color: Colors.red,fontSize: 20),)],)),
                      Container(width: (MediaQuery.of(context).size.width - 36)/3, child: new Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[new Icon(Icons.add_business,size: 20.0,color: Colors.yellow[800],),new SizedBox(width: 4.0,), new Text("전세",style: TextStyle(color: Colors.yellow[800],fontSize: 20))],)),
                      Container(width: (MediaQuery.of(context).size.width - 36)/3, child: new Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[new Icon(Icons.meeting_room,size: 20.0,color: Colors.blue,),new SizedBox(width: 4.0,), new Text("월세",style: TextStyle(color: Colors.blue,fontSize: 20))],)),
                    ],
                    isSelected: isSelected,
                    onPressed: toggleSelect,
                ),
              ],
            ),



            Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              child: PageView(
                pageSnapping: true,
                controller: _controller,
                onPageChanged: (index) {
                  setState(() {
                    for (int i = 0; i < isSelected.length; i++) {
                      if (i == index) {
                        isSelected[i] = true;
                      } else {
                        isSelected[i] = false;
                      }
                    }
                  });
                },
                children: [
                  Column(
                    children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 4,
                                  child: TextField(
                                    controller: _textEditingControllerMin,
                                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      hintText: '최소',
                                      hintStyle: TextStyle(
                                        color: Theme.of(context).colorScheme.outline,
                                        letterSpacing: 1.0,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      contentPadding: EdgeInsets.all(10),
                                      prefixIcon: Icon(
                                        Icons.account_circle,
                                        color: Theme.of(context).colorScheme.onSurface,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Theme.of(context).colorScheme.onBackground,
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(30)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Theme.of(context).colorScheme.outlineVariant,
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(30)),
                                      ),
                                    ),
                                  )
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: 90,
                                width: MediaQuery.of(context).size.width / 3,
                                child: CupertinoPicker(
                                  itemExtent: 40,
                                  diameterRatio: 5,
                                  offAxisFraction: -1.0,
                                    backgroundColor: Colors.white,
                                    scrollController: FixedExtentScrollController(initialItem: 0),
                                    squeeze: 1.0,
                                    onSelectedItemChanged: (index) {
                                      if(index == 0) {
                                        _textEditingControllerMin.text = controller.minS.value.toString();
                                        _textEditingControllerMax.text = controller.maxS.value.toString();
                                        controller.minPrice(controller.minS.value.toInt());
                                        controller.maxPrice(controller.maxS.value.toInt());
                                      } else {
                                        _textEditingControllerMin.text = ((index) * 5000 - 5000).toString();
                                        _textEditingControllerMax.text = ((index + 1) * 5000).toString();
                                        controller.minPrice(((index) * 5000 -5000));
                                        controller.maxPrice(((index + 1) * 5000));
                                      }
                                    },
                                    children: _list,
                                ),
                              ),
                              Container(
                                  width: MediaQuery.of(context).size.width / 4,
                                  child: TextField(
                                    controller: _textEditingControllerMax,
                                    key: ValueKey(1),
                                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      hintText: '최대',
                                      hintStyle: TextStyle(
                                        color: Theme.of(context).colorScheme.outline,
                                        letterSpacing: 1.0,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      contentPadding: EdgeInsets.all(10),
                                      prefixIcon: Icon(
                                        Icons.account_circle,
                                        color: Theme.of(context).colorScheme.onSurface,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Theme.of(context).colorScheme.onBackground,
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(30)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Theme.of(context).colorScheme.outlineVariant,
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(30)),
                                      ),
                                    ),
                                  )
                              ),
                            ],
                          ),


/*                      GetX<Controller>( // init을 통해 Controller를 등록할 수 있지만 여기선 Get.put을 사용
                        builder: (_) => Text(
                          '최대: ${_.maxPrice.value}',
                        ),
                      ),
                      RangeSlider(
                          max: controller.maxS.value.toDouble(),
                          min: controller.minS.value.toDouble(),
                          values: values,
                          divisions: 50,
                          onChanged: onPickerChanged,
                          labels: RangeLabels(
                            values.start.round().toString(),
                            values.end.round().toString(),
                          ),
                        ),
                      GetX<Controller>( // init을 통해 Controller를 등록할 수 있지만 여기선 Get.put을 사용
                        builder: (_) => Text(
                          '최소: ${_.minPrice.value}',
                        ),
                      ), */
                    ],
                  ),
                  Column(
                    children: [
                      Obx((){ // Obx 사용 시 따로 Controller 명시 X 보여줄 위젯만. 근데 Get.put을 반드시 사용
                        return Text(
                          '최대: ${controller.maxJeonse.value}',
                        );
                      }),
                      RangeSlider(
                        max: controller.maxJ.value.toDouble(),
                        min: controller.minJ.value.toDouble(),
                        values: values2,
                        divisions: 50,
                        onChanged: onPickerChanged2,
                        labels: RangeLabels(
                            values2.start.round().toString(),
                            values2.end.round().toString(),
                        ),
                      ),
                      Obx((){ // Obx 사용 시 따로 Controller 명시 X 보여줄 위젯만. 근데 Get.put을 반드시 사용
                        return Text(
                          '최소: ${controller.minJeonse.value}',
                        );
                      }),
                    ],
                  ),
                  Column(
                    children: [
                      Obx((){ // Obx 사용 시 따로 Controller 명시 X 보여줄 위젯만. 근데 Get.put을 반드시 사용
                        return Text(
                          '최대: ${controller.maxDeposit.value}',
                        );
                      }),
                      RangeSlider(
                        max: controller.maxD.value.toDouble(),
                        min: controller.minD.value.toDouble(),
                        values: values3,
                        divisions: 50,
                        onChanged: onPickerChanged3,
                        labels: RangeLabels(
                            values3.start.round().toString(),
                            values3.end.round().toString(),
                        ),
                      ),
                      Obx((){ // Obx 사용 시 따로 Controller 명시 X 보여줄 위젯만. 근데 Get.put을 반드시 사용
                        return Text(
                          '최소: ${controller.minDeposit.value}',
                        );
                      }),
                      SizedBox(height: 20,),
                      Obx((){ // Obx 사용 시 따로 Controller 명시 X 보여줄 위젯만. 근데 Get.put을 반드시 사용
                        return Text(
                          '최대: ${controller.maxMonthly.value}',
                        );
                      }),
                      RangeSlider(
                        max: controller.maxM.value.toDouble(),
                        min: controller.minM.value.toDouble(),
                        values: values4,
                        divisions: 50,
                        onChanged: onPickerChanged4,
                        labels: RangeLabels(
                          values4.start.round().toString(),
                          values4.end.round().toString(),
                        ),
                      ),
                      Obx((){ // Obx 사용 시 따로 Controller 명시 X 보여줄 위젯만. 근데 Get.put을 반드시 사용
                        return Text(
                          '최소: ${controller.minMonthly.value}',
                        );
                      }),
                    ],
                  ),
                ]
              ),
            ),
            Column(
              children : [
                Obx((){ // Obx 사용 시 따로 Controller 명시 X 보여줄 위젯만. 근데 Get.put을 반드시 사용
                  return Text(
                    '최대: ${(controller.maxSize.value*0.3025).round()}',
                  );
                }),
                RangeSlider(
                  max: controller.maxZ.value.toDouble(),
                  min: controller.minZ.value.toDouble(),
                  values: values5,
                  divisions: 50,
                  onChanged: onPickerChanged5,
                  labels: RangeLabels(
                    (values5.start*0.3025).round().toString(),
                    (values5.end*0.3025).round().toString(),
                  ),
                ),
                Obx((){ // Obx 사용 시 따로 Controller 명시 X 보여줄 위젯만. 근데 Get.put을 반드시 사용
                  return Text(
                    '최소: ${(controller.minSize.value*0.3025).round()}',
                  );
                }),
              ],
            ),
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
                onPressed: () async {
                  Get.to(() => RegidentialListViewScreen());
                },
                child: const Text(
                  '선택 완료',
                  style: TextStyle(fontSize: 18),
                ),
            ),
          ],
        ),
      ),
    );
  }

  void toggleSelect(int index) async {
      setState(() {
        for(int i = 0; i < isSelected.length; i++) {
          if(i == index) {
            isSelected[i] = true;

            if(i == 1) controller.selectGubun('전세');
            else if(i == 2) controller.selectGubun('월세');
            else controller.selectGubun('매매');

          } else {
            isSelected[i] = false;
          }
        }
        _controller.jumpToPage(index);
      }
    );
  }

  void onPickerChanged(RangeValues value) {
    setState(() {
      values = value;
      controller.minPrice(values.start.round());
      controller.maxPrice(values.end.round());
    });
  }
  void onPickerChanged2(RangeValues value) {
    setState(() {
      values2 = value;
      controller.minJeonse(values2.start.round());
      controller.maxJeonse(values2.end.round());
    });
  }
  void onPickerChanged3(RangeValues value) {
    setState(() {
      values3 = value;
      controller.minDeposit(values3.start.round());
      controller.maxDeposit(values3.end.round());
    });
  }
  void onPickerChanged4(RangeValues value) {
    setState(() {
      values4 = value;
      controller.minMonthly(values4.start.round());
      controller.maxMonthly(values4.end.round());
    });
  }

  void onPickerChanged5(RangeValues value) {
    setState(() {
      values5 = value;
      controller.minSize(values5.start.round());
      controller.maxSize(values5.end.round());
    });
  }

  void   initRangeVlues() {
    values = RangeValues(controller.minS.value.toDouble(), controller.maxS.value.toDouble());
    values2 = RangeValues(controller.minJ.value.toDouble(), controller.maxJ.value.toDouble());
    values3 = RangeValues(controller.minD.value.toDouble(), controller.maxD.value.toDouble());
    values4 = RangeValues(controller.minM.value.toDouble(), controller.maxM.value.toDouble());
    values5 = RangeValues(controller.minZ.value.toDouble(), controller.maxZ.value.toDouble());
    controller.selectGubun('매매');
    _textEditingControllerMin.text = controller.minS.value.toString();
    _textEditingControllerMax.text = controller.maxS.value.toString();
    _list.addAll(List.generate((controller.maxS.value.toInt()/5000).toInt(), (i) => ((i + 1) * 5000)).map((e) => Text('$e만원')).toList());
  }
}