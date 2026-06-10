class Menu {
  boolean showMenu = false;

  // Terrain height options
  int selectedTerrainHeight = 150;
  int[] values = {0, 75, 150, 250}; // can just be regular array (not dynamic)
  String[] labels = {"0", "75", "150", "250"};

  float btnW = 120;
  float btnH = 40;

  // Button positions
  float[] bx = new float[4];
  float[] by = new float[4];


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
      stroke(255); // White line
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
      stroke(255); // White line
      strokeWeight(2);
      line(width / 2 - 200, 390, width / 2 + 200, 390);

      // Draw terrain height buttons
      float startBtnX = width / 2 - 255;
      float startBtnY = 420;

      textAlign(CENTER, CENTER);
      textSize(22);

      // Loop through buttons and draw them
      for (int i = 0; i < 4; i++) {
        bx[i] = startBtnX + i * (btnW + 20);
        //        start loc + index * (buttonwidth + offset)
        by[i] = startBtnY; // Same for all buttons

        // Highlight selected button
        if (selectedTerrainHeight == values[i]) {
          fill(180, 220, 255);
        } else {
          fill(255);
        }

        rect(bx[i], by[i], btnW, btnH, 8);

        fill(0);
        // Place labels in center of buttons
        text(labels[i], bx[i] + btnW / 2, by[i] + btnH / 2);
      }
    }
  }

  // Handle mouse clicks on buttons
  void handleClick() {
    // loop through button
    for (int i = 0; i < 4; i++) {
      // check if mouse is in button
      if (mouseX > bx[i] && mouseX < bx[i] + btnW &&
        mouseY > by[i] && mouseY < by[i] + btnH) {

        selectedTerrainHeight = values[i];
        println("Terrain height set to: " + selectedTerrainHeight);
      }
    }
  }
}
