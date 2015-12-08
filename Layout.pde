/*
Author:Galen Thomas-Ramos
 CS-424;  Fall 2012
 */

import controlP5.*;

PImage divisorLine;
String[] splatterArray = new String[3];

float textPlacementPadX, textPlacementPadY;

float mainMenuPlotX1, mainMenuPlotX2, mainMenuPlotY1, mainMenuPlotY2;
float menuTabTop, menuTabBottom;
float menuTabLeft, menuTabMid, menuTabRight;

float projectTitlePlotX, projectTitlePlotY;

float overviewButtonPlotX1, overviewButtonPlotY1, overviewButtonPlotX2, overviewButtonPlotY2;
float overviewMenuPlotX1, overviewMenuPlotX2, overviewMenuPlotY1, overviewMenuPlotY2;
float overviewExitButtonPlotX1, overviewExitButtonPlotY1, overviewExitButtonPlotX2, overviewExitButtonPlotY2;

String[] filterChoices; // Holds Strings of filter titles
float[] menuButtonTopPlots;
float[] menuButtonBottomPlots;

boolean[] countriesChosen;
boolean allCountryFilterValues;

float[] monsterFilterButtonTopPlots;
float[] monsterFilterButtonBottomPlots;
float[] monsterFilterButtonLeftPlots;
float[] monsterFilterButtonRightPlots;
float monsterFilterBackX1, monsterFilterBackX2, monsterFilterBackY1, monsterFilterBackY2;
boolean[] monstersChosen;
String[] monsterNames;
boolean allMonsterFilterValues;


float[] genreFilterButtonTopPlots;
float[] genreFilterButtonBottomPlots;
float[] genreFilterButtonLeftPlots;
float[] genreFilterButtonRightPlots;
String[] genreNames;
boolean[] genresChosen;
boolean allGenreFilterValues;

float[] formatFilterButtonTopPlots;
float[] formatFilterButtonBottomPlots;
float formatFilterButtonLeftPlot;
float formatFilterButtonRightPlot;
boolean[] formatsChosen;
boolean allFormatFilterValues;
String[] formatNames;


float[] certificationFilterButtonTopPlots;
float[] certificationFilterButtonBottomPlots;
float certificationFilterButtonRightPlot;
float certificationFilterButtonLeftPlot;
String[] certificationNames;
boolean[] certificationsChosen;
boolean allCertificateFilterValues;

float menuButtonLeftPlot;
float menuButtonMidPlot;
float menuButtonRightPlot;

PFont projectTitleFont;
PFont menuItemFont;

PImage splatter1;
PImage splatter2;
PImage splatter3;
PImage chosenSplatter;

float divisorLinePlotX, divisorLinePlotY1, divisorLinePlotY2;

int indexOfChosenSplatter;

boolean timelineMenuChosen;
boolean comparisonGraphMenuChosen;
boolean overviewMenuChosen;

boolean[] filterButtonChosen;  //Holds boolean values for which filter has been enabled (only one boolean can be true within the array at one time, or none)
boolean filterWasClicked;
boolean filterButtonReset;

/*
boolean timelineFilterMonsters;
 boolean timelineFilterGenre;
 boolean timelineFilterCountryOfOrigin;
 boolean timelineFilterBudget;
 boolean timelineFilterFormat;
 boolean timelineFilterFilmRating;
 boolean timelineFilterBudgetCategory;
 boolean timelineFilterIMDBRating;
 boolean timelineFilterIMDBVotes
 
 boolean comparisonGraphFilterMonsters;
 boolean comparisonGraphFilterGenre
 boolean comparisonGraphFilterCountryOfOrign
 boolean comparisonGraphFilterBudget
 boolean comparisonGraphFilterFormat
 boolean comparisonGraphFilterFilmRating
 boolean comparisonGraphFilterBudgetCategory;
 boolean comparisonGraphFilterIMDBRating;
 boolean comparisonGraphFilterIMDBVotes
 */

boolean splatterHasBeenChosen;

