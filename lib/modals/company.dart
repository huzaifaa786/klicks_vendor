class Company {
  int? company_id;
  String? name;
  String? email;
  String? apiToken;
  String? phone;
  String? suv_price;
  String? sedan_price;
  String? username;
   

  Company(company) {
    company_id = company['id'];
    name = company['name'];
    email = company['email'];
    apiToken = company['api_token'] ?? '';
    phone = company['phone'];
    suv_price = company['suv_price'];
    sedan_price = company['sedan_price'];
    username = company['username'];
   
  }
}
