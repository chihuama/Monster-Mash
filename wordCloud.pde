import wordcram.*;
import wordcram.text.*;

WordCram wordCram;
//
//void setup() {
//  size(1000, 300);
//  background(0,170);
//  colorMode(RGB);
//  
//  initWordCram();
//}

void initWordCram(int year1, int year2) {
  createKeywordList(year1, year2);
  wordCram = new WordCram(this)
    .fromTextFile("dataSet/Keywords.txt")
      //.withFont(createFont("../../LiberationSerif-Regular.ttf", 1))
      
      
      // scale according to the scale factor.--------------------------------------
      // change the values here ---------------------------------------------------
      
      .sizedByWeight(9 * scaleFactor , 50 * scaleFactor)             
      
      //--------------------------------------------------------------------------
      //^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
      
        .angledAt(0)
          // .withPlacer(Placers.centerClump())
          // .withPlacer(Placers.horizLine())
          //.withPlacer(Placers.horizBandAnchoredLeft())
           .withPlacer(Placers.wave())

            // For this one, try setting the sketch size to 1000x1000.
            //.withPlacer(Placers.swirl())
            //.sizedByWeight(8, 30)

            //.withPlacer(Placers.upperLeft())
            //.sizedByWeight(10, 40)
            .withColorer(darkerByWeight())
              ;
}

WordColorer darkerByWeight() {
  return new WordColorer() {
    public color colorFor(Word word) {
      int r = (int)random(255);
      int g = (int)random(255);
      int b = (int)random(255);
      return color(r, g, b);
    }
  }; // Don't forget the semi-colon for the return statement.
}

void drawMe(int year1, int year2) {
  
  if (wordCram.hasMore()) {
    wordCram.drawNext();
  }


  ///-------------- change the text size, font, color, placement accordingly
  // -------------------------------------------------------------
  //--------------------------------------------------------------
  textSize(15);
  textAlign(RIGHT, CENTER);
  text(year1 + " to " + year2, width -10, 10);
  //^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  //----------------------------------------------------------------
  //--------------------------------------------------------------



  Word[] words  = wordCram.getWords();  
  Word[] skippedWords = wordCram.getSkippedWords();
  //println(skippedWords);  // Probably a long list!
  // println("Placed " + (words.length - skippedWords.length) + 
  //    " words out of " + words.length);
  for (int i=0; i<words.length; i++) {
    Word word = words[i];

    // This will show either where the word was placed, or why it was skipped.
    //println(word);

    if (word.wasPlaced()) {
      // println(word.word + " was placed!");
    }
    if (word.wasSkipped()) {
      println(word.word + " was skipped!");

      if (word.wasSkippedBecause() == WordCram.NO_SPACE) {
        println(word.word + " was skipped because there was no room");
      }
    }
  }
}




void createKeywordList(int year1, int year2) {
  PrintWriter output = createWriter(sketchPath("") + "/dataSet/Keywords.txt");
  try {
    File file = new File(sketchPath("") + "/dataSet/rawKeywordList.txt");
    FileReader reader = new FileReader(file);
    BufferedReader in = new BufferedReader(reader);

    String string;

    println("started creating keyword for word cloud");
    while ( (string = in.readLine ())!=null) {
      if (string.length() == 0)
        continue;

      String keyword = string.substring(0, string.lastIndexOf("\t"));
      keyword = keyword.trim() + "  ";
      String yearString = string.substring(string.lastIndexOf("\t"), string.length());
      yearString = yearString.trim();
      int yearVal = Integer.valueOf(yearString);

      if (yearVal >= year1 && yearVal <= year2) {
        output.print(keyword);
      }
    }
    in.close();
  }
  catch(IOException e) {
    e.printStackTrace();
  }
  output.flush();
  output.close();
  println("keywords for word cloud created");
}

