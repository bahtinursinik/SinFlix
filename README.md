# 🎬 SinFlix

**SinFlix**, kullanıcıların modern bir arayüzle film keşfetmesini ve favori filmlerini yönetmesini sağlayan bir Flutter uygulamasıdır. Uygulama; kayıt, giriş, favori film ekleme, profil görüntüleme gibi temel kullanıcı akışlarını destekler ve bu işlemler sırasında Lottie animasyonları ile kullanıcı deneyimi artırılmıştır.

---

## 🚀 Genel Özellikler

- 🔐 E-posta ile kullanıcı **kayıt** ve **giriş**
- 🧠 Giriş yaptıktan sonra **token saklama** ve **otomatik giriş yönetimi**
- 🏠 Ana sayfada film listesi (sonsuz kaydırma, 5 film/sayfa)
- ❤️ Favori filmleri ekleme / çıkarma, UI'da anlık güncelleme
- 👤 Profil sayfasında “Beğendiğim Filmler” bölümü
- 🔄 Pull-to-refresh ve loading göstergeleri
- 📥 Sınırlı Teklif Bottom Sheet tasarımı
- 🌍 Türkçe ve İngilizce **çoklu dil desteği** (Localization)
- 🧩 **Custom Widget** kullanımı
- 🧭 Bottom Navigation ile kolay gezinme
- 📲 Splash Screen ve özel uygulama ikonu
- 🎞️ Başarılı işlemlerde Lottie animasyonları
- 📦 MVVM + Clean Architecture yapısı
- 📚 BLoC State Management
- 🛠️ Logger Service
- 🔐 Güvenli token yönetimi (secure storage)

---

## 🧱 Kullanılan Teknolojiler

| Katman | Açıklama |
|-------|----------|
| 🎯 Flutter | Mobil uygulama geliştirme |
| 📦 BLoC | Durum yönetimi |
| 🧼 Clean Architecture | Katmanlı, sürdürülebilir yapı |
| 🔐 flutter_secure_storage | Token saklama |
| 🎨 Lottie | Animasyonlar |
| 🧪 Custom Widgets | UI tekrarını azaltmak için özelleştirilmiş bileşenler |
| 🛠 Logger | Geliştirme sürecinde hata/log takibi |

---

## 📱 Ekranlar

- **Login Screen** – Kullanıcı girişi
- **Register Screen** – Yeni kullanıcı kaydı
- **Home Screen** – Filmlerin listelendiği ana sayfa
- **Profile Screen** – Kullanıcı bilgileri ve favori filmler
- **Bottom Sheet** – Sınırlı teklif popup’ı
- **Splash Screen** – Açılış ekranı

---

## 🔁 Navigasyon

- `BottomNavigationBar` kullanılarak sayfalar arası geçiş yapılır.
- Sayfalar arası geçişte state korunur.
- Navigator Service ile dinamik yönlendirme yapılır.

---

### 🔑 Kimlik Doğrulama

- ✅ Kayıt ve giriş işlemleri
- ✅ Token'ın güvenli şekilde saklanması (`flutter_secure_storage`)
- ✅ Başarılı girişte otomatik yönlendirme

### 🏠 Ana Sayfa Özellikleri

- ✅ Sonsuz kaydırma (infinite scroll)
- ✅ Sayfa başına 5 film
- ✅ Pull-to-refresh ve loading animasyonları
- ✅ Favori butonu ile anlık güncelleme

### 👤 Profil Sayfası

- ✅ Kullanıcı bilgilerini gösterme
- ✅ Favorilere eklenen filmleri listeleme

### 🌐 Dil Desteği

- ✅ Uygulama, Türkçe ve İngilizce olarak kullanılabilir
- ✅ Kullanıcının sistem diline göre otomatik dil seçimi

### 🔄 Navigasyon

- ✅ `BottomNavigationBar` ile geçiş
- ✅ Sayfa state'leri korunur

### 🧩 Ek Özellikler

- ✅ Logger Service
- ✅ Lottie Animasyonlar
- ✅ Splash Screen ve ikon
- ✅ Custom Widget'larla modüler yapı

  ### Ekran Fotoğrafları

  <img width="1290" height="2796" alt="Image" src="https://github.com/user-attachments/assets/3ff318bb-f930-4fb0-9e2c-924d8aaa7d73" />

  <img width="1290" height="2796" alt="Image" src="https://github.com/user-attachments/assets/b4e15379-46c0-4ae6-960b-adc64f752c83" />

  <img width="1290" height="2796" alt="Image" src="https://github.com/user-attachments/assets/762b044b-da30-482c-a6ff-c379ab27a716" />

  <img width="1290" height="2796" alt="Image" src="https://github.com/user-attachments/assets/fa10554b-eedb-461a-acfc-d3a2b962199f" />

  <img width="1290" height="2796" alt="Image" src="https://github.com/user-attachments/assets/9f5ab3d2-fa2f-4d58-b040-dbec15daab1f" />

  <img width="1290" height="2796" alt="Image" src="https://github.com/user-attachments/assets/66bdc4a1-f5ed-47fc-88ad-cac37915a449" />

  <img width="1290" height="2796" alt="Image" src="https://github.com/user-attachments/assets/48711e48-37ce-451c-8838-46d641ee83fb" />

### 📦 Kurulum
git clone https://github.com/bahtinursinik/SinFlix.git
cd SinFlix
flutter pub get
flutter run