void definePlots() {
  //
  //
  //PLOTS FOR MENUS
  mainMenuPlotX1 = divisorLinePlotX + (scaleFactor * 10);
  mainMenuPlotY1 = graphPlotY1 + (scaleFactor * 80);
  mainMenuPlotX2 = width - (scaleFactor * 10);
  mainMenuPlotY2 = graphPlotY2 + (scaleFactor * 10);

  projectTitlePlotX = width - (scaleFactor * 10);
  projectTitlePlotY = (scaleFactor * 20);

  divisorLinePlotX = graphPlotX2 + (scaleFactor * 150);
  divisorLinePlotY1 = 0;
  divisorLinePlotY2 = height;

  menuButtonTopPlots = new float[4];      //Holds top positions of menu buttons for both menus
  menuButtonBottomPlots = new float[4];   //Holds bottom positions of menu buttons for both menus
  menuButtonLeftPlot = mainMenuPlotX1 + (scaleFactor * 10);
  menuButtonRightPlot = mainMenuPlotX2 - (scaleFactor * 10);
  menuButtonMidPlot = ((menuButtonRightPlot - menuButtonLeftPlot) / 2) + menuButtonLeftPlot;


  menuTabTop = mainMenuPlotY1 - (scaleFactor * 30);
  menuTabBottom = mainMenuPlotY1;
  menuTabLeft = mainMenuPlotX1;
  menuTabMid = mainMenuPlotX1 + ((mainMenuPlotX2 - mainMenuPlotX1) / 2);
  menuTabRight = mainMenuPlotX2;

  //
  //
  //Populate menuButtons bottom and top coords
  float tempCoord = mainMenuPlotY1 + (scaleFactor * 10);
  for (int i = 0; i < 4; i++) {
    menuButtonTopPlots[i] = tempCoord;
    menuButtonBottomPlots[i] = tempCoord + (scaleFactor * 40);
    tempCoord = menuButtonBottomPlots[i] + (scaleFactor * 10);
  }

  //
  //
  //Overview Menu/ button stuff
  overviewMenuPlotX1 = (scaleFactor * 5);
  overviewMenuPlotX2 = width - (scaleFactor * 5);
  overviewMenuPlotY1 = (scaleFactor * 5);
  overviewMenuPlotY2 = height - (scaleFactor * 5);

  overviewExitButtonPlotX1 = width - (scaleFactor * 200);
  overviewExitButtonPlotY1 = height - (scaleFactor * 70);
  overviewExitButtonPlotX2 = width - (scaleFactor * 30);
  overviewExitButtonPlotY2 = height - (scaleFactor * 30);

  overviewButtonPlotX1 = width - (scaleFactor * 150);
  overviewButtonPlotY1 = projectTitlePlotY + (scaleFactor * 27);
  overviewButtonPlotX2 = projectTitlePlotX;
  overviewButtonPlotY2 = projectTitlePlotY + (scaleFactor * 55);

  //
  //
  //PLOTS FOR MONSTER FILTER BUTTONS
  monsterFilterButtonTopPlots = new float[7];
  monsterFilterButtonBottomPlots = new float[7];
  monsterFilterButtonLeftPlots = new float[7];
  monsterFilterButtonRightPlots = new float[7];

  float topTemp = graphPlotY1 + (scaleFactor * 10);
  float bottomTemp = topTemp + (scaleFactor * 40);
  float leftTemp = graphPlotX1 + (scaleFactor * 110);
  float rightTemp = leftTemp + (scaleFactor * 130);

  for ( int i = 0; i < 7; i++) {              //Populate Top, Bottom, Left and Right arrays which hold coords of monster filter buttons
    monsterFilterButtonTopPlots[i] = topTemp;
    monsterFilterButtonBottomPlots[i] = bottomTemp;
    monsterFilterButtonLeftPlots[i] = leftTemp;
    monsterFilterButtonRightPlots[i] = rightTemp;

    topTemp = bottomTemp + (scaleFactor * 10);
    bottomTemp = topTemp + (scaleFactor * 40);
    leftTemp = rightTemp + (scaleFactor * 20);
    rightTemp = leftTemp + (scaleFactor * 130);
  }

  monsterFilterBackX1 = divisorLinePlotX - (scaleFactor * 150);
  monsterFilterBackX2 = monsterFilterBackX1 + (scaleFactor * 130);
  monsterFilterBackY1 = height - (scaleFactor * 80);
  monsterFilterBackY2 = monsterFilterBackY1 + (scaleFactor * 40);



  genreFilterButtonTopPlots = new float[9];
  genreFilterButtonBottomPlots = new float[9];
  genreFilterButtonLeftPlots = new float[3];
  genreFilterButtonRightPlots = new float[3];

  float genreTopTemp = 0 + (scaleFactor * 20);
  float genreLeftTemp = graphPlotMidX + (scaleFactor * 195);

  for (int i = 0; i < 9; i++) {        //For top and bottom coords of genre filter buttons
    genreFilterButtonTopPlots[i] = genreTopTemp;
    genreFilterButtonBottomPlots[i] = genreFilterButtonTopPlots[i] + (scaleFactor * 38);

    genreTopTemp = genreFilterButtonBottomPlots[i] + (scaleFactor * 10);
  }

  for (int i = 0; i < 3; i++) {        //For Left and right coords of genre filter buttons
    genreFilterButtonLeftPlots[i] = genreLeftTemp;
    genreFilterButtonRightPlots[i] = genreFilterButtonLeftPlots[i] + (scaleFactor * 135);

    genreLeftTemp = genreFilterButtonRightPlots[i] + (scaleFactor * 20);
  }

  float tempTop = graphPlotMidY - (scaleFactor * 50);
  float tempBottom = tempTop + (scaleFactor * 40);

  formatFilterButtonTopPlots = new float[4];
  formatFilterButtonBottomPlots = new float[4];
  formatFilterButtonLeftPlot = divisorLinePlotX - (scaleFactor * 170);
  formatFilterButtonRightPlot = divisorLinePlotX - (scaleFactor * 15);

  for ( int i = 0; i < 4; i++) { 
    formatFilterButtonTopPlots[i] = tempTop;
    formatFilterButtonBottomPlots[i] = tempBottom;

    tempTop = tempBottom + (scaleFactor * 10);
    tempBottom = tempTop + (scaleFactor * 40);
  }


  certificationFilterButtonTopPlots = new float[6];
  certificationFilterButtonBottomPlots = new float[6];
  float certificationFilterButtonRightPlot = divisorLinePlotX - (scaleFactor * 170);
  float certificationFilterButtonLeftPlot = divisorLinePlotX - (scaleFactor * 15);

  float certificationTopTemp = graphPlotMidY - (scaleFactor * 90);

  for ( int i = 0; i < 6; i++) { 
    certificationFilterButtonTopPlots[i] = certificationTopTemp;
    certificationFilterButtonBottomPlots[i] = certificationFilterButtonTopPlots[i] + (scaleFactor * 40);

    certificationTopTemp = certificationFilterButtonBottomPlots[i] + (scaleFactor * 10);
  }
}

