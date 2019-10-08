const String addReview =
    """mutation addReview(\$inventoryId:String,\$rating:Float,\$text:String){
    addReview(inventoryId:\$inventoryId,rating:\$rating,text:\$text){
   error{
     path
     message
   }
 }
}
""";
