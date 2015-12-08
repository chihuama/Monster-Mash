/* 
   CS 424 f12 Proj2 
   Author: Chihua Ma
*/

//int YearStart = 1890, YearEnd = 2012;

// read genreFIle.tsv
String[] GenreList;
int Genres;
int currentGenre = 0;

int GenreListRows;
String[] GenreListTitle;
String[] GenreListGenre;


void readGenre() {
  
  GenreList = loadStrings("genreFile.tsv");
  Genres = GenreList.length;
  
  String[] rows = loadStrings("parsedGenreList.tsv");
  GenreListRows = rows.length;
  
  GenreListTitle = new String[GenreListRows];
  GenreListGenre = new String[GenreListRows];
  
  for (int i=0; i<GenreListRows; i++) {
    String[] columns = split(rows[i], TAB);  // split the row on the tabs
    
    GenreListTitle[i] = columns[0];
    GenreListGenre[i] = columns[1];
  } // end - for
}

void GenreBox(){
  Genre = controlP5.addListBox("myList4",int(graphPlotX2+ (scaleFactor * 30)),int(graphPlotY1+ (scaleFactor * 200)),( scaleFactor * 120),(scaleFactor * 100));
  Genre.setId(4);
  Genre.setItemHeight(scaleFactor * 20);
  Genre.setBarHeight(scaleFactor * 20);
  
  Genre.captionLabel().toUpperCase(true);
  Genre.captionLabel().set("Choose a genre");
  Genre.captionLabel().style().marginTop = (scaleFactor * 5);
  
  for (int i=0; i<Genres; i++) {
    Genre.addItem(GenreList[i], i );
  }
  Genre.setColorBackground(color(50,128));
  Genre.setColorActive(color(0,0,255,128));
}
