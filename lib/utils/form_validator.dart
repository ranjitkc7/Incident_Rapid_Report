class FormValidator {
  static String? validateName(String? value){
    if(value!.trim().isEmpty){
      return "Name is required";
    }
    return null;
  }
 

 static String? validateEmail(String? value){
  if(value!.trim().isEmpty){
    return "Email is required";
  }
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if(!emailRegex.hasMatch(value)){
    return "Enter a valid email address";
  }
  return null;
 }
  

  static String? validatePassword(String? value){
    if(value!.trim().isEmpty){
      return "Password is required";
    }

    if(value.length < 8){
      return "Password must be at least 8 characters long";
    }

    if(!RegExp(r'[A-Z]').hasMatch(value)){
      return "Password must contain at least one uppercase letter";
    }

    if(!RegExp(r'[a-z]').hasMatch(value)){
      return "Password must contain at least one lowercase letter";
    }

    if(!RegExp(r'[0-9]').hasMatch(value)){
      return "Password must contain at least one digit";
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
        return "Password must contain at least one special character";
   }
    return null;
  }

  static String? validateConfirmPassword(String? password, String? confirmPassword){
    if(confirmPassword!.trim().isEmpty){
      return "Please re-enter the password";
    }
    if(password != confirmPassword){
      return "Passwords do not match";
    }
    return null;
  }
}
