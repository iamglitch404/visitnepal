import 'package:flutter/material.dart';

class MockData {
  MockData._();

  static Map<String, dynamic> currentUser = {
    'id': 'usr_101',
    'name': 'Aayush Pradhan',
    'email': 'aayush.traveler@visitnepal.com',
    'phone': '+977 9841234567',
    'nationality': 'Nepali',
    'passportNumber': 'NPL-9988221',
    'avatar': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=400&q=80',
    'bio': 'Passionate Himalayan trekker, photographer, and tea enthusiast.',
    'tripsCompleted': 14,
    'reviewsCount': 28,
    'badges': ['Himalayan Pioneer', 'Certified Trekker', 'Eco Explorer'],
  };

  static const List<Map<String, dynamic>> categories = [
    {'label': 'All', 'icon': Icons.tune_rounded},
    {'label': 'Trekking', 'icon': Icons.hiking_rounded},
    {'label': 'Cultural', 'icon': Icons.temple_buddhist_rounded},
    {'label': 'Adventure', 'icon': Icons.paragliding_rounded},
    {'label': 'Wildlife', 'icon': Icons.pets_rounded},
    {'label': 'Spiritual', 'icon': Icons.self_improvement_rounded},
    {'label': 'Lakes & Valleys', 'icon': Icons.water_rounded},
  ];

  static const List<Map<String, dynamic>> services = [
    {'title': 'Stays & Lodges', 'category': 'hotel', 'icon': Icons.hotel_rounded, 'color': Color(0xFF2563EB), 'count': '180+ Hotels'},
    {'title': 'Mountain Guides', 'category': 'guide', 'icon': Icons.person_pin_rounded, 'color': Color(0xFF16A34A), 'count': '420+ Certified'},
    {'title': 'Sherpa Butler', 'category': 'butler', 'icon': Icons.room_service_rounded, 'color': Color(0xFF9333EA), 'count': '95+ Available'},
    {'title': 'Trek Permits', 'category': 'permit', 'icon': Icons.verified_user_rounded, 'color': Color(0xFFEA580C), 'count': 'Online Approval'},
    {'title': 'Transport & 4x4', 'category': 'transport', 'icon': Icons.directions_bus_rounded, 'color': Color(0xFF0D9488), 'count': 'Flights & Jeeps'},
    {'title': 'Adventures', 'category': 'activity', 'icon': Icons.sports_motorsports_rounded, 'color': Color(0xFFDC2626), 'count': '65+ Experiences'},
  ];