void drawLayout() {
  definePlots();

  textPlacementPadX = scaleFactor * 10;
  textPlacementPadY = scaleFactor * 2;

  //CODE FOR SPLATTER METHOD

  drawProjectTitle(); 
  strokeWeight(scaleFactor * 4);
  fill(359, 67, 92);

  menuItemFont = createFont("SansSerif", (scaleFactor * 16));
  textFont(menuItemFont);

  drawMenuTabs();
  drawMenu();
  drawOverviewButton();

  divisorLine = loadImage("divisorline.png");
  image(divisorLine, divisorLinePlotX, divisorLinePlotY1);

  if (filterWasClicked) {
    int count = 0;
    /* for (boolean g: filterButtonChosen)
     {
     println("boolean value # " + count +" within filter button array is: " + g);
     count++;
     }
     println();   */
    drawPopUpFilter();
  }

  if (overviewMenuChosen) {
    drawOverviewMenu();
  }
}

void drawMenu() { 

  filterChoices = new String [8];

  filterChoices[0] = "Monsters";
  filterChoices[1] = "Country of Origin";
  filterChoices[2] = "Genre";
  filterChoices[3] = "Format";
  filterChoices[4] = "Certification";
  filterChoices[5] = "Budget Category";
  filterChoices[6] = "IMDB Rating";
  filterChoices[7] = "IMDB No. of Votes";

  monsterNames = new String[44];

  int inc = 1;

  monsterNames[0] = "All Keywords";
  monsterNames[inc + 0] ="Alien";
  monsterNames[inc + 1] ="Anaconda";
  monsterNames[inc + 2] ="Android";
  monsterNames[inc + 3] ="Bigfoot";
  monsterNames[inc + 4] ="Cyclops";
  monsterNames[inc + 5] ="Demon";
  monsterNames[inc + 6] ="Devil";
  monsterNames[inc + 7] ="Dinosaur";
  monsterNames[inc + 8] ="Dracula";
  monsterNames[inc + 9] ="Dragon";
  monsterNames[inc + 10] ="Frankenstein's-monster";
  monsterNames[inc + 11] ="Freddy-Krueger";
  monsterNames[inc + 12] ="Ghost";
  monsterNames[inc + 13] ="Giant-Ape";
  monsterNames[inc + 14] ="Giant-Insect";
  monsterNames[inc + 15] ="Giant-Snake";
  monsterNames[inc + 16] ="Giant-Spider";
  monsterNames[inc + 17] ="Goblin";
  monsterNames[inc + 18] ="Godzilla";
  monsterNames[inc + 19] ="Invisible-man";
  monsterNames[inc + 20] ="King-Kong";
  monsterNames[inc + 21] ="Lake-Monster";
  monsterNames[inc + 22] ="Mermaid";
  monsterNames[inc + 23] ="Monster";
  monsterNames[inc + 24] ="Monster-Plant";
  monsterNames[inc + 25] ="Mummy";
  monsterNames[inc + 26] ="Mutant";
  monsterNames[inc + 27] ="Ogre";
  monsterNames[inc + 28] ="Orc";
  monsterNames[inc + 29] ="Phantom";
  monsterNames[inc + 30] ="Predator";
  monsterNames[inc + 31] ="Robot";
  monsterNames[inc + 32] ="Sasquatch";
  monsterNames[inc + 33] ="Satan";
  monsterNames[inc + 34] ="Sea-Monster";
  monsterNames[inc + 35] ="Shape-Shifting-Alien";
  monsterNames[inc + 36] ="Troll";
  monsterNames[inc + 37] ="Vampire";
  monsterNames[inc + 38] ="Werewolf";
  monsterNames[inc + 39] ="Witch";
  monsterNames[inc + 40] ="Xenomorph";
  monsterNames[inc + 41] ="Yeti";
  monsterNames[inc + 42] ="Zombie";

  formatNames = new String[4];

  formatNames[0] = "All Formats";
  formatNames[1] = "Direct to Video Release";
  formatNames[2] = "Movie";
  formatNames[3] = "Tv Series";

  certificationNames = new String[6];

  certificationNames[0] = "All Certificates";
  certificationNames[1] = "G";
  certificationNames[2] = "PG";
  certificationNames[3] = "PG-13";
  certificationNames[4] = "R";
  certificationNames[5] = "NC-17";     

  divisorLine = loadImage("divisorline.png");

  if (timelineMenuChosen) {
    strokeWeight(int(scaleFactor * 5));// Main menu box Green - filter graph
    stroke(340);
    fill(340, 80);
    rectMode(CORNERS);
    rect(mainMenuPlotX1, mainMenuPlotY1, mainMenuPlotX2, mainMenuPlotY2, (scaleFactor * 6));

    drawTimelineMenuButtons();
  }
  else if (comparisonGraphMenuChosen) {
    strokeWeight(int(scaleFactor * 5));// Main menu box Purple - alt graph
    stroke(50);
    fill(50, 80);
    rectMode(CORNERS);
    rect(mainMenuPlotX1, mainMenuPlotY1, mainMenuPlotX2, mainMenuPlotY2, (scaleFactor * 6));

    drawComparisonGraphMenuButtons();
  }
}


