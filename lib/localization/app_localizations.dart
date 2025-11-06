import 'package:flutter/material.dart';

/// AppLocalizations - ระบบหลายภาษา (TH/EN)
class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  static final Map<String, Map<String, String>> _localizedValues = {
    'th': _thaiStrings,
    'en': _englishStrings,
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? key;
  }

  // Getters for easy access
  String get appName => translate('app_name');
  String get home => translate('home');
  String get tickets => translate('tickets');
  String get rooms => translate('rooms');
  String get restaurants => translate('restaurants');
  String get profile => translate('profile');
  String get cart => translate('cart');
  String get login => translate('login');
  String get register => translate('register');
  String get logout => translate('logout');
  String get bookNow => translate('book_now');
  String get checkout => translate('checkout');
  String get pay => translate('pay');
  String get back => translate('back');
  String get next => translate('next');
  String get cancel => translate('cancel');
  String get confirm => translate('confirm');
  String get save => translate('save');
  String get search => translate('search');
  String get filter => translate('filter');
  
  // Home Screen
  String get welcome => translate('welcome');
  String get recommendedAttractions => translate('recommended_attractions');
  String get yourPromotions => translate('your_promotions');
  String get exploreAllZones => translate('explore_all_zones');
  String get birthdayPromo => translate('birthday_promo');
  String get ticketPromo => translate('ticket_promo');
  String get roomPromo => translate('room_promo');
  String get foodPromo => translate('food_promo');
  
  // Authentication
  String get email => translate('email');
  String get password => translate('password');
  String get confirmPassword => translate('confirm_password');
  String get forgotPassword => translate('forgot_password');
  String get dontHaveAccount => translate('dont_have_account');
  String get alreadyHaveAccount => translate('already_have_account');
  String get fullName => translate('full_name');
  String get phoneNumber => translate('phone_number');
  String get dateOfBirth => translate('date_of_birth');
  String get nationality => translate('nationality');
  String get idCardNumber => translate('id_card_number');
  String get passportNumber => translate('passport_number');
  
  // Tickets
  String get ticketBooking => translate('ticket_booking');
  String get selectDate => translate('select_date');
  String get selectQuantity => translate('select_quantity');
  String get adult => translate('adult');
  String get child => translate('child');
  String get senior => translate('senior');
  String get foreigner => translate('foreigner');
  String get ticketPrice => translate('ticket_price');
  String get totalPrice => translate('total_price');
  String get discount => translate('discount');
  String get grandTotal => translate('grand_total');
  
  // Rooms
  String get roomBooking => translate('room_booking');
  String get checkIn => translate('check_in');
  String get checkOut => translate('check_out');
  String get selectRoom => translate('select_room');
  String get roomType => translate('room_type');
  String get available => translate('available');
  String get fullyBooked => translate('fully_booked');
  String get perNight => translate('per_night');
  String get guests => translate('guests');
  
  // Restaurants
  String get restaurantBooking => translate('restaurant_booking');
  String get selectRestaurant => translate('select_restaurant');
  String get menu => translate('menu');
  String get preOrder => translate('pre_order');
  String get tableBooking => translate('table_booking');
  String get numberOfPeople => translate('number_of_people');
  String get bookingTime => translate('booking_time');
  
  // Cart & Checkout
  String get cartEmpty => translate('cart_empty');
  String get itemsInCart => translate('items_in_cart');
  String get removeFromCart => translate('remove_from_cart');
  String get proceedToCheckout => translate('proceed_to_checkout');
  String get paymentMethod => translate('payment_method');
  String get creditCard => translate('credit_card');
  String get promptPay => translate('prompt_pay');
  String get bookingConfirmation => translate('booking_confirmation');
  String get bookingSuccess => translate('booking_success');
  String get eTicket => translate('e_ticket');
  
  // Profile
  String get myProfile => translate('my_profile');
  String get myBookings => translate('my_bookings');
  String get editProfile => translate('edit_profile');
  String get changePassword => translate('change_password');
  String get language => translate('language');
  String get settings => translate('settings');
  String get kycVerification => translate('kyc_verification');
  
  // Promotions
  String get birthdayDiscount => translate('birthday_discount');
  String get holidayPricing => translate('holiday_pricing');
  String get thaiNationalDiscount => translate('thai_national_discount');
  String get earlyBirdDiscount => translate('early_bird_discount');
  
  // Status
  String get pending => translate('pending');
  String get confirmed => translate('confirmed');
  String get cancelled => translate('cancelled');
  String get completed => translate('completed');
  
  // Error Messages
  String get errorNetworkFailed => translate('error_network_failed');
  String get errorInvalidCredentials => translate('error_invalid_credentials');
  String get errorSessionExpired => translate('error_session_expired');
  String get errorServerError => translate('error_server_error');
  String get errorFieldRequired => translate('error_field_required');
  String get errorInvalidEmail => translate('error_invalid_email');
  String get errorPasswordTooShort => translate('error_password_too_short');
  String get errorPasswordMismatch => translate('error_password_mismatch');
  
  // Common
  String get yes => translate('yes');
  String get no => translate('no');
  String get ok => translate('ok');
  String get loading => translate('loading');
  String get pleaseWait => translate('please_wait');
  String get tryAgain => translate('try_again');
  String get noDataFound => translate('no_data_found');
}

