// import 'package:flutter/material.dart';

class States {
  List Tehsil = ["Tehsil1", "Tehsil2", "Tehsil3", "Tehsil4", "Tehsil5","Tehsil6", "Tehsil7", "Tehsil8", "Tehsil9", "Tehsil10"];
  List Ward = ["Ward1", "Ward2", "Ward3", "Ward4", "Ward5","Ward6", "Ward7", "Ward8", "Ward9", "Ward10"];

//https://github.com/CoolChakshu/health-wealth-html/blob/master/multi-select.js

  Map<String,List<String>> data = {
    // 'Andhra Pradesh': [
    //   'Visakhapatnam',
    //   'Guntur',
    //   'Krishna',
    //   'East Godavari',
    //   'West Godavari',
    //   'Nellore',
    //   'Chittoor',
    //   'Anantapur',
    //   'Kadapa',
    //   'Kurnool',
    //   'Prakasam',
    //   'Vizianagaram',
    //   'Srikakulam',
    // ],
    // 'Arunachal Pradesh': [
    //   'Itanagar Capital Complex',
    //   'Tawang',
    //   'West Kameng',
    //   'East Kameng',
    //   'Papum Pare',
    //   'Kurung Kumey',
    //   'Kra Daadi',
    //   'Lower Subansiri',
    //   'Upper Subansiri',
    //   'West Siang',
    //   'East Siang',
    //   'Siang',
    //   'Upper Siang',
    // ],
    // 'Kerala': [
    //   'Thiruvananthapuram',
    //   'Kollam',
    //   'Pathanamthitta',
    //   'Alappuzha',
    //   'Kottayam',
    //   'Idukki',
    //   'Ernakulam',
    //   'Thrissur',
    //   'Palakkad',
    //   'Malappuram',
    //   'Kozhikode',
    //   'Wayanad',
    //   'Kannur',
    //   'Kasaragod',
    // ],
    // 'Madhya Pradesh': [
    //   'Bhopal',
    //   'Indore',
    //   'Jabalpur',
    //   'Gwalior',
    //   'Ujjain',
    //   'Rewa',
    //   'Sagar',
    //   'Ratlam',
    //   'Satna',
    //   'Chhindwara',
    //   'Morena',
    //   'Bhind',
    //   'Shivpuri',
    //   'Guna',
    //   'Datia',
    //   'Mandsaur',
    //   'Neemuch',
    //   'Panna',
    //   'Tikamgarh',
    //   'Damoh',
    //   'Vidisha',
    //   'Ashoknagar',
    //   'Singrauli',
    //   'Sidhi',
    //   'Anuppur',
    //   'Shahdol',
    //   'Umaria',
    //   'Dindori',
    // ],
    // 'Maharashtra': [
    //   'Mumbai City',
    //   'Mumbai Suburban',
    //   'Thane',
    //   'Palghar',
    //   'Raigad',
    //   'Ratnagiri',
    //   'Sindhudurg',
    //   'Nashik',
    //   'Ahmednagar',
    //   'Jalgaon',
    //   'Dhule',
    //   'Nandurbar',
    //   'Pune',
    //   'Solapur',
    //   'Satara',
    //   'Sangli',
    //   'Kolhapur',
    //   'Aurangabad',
    //   'Jalna',
    //   'Beed',
    //   'Osmanabad',
    //   'Nanded',
    //   'Parbhani',
    //   'Hingoli',
    //   'Latur',
    //   'Washim',
    //   'Yavatmal',
    //   'Amravati',
    //   'Akola',
    //   'Buldhana',
    //   'Nagpur',
    //   'Wardha',
    //   'Bhandara',
    //   'Gondia',
    //   'Chandrapur',
    //   'Gadchiroli',
    // ],
    // 'Manipur': [
    //   'Bishnupur',
    //   'Chandel',
    //   'Churachandpur',
    //   'Imphal East',
    //   'Imphal West',
    //   'Jiribam',
    //   'Kakching',
    //   'Kamjong',
    //   'Kangpokpi',
    //   'Noney',
    //   'Pherzawl',
    //   'Senapati',
    //   'Tamenglong',
    //   'Tengnoupal',
    //   'Thoubal',
    //   'Ukhrul',
    // ],
    // 'Meghalaya': [
    //   'East Garo Hills',
    //   'West Garo Hills',
    //   'South Garo Hills',
    //   'North Garo Hills',
    //   'East Khasi Hills',
    //   'West Khasi Hills',
    //   'Ri-Bhoi',
    // ],
    // 'Odisha': [
    //   'Balasore',
    //   'Bhadrak',
    //   'Jajpur',
    //   'Kendrapara',
    //   'Cuttack',
    //   'Puri',
    //   'Khurda',
    //   'Nayagarh',
    //   'Jagatsinghpur',
    //   'Dhenkanal',
    //   'Angul',
    //   'Boudh',
    //   'Sonepur',
    //   'Bargarh',
    //   'Sambalpur',
    //   'Deogarh',
    //   'Jharsuguda',
    //   'Nuapada',
    //   'Balangir',
    //   'Sundargarh',
    //   'Kalahandi',
    //   'Kandhamal',
    //   'Nabarangpur',
    //   'Rayagada',
    //   'Gajapati',
    //   'Ganjam',
    //   'Koraput',
    //   'Malkangiri',
    // ],
    // 'Punjab': [
    //   'Amritsar',
    //   'Barnala',
    //   'Bathinda',
    //   'Faridkot',
    //   'Fatehgarh Sahib',
    //   'Fazilka',
    //   'Ferozepur',
    //   'Gurdaspur',
    //   'Hoshiarpur',
    //   'Jalandhar',
    //   'Kapurthala',
    //   'Ludhiana',
    //   'Mansa',
    //   'Moga',
    //   'Muktsar',
    //   'Pathankot',
    //   'Patiala',
    //   'Rupnagar',
    //   'Sangrur',
    //   'Shaheed Bhagat Singh Nagar (Nawanshahr)',
    //   'Sri Muktsar Sahib',
    //   'Tarn Taran',
    // ],
    'Rajasthan': [
    //   'Ajmer',
    //   'Alwar',
    //   'Banswara',
    //   'Baran',
    //   'Barmer',
    //   'Bharatpur',
    //   'Bhilwara',
    //   'Bikaner',
    //   'Bundi',
    //   'Chittorgarh',
    //   'Churu',
    //   'Dausa',
    //   'Dholpur',
    //   'Dungarpur',
    //   'Hanumangarh',
    //   'Jaipur',
    //   'Jaisalmer',
    //   'Jalore',
    //   'Jhalawar',
    //   'Jhunjhunu',
    //   'Jodhpur',
    //   'Karauli',
    //   'Kota',
    //   'Nagaur',
    //   'Pali',
    //   'Pratapgarh',
    //   'Rajsamand',
    //   'Sawai Madhopur',
    //   'Sikar',
      'Sirohi',
      'Sri Ganganagar',
      'Tonk',
      'Udaipur',
    ],
    'Sikkim': [
      'East Sikkim',
      'West Sikkim',
      'North Sikkim',
      'South Sikkim',
    ],
    'Tamil Nadu': [
      'Ariyalur',
      'Chengalpattu',
      'Chennai',
      'Coimbatore',
      'Cuddalore',
      'Dharmapuri',
      'Dindigul',
      'Erode',
      'Kallakurichi',
      'Kancheepuram',
      'Kanyakumari',
      'Karur',
      'Krishnagiri',
      'Madurai',
      'Nagapattinam',
      'Namakkal',
      'Nilgiris',
      'Perambalur',
      'Pudukkottai',
      'Ramanathapuram',
      'Ranipet',
      'Salem',
      'Sivaganga',
      'Tenkasi',
      'Thanjavur',
      'Theni',
      'Thoothukudi',
      'Tiruchirapalli',
      'Tirunelveli',
      'Tirupathur',
      'Tiruppur',
      'Tiruvallur',
      'Tiruvannamalai',
      'Tiruvarur',
      'Vellore',
      'Viluppuram',
      'Virudhunagar',
    ],
    'Uttar Pradesh': [
      'Agra',
      'Aligarh',
      'Allahabad',
      'Ambedkar Nagar',
      'Amethi',
      'Amroha',
      'Auraiya',
      'Azamgarh',
      'Baghpat',
      'Bahraich',
      'Ballia',
      'Balrampur',
      'Banda',
      'Barabanki',
      'Bareilly',
      'Basti',
      'Bhadohi',
      'Bijnor',
      'Budaun',
      'Bulandshahr',
      'Chandauli',
      'Chitrakoot',
      'Deoria',
      'Etah',
      'Etawah',
      'Faizabad',
      'Farrukhabad',
      'Fatehpur',
      'Firozabad',
      'Gautam Buddh Nagar',
      'Ghaziabad',
      'Ghazipur',
      'Gonda',
      'Gorakhpur',
      'Hamirpur',
      'Hapur',
      'Hardoi',
      'Hathras',
      'Jalaun',
      'Jaunpur',
      'Jhansi',
      'Kannauj',
      'Kanpur Dehat',
      'Kanpur Nagar',
      'Kasganj',
      'Kaushambi',
      'Kushinagar',
      'Lakhimpur Kheri',
      'Lalitpur',
      'Lucknow',
      'Maharajganj',
      'Mahoba',
      'Mainpuri',
      'Mathura',
      'Mau',
      'Meerut',
      'Mirzapur',
      'Moradabad',
      'Muzaffarnagar',
      'Pilibhit',
      'Pratapgarh',
      'Prayagraj',
      'Rae Bareli',
      'Rampur',
      'Saharanpur',
      'Sambhal',
      'Sant Kabir Nagar',
      'Shahjahanpur',
      'Shamli',
      'Shrawasti',
      'Siddharthnagar',
      'Sitapur',
      'Sonbhadra',
      'Sultanpur',
      'Unnao',
      'Varanasi',
    ],
    'Uttarakhand': [
      'Almora',
      'Bageshwar',
      'Chamoli',
      'Champawat',
      'Dehradun',
      'Haridwar',
      'Nainital',
      'Pauri Garhwal',
      'Pithoragarh',
      'Rudraprayag',
      'Tehri Garhwal',
      'Udham Singh Nagar',
      'Uttarkashi',
    ],
    'West Bengal': [
      'Alipurduar',
      'Bankura',
      'Birbhum',
      'Cooch Behar',
      'Dakshin Dinajpur',
      'Darjeeling',
      'Hooghly',
      'Howrah',
      'Jalpaiguri',
      'Jhargram',
      'Kalimpong',
      'Kolkata',
      'Malda',
      'Murshidabad',
      'Nadia',
      'North 24 Parganas',
      'Paschim Bardhaman',
      'Paschim Medinipur',
      'Purba Bardhaman',
      'Purba Medinipur',
      'Purulia',
      'South 24 Parganas',
      'Uttar Dinajpur',
    ],
    'Telangana': [
      'Adilabad',
      'Bhadradri Kothagudem',
      'Hyderabad',
      'Jagtial',
      'Jangaon',
      'Jayashankar Bhupalapally',
      'Jogulamba Gadwal',
      'Kamareddy',
      'Karimnagar',
      'Khammam',
      'Komaram Bheem Asifabad',
      'Mahabubabad',
      'Mahabubnagar',
      'Mancherial',
      'Medak',
      'Medchal Malkajgiri',
      'Nagarkurnool',
      'Nalgonda',
      'Nirmal',
      'Nizamabad',
      'Peddapalli',
      'Rajanna Sircilla',
      'Rangareddy',
      'Sangareddy',
      'Siddipet',
      'Suryapet',
      'Vikarabad',
      'Wanaparthy',
      'Warangal Rural',
      'Warangal Urban',
      'Yadadri Bhuvanagiri',
    ],
    'Himachal Pradesh': [
      'Bilaspur',
      'Chamba',
      'Hamirpur',
      'Kangra',
      'Kinnaur',
      'Kullu',
      'Lahaul and Spiti',
      'Mandi',
      'Shimla',
      'Sirmaur',
      'Solan',
      'Una',
    ],
    'Gujarat': [
      'Ahmedabad',
      'Amreli',
      'Anand',
      'Aravalli',
      'Banaskantha',
      'Bharuch',
      'Bhavnagar',
      'Botad',
      'Chhota Udaipur',
      'Dahod',
      'Dang',
      'Devbhoomi Dwarka',
      'Gandhinagar',
      'Gir Somnath',
      'Jamnagar',
      'Junagadh',
      'Kheda',
      'Kutch',
      'Mahisagar',
      'Mehsana',
      'Morbi',
      'Narmada',
      'Navsari',
      'Panchmahal',
      'Patan',
      'Porbandar',
      'Rajkot',
      'Sabarkantha',
      'Surat',
      'Surendranagar',
      'Tapi',
      'Vadodara',
      'Valsad',
    ],
    'Bihar': [
      'Araria',
      'Arwal',
      'Aurangabad',
      'Banka',
      'Begusarai',
      'Bhagalpur',
      'Bhojpur',
      'Buxar',
      'Darbhanga',
      'East Champaran',
      'Gaya',
      'Gopalganj',
      'Jamui',
      'Jehanabad',
      'Kaimur',
      'Katihar',
      'Khagaria',
      'Kishanganj',
      'Lakhisarai',
      'Madhepura',
      'Madhubani',
      'Munger',
      'Muzaffarpur',
      'Nalanda',
      'Nawada',
      'Patna',
      'Purnia',
      'Rohtas',
      'Saharsa',
      'Samastipur',
      'Saran',
      'Sheikhpura',
      'Sheohar',
      'Sitamarhi',
      'Siwan',
      'Supaul',
      'Vaishali',
      'West Champaran',
    ],
    'Jharkhand': [
      'Bokaro',
      'Chatra',
      'Deoghar',
      'Dhanbad',
      'Dumka',
      'East Singhbhum',
      'Garhwa',
      'Giridih',
      'Godda',
      'Gumla',
      'Hazaribagh',
      'Jamtara',
      'Khunti',
      'Koderma',
      'Latehar',
      'Lohardaga',
      'Pakur',
      'Palamu',
      'Ramgarh',
      'Ranchi',
      'Sahibganj',
      'Seraikela Kharsawan',
      'Simdega',
      'West Singhbhum',
    ],
    'Karnataka': [
      'Bagalkot',
      'Ballari',
      'Belagavi',
      'Bengaluru Rural',
      'Bengaluru Urban',
      'Bidar',
      'Chamarajanagar',
      'Chikballapur',
      'Chikkamagaluru',
      'Chitradurga',
      'Dakshina Kannada',
      'Davanagere',
      'Dharwad',
      'Gadag',
      'Hassan',
      'Haveri',
      'Kalaburagi',
      'Kodagu',
      'Kolar',
      'Koppal',
      'Mandya',
      'Mysuru',
      'Raichur',
      'Ramanagara',
      'Shivamogga',
      'Tumakuru',
      'Udupi',
      'Uttara Kannada',
      'Vijayapura',
      'Yadgir',
    ],
    'Assam': [
      'Baksa',
      'Barpeta',
      'Biswanath',
      'Bongaigaon',
      'Cachar',
      'Charaideo',
      'Chirang',
      'Darrang',
      'Dhemaji',
      'Dhubri',
      'Dibrugarh',
      'Dima Hasao',
      'Goalpara',
      'Golaghat',
      'Hailakandi',
      'Hojai',
      'Jorhat',
      'Kamrup',
      'Kamrup Metropolitan',
      'Karbi Anglong',
      'Karimganj',
      'Kokrajhar',
      'Lakhimpur',
      'Majuli',
      'Morigaon',
      'Nagaon',
      'Nalbari',
      'Sivasagar',
      'Sonitpur',
      'South Salmara-Mankachar',
      'Tinsukia',
      'Udalguri',
      'West Karbi Anglong',
    ],
    'Chhattisgarh': [
      'Balod',
      'Baloda Bazar',
      'Balrampur',
      'Bastar',
      'Bemetara',
      'Bijapur',
      'Bilaspur',
      'Dantewada',
      'Dhamtari',
      'Durg',
      'Gariaband',
      'Gaurela Pendra Marwahi',
      'Janjgir-Champa',
      'Jashpur',
      'Kabirdham',
      'Kanker',
      'Kondagaon',
      'Korba',
      'Koriya',
      'Mahasamund',
      'Mungeli',
      'Narayanpur',
      'Raigarh',
      'Raipur',
      'Rajnandgaon',
      'Sukma',
      'Surajpur',
      'Surguja',
    ],
    'Haryana': [
      'Ambala',
      'Bhiwani',
      'Charkhi Dadri',
      'Faridabad',
      'Fatehabad',
      'Gurugram',
      'Hisar',
      'Jhajjar',
      'Jind',
      'Kaithal',
      'Karnal',
      'Kurukshetra',
      'Mahendragarh',
      'Nuh',
      'Palwal',
      'Panchkula',
      'Panipat',
      'Rewari',
      'Rohtak',
      'Sirsa',
      'Sonipat',
      'Yamunanagar',
    ],
    'Nagaland': [
      'Dimapur',
      'Kiphire',
      'Kohima',
      'Longleng',
      'Mokokchung',
      'Mon',
      'Peren',
      'Phek',
      'Tuensang',
      'Wokha',
      'Zunheboto',
    ],
    'Tripura': [
      'Dhalai',
      'Gomati',
      'Khowai',
      'North Tripura',
      'Sepahijala',
      'South Tripura',
      'Unakoti',
      'West Tripura',
    ],
    'Goa': [
      'North Goa',
      'South Goa',
    ],
    'Mizoram': [
      'Aizawl',
      'Lunglei',
      'Mamit',
      'Kolasib',
      'Champhai',
      'Serchhip',
      'Lawngtlai',
      'Saiha',
    ],
  };

