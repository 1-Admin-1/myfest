class Note {
  final int? id;
  final String title;
  final String description;
  final String address;
  final String addressNumber;

  Note ({
      this.id,
      required this.title,
      required this.description,
      required this.address,
      required this.addressNumber
      });
 
  Note.empty(this.id, this.title, this.description, this.address, this.addressNumber);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'address': address,
      'addressNumber': addressNumber
    };
  }
}
