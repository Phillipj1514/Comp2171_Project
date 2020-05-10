class User_Profile{
  String firstname;
  String lastname;
  String username;
  String password;
  DateTime dob;
  int age;
  double height;
  double weight;
  DateTime dateCreated;
  // Contstructor
  User_Profile(this.firstname, this.lastname, this.username, this.password, int month, int day, int year, this.age, this.height, this.weight){
    this.dateCreated = DateTime.now();
    this.dob = new DateTime.utc(year, month, day);
  }

  // getters
  String getFirstname() => this.firstname;
  String getLastname() => this.lastname;
  String getName() => this.firstname+" "+this.lastname;
  String getUsername() => this.username;
  String getpassword() => this.password;
  DateTime getDOB() => this.dob;
  int getAge() => this.age;
  double getHeight() => this.height;
  double getWeight() => this.weight;
  DateTime getDateCreated() => this.dateCreated;
  
  // setters

  void setFirstname(String firstname) => this.firstname = firstname;
  void setLastname(String lastname) => this.firstname = lastname;
  void setUsername(String username) => this.username = username;
  void setPassword(String password, String confirmPassword){
    this.password = (password == confirmPassword) ? password : this.password;
  }
  void setDOB(int month, int day, int year){
    this.dob = DateTime.utc(year, month, day);
  }
  void setAge(int age) => this.age = age;
  void setHeight(double height) => this.height =  height;
  void setWeight(double weight) => this.weight = weight;
}
void main(List<String> args){
  User_Profile ab = new User_Profile("John","Paul","jp","pswd",3,12,1990,30,5,160);
  print(ab.getpassword());
  print(ab.getDateCreated().toString());
  print(ab.getDOB().toString());
  ab.setPassword("new","new");
  print(ab.getpassword());

}