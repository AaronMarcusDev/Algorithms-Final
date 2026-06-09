// This class is used as a general 'storage' / overview of the colors used in this program,
// so that I can easily change them without having to search.
// It also contains some helper methods.
class ColorSet {
  color purple = color(45, 25, 80);
  color orange  = color(235, 110, 85);
  float originalBirdColor = color(random(140, 180), random(40, 70), random(180, 220));

  color getBirdColor() {
    return color(random(100, 255), random(10, 255), random(10, 255));
  }
}
