/* 
   CS 424 f12 Proj2 
   Author: Chihua Ma
*/

void recalculate() {
  // Initial MonsterNum[][]
  //MonsterNum = new float[YearEnd-YearStart+1][noOfMonsters];
  //if (graphID==0) {
  for(int i=0; i<=(YearEnd-YearStart); i++) {
    for(int j=0; j<noOfMonsters; j++) {
      MonsterNum[i][j] = 0;
    }
  }
  /*} else {
    for(int i=0; i<=(YearEnd-YearStart); i++) {
      MonsterNum[i][currentColumn] = 0;
    }
  }*/
  
  if (currentColumn==0) {
    graphID = 1;
    graphs[0] = currentColumn;
  }
  
  for (int g=0; g<graphID; g++) {
  for (int j=YearStart; j<=YearEnd; j++) {
    String years = ""+j;

    if (currentColumn==0) {
      if (currentFormat==0) {
        if (currentCountry==0) {
          if (currentGenre==0) {
            //MonsterNum[j-YearStart][currentColumn] = TotalNum[j-YearStart];
            for (int r=0; r<MovieListRows; r++) {
              if ((MovieListYear[r].equals(years))&&((RatingMin<=MovieListIMDB_Rating[r])&&(MovieListIMDB_Rating[r]<=RatingMax))&&((VotesMin<=MovieListVote[r])&&(MovieListVote[r]<=VotesMax))) {
                //MonsterNum[j-YearStart][currentColumn]++;
                MonsterNum[j-YearStart][graphs[g]]++;
              }
            }
          } // end - case 1 (0000)
          else {
            for (int r=0; r<MovieListRows; r++) {
              if ((MovieListYear[r].equals(years))&&(MovieListGenre[r].contains(GenreList[currentGenre]))&&((RatingMin<=MovieListIMDB_Rating[r])&&(MovieListIMDB_Rating[r]<=RatingMax))&&((VotesMin<=MovieListVote[r])&&(MovieListVote[r]<=VotesMax))) {
                //MonsterNum[j-YearStart][currentColumn]++;
                MonsterNum[j-YearStart][graphs[g]]++;
              }
            }
          } // end - case 2 (0001)
        } // end - case 1&2 (0000, 0001)
        else {
          if (currentGenre==0) {
            for (int r=0; r<MovieListRows; r++) {
              if ((MovieListYear[r].equals(years))&&(MovieListCountry[r].equals(CountryList[currentCountry]))&&((RatingMin<=MovieListIMDB_Rating[r])&&(MovieListIMDB_Rating[r]<=RatingMax))&&((VotesMin<=MovieListVote[r])&&(MovieListVote[r]<=VotesMax))) {
                //MonsterNum[j-YearStart][currentColumn]++;
                MonsterNum[j-YearStart][graphs[g]]++;
              }
            }
          } // end - case 3 (0010)
          else {
            for (int r=0; r<MovieListRows; r++) {
              if ((MovieListYear[r].equals(years))&&(MovieListCountry[r].equals(CountryList[currentCountry]))&&(MovieListGenre[r].contains(GenreList[currentGenre]))&&((RatingMin<=MovieListIMDB_Rating[r])&&(MovieListIMDB_Rating[r]<=RatingMax))&&((VotesMin<=MovieListVote[r])&&(MovieListVote[r]<=VotesMax))) {
                //MonsterNum[j-YearStart][currentColumn]++;
                MonsterNum[j-YearStart][graphs[g]]++;
              }
            }
          } // end - case 4 (0011)
        } // end - case 3&4 (0010, 0011)
      } // end 1-4 (00XX)
      else {
        if (currentCountry==0) {
          if (currentGenre==0) {
            for (int r=0; r<MovieListRows; r++) {
              if ((MovieListYear[r].equals(years))&&(MovieListFormat[r].equals(FormatList[currentFormat]))&&((RatingMin<=MovieListIMDB_Rating[r])&&(MovieListIMDB_Rating[r]<=RatingMax))&&((VotesMin<=MovieListVote[r])&&(MovieListVote[r]<=VotesMax))) {
                //MonsterNum[j-YearStart][currentColumn]++;
                MonsterNum[j-YearStart][graphs[g]]++;
              }
            }
          } // end - case 5 (0100)
          else {
            for (int r=0; r<MovieListRows; r++) {
              if ((MovieListYear[r].equals(years))&&(MovieListFormat[r].equals(FormatList[currentFormat]))&&(MovieListGenre[r].contains(GenreList[currentGenre]))&&((RatingMin<=MovieListIMDB_Rating[r])&&(MovieListIMDB_Rating[r]<=RatingMax))&&((VotesMin<=MovieListVote[r])&&(MovieListVote[r]<=VotesMax))) {
                //MonsterNum[j-YearStart][currentColumn]++;
                MonsterNum[j-YearStart][graphs[g]]++;
              }
            }
          } // end - case 6 (0101)
        } // end - case 5&6 (0100, 0101)
        else {
          if (currentGenre==0) {
            for (int r=0; r<MovieListRows; r++) {
              if ((MovieListYear[r].equals(years))&&(MovieListFormat[r].equals(FormatList[currentFormat]))&&(MovieListCountry[r].equals(CountryList[currentCountry]))&&((RatingMin<=MovieListIMDB_Rating[r])&&(MovieListIMDB_Rating[r]<=RatingMax))&&((VotesMin<=MovieListVote[r])&&(MovieListVote[r]<=VotesMax))) {
                //MonsterNum[j-YearStart][currentColumn]++;
                MonsterNum[j-YearStart][graphs[g]]++;
              }
            }
          } // end - case 7 (0110)
          else {
            for (int r=0; r<MovieListRows; r++) {
              if ((MovieListYear[r].equals(years))&&(MovieListFormat[r].equals(FormatList[currentFormat]))&&(MovieListCountry[r].equals(CountryList[currentCountry]))&&(MovieListGenre[r].contains(GenreList[currentGenre]))&&((RatingMin<=MovieListIMDB_Rating[r])&&(MovieListIMDB_Rating[r]<=RatingMax))&&((VotesMin<=MovieListVote[r])&&(MovieListVote[r]<=VotesMax))) {
                //MonsterNum[j-YearStart][currentColumn]++;
                MonsterNum[j-YearStart][graphs[g]]++;
              }
            }
          } // end - case 8 (0111)
        } // end - case 7&8 (0110, 0111)
      } // end 5-8 (01XX)
    } // end 1-8 (0XXX)
    
    for (int i=0; i<KeywordListRows; i++) {
      if (KeywordListYear[i].equals(years)) {
        //if (KeywordListMonster[i].equals(MonsterList[currentColumn])) {
        if (KeywordListMonster[i].equals(MonsterList[graphs[g]])) {
          if (currentFormat==0) {
            if (currentCountry==0) {
              if (currentGenre==0) {
                //MonsterNum[j-YearStart][currentColumn]++;
                for (int r=0; r<MovieListRows; r++) {
                  if ((MovieListTitle[r].equals( KeywordListTitle[i]))&&((RatingMin<=MovieListIMDB_Rating[r])&&(MovieListIMDB_Rating[r]<=RatingMax))&&((VotesMin<=MovieListVote[r])&&(MovieListVote[r]<=VotesMax))) {
                    //MonsterNum[j-YearStart][currentColumn]++;
                    MonsterNum[j-YearStart][graphs[g]]++;
                  }
                }
              } // end - case 9 (1000)
              else {
                for (int r=0; r<MovieListRows; r++) {
                  if ((MovieListTitle[r].equals( KeywordListTitle[i]))&&(MovieListGenre[r].contains(GenreList[currentGenre]))&&((RatingMin<=MovieListIMDB_Rating[r])&&(MovieListIMDB_Rating[r]<=RatingMax))&&((VotesMin<=MovieListVote[r])&&(MovieListVote[r]<=VotesMax))) {
                    //MonsterNum[j-YearStart][currentColumn]++;
                    MonsterNum[j-YearStart][graphs[g]]++;
                  }
                }
              } // end - case 10 (1001)
            } // end - case 9&10 (1000,1001)
            else {
              if (currentGenre==0) {
                for (int r=0; r<MovieListRows; r++) {
                  if ((MovieListTitle[r].equals( KeywordListTitle[i]))&&(MovieListCountry[r].equals(CountryList[currentCountry]))&&((RatingMin<=MovieListIMDB_Rating[r])&&(MovieListIMDB_Rating[r]<=RatingMax))&&((VotesMin<=MovieListVote[r])&&(MovieListVote[r]<=VotesMax))) {
                    //MonsterNum[j-YearStart][currentColumn]++;
                    MonsterNum[j-YearStart][graphs[g]]++;
                  }
                }
              } // end - case 11 (1010)
              else {
                for (int r=0; r<MovieListRows; r++) {
                  if ((MovieListTitle[r].equals( KeywordListTitle[i]))&&(MovieListCountry[r].equals(CountryList[currentCountry]))&&(MovieListGenre[r].contains(GenreList[currentGenre]))&&((RatingMin<=MovieListIMDB_Rating[r])&&(MovieListIMDB_Rating[r]<=RatingMax))&&((VotesMin<=MovieListVote[r])&&(MovieListVote[r]<=VotesMax))) {
                    //MonsterNum[j-YearStart][currentColumn]++;
                    MonsterNum[j-YearStart][graphs[g]]++;
                  }
                }
              } // end - case 12 (1011)
            } // end - case 11&12 (1010, 1011)
          } // end 9-12 (10XX)
          
          else {
            if (currentCountry==0) {
              if (currentGenre==0) {
                for (int r=0; r<MovieListRows; r++) {
                  if ((MovieListTitle[r].equals( KeywordListTitle[i]))&&(MovieListFormat[r].equals(FormatList[currentFormat]))&&((RatingMin<=MovieListIMDB_Rating[r])&&(MovieListIMDB_Rating[r]<=RatingMax))&&((VotesMin<=MovieListVote[r])&&(MovieListVote[r]<=VotesMax))) {
                    //MonsterNum[j-YearStart][currentColumn]++;
                    MonsterNum[j-YearStart][graphs[g]]++;
                  }
                }
              } // end - case 13 (1100)
              else {
                for (int r=0; r<MovieListRows; r++) {
                  if ((MovieListTitle[r].equals( KeywordListTitle[i]))&&(MovieListFormat[r].equals(FormatList[currentFormat]))&&(MovieListGenre[r].contains(GenreList[currentGenre]))&&((RatingMin<=MovieListIMDB_Rating[r])&&(MovieListIMDB_Rating[r]<=RatingMax))&&((VotesMin<=MovieListVote[r])&&(MovieListVote[r]<=VotesMax))) {
                    //MonsterNum[j-YearStart][currentColumn]++;
                    MonsterNum[j-YearStart][graphs[g]]++;
                  }
                }
              } // end - case 14 (1101)
            } // end - case 13&14 (1100, 1101)
            else {
              if (currentGenre==0) {
                for (int r=0; r<MovieListRows; r++) {
                  if ((MovieListTitle[r].equals( KeywordListTitle[i]))&&(MovieListFormat[r].equals(FormatList[currentFormat]))&&(MovieListCountry[r].equals(CountryList[currentCountry]))&&((RatingMin<=MovieListIMDB_Rating[r])&&(MovieListIMDB_Rating[r]<=RatingMax))&&((VotesMin<=MovieListVote[r])&&(MovieListVote[r]<=VotesMax))) {
                    //MonsterNum[j-YearStart][currentColumn]++;
                    MonsterNum[j-YearStart][graphs[g]]++;
                  }
                }
              } // end - case 15 (1110)
              else {
                for (int r=0; r<MovieListRows; r++) {
                  if ((MovieListTitle[r].equals( KeywordListTitle[i]))&&(MovieListFormat[r].equals(FormatList[currentFormat]))&&(MovieListCountry[r].equals(CountryList[currentCountry]))&&(MovieListGenre[r].contains(GenreList[currentGenre]))&&((RatingMin<=MovieListIMDB_Rating[r])&&(MovieListIMDB_Rating[r]<=RatingMax))&&((VotesMin<=MovieListVote[r])&&(MovieListVote[r]<=VotesMax))) {
                    //MonsterNum[j-YearStart][currentColumn]++;
                    MonsterNum[j-YearStart][graphs[g]]++;
                  }
                }
              } // end - case 16 (1111)
            } // end - case 15&16 (1110, 1111)
          } // end 13-16 (11XX)
        }
      }
    }// end 9-16 (1XXX)
    
  }// end - for
  }
}
