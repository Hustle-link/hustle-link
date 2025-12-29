import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hustle_link/src/providers/certification_service_provider.dart';
import 'package:hustle_link/src/shared/routing/app_router.dart';
import 'package:intl/intl.dart';

class AdminDashboardPage extends ConsumerWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pendingAsync = ref.watch(pendingCertificationsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Admin Dashboard')),
      body: pendingAsync.when(
        data: (certifications) {
          if (certifications.isEmpty) {
            return const Center(child: Text('No pending certifications'));
          }
          return ListView.builder(
            itemCount: certifications.length,
            itemBuilder: (context, index) {
              final cert = certifications[index];
              return ListTile(
                title: Text('User ID: ${cert.userId}'),
                subtitle: Text(
                  'Uploaded: ${DateFormat.yMMMd().format(cert.uploadedAt)}',
                ),
                trailing: ElevatedButton(
                  onPressed: () {
                    // Navigate to review page
                    context.pushNamed(
                      AppRoutes.adminCertificationReviewRoute,
                      extra: cert,
                    );
                  },
                  child: const Text('Review'),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Text('Error: $err', style: TextStyle(color: Colors.red)),
        ),
      ),
    );
  }
}
