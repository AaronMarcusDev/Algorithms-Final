// Source for this function: https://forum.processing.org/one/topic/create-a-rectangular-gradient-two-colours.html
// I wrapped it in its own class

// It works by colouring two vertices,
// and then lets processing auto-merge them when generating the infill of the rectangle.

class BG {
  void gradientRect(int x, int y, int w, int h, color c1, color c2) {
    beginShape();
    fill(c1);
    vertex(x, y);
    vertex(x, y+h);
    fill(c2);
    vertex(x+w, y+h);
    vertex(x+w, y);
    endShape();
  }
}