void drawTimelineMenuButtons() {
  strokeWeight(int(scaleFactor * 5));// Main menu box Green buttons
  stroke(340);
  rectMode(CORNERS);

  textFont(menuItemFont);
  textAlign(LEFT, TOP);

  for (int i = 0; i < 4; i++) {
    if (!filterButtonChosen[i]) {
      fill(350, 80);
      rect(menuButtonLeftPlot, menuButtonTopPlots[i], menuButtonMidPlot - (scaleFactor * 5), menuButtonBottomPlots[i], (scaleFactor * 6));//Left Column of buttons

      fill(50);
      text(filterChoices[i], menuButtonLeftPlot + textPlacementPadX, menuButtonTopPlots[i] + textPlacementPadY + (scaleFactor * 5));
    }

    else {
      fill(250, 99);
      rect(menuButtonLeftPlot, menuButtonTopPlots[i], menuButtonMidPlot - (scaleFactor * 5), menuButtonBottomPlots[i], (scaleFactor * 6));//Left Column of buttons

      fill(90);
      text(filterChoices[i], menuButtonLeftPlot + textPlacementPadX, menuButtonTopPlots[i] + textPlacementPadY + (scaleFactor * 5));
    }
  }

  for (int j = 0; j < 4; j++) {
    if (!filterButtonChosen[j + 4]) {
      fill(350, 80);
      rect(menuButtonMidPlot + (scaleFactor * 5), menuButtonTopPlots[j], menuButtonRightPlot, menuButtonBottomPlots[j], (scaleFactor * 6));//Right Column of buttons

      fill(50);
      text(filterChoices[j + 4], menuButtonMidPlot + textPlacementPadX, menuButtonTopPlots[j] + textPlacementPadY  + (scaleFactor * 5));
    }
    else {
      fill(250, 99);
      rect(menuButtonMidPlot + (scaleFactor * 5), menuButtonTopPlots[j], menuButtonRightPlot, menuButtonBottomPlots[j], (scaleFactor * 6));//Right Column of buttons

      fill(90);
      text(filterChoices[j + 4], menuButtonMidPlot + textPlacementPadX, menuButtonTopPlots[j] + textPlacementPadY  + (scaleFactor * 5));
    }
  }
}


void drawComparisonGraphMenuButtons() {

  strokeWeight(int(scaleFactor * 5));// Main menu box Purple buttons
  stroke(50);

  rectMode(CORNERS);

  textFont(menuItemFont);
  textAlign(LEFT, TOP);

  for (int i = 0; i < 4; i++) {
    if (!filterButtonChosen[i]) {
      fill(80, 80);
      rect(menuButtonLeftPlot, menuButtonTopPlots[i], menuButtonMidPlot - (scaleFactor * 5), menuButtonBottomPlots[i], (scaleFactor * 6));//Left Column of buttons

      fill(340);
      text(filterChoices[i], menuButtonLeftPlot + textPlacementPadX, menuButtonTopPlots[i] + textPlacementPadY + (scaleFactor * 5));
    }
    else {
      fill(0, 99);
      rect(menuButtonLeftPlot, menuButtonTopPlots[i], menuButtonMidPlot - (scaleFactor * 5), menuButtonBottomPlots[i], (scaleFactor * 6));//Left Column of buttons

      fill(300);
      text(filterChoices[i], menuButtonLeftPlot + textPlacementPadX, menuButtonTopPlots[i] + textPlacementPadY + (scaleFactor * 5));
    }
  }

  for (int j = 0; j < 4; j++) {
    if (!filterButtonChosen[j+4]) {
      fill(80, 80);
      rect(menuButtonMidPlot + (scaleFactor * 5), menuButtonTopPlots[j], menuButtonRightPlot, menuButtonBottomPlots[j], (scaleFactor * 6));//Right Column of buttons

      fill(340);
      text(filterChoices[j + 4], menuButtonMidPlot + textPlacementPadX, menuButtonTopPlots[j] + textPlacementPadY  + (scaleFactor * 5));
    }
    else {
      fill(0, 99);
      rect(menuButtonMidPlot + (scaleFactor * 5), menuButtonTopPlots[j], menuButtonRightPlot, menuButtonBottomPlots[j], (scaleFactor * 6));//Right Column of buttons

      fill(300);
      text(filterChoices[j + 4], menuButtonMidPlot + textPlacementPadX, menuButtonTopPlots[j] + textPlacementPadY  + (scaleFactor * 5));
    }
  }
}


void drawProjectTitle() {


  projectTitleFont = createFont("SansSerif", (scaleFactor * 40)); 

  fill(0);
  textAlign(RIGHT, CENTER);
  textFont(projectTitleFont);
  text("Monster Mash", projectTitlePlotX, projectTitlePlotY);
}

