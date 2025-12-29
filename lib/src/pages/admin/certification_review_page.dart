import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hustle_link/src/providers/certification_service_provider.dart';
import 'package:hustle_link/src/src.dart';
import 'package:url_launcher/url_launcher.dart';

class CertificationReviewPage extends ConsumerStatefulWidget {
  final Certification certification;

  const CertificationReviewPage({super.key, required this.certification});

  @override
  ConsumerState<CertificationReviewPage> createState() =>
      _CertificationReviewPageState();
}

class _CertificationReviewPageState
    extends ConsumerState<CertificationReviewPage> {
  final _reasonController = TextEditingController();
  bool _isProcessing = false;

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  Future<void> _approve() async {
    setState(() => _isProcessing = true);
    try {
      final auth = ref.read(firebaseAuthServiceProvider);
      final adminId = auth.currentUser!.uid;

      await ref
          .read(certificationServiceProvider)
          .verifyCertification(
            certificationId: widget.certification.id,
            adminId: adminId,
          );

      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Certification Approved')));
        context.pop();
        // Refresh the list
        ref.invalidate(pendingCertificationsProvider);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  Future<void> _reject() async {
    final reason = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reject Certification'),
        content: TextField(
          controller: _reasonController,
          decoration: const InputDecoration(
            hintText: 'Enter reason for rejection',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, _reasonController.text),
            child: const Text('Reject'),
          ),
        ],
      ),
    );

    if (reason == null || reason.isEmpty) return;

    setState(() => _isProcessing = true);
    try {
      final auth = ref.read(firebaseAuthServiceProvider);
      final adminId = auth.currentUser!.uid;

      await ref
          .read(certificationServiceProvider)
          .rejectCertification(
            certificationId: widget.certification.id,
            reason: reason,
            adminId: adminId,
          );

      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Certification Rejected')));
        context.pop();
        ref.invalidate(pendingCertificationsProvider);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Review Certification')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('File: ${widget.certification.fileName}'),
            const SizedBox(height: 8),
            Text('User ID: ${widget.certification.userId}'),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  launchUrl(Uri.parse(widget.certification.downloadUrl));
                },
                icon: const Icon(Icons.download),
                label: const Text('View Document'),
              ),
            ),
            const SizedBox(height: 32),
            if (_isProcessing)
              const Center(child: CircularProgressIndicator())
            else
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _reject,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade100,
                      foregroundColor: Colors.red,
                    ),
                    child: const Text('Reject'),
                  ),
                  ElevatedButton(
                    onPressed: _approve,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade100,
                      foregroundColor: Colors.green,
                    ),
                    child: const Text('Approve'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
