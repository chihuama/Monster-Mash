/* 
   CS 424 f12 Proj2 
   Author: Chihua Ma
*/

//int YearStart = 1890, YearEnd = 2012;

// read MonsterList.txt
String[] MonsterList;
int noOfMonsters;
int currentMonster = 0;

// read KeywordList.tsv
int[][] MonsterNum;
float MonsterMax, MonsterMin;
int KeywordListRows;

String[] KeywordListTitle;
String[] KeywordListMonster;
String[] KeywordListYear;


void readKeyword() {
  
  //MonsterList = loadStrings("MonsterList.txt");
  MonsterList = loadStrings("keywordFile.tsv");
  noOfMonsters = MonsterList.length;
  
  // Initial MonsterNum[][]
  MonsterNum = new int[YearEnd-YearStart+1][noOfMonsters];
  for(int i=0; i<=(YearEnd-YearStart); i++) {
    for(int j=0; j<noOfMonsters; j++) {
      MonsterNum[i][j] = 0;
    }
  }
  
  String[] rows = loadStrings("KeywordList.tsv");
  KeywordListRows = rows.length;
  
  KeywordListTitle = new String[KeywordListRows];
  KeywordListMonster = new String[KeywordListRows];
  KeywordListYear = new String[KeywordListRows];
  
  for (int i=0; i<KeywordListRows; i++) {
    String[] columns = split(rows[i], TAB);  // split the row on the tabs
    
    KeywordListTitle[i] = columns[0];
    KeywordListMonster[i] = columns[1];
    KeywordListYear[i] = columns[2];
    
    // count the # of monster movies over entire timeline
    for (int j=YearStart; j<=YearEnd; j++) {
      String years = ""+j;
      if (columns[2].equals(years)) {
        MonsterNum[j-YearStart][0] = TotalNum[j-YearStart];
        
        // count the # of a particular monster movie
        for (int m=0; m<noOfMonsters; m++) {
          if (columns[1].equals(MonsterList[m])) {
            //if (currentFormat==0) {
            MonsterNum[j-YearStart][m]++;
            /*} else {
            for (int r=0; r<MovieListRows; r++) {
              if ((MovieListTitle[r].equals( KeywordListTitle[i]))&&(MovieListFormat[r].equals(FormatList[currentFormat]))) {
                MonsterNum[j-YearStart][m]++;
              }
            }
            } // end -if -else*/
          }
        } // end - for
      } // end -if      
    } // end - for  
  } // end - for
}


float getMax(int col) {
  float m = -Float.MAX_VALUE;
  for (int i=0; i<=(YearEnd-YearStart); i++) {
    if (MonsterNum[i][col] > m) {
      m = MonsterNum[i][col];
    }
  }
  return m;
}

float getMin(int col) {
  float m = Float.MAX_VALUE;
  for (int i=0; i<=(YearEnd-YearStart); i++) {
    if (MonsterNum[i][col] < m) {
      m = MonsterNum[i][col];
    }
  }
  return m;
}


void KeywordListBox(){
  MonsterType = controlP5.addListBox("myList1",int(graphPlotX2+ (scaleFactor * 30)),int(graphPlotY1+ (scaleFactor * 30)),( scaleFactor * 120),(scaleFactor * 120));
  MonsterType.setId(1);
  MonsterType.setItemHeight(scaleFactor * 20);
  MonsterType.setBarHeight(scaleFactor * 20);
  
  MonsterType.captionLabel().toUpperCase(true);
  MonsterType.captionLabel().set("Choose Monster Type");
  MonsterType.captionLabel().style().marginTop = (scaleFactor * 5);
  
  for (int i=0; i<noOfMonsters; i++) {
    MonsterType.addItem(MonsterList[i], i );
  }
  MonsterType.setColorBackground(color(50,128));
  MonsterType.setColorActive(color(0,0,255,128));
}
