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

### Tugas 8

1. 
Navigator.push() menambahkan halaman baru di atas halaman yang sedang running, sehingga halaman lama tetap tersimpan di stack dan user bisa kembali ke sana. 
Navigator.pushReplacement() mengganti halaman yang sedang running dengan halaman baru, sehingga halaman lama dibuang atau di-pop dari stack dan tidak bisa dikembalikan lewat tombol back. 
Navigator.pop() membuang atau pop halaman paling atas dari stack sehingga user kembali ke halaman di bawahnya.
Untuk membuka formulir dari kartu aksi, project ini memakai Navigator.push(). Pada ItemCard, kartu "Tambah Proyek" dan "Tambah Experience" memanggil Navigator.push() ke ProjectFormPage atau ExperienceFormPage, agar user bisa kembali ke halaman utama dengan tombol back.
Home di drawer menggunakan Navigator.pushReplacement() dengan MaterialPageRoute. Halaman formulir yang sedang running diganti dengan halaman utama, sehingga user sampai di halaman utama tanpa perlu menekan tombol back. Cara ini juga yang dipakai untuk menguji alur back di Chrome, karena Chrome tidak punya tombol back sistem.
2. 
Scaffold menyediakan kerangka dasar halaman, yaitu tempat untuk AppBar, Drawer, dan body. AppBar menampilkan judul halaman di bagian atas, sedangkan Drawer menyediakan menu navigasi yang muncul dari sisi kiri. Karena setiap halaman memakai susunan yang sama, user selalu menemukan judul di tempat yang sama dan menu navigasi yang sama. Pada project ini, drawer dibuat sekali sebagai LeftDrawer, lalu dipasang lewat drawer const LeftDrawer() di MyHomePage, ProjectFormPage, dan ExperienceFormPage, sehingga isinya tidak perlu ditulis ulang di setiap halaman.
Contoh penggunaan warna tema adalah warna black dipakai di beberapa tempat. Di main.dart, ColorScheme.fromSeed memakai seedColor Colors.black. AppBar pada ProjectFormPage dan ExperienceFormPage memakai backgroundColor Colors.black dengan foregroundColor putih, DrawerHeader pada LeftDrawer memakai warna black yang sama, dan tombol Save pada kedua form juga berwarna black. Sementara itu, AppBar pada MyHomePage mengambil warna lewat Theme.of(context).colorScheme.primary, yang berasal dari seed black tersebut.
3. 
Formulir disusun dengan Form yang membungkus SingleChildScrollView, lalu Column yang berisi seluruh input dengan crossAxisAlignment.start. Column dipilih karena input dibaca dari atas ke bawah, dan alignment ke kiri membuat label serta kolom terlihat rapi.
Setiap input dibungkus Padding dengan jarak 8.0. Padding berperan untuk memberi jarak antar kolom dan antara kolom dengan tepi layar, sehingga input tidak saling menempel, terutama pada layar yang kecil.
SingleChildScrollView berfungsi untuk membuat isi formulir bisa discroll. Ketika layar terbatas, misalnya pada saat keyboard tampil dan menutupi sebagian layar, isi formulir tidak terpotong dan tidak menimbulkan overflow. SDehingga user tetap bisa scroll untuk menjangkau semua input dan tombol Save.
4. 
GlobalKey<FormState> adalah key yang dipakai untuk mengakses Form dari luar, misalnya dari tombol Save. Key-nya disimpan di variabel _formKey lalu dipasang pada atribut key milik Form. 
Validator adalah function di setiap TextFormField yang mengecek isi input, lalu return pesan error kalau isinya salah atau null kalau isinya benar. 
Validate() adalah method yang menjalankan semua validator itu sekaligus. Hasilnya true kalau semua input benar, dan false kalau ada yang salah, sehingga error message muncul di kolom yang inputnya salah.
Saat tombol Save atau Simpn ditekan, program memanggil _formKey.currentState!.validate(). Dialog ringkasan hanya muncul kalau hasilnya true. Kalau false, pengguna tetap di form dan melihat error messagenya.
Contoh nilai yang ditolak adalah link thumbnail "bukan-url". Validator mengecek apakah link itu diawali http atau https dan punya nama host. Karena "bukan-url" tidak memenuhi keduanya, kolom menampilkan errr message "Masukkan URL http(s) yang valid!" dan tombol Simpan tidak bisa menampilkan dialog.
Memilih jenis input atau papan ketik saja belum cukup karena keduanya hanya mengatur tampilan dan cara mengetik, tidak memeriksa isinya. Papan ketik khusus URL tetap membiarkan user mengetik "bukan-url", atau menempelkan teks apa saja. Sehingga isinya tetap harus dicek lewat validasi.

# AI Disclosure
Dalam pengerjaan project ini, saya menggunakan:
Claude.ai
- Membantu menjelaskan materi tutorial Flutter, yaitu drawer menu serta form dan elemen input.
- Menganalisis checklist tugas dan menyusun urutan langkah pengerjaannya
- Membantu merekomendasikan field formulir Experience dan pilihan kategori
- Membantu menambahkan validasi, seperti validasi panjang nama dan format URL.
- Mengecek checklist tugas untuk memastikan seluruh ketentuan sudah terpenuhi
