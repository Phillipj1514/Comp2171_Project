class User_Profile{
  String uid;
  String firstname;
  String lastname;
  String username;
  String email;
  // removed because authentication is handled by firebase
  // String password;
  DateTime dob;
  int age;
  double height;
  double weight;
  DateTime dateCreated;
  // Contstructor
  User_Profile(this.uid, this.firstname, this.lastname, this.username, this.email, int month, int day, int year, this.age, this.height, this.weight){
    this.dateCreated = DateTime.now();
    this.dob = new DateTime.utc(year, month, day);
  }
  User_Profile.withDate(this.uid, this.firstname, this.lastname, this.username, this.email, this.dob, this.age, this.height, this.weight, this.dateCreated);


  // getters
  String getUid() => this.uid; 
  
  String getFirstname() => this.firstname;
  
  String getLastname() => this.lastname;
  
  String getName() => this.firstname+" "+this.lastname;
  
  String getUsername() => this.username;

  String getEmail() => this.email;
  
  // String getpassword() => this.password;
  DateTime getDOB() => this.dob;
  
  int getAge() => this.age;
  
  double getHeight() => this.height;
  
  double getWeight() => this.weight;
  
  DateTime getDateCreated() => this.dateCreated;
  
  // setters
  void setUid(String uid) => this.uid = uid;
  
  void setFirstname(String firstname) => this.firstname = firstname;
  
  void setLastname(String lastname) => this.firstname = lastname;
  
  void setUsername(String username) => this.username = username;

  void setEmail(String email) => this.email = email;

  // void setPassword(String password, String confirmPassword){
  //   this.password = (password == confirmPassword) ? password : this.password;
  // }
  void setDOB(int month, int day, int year){
    this.dob = DateTime.utc(year, month, day);
  }
  
  void setAge(int age) => this.age = age;
  
  void setHeight(double height) => this.height =  height;
  
  void setWeight(double weight) => this.weight = weight;
  
  Map<String, dynamic> mapify(){}
}
void main(List<String> args){
  User_Profile ab = new User_Profile("k213nk31kj23n12k3n","John","Paul","jp","j@p.com",3,12,1990,30,5,160);
  // print(ab.getpassword());
  print(ab.getDateCreated().toString());
  print(ab.getDOB().toString());
  // ab.setPassword("new","new");
  // print(ab.getpassword());

}