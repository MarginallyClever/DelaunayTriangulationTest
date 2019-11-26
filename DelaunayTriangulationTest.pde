DelaunayTriangulation dt = new DelaunayTriangulation();

ArrayList<Point2D> pointsIn = new ArrayList<Point2D>();
  
void setup() {
  size(800,800);
  dt.prepare(pointsIn);
}

void draw() {
  dt.render();
}

void mouseClicked() {
  Point2D p = new Point2D(mouseX,mouseY);
  pointsIn.add(p);
  dt.prepare(pointsIn);
  while(dt.step());
  dt.finish();
}


// (0...1]
void rainbowColor(float zeroToOne) {
  // index as hsv to rgb
  // https://en.wikipedia.org/wiki/HSL_and_HSV#HSV_to_RGB
  // Assume Hue=v/360, saturation=1, value=1.
  float C = 1;// C=V*S
  float H = zeroToOne*6;
  float X = C * (1-abs((H % 2) - 1));
  
  float r,g,b;
  
       if(H<1) { r=C; g=X; b=0; }
  else if(H<2) { r=X; g=C; b=0; }
  else if(H<3) { r=0; g=C; b=X; }
  else if(H<4) { r=0; g=X; b=C; }
  else if(H<5) { r=X; g=0; b=C; }
  else         { r=C; g=0; b=X; }  // H<6
  
  stroke(r*255,g*255,b*255,192);
}

// Give j [0....NUM_CLUSTERS-1]
// sets globals {r,g,b} to a rainbow color.
void clusterColor(int j) {
  float v = (float)(j+1) / (float)pointsIn.size(); // (0...1]
  rainbowColor(v);
}
