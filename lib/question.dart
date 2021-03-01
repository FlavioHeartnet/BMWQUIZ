class Questions {
   int id;
   String question;
   String anwser;

  Questions({this.id, this.question, this.anwser});

  static List<Questions> getAnwsers(){
      return <Questions>[
        Questions(id: 1, anwser: "Germany", question: "BMW"),
        Questions(id: 2, anwser: "Japan", question: "Toyota"),
        Questions(id: 3, anwser: "England", question: "Mini"),
        Questions(id: 4, anwser: "USA", question: "General Motors"),
        Questions(id: 5, anwser: "England", question: "Rolls-Royce")
      ];
  }

}