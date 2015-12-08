/* 
   CS 424 f12 Proj2 
   Author: Chihua Ma
*/

float SliderYearX1;
float SliderYearX2;
float SliderYearXpos;

void drawSliderYear() {
  // timeline
  rectMode(CORNER);
  fill(#979596,250);
  noStroke();
  rect(graphPlotX1,graphPlotY2 + (scaleFactor * 65),graphPlotX2-graphPlotX1,15);
  
  int i;
  float xPos;
  for(i=0; i<=(YearEnd-YearStart); i++){           
    if((i+YearStart)%10 != 0){
      //stroke(225, 225, 160);
      stroke(360);
      strokeWeight(1);
      noFill();
      
      xPos = map((i+YearStart), YearStart, YearEnd, graphPlotX1, graphPlotX2);
      line(xPos, graphPlotY2 + (scaleFactor * 65), xPos, graphPlotY2 + (scaleFactor * 80));
    }
    if((i+YearStart)%10 == 0){
      //stroke(225, 225, 160);
      stroke(360);
      strokeWeight(1);
      textSize(scaleFactor*10);
      //fill(225, 225, 160);
      fill(360);
      textAlign(CENTER);
      
      xPos = map((i+YearStart), YearStart, YearEnd, graphPlotX1, graphPlotX2);
      text((i+YearStart),xPos,graphPlotY2 + (scaleFactor * 90));
      line(xPos, graphPlotY2 + (scaleFactor * 60), xPos, graphPlotY2 + (scaleFactor * 80));
    }
  }
  
  SliderYearX1 = ((YearMin-YearStart)*(graphPlotX2 - graphPlotX1) + graphPlotX1*(YearEnd-YearStart))/(YearEnd-YearStart);
  SliderYearX2 = float((YearMax-YearStart)/(YearEnd-YearStart)) * (graphPlotX2 - graphPlotX1) + graphPlotX1;
  
  // slider
  stroke(#980623, 255);
  fill(#980623, 100);
  rectMode(CORNERS);
  rect(SliderYearX1, graphPlotY2 + (scaleFactor * 65), SliderYearX2, graphPlotY2 + (scaleFactor * 80));
  noStroke();
  fill(#980623, 255);
  ellipse(SliderYearX1, graphPlotY2 + (scaleFactor * 72), 12, 12);
  ellipse(SliderYearX2, graphPlotY2 + (scaleFactor * 72), 12, 12);
  
  fill(360);
  textSize(scaleFactor * 12);
  if(YearMin == YearMax){
    textAlign(CENTER);
    text(YearMin, SliderYearX1,  graphPlotY2 + (scaleFactor * 55));
  }
  else{
    textAlign(CENTER);
    text(YearMin, SliderYearX1,  graphPlotY2 + (scaleFactor * 55));
    textAlign(CENTER);
    text(YearMax, SliderYearX2, graphPlotY2 + (scaleFactor * 55));
  }
  
}

void yearSlider() {
  //controlP5.setControlFont(new ControlFont(createFont("Arial",scaleFactor*10)));
  //textAlign(BOTTOM);
  
  controlP5.addSlider("Year_Min", YearStart, YearEnd, YearMin, int(graphPlotX11), int(graphPlotY2 + (scaleFactor*65)), scaleFactor*200, scaleFactor*20);
  Slider ys = (Slider)controlP5.controller("Year_Min");
  ys.captionLabel().set(" "); 
  //ys.setNumberOfTickMarks(10);
  //ys.setSliderMode(Slider.FLEXIBLE);
  
  controlP5.addSlider("Year_Max", YearStart, YearEnd, YearMax, int(graphPlotX11+scaleFactor*300), int(graphPlotY2 + (scaleFactor*65)), scaleFactor*200, scaleFactor*20);
  Slider ye = (Slider)controlP5.controller("Year_Max");
  ye.captionLabel().set(" "); 
  //ye.setNumberOfTickMarks(10);
  //ye.setSliderMode(Slider.FLEXIBLE);
}

// a slider event for choosing the year range
public void Year_Min(int theValue) {
  YearMin = theValue;
  println("YearMin : "+YearMin);
}

public void Year_Max(int theValue) {
  YearMax = theValue;
  println("YearMax : "+YearMax);
}


void RatingSlider() {
  controlP5.addSlider("ratingMin", 0, 10, RatingMin, int(graphPlotX1 + (scaleFactor*550)), int(graphPlotY2 + (scaleFactor*65)), scaleFactor*100, scaleFactor*20);
  Slider rMin = (Slider)controlP5.controller("ratingMin");
  rMin.captionLabel().set(" "); 
  
  controlP5.addSlider("ratingMax", 0, 10, RatingMax, int(graphPlotX1 + (scaleFactor*650)), int(graphPlotY2 + (scaleFactor*65)), scaleFactor*100, scaleFactor*20);
  Slider rMax = (Slider)controlP5.controller("ratingMax");
  rMax.captionLabel().set("IMDB Rating"); 
}

public void ratingMin(float theValue) {
  RatingMin = theValue;
  recalculate();
  println("RatingMin : "+RatingMin);
}

public void ratingMax(float theValue) {
  RatingMax = theValue;
  recalculate();
  println("RatingMax : "+RatingMax);
}


void VoteSlider() {
  controlP5.addSlider("VoteMin", 5, 834096, VotesMin, int(graphPlotX1 + (scaleFactor*850)), int(graphPlotY2 + (scaleFactor*65)), scaleFactor*150, scaleFactor*20);
  Slider voMin = (Slider)controlP5.controller("VoteMin");
  voMin.captionLabel().set(" "); 
  
  controlP5.addSlider("VoteMax", 5, 834096, VotesMax, int(graphPlotX1 + (scaleFactor*1000)), int(graphPlotY2 + (scaleFactor*65)), scaleFactor*150, scaleFactor*20);
  Slider voMax = (Slider)controlP5.controller("VoteMax");
  voMax.captionLabel().set("Votes"); 
}

public void VoteMin(int theValue) {
  VotesMin = theValue;
  recalculate();
  println("VotesMin : "+VotesMin);
}

public void VoteMax(int theValue) {
  VotesMax = theValue;
  recalculate();
  println("VotesMax : "+VotesMax);
}
