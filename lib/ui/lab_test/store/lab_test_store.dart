import 'package:flutter/cupertino.dart';
import 'package:flutter_demo_structure/data/model/lab_test/popular/popular_model.dart';
import 'package:mobx/mobx.dart';

part 'lab_test_store.g.dart';

class LabTestStore = LabTestBase with _$LabTestStore;

abstract class LabTestBase with Store {
  @observable
  ObservableList<PopularModel> cartList = ObservableList<PopularModel>();

  @observable
  TextEditingController dateController = TextEditingController();

  @observable
  String? time;

  @observable
  String? selectedDate;

  @observable
  bool hardCopy = false;

  @observable
  int totalAmount = 0;

  @observable
  int totalDiscount = 0;

  @action
  void wantHardCopy() {
    hardCopy = !hardCopy;
  }


  @action
  void calculateTotalAmount() {
    totalAmount =
        cartList.fold(0, (sum, element) => sum + element.amount);
  }

  @action
  void calculateTotalDiscount() {
    totalDiscount =
        cartList.fold(0, (sum, element) => sum + element.discount);
  }


}