const String addQuestion =
    """mutation AddQuestion(\$questionText:String,\$inventoryId:String){
    addQuestion(questionText:\$questionText,inventoryId:\$inventoryId){
   error{
     path
     message
   }
    
 }
}""";
