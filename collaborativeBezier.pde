void collaborativeBezier() {
  drawBackground();
  //draw all curves
  for (int i = 0; i < listCurves.size(); i++) {
    listCurves.get(i).drawCurve();
  }

  getUserInputBezier();
  // No clue why we need to declare the following 4 vectors, but if we don't, lines stack on top of each others
  PVector movedPoint0 = new PVector(activeCurvePoints[0].x, activeCurvePoints[0].y);
  PVector movedPoint1 = new PVector(activeCurvePoints[1].x, activeCurvePoints[1].y);
  PVector movedPoint2 = new PVector(activeCurvePoints[2].x, activeCurvePoints[2].y);
  PVector movedPoint3 = new PVector(activeCurvePoints[3].x, activeCurvePoints[3].y);


  listCurves.get(listCurves.size() - 1).move(movedPoint0, movedPoint1, movedPoint2, movedPoint3);
  listCurves.get(listCurves.size() - 1).drawPlayer();
}

void drawBackground() {
  background(0, 0, 98, 120);
  strokeWeight(2);
  stroke(20);
  strokeCap(ROUND);
  for (int x = 0; x < width + gridSize; x += gridSize) {
    for (int y = 0; y < height + gridSize; y += gridSize) {
      point(x, y);
    }
  }
  if (isCapRound == false) {
    strokeCap(SQUARE);
  }
}

void storeBezier() {
  listCurves.add(new Curve());
  stored = true;
}

int roundToGrid(int n) {
  int a = (n / gridSize) * gridSize;
  int b = a + gridSize;
  return (n - a > b - n) ? b : a;
}