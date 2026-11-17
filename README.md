# nim_latres_D — Toko Online (Latihan Responsi Praktikum Mobile SI-D)

Aplikasi toko online Flutter. Data produk dari API eksternal
`https://dummyjson.com/products`.

## Fitur
- Login (username bebas, password = NIM), username disimpan di session.
- Auto-login: selama belum logout, buka app langsung ke halaman utama.
- Bottom navigation: Home & Profile.
- Home: info username, tombol cart, list produk dari API.
- Detail produk: info lengkap, qty (0 < qty <= stok), Add to Cart (Hive).
- Cart: hanya item milik user yang login, tombol hapus item, total harga.
- Profile: username, deskripsi, tombol logout.

## Struktur Folder
```
lib/
├── main.dart                  # Entry point: init Hive, cek session, tentukan halaman awal
├── config/
│   └── constants.dart         # NIM (password login) & URL API
├── models/
│   ├── product.dart           # Model Product & Review (parsing JSON API)
│   └── cart_item.dart         # Model item keranjang (disimpan ke Hive)
├── services/
│   ├── api_service.dart       # HTTP request ke dummyjson (package http)
│   ├── session_service.dart   # Simpan/baca/hapus username (SharedPreferences)
│   └── cart_service.dart      # CRUD keranjang di Hive, dipisah per username
└── pages/
    ├── login_page.dart        # Form login + validasi password = NIM
    ├── main_page.dart         # Scaffold + BottomNavigationBar (Home, Profile)
    ├── home_page.dart         # Sapaan username, tombol cart, list produk
    ├── detail_page.dart       # Detail produk, qty, Add to Cart
    ├── cart_page.dart         # Isi keranjang milik user, hapus item, total
    └── profile_page.dart      # Info user, deskripsi, logout
```

## Alur Data
- **Session** (SharedPreferences, key `username`): ada = sudah login.
- **Cart** (Hive box `cart_box`): key `"<username>:<productId>"`, value berisi
  username, productId, title, price, thumbnail, stock, qty. Karena key memuat
  username, cart tiap user terpisah, dan tetap tersimpan saat logout.
- **Produk**: tidak disimpan lokal, diambil dari API tiap membuka Home.

## Cara Menjalankan
1. Ganti `kNim` di `lib/config/constants.dart` dengan NIM kamu.
2. `flutter pub get`
3. `flutter run`
