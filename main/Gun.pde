class Gun {
  PVector pos;
  int sides;
  float r;
  float h;

  Gun(float x, float y, float z, int _sides, float _r, float _h) {
    pos = new PVector(x, y, z);
    sides = _sides;
    r = _r;
    h = _h;
  }

  void display() {
    pushMatrix();

    // 1. Move to the safe center position where it doesn't disappear
    translate(pos.x, pos.y, pos.z);

    // 2. Rotate it towards the far back-left
    rotateY(radians(15)); // Turn left
    rotateX(radians(-15)); // Angle up into the background

    // 3. SHIFT DOWN: This lowers the barrel manually without clipping out of the camera view
    translate(20, 20, 0);

    float angle = 360.0 / sides;
    float halfHeight = h / 2;

    // --- Draw top of the tube ---
    beginShape();
    for (int i = 0; i < sides; i++) {
      float x = cos( radians( i * angle ) ) * r;
      float y = sin( radians( i * angle ) ) * r;
      vertex( x, y, -halfHeight);
    }
    endShape(CLOSE);

    // --- Draw bottom of the tube ---
    beginShape();
    for (int i = 0; i < sides; i++) {
      float x = cos( radians( i * angle ) ) * r;
      float y = sin( radians( i * angle ) ) * r;
      vertex(x, y, halfHeight);
    }
    endShape(CLOSE);

    // --- Draw sides ---
    beginShape(TRIANGLE_STRIP);
    for (int i = 0; i < sides + 1; i++) {
      float x = cos( radians( i * angle ) ) * r;
      float y = sin( radians( i * angle ) ) * r;
      vertex( x, y, halfHeight);
      vertex( x, y, -halfHeight);
    }
	
    endShape(CLOSE);

    popMatrix();
  }
}

