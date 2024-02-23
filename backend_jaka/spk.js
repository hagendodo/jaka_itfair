const datas = [
  [5, 4, 5, 5, 5, 3, 4],
  [
    5, 4, 5, 5, 3, 3, 4, 5, 5, 5, 5, 4, 3, 3, 4, 5, 5, 5, 5, 4, 5, 4, 5, 5, 3,
    3, 4, 5, 5, 5, 5, 4, 3, 3, 4, 5, 5, 5, 5, 4,
  ],
  [5],
];

const results = datas.map((subArray) => {
  const sum = subArray.reduce((acc, value) => acc + value, 0);
  const average = parseFloat((sum / subArray.length).toFixed(3));
  const length = subArray.length;
  return [average, length];
});

console.log(results);

const sorted = results.map((res) => {
  return res[0] * 0.8 + parseInt((res[1] + 1) / 10) + ((res[1] + 1) % 10) / 10;
});

console.log(sorted);
