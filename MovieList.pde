/* 
   CS 424 f12 Proj2 
   Author: Chihua Ma
*/

//int YearStart = 1890, YearEnd = 2012;
float RatingMin = 0, RatingMax =10;
int VotesMin = 5, VotesMax = 834096;

int[] TotalNum;
int MovieListRows;

String[] MovieListTitle;
String[] MovieListYear;
float[] MovieListIMDB_Rating;
float[] MovieListVote;
String[] MovieListFormat;
String[] MovieListCountry;
String[] MovieListGenre;

String[] FormatList;
int Formats;
int currentFormat = 0;

String[] CountryList;
int Countries;
int currentCountry = 0;


void readMovie() {
  
  FormatList = loadStrings("formatFile.tsv");
  Formats = FormatList.length;
  
  CountryList = loadStrings("countryFile.tsv");
  Countries = CountryList.length;
  
  // Initial TotalNum[]
  TotalNum = new int[YearEnd-YearStart+1];
  for(int i=0; i<=(YearEnd-YearStart); i++) {
    TotalNum[i] = 0;
  }
  
  String[] rows = loadStrings("MovieList.tsv");
  MovieListRows = rows.length;
  
  MovieListTitle = new String[MovieListRows];
  MovieListYear = new String[MovieListRows];
  MovieListIMDB_Rating = new float[MovieListRows];
  MovieListVote = new float[MovieListRows];
  MovieListFormat = new String[MovieListRows];
  MovieListCountry = new String[MovieListRows];
  MovieListGenre = new String[MovieListRows];
  
  for (int i=0; i<MovieListRows; i++) {
    String[] columns = split(rows[i], TAB);  // split the row on the tabs  
    MovieListTitle[i] = columns[0];  
    MovieListYear[i] = columns[1];
    MovieListIMDB_Rating[i] = parseFloat(columns[2]);
    //MovieListIMDB_Rating[i] = float(trim(columns[2]));
    MovieListVote[i] = parseFloat(columns[3]);
    //MovieListVote[i] = float(trim(columns[3]));
    MovieListFormat[i] = columns[4];
    MovieListCountry[i] = columns[5];
    MovieListGenre[i] = columns[9];
    
    // count the # of monster movies over entire timeline
    for (int j=YearStart; j<=YearEnd; j++) {
      String years = ""+j;
      if (columns[1].equals(years)) {
        TotalNum[j-YearStart]++;        
      } // end -if      
    } // end - for  
    
  } // end - for 
  
}

void FormatBox(){
  Format = controlP5.addListBox("myList2",int(graphPlotX2+ (scaleFactor * 30)),int(graphPlotY1+ (scaleFactor * 80)),( scaleFactor * 120),(scaleFactor * 80));
  Format.setId(2);
  Format.setItemHeight(scaleFactor * 20);
  Format.setBarHeight(scaleFactor * 20);
  
  Format.captionLabel().toUpperCase(true);
  Format.captionLabel().set("Choose a Format");
  Format.captionLabel().style().marginTop = (scaleFactor * 5);
  
  for (int i=0; i<Formats; i++) {
    Format.addItem(FormatList[i], i);
  }
  
  Format.setColorBackground(color(50,128));
  Format.setColorActive(color(0,0,255,128));
}

void CountryBox(){
  Country = controlP5.addListBox("myList3",int(graphPlotX2+ (scaleFactor * 30)),int(graphPlotY1+ (scaleFactor * 30)),( scaleFactor * 120),(scaleFactor * 100));
  Country.setId(3);
  Country.setItemHeight(scaleFactor * 20);
  Country.setBarHeight(scaleFactor * 20);
  
  Country.captionLabel().toUpperCase(true);
  Country.captionLabel().set("Choose a Country");
  Country.captionLabel().style().marginTop = (scaleFactor * 5);
  
  for (int i=0; i<Countries; i++) {
    Country.addItem(CountryList[i], i);
  }
  
  Country.setColorBackground(color(50,128));
  Country.setColorActive(color(0,0,255,128));
}
