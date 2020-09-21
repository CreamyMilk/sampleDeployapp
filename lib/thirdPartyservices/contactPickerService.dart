import 'package:fluttercontactpicker/fluttercontactpicker.dart';

class ContactPickerService {
  Future<PhoneContact> getContact() async {
    final PhoneContact contact = await FlutterContactPicker.pickPhoneContact();
    return contact;
  }
}
