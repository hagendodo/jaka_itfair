List<dynamic> merchants = [
  {
    "_id": 1,
    "title": "Kantin Jago",
    "time": "8:00am - 3.00pm",
    "imageURL":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/6/62/NCI_Visuals_Food_Hamburger.jpg/375px-NCI_Visuals_Food_Hamburger.png",
    "owner": "Bu Astuti",
    "logoURL":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/2/24/LEGO_logo.svg/512px-LEGO_logo.svg.png",
    "rating": 5,
    "ratingCount": "213",
    "coords": {
      "id": "2023",
      "latitude": 37.7892117665919,
      "longitude": -122.41325651079953,
      "address": "Kantin Atas UIN SGD Kampus 1",
      "title": "Kantin Jago",
      "latitudeDelta": 0.0122,
      "longtitudeDelta": 0.0221,
    }
  },
  {
    "_id": 2,
    "title": "Kantin Abah",
    "time": "7:30am - 2.00pm",
    "imageURL":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/6/62/NCI_Visuals_Food_Hamburger.jpg/375px-NCI_Visuals_Food_Hamburger.png",
    "owner": "Abah Bahar",
    "logoURL":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/2/24/LEGO_logo.svg/512px-LEGO_logo.svg.png",
    "rating": 2,
    "ratingCount": "421",
    "coords": {
      "id": "2021",
      "latitude": 37.7892117665919,
      "longitude": -122.41325651079953,
      "address": "Kantin Baru UIN SGD Kampus 1",
      "title": "Kantin Abah",
      "latitudeDelta": 0.0122,
      "longtitudeDelta": 0.0221,
    }
  },
  {
    "_id": 3,
    "title": "Kantin Sehat",
    "time": "9:00am - 6.00pm",
    "imageURL":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/6/62/NCI_Visuals_Food_Hamburger.jpg/375px-NCI_Visuals_Food_Hamburger.png",
    "owner": "Bu Acah",
    "logoURL":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/2/24/LEGO_logo.svg/512px-LEGO_logo.svg.png",
    "rating": 5,
    "ratingCount": "912",
    "coords": {
      "id": "2022",
      "latitude": 37.7892117665919,
      "longitude": -122.41325651079953,
      "address": "Kantin Bawah UIN SGD Kampus 1",
      "title": "Kantin Sehat",
      "latitudeDelta": 0.0122,
      "longtitudeDelta": 0.0221,
    }
  },
  {
    "_id": 4,
    "title": "Kantin Murah",
    "time": "9:00am - 6.00pm",
    "imageURL":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/6/62/NCI_Visuals_Food_Hamburger.jpg/375px-NCI_Visuals_Food_Hamburger.png",
    "owner": "Abah Ganteng",
    "logoURL":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/2/24/LEGO_logo.svg/512px-LEGO_logo.svg.png",
    "rating": 4,
    "ratingCount": "121",
    "coords": {
      "id": "2021",
      "latitude": 37.7892117665919,
      "longitude": -122.41325651079953,
      "address": "Kantin Atas UIN SGD Kampus 1",
      "title": "Kantin Murah",
      "latitudeDelta": 0.0122,
      "longtitudeDelta": 0.0221,
    }
  },
  {
    "_id": 5,
    "title": "Kantin Aja",
    "time": "6:00am - 3.30pm",
    "imageURL":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/6/62/NCI_Visuals_Food_Hamburger.jpg/375px-NCI_Visuals_Food_Hamburger.png",
    "owner": "Bu Maryam",
    "logoURL":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/2/24/LEGO_logo.svg/512px-LEGO_logo.svg.png",
    "rating": 3,
    "ratingCount": "521",
    "coords": {
      "id": "2023",
      "latitude": 37.7892117665919,
      "longitude": -122.41325651079953,
      "address": "Kantin Bawah UIN SGD Kampus 1",
      "title": "Kantin Aja",
      "latitudeDelta": 0.0122,
      "longtitudeDelta": 0.0221,
    }
  },
];

