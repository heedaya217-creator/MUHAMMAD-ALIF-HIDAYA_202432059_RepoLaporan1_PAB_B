import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class ChecklistItem {
  final String title;
  final String category;
  final String note;
  final int daysBefore;
  bool isDone;

  ChecklistItem({
    required this.title,
    required this.category,
    required this.note,
    required this.daysBefore,
    this.isDone = false,
  });
}

// Data profile perjalanan (object berisi data sendiri).
class TripProfile {
  final String name;
  final String destination;
  final String program;
  final int durationDays;
  final double luggageLimitKg; // double

  const TripProfile({
    required this.name,
    required this.destination,
    required this.program,
    required this.durationDays,
    required this.luggageLimitKg,
  });
}

// Icon dan warna aksen untuk tiap kategori.
class CategoryStyle {
  final String name;
  final IconData icon;
  final Color color;

  const CategoryStyle({
    required this.name,
    required this.icon,
    required this.color,
  });
}

const List<CategoryStyle> categoryStyles = [
  CategoryStyle(name: 'Dokumen', icon: Icons.description, color: Colors.blue),
  CategoryStyle(name: 'Akademik', icon: Icons.school, color: Colors.deepOrange),
  CategoryStyle(
    name: 'Barang Bawaan',
    icon: Icons.luggage,
    color: Colors.brown,
  ),
  CategoryStyle(name: 'Akses Digital', icon: Icons.wifi, color: Colors.purple),
  CategoryStyle(name: 'Budaya', icon: Icons.public, color: Colors.pink),
];

CategoryStyle getCategoryStyle(String name) {
  return categoryStyles.firstWhere(
    (c) => c.name == name,
    orElse: () => categoryStyles.first,
  );
}

// APLIKASI UTAMA

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Exchange Starter Pack',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF123B6D))
            .copyWith(primary: const Color(0xFF123B6D)),
      ),
      home: const LayarUtama(),
    );
  }
}

// HALAMAN UTAMA

class LayarUtama extends StatefulWidget {
  const LayarUtama({super.key});

  @override
  State<LayarUtama> createState() => _LayarUtamaState();
}

class _LayarUtamaState extends State<LayarUtama> {
  String selectedCategory = 'All';

  final List<ChecklistItem> items = [
    // Dokumen
    ChecklistItem(
      title: 'Passport',
      category: 'Dokumen',
      note: 'Pastikan masa berlaku minimal 6 bulan setelah tanggal pulang.',
      daysBefore: 30,
    ),
    ChecklistItem(
      title: 'Visa / izin masuk pelajar',
      category: 'Dokumen',
      note: 'Cek ketentuan visa atau izin masuk sesuai negara tujuan.',
      daysBefore: 21,
    ),
    ChecklistItem(
      title: 'Asuransi perjalanan',
      category: 'Dokumen',
      note: 'Simpan nomor polis dan kontak darurat asuransi.',
      daysBefore: 14,
    ),
    ChecklistItem(
      title: 'Surat penerimaan & itinerary',
      category: 'Dokumen',
      note: 'Cetak satu salinan dan simpan versi digitalnya.',
      daysBefore: 7,
    ),
    // Akademik
    ChecklistItem(
      title: 'Learning agreement disetujui',
      category: 'Akademik',
      note: 'Pastikan pilihan mata kuliah sudah ditandatangani kampus asal.',
      daysBefore: 21,
    ),
    ChecklistItem(
      title: 'Transkrip & KRS terbaru',
      category: 'Akademik',
      note: 'Siapkan dalam bentuk PDF dan salinan cetak.',
      daysBefore: 14,
    ),
    ChecklistItem(
      title: 'Kontak koordinator program',
      category: 'Akademik',
      note: 'Simpan email koordinator di kampus asal dan kampus tujuan.',
      daysBefore: 10,
    ),
    // Barang Bawaan
    ChecklistItem(
      title: 'Adaptor colokan',
      category: 'Barang Bawaan',
      note: 'Filipina memakai colokan tipe A, bawa adaptor yang sesuai.',
      daysBefore: 7,
    ),
    ChecklistItem(
      title: 'Obat pribadi',
      category: 'Barang Bawaan',
      note: 'Bawa secukupnya, lengkap dengan kemasan asli.',
      daysBefore: 7,
    ),
    ChecklistItem(
      title: 'Pakaian harian & formal',
      category: 'Barang Bawaan',
      note: 'Siapkan pakaian formal untuk presentasi dan acara kampus.',
      daysBefore: 5,
    ),
    // Akses Digital
    ChecklistItem(
      title: 'eSIM / paket data roaming',
      category: 'Akses Digital',
      note: 'Aktifkan sebelum berangkat supaya langsung online saat tiba.',
      daysBefore: 3,
    ),
    ChecklistItem(
      title: 'Peta offline & aplikasi transportasi',
      category: 'Akses Digital',
      note: 'Unduh peta area kampus dan aplikasi ride-hailing lokal.',
      daysBefore: 3,
    ),
    ChecklistItem(
      title: 'Backup dokumen ke cloud',
      category: 'Akses Digital',
      note: 'Unggah paspor, visa, dan surat penerimaan ke penyimpanan cloud.',
      daysBefore: 5,
    ),
    // Budaya
    ChecklistItem(
      title: 'Frasa dasar Bahasa Filipino',
      category: 'Budaya',
      note: 'Pelajari salam, terima kasih, dan cara bertanya arah.',
      daysBefore: 10,
    ),
    ChecklistItem(
      title: 'Etika kampus & budaya setempat',
      category: 'Budaya',
      note: 'Kenali cara berpakaian, bersalaman, dan sopan santun di kelas.',
      daysBefore: 7,
    ),
  ];