void drawPopUpFilter() {      
  for (int i = 0; i < 8; i++) {
    if (filterButtonChosen[i]) {
      if ( i == 0) {              //Draw popup rect layer for MONSTERS

        strokeWeight(int(scaleFactor * 5));
        stroke(359, 85, 85);
        fill(359, 85, 85, 80);
        rectMode(CORNERS);
        rect(graphPlotX1 + (scaleFactor * 100), graphPlotY1, divisorLinePlotX - (scaleFactor * 5), height - (scaleFactor * 40), (scaleFactor * 6));

        drawMonsterFilterButtons();
      } 
      if ( i == 1) {              //Draw popup rect layer for  COUNTRY OF ORIGIN-- will be using text entry
      } 
      if ( i == 2) {              //Draw popup rect layer for  GENRES

        strokeWeight(int(scaleFactor * 5));
        stroke(224, 59, 86);
        fill(224, 59, 86, 80);
        rectMode(CORNERS);
        rect(graphPlotMidX + (scaleFactor * 185), 0 + (scaleFactor * 10), divisorLinePlotX - (scaleFactor * 5), height - (scaleFactor * 10), (scaleFactor * 6));

        drawGenreFilterButtons();
      } 
      if ( i == 3) {              //Draw popup rect layer for FORMAT

        strokeWeight(int(scaleFactor * 5));
        stroke(55, 78, 95);
        fill(55, 78, 95, 80);
        rectMode(CORNERS);
        rect(divisorLinePlotX - (scaleFactor * 180), graphPlotMidY - (scaleFactor * 60), divisorLinePlotX - (scaleFactor * 5), height - (scaleFactor * 85), (scaleFactor * 6));

        drawFormatFilterButtons();
      } 
      if ( i == 4) {              //Draw popup rect layer for CERTIFICATIONS

        strokeWeight(int(scaleFactor * 5));
        stroke(41, 63, 99);
        fill(41, 63, 99, 80);
        rectMode(CORNERS);
        rect(divisorLinePlotX - (scaleFactor * 180), graphPlotMidY - (scaleFactor * 100), divisorLinePlotX - (scaleFactor * 5), height - (scaleFactor * 45), (scaleFactor * 6));
      
      drawCertificationFilterButtons();
  } 
      if ( i == 5) {              //Draw popup rect layer for BUDGET CATEGORY
      } 
      if ( i == 6) {              //Draw popup rect layer for IMDB RATING
      } 
      if ( i == 7) {              //Draw popup rect layer for IMDB VOTES
      }
    }
  }
}

void drawCertificationFilterButtons() {
  strokeWeight(scaleFactor * 4);

  textFont(menuItemFont);
  textSize(scaleFactor * 10);
  textAlign(LEFT, TOP);
  
  for (int i = 0; i < 6; i++) {
    if (!certificationsChosen[i]) {
      fill(41, 63, 99, 99);
      rect(certificationFilterButtonLeftPlot, certificationFilterButtonTopPlots[i], certificationFilterButtonRightPlot, certificationFilterButtonBottomPlots[i], (scaleFactor * 6));
      fill(50);
      text(certificationNames[i], certificationFilterButtonLeftPlot + textPlacementPadX, certificationFilterButtonTopPlots[i] + textPlacementPadY + (scaleFactor * 8));
    }
    else {
      fill(41, 76, 77, 99);
      rect(certificationFilterButtonLeftPlot, certificationFilterButtonTopPlots[i], certificationFilterButtonRightPlot, certificationFilterButtonBottomPlots[i], (scaleFactor * 6));
      fill(20);
      text(certificationNames[i], certificationFilterButtonLeftPlot + textPlacementPadX, certificationFilterButtonTopPlots[i] + textPlacementPadY + (scaleFactor * 8));
    }
  }
}


void drawGenreFilterButtons() {
  strokeWeight(scaleFactor * 4);
  stroke(224, 59, 86);

  textFont(menuItemFont);
  textSize(scaleFactor * 10);
  textAlign(LEFT, TOP);
  int textCounter = 0;

  for (int i = 0; i < 9; i++) {   // each row of genre buttons (3 buttons to a row)

    for (int j = 0; j < 3; j++) {  // each column of gere buttons
      if (!genresChosen[textCounter]) {
        fill(224, 59, 86, 80);
        rect(genreFilterButtonLeftPlots[j], genreFilterButtonTopPlots[i], genreFilterButtonRightPlots[j], genreFilterButtonBottomPlots[i], scaleFactor * 3);

        fill(340);
        text(GenreList[textCounter], genreFilterButtonLeftPlots[j] + textPlacementPadX, genreFilterButtonTopPlots[i]  + textPlacementPadY + (scaleFactor * 8));
      }
      else {
        fill(224, 67, 63, 80);
        rect(genreFilterButtonLeftPlots[j], genreFilterButtonTopPlots[i], genreFilterButtonRightPlots[j], genreFilterButtonBottomPlots[i], scaleFactor * 3);

        fill(280);
        text(GenreList[textCounter], genreFilterButtonLeftPlots[j] + textPlacementPadX, genreFilterButtonTopPlots[i]  + textPlacementPadY + (scaleFactor * 8));
      }
      textCounter++;
    }
  }
}


