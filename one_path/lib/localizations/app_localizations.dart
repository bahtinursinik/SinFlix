import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static const Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'hello': "Hello",
      'pleaseLogin': "Log in to continue.",
      'welcomeApp': "Welcome to our App!",
      'email': "Email",
      'password': "Password",
      'forgotPassword': "Forgot Password",
      'login': "Login",
      'noAccount': "Don't have an account?",
      'register': "Register!",
      "comeOn": "Come on. Join us!",
      "discoverMore": "Create your account to discover more.",
      'welcome': "Welcome",
      'registerInstruction': "Please fill in all the fields below to register",
      'fullName': "Full Name",
      'passwordRepeat': "Repeat Password",
      'agreementTextPart1': "I have read the ",
      'agreementTextPart2': "user agreement and accept it",
      'agreementTextPart3': ". Please read this agreement to proceed.",
      'registerNow': "Register Now",
      'alreadyHaveAccount': "Already have an account?",
      'loginHere': "Login Here!",
      'profileDetail': "Profile Detail",
      'uploadPhotos': "Upload Your Photos",
      'pleaseUploadPhoto': "Please upload your photo",
      'continueText': "Continue",
      'homePage': "Home",
      'profile': "Profile",
      'limitedOffer': "Limited Offer",
      'addPhoto': "Add Photo",
      'favoriteMovies': "Favorite Movies",
      'bonusText':
          "Select your token\npackage to earn bonuses and unlock new episodes!",
      'premiumAccount': "Premium\nAccount",
      'moreMatches': "More\nMatches",
      'highlight': "Highlight\n",
      'moreLikes': "More\nLikes",
      'selectCoin': "Select a coin package to unlock",
      'token': "Token",
      'seeAllTokens': "See All Tokens",
      'pleaseSelectLanguage':
          "Please select your preferred language to use the app",
      'turkish': "Turkish",
      'english': "English",
      'logout': "Logout",
      'idLabel': "ID",
      'photoAddSuccess': "Photo uploaded successfully!",
      'favoriteMoviesEmpty': "No favorite movies found.",
      'profileLoadError': "Failed to load profile",
      'profileLoadErrorMessage': "Error loading profile:",
      'uploadPhotoButton': "Add Photo",
      'languageSelectionTitle': "Language Selection",
      'selectLanguage': "Please select a language",
      'languageTurkish': "Turkish",
      'languageEnglish': "English",
      'fillAllFields': 'Please fill in all fields',
      'enterValidEmail': 'Please enter a valid email address',
      'passwordsDoNotMatch': 'Passwords do not match',
      'registrationSuccess': 'Registration successful! You can now log in.',
      'continue': 'Continue',
      'uploadPhoto': 'Update Photo',
      'pleaseUploadPhotoFirst': 'Please upload a photo first.',
      'photoUploaded': 'Photo uploaded!',
      'error': 'Error:',
      'imageNotProcessed': 'Image could not be processed.',
      'tokenNotFound': 'Token not found.',
      'perWeek': 'Per week',
      'bonusesYouWillReceive': 'Bonuses You Will Receive',
      'uploadPhotoInstruction':
          'Please upload your photo.\nYou can update this photo later.',
      'showMore': "Show more",
      'showLess': "Show less",
      'settings': "Settings"
    },
    'tr': {
      'hello': "Merhabalar",
      'pleaseLogin': "Devam etmek için giriş yapın.",
      'welcomeApp': "Uygulamamıza hoş geldiniz!",
      'email': "E-Posta",
      'password': "Şifre",
      'forgotPassword': "Şifremi unuttum",
      'login': "Giriş Yap",
      'noAccount': "Bir hesabın yok mu?",
      'register': "Kaydol",
      "comeOn": "Hadi. Sen de Aramıza Katıl!",
      "discoverMore": "Daha fazlasını keşfetmek için hesabını oluştur.",
      'welcome': "Hoşgeldiniz",
      'registerInstruction':
          "Kayıt olmak için lütfen alttaki tüm alanları doldurun",
      'fullName': "Ad soyad",
      'passwordRepeat': "Şifre Tekrar",
      'agreementTextPart1': "Kullanıcı sözleşmesini ",
      'agreementTextPart2': "okudum ve kabul ediyorum",
      'agreementTextPart3': ". Bu sözleşmeyi okuyarak devam ediniz lütfen.",
      'registerNow': "Şimdi Kaydol",
      'alreadyHaveAccount': "Zaten bir hesabın var mı?",
      'loginHere': "Giriş Yap!",
      'profileDetail': "Profil Detayı",
      'uploadPhotos': "Fotoğraflarınızı Yükleyin",
      'pleaseUploadPhoto': "Lütfen fotoğrafınızı yükleyin",
      'continueText': "Devam Et",
      'homePage': "Ana sayfa",
      'profile': "Profil",
      'limitedOffer': "Sınırlı Teklif",
      'addPhoto': "Fotoğraf Ekle",
      'favoriteMovies': "Beğendiğim Filmler",
      'bonusText':
          "Jeton paketin’ni seçerek bonus\nkazanın ve yeni bölümlerin kilidini açın!",
      'premiumAccount': "Premium\nHesap",
      'moreMatches': "Daha\nFazla Eşleşme",
      'highlight': "Öne\nÇıkarma",
      'moreLikes': "Daha\nFazla Beğeni",
      'selectCoin': "Kilidi açmak için bir jeton paketi seçin",
      'token': "Jeton",
      'seeAllTokens': "Tüm Jetonları Gör",
      'pleaseSelectLanguage':
          "Lütfen uygulamayı kullanmak için istediğiniz dili seçin",
      'turkish': "Türkçe",
      'english': "İngilizce",
      'logout': "Çıkış Yap",
      'idLabel': "ID",
      'photoAddSuccess': "Fotoğraf başarıyla yüklendi!",
      'favoriteMoviesEmpty': "Favori film bulunamadı.",
      'profileLoadError': "Profil yüklenemedi",
      'profileLoadErrorMessage': "Profil yüklenirken hata:",
      'uploadPhotoButton': "Fotoğraf Ekle",
      'languageSelectionTitle': "Dil Seçimi",
      'selectLanguage': "Lütfen bir dil seçin",
      'languageTurkish': "Türkçe",
      'languageEnglish': "İngilizce",
      'fillAllFields': 'Lütfen tüm alanları doldurunuz',
      'enterValidEmail': 'Geçerli bir e-posta adresi giriniz',
      'passwordsDoNotMatch': 'Şifreler eşleşmiyor',
      'registrationSuccess': 'Kayıt başarılı! Giriş yapabilirsiniz.',
      'continue': 'Devam Et',
      'uploadPhoto': 'Fotoğrafı Güncelle',
      'pleaseUploadPhotoFirst': 'Lütfen önce bir fotoğraf yükleyin.',
      'photoUploaded': 'Fotoğraf yüklendi!',
      'error': 'Hata:',
      'imageNotProcessed': 'Görsel işlenemedi.',
      'tokenNotFound': 'Token bulunamadı.',
      'perWeek': 'Başına haftalık',
      'bonusesYouWillReceive': 'Alacağınız Bonuslar',
      'uploadPhotoInstruction':
          'Lütfen fotoğrafınızı yükleyin.\nBu fotoğrafı daha sonra güncelleyebilirsiniz.',
      'showMore': "Daha fazla göster",
      'showLess': "Daha az göster",
      'settings': "Ayarlar"
    },
  };

  // Property getterlar

  String get hello => _localizedValues[locale.languageCode]!['hello']!;
  String get pleaseLogin =>
      _localizedValues[locale.languageCode]!['pleaseLogin']!;
  String get welcomeApp =>
      _localizedValues[locale.languageCode]!['welcomeApp']!;
  String get email => _localizedValues[locale.languageCode]!['email']!;
  String get password => _localizedValues[locale.languageCode]!['password']!;
  String get forgotPassword =>
      _localizedValues[locale.languageCode]!['forgotPassword']!;
  String get login => _localizedValues[locale.languageCode]!['login']!;
  String get noAccount => _localizedValues[locale.languageCode]!['noAccount']!;
  String get register => _localizedValues[locale.languageCode]!['register']!;
  String get comeOn => _localizedValues[locale.languageCode]!['comeOn']!;
  String get discoverMore =>
      _localizedValues[locale.languageCode]!['discoverMore']!;
  String get welcome => _localizedValues[locale.languageCode]!['welcome']!;
  String get registerInstruction =>
      _localizedValues[locale.languageCode]!['registerInstruction']!;
  String get fullName => _localizedValues[locale.languageCode]!['fullName']!;
  String get passwordRepeat =>
      _localizedValues[locale.languageCode]!['passwordRepeat']!;
  String get agreementTextPart1 =>
      _localizedValues[locale.languageCode]!['agreementTextPart1']!;
  String get agreementTextPart2 =>
      _localizedValues[locale.languageCode]!['agreementTextPart2']!;
  String get agreementTextPart3 =>
      _localizedValues[locale.languageCode]!['agreementTextPart3']!;

  String get registerNow =>
      _localizedValues[locale.languageCode]!['registerNow']!;
  String get alreadyHaveAccount =>
      _localizedValues[locale.languageCode]!['alreadyHaveAccount']!;
  String get loginHere => _localizedValues[locale.languageCode]!['loginHere']!;
  String get profileDetail =>
      _localizedValues[locale.languageCode]!['profileDetail']!;
  String get uploadPhotos =>
      _localizedValues[locale.languageCode]!['uploadPhotos']!;
  String get pleaseUploadPhoto =>
      _localizedValues[locale.languageCode]!['pleaseUploadPhoto']!;
  String get continueText =>
      _localizedValues[locale.languageCode]!['continueText']!;
  String get homePage => _localizedValues[locale.languageCode]!['homePage']!;
  String get profile => _localizedValues[locale.languageCode]!['profile']!;
  String get limitedOffer =>
      _localizedValues[locale.languageCode]!['limitedOffer']!;
  String get addPhoto => _localizedValues[locale.languageCode]!['addPhoto']!;
  String get favoriteMovies =>
      _localizedValues[locale.languageCode]!['favoriteMovies']!;
  String get bonusText => _localizedValues[locale.languageCode]!['bonusText']!;
  String get premiumAccount =>
      _localizedValues[locale.languageCode]!['premiumAccount']!;
  String get moreMatches =>
      _localizedValues[locale.languageCode]!['moreMatches']!;
  String get highlight => _localizedValues[locale.languageCode]!['highlight']!;
  String get moreLikes => _localizedValues[locale.languageCode]!['moreLikes']!;
  String get selectCoin =>
      _localizedValues[locale.languageCode]!['selectCoin']!;
  String get token => _localizedValues[locale.languageCode]!['token']!;
  String get seeAllTokens =>
      _localizedValues[locale.languageCode]!['seeAllTokens']!;
  String get pleaseSelectLanguage =>
      _localizedValues[locale.languageCode]!['pleaseSelectLanguage']!;
  String get turkish => _localizedValues[locale.languageCode]!['turkish']!;
  String get english => _localizedValues[locale.languageCode]!['english']!;
  String get logout => _localizedValues[locale.languageCode]!['logout']!;
  String get idLabel => _localizedValues[locale.languageCode]!['idLabel']!;
  String get photoAddSuccess =>
      _localizedValues[locale.languageCode]!['photoAddSuccess']!;
  String get favoriteMoviesEmpty =>
      _localizedValues[locale.languageCode]!['favoriteMoviesEmpty']!;
  String get profileLoadError =>
      _localizedValues[locale.languageCode]!['profileLoadError']!;
  String get profileLoadErrorMessage =>
      _localizedValues[locale.languageCode]!['profileLoadErrorMessage']!;
  String get uploadPhotoButton =>
      _localizedValues[locale.languageCode]!['uploadPhotoButton']!;
  String get languageSelectionTitle =>
      _localizedValues[locale.languageCode]!['languageSelectionTitle']!;
  String get selectLanguage =>
      _localizedValues[locale.languageCode]!['selectLanguage']!;
  String get languageTurkish =>
      _localizedValues[locale.languageCode]!['languageTurkish']!;
  String get languageEnglish =>
      _localizedValues[locale.languageCode]!['languageEnglish']!;
  String get fillAllFields =>
      _localizedValues[locale.languageCode]!['fillAllFields']!;
  String get enterValidEmail =>
      _localizedValues[locale.languageCode]!['enterValidEmail']!;
  String get passwordsDoNotMatch =>
      _localizedValues[locale.languageCode]!['passwordsDoNotMatch']!;
  String get registrationSuccess =>
      _localizedValues[locale.languageCode]!['registrationSuccess']!;
  String get uploadPhoto =>
      _localizedValues[locale.languageCode]!['uploadPhoto']!;
  String get pleaseUploadPhotoFirst =>
      _localizedValues[locale.languageCode]!['pleaseUploadPhotoFirst']!;
  String get photoUploaded =>
      _localizedValues[locale.languageCode]!['photoUploaded']!;
  String get error => _localizedValues[locale.languageCode]!['error']!;
  String get imageNotProcessed =>
      _localizedValues[locale.languageCode]!['imageNotProcessed']!;
  String get tokenNotFound =>
      _localizedValues[locale.languageCode]!['tokenNotFound']!;
  String get perWeek => _localizedValues[locale.languageCode]!['perWeek']!;
  String get bonusesYouWillReceive =>
      _localizedValues[locale.languageCode]!['bonusesYouWillReceive']!;
  String get uploadPhotoInstruction =>
      _localizedValues[locale.languageCode]!['uploadPhotoInstruction']!;
  String get showMore => _localizedValues[locale.languageCode]!['showMore']!;
  String get showLess => _localizedValues[locale.languageCode]!['showLess']!;
  String get settings => _localizedValues[locale.languageCode]!['settings']!;
  static AppLocalizations of(BuildContext context) {
    final localizations =
        Localizations.of<AppLocalizations>(context, AppLocalizations);
    if (localizations == null) {
      throw Exception('AppLocalizations not found in context');
    }
    return localizations;
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'tr'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async =>
      AppLocalizations(locale);

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) =>
      false;
}
