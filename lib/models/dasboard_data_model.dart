class DashboardDataModel {

  String? accessToken;
  String? fullName;
  String? qualification;
  String? speciality;
  String? contactNumber;
  String? email;
  String? image;
  String? id;
  DashboardDataModel({
     this.accessToken, this.fullName,
     this.qualification,  this.speciality,
     this.contactNumber,  this.email,
     this.image,  this.id});

  get name => null;


  Map<String,dynamic> toJson(){
    Map <String, dynamic> map;

    map = {
      "accessToken":accessToken,
      "fullName":fullName,
      "qualification":qualification,
      "speciality":speciality,
      "contactNumber":contactNumber,
      "email":email,
      "image":image,
      "id":id
    };
    return map;


  }




  DashboardDataModel fromJson(Map<String,dynamic> map){
    DashboardDataModel dataModel = DashboardDataModel(
    id: map['id'],
        accessToken:map['accessToken'],
        fullName:map['fullName'],
        qualification:map['qualification'],
        speciality:map['speciality'],
        contactNumber:map['contactNumber'],
        email:map['email'],
        image:map['image'],

    );
    return dataModel;
  }

}