import 'Contact.dart';

//     "status": 200,
//     "message": "Contact Added Successfully",
//     "data": {
//         "phone": "43646",
//         "email": "ssags@gmail.com",
//         "updated_at": "2023-12-14T18:50:02.000000Z",
//         "created_at": "2023-12-14T18:50:02.000000Z",
//         "id": 9
//     }
// }
class ApiResponse {
  final bool? status;
  final String? message;
  final Contact? data;

  ApiResponse({this.status, required this.message, this.data});
  factory ApiResponse.fromJson(Map<String, dynamic> json) {
     bool status = json['status'] != null ? json['status'] as bool : false;
    String? message  =json['message'] != null ? json['message'] as String : null;
    Contact? contact = json['data'] != null ? Contact.fromJson(json['data']) : null;
    return ApiResponse(
      status: status,
      message: message,
      data: contact,
    );
  }
}