  Map location = {
    "Maharashtra": {
      "Districts": {
        "Mumbai": {
          "tehsil": {
            "Tehsil1": {
              "Ward1": [
                "person1",
                "person2",
                "person3",
                "person4",
                "person5"
              ],
              "Ward2": [
                "person6",
                "person7",
                "person8",
                "person9",
                "person10"
              ],
              "Ward3": [
                "person11",
                "person12",
                "person13",
                "person14",
                "person15"
              ]
            },
            "Tehsil2": {
              "Ward4": [
                "person16",
                "person17",
                "person18",
                "person19",
                "person20"
              ],
              "Ward5": [
                "person21",
                "person22",
                "person23",
                "person24",
                "person25"
              ],
              "Ward6": [
                "person26",
                "person27",
                "person28",
                "person29",
                "person30"
              ]
            }
          },
        },
        "Pune": {
          "tehsil": {
            "Tehsil1": {
              "Ward1": [
                "person1",
                "person2",
                "person3",
                "person4",
                "person5"
              ],
              "Ward2": [
                "person6",
                "person7",
                "person8",
                "person9",
                "person10"
              ],
              "Ward3": [
                "person11",
                "person12",
                "person13",
                "person14",
                "person15"
              ]
            },
            "Tehsil2": {
              "Ward4": [
                "person16",
                "person17",
                "person18",
                "person19",
                "person20"
              ],
              "Ward5": [
                "person21",
                "person22",
                "person23",
                "person24",
                "person25"
              ],
              "Ward6": [
                "person26",
                "person27",
                "person28",
                "person29",
                "person30"
              ]
            }
          },
        },
      },
    },
    "Delhi": {
      "Districts": {
        "NCR": {
          "tehsil": {
            "Tehsil1": {
              "Ward1": [
                "person1",
                "person2",
                "person3",
                "person4",
                "person5"
              ],
              "Ward2": [
                "person6",
                "person7",
                "person8",
                "person9",
                "person10"
              ],
              "Ward3": [
                "person11",
                "person12",
                "person13",
                "person14",
                "person15"
              ]
            },
            "Tehsil2": {
              "Ward4": [
                "person16",
                "person17",
                "person18",
                "person19",
                "person20"
              ],
              "Ward5": [
                "person21",
                "person22",
                "person23",
                "person24",
                "person25"
              ],
              "Ward6": [
                "person26",
                "person27",
                "person28",
                "person29",
                "person30"
              ]
            }
          },
        },
        "Faridabad": {
          "tehsil": {
            "Tehsil1": {
              "Ward1": [
                "person1",
                "person2",
                "person3",
                "person4",
                "person5"
              ],
              "Ward2": [
                "person6",
                "person7",
                "person8",
                "person9",
                "person10"
              ],
              "Ward3": [
                "person11",
                "person12",
                "person13",
                "person14",
                "person15"
              ]
            },
            "Tehsil2": {
              "Ward4": [
                "person16",
                "person17",
                "person18",
                "person19",
                "person20"
              ],
              "Ward5": [
                "person21",
                "person22",
                "person23",
                "person24",
                "person25"
              ],
              "Ward6": [
                "person26",
                "person27",
                "person28",
                "person29",
                "person30"
              ]
            }
          },
        },
      }
    },
    "UP": {
      "Districts": {
        "RamPur": {
          "tehsil": {
            "Tehsil1": {
              "Ward1": [
                "person1",
                "person2",
                "person3",
                "person4",
                "person5"
              ],
              "Ward2": [
                "person6",
                "person7",
                "person8",
                "person9",
                "person10"
              ],
              "Ward3": [
                "person11",
                "person12",
                "person13",
                "person14",
                "person15"
              ]
            },
            "Tehsil2": {
              "Ward4": [
                "person16",
                "person17",
                "person18",
                "person19",
                "person20"
              ],
              "Ward5": [
                "person21",
                "person22",
                "person23",
                "person24",
                "person25"
              ],
              "Ward6": [
                "person26",
                "person27",
                "person28",
                "person29",
                "person30"
              ]
            }
          },
        },
        "Varanasi": {
          "tehsil": {
            "Tehsil1": {
              "Ward1": [
                "person1",
                "person2",
                "person3",
                "person4",
                "person5"
              ],
              "Ward2": [
                "person6",
                "person7",
                "person8",
                "person9",
                "person10"
              ],
              "Ward3": [
                "person11",
                "person12",
                "person13",
                "person14",
                "person15"
              ]
            },
            "Tehsil2": {
              "Ward4": [
                "person16",
                "person17",
                "person18",
                "person19",
                "person20"
              ],
              "Ward5": [
                "person21",
                "person22",
                "person23",
                "person24",
                "person25"
              ],
              "Ward6": [
                "person26",
                "person27",
                "person28",
                "person29",
                "person30"
              ]
            }
          },
        },
      }
    },
    "Goa": {
      "Districts": {
        "North Goa": {
          "tehsil": {
            "Tehsil1": {
              "Ward1": [
                "person1",
                "person2",
                "person3",
                "person4",
                "person5"
              ],
              "Ward2": [
                "person6",
                "person7",
                "person8",
                "person9",
                "person10"
              ],
              "Ward3": [
                "person11",
                "person12",
                "person13",
                "person14",
                "person15"
              ]
            },
            "Tehsil2": {
              "Ward4": [
                "person16",
                "person17",
                "person18",
                "person19",
                "person20"
              ],
              "Ward5": [
                "person21",
                "person22",
                "person23",
                "person24",
                "person25"
              ],
              "Ward6": [
                "person26",
                "person27",
                "person28",
                "person29",
                "person30"
              ]
            }
          },
        },
        "South Goa": {
          "tehsil": {
            "Tehsil1": {
              "Ward1": [
                "person1",
                "person2",
                "person3",
                "person4",
                "person5"
              ],
              "Ward2": [
                "person6",
                "person7",
                "person8",
                "person9",
                "person10"
              ],
              "Ward3": [
                "person11",
                "person12",
                "person13",
                "person14",
                "person15"
              ]
            },
            "Tehsil2": {
              "Ward4": [
                "person16",
                "person17",
                "person18",
                "person19",
                "person20"
              ],
              "Ward5": [
                "person21",
                "person22",
                "person23",
                "person24",
                "person25"
              ],
              "Ward6": [
                "person26",
                "person27",
                "person28",
                "person29",
                "person30"
              ]
            }
          },
        },
      }
    },
    "Telangana": {
      "Districts": {
        "Hyderabad": {
          "tehsil": {
            "Tehsil1": {
              "Ward1": [
                "person1",
                "person2",
                "person3",
                "person4",
                "person5"
              ],
              "Ward2": [
                "person6",
                "person7",
                "person8",
                "person9",
                "person10"
              ],
              "Ward3": [
                "person11",
                "person12",
                "person13",
                "person14",
                "person15"
              ]
            },
            "Tehsil2": {
              "Ward4": [
                "person16",
                "person17",
                "person18",
                "person19",
                "person20"
              ],
              "Ward5": [
                "person21",
                "person22",
                "person23",
                "person24",
                "person25"
              ],
              "Ward6": [
                "person26",
                "person27",
                "person28",
                "person29",
                "person30"
              ]
            }
          },
        },
        "Adilabad": {
          "tehsil": {
            "Tehsil1": {
              "Ward1": [
                "person1",
                "person2",
                "person3",
                "person4",
                "person5"
              ],
              "Ward2": [
                "person6",
                "person7",
                "person8",
                "person9",
                "person10"
              ],
              "Ward3": [
                "person11",
                "person12",
                "person13",
                "person14",
                "person15"
              ]
            },
            "Tehsil2": {
              "Ward4": [
                "person16",
                "person17",
                "person18",
                "person19",
                "person20"
              ],
              "Ward5": [
                "person21",
                "person22",
                "person23",
                "person24",
                "person25"
              ],
              "Ward6": [
                "person26",
                "person27",
                "person28",
                "person29",
                "person30"
              ]
            }
          },
        },
      }
    },
  };
}
