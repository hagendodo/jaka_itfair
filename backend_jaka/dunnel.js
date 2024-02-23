const BOBOT_RATING = 0.7;
const BOBOT_TOTAL_ORDER = 0.3;
const BOBOT_TOTAL_RATING = 0.5;
const BOBOT_ORDER_TODAY = 0.2;
const INCREMENT_ANTI_ZERO_ORDER_TODAY = 1;
const BOBOT_DISTANCE = 0.3;

function calculateSpk(data) {
  //data.totalOrder > 10 ? data.totalOrder % 10 : data.totalOrder

  console.log(
    (data.rating * BOBOT_RATING +
      Math.round(
        parseInt((data.totalOrder + 1) / 10) + ((data.totalOrder + 1) % 10) / 10
      ) *
        BOBOT_TOTAL_ORDER) *
      BOBOT_TOTAL_RATING
  );

  console.log(
    BOBOT_ORDER_TODAY / (data.orderToday + INCREMENT_ANTI_ZERO_ORDER_TODAY)
  );

  console.log((BOBOT_DISTANCE / (data.distance + 1)) * 10);

  console.log("----------");
  return parseFloat(
    (
      (data.rating * BOBOT_RATING +
        Math.round(
          parseInt((data.totalOrder + 1) / 10) +
            ((data.totalOrder + 1) % 10) / 10
        ) *
          BOBOT_TOTAL_ORDER) *
        BOBOT_TOTAL_RATING +
      BOBOT_ORDER_TODAY / (data.orderToday + INCREMENT_ANTI_ZERO_ORDER_TODAY) +
      BOBOT_DISTANCE / (data.distance + 1)
    ).toFixed(3) * data.rating
  );
}

function spk(datas) {
  const spkValues = datas.map((data) => calculateSpk(data));
  return spkValues;
}

const datas = [
  {
    rating: 4.8,
    totalOrder: 17,
    orderToday: 1,
    distance: 10,
  },
  {
    rating: 4.6,
    totalOrder: 28,
    orderToday: 2,
    distance: 10,
  },
  {
    rating: 4.2,
    totalOrder: 30,
    orderToday: 1,
    distance: 0,
  },
];

const resultSpk = spk(datas);

console.log(resultSpk);
