const String getQA = """query getQA(\$inventoryId:String){
  getQA(inventoryId:\$inventoryId){
    questionText
    answerText
    }
}
""";
