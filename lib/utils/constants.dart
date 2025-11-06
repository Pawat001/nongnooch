/// Constants สำหรับสวนนงนุช One-Stop Service App
class AppConstants {
  // App Info
  static const String appName = 'สวนนงนุช';
  static const String appNameEN = 'Suan Nong Nooch';
  static const String appVersion = '1.0.0';
  
  // API Endpoints (ตัวอย่าง - ปรับตามเซิร์ฟเวอร์จริง)
  static const String baseUrl = 'https://api.suannongnuch.com';
  static const String apiVersion = 'v1';
  
  // Storage Keys (สำหรับ SharedPreferences / Hive)
  static const String keyLanguage = 'app_language';
  static const String keyIsLoggedIn = 'is_logged_in';
  static const String keyUserId = 'user_id';
  static const String keyUserEmail = 'user_email';
  static const String keyUserToken = 'user_token';
  static const String keyCartItems = 'cart_items';
  static const String keyUserProfile = 'user_profile';
  
  // Language Codes
  static const String langThai = 'th';
  static const String langEnglish = 'en';
  
  // Navigation Routes
  static const String routeHome = '/';
  static const String routeLogin = '/login';
  static const String routeRegister = '/register';
  static const String routeProfile = '/profile';
  static const String routeTickets = '/tickets';
  static const String routeTicketDetail = '/ticket-detail';
  static const String routeRooms = '/rooms';
  static const String routeRoomDetail = '/room-detail';
  static const String routeRestaurants = '/restaurants';
  static const String routeRestaurantDetail = '/restaurant-detail';
  static const String routeCart = '/cart';
  static const String routeCheckout = '/checkout';
  static const String routePayment = '/payment';
  static const String routeBookingSuccess = '/booking-success';
  static const String routeMyBookings = '/my-bookings';
  static const String routeAttractions = '/attractions';
  
  // User Roles
  static const String roleGuest = 'guest';
  static const String roleUser = 'user';
  static const String roleVIP = 'vip';
  
  // KYC Status
  static const String kycPending = 'pending';
  static const String kycVerified = 'verified';
  static const String kycRejected = 'rejected';
  
  // Nationality Types
  static const String nationalityThai = 'thai';
  static const String nationalityForeigner = 'foreigner';
  
  // Booking Status
  static const String bookingPending = 'pending';
  static const String bookingConfirmed = 'confirmed';
  static const String bookingCancelled = 'cancelled';
  static const String bookingCompleted = 'completed';
  
  // Payment Methods
  static const String paymentPromptPay = 'promptpay';
  static const String paymentCreditCard = 'credit_card';
  static const String paymentCash = 'cash';
  
  // Payment Status
  static const String paymentPending = 'pending';
  static const String paymentSuccess = 'success';
  static const String paymentFailed = 'failed';
  
  // Cart Item Types
  static const String cartItemTicket = 'ticket';
  static const String cartItemRoom = 'room';
  static const String cartItemFood = 'food';
  static const String cartItemPackage = 'package';
  
  // Ticket Types
  static const String ticketAdult = 'adult';
  static const String ticketChild = 'child';
  static const String ticketSenior = 'senior';
  static const String ticketForeigner = 'foreigner';
  
  // Room Types
  static const String roomStandard = 'standard';
  static const String roomDeluxe = 'deluxe';
  static const String roomPoolVilla = 'pool_villa';
  static const String roomSuite = 'suite';
  
  // Restaurant Categories
  static const String restaurantThai = 'thai';
  static const String restaurantInternational = 'international';
  static const String restaurantBuffet = 'buffet';
  static const String restaurantCafe = 'cafe';
  
  // Promotion Types
  static const String promoBirthday = 'birthday';
  static const String promoHoliday = 'holiday';
  static const String promoEarlyBird = 'early_bird';
  static const String promoGroup = 'group';
  static const String promoThaiNational = 'thai_national';
  
  // Date Formats
  static const String dateFormatDisplay = 'dd MMM yyyy';
  static const String dateFormatAPI = 'yyyy-MM-dd';
  static const String dateTimeFormatDisplay = 'dd MMM yyyy HH:mm';
  static const String timeFormatDisplay = 'HH:mm';
  
  // Business Rules
  static const int maxTicketsPerBooking = 10;
  static const int maxRoomsPerBooking = 5;
  static const int maxFoodItemsPerOrder = 20;
  static const int minAdvanceBookingDays = 1;
  static const int maxAdvanceBookingDays = 90;
  
  // Birthday Promotion Rules
  static const int birthdayPromoMonthRange = 0; // 0 = เดือนเดียวกัน, 1 = +-1 เดือน
  static const double birthdayDiscountPercent = 20.0; // ส่วนลด 20%
  
  // Thai National Promotion
  static const double thaiNationalDiscount = 100.0; // ลด 100 บาท
  
  // Regular Prices (ตัวอย่าง)
  static const double ticketAdultPrice = 500.0;
  static const double ticketChildPrice = 300.0;
  static const double ticketSeniorPrice = 400.0;
  static const double ticketForeignerPrice = 600.0;
  
  // Holiday Price Multiplier
  static const double holidayPriceMultiplier = 1.2; // เพิ่ม 20% ในวันหยุด
  
  // Validation Rules
  static const int minPasswordLength = 6;
  static const int maxPasswordLength = 20;
  static const int minNameLength = 2;
  static const int maxNameLength = 100;
  
  // Image Placeholders (URL ตัวอย่าง - ใช้ local assets จริง)
  static const String placeholderImageUrl = 'https://via.placeholder.com/400x300?text=Suan+Nong+Nooch';
  
  // Error Messages Keys (สำหรับ localization)
  static const String errorNetworkFailed = 'error_network_failed';
  static const String errorInvalidCredentials = 'error_invalid_credentials';
  static const String errorSessionExpired = 'error_session_expired';
  static const String errorServerError = 'error_server_error';
  
  // Thai Public Holidays 2024-2025 (ตัวอย่าง)
  static List<DateTime> getPublicHolidays() {
    return [
      DateTime(2024, 1, 1),   // New Year
      DateTime(2024, 4, 13),  // Songkran
      DateTime(2024, 4, 14),
      DateTime(2024, 4, 15),
      DateTime(2024, 5, 1),   // Labor Day
      DateTime(2024, 12, 31), // New Year's Eve
      DateTime(2025, 1, 1),
      DateTime(2025, 4, 13),
      DateTime(2025, 4, 14),
      DateTime(2025, 4, 15),
    ];
  }
  
  // Check if date is holiday
  static bool isHoliday(DateTime date) {
    final holidays = getPublicHolidays();
    return holidays.any((holiday) =>
      holiday.year == date.year &&
      holiday.month == date.month &&
      holiday.day == date.day
    );
  }
  
  // Check if date is weekend
  static bool isWeekend(DateTime date) {
    return date.weekday == DateTime.saturday || date.weekday == DateTime.sunday;
  }
}
