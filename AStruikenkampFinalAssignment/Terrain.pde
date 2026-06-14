class Terrain {
  int cols, rows;
  int gss;          // grid square size
  int w, h;         // width and height of the terrain
  int maxHeight;

  float[][] mesh;   // 2D array --> https://processing.org/tutorials/2darray

  Terrain(int _w, int _h, int _gss) {
    //         ^-- make them 'private' (_) first for the parameters since I am going to map them to w, h and gss anyways.
    w = _w;
    h = _h;
    gss = _gss;
    maxHeight = 150;

    // Use w, h and gss to calculate the following values:
    cols = w / gss;
    rows = h / gss;

    // This is only a 2D vector since the program calculates the height based on perlin noise later, no need to store it here.
    mesh = new float[cols][rows];
    
    generate(); // I run it in the constructor to immediately generate the terrain
  }

  // Method to generate terrain heights

  void generate() {
    float initialYOff = random(10000); // <-- so that it actually regenerates upon calling the method.
    float initialXOff = random(10000);

    float yoff = initialYOff;
    for (int y = 0; y < rows; y++) {
      float xoff = initialXOff;
      for (int x = 0; x < cols; x++) {
        mesh[x][y] = map(noise(xoff, yoff), 0, 1, -100, maxHeight);
        //                                          ^-- lowest and highest point
        xoff += 0.08; 
      }
      yoff += 0.08;
    }
  }

  void display() {
    pushMatrix();
    // Position the terrain at the bottom of the 3D space
    translate(width/2, 550, -400);
    rotateX(HALF_PI); // Rotate it to be flat (like a ground should be)
    translate(-w/2, -h/2); // Center the grid
    
    for (int y = 0; y < rows - 1; y++) {
      beginShape(TRIANGLE_STRIP);
      noStroke();
      for (int x = 0; x < cols; x++) {
        // Change colour based on height mapping, so it has depth!
        float greenValue = map(mesh[x][y], -100, 150, 80, 200);
        fill(34, greenValue, 34); 
        
        vertex(x * gss, y * gss, mesh[x][y]);
        vertex(x * gss, (y + 1) * gss, mesh[x][y + 1]);
      }
      endShape();
    }
    popMatrix();
  }
}