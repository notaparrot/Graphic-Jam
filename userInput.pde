//////////////////////////////////////////////////////////////////////
//Overview controls//
//////////////////////////////////////////////////////////////////////

//Switch to different mode

void onStartButtonRelease() {
  if (graphicMode == 0) {
    initiateBezierMode = true;
    listCurves.clear();
    storeBezier();
    stored = false;
    graphicMode = 1;
    initiateTextPlacement = false;
  } else if (graphicMode == 1) {
    //store svg drawing and switch to placement mode
    pg = createGraphics(width, height);
    pg.smooth(8);
    pg.beginDraw();
    if (isCapRound == false) {
      pg.strokeCap(SQUARE);

    } else {
      pg.strokeCap(ROUND);
    }
    pg.colorMode(HSB, 100, 100, 100, 255);
    pg.strokeWeight(lineStrokeWeight);
    pg.stroke(colorWheelH, colorWheelS, 80);
    pg.noFill();
    //pg.background(0, 0, 0, 0);
    for (int i = 0; i < listCurves.size(); i++) {
      pg.beginShape();
      listCurves.get(i).transferPg(pg);
      pg.endShape();
    }
    pg.endDraw();

    // initiatePhotoMode = true;
    initiatePlacementMode = true;
    graphicMode = 0;
    //move cursor in an appropriate place to paste the shape
    cursor1x = 0;
    cursor1y = 0;
    cursor2x = width;
    cursor2y = height;
  } else if (graphicMode == 2) {
    initiateTextPlacement = true;
    graphicMode = 0;
    //move cursor in an appropriate place to paste the shape
    cursor1x = 0;
    cursor1y = 0;
    cursor2x = width;
    cursor2y = height;

  }
}

void getUserInputPlacement() {
  float cursorSpeed = 7.5;

  //left joystick
  if (xboxController.getSlider("leftJoyX").getValue() > 0.2) {
    cursor1x += abs(xboxController.getSlider("leftJoyX").getValue()) * cursorSpeed;
  }
  if (xboxController.getSlider("leftJoyX").getValue() < -0.2) {
    cursor1x -= abs(xboxController.getSlider("leftJoyX").getValue()) * cursorSpeed;
  }
  if (xboxController.getSlider("leftJoyY").getValue() > 0.2) {
    cursor1y += abs(xboxController.getSlider("leftJoyY").getValue()) * cursorSpeed;
  }
  if (xboxController.getSlider("leftJoyY").getValue() < -0.2) {
    cursor1y -= abs(xboxController.getSlider("leftJoyY").getValue()) * cursorSpeed;
  }

  //right joystick
  if (xboxController.getSlider("rightJoyX").getValue() > 0.2) {
    cursor2x += abs(xboxController.getSlider("rightJoyX").getValue()) * cursorSpeed;
  }
  if (xboxController.getSlider("rightJoyX").getValue() < -0.2) {
    cursor2x -= abs(xboxController.getSlider("rightJoyX").getValue()) * cursorSpeed;
  }
  if (xboxController.getSlider("rightJoyY").getValue() > 0.2) {
    cursor2y += abs(xboxController.getSlider("rightJoyY").getValue()) * cursorSpeed;
  }
  if (xboxController.getSlider("rightJoyY").getValue() < -0.2) {
    cursor2y -= abs(xboxController.getSlider("rightJoyY").getValue()) * cursorSpeed;
  }
}

//in bezier mode:  store the curve in the list
//in photo mode: print svg on image
void onSelectButtonRelease() {
  if (graphicMode == 1) {
    storeBezier();
  }

  if (graphicMode == 2) {
    if (textMode == 0) {
      textMode = 1;
    } else {
      textMode = 0;
    }
  }

  if (graphicMode == 0) {
    initiatePlacementMode = false;
    graphicMode = 2;
  }
}

//////////////////////////////////////////////////////////////////////
//Photo Control//
//////////////////////////////////////////////////////////////////////


