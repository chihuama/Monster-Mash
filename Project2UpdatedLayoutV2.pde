/*Authors:
 Chihua Ma
 Galen Thomas-Ramos
 Giric Goyal
 
 CS-424 Fall 2012 */
import processing.net.*;
import omicronAPI.*;
import controlP5.*;

OmicronAPI omicronManager;
TouchListener touchListener;

// Link to this Processing applet - used for touchDown() callback example
PApplet applet;

ControlP5 controlP5;
ListBox MonsterType;
ListBox Format;
ListBox Country;
ListBox Genre;


int YearStart = 1890, YearEnd = 2012;
int YearMin = 1890, YearMax = 2012;

int[] colors = new int[5];

PImage bg;
PFont graphPlotFont;
int scaleFactor;



boolean showComic = true;
boolean showCloud = false;
boolean showMain = false;



//OmiCron Method
public void init() {
  super.init();

  // Creates the OmicronAPI object. This is placed in init() since we want to use fullscreen
  omicronManager = new OmicronAPI(this);

  // Removes the title bar for full screen mode (present mode will not work on Cyber-commons wall)
  omicronManager.setFullscreen(false);
}




void setup() {
  scaleFactor = 1;  //Use 1 for computers and 5 for the wall
  size((scaleFactor * 1332), (scaleFactor * 461), JAVA2D);
  frameRate(60);

  //
  //
  //OMICRON STUFF
  // Make the connection to the tracker machine
  omicronManager.ConnectToTracker(7001, 7340, "131.193.77.159");
  // Create a listener to get events
  touchListener = new TouchListener();
  // Register listener with OmicronAPI
  omicronManager.setTouchListener(touchListener);
  // Sets applet to this sketch
  applet = this;


  animateSetup();


  // controlP5
  controlP5 = new ControlP5(this); //THIS MUST COME BEFORE THE COLORMODE METHOD

  colorMode(HSB, 360, 100, 100);// BE CAREFUL HERE! This color mode is used throghout the program!

  //Grab Data
  readMovie();
  readKeyword();
  readGenre();

  colors[0] = #5679C1;
  colors[1] = #AA0078;
  colors[2] = #339900;
  colors[3] = #FFCC33;
  colors[4] = #CC3300;
  //
  //
  //Load All Images
  bg = loadImage("newgradient.jpg");
  bg.resize(width, height); //displayResolutionX * int(scaleFactor), displayResolutionY * int(scaleFactor));

  splatter1 = loadImage("splatter1.png");
  splatter2 = loadImage("splatter2.png");
  splatter3 = loadImage("splatter3.png");

  splatterArray[0] = "splatter1.png";
  splatterArray[1] = "splatter2.png";  
  splatterArray[2] = "splatter3.png";  
  /* 
   pattern1 = loadImage("pattern1.png");
   pattern2 = loadImage("pattern2.png");
   pattern3 = loadImage("pattern3.png");
   pattern4 = loadImage("pattern4.png");
   pattern5 = loadImage("pattern5.png");
   */
  /*
  patternArray[1] = pattern1;
   patternArray[2] = pattern5;
   patternArray[3] = pattern3;
   patternArray[4] = pattern4;
   patternArray[5] = pattern2; 
   */
  allMonsterFilterValues = false;
  allFormatFilterValues = false;

  filterButtonChosen = new boolean[8];

  monstersChosen = new boolean[44];
  genresChosen = new boolean[27];
  certificationsChosen = new boolean[6];
  formatsChosen = new boolean[4];
  countriesChosen = new boolean[231];

  //Corners of the menu(s)

  // Corners of the graphPlotted time series
  graphPlotX1 = (scaleFactor * 140);
  graphPlotX11 = (scaleFactor * 440); 
  graphPlotX2 = width - (scaleFactor * 480);
  graphPlotX22 = width - (scaleFactor * 400);
  graphPlotY1 = (scaleFactor * 60);
  //graphPlotY2 = height - (scaleFactor * 70);
  graphPlotY2 = height - (scaleFactor * 100);
  graphPlotMidX = ((graphPlotX2 - graphPlotX1) / 2) + graphPlotX1;
  graphPlotMidY = ((graphPlotY2 - graphPlotY1) / 2) + graphPlotY1;
  labelX = graphPlotX11 -(scaleFactor * 80);
  labelY = graphPlotY2 / 2;

  //graphPlotFont = createFont("SansSerif", (scaleFactor * 20));
  //textFont(graphPlotFont);

  timelineMenuChosen = true;      //If you want to check out the different menus available right now - 10/10/2012, either enable filterMenuChosen or alternateMenuChosen
  //alternateMenuChosen = true;
  //overviewMenuChosen = true;  //If you want to check out the overviewMenu, enable this. I will enable touch (and mouse) response later today

  splatterHasBeenChosen = false;

  smooth();
  
  //////// Chihua added ////////
  for (int i=0; i<43; i++) {
    graphs[i] = -1;
    MonsterName[i] = "All";
  }
  
  ///yearSlider();
  //RatingSlider();
  //VoteSlider();
   
  //CountryBox();
  //GenreBox();
  //controlP5.addButton("RESET",0,int(graphPlotX2+ (scaleFactor * 30)),int(graphPlotY1+ (scaleFactor * 300)),( scaleFactor * 40),(scaleFactor * 20));
  /*
 // read MovieList.tsv
   readMovie();
   // read parsedKeywordList.tsv
   readKeyword();
   
   //controlP5.setControlFont(new ControlFont(createFont("Arial",10)));
   // Monster Type Listbox 
   KeywordListBox();
   // Format Listbox 
   FormatBox();*/
      
}

