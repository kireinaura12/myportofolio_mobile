import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/models/experience.dart';

class ExperienceDetailScreen extends StatelessWidget {
  const ExperienceDetailScreen({super.key, required this.experience});

  final Experience experience;

  // Format hari-bulan-tahun, tanpa paket tambahan. toLocal() dipakai karena
  // tanggal dari API bisa berupa waktu UTC.
  String _formatDate(DateTime? date) {
    if (date == null) return '-';
    final local = date.toLocal();
    final day = local.day.toString().padLeft(2, '0');
    final month = local.month.toString().padLeft(2, '0');
    return '$day-$month-${local.year}';
  }

  @override
  Widget build(BuildContext context) {
    final thumbnail = experience.thumbnail;
    final category = experience.categoryDisplay.isNotEmpty
        ? experience.categoryDisplay
        : experience.category;

    return Scaffold(
      appBar: AppBar(
        title: Text(experience.title),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar hanya ditampilkan kalau URL-nya ada dan tidak kosong.
            if (thumbnail != null && thumbnail.isNotEmpty) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  thumbnail,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const SizedBox.shrink(),
                ),
              ),
              const SizedBox(height: 16),
            ],
            Text(
              experience.title,
              style: Theme.of(context).textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Chip(label: Text(category)),
            const SizedBox(height: 16),
            Text(experience.description),
            const SizedBox(height: 24),
            const Text(
              'Tanggal Mulai',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(_formatDate(experience.startedAt)),
            const SizedBox(height: 16),
            const Text(
              'Tanggal Selesai',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              experience.endedAt == null
                  ? 'Sedang berlangsung'
                  : _formatDate(experience.endedAt),
            ),
          ],
        ),
      ),
    );
  }
}
