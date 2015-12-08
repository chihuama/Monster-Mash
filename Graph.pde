//FloatTable data;

float graphPlotX1, graphPlotX11, graphPlotY1;
float graphPlotX2, graphPlotX22, graphPlotY2;
float graphPlotMidX, graphPlotMidY;
float labelX, labelY;

int yearInterval = 10;
int volumeInterval = 4;
int volumeIntervalMinor = 2;
float vMax = 0, vMin = 0;
int vscale; // volumn scale

int currentColumn = 0;

int[] graphs = new int[43];
int graphID = 0;

String[] MonsterName = new String[43];
int MonsterID = 0;


PImage pattern1;
PImage pattern2;
PImage pattern3;
PImage pattern4;
PImage pattern5;

  
void drawGraph() {
    
  if (currentColumn==0) {
    MonsterMax = getMax(currentColumn);
    MonsterMin = getMin(currentColumn);  
  } else {
    MonsterMax = getCurrentMax();
    MonsterMin = getCurrentMin();  
  }
    if ((MonsterMax/volumeInterval)>=10) {
    vscale = int(MonsterMax/volumeInterval)/10;
    } else {
      vscale = 1;
    }
    MonsterMax = ceil(MonsterMax / (volumeInterval*vscale)) * (volumeInterval*vscale);
    
    vMax = MonsterMax;
    vMin = MonsterMin; 
         
  drawTitle();
  drawAxisLabels();  
  drawYearLabels();
  drawVolumeLabels();
  
  //stroke(#5679C1);
  //fill(#5679C1, 100);
  strokeWeight(scaleFactor*3);
  //drawDataArea(currentColumn);

  if (currentColumn==0) {
    stroke(#5679C1);
    fill(#5679C1, 100);
    drawDataArea(currentColumn);
  } else {
    for (int i=0; i<graphID; i++) {
      if (graphs[i]>=0){
        stroke(colors[i%5]);
        fill(colors[i%5], 100);
        drawDataArea(graphs[i]); 
      }
    }
  }

}

void drawTitle() {
  fill(0);
  textSize(scaleFactor * 20);
  textAlign(LEFT, BOTTOM);
  String titleMonster, titleFormat, titleCountry, titleGenre;
  titleMonster = MonsterList[currentColumn];
  titleFormat = FormatList[currentFormat];
  titleCountry = CountryList[currentCountry];
  titleGenre = GenreList[currentGenre];
  text(titleMonster+",", graphPlotX11 + (scaleFactor * 20), graphPlotY1 - scaleFactor*15);
  text(titleFormat+",", graphPlotX11 + (scaleFactor * 30) + textWidth(titleMonster), graphPlotY1 - scaleFactor*15);
  text(titleCountry+",", graphPlotX11 + (scaleFactor * 40) + textWidth(titleMonster) + textWidth(titleFormat), graphPlotY1 - scaleFactor*15);
  text(titleGenre, graphPlotX11 + (scaleFactor * 50) + textWidth(titleMonster) + textWidth(titleFormat) + textWidth(titleCountry), graphPlotY1 - scaleFactor*15);
}

void drawAxisLabels() {
  fill(0);
  textSize(scaleFactor * 14);
  textLeading(15);
  
  textAlign(CENTER, CENTER);
  // Use \n (enter/linefeed) to break the text into separate lines
  text("Popularity", labelX, (graphPlotY1+graphPlotY2)/2 - (scaleFactor * 20));
  textAlign(CENTER);
  
  //fill(360);
  //text("Year", (graphPlotX1+graphPlotX2)/2, graphPlotY2 + (scaleFactor * 50));
}


void drawYearLabels() {
  fill(360);
  textSize(scaleFactor * 12);
  textAlign(CENTER, TOP);
  
  // Use thin, gray lines to draw the grid

  for (int y = YearMin; y <= YearMax; y++) {
    if (y % yearInterval == 0) {
      float x = map(y, YearMin, YearMax, graphPlotX11, graphPlotX22);
      
      stroke(360);
      strokeWeight(1);
      line(x, graphPlotY2 + (scaleFactor * 2), (x + (scaleFactor *15)), graphPlotY2 + (scaleFactor * 18)); //Lines for skewed year labels. makes room for black x axis and y axis
      
      text(y, x + (scaleFactor * 18), graphPlotY2 + (scaleFactor * 18));
      
      stroke(224);
      strokeWeight(1);
      line(x, graphPlotY1, x, graphPlotY2);// grey vertical graph lines for years
      

    }
  }
}


void drawVolumeLabels() {
  fill(0);
  textSize(scaleFactor * 12);
  
  stroke(128);
  strokeWeight(1);

  for (float v = vMin; v <= vMax; v += (volumeIntervalMinor*vscale)) {
    if (v % (volumeIntervalMinor*vscale) == 0) {     // If a tick mark
      float y = map(v, vMin, vMax, graphPlotY2, graphPlotY1);  
      if (v % (volumeInterval*vscale) == 0 && v != 0) {        // If a major tick mark, but cancel out the 0 as it interferes with the black axis lines
        textAlign(RIGHT, CENTER);         // Center vertically
        text(floor(v), graphPlotX11 - (scaleFactor * 12), y);
        line(graphPlotX11 - (scaleFactor * 10), y, graphPlotX11, y);     // Draw major tick
      } else {
        // Commented out, too distracting visually
        line(graphPlotX11 - (scaleFactor * 5), y, graphPlotX11, y);   // Draw minor tick
      }
    }
  }
}


void drawDataArea(int col) {
  beginShape();
  for (int years = 0; years <= (YearMax-YearMin); years++) {
    float x = map(years+YearMin, YearMin, YearMax, graphPlotX11, graphPlotX22);
    float y = map(MonsterNum[years+YearMin-YearStart][col], vMin, vMax, graphPlotY2, graphPlotY1);
    vertex(x, y);
  }
  vertex(graphPlotX22, graphPlotY2);
  vertex(graphPlotX11, graphPlotY2);  
  endShape(CLOSE);
}


void drawDataCurve(int col) {
  beginShape();
  for (int row = 0; row <= (YearEnd-YearStart); row++) {
      float value = MonsterNum[row][col];
      float x = map(row+YearStart, YearStart, YearEnd, graphPlotX1, graphPlotX2);
      float y = map(value, vMin, vMax, graphPlotY2, graphPlotY1);
      curveVertex(x, y);
      if ((row==0)||(row==(YearEnd-YearStart))) {
        curveVertex(x, y);
      }
  }
  endShape();
}


float getCurrentMax() {
  float m = -Float.MAX_VALUE;
  for (int j=0; j<graphID; j++) {
  for (int i=0; i<=(YearEnd-YearStart); i++) {
    if (MonsterNum[i][graphs[j]] > m) {
      m = MonsterNum[i][graphs[j]];
    }
  }
  }
  return m;
}

float getCurrentMin() {
  float m = Float.MAX_VALUE;
  for (int j=0; j<graphID; j++) {
  for (int i=0; i<=(YearEnd-YearStart); i++) {
    if (MonsterNum[i][graphs[j]] < m) {
      m = MonsterNum[i][graphs[j]];
    }
  }
  }
  return m;
}


void drawText() {
     
  strokeWeight(int(scaleFactor * 5));
  stroke(350);
  fill(350, 50);
  rectMode(CORNERS);  
  rect(scaleFactor*30, scaleFactor*30, graphPlotX11-(scaleFactor*150), (graphPlotY2+graphPlotY1)/2, (scaleFactor * 6));
  
  fill(0);
  textSize(scaleFactor * 16);
  textAlign(LEFT, TOP);
  text("Keywords: ", scaleFactor*40, scaleFactor*35);
  for (int m=0; m<MonsterID; m++) {
    fill(colors[m%5]);
    text(MonsterName[m], scaleFactor*40, scaleFactor*(35 + 25 + 25*m));
  }
}
