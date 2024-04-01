function calculateDifference(point1, point2, referencePoint) {
  // Menghitung selisih untuk point1
  const diff1 = {
    x: point1.x - referencePoint.x,
    y: point1.y - referencePoint.y,
  };

  // Menghitung selisih untuk point2
  const diff2 = {
    x: point2.x - referencePoint.x,
    y: point2.y - referencePoint.y,
  };

  const t1 = diff1.x + diff1.y;
  const t2 = diff2.x + diff2.y;

  if (t1 < t2) {
    return diff1;
  }

  if (t1 == t2) {
    return Math.abs(diff1.x - diff1.y) < Math.abs(diff2.x - diff2.y)
      ? diff1
      : diff2;
  }

  return diff2;
}

// Contoh pemanggilan fungsi
const point1 = { x: 4, y: 5 };
const point2 = { x: 5, y: 4 };
const referencePoint = { x: 3, y: 4 };

const differences = calculateDifference(point1, point2, referencePoint);

console.log(differences);
