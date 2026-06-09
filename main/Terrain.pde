class Terrain {
  int cols, rows;
  int gss;          // grid square size
  int w, h;         // Totale breedte en lengte van het terrein

  float[][] mesh;   // 2D array --> https://processing.org/tutorials/2darray

  Terrain(int _w, int _h, int _gss) {
    //         ^-- make them 'private' (_) first for the parameters since I am going to map them to w, h and gss anyways.
    w = _w;
    h = _h;
    gss = _gss;
    cols = w / gss;
    rows = h / gss;
    mesh = new float[cols][rows];
    
    generate(); // I run it in the constructor to immediately generate the terrain
  }

  // Interne methode om de Perlin noise hoogtes te genereren
  void generate() {
    float yoff = 0;
    for (int y = 0; y < rows; y++) {
      float xoff = 0;
      for (int x = 0; x < cols; x++) {
        mesh[x][y] = map(noise(xoff, yoff), 0, 1, -100, 150);
        xoff += 0.08; 
      }
      yoff += 0.08;
    }
  }

  // Teken het terrein op het scherm
  void display() {
    pushMatrix();
    // Positioneer het terrein op de bodem van de 3D wereld
    translate(width/2, 550, -400);
    rotateX(HALF_PI); // Kantel plat als een vloer
    translate(-w/2, -h/2); // Centreer het grid
    
    for (int y = 0; y < rows - 1; y++) {
      beginShape(TRIANGLE_STRIP);
      noStroke();
      for (int x = 0; x < cols; x++) {
        // Kleur bepalen op basis van de opgeslagen hoogte
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