List<Map<String, dynamic>> foods = [
  {
    "_id": 1,
    "title": "Ayam Preman",
    "foodTags": ["Ayam Geprek", "Ayam Goreng", "Ayam Bakar"],
    "foodType": ["Food"],
    "code": "312312",
    "isAvailable": true,
    "merchant": "1",
    "rating": 4.9,
    "ratingCount": "211",
    "description":
        "Ayam terenak di Se-UIN BDG pokonamah, Jangan lupa beli kami membantu UMKM Lokal yaa",
    "price": 6000,
    "additives": [
      {"id": 1, "title": "Ayam Geprek", "price": "13"},
      {"id": 2, "title": "Ayam Goreng", "price": "10"},
      {"id": 3, "title": "Ayam Bakar", "price": "17"},
    ],
    "imageURL":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/9/91/Pizza-3007395.jpg/330px-Pizza-3007395.png",
    "time": "35 min",
    "category": 2,
  },
  {
    "_id": 2,
    "title": "Cakue Mantap",
    "foodTags": ["Asin", "Keju", "Pedas"],
    "foodType": ["Food"],
    "code": "391021",
    "isAvailable": true,
    "merchant": "2",
    "rating": 4.0,
    "ratingCount": "812",
    "description":
        "Cakue yang paling enak di UIN Bandung, Jangan lupa beli kami membantu UMKM Lokal yaa",
    "price": 7000,
    "additives": [
      {"id": 1, "title": "Asin Pedas", "price": "13"},
      {"id": 2, "title": "Asin Keju", "price": "10"},
      {"id": 3, "title": "Keju Pedas", "price": "17"},
    ],
    "imageURL":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/9/91/Pizza-3007395.jpg/330px-Pizza-3007395.png",
    "time": "15 min",
    "category": 6,
  },
  {
    "_id": 3,
    "title": "Batagor Kuah",
    "foodTags": ["Kering", "Kuah"],
    "foodType": ["Food"],
    "code": "998121",
    "isAvailable": true,
    "merchant": "3",
    "rating": 4.5,
    "ratingCount": "771",
    "description":
        "Batagor yang paling enak di UIN Bandung, Jangan lupa beli kami membantu UMKM Lokal yaa",
    "price": 5000,
    "additives": [
      {"id": 1, "title": "Batagor Kering", "price": "10"},
      {"id": 2, "title": "Batagor Kuah", "price": "10"},
    ],
    "imageURL":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/9/91/Pizza-3007395.jpg/330px-Pizza-3007395.png",
    "time": "10 min",
    "category": 3,
  },
  {
    "_id": 4,
    "title": "Teh Sehat",
    "foodTags": ["Original", "Rasa"],
    "foodType": ["Drink"],
    "code": "132112",
    "isAvailable": true,
    "merchant": "4",
    "rating": 4.8,
    "ratingCount": "3123",
    "description":
        "Teh Poci yang paling enak di UIN Bandung, Jangan lupa beli kami membantu UMKM Lokal yaa",
    "price": 3500,
    "additives": [
      {"id": 1, "title": "Original", "price": "5"},
      {"id": 2, "title": "Lychee", "price": "7"},
      {"id": 3, "title": "Manggo", "price": "6"},
    ],
    "imageURL":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/9/91/Pizza-3007395.jpg/330px-Pizza-3007395.png",
    "time": "10 min",
    "category": 5000,
  },
  {
    "_id": 5,
    "title": "Basreng Gacor",
    "foodTags": ["Kering"],
    "foodType": ["Food"],
    "code": "512112",
    "isAvailable": true,
    "merchant": "5",
    "rating": 4.5,
    "ratingCount": "771",
    "description":
        "Basreng yang paling enak di UIN Bandung, Jangan lupa beli kami membantu UMKM Lokal yaa",
    "price": 15000,
    "additives": [
      {"id": 1, "title": "Asin Pedas", "price": "5"},
      {"id": 2, "title": "Keju Manis", "price": "5"},
      {"id": 3, "title": "Asin Keju", "price": "5"},
    ],
    "imageURL":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/9/91/Pizza-3007395.jpg/330px-Pizza-3007395.png",
    "time": "15 min",
    "category": 3,
  },
  {
    "_id": 6,
    "title": "Bala Bala Gengster",
    "foodTags": ["Kering"],
    "foodType": ["Food"],
    "code": "512112",
    "isAvailable": true,
    "merchant": "1",
    "rating": 3,
    "ratingCount": "771",
    "description":
        "Bala Bala yang paling enak di UIN Bandung, Jangan lupa beli kami membantu UMKM Lokal yaa",
    "price": 15000,
    "additives": [
      {"id": 1, "title": "Asin Pedas", "price": "5"},
      {"id": 2, "title": "Keju Manis", "price": "5"},
      {"id": 3, "title": "Asin Keju", "price": "5"},
    ],
    "imageURL":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/9/91/Pizza-3007395.jpg/330px-Pizza-3007395.png",
    "time": "5 min",
    "category": 3,
  },
  {
    "_id": 7,
    "title": "Seblak",
    "foodTags": ["Kering", "Kuah"],
    "foodType": ["Food"],
    "code": "512112",
    "isAvailable": true,
    "merchant": "3",
    "rating": 3,
    "ratingCount": "771",
    "description":
        "Bala Bala yang paling enak di UIN Bandung, Jangan lupa beli kami membantu UMKM Lokal yaa",
    "price": 15000,
    "additives": [
      {"id": 1, "title": "Asin Pedas", "price": "5"},
      {"id": 2, "title": "Keju Manis", "price": "5"},
      {"id": 3, "title": "Asin Keju", "price": "5"},
    ],
    "imageURL":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/9/91/Pizza-3007395.jpg/330px-Pizza-3007395.png",
    "time": "5 min",
    "category": 3,
  },
];

