# **Movie App**

Aplikasi ini adalah proyek sederhana menggunakan Flutter yang mengambil data film dari REST API dan menampilkannya dalam daftar yang bisa dicari, serta menampilkan detail setiap film untuk kebutuhan UTS Mata Kuliah mobile application development

## **Fitur Utama**

1. **Daftar Film** - Menampilkan daftar film populer.
2. **Pencarian Film** - pencarian film berdasarkan judul.
3. **Detail Film** - Menampilkan detail lengkap dari film yang dipilih, termasuk judul, tanggal rilis, rating, dan sinopsis.

## **Langkah Installasi**

1. **Clone repositori ini**:

   ```bash
   git clone https://github.com/Hudzaiflank/MidTerm-MobileAppDev.git

   ```

2. **Masuk ke direktori proyek**:

   ```bash
   cd MidTerm-MobileAppDev
   ```

3. **Install dependencies**:

   ```bash
   flutter pub get
   ```

4. **Menyiapkan API Key**:

- Daftar di The Movie Database (TMDb) dan dapatkan **API Key**.
- Buka file **api_service.dart** dan gantikan API asli yang sudah ada dengan API Key yang didapatkan dari TMDb.

## **Struktur Proyek**

- **main.dart**: File utama yang mengelola halaman beranda aplikasi, menampilkan daftar film, dan menyediakan pencarian.
- **api_service.dart**: Mengelola semua request API untuk mendapatkan data film dari TMDb.
- **movie_detail_screen.dar**: Menampilkan detail dari film yang dipilih.