void drawMonsterFilterButtons() {
  strokeWeight(scaleFactor * 4);
  fill(359, 67, 92);

  textFont(menuItemFont);
  textSize(scaleFactor * 10);
  textAlign(LEFT, TOP);
  int textCounter = 0;

  for (int j = 0; j < 7; j++) {


    if (j != 6) {

      if (!monstersChosen[textCounter]) {
        fill(359, 67, 92, 90);
        rect(monsterFilterButtonLeftPlots[0], monsterFilterButtonTopPlots[j], monsterFilterButtonRightPlots[0], monsterFilterButtonBottomPlots[j], scaleFactor * 3);
        fill(340);
        text(monsterNames[textCounter], monsterFilterButtonLeftPlots[0] + textPlacementPadX, monsterFilterButtonTopPlots[j] + textPlacementPadY + (scaleFactor * 8));
      }
      else {
        fill(358, 72, 70, 90);
        rect(monsterFilterButtonLeftPlots[0], monsterFilterButtonTopPlots[j], monsterFilterButtonRightPlots[0], monsterFilterButtonBottomPlots[j], scaleFactor * 3);
        fill(180);
        text(monsterNames[textCounter], monsterFilterButtonLeftPlots[0] + textPlacementPadX, monsterFilterButtonTopPlots[j] + textPlacementPadY + (scaleFactor * 8));
      }
      textCounter++;

      if (!monstersChosen[textCounter]) {
        fill(359, 67, 92, 90);
        rect(monsterFilterButtonLeftPlots[1], monsterFilterButtonTopPlots[j], monsterFilterButtonRightPlots[1], monsterFilterButtonBottomPlots[j], scaleFactor * 3);
        fill(340);
        text(monsterNames[textCounter], monsterFilterButtonLeftPlots[1] + textPlacementPadX, monsterFilterButtonTopPlots[j] + textPlacementPadY + (scaleFactor * 8));
      }
      else {
        fill(358, 72, 70, 90);
        rect(monsterFilterButtonLeftPlots[1], monsterFilterButtonTopPlots[j], monsterFilterButtonRightPlots[1], monsterFilterButtonBottomPlots[j], scaleFactor * 3);
        fill(180);
        text(monsterNames[textCounter], monsterFilterButtonLeftPlots[1] + textPlacementPadX, monsterFilterButtonTopPlots[j] + textPlacementPadY + (scaleFactor * 8));
      }
      textCounter++;

      if (!monstersChosen[textCounter]) {
        fill(359, 67, 92, 90);
        rect(monsterFilterButtonLeftPlots[2], monsterFilterButtonTopPlots[j], monsterFilterButtonRightPlots[2], monsterFilterButtonBottomPlots[j], scaleFactor * 3);
        fill(340);
        text(monsterNames[textCounter], monsterFilterButtonLeftPlots[2] + textPlacementPadX, monsterFilterButtonTopPlots[j] + textPlacementPadY + (scaleFactor * 8));
      }
      else {
        fill(358, 72, 70, 90);
        rect(monsterFilterButtonLeftPlots[2], monsterFilterButtonTopPlots[j], monsterFilterButtonRightPlots[2], monsterFilterButtonBottomPlots[j], scaleFactor * 3);
        fill(180);
        text(monsterNames[textCounter], monsterFilterButtonLeftPlots[2] + textPlacementPadX, monsterFilterButtonTopPlots[j] + textPlacementPadY + (scaleFactor * 8));
      }
      textCounter++;

      if (!monstersChosen[textCounter]) {
        fill(359, 67, 92, 90);
        rect(monsterFilterButtonLeftPlots[3], monsterFilterButtonTopPlots[j], monsterFilterButtonRightPlots[3], monsterFilterButtonBottomPlots[j], scaleFactor * 3);
        fill(340);
        text(monsterNames[textCounter], monsterFilterButtonLeftPlots[3] + textPlacementPadX, monsterFilterButtonTopPlots[j] + textPlacementPadY + (scaleFactor * 8));
      }
      else {
        fill(358, 72, 70, 90);
        rect(monsterFilterButtonLeftPlots[3], monsterFilterButtonTopPlots[j], monsterFilterButtonRightPlots[3], monsterFilterButtonBottomPlots[j], scaleFactor * 3);
        fill(180);
        text(monsterNames[textCounter], monsterFilterButtonLeftPlots[3] + textPlacementPadX, monsterFilterButtonTopPlots[j] + textPlacementPadY + (scaleFactor * 8));
      }
      textCounter++;

      if (!monstersChosen[textCounter]) {
        fill(359, 67, 92, 90);
        rect(monsterFilterButtonLeftPlots[4], monsterFilterButtonTopPlots[j], monsterFilterButtonRightPlots[4], monsterFilterButtonBottomPlots[j], scaleFactor * 3);
        fill(340);
        text(monsterNames[textCounter], monsterFilterButtonLeftPlots[4] + textPlacementPadX, monsterFilterButtonTopPlots[j] + textPlacementPadY + (scaleFactor * 8));
      }
      else {
        fill(358, 72, 70, 90);
        rect(monsterFilterButtonLeftPlots[4], monsterFilterButtonTopPlots[j], monsterFilterButtonRightPlots[4], monsterFilterButtonBottomPlots[j], scaleFactor * 3);
        fill(180);
        text(monsterNames[textCounter], monsterFilterButtonLeftPlots[4] + textPlacementPadX, monsterFilterButtonTopPlots[j] + textPlacementPadY + (scaleFactor * 8));
      }
      textCounter++;

      if (!monstersChosen[textCounter]) {
        fill(359, 67, 92, 90);
        rect(monsterFilterButtonLeftPlots[5], monsterFilterButtonTopPlots[j], monsterFilterButtonRightPlots[5], monsterFilterButtonBottomPlots[j], scaleFactor * 3);
        fill(340);
        text(monsterNames[textCounter], monsterFilterButtonLeftPlots[5] + textPlacementPadX, monsterFilterButtonTopPlots[j] + textPlacementPadY + (scaleFactor * 8));
      }
      else {
        fill(358, 72, 70, 90);
        rect(monsterFilterButtonLeftPlots[5], monsterFilterButtonTopPlots[j], monsterFilterButtonRightPlots[5], monsterFilterButtonBottomPlots[j], scaleFactor * 3);
        fill(180);
        text(monsterNames[textCounter], monsterFilterButtonLeftPlots[5] + textPlacementPadX, monsterFilterButtonTopPlots[j] + textPlacementPadY + (scaleFactor * 8));
      }
      textCounter++;

      if (!monstersChosen[textCounter]) {
        fill(359, 67, 92, 90);
        rect(monsterFilterButtonLeftPlots[6], monsterFilterButtonTopPlots[j], monsterFilterButtonRightPlots[6], monsterFilterButtonBottomPlots[j], scaleFactor * 3);
        fill(340);
        text(monsterNames[textCounter], monsterFilterButtonLeftPlots[6] + textPlacementPadX, monsterFilterButtonTopPlots[j] + textPlacementPadY + (scaleFactor * 8));
      }
      else {
        fill(358, 72, 70, 90);
        rect(monsterFilterButtonLeftPlots[6], monsterFilterButtonTopPlots[j], monsterFilterButtonRightPlots[6], monsterFilterButtonBottomPlots[j], scaleFactor * 3);
        fill(180);
        text(monsterNames[textCounter], monsterFilterButtonLeftPlots[6] + textPlacementPadX, monsterFilterButtonTopPlots[j] + textPlacementPadY + (scaleFactor * 8));
      }
      textCounter++;
    }


    else {      //if j == 6

      if (!monstersChosen[textCounter]) {
        fill(359, 67, 92, 90);  //Last monster filter button; zombie
        rect(monsterFilterButtonLeftPlots[0], monsterFilterButtonTopPlots[j], monsterFilterButtonRightPlots[0], monsterFilterButtonBottomPlots[j], scaleFactor * 3);
        fill(340);
        text(monsterNames[textCounter], monsterFilterButtonLeftPlots[0] + textPlacementPadX, monsterFilterButtonTopPlots[j] + textPlacementPadY + (scaleFactor * 8));
      }
      else {
        fill(358, 72, 70, 90);  //Last monster filter button; zombie
        rect(monsterFilterButtonLeftPlots[0], monsterFilterButtonTopPlots[j], monsterFilterButtonRightPlots[0], monsterFilterButtonBottomPlots[j], scaleFactor * 3);
        fill(180);
        text(monsterNames[textCounter], monsterFilterButtonLeftPlots[0] + textPlacementPadX, monsterFilterButtonTopPlots[j] + textPlacementPadY + (scaleFactor * 8));
      }
      textCounter++;

      if (!monstersChosen[textCounter]) {
        fill(359, 67, 92, 90);  //Last monster filter button; zombie
        rect(monsterFilterButtonLeftPlots[1], monsterFilterButtonTopPlots[j], monsterFilterButtonRightPlots[1], monsterFilterButtonBottomPlots[j], scaleFactor * 3);
        fill(340);
        text(monsterNames[textCounter], monsterFilterButtonLeftPlots[1] + textPlacementPadX, monsterFilterButtonTopPlots[j] + textPlacementPadY + (scaleFactor * 8));
      }
      else {
        fill(358, 72, 70, 90);  //Last monster filter button; zombie
        rect(monsterFilterButtonLeftPlots[1], monsterFilterButtonTopPlots[j], monsterFilterButtonRightPlots[1], monsterFilterButtonBottomPlots[j], scaleFactor * 3);
        fill(180);
        text(monsterNames[textCounter], monsterFilterButtonLeftPlots[1] + textPlacementPadX, monsterFilterButtonTopPlots[j] + textPlacementPadY + (scaleFactor * 8));
      }
    }
  }
}