List<dynamic> orders = [
  {
    "_id": 1,
    "title": "Mie Gacoan, Es Teh Manis",
    "status": "active",
    "totalprice": 900000,
    "menu": "4 Mie Gacoan lv2, Mie Gacoan lv1",
  },
  {
    "_id": 2,
    "title": "Mie Gacoan dan Milo Anget nya yaaa",
    "status": "delivered",
    "totalprice": 900000,
    "menu": "4 Mie Gacoan lv2, Mie Gacoan lv1",
  },
  {
    "_id": 3,
    "title": "Mie Gacoan",
    "status": "canceled",
    "totalprice": 9000,
    "menu": "aku sayang kamu deh coba in ini bisa dong ke bawah",
  },
  {
    "_id": 2,
    "title": "Mie Gacoan dan Milo Anget nya yaaa",
    "status": "delivered",
    "totalprice": 900000,
    "menu": "4 Mie Gacoan lv2, Mie Gacoan lv1",
  },
  {
    "_id": 3,
    "title": "Mie Gacoan",
    "status": "canceled",
    "totalprice": 9000,
    "menu": "aku sayang kamu deh coba in ini bisa dong ke bawah",
  },
  {
    "_id": 2,
    "title": "Mie Gacoan dan Milo Anget nya yaaa",
    "status": "delivered",
    "totalprice": 900000,
    "menu": "4 Mie Gacoan lv2, Mie Gacoan lv1",
  },
  {
    "_id": 3,
    "title": "Mie Gacoan",
    "status": "canceled",
    "totalprice": 9000,
    "menu": "aku sayang kamu deh coba in ini bisa dong ke bawah",
  },
  {
    "_id": 2,
    "title": "Mie Gacoan dan Milo Anget nya yaaa",
    "status": "delivered",
    "totalprice": 900000,
    "menu": "4 Mie Gacoan lv2, Mie Gacoan lv1",
  },
  {
    "_id": 3,
    "title": "Mie Gacoan",
    "status": "canceled",
    "totalprice": 9000,
    "menu": "aku sayang kamu deh coba in ini bisa dong ke bawah",
  },
  {
    "_id": 2,
    "title": "Mie Gacoan dan Milo Anget nya yaaa",
    "status": "delivered",
    "totalprice": 900000,
    "menu": "4 Mie Gacoan lv2, Mie Gacoan lv1",
  },
  {
    "_id": 3,
    "title": "Mie Gacoan",
    "status": "canceled",
    "totalprice": 9000,
    "menu": "aku sayang kamu deh coba in ini bisa dong ke bawah",
  },
  {
    "_id": 2,
    "title": "Mie Gacoan dan Milo Anget nya yaaa",
    "status": "delivered",
    "totalprice": 900000,
    "menu": "4 Mie Gacoan lv2, Mie Gacoan lv1",
  },
  {
    "_id": 3,
    "title": "Mie Gacoan",
    "status": "canceled",
    "totalprice": 9000,
    "menu": "aku sayang kamu deh coba in ini bisa dong ke bawah",
  },
  {
    "_id": 2,
    "title": "Mie Gacoan dan Milo Anget nya yaaa",
    "status": "delivered",
    "totalprice": 900000,
    "menu": "4 Mie Gacoan lv2, Mie Gacoan lv1",
  },
  {
    "_id": 3,
    "title": "Mie Gacoan",
    "status": "canceled",
    "totalprice": 9000,
    "menu": "aku sayang kamu deh coba in ini bisa dong ke bawah",
  },
];

List<Map<String, dynamic>> carts = [
  {
    "_id": 1,
    "food": "2",
    "merchant": "2",
  },
  {
    "_id": 2,
    "food": "1",
    "merchant": "1",
  },
  {
    "_id": 3,
    "food": "6",
    "merchant": "1",
  },
];