void controlEvent(ControlEvent theEvent) {
  if (theEvent.isGroup()) {
    switch(theEvent.group().id()) {
      case(1):
      currentColumn = int(theEvent.group().value());
      recalculate();
      break;

      case(2):
      currentFormat = int(theEvent.group().value());
      recalculate();
      break;
      
      case(3):
      currentCountry = int(theEvent.group().value());
      recalculate();
      println(currentCountry);
      break;
      
      case(4):
      currentGenre = int(theEvent.group().value());
      recalculate();
      println(currentGenre);
      break;
    }
  }
}

public void RESET(int theValue) {
  currentColumn=0;
  graphID = 0;
  MonsterID = 0;
  vMax = 0;
  vMin = 0;
  readKeyword();
  redraw();
}

void draw() {
  //background(255);
  if (!showMain) {
    animateDraw();
  }
  if (showMain) {
    //background(255);
    
  
    
    background(bg);
  
   // omicronManager.process();  
  
    fill(360, 50);    //
    rectMode(CORNERS);
    noStroke();
    rect(graphPlotX11, graphPlotY1, graphPlotX22, graphPlotY2);
  
    //////// Chihua added ////////
    drawGraph();
    yearSlider();
    fill(0);
    textSize(scaleFactor * 14);
    textAlign(RIGHT,TOP);
    text("Year Start", int(graphPlotX11-scaleFactor*10), int(graphPlotY2 + (scaleFactor*65)));
    text("Year End", int(graphPlotX11+scaleFactor*290), int(graphPlotY2 + (scaleFactor*65)));
    controlP5.addButton("RESET",0,int(graphPlotX22+(scaleFactor*50)),int(graphPlotY2+(scaleFactor * 65)),( scaleFactor * 40),(scaleFactor * 20));
    drawText();
    drawForm();
    //formSlider();
    /////////////////////////////
  
    strokeCap(SQUARE);//X-axis line of graph
    stroke(0);    
    strokeWeight(scaleFactor * 5);
    line((graphPlotX11 - (scaleFactor * 65)), graphPlotY2, graphPlotX22, graphPlotY2);
  
    strokeCap(SQUARE);//Y-axis line of graph
    stroke(0);    
    strokeWeight(scaleFactor * 5);
    line(graphPlotX11, 0, graphPlotX11, (graphPlotY2 + (scaleFactor * 45)));
    
    drawSplatter();
  
    drawLayout();// IF YOU ARE HAVING ISSUES WITH VARIABLES NOT BEING FOUND WHEN YOU ARE TRYING TO INCORPORAT THESE FILTER
    //INTO THE GRAPH, THEN YOU MIGHT NEED TO REORGANIZE drawLayout() before drawGraph()
  }
  omicronManager.process();
}