void drawFormatFilterButtons() {

  strokeWeight(scaleFactor * 4);

  textFont(menuItemFont);
  textSize(scaleFactor * 10);
  textAlign(LEFT, TOP);

  for (int i = 0; i < 4; i++) {
    if (!formatsChosen[i]) {
      fill(57, 92, 95, 99);
      rect(formatFilterButtonLeftPlot, formatFilterButtonTopPlots[i], formatFilterButtonRightPlot, formatFilterButtonBottomPlots[i], (scaleFactor * 6));
      fill(50);
      text(formatNames[i], formatFilterButtonLeftPlot + textPlacementPadX, formatFilterButtonTopPlots[i] + textPlacementPadY + (scaleFactor * 8));
    }
    else {
      fill(57, 81, 59, 99);
      rect(formatFilterButtonLeftPlot, formatFilterButtonTopPlots[i], formatFilterButtonRightPlot, formatFilterButtonBottomPlots[i], (scaleFactor * 6));
      fill(20);
      text(formatNames[i], formatFilterButtonLeftPlot + textPlacementPadX, formatFilterButtonTopPlots[i] + textPlacementPadY + (scaleFactor * 8));
    }
  }
}

void drawOverviewMenu() {


  strokeWeight(int(scaleFactor * 10));//overview menu 
  stroke(0);
  fill(0, 0, 0, 95);
  rectMode(CORNERS);
  rect(overviewMenuPlotX1, overviewMenuPlotY1, overviewMenuPlotX2, overviewMenuPlotY2, (scaleFactor * 6));

  strokeWeight(int(scaleFactor * 5));// overview menu "back to menus button"
  stroke(0);
  fill(0, 0, 0, 95);
  rectMode(CORNERS);
  rect(overviewExitButtonPlotX1, overviewExitButtonPlotY1, overviewExitButtonPlotX2, overviewExitButtonPlotY2, (scaleFactor * 3));

  fill(340);
  textSize(scaleFactor * 20);
  textAlign(LEFT, TOP);
  text("Back to Menus", overviewExitButtonPlotX1 + textPlacementPadX, overviewExitButtonPlotY1 + textPlacementPadY + (scaleFactor * 3));
}

