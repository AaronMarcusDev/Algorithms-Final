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


  void showHint() {
    hint(DISABLE_DEPTH_TEST); // Otherwise the terrain will go through it :(
    // https://processing.org/reference/hint_.html

    textSize(24);             
    textAlign(LEFT, BOTTOM);

    // darker text in the back like a drop shadow
    fill(0, 150);
    text("Press M for Menu", 21, height - 19);
    fill(255);
    text("Press M for Menu", 20, height - 20);

    hint(ENABLE_DEPTH_TEST); // Enable 3D depth again
  }

  
  void show() {
    if (showMenu) {
      // Blurry background
      fill(100, 100, 100, 150);
      //                   ^-- Opacity
      rect(0, 0, width, height);

      textAlign(CENTER, TOP);
      fill(255);
      textSize(36);
      text("MENU", width / 2, 60);

      // Divider
      stroke(255); // White line
      strokeWeight(2);
      line(width / 2 - 200, 100, width / 2 + 200, 100);

      textSize(18);
      fill(255);

      // Left-align the actual text but keep the block centered
      textAlign(LEFT, TOP);
      float startX = width / 2 - 130;
      float startY = 140;
      float spacing = 40; // Vertical gap between lines

      text("> 'g' to regenerate terrain", startX, startY);
      text("> 'r' to remove all current birds", startX, startY + spacing);
      text("> right mouse click for spawning new bird", startX, startY + (spacing * 2));
      text("> left mouse click for throwing a rock", startX, startY + (spacing * 3));
      text("> 'm' for opening/closing menu", startX, startY + (spacing * 4));

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
        // println("Terrain height set to: " + selectedTerrainHeight);
      }
    }
  }
}

