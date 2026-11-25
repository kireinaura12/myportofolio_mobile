import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/models/project.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';

class ProjectFormPage extends StatefulWidget {
  const ProjectFormPage({super.key});

  @override
  State<ProjectFormPage> createState() => _ProjectFormPageState();
}

class _ProjectFormPageState extends State<ProjectFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _title = '';
  String _description = '';
  String _techStack = '';
  String _projectUrl = '';
  String _projectImageUrl = '';
  bool _isSubmitting = false;

  String? _required(String? v, String name) =>
      (v == null || v.trim().isEmpty) ? '$name tidak boleh kosong!' : null;

  String? _validateUrl(String? value, {required bool required}) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) {
      return required ? 'URL tidak boleh kosong!' : null;
    }
    final uri = Uri.tryParse(text);
    final isHttp =
        uri != null &&
        (uri.scheme == 'http' || uri.scheme == 'https') &&
        uri.host.isNotEmpty;
    return isHttp ? null : 'Masukkan URL http(s) yang valid!';
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (!await ensureLoggedIn(context)) return;
    if (!mounted) return;

    final authState = context.read<AuthState>();
    final apiClient = context.read<ApiClient>();
    final messenger = ScaffoldMessenger.of(context);

    final newProject = Project(
      title: _title.trim(),
      description: _description.trim(),
      techStack: _techStack.trim(),
      projectUrl: _projectUrl.trim(),
      projectImageUrl: _projectImageUrl.trim(),
    );

    setState(() => _isSubmitting = true);
    try {
      final created = await apiClient.createProject(
        newProject,
        token: authState.token!,
      );
      if (!mounted) return;
      await showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Proyek berhasil ditambahkan!'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Judul: ${created.title}'),
                Text('Deskripsi: ${created.description}'),
                Text('Tech Stack: ${created.techStack}'),
                Text('URL: ${created.projectUrl}'),
                if (created.projectImageUrl.isNotEmpty)
                  Text('Gambar: ${created.projectImageUrl}'),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
      if (!mounted) return;
      _formKey.currentState!.reset();
      _title = _description = _techStack = _projectUrl = _projectImageUrl = '';
    } on ApiException catch (e) {
      if (!mounted) return;
      if (e.statusCode == 401) {
        // Token tidak valid/kedaluwarsa: logout lalu minta login ulang.
        await authState.logout();
        if (!mounted) return;
        messenger.showSnackBar(
          const SnackBar(content: Text('Sesi habis, silakan login ulang.')),
        );
        if (await ensureLoggedIn(context) && mounted) {
          setState(() => _isSubmitting = false);
          await _submit(); // ulangi sekali dengan token baru
        }
      } else {
        messenger.showSnackBar(
          SnackBar(content: Text('Gagal menyimpan (status ${e.statusCode}).')),
        );
      }
    } catch (_) {
      if (!mounted) return;
      messenger.showSnackBar(
        const SnackBar(content: Text('Tidak dapat terhubung ke server.')),
      );
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  Widget _field({
    required String label,
    String? hint,
    int maxLines = 1,
    required ValueChanged<String> onChanged,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint ?? label,
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        ),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Add Project Form')),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _field(
                label: 'Title',
                onChanged: (v) => _title = v,
                validator: (v) => _required(v, 'Title'),
              ),
              _field(
                label: 'Description',
                maxLines: 5,
                onChanged: (v) => _description = v,
                validator: (v) => _required(v, 'Description'),
              ),
              _field(
                label: 'Tech Stack',
                hint: 'Contoh: Flutter, Django, Figma',
                onChanged: (v) => _techStack = v,
                validator: (v) => _required(v, 'Tech Stack'),
              ),
              _field(
                label: 'Project URL',
                hint: 'https://...',
                onChanged: (v) => _projectUrl = v,
                validator: (v) => _validateUrl(v, required: true),
              ),
              _field(
                label: 'Project Image URL (Optional)',
                hint: 'https://...',
                onChanged: (v) => _projectImageUrl = v,
                validator: (v) => _validateUrl(v, required: false),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.black),
                    ),
                    onPressed: _isSubmitting ? null : _submit,
                    child: _isSubmitting
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text(
                            'Save',
                            style: TextStyle(color: Colors.white),
                          ),
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
