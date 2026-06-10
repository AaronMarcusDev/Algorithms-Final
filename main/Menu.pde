class Menu {
  boolean showMenu = false;

  int terrainHeight = 150;// Default terrain height (see Terrain.pde)
  // Rectangle[] buttons;

  // For terrain height buttons
  float btnW = 120;
  float btnH = 40;

  // Button rectangles
  // Rectangle[] buttons = {
  //   new Rectangle(0, 0, 0, 0), // 0
  //   new Rectangle(0, 0, 0, 0), // 75
  //   new Rectangle(0, 0, 0, 0), // 150
  //   new Rectangle(0, 0, 0, 0)   // 250
  // };


  void show() {
    if (showMenu) {

      // Blurry background
      fill(100, 100, 100, 150);
      //                   ^-- Opacity
      rect(0, 0, width, height);

      textAlign(CENTER, TOP);
      fill(255);
      textSize(36);
      text("MENU", width / 2, 80);

      // Divider
      stroke(255); // White line with transparency
      strokeWeight(2);
      line(width / 2 - 200, 120, width / 2 + 200, 120);

      textSize(18);
      fill(255);

      // Left-align the actual text but keep the block centered
      textAlign(LEFT, TOP);
      float startX = width / 2 - 130;
      float startY = 170;
      float spacing = 40; // Vertical gap between lines

      text("> 'g' to regenerate terrain", startX, startY);
      text("> 'r' to remove all current birds", startX, startY + spacing);
      text("> mouse click for spawning new bird", startX, startY + (spacing * 2));
      text("> 'm' for opening/closing menu", startX, startY + (spacing * 3));

      fill(255);
      textSize(28);
      text("Set max terrain height", width / 2 - 130, 350);

      // Divider
      stroke(255); // White line with transparency
      strokeWeight(2);
      line(width / 2 - 200, 390, width / 2 + 200, 390);

      // text("Type a nu");
    }
  }

  // void menuClick() {
  //   int[] values = {0, 75, 150, 250};

  //   for (int i = 0; i < 4; i++) {
  //     Rectangle r = menu.buttons[i];

  //     if (mouseX > r.x && mouseX < r.x + r.w &&
  //       mouseY > r.y && mouseY < r.y + r.h) {

  //       terrainHeight = values[i];
  //       println("Terrain height set to: " + terrainHeight);
  //     }
  //   }
  // }
}