public void getUserInputPhoto() {

  float cursorSpeed = 7.5;

  //left joystick
  if (xboxController.getSlider("leftJoyX").getValue() > 0.2) {
    cursor1x += abs(xboxController.getSlider("leftJoyX").getValue()) * cursorSpeed;
  }
  if (xboxController.getSlider("leftJoyX").getValue() < -0.2) {
    cursor1x -= abs(xboxController.getSlider("leftJoyX").getValue()) * cursorSpeed;
  }
  if (xboxController.getSlider("leftJoyY").getValue() > 0.2) {
    cursor1y += abs(xboxController.getSlider("leftJoyY").getValue()) * cursorSpeed;
  }
  if (xboxController.getSlider("leftJoyY").getValue() < -0.2) {
    cursor1y -= abs(xboxController.getSlider("leftJoyY").getValue()) * cursorSpeed;
  }

  //right joystick
  if (xboxController.getSlider("rightJoyX").getValue() > 0.2) {
    cursor2x += abs(xboxController.getSlider("rightJoyX").getValue()) * cursorSpeed;
  }
  if (xboxController.getSlider("rightJoyX").getValue() < -0.2) {
    cursor2x -= abs(xboxController.getSlider("rightJoyX").getValue()) * cursorSpeed;
  }
  if (xboxController.getSlider("rightJoyY").getValue() > 0.2) {
    cursor2y += abs(xboxController.getSlider("rightJoyY").getValue()) * cursorSpeed;
  }
  if (xboxController.getSlider("rightJoyY").getValue() < -0.2) {
    cursor2y -= abs(xboxController.getSlider("rightJoyY").getValue()) * cursorSpeed;
  }

  //prevent cursors from going offscreen
  cursor1x = constrain(cursor1x, 0, width);
  cursor2x = constrain(cursor2x, 0, width);
  cursor1y = constrain(cursor1y, 0, height);
  cursor2y = constrain(cursor2y, 0, height);
}

void triggerCursors() {
  if (xboxController.getButton("leftSTrig").pressed()) {
    isCursor1triggered = true;
  }
  if (xboxController.getButton("rightSTrig").pressed()) {
    isCursor2triggered = true;
  }
}

void onLeftSTrigRelease() {
  isCursor1triggered = false;
  paste = true;
}

void onRightSTrigRelease() {
  isCursor2triggered = false;
  paste = true;
}


//////////////////////////////////////////////////////////////////////
//Bezier Controls//
//////////////////////////////////////////////////////////////////////

