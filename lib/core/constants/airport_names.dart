class AirportNames {
  static Map<String, String> airportCodeMap = {
    "BDP": "Bhadrapur",
    "BHR": "Bharatpur",
    "BIR": "Biratnagar",
    "BJR": "Bajura",
    "BWA": "Bhairahawa",
    "DHI": "Dhangadhi",
    "DOP": "Dolpa",
    "ILM": "Ilam",
    "IMK": "Simikot",
    "JKR": "Janakpur",
    "JMO": "Jomsom",
    "JUM": "Jumla",
    "KEP": "Nepalgunj",
    "KTM": "Kathmandu",
    "LUA": "Lukla",
    "PKR": "Pokhara",
    "PPL": "Phaplu",
    "RARA": "Rara",
    "RHP": "Ramechhap",
    "RJB": "Rajbiraj",
    "SIF": "Simara",
    "SKH": "Surkhet",
    "TMI": "Tumlingtar",
    "VNS": "Varanasi"
  };

  static getAirportName({required String airportCode}) {
    return airportCodeMap[airportCode];
  }
}
