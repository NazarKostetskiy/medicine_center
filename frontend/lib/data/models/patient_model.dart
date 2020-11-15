class PatientModel {
  final int id;
  final String email, password1, password2, name;
  final String surname, phone_number, patronymic, gender;
  final DateTime birthday;

  PatientModel(this.id, [this.email, this.name, this.surname,
  	this.patronymic, this.phone_number, this.gender, this.birthday]);

  factory PatientModel.fromJson(Map json) {
    final id = json['id'];
    return PatientModel(id);
  }
}