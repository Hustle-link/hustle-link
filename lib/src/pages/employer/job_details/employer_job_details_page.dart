import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hustle_link/src/src.dart';
import 'package:sizer/sizer.dart';

/// A Riverpod provider that fetches a stream of applications for a specific job.
///
/// This is intended for the employer's view of job details.
// TODO(caching): Implement caching for job applications to reduce Firestore reads.
final jobApplicationsProvider =
    StreamProvider.family<List<JobApplication>, String>((ref, jobId) {
      final svc = ref.watch(firestoreJobServiceProvider);
      return svc.getApplicationsForJob(jobId);
    });

/// A widget that displays the details of a job posting for an employer.
///
/// This page shows the job's title, description, and other metadata, as well
/// as a list of applications submitted for the job.
class EmployerJobDetailsPage extends HookConsumerWidget {
  /// The ID of the job to display.
  final String jobId;

  /// Creates a new instance of [EmployerJobDetailsPage].
  const EmployerJobDetailsPage({super.key, required this.jobId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final jobAsync = ref.watch(jobByIdProvider(jobId));

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.jobDetails),
        actions: [
          IconButton(
            tooltip: l10n.editJob,
            onPressed: jobAsync.maybeWhen(
              data: (job) => job == null
                  ? null
                  : () {
                      context.push(
                        AppRoutes.employerPostJob,
                        extra: {'editJobId': job.id},
                      );
                    },
              orElse: () => null,
            ),
            icon: const Icon(Icons.edit_outlined),
          ),
        ],
      ),
      body: jobAsync.when(
        data: (job) {
          if (job == null) {
            return Center(child: Text(l10n.jobNotFound));
          }

          return ListView(
            padding: EdgeInsets.all(4.w),
            children: [
              // Header
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          job.title,
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (job.employerCompany != null) ...[
                          SizedBox(height: 0.5.h),
                          Text(
                            job.employerCompany!,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  _StatusChip(status: job.status),
                ],
              ),

              SizedBox(height: 2.h),

              // Meta
              Wrap(
                spacing: 4.w,
                runSpacing: 1.h,
                children: [
                  _Meta(
                    icon: Icons.payments_outlined,
                    label: '\$${job.compensation.toStringAsFixed(0)}',
                  ),
                  if (job.location != null)
                    _Meta(
                      icon: Icons.location_on_outlined,
                      label: job.location!,
                    ),
                  if (job.deadline != null)
                    _Meta(
                      icon: Icons.event_outlined,
                      label: '${l10n.deadline}: ${_fmtDate(job.deadline!)}',
                    ),
                  _Meta(
                    icon: Icons.access_time,
                    label: _timeAgo(job.createdAt, l10n),
                  ),
                ],
              ),

              SizedBox(height: 2.h),

              // Description
              Text(
                job.description,
                style: TextStyle(fontSize: 14.sp, height: 1.5),
              ),

              if (job.skillsRequired.isNotEmpty) ...[
                SizedBox(height: 2.h),
                Wrap(
                  spacing: 2.w,
                  runSpacing: 1.h,
                  children: job.skillsRequired
                      .map((s) => Chip(label: Text(s)))
                      .toList(),
                ),
              ],

              SizedBox(height: 3.h),

              // Applications header
              Row(
                children: [
                  Text(
                    l10n.jobApplications,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  if ((job.applicationsCount ?? 0) > 0)
                    Text(
                      l10n.total(job.applicationsCount.toString()),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                ],
              ),
              SizedBox(height: 1.h),

              Consumer(
                builder: (context, ref, _) {
                  final apps = ref.watch(jobApplicationsProvider(job.id));
                  return apps.when(
                    data: (list) {
                      if (list.isEmpty) {
                        return _EmptyApps();
                      }
                      return Column(
                        children: list
                            .map((a) => _ApplicationTile(app: a))
                            .toList(),
                      );
                    },
                    loading: () => const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    error: (e, st) => Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(l10n.errorLoadingApplications),
                    ),
                  );
                },
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: jobAsync.maybeWhen(
        data: (job) => job == null
            ? null
            : FloatingActionButton.extended(
                onPressed: () {
                  // open applications bottom sheet list
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    builder: (_) => SizedBox(
                      height: 0.8.sh,
                      child: Padding(
                        padding: EdgeInsets.all(4.w),
                        child: Consumer(
                          builder: (context, ref, _) {
                            final apps = ref.watch(
                              jobApplicationsProvider(job.id),
                            );
                            return apps.when(
                              data: (list) => list.isEmpty
                                  ? _EmptyApps()
                                  : ListView.separated(
                                      itemBuilder: (_, i) =>
                                          _ApplicationTile(app: list[i]),
                                      separatorBuilder: (_, __) =>
                                          const Divider(height: 1),
                                      itemCount: list.length,
                                    ),
                              loading: () => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              error: (e, st) =>
                                  Center(child: Text('Error: $e')),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.people_outline),
                label: Text(l10n.viewApplications),
              ),
        orElse: () => null,
      ),
    );
  }

  /// Formats a [DateTime] object into a "time ago" string.
  String _timeAgo(DateTime dt, AppLocalizations l10n) {
    final d = DateTime.now().difference(dt);
    if (d.inDays > 0) return l10n.ago('${d.inDays}d');
    if (d.inHours > 0) return l10n.ago('${d.inHours}h');
    if (d.inMinutes > 0) return l10n.ago('${d.inMinutes}m');
    return l10n.justNow;
  }

  /// Formats a [DateTime] object into a "day/month/year" string.
  String _fmtDate(DateTime dt) => '${dt.day}/${dt.month}/${dt.year}';
}

/// A widget that displays a piece of metadata with an icon.
class _Meta extends StatelessWidget {
  final IconData icon;
  final String label;

  /// Creates a new instance of [_Meta].
  const _Meta({required this.icon, required this.label});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 16.sp,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        SizedBox(width: 1.w),
        Text(
          label,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

/// A widget that displays a chip with the job's status.
class _StatusChip extends StatelessWidget {
  final JobStatus status;

  /// Creates a new instance of [_StatusChip].
  const _StatusChip({required this.status});
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    Color color;
    String text;
    switch (status) {
      case JobStatus.active:
        color = Colors.green;
        text = l10n.active;
        break;
      case JobStatus.closed:
        color = Colors.red;
        text = l10n.closed;
        break;
      case JobStatus.draft:
        color = Colors.orange;
        text = l10n.draft;
        break;
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.8.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontWeight: FontWeight.w600),
      ),
    );
  }
}

/// A widget that is displayed when there are no applications for a job.
class _EmptyApps extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Column(
        children: [
          Icon(
            Icons.assignment_outlined,
            size: 48.sp,
            color: Theme.of(context).colorScheme.outline,
          ),
          SizedBox(height: 1.h),
          Text(
            l10n.noApplicationsYet,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

/// A widget that displays a single job application in a list tile.
class _ApplicationTile extends StatelessWidget {
  final JobApplication app;

  /// Creates a new instance of [_ApplicationTile].
  const _ApplicationTile({required this.app});
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    Color statusColor;
    String statusText;
    switch (app.status) {
      case ApplicationStatus.pending:
        statusColor = Colors.orange;
        statusText = l10n.pending;
        break;
      case ApplicationStatus.reviewed:
        statusColor = Colors.blue;
        statusText = l10n.reviewed;
        break;
      case ApplicationStatus.accepted:
        statusColor = Colors.green;
        statusText = l10n.accepted;
        break;
      case ApplicationStatus.rejected:
        statusColor = Colors.red;
        statusText = l10n.rejected;
        break;
    }

    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 2.w),
      leading: CircleAvatar(
        child: Text(app.hustlerName?.substring(0, 1).toUpperCase() ?? '?'),
      ),
      title: Text(
        app.hustlerName ?? app.hustlerUid,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(l10n.applied(_timeAgo(app.appliedAt, l10n))),
      trailing: Container(
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.6.h),
        decoration: BoxDecoration(
          color: statusColor.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(statusText, style: TextStyle(color: statusColor)),
      ),
    );
  }

  String _timeAgo(DateTime dt, AppLocalizations l10n) {
    final d = DateTime.now().difference(dt);
    if (d.inDays > 0) return l10n.ago('${d.inDays}d');
    if (d.inHours > 0) return l10n.ago('${d.inHours}h');
    if (d.inMinutes > 0) return l10n.ago('${d.inMinutes}m');
    return l10n.justNow;
  }
}
