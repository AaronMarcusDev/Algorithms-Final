class Sphere3D {
  // saves some space everytime I want to render a spere in a 3D space
  void render(PVector pos, float size) {
    pushMatrix();
    translate(pos.x, pos.y, pos.z); // Move to the particle's active 3D coordinates
    sphere(size);             // Draw a real 3D sphere shape
    popMatrix();
  }
}
