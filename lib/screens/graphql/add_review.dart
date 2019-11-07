const String addReview =
    """mutation addReview(\$inventoryId:String,\$rating:Float,\$text:String,\$images:String){
    addReview(inventoryId:\$inventoryId,rating:\$rating,text:\$text,images:\$images){
   error{
     path
     message
   }
 }
}
""";