public void getUserInputBezier() {

  int cursorSpeed = 3;

  //left joystick
  if (xboxController.getSlider("leftJoyX").getValue() > 0.5) {
    activeCurvePoints[0].x += cursorSpeed;
  }
  if (xboxController.getSlider("leftJoyX").getValue() < -0.5) {
    activeCurvePoints[0].x -= cursorSpeed;
  }
  if (xboxController.getSlider("leftJoyY").getValue() > 0.5) {
    activeCurvePoints[0].y += cursorSpeed;
  }
  if (xboxController.getSlider("leftJoyY").getValue() < -0.5) {
    activeCurvePoints[0].y -= cursorSpeed;
  }

  //right joystick
  if (xboxController.getSlider("rightJoyX").getValue() > 0.5) {
    activeCurvePoints[3].x += cursorSpeed;
  }
  if (xboxController.getSlider("rightJoyX").getValue() < -0.5) {
    activeCurvePoints[3].x -= cursorSpeed;
  }
  if (xboxController.getSlider("rightJoyY").getValue() > 0.5) {
    activeCurvePoints[3].y += cursorSpeed;
  }
  if (xboxController.getSlider("rightJoyY").getValue() < -0.5) {
    activeCurvePoints[3].y -= cursorSpeed;
  }

  //directional cross 

  if (xboxController.getHat("dirCross").left()) {
    activeCurvePoints[1].x -= cursorSpeed;
  }
  if (xboxController.getHat("dirCross").right()) {
    activeCurvePoints[1].x += cursorSpeed;
  }
  if (xboxController.getHat("dirCross").up()) {
    activeCurvePoints[1].y -= cursorSpeed;
  }
  if (xboxController.getHat("dirCross").down()) {
    activeCurvePoints[1].y += cursorSpeed;
  }
  //right buttons

  if (xboxController.getButton("aButton").pressed()) {
    activeCurvePoints[2].y += cursorSpeed;
  }

  if (xboxController.getButton("yButton").pressed()) {
    activeCurvePoints[2].y -= cursorSpeed;
  }

  if (xboxController.getButton("xButton").pressed()) {
    activeCurvePoints[2].x -= cursorSpeed;
  }

  if (xboxController.getButton("bButton").pressed()) {
    activeCurvePoints[2].x += cursorSpeed;
  }


  // round position of cursor mapped to joysticks
  ////left joystick
  if (xboxController.getSlider("leftJoyX").getValue() < 0.5 && xboxController.getSlider("leftJoyX").getValue() > -0.5) {
    activeCurvePoints[0].x = roundToGrid(int(activeCurvePoints[0].x));
  }
  if (xboxController.getSlider("leftJoyY").getValue() < 0.5 && xboxController.getSlider("leftJoyY").getValue() > -0.5) {
    activeCurvePoints[0].y = roundToGrid(int(activeCurvePoints[0].y));
  }
  ////right joystick
  if (xboxController.getSlider("rightJoyX").getValue() < 0.5 && xboxController.getSlider("rightJoyX").getValue() > -0.5) {
    activeCurvePoints[3].x = roundToGrid(int(activeCurvePoints[3].x));
  }
  if (xboxController.getSlider("rightJoyY").getValue() < 0.5 && xboxController.getSlider("rightJoyY").getValue() > -0.5) {
    activeCurvePoints[3].y = roundToGrid(int(activeCurvePoints[3].y));
  }
  ////directional cross
  if (xboxController.getHat("dirCross").left() == false && xboxController.getHat("dirCross").right() == false) {
    activeCurvePoints[1].x = roundToGrid(int(activeCurvePoints[1].x));
  }
  if (xboxController.getHat("dirCross").up() == false && xboxController.getHat("dirCross").down() == false) {
    activeCurvePoints[1].y = roundToGrid(int(activeCurvePoints[1].y));
  }

  //prevent cursors from going offscreen
  activeCurvePoints[0].x = constrain(activeCurvePoints[0].x, 0, width);
  activeCurvePoints[0].y = constrain(activeCurvePoints[0].y, 0, height);
  activeCurvePoints[1].x = constrain(activeCurvePoints[1].x, 0, width);
  activeCurvePoints[1].y = constrain(activeCurvePoints[1].y, 0, height);
  activeCurvePoints[2].x = constrain(activeCurvePoints[2].x, 0, width);
  activeCurvePoints[2].y = constrain(activeCurvePoints[2].y, 0, height);
  activeCurvePoints[3].x = constrain(activeCurvePoints[3].x, 0, width);
  activeCurvePoints[3].y = constrain(activeCurvePoints[3].y, 0, height);

  //change line strokeWeight
  if (xboxController.getButton("rightSTrig").pressed()) {
    lineStrokeWeight += 1;
  }
  if (xboxController.getButton("leftSTrig").pressed()) {
    lineStrokeWeight -= 1;
    if (lineStrokeWeight < 1) {
      lineStrokeWeight = 1;
    }
  }

  //change color
  if (xboxController.getSlider("rightBTrig").getValue() > 0.5) {
    colorWheelH += 1;
    if (colorWheelH >= 100) {
      colorWheelH = 0;
    }
  }
  if (xboxController.getSlider("leftBTrig").getValue() > 0.5) {
    colorWheelS += 1;
    if (colorWheelS >= 100) {
      colorWheelS = 0;
    }
  }
}