  // Daftar yang tampil sesuai filter kategori.
  List<ChecklistItem> get visibleItems {
    if (selectedCategory == 'All') {
      return items;
    }
    return items.where((i) => i.category == selectedCategory).toList();
  }

  int get doneCount => items.where((i) => i.isDone).length;

  void toggleItem(ChecklistItem item) {
    setState(() {
      item.isDone = !item.isDone;
    });
    debugPrint('${item.title}: ${item.isDone ? "SIAP" : "BELUM"}');
  }

  void setVisibleDone(bool value) {
    setState(() {
      for (final item in visibleItems) {
        item.isDone = value;
      }
    });
  }

  void selectCategory(String name) {
    setState(() {
      selectedCategory = name;
    });
  }

  // Button filter kategori.
  Widget buildFilterButton(String name) {
    final Color primary = Theme.of(context).colorScheme.primary;
    final bool selected = selectedCategory == name;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: selected ? primary : Colors.white,
        foregroundColor: selected ? Colors.white : Colors.black87,
      ),
      onPressed: () {
        selectCategory(name);
      },
      child: Text(name),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Objek berisi data milik sendiri
    const myProfile = TripProfile(
      name: 'Muhammad Alif Hidaya',
      destination: 'Quezon City, Philippines',
      program: 'International Mobility Program 2026',
      durationDays: 14,
      luggageLimitKg: 20.0,
    );

    final Color primary = Theme.of(context).colorScheme.primary;
    final List<ChecklistItem> shown = visibleItems;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        title: const Text('Student Exchange Starter Pack'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
            children: [
              const TripHeader(profile: myProfile),
              const SizedBox(height: 16),
              ProgressSummaryCard(done: doneCount, total: items.length),
              const SizedBox(height: 20),
              const Text(
                'Kategori',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  buildFilterButton('All'),
                  ...categoryStyles.map((c) => buildFilterButton(c.name)),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        setVisibleDone(true);
                      },
                      child: const Text('Mark All'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade300,
                        foregroundColor: Colors.black87,
                      ),
                      onPressed: () {
                        setVisibleDone(false);
                      },
                      child: const Text('Reset'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'Daftar Persiapan (${shown.length})',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              ...shown.map(
                (item) => Padding(
                  key: ValueKey(item.title),
                  padding: const EdgeInsets.only(bottom: 12),
                  child: ChecklistCard(
                    item: item,
                    onToggle: () {
                      toggleItem(item);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// CUSTOM WIDGET

// Kartu header berisi data perjalanan.
class TripHeader extends StatelessWidget {
  final TripProfile profile;

  const TripHeader({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final Color primary = Theme.of(context).colorScheme.primary;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: primary,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(40),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.flight_takeoff, color: Colors.white),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Halo, ${profile.name}!',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      profile.program,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              InfoPill(icon: Icons.place, text: profile.destination),
              InfoPill(
                icon: Icons.calendar_month,
                text: '${profile.durationDays} hari',
              ),
              InfoPill(
                icon: Icons.work_outline,
                text: 'Bagasi ${profile.luggageLimitKg.toStringAsFixed(0)} kg',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Label kecil berisi icon dan text
class InfoPill extends StatelessWidget {
  final IconData icon;
  final String text;

  const InfoPill({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(40),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: Colors.white),
          const SizedBox(width: 5),
          Flexible(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

// Kartu ringkasan progress persiapan.
class ProgressSummaryCard extends StatelessWidget {
  final int done;
  final int total;

  const ProgressSummaryCard({
    super.key,
    required this.done,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final Color primary = Theme.of(context).colorScheme.primary;
    final double ratio = total == 0 ? 0 : done / total;
    final int percent = (ratio * 100).round();
    final bool complete = total > 0 && done == total;

    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Progres Persiapan',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Text(
                  '$percent%',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: ratio,
                minHeight: 10,
                backgroundColor: Colors.grey.shade300,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  complete ? Icons.celebration : Icons.checklist,
                  size: 18,
                  color: complete ? primary : Colors.grey.shade600,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    complete
                        ? 'Semua siap, selamat berangkat!'
                        : '$done dari $total persiapan selesai',
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Kartu satu butir persiapan. Buttonnya memanggil callback onToggle.
class ChecklistCard extends StatelessWidget {
  final ChecklistItem item;
  final VoidCallback onToggle;

  const ChecklistCard({super.key, required this.item, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    final Color primary = Theme.of(context).colorScheme.primary;
    final CategoryStyle style = getCategoryStyle(item.category);
    final bool done = item.isDone;

    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: done ? primary.withAlpha(25) : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: done ? primary : Colors.grey.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: done ? primary : style.color.withAlpha(30),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    done ? Icons.check : style.icon,
                    size: 24,
                    color: done ? Colors.white : style.color,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: done ? Colors.grey.shade600 : Colors.black87,
                          decoration: done
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        style.name,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: style.color,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              item.note,
              style: TextStyle(
                fontSize: 13,
                height: 1.4,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.schedule, size: 16, color: Colors.grey.shade500),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    'Target: H-${item.daysBefore}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: done ? Colors.grey.shade300 : primary,
                    foregroundColor: done ? Colors.black87 : Colors.white,
                  ),
                  onPressed: onToggle,
                  child: Text(done ? 'Cancel' : 'Mark as ready'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