// See TouchListener on how to use this function call
// In this example TouchListener draws a solid ellipse
// Ths functions here draws a ring around the solid ellipse

// NOTE: Mouse pressed, dragged, and released events will also trigger these
//       using an ID of -1 and an xWidth and yWidth value of 10.
void touchDown(int ID, float xPos, float yPos, float xWidth, float yWidth) {
  noFill();
  stroke(255, 0, 0);
  ellipse( xPos, yPos, xWidth * 2, yWidth * 2 );
  if (!overviewMenuChosen) {
    if (!showMain) {
      if(yPos > 0 && yPos < height) {
        if (xPos > 0 && xPos <width) {
          if (img6 > images[5].width/3 && !showCloud) {
            showComic = false;
            showCloud = true;
            background(0);
          }
          else if (showCloud && !showMain) {
            println("bingg");
            background(255);
            showCloud = false;
            showMain = true;
          }
        }
      }
      
    }
  }
  if (showMain) {
    if (!overviewMenuChosen) {  
  
      if (yPos > menuTabTop && yPos < menuTabBottom) {   //for clicks on filter/alternate graph tabs 
        if (xPos > menuTabLeft && xPos < menuTabMid) {
          comparisonGraphMenuChosen = false;
          timelineMenuChosen = true;
        }
        if (xPos > menuTabMid && xPos < menuTabRight) {
          timelineMenuChosen = false;
          comparisonGraphMenuChosen = true;
        }
      }
  
  
  
  
  
      if (timelineMenuChosen) {
        if (xPos > menuButtonLeftPlot && (xPos < menuButtonMidPlot - (scaleFactor * 5))){
          for (int i = 0; i < 4; i++){
            if (yPos > menuButtonTopPlots[i] && yPos < menuButtonBottomPlots[i]){
              if (filterButtonChosen[i])
                filterButtonChosen[i] = false;
  
              else {
                resetSplatter();
                filterWasClicked = true;
                filterButtonChosen = new boolean[8];   //Reset all filter choices to false
                filterButtonChosen[i] = true;
              }
            }
            println("filter # " + i + " is " + filterButtonChosen[i]);
          }
        }
      
  
      else if (xPos > menuButtonMidPlot + (scaleFactor * 5) && xPos < menuButtonRightPlot){
        for (int j = 4; j < 8; j++){
          if (yPos > menuButtonTopPlots[j - 4] && yPos < menuButtonBottomPlots[j - 4]) {
            if (filterButtonChosen[j])
              filterButtonChosen[j] = false;
  
            else {
              resetSplatter();
              filterWasClicked = true;
              filterButtonChosen = new boolean[8];   //Reset all filter choices to false
              filterButtonChosen[j] = true;
            }
          }
          println("filter # " + j + " is " + filterButtonChosen[j]);
        }
      }
    }
  
  
  
    else if (comparisonGraphMenuChosen) {
      if (xPos > menuButtonLeftPlot && xPos < menuButtonMidPlot + (scaleFactor * 5)) {
        for (int i = 0; i < 4; i++){
          if (yPos > menuButtonTopPlots[i] && yPos < menuButtonBottomPlots[i]) {
            if (filterButtonChosen[i])
              filterButtonChosen[i] = false;
  
            else {
              resetSplatter();
              filterWasClicked = true;
              filterButtonChosen = new boolean[8];   //Reset all filter choices to false
              filterButtonChosen[i] = true;
            }
          }
          println("filter # " + i + " is " + filterButtonChosen[i]);
        }
      }
      else if (xPos > menuButtonMidPlot + (scaleFactor * 5) && xPos < menuButtonRightPlot) {
        for (int j = 4; j < 8; j++){
          if (yPos > menuButtonTopPlots[j - 4] && yPos < menuButtonBottomPlots[j - 4]) {
            if (filterButtonChosen[j])
              filterButtonChosen[j] = false;
  
            else {
              resetSplatter();
              filterWasClicked = true;
              filterButtonChosen = new boolean[8];   //Reset all filter choices to false
              filterButtonChosen[j] = true;
            }
          }
          println("filter # " + j + " is " + filterButtonChosen[j]);
        }
      }
    }
  
  
  
  
      if (filterButtonChosen[0]) {   //FOR MONSTER (KEYWORD) FILTERING
        int relevantMonsterIndex = 0;
  
  
        for (int i = 0; i < 7; i++) {
          for (int j = 0; j < 7; j++) {
            if (yPos > monsterFilterButtonTopPlots[i] && yPos < monsterFilterButtonBottomPlots[i]) {
              if ((xPos > monsterFilterButtonLeftPlots[j] && xPos < monsterFilterButtonRightPlots[j]) && ((((i * 7)+ (j + 1)) - 1) != 0)  && ((((i * 7)+ (j + 1)) - 1) < 44) )//Can't be a click on the all keywords nor can it be a click on the remaining 6 spaces that a 7 x 7 traversal create (there are only 44 entries in keywords)
              {
                println("Y row is: " + i + " and X Col is: " + j);
                relevantMonsterIndex = ((i * 7)+ (j + 1)) - 1;
                monstersChosen[relevantMonsterIndex] = !monstersChosen[relevantMonsterIndex];
                println("monsterChosen[" + (relevantMonsterIndex) + "] is " + monstersChosen[relevantMonsterIndex] + " Monster is: " + monsterNames[relevantMonsterIndex]);
                
                //////// Chihua added ////////
                if (monstersChosen[relevantMonsterIndex]==true) {
                  currentColumn = i*7 + j;
                
                  if (graphID==0) {
                    vMax = 0;
                    vMin = 0;
                  }
                  if (graphID<43) {
                  graphs[graphID] = currentColumn;
                  graphID++;
                  
                  MonsterName[MonsterID] = MonsterList[currentColumn];
                  MonsterID++;
                  }
                
                  recalculate();
                }                  
                /////////////////////////////
              }
            }
          }
        }
  
        if (yPos > monsterFilterButtonTopPlots[0] && yPos < monsterFilterButtonBottomPlots[0]) {
          if (xPos > monsterFilterButtonLeftPlots[0] && xPos < monsterFilterButtonRightPlots[0]) {
            allMonsterFilterValues = !allMonsterFilterValues;
            
            //////// Chihua added ////////
            currentColumn = 0;
            graphID = 0; 
            MonsterID = 0;
            vMin = 0; 
            vMax = 0; 
            recalculate();
            ///////////////////////////// 
  
            if (allMonsterFilterValues) {
              for (int i = 0; i < 44; i++) {
                monstersChosen[i] = true;
              }
            }
            else {
              for (int j = 0; j < 44; j++) {
                monstersChosen[j] = false;
              }
            }
          }
        }
      }
  
      
        if (filterButtonChosen[2]) {   //FOR GENRE FILTERING
        int relevantGenreIndex = 0;
  
  
        for (int i = 0; i < 9; i++) {
          for (int j = 0; j < 3; j++) {
            if (yPos > genreFilterButtonTopPlots[i] && yPos < genreFilterButtonBottomPlots[i]) {
              if ((xPos > genreFilterButtonLeftPlots[j] && xPos < genreFilterButtonRightPlots[j]) && ((((i * 9)+ (j + 1)) - 1) != 0))
              {
                println("Y row is: " + i + " and X Col is: " + j);
                
                genresChosen[relevantGenreIndex] = !genresChosen[relevantGenreIndex];
                println("genresChosen[" + (relevantGenreIndex) + "] is " + genresChosen[relevantGenreIndex]);// + " Genre is: " + GenreList[relevantGenreIndex]);
                
                //////// Chihua added ////////
                if (genresChosen[relevantGenreIndex]==true) {
                  currentGenre = i*3 + j;
                
                  if (graphID==0) {
                    vMax = 0;
                    vMin = 0;
                  }             
                  recalculate();
                }
                ///////////////////////////// 
              }
            }
            relevantGenreIndex++;
          }
        }
  
        if (yPos > genreFilterButtonTopPlots[0] && yPos < genreFilterButtonBottomPlots[0]) {
          if (xPos > genreFilterButtonLeftPlots[0] && xPos < genreFilterButtonRightPlots[0]) {
            allGenreFilterValues = !allGenreFilterValues;
            
            //////// Chihua added ////////
            currentGenre = 0;
            vMax = 0;
            vMin = 0;
            recalculate();
            /////////////////////////////
          
            if (allGenreFilterValues) {
              for (int i = 0; i < 27; i++) {
                genresChosen[i] = true;
              }
            }
            else {
              for (int j = 0; j < 27; j++) {
                genresChosen[j] = false;
              }
            }
          }
        }
      }
      
  
      if (filterButtonChosen[3]) {//FOR FORMAT FILTERING
  
        if (xPos > formatFilterButtonLeftPlot && xPos < formatFilterButtonRightPlot) {
          for (int i = 1; i < 4; i++) {
            if (yPos > formatFilterButtonTopPlots[i] && yPos < formatFilterButtonBottomPlots[i]) {
              formatsChosen[i] = !formatsChosen[i];
              
              //////// Chihua added ////////
              if (formatsChosen[i]==true) {
                currentFormat = i; 
                if (graphID==0) {
                  vMax = 0;
                  vMin = 0;
                }
                recalculate(); 
              }               
              /////////////////////////////
            }
          } 
  
          if (yPos > formatFilterButtonTopPlots[0] & yPos < formatFilterButtonBottomPlots[0]) {
            allFormatFilterValues = !allFormatFilterValues;
            
            //////// Chihua added ////////
            currentFormat = 0;
            vMax = 0;
            vMin = 0;
            recalculate();
            /////////////////////////////
  
            if (allFormatFilterValues) {
              for (int i = 0; i < 4; i++) {
                formatsChosen[i] = true;
              }
            }
            else {
              for (int j = 0; j < 4; j++) {
                formatsChosen[j] = false;
              }
            }
          }
        }
      }
  
  
      if (yPos > overviewButtonPlotY1 && yPos < overviewButtonPlotY2)    //Enable overview menu layer
        if (xPos >overviewButtonPlotX1 && xPos < overviewButtonPlotX2)
          overviewMenuChosen = true;
    }
  
    if (overviewMenuChosen) {                                            //Exit from overview menu layer
      if (yPos > overviewExitButtonPlotY1 && yPos < overviewExitButtonPlotY2)
        if (xPos > overviewExitButtonPlotX1 && xPos < overviewButtonPlotX2)
          overviewMenuChosen = false;
    }
  }
}//touchDown



void touchMove(int ID, float xPos, float yPos, float xWidth, float yWidth) {
  noFill();
  stroke(0, 255, 0);
  ellipse( xPos, yPos, xWidth * 2, yWidth * 2 );
}// touchMove

void touchUp(int ID, float xPos, float yPos, float xWidth, float yWidth) {
  noFill();
  stroke(0, 0, 255);
  ellipse( xPos, yPos, xWidth * 2, yWidth * 2 );
}// touchUp