// events to round cursor position when the button is not pressed anymore
void onaButtonRelease() {
  if (graphicMode == 1) {
    activeCurvePoints[2].y = roundToGrid(int(activeCurvePoints[2].y));
  } else if (graphicMode == 0 && initiatePlacementMode == true) {
    //paste the generated shape
    photo.blend(pg, 0, 0, width, height, cursor1x, cursor1y, cursor2x, cursor2y, LIGHTEST);
    initiatePlacementMode = false;

    cursor1x = width / 2 - 5;
    cursor1y = height / 2 - 5;
    cursor2x = width / 2 + 5;
    cursor2y = height / 2 + 5;

    //odd bug workaround
    paste = false;
  } else if (graphicMode == 0 && initiateTextPlacement == true) {
pastingTextL = true;

  } else if (graphicMode == 2) {
    showGrid = !showGrid;
  }
}
void onyButtonRelease() {
  if (graphicMode == 1) {
    activeCurvePoints[2].y = roundToGrid(int(activeCurvePoints[2].y));
  } else if (graphicMode == 2) {
    textDeformMode++;
    if (textDeformMode == 4) {
      textDeformMode = 0;
    }
  }
}
void onxButtonRelease() {
  if (graphicMode == 1) {
    activeCurvePoints[2].x = roundToGrid(int(activeCurvePoints[2].x));
  } else if (graphicMode == 2) {
    fontSelector++;
    if (fontSelector >= 5) {
      fontSelector = 0;
    }
    textFont(fonts[fontSelector]);
    textCursor = textWidth(lines.get(lines.size() - 1));

  }
}
void onbButtonRelease() {
  if (graphicMode == 1) {

    activeCurvePoints[2].x = roundToGrid(int(activeCurvePoints[2].x));
  } else if (graphicMode == 0 && initiatePlacementMode == true) {
    // paste the generated shape
    photo.blend(pg, 0, 0, width, height, cursor1x, cursor1y, cursor2x, cursor2y, DARKEST);
    initiatePlacementMode = false;

    cursor1x = width / 2 - 5;
    cursor1y = height / 2 - 5;
    cursor2x = width / 2 + 5;
    cursor2y = height / 2 + 5;
    //odd bug workaround
    paste = false;
  } else if (graphicMode == 2) {
    showFontGhost = !showFontGhost;
  } else if (graphicMode == 0 && initiateTextPlacement == true) {
pastingTextD = true;

  }
}

void onrightThumbRelease() {
  if (isCapRound) {
    strokeCap(SQUARE);
    isCapRound = false;
  } else {
    strokeCap(ROUND);
    isCapRound = true;
  }
}

//////////////////////////////////////////////////////////////////////
//FONT Controls//
//////////////////////////////////////////////////////////////////////

void getFontInput() {

  if (xboxController.getButton("rightSTrig").pressed()) {
    textInputSize += 1;
    textCursor = textWidth(lines.get(lines.size() - 1));

  }
  if (xboxController.getButton("leftSTrig").pressed()) {
    textInputSize -= 1;
    textCursor = textWidth(lines.get(lines.size() - 1));

    if (textInputSize < 12) {
      textInputSize = 12;
    }
  }
  //right joystick
  if (xboxController.getSlider("rightJoyX").getValue() > 0.2) {
    tilesX -= 0.1;
    if (tilesX < 4) {
      tilesX = 4;
    }
  }
  if (xboxController.getSlider("rightJoyX").getValue() < -0.2) {
    tilesX += 0.1;

  }
  if (xboxController.getSlider("rightJoyY").getValue() > 0.2) {
    tilesY -= 0.1;
    if (tilesY < 4) {
      tilesY = 4;
    }
  }
  if (xboxController.getSlider("rightJoyY").getValue() < -0.2) {
    tilesY += 0.1;
  }

  //    //left joystick
  if (xboxController.getSlider("leftJoyX").getValue() > 0.2) {
    waveStrength += 1;
  }
  if (xboxController.getSlider("leftJoyX").getValue() < -0.2) {
    waveStrength -= 1;
    if (waveStrength < 5) {
      waveStrength = 5;
    }
  }
  if (xboxController.getSlider("leftJoyY").getValue() > 0.2) {
    sinPhase += 0.01;
  }
  if (xboxController.getSlider("leftJoyY").getValue() < -0.2) {
    sinPhase -= 0.01;
    if (sinPhase < 0.1) {
      sinPhase = 0.1;
    }
  }


  //triggers
  if (xboxController.getSlider("rightBTrig").getValue() > 0.5) {
    colorWheelH += 1;
    if (colorWheelH >= 100) {
      colorWheelH = 0;
    }
  }
  if (xboxController.getSlider("leftBTrig").getValue() > 0.5) {
    colorWheelS += 1;
    if (colorWheelS >= 100) {
      colorWheelS = 0;
    }
  }
}