// Thai Strings
const Map<String, String> _thaiStrings = {
  'app_name': 'สวนนงนุช',
  'home': 'หน้าหลัก',
  'tickets': 'จองตั๋ว',
  'rooms': 'จองที่พัก',
  'restaurants': 'ร้านอาหาร',
  'profile': 'โปรไฟล์',
  'cart': 'ตะกร้า',
  'login': 'เข้าสู่ระบบ',
  'register': 'สมัครสมาชิก',
  'logout': 'ออกจากระบบ',
  'book_now': 'จองเลย',
  'checkout': 'ชำระเงิน',
  'pay': 'จ่ายเงิน',
  'back': 'ย้อนกลับ',
  'next': 'ถัดไป',
  'cancel': 'ยกเลิก',
  'confirm': 'ยืนยัน',
  'save': 'บันทึก',
  'search': 'ค้นหา',
  'filter': 'ตัวกรอง',
  
  // Home Screen
  'welcome': 'ยินดีต้อนรับ',
  'recommended_attractions': 'โซนท่องเที่ยวแนะนำ',
  'your_promotions': 'โปรโมชั่นสำหรับคุณ',
  'explore_all_zones': 'สำรวจทุกโซน',
  'birthday_promo': 'สุขสันต์วันเกิด! รับสิทธิ์พิเศษเฉพาะคุณ',
  'ticket_promo': 'คุ้มกว่า! ซื้อตั๋วเข้าชมล่วงหน้า',
  'room_promo': 'พักผ่อนเหนือระดับ กับที่พักวิวสวน',
  'food_promo': 'อิ่มไม่อั้น! บุฟเฟ่ต์นานาชาติ',
  
  // Authentication
  'email': 'อีเมล',
  'password': 'รหัสผ่าน',
  'confirm_password': 'ยืนยันรหัสผ่าน',
  'forgot_password': 'ลืมรหัสผ่าน?',
  'dont_have_account': 'ยังไม่มีบัญชี?',
  'already_have_account': 'มีบัญชีแล้ว?',
  'full_name': 'ชื่อ-นามสกุล',
  'phone_number': 'เบอร์โทรศัพท์',
  'date_of_birth': 'วันเกิด',
  'nationality': 'สัญชาติ',
  'id_card_number': 'เลขบัตรประชาชน',
  'passport_number': 'เลขพาสปอร์ต',
  
  // Tickets
  'ticket_booking': 'จองตั๋วเข้าชม',
  'select_date': 'เลือกวันที่',
  'select_quantity': 'เลือกจำนวน',
  'adult': 'ผู้ใหญ่',
  'child': 'เด็ก',
  'senior': 'ผู้สูงอายุ',
  'foreigner': 'ชาวต่างชาติ',
  'ticket_price': 'ราคาตั๋ว',
  'total_price': 'ราคารวม',
  'discount': 'ส่วนลด',
  'grand_total': 'ยอดรวมสุทธิ',
  
  // Rooms
  'room_booking': 'จองห้องพัก',
  'check_in': 'เช็คอิน',
  'check_out': 'เช็คเอาท์',
  'select_room': 'เลือกห้อง',
  'room_type': 'ประเภทห้อง',
  'available': 'ว่าง',
  'fully_booked': 'เต็ม',
  'per_night': 'ต่อคืน',
  'guests': 'ผู้เข้าพัก',
  
  // Restaurants
  'restaurant_booking': 'จองร้านอาหาร',
  'select_restaurant': 'เลือกร้านอาหาร',
  'menu': 'เมนูอาหาร',
  'pre_order': 'สั่งอาหารล่วงหน้า',
  'table_booking': 'จองโต๊ะ',
  'number_of_people': 'จำนวนคน',
  'booking_time': 'เวลาที่จอง',
  
  // Cart & Checkout
  'cart_empty': 'ตะกร้าว่างเปล่า',
  'items_in_cart': 'รายการในตะกร้า',
  'remove_from_cart': 'ลบออกจากตะกร้า',
  'proceed_to_checkout': 'ดำเนินการชำระเงิน',
  'payment_method': 'วิธีการชำระเงิน',
  'credit_card': 'บัตรเครดิต',
  'prompt_pay': 'พร้อมเพย์',
  'booking_confirmation': 'ยืนยันการจอง',
  'booking_success': 'จองสำเร็จ!',
  'e_ticket': 'บัตรอิเล็กทรอนิกส์',
  
  // Profile
  'my_profile': 'โปรไฟล์ของฉัน',
  'my_bookings': 'การจองของฉัน',
  'edit_profile': 'แก้ไขโปรไฟล์',
  'change_password': 'เปลี่ยนรหัสผ่าน',
  'language': 'ภาษา',
  'settings': 'ตั้งค่า',
  'kyc_verification': 'ยืนยันตัวตน (KYC)',
  
  // Promotions
  'birthday_discount': 'ส่วนลดวันเกิด',
  'holiday_pricing': 'ราคาวันหยุด',
  'thai_national_discount': 'ส่วนลดคนไทย',
  'early_bird_discount': 'ส่วนลดจองล่วงหน้า',
  
  // Status
  'pending': 'รอดำเนินการ',
  'confirmed': 'ยืนยันแล้ว',
  'cancelled': 'ยกเลิกแล้ว',
  'completed': 'เสร็จสิ้น',
  
  // Error Messages
  'error_network_failed': 'เชื่อมต่อเครือข่ายไม่สำเร็จ',
  'error_invalid_credentials': 'อีเมลหรือรหัสผ่านไม่ถูกต้อง',
  'error_session_expired': 'เซสชันหมดอายุ กรุณาเข้าสู่ระบบใหม่',
  'error_server_error': 'เกิดข้อผิดพลาดจากเซิร์ฟเวอร์',
  'error_field_required': 'กรุณากรอกข้อมูลให้ครบถ้วน',
  'error_invalid_email': 'รูปแบบอีเมลไม่ถูกต้อง',
  'error_password_too_short': 'รหัสผ่านต้องมีอย่างน้อย 6 ตัวอักษร',
  'error_password_mismatch': 'รหัสผ่านไม่ตรงกัน',
  
  // Common
  'yes': 'ใช่',
  'no': 'ไม่ใช่',
  'ok': 'ตกลง',
  'loading': 'กำลังโหลด...',
  'please_wait': 'กรุณารอสักครู่...',
  'try_again': 'ลองใหม่อีกครั้ง',
  'no_data_found': 'ไม่พบข้อมูล',
};