void drawMenuTabs() {


  if (timelineMenuChosen) {
    strokeWeight(int(scaleFactor * 4));// Filter graph tab CHOSEN
    stroke(340);
    fill(340, 80);
    rectMode(CORNERS);
    rect(menuTabLeft, menuTabTop, menuTabMid - (scaleFactor * 2), menuTabBottom, (scaleFactor * 3), (scaleFactor * 3), 0, 0);

    textAlign(LEFT, TOP);
    fill(100);
    text("Timeline", menuTabLeft + textPlacementPadX, menuTabTop + textPlacementPadY); //Text for CHOSEN filtergraph Tab

    strokeWeight(int(scaleFactor * 2));// Alt. graph tab
    stroke(90);
    fill(50, 60);
    rectMode(CORNERS);
    rect(menuTabMid + (scaleFactor * 5), menuTabTop, menuTabRight, menuTabBottom, (scaleFactor * 3), (scaleFactor * 3), 0, 0);

    textAlign(LEFT, TOP);
    fill(340, 80);
    text("Comparison Graph", menuTabMid + textPlacementPadX, menuTabTop + textPlacementPadY); //Text for non chosen alternate graph
  }
  else if (comparisonGraphMenuChosen) {

    strokeWeight(int(scaleFactor * 2));// Filter graph tab
    stroke(300);
    fill(340, 60);
    rectMode(CORNERS);
    rect(menuTabLeft, menuTabTop, menuTabMid - (scaleFactor * 5), menuTabBottom, (scaleFactor * 3), (scaleFactor * 3), 0, 0); 

    textAlign(LEFT, TOP);
    fill(100, 80);
    text("Timeline", menuTabLeft + textPlacementPadX, menuTabTop + textPlacementPadY); //Text for non chosen filtergraph Tab//text for non chosen filter graph

    strokeWeight(int(scaleFactor * 4));// Alt. graph tab CHOSEN
    stroke(50);
    fill(50, 80);
    rectMode(CORNERS);
    rect(menuTabMid + (scaleFactor * 2), menuTabTop, menuTabRight, menuTabBottom, (scaleFactor * 3), (scaleFactor * 3), 0, 0);

    textAlign(LEFT, TOP);
    fill(340);
    text("Comparison Graph", menuTabMid + textPlacementPadX, menuTabTop + textPlacementPadY); //Text for CHOSEN alternate graph Tab
  }
}

void drawOverviewButton() {


  strokeWeight(int(scaleFactor * 5));// Main menu box
  stroke(100);
  fill(0, 0, 0, 60);
  rectMode(CORNERS);
  rect(overviewButtonPlotX1, overviewButtonPlotY1, overviewButtonPlotX2, overviewButtonPlotY2, (scaleFactor * 3));

  textAlign(LEFT, TOP);
  fill(340);
  text("Overview Graph", overviewButtonPlotX1 + (scaleFactor * 10), overviewButtonPlotY1 + (scaleFactor * 2));
}

void resetSplatter() {
  splatterHasBeenChosen = false;
}

void chooseSplatter() {
  indexOfChosenSplatter = int(random(splatterArray.length));
  chosenSplatter = loadImage(splatterArray[indexOfChosenSplatter]);

  splatterHasBeenChosen = true;
}

void drawSplatter() {
  if (!splatterHasBeenChosen)
    chooseSplatter(); 

  if (splatterHasBeenChosen) {
    chosenSplatter.resize(int(width - (divisorLinePlotX + (scaleFactor * 2))), height);
    image(chosenSplatter, divisorLinePlotX + (scaleFactor * 2), 0);
  }
}

