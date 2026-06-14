class Sphere3D {
  // saves some space everytime I want to render a sphere in a 3D space with a PVector position
  void render(PVector pos, float size) {
    noStroke();
    pushMatrix();
    translate(pos.x, pos.y, pos.z); // Move to the particle's active 3D coordinates
    sphere(size);             // Draw a real 3D sphere shape
    popMatrix();
  }
}