// English Strings
const Map<String, String> _englishStrings = {
  'app_name': 'Suan Nong Nooch',
  'home': 'Home',
  'tickets': 'Tickets',
  'rooms': 'Rooms',
  'restaurants': 'Restaurants',
  'profile': 'Profile',
  'cart': 'Cart',
  'login': 'Login',
  'register': 'Register',
  'logout': 'Logout',
  'book_now': 'Book Now',
  'checkout': 'Checkout',
  'pay': 'Pay',
  'back': 'Back',
  'next': 'Next',
  'cancel': 'Cancel',
  'confirm': 'Confirm',
  'save': 'Save',
  'search': 'Search',
  'filter': 'Filter',
  
  // Home Screen
  'welcome': 'Welcome',
  'recommended_attractions': 'Recommended Attractions',
  'your_promotions': 'Your Promotions',
  'explore_all_zones': 'Explore All Zones',
  'birthday_promo': 'Happy Birthday! Get Your Special Offer',
  'ticket_promo': 'Better Value! Book Your Tickets in Advance',
  'room_promo': 'Premium Relaxation with Garden View',
  'food_promo': 'All You Can Eat! International Buffet',
  
  // Authentication
  'email': 'Email',
  'password': 'Password',
  'confirm_password': 'Confirm Password',
  'forgot_password': 'Forgot Password?',
  'dont_have_account': "Don't have an account?",
  'already_have_account': 'Already have an account?',
  'full_name': 'Full Name',
  'phone_number': 'Phone Number',
  'date_of_birth': 'Date of Birth',
  'nationality': 'Nationality',
  'id_card_number': 'ID Card Number',
  'passport_number': 'Passport Number',
  
  // Tickets
  'ticket_booking': 'Ticket Booking',
  'select_date': 'Select Date',
  'select_quantity': 'Select Quantity',
  'adult': 'Adult',
  'child': 'Child',
  'senior': 'Senior',
  'foreigner': 'Foreigner',
  'ticket_price': 'Ticket Price',
  'total_price': 'Total Price',
  'discount': 'Discount',
  'grand_total': 'Grand Total',
  
  // Rooms
  'room_booking': 'Room Booking',
  'check_in': 'Check In',
  'check_out': 'Check Out',
  'select_room': 'Select Room',
  'room_type': 'Room Type',
  'available': 'Available',
  'fully_booked': 'Fully Booked',
  'per_night': 'per night',
  'guests': 'Guests',
  
  // Restaurants
  'restaurant_booking': 'Restaurant Booking',
  'select_restaurant': 'Select Restaurant',
  'menu': 'Menu',
  'pre_order': 'Pre-Order',
  'table_booking': 'Table Booking',
  'number_of_people': 'Number of People',
  'booking_time': 'Booking Time',
  
  // Cart & Checkout
  'cart_empty': 'Cart is Empty',
  'items_in_cart': 'Items in Cart',
  'remove_from_cart': 'Remove from Cart',
  'proceed_to_checkout': 'Proceed to Checkout',
  'payment_method': 'Payment Method',
  'credit_card': 'Credit Card',
  'prompt_pay': 'PromptPay',
  'booking_confirmation': 'Booking Confirmation',
  'booking_success': 'Booking Successful!',
  'e_ticket': 'E-Ticket',
  
  // Profile
  'my_profile': 'My Profile',
  'my_bookings': 'My Bookings',
  'edit_profile': 'Edit Profile',
  'change_password': 'Change Password',
  'language': 'Language',
  'settings': 'Settings',
  'kyc_verification': 'KYC Verification',
  
  // Promotions
  'birthday_discount': 'Birthday Discount',
  'holiday_pricing': 'Holiday Pricing',
  'thai_national_discount': 'Thai National Discount',
  'early_bird_discount': 'Early Bird Discount',
  
  // Status
  'pending': 'Pending',
  'confirmed': 'Confirmed',
  'cancelled': 'Cancelled',
  'completed': 'Completed',
  
  // Error Messages
  'error_network_failed': 'Network connection failed',
  'error_invalid_credentials': 'Invalid email or password',
  'error_session_expired': 'Session expired. Please login again',
  'error_server_error': 'Server error occurred',
  'error_field_required': 'Please fill in all required fields',
  'error_invalid_email': 'Invalid email format',
  'error_password_too_short': 'Password must be at least 6 characters',
  'error_password_mismatch': 'Passwords do not match',
  
  // Common
  'yes': 'Yes',
  'no': 'No',
  'ok': 'OK',
  'loading': 'Loading...',
  'please_wait': 'Please wait...',
  'try_again': 'Try Again',
  'no_data_found': 'No Data Found',
};

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['th', 'en'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