  static const List<Map<String, String>> popularCities = [
    {'name': 'Pokhara', 'image': 'https://images.unsplash.com/photo-1544735716-392fe2489ffa?auto=format&fit=crop&w=400&q=80', 'subtitle': 'City of Lakes'},
    {'name': 'Kathmandu', 'image': 'https://images.unsplash.com/photo-1518002171953-a080ee817e1f?auto=format&fit=crop&w=400&q=80', 'subtitle': 'Valley of Temples'},
    {'name': 'Mustang', 'image': 'https://images.unsplash.com/photo-1544735716-392fe2489ffa?auto=format&fit=crop&w=400&q=80', 'subtitle': 'Forbidden Kingdom'},
    {'name': 'Chitwan', 'image': 'https://images.unsplash.com/photo-1534177616072-ef7dc120449d?auto=format&fit=crop&w=400&q=80', 'subtitle': 'Deep Jungle'},
    {'name': 'Solukhumbu', 'image': 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=400&q=80', 'subtitle': 'Everest Gateway'},
    {'name': 'Lumbini', 'image': 'https://images.unsplash.com/photo-1544735716-392fe2489ffa?auto=format&fit=crop&w=400&q=80', 'subtitle': 'Birthplace of Buddha'},
  ];

  static final List<Map<String, dynamic>> destinations = [
    {
      'id': 'dest_ebc',
      'title': 'Everest Base Camp Trek',
      'location': 'Solukhumbu, Sagarmatha Region',
      'duration': '14 Days',
      'difficulty': 'Challenging',
      'altitude': '5,364 m',
      'bestSeason': 'March - May, Oct - Dec',
      'price': 1350,
      'rating': 4.95,
      'reviewsCount': 428,
      'imageUrl': 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=800&q=80',
      'category': 'Trekking',
      'description': 'The legendary journey to the foot of Mt. Everest (8,848m). Trek through Sherpa villages, ancient gompas, suspension bridges draped in prayer flags, and iconic acclimatization stops at Namche Bazaar and Dingboche.',
      'highlights': [
        'Dramatic landing at world-famous Lukla Airport',
        'Acclimatization and café culture in Namche Bazaar',
        'Spiritual blessing at Tengboche Monastery',
        'Sunrise view of Mount Everest from Kala Patthar (5,545m)',
        'Touching the historic Everest Base Camp milestone'
      ],
      'itinerary': [
        {'day': 1, 'title': 'Scenic Flight to Lukla & Trek to Phakding', 'altitude': '2,610 m', 'desc': 'Fly from Kathmandu/Ramechhap to Lukla (2,840m) and begin moderate trek along Dudh Koshi river.'},
        {'day': 2, 'title': 'Phakding to Namche Bazaar', 'altitude': '3,440 m', 'desc': 'Cross iconic suspension bridges and ascend to the vibrant capital of the Khumbu region.'},
        {'day': 3, 'title': 'Acclimatization Day in Namche', 'altitude': '3,880 m', 'desc': 'Hike to Everest View Hotel for the first panoramic glimpse of Everest, Lhotse, and Ama Dablam.'},
        {'day': 4, 'title': 'Namche to Tengboche Monastery', 'altitude': '3,860 m', 'desc': 'Trail descends into Rhododendron forests before climbing to Tengboche, the spiritual epicenter of Khumbu.'},
        {'day': 5, 'title': 'Tengboche to Dingboche', 'altitude': '4,410 m', 'desc': 'Trek past mani stones and Pangboche village into the alpine wilderness.'},
        {'day': 6, 'title': 'Dingboche to Lobuche', 'altitude': '4,940 m', 'desc': 'Ascend the memorial ridge at Thokla Pass remembering legendary climbers.'},
        {'day': 7, 'title': 'Gorak Shep & Everest Base Camp', 'altitude': '5,364 m', 'desc': 'Trek on Khumbu Glacier moraines to reach EBC, celebrating under the Khumbu Icefall.'},
        {'day': 8, 'title': 'Kala Patthar Summit & Descent to Pheriche', 'altitude': '5,545 m', 'desc': 'Early morning hike for the ultimate golden sunrise over Everest, then descend to Pheriche.'},
      ]
    },
    {
      'id': 'dest_act',
      'title': 'Annapurna Circuit & Thorong La',
      'location': 'Manang & Mustang Districts',
      'duration': '12 Days',
      'difficulty': 'Difficult',
      'altitude': '5,416 m',
      'bestSeason': 'Sept - Nov, March - May',
      'price': 980,
      'rating': 4.92,
      'reviewsCount': 356,
      'imageUrl': 'https://images.unsplash.com/photo-1544735716-392fe2489ffa?auto=format&fit=crop&w=800&q=80',
      'category': 'Trekking',
      'description': 'Circling the Annapurna Massif through lush subtropical valleys, high Tibetan plateaus, and over the thrilling Thorong La Pass into sacred Muktinath.',
      'highlights': [
        'Crossing the iconic Thorong La Pass (5,416m)',
        'Explore medieval Buddhist monasteries in Manang',
        'Holy temple of Muktinath with eternal flame',
        'Deepest gorge in the world along the Kali Gandaki River'
      ],
      'itinerary': [
        {'day': 1, 'title': 'Kathmandu to Besisahar & Dharapani', 'altitude': '1,860 m', 'desc': 'Scenic jeep drive through cascading waterfalls and terrace farms.'},
        {'day': 2, 'title': 'Dharapani to Chame', 'altitude': '2,670 m', 'desc': 'Forest trail with dramatic cliffs and views of Annapurna II.'},
        {'day': 3, 'title': 'Chame to Pisang', 'altitude': '3,200 m', 'desc': 'Walk past the dramatic Paungda Danda curved rock face.'},
        {'day': 4, 'title': 'Pisang to Manang', 'altitude': '3,540 m', 'desc': 'High altitude route via Upper Pisang offering unbeatable mountain vistas.'},
        {'day': 5, 'title': 'Thorong Phedi to Muktinath via Pass', 'altitude': '5,416 m', 'desc': 'Challenging pre-dawn pass crossing followed by long descent to Muktinath.'},
      ]
    },
    {
      'id': 'dest_abc',
      'title': 'Annapurna Base Camp Sanctuary',
      'location': 'Kaski District, Pokhara',
      'duration': '8 Days',
      'difficulty': 'Moderate',
      'altitude': '4,130 m',
      'bestSeason': 'Year Round',
      'price': 720,
      'rating': 4.88,
      'reviewsCount': 289,
      'imageUrl': 'https://images.unsplash.com/photo-1570789210967-2cac24afeb00?auto=format&fit=crop&w=800&q=80',
      'category': 'Trekking',
      'description': 'A 360-degree amphitheater of snow-capped giants including Annapurna I (8,091m), Machapuchare (Fishtail), and Hiunchuli.',
      'highlights': [
        'Uninterrupted 360-degree mountain amphitheater',
        'Sunrise view of Annapurna South from Poon Hill',
        'Natural geothermal hot springs at Jhinu Danda',
        'Deep rhododendron and bamboo cloud forests'
      ],
      'itinerary': [
        {'day': 1, 'title': 'Pokhara to Nayapul & Tikhedhunga', 'altitude': '1,540 m', 'desc': 'Drive to Nayapul and gentle warm-up walk along Modi Khola.'},
        {'day': 2, 'title': 'Tikhedhunga to Ghorepani', 'altitude': '2,860 m', 'desc': 'Climb the Ulleri stone stairs through enchanting rhododendron woods.'},
        {'day': 3, 'title': 'Poon Hill Sunrise & Tadapani', 'altitude': '3,210 m', 'desc': 'Golden dawn panoramic views of Dhaulagiri and Annapurna ranges.'},
        {'day': 4, 'title': 'Deurali to Annapurna Base Camp', 'altitude': '4,130 m', 'desc': 'Passing Machapuchare Base Camp to reach the heart of the sanctuary.'},
      ]
    },
    {
      'id': 'dest_mustang',
      'title': 'Upper Mustang Forbidden Kingdom',
      'location': 'Lo Manthang, Mustang',
      'duration': '10 Days',
      'difficulty': 'Moderate',
      'altitude': '3,840 m',
      'bestSeason': 'May - November',
      'price': 1650,
      'rating': 4.97,
      'reviewsCount': 142,
      'imageUrl': 'https://images.unsplash.com/photo-1544735716-392fe2489ffa?auto=format&fit=crop&w=800&q=80',
      'category': 'Cultural',
      'description': 'Step into an ancient Tibetan Buddhist realm preserved within rainshadow canyons. Walled cities, sky caves, and red ochre monasteries.',
      'highlights': [
        'Walled capital city of Lo Manthang & King palace',
        'Centuries-old cliffside sky caves and ancient murals',
        'Vibrant Tiji Festival masked dances',
        'Otherworldly wind-eroded red canyon landscapes'
      ],
      'itinerary': [
        {'day': 1, 'title': 'Flight to Jomsom & Trek to Kagbeni', 'altitude': '2,800 m', 'desc': 'Mountain flight along Kali Gandaki gorge into the gateway of Mustang.'},
        {'day': 2, 'title': 'Kagbeni to Chele', 'altitude': '3,050 m', 'desc': 'Entering the restricted zone along steep sandstone formations.'},
        {'day': 3, 'title': 'Chele to Syangboche & Ghami', 'altitude': '3,520 m', 'desc': 'Passing Tibetan villages and the longest Mani wall in Nepal.'},
        {'day': 4, 'title': 'Arrival in Lo Manthang', 'altitude': '3,840 m', 'desc': 'Reaching the historic walled capital of the Lo kingdom.'},
      ]
    },
    {
      'id': 'dest_langtang',
      'title': 'Langtang Valley & Kyanjin Gompa',
      'location': 'Rasuwa District',
      'duration': '7 Days',
      'difficulty': 'Moderate',
      'altitude': '3,870 m',
      'bestSeason': 'Sept - Nov, March - May',
      'price': 550,
      'rating': 4.86,
      'reviewsCount': 195,
      'imageUrl': 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=800&q=80',
      'category': 'Trekking',
      'description': 'The valley of glaciers closest to Kathmandu. Renowned for Tamang heritage, yak cheese factories, and soaring peaks of Langtang Lirung.',
      'highlights': [
        'Visit Swiss-founded artisanal Yak Cheese Factory',
        'Summit Kyanjin Ri (4,773m) for glacier views',
        'Immerse in indigenous Tamang and Tibetan cultures',
        'Langtang National Park red panda sanctuary'
      ],
      'itinerary': [
        {'day': 1, 'title': 'Drive Kathmandu to Syabrubesi', 'altitude': '1,460 m', 'desc': 'Winding drive through lush hills and Trishuli river valley.'},
        {'day': 2, 'title': 'Syabrubesi to Lama Hotel', 'altitude': '2,470 m', 'desc': 'Gentle ascent alongside the roaring Langtang Khola.'},
        {'day': 3, 'title': 'Lama Hotel to Langtang Village', 'altitude': '3,430 m', 'desc': 'Open valley views as pine forests give way to alpine pastures.'},
        {'day': 4, 'title': 'Langtang Village to Kyanjin Gompa', 'altitude': '3,870 m', 'desc': 'Reach the monastery settlement nestled beneath glaciers.'},
      ]
    },
    {
      'id': 'dest_chitwan',
      'title': 'Chitwan Jungle Safari & Wildlife',
      'location': 'Chitwan National Park',
      'duration': '3 Days',
      'difficulty': 'Easy',
      'altitude': '415 m',
      'bestSeason': 'October - March',
      'price': 320,
      'rating': 4.79,
      'reviewsCount': 310,
      'imageUrl': 'https://images.unsplash.com/photo-1534177616072-ef7dc120449d?auto=format&fit=crop&w=800&q=80',
      'category': 'Wildlife',
      'description': 'UNESCO World Heritage wildlife sanctuary home to the endangered One-Horned Rhinoceros, Royal Bengal Tiger, and gharial crocodiles.',
      'highlights': [
        'Jeep safari deep inside tiger habitat',
        'Canoe ride on Rapti River spotting marsh crocodiles',
        'Tharu cultural stick dance performance',
        'Birdwatching paradise with 500+ resident species'
      ],
      'itinerary': [
        {'day': 1, 'title': 'Arrival & Tharu Village Walk', 'altitude': '415 m', 'desc': 'Welcome drink, village exploration, and sunset over Rapti river.'},
        {'day': 2, 'title': 'Full Day Jungle Adventure', 'altitude': '415 m', 'desc': 'Canoe safari, elephant breeding center visit, and 4x4 open jeep safari.'},
        {'day': 3, 'title': 'Birdwatching & Departure', 'altitude': '415 m', 'desc': 'Early morning birding tour before return drive to Kathmandu/Pokhara.'},
      ]
    }
  ];

  static final List<Map<String, dynamic>> hotels = [
    {
      'id': 'htl_dwarikas',
      'name': "The Dwarika's Hotel",
      'location': 'Battisputali, Kathmandu',
      'price': '\$260 / night',
      'priceNum': 260,
      'rating': 4.96,
      'imageUrl': 'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=800&q=80',
      'highlights': ['UNESCO Heritage Design', 'Organic Farm Cuisine', 'Ayurvedic Spa', 'Heritage Pool'],
      'description': 'A living museum of Newari architecture incorporating 13th-century hand-carved terracotta and wood artifacts.',
    },
    {
      'id': 'htl_barpeepal',
      'name': 'Bar Peepal Resort',
      'location': 'Sarangkot Road, Pokhara',
      'price': '\$145 / night',
      'priceNum': 145,
      'rating': 4.90,
      'imageUrl': 'https://images.unsplash.com/photo-1582719508461-905c673771fd?auto=format&fit=crop&w=800&q=80',
      'highlights': ['Phewa Lake Panorama', 'Infinity Pool', 'Annapurna Sunrise Views', 'Organic Garden'],
      'description': 'Perched atop Sarangkot hill overlooking Phewa Lake and the snow peaks of Fishtail and Annapurna.',
    },
    {
      'id': 'htl_yeti_namche',
      'name': 'Yeti Mountain Home',
      'location': 'Namche Bazaar, Everest',
      'price': '\$195 / night',
      'priceNum': 195,
      'rating': 4.92,
      'imageUrl': 'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?auto=format&fit=crop&w=800&q=80',
      'highlights': ['Heated Electric Blankets', 'Oxygen Concentrators', 'Panoramic Deck', 'Sherpa Hospitality'],
      'description': 'Luxury mountain comfort at 3,440m altitude with breathtaking views of Kongde Ri and Thamserku.',
    },
    {
      'id': 'htl_barahi',
      'name': 'Barahi Jungle Lodge',
      'location': 'Meghauli, Chitwan',
      'price': '\$220 / night',
      'priceNum': 220,
      'rating': 4.88,
      'imageUrl': 'https://images.unsplash.com/photo-1540555700478-4be289fbecef?auto=format&fit=crop&w=800&q=80',
      'highlights': ['Private River Cottages', 'Naturalist Guides', 'Infinity Pool on River', 'Bush Dinners'],
      'description': 'Eco-luxury safari lodge right along the banks of Rapti river bordering Chitwan National Park.',
    },
  ];

  static final List<Map<String, dynamic>> guides = [
    {
      'id': 'gd_pasang',
      'name': 'Pasang Nuru Sherpa',
      'role': 'IFMGA Mountain Guide',
      'summits': 'Everest x 7, K2 x 2, Manaslu x 5',
      'languages': ['English', 'Sherpa', 'Nepali', 'French'],
      'experience': '16 Years',
      'rating': 4.98,
      'reviews': 184,
      'rate': '\$65 / day',
      'rateNum': 65,
      'avatar': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=400&q=80',
      'bio': 'Certified international mountain guide born in Khumjung. Expert in high altitude safety, crevasse rescue, and cultural storytelling.',
    },
    {
      'id': 'gd_anita',
      'name': 'Anita Gurung',
      'role': 'Trekking & Wilderness Guide',
      'summits': 'Thorong Peak, Mera Peak, Island Peak',
      'languages': ['English', 'Nepali', 'German'],
      'experience': '9 Years',
      'rating': 4.95,
      'reviews': 126,
      'rate': '\$50 / day',
      'rateNum': 50,
      'avatar': 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=400&q=80',
      'bio': 'Pioneering female wilderness specialist leading eco-treks and female traveler expeditions across Annapurna and Langtang.',
    },
    {
      'id': 'gd_mingma',
      'name': 'Mingma Dorchi Sherpa',
      'role': 'Speed Alpinist & Expedition Leader',
      'summits': 'Guinness Record Holder (Everest - Lhotse traverse)',
      'languages': ['English', 'Tibetan', 'Hindi', 'Nepali'],
      'experience': '14 Years',
      'rating': 4.99,
      'reviews': 210,
      'rate': '\$80 / day',
      'rateNum': 80,
      'avatar': 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=400&q=80',
      'bio': 'Renowned Himalayan mountaineer with deep expertise in personalized private expeditions and extreme wilderness navigation.',
    },
  ];

  static final List<Map<String, dynamic>> butlers = [
    {
      'id': 'btl_pemba',
      'name': 'Pemba Tenzing Sherpa',
      'role': 'High-Altitude Personal Butler',
      'rating': 4.96,
      'trips': '80+ Journeys',
      'rate': '\$45 / day',
      'avatar': 'https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?auto=format&fit=crop&w=400&q=80',
      'skills': ['Luggage Coordination', 'Teahouse VIP Bookings', 'Tea & Coffee Service', 'First Aid Responder'],
    },
    {
      'id': 'btl_karma',
      'name': 'Karma Dorje Lama',
      'role': 'Expedition Concierge & Medic',
      'rating': 4.93,
      'trips': '64+ Journeys',
      'rate': '\$40 / day',
      'avatar': 'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?auto=format&fit=crop&w=400&q=80',
      'skills': ['Oxygen Management', 'Photography Assistance', 'Permit Expediting', 'Camp Setup'],
    },
  ];

  static final List<Map<String, dynamic>> activities = [
    {
      'id': 'act_paraglide',
      'title': 'Tandem Paragliding over Phewa Lake',
      'location': 'Sarangkot, Pokhara',
      'duration': '30 Mins Flight',
      'price': '\$85',
      'rating': 4.95,
      'imageUrl': 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=600&q=80',
      'operator': 'Sunrise Paragliding Pokhara',
    },
    {
      'id': 'act_heli',
      'title': 'Everest Scenic Helicopter Flight with Breakfast',
      'location': 'Tribhuvan Airport -> Kala Patthar',
      'duration': '4 Hours',
      'price': '\$950',
      'rating': 4.99,
      'imageUrl': 'https://images.unsplash.com/photo-1544735716-392fe2489ffa?auto=format&fit=crop&w=600&q=80',
      'operator': 'Simrik Air Helicopters',
    },
    {
      'id': 'act_bungee',
      'title': '160m Bungee Jump over Bhote Koshi',
      'location': 'The Last Resort, Sindhupalchok',
      'duration': 'Full Day',
      'price': '\$110',
      'rating': 4.88,
      'imageUrl': 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=600&q=80',
      'operator': 'The Last Resort Nepal',
    },
    {
      'id': 'act_rafting',
      'title': 'Trishuli River White Water Rafting (Grade III+)',
      'location': 'Charaudi, Dhading',
      'duration': '1 Day',
      'price': '\$60',
      'rating': 4.84,
      'imageUrl': 'https://images.unsplash.com/photo-1544735716-392fe2489ffa?auto=format&fit=crop&w=600&q=80',
      'operator': 'Paddle Nepal River Expeditions',
    },
  ];

  static final List<Map<String, dynamic>> transports = [
    {
      'id': 'trn_scorpio',
      'title': 'Mahindra Scorpio 4WD Mountain Rental',
      'type': 'Private Offroad Vehicle',
      'seats': '6 Passengers',
      'price': '\$120 / day',
      'driver': 'Includes Experienced Mountain Driver',
      'rating': 4.92,
    },
    {
      'id': 'trn_flight',
      'title': 'Kathmandu to Pokhara Domestic Flight',
      'type': 'Buddha Air ATR-72',
      'seats': 'Window Seat Priority',
      'price': '\$115 one-way',
      'driver': '25 Mins Flight time',
      'rating': 4.85,
    },
    {
      'id': 'trn_vipbus',
      'title': 'Greenline Super Deluxe VIP Tourist Coach',
      'type': 'AC Luxury Sofa Bus',
      'seats': 'Reclining 2x1 Sofa Seats',
      'price': '\$30 / ticket',
      'driver': 'Includes Lunch Buffet & WiFi',
      'rating': 4.75,
    },
  ];

  static final List<Map<String, dynamic>> permits = [
    {
      'id': 'pmt_tims',
      'code': 'TIMS-2026-9812',
      'title': 'TIMS Card (Trekkers Information Management System)',
      'authority': 'Nepal Tourism Board (NTB) & TAAN',
      'cost': 'NPR 2,000 (~ \$15 USD)',
      'validity': 'Valid across all non-restricted trekking routes',
      'status': 'Approved',
      'approvalDate': '24 Oct 2026',
    },
    {
      'id': 'pmt_snp',
      'code': 'SNP-2026-4401',
      'title': 'Sagarmatha National Park Entry Permit',
      'authority': 'Department of National Parks & Wildlife',
      'cost': 'NPR 3,000 (~ \$23 USD)',
      'validity': 'Khumbu / Everest Region',
      'status': 'Approved',
      'approvalDate': '25 Oct 2026',
    },
    {
      'id': 'pmt_acap',
      'code': 'ACAP-2026-1192',
      'title': 'Annapurna Conservation Area Project (ACAP)',
      'authority': 'National Trust for Nature Conservation (NTNC)',
      'cost': 'NPR 3,000 (~ \$23 USD)',
      'validity': 'Annapurna, Manang & Mustang',
      'status': 'Under Review',
      'approvalDate': 'Pending Officer Sign-off',
    },
    {
      'id': 'pmt_mustang',
      'code': 'RAP-2026-0043',
      'title': 'Upper Mustang Restricted Area Special Permit',
      'authority': 'Department of Immigration, Kathmandu',
      'cost': '\$500 USD (First 10 Days)',
      'validity': 'Kagbeni to Lo Manthang',
      'status': 'Draft',
      'approvalDate': 'Requires Licensed Guide Assignment',
    },
  ];

  static final List<Map<String, dynamic>> userBookings = [
    {
      'id': 'BKG-99214',
      'title': 'Everest Base Camp Trek (14 Days)',
      'provider': 'Himalayan Sherpa Expeditions',
      'category': 'Trek',
      'date': 'Nov 12 - Nov 25, 2026',
      'status': 'Confirmed',
      'amount': '\$1,350',
      'qrCode': 'EBC-99214-CONFIRMED-AAYUSH',
      'color': Color(0xFF2563EB),
      'icon': Icons.hiking_rounded,
      'meetingPoint': 'Lukla Airport Terminal, 08:30 AM',
      'assignedGuide': 'Pasang Nuru Sherpa',
      'contactPhone': '+977 9811223344',
    },
    {
      'id': 'BKG-88102',
      'title': "The Dwarika's Hotel - Heritage Suite",
      'provider': "The Dwarika's Hotel Kathmandu",
      'category': 'Stay',
      'date': 'Nov 10 - Nov 12, 2026 (2 Nights)',
      'status': 'Confirmed',
      'amount': '\$520',
      'qrCode': 'DWARIKAS-SUITE-88102-CHECKIN',
      'color': Color(0xFF16A34A),
      'icon': Icons.hotel_rounded,
      'meetingPoint': 'Battisputali Front Desk, 02:00 PM Check-in',
      'assignedGuide': 'Front Desk Concierge',
      'contactPhone': '+977 1 4479488',
    },
    {
      'id': 'BKG-77401',
      'title': 'Tandem Paragliding Flight',
      'provider': 'Sunrise Paragliding Pokhara',
      'category': 'Adventure',
      'date': 'Completed on Oct 18, 2026',
      'status': 'Completed',
      'amount': '\$85',
      'qrCode': 'PARA-POK-77401-PAID',
      'color': Color(0xFF64748B),
      'icon': Icons.paragliding_rounded,
      'meetingPoint': 'Lakeside Center, Pokhara',
      'assignedGuide': 'Ramesh Thapa',
      'contactPhone': '+977 61 465220',
    },
    {
      'id': 'BKG-66319',
      'title': 'Private Scorpio 4x4 Transfer Pokhara -> Kathmandu',
      'provider': 'Nepal Mountain Wheels',
      'category': 'Transport',
      'date': 'Cancelled by User',
      'status': 'Cancelled',
      'amount': '\$120 (Refunded)',
      'qrCode': 'VOID-REFUNDED',
      'color': Color(0xFFEF4444),
      'icon': Icons.directions_car_rounded,
      'meetingPoint': 'Hotel Pickup',
      'assignedGuide': 'Bikash KC',
      'contactPhone': '+977 9801234567',
    },
  ];

  static final List<Map<String, dynamic>> communityPosts = [
    {
      'id': 'post_1',
      'authorName': 'Tenzing Norbu',
      'authorAvatar': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=400&q=80',
      'authorLocation': 'Dingboche, 4,410m',
      'timeAgo': '2 hours ago',
      'verified': true,
      'content': 'Sunrise over Ama Dablam this morning was pure spiritual magic. Clear skies, freezing crisp air (-8°C), and fresh yak butter tea at the lodge. The Himalayas are calling! 🏔️☕',
      'mediaUrl': 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=900&q=80',
      'likesCount': 284,
      'userReaction': 'love',
      'commentsCount': 34,
      'comments': [
        {'id': 'c1', 'author': 'Sarah Jenkins', 'avatar': 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=400&q=80', 'text': 'Incredible shot! How are the trails up to Lobuche right now?', 'timeAgo': '1 hour ago', 'likes': 6},
        {'id': 'c2', 'author': 'Tenzing Norbu', 'avatar': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=400&q=80', 'text': '@Sarah dry and solid! Microspikes are helpful near the moraine.', 'timeAgo': '45m ago', 'likes': 4},
      ]
    },
    {
      'id': 'post_2',
      'authorName': 'Elena Rostova',
      'authorAvatar': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=400&q=80',
      'authorLocation': 'Phewa Lake, Pokhara',
      'timeAgo': '5 hours ago',
      'verified': false,
      'content': 'Gliding silently across Phewa Lake on a traditional wooden doonga boat, looking right at the sacred Fishtail peak reflection. Nepal has captured my heart completely! 🇳🇵✨',
      'mediaUrl': 'https://images.unsplash.com/photo-1544735716-392fe2489ffa?auto=format&fit=crop&w=900&q=80',
      'likesCount': 192,
      'userReaction': 'like',
      'commentsCount': 19,
      'comments': [
        {'id': 'c3', 'author': 'Kritish Shrestha', 'avatar': 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=400&q=80', 'text': 'Make sure you try the fresh Thakali thali in Lakeside for dinner!', 'timeAgo': '3 hours ago', 'likes': 8},
      ]
    },
    {
      'id': 'post_3',
      'authorName': 'Marcus Berg',
      'authorAvatar': 'https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?auto=format&fit=crop&w=400&q=80',
      'authorLocation': 'Lo Manthang, Mustang',
      'timeAgo': 'Yesterday',
      'verified': true,
      'content': 'We finally crossed the high pass into Upper Mustang. The red sandstone formations look like they belong on Mars. Ancient Tibetan wall paintings inside the Jampa Gompa left us speechless.',
      'mediaUrl': 'https://images.unsplash.com/photo-1570789210967-2cac24afeb00?auto=format&fit=crop&w=900&q=80',
      'likesCount': 415,
      'userReaction': 'wow',
      'commentsCount': 52,
      'comments': [
        {'id': 'c4', 'author': 'Dawa Sherpa', 'avatar': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=400&q=80', 'text': 'Welcome to the Kingdom of Lo! Don’t forget to visit Chhoser caves tomorrow.', 'timeAgo': '18 hours ago', 'likes': 12},
      ]
    }
  ];

  static final List<Map<String, dynamic>> conversations = [
    {
      'id': 'chat_1',
      'name': 'Pasang Nuru Sherpa (Guide)',
      'avatar': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=400&q=80',
      'status': 'Online',
      'verified': true,
      'lastMessage': 'I have prepared our crampons and oxygen kits for tomorrow!',
      'lastTime': '11:15 AM',
      'unread': 2,
      'messages': [
        {'id': 'm1', 'sender': 'Pasang', 'text': 'Tashi Delek Aayush! Looking forward to starting the trek with you on the 12th.', 'time': '10:45 AM', 'isMe': false},
        {'id': 'm2', 'sender': 'Aayush', 'text': 'Namaste Pasang dai! Yes, my flight lands in Lukla at 8:30 AM.', 'time': '10:50 AM', 'isMe': true},
        {'id': 'm3', 'sender': 'Pasang', 'text': 'I will be at the runway gate waiting for you with a sign.', 'time': '11:02 AM', 'isMe': false},
        {'id': 'm4', 'sender': 'Pasang', 'text': 'I have prepared our crampons and oxygen kits for tomorrow!', 'time': '11:15 AM', 'isMe': false},
      ]
    },
    {
      'id': 'chat_2',
      'name': "The Dwarika's Hotel Concierge",
      'avatar': 'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=400&q=80',
      'status': 'Away',
      'verified': true,
      'lastMessage': 'Your airport pickup Mercedes has been scheduled for 1:30 PM.',
      'lastTime': 'Yesterday',
      'unread': 0,
      'messages': [
        {'id': 'm5', 'sender': 'Hotel', 'text': 'Greetings Mr. Pradhan! We are honored to welcome you.', 'time': 'Yesterday', 'isMe': false},
        {'id': 'm6', 'sender': 'Aayush', 'text': 'Could you please confirm the airport pickup driver details?', 'time': 'Yesterday', 'isMe': true},
        {'id': 'm7', 'sender': 'Hotel', 'text': 'Your airport pickup Mercedes has been scheduled for 1:30 PM.', 'time': 'Yesterday', 'isMe': false},
      ]
    },
    {
      'id': 'chat_3',
      'name': 'Pemba Tenzing (Sherpa Butler)',
      'avatar': 'https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?auto=format&fit=crop&w=400&q=80',
      'status': 'Online',
      'verified': true,
      'lastMessage': 'Teahouse rooms reserved at Namche and Tengboche.',
      'lastTime': '2 days ago',
      'unread': 0,
      'messages': [
        {'id': 'm8', 'sender': 'Pemba', 'text': 'Namaste! Teahouse rooms reserved at Namche and Tengboche with corner mountain views.', 'time': '2 days ago', 'isMe': false},
      ]
    }
  ];

  static final List<Map<String, dynamic>> notifications = [
    {
      'id': 'nt_1',
      'title': 'Permit Approved! 🎉',
      'body': 'Your Sagarmatha National Park entry permit (SNP-2026-4401) has been officially approved.',
      'time': '10 mins ago',
      'icon': Icons.verified_user_rounded,
      'color': Color(0xFF16A34A),
      'read': false,
    },
    {
      'id': 'nt_2',
      'title': 'Booking Confirmed 🎫',
      'body': 'Your reservation for Everest Base Camp Trek (Nov 12 - 25) with Himalayan Sherpa Expeditions is confirmed.',
      'time': '2 hours ago',
      'icon': Icons.confirmation_number_rounded,
      'color': Color(0xFF2563EB),
      'read': false,
    },
    {
      'id': 'nt_3',
      'title': 'Himalayan Weather Advisory ⛅',
      'body': 'Sunny mornings with afternoon fog expected across Khumbu Valley. High winds above 5,000m on Saturday.',
      'time': 'Yesterday',
      'icon': Icons.wb_sunny_rounded,
      'color': Color(0xFFEA580C),
      'read': true,
    },
    {
      'id': 'nt_4',
      'title': 'New Story Liked ❤️',
      'body': 'Tenzing Norbu and 42 others liked your photo at Phewa Lake.',
      'time': '2 days ago',
      'icon': Icons.favorite_rounded,
      'color': Color(0xFFEF4444),
      'read': true,
    },
  ];

  static final List<Map<String, dynamic>> scheduleDays = [
    {
      'day': 1,
      'date': 'Nov 12, 2026',
      'title': 'Lukla Flight & Phakding Hike',
      'completed': true,
      'stay': 'Yeti Mountain Lodge, Phakding',
      'alarm': '05:30 AM (Lukla Departure)',
      'audioNote': 'Remember to pack extra batteries in warm jacket pockets.',
      'events': [
        {'time': '06:30 AM', 'title': 'Lukla Flight from TIA', 'desc': 'Terminal 2, Flight Tara Air 102'},
        {'time': '08:45 AM', 'title': 'Meet Guide Pasang Nuru', 'desc': 'Lukla runway checkpoint'},
        {'time': '09:30 AM', 'title': 'Begin trek to Phakding', 'desc': '3.5 hours gentle descent along Dudh Koshi'},
        {'time': '01:30 PM', 'title': 'Check-in & Hot Garlic Soup', 'desc': 'Acclimatization meal at tea house'},
      ]
    },
    {
      'day': 2,
      'date': 'Nov 13, 2026',
      'title': 'Climb to Namche Bazaar',
      'completed': false,
      'stay': 'Panorama Lodge, Namche (3,440m)',
      'alarm': '06:00 AM',
      'audioNote': 'Cross Hillary Suspension Bridge slowly and pace breathing.',
      'events': [
        {'time': '07:30 AM', 'title': 'Trek departure from Phakding', 'desc': 'Enter Sagarmatha National Park at Monjo'},
        {'time': '11:00 AM', 'title': 'Hillary Suspension Bridge', 'desc': 'Prayer flags crossing & gorge view'},
        {'time': '02:00 PM', 'title': 'Arrive in Namche Bazaar', 'desc': 'Sherpa capital exploration & bakery visit'},
      ]
    },
    {
      'day': 3,
      'date': 'Nov 14, 2026',
      'title': 'Namche Acclimatization Hike',
      'completed': false,
      'stay': 'Panorama Lodge, Namche',
      'alarm': '07:00 AM',
      'audioNote': 'First panoramic photo spot of Mt. Everest.',
      'events': [
        {'time': '08:30 AM', 'title': 'Hike to Everest View Hotel (3,880m)', 'desc': 'Panoramic terrace breakfast'},
        {'time': '01:00 PM', 'title': 'Visit Sherpa Culture Museum', 'desc': 'Heritage exhibits and mountaineering history'},
      ]
    },
  ];

  static Map<String, dynamic> businessMetrics = {
    'companyName': 'Himalayan Sherpa Expeditions Pvt. Ltd.',
    'registration': 'REG-NPL-88910',
    'rating': 4.94,
    'totalRevenue': '\$48,920',
    'totalBookings': 138,
    'activeStaff': 16,
    'verifiedStatus': 'Verified Government Partner',
    'recentReservations': [
      {'id': 'RSV-401', 'traveler': 'Aayush Pradhan', 'package': 'Everest Base Camp (14D)', 'pax': 2, 'date': 'Nov 12, 2026', 'status': 'Confirmed', 'amount': '\$2,700'},
      {'id': 'RSV-402', 'traveler': 'Sarah Jenkins', 'package': 'Annapurna Circuit (12D)', 'pax': 1, 'date': 'Nov 18, 2026', 'status': 'Pending Payment', 'amount': '\$980'},
      {'id': 'RSV-403', 'traveler': 'Hiroshi Tanaka', 'package': 'Upper Mustang Forbidden Kingdom', 'pax': 4, 'date': 'Dec 02, 2026', 'status': 'Confirmed', 'amount': '\$6,600'},
    ],
    'staffList': [
      {'name': 'Pasang Nuru Sherpa', 'role': 'Lead Expedition Guide', 'status': 'Assigned on Nov 12'},
      {'name': 'Anita Gurung', 'role': 'Wilderness Trek Leader', 'status': 'Available'},
      {'name': 'Pemba Tenzing', 'role': 'Sherpa Butler', 'status': 'Assigned on Nov 12'},
      {'name': 'Dawa Lama', 'role': 'Logistics & Porters Coordinator', 'status': 'Active'},
    ]
  };

  static Map<String, dynamic> adminMetrics = {
    'totalTravelers': 18450,
    'registeredAgencies': 342,
    'activeGuides': 820,
    'totalBookingsVolume': '\$2,450,000',
    'pendingPermits': 24,
    'pendingBusinessVerifications': 7,
    'verificationQueue': [
      {'business': 'Everest High Altitude Helis', 'type': 'Aviation & Rescue', 'applied': '2 days ago', 'status': 'Pending Inspection'},
      {'business': 'Annapurna Eco Lodge Marpha', 'type': 'Hospitality / Stay', 'applied': 'Yesterday', 'status': 'Document Review'},
      {'business': 'Trishuli Raft Adventures', 'type': 'Adventure Sport', 'applied': 'Today', 'status': 'Pending Safety Audit'},
    ],
    'permitOfficerQueue': [
      {'id': 'PMT-REQ-101', 'applicant': 'Aayush Pradhan', 'permit': 'Sagarmatha National Park', 'region': 'Khumbu', 'status': 'Approved'},
      {'id': 'PMT-REQ-102', 'applicant': 'Elena Rostova', 'permit': 'Annapurna Conservation Area (ACAP)', 'region': 'Kaski/Manang', 'status': 'Under Review'},
      {'id': 'PMT-REQ-103', 'applicant': 'Marcus Berg', 'permit': 'Upper Mustang Restricted Permit', 'region': 'Lo Manthang', 'status': 'Officer Signature Needed'},
    ]
  };
}
