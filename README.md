### Tugas 7

1. 
Widget tree adalah struktur hierarki berbentuk pohon yang terbentuk dari nested widget. Pada Flutter, hampir semuanya adalah widget karena seluruh UI dibangun dengan menyusun widget di dalam widget lain.
Hubungan parent-child:
Parent adalah widget yang membungkus widget lain, dimana Parent menentukan constraint (batas ukuran) yang diteruskan ke child. Sedangkan Child adalah widget yang dibungkus, dimana Child bisa menentukan ukurannya sendiri dalam batas tersbut, lalu parent menentukan posisinya. 
2. 
- MyApp: Root aplikasi yang membangun MaterialApp dengan tema dan menetapkan halaman awal.
- MyHomePage: Sebagai halaman utama yang meenampilkan identitas pesan sambutan, dan kisi tombol menu.
- InfoCard: Kartu kecil yang menampilkan sepasang title dan content (dipakai untuk NPM, Name, Class).
- ItemCard: Kartu tombol menu berwarna. Saat diklik akan menampilkan SnackBar.
3. 
MaterialApp berfungsi untuk memberikan tema, navigasi/routing, lokalisasi, serta menyediakan widget pendukung seperti Theme, Navigator, MediaQuery, dan Overlay.
Digunakan sebagai root karena banyak widget Material (seperti Scaffold, AppBar, ElevatedButton, SnackBar) bergantung pada widget parent yang disediakan MaterialApp. Oleh karena itu MaterialApp ditempatkan di root agar semua widget di bawahnya mendapat konfigurasi yang konsisten.
4.
Stateless widget adalah widget yang tampilannya tetap dan tidak berubah dengan sendirinya, karena hanya menampilkan data yang diberikan dari luar saat widget dibuat, sedangkan stateful widget adalah widget yang tampilannya bisa berubah-ubah selama aplikasi berjalan, karena widgt tersebut menyimpan data (state) di dalam dirinya dan akan menggambar ulang tampilannya setiap kali data itu berubah lewat setState()
Stateless widget sebaiknya digunakan ketika tampilan tidak perlu berubah akibat interaksi pengguna atau data internal, misalnya label teks, ikon, kartu informasi, atau tata letak halaman yang isinya tetap. 
Sedangkan stateful widget digunakan ketika tampilan perlu berubah selama aplikasi berjalan, misalnya counter yang bertambah saat tombol ditekan, checkbox atau switch yang bisa dinyalakan dan dimatikan, input form, animasi, atau data yang dimuat dari internet lalu ditampilkan setelah tersedia.
5. 
BuildContext adalah penanda lokasi sebuah widget di dalam widget tree yang memungkinkan widget mengambil informasi dari widget leluhurnya, seperti tema, ukuran layar, atau navigasi. BuildContext penting karena jika tanpa context, widget tidak tahu posisinya di pohon dan tidak bisa mengakses data atau layanan yang disediakan widget di atasnya.
Di dalam method build, Flutter otomatis memberikan context lewat parameter Widget build(BuildContext context), lalu context itu dipakai untuk mengambil data dari leluhur. Pada project ini, MyHomePage memakai Theme.of(context) untuk mengambil warna tema unntuk AppBar, dan ItemCard memakai ScaffoldMessenger.of(context) untuk menampilkan SnackBar.
6. 
Hot reload adalah fitur untuk melihat perubahan kode secara langsung di aplikasi yang sedang berjalan, tanpa menghapus data atau tampilan yang sedang dipakai. Sedangkan Hot restart menjalankan aplikasi lagi dari awal sehingga semua data kembali ke kondisi awal.
Kita tidak bisa hanya mengandalkan hot reload kalau perubahan kodenya berada di bagian yang hanya dijalankan sekali saat aplikasi pertama kali dibuka, seperti isi main(), variabel global atau static, dan initState(). Kalau bagian tersbut yang diubah, kita harus melakukan hot restart.
Sedangkan untuk full restart, yaitu menghentikan aplikasi lalu menjalankannya lagi dengan flutter run, dilakukan saat perubahannya bukan hanya di kode Dart. Contohnya menambah aset atau font baru, atau mengubah kode bawaan Android dan iOS.

# AI Disclosure
Dalam pengerjaan project ini, saya menggunakan:
Claude.ai
- Mengecek checklist tugas untuk memastikan seluruh ketentuan sudah terpenuhi.
- Membantu memperbaiki layout tombol menu agar tidak overflow setelah jumlah tombol bertambah.
- Membantu menjelaskan materi Flutter yang berkaitan dengan pertanyaan refleksi, yaitu widget tree, widget yang digunakan, MaterialApp, StatelessWidget dan StatefulWidget, BuildContext, serta hot reload dan hot restart.
Chat AI: https://claude.ai/share/ddf49120-64fc-47b7-9393-280d2e50c039