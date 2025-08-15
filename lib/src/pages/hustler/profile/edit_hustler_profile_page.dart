import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hustle_link/src/src.dart';
import 'package:hustle_link/src/pages/hustler/profile/controllers/controllers.dart';
import 'package:hustle_link/src/shared/l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_selector/file_selector.dart';
import 'package:go_router/go_router.dart';

class EditHustlerProfilePage extends HookConsumerWidget {
  final Hustler profile;

  const EditHustlerProfilePage({super.key, required this.profile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final nameController = useTextEditingController(text: profile.name);
    final bioController = useTextEditingController(text: profile.bio ?? '');
    final experienceController = useTextEditingController(
      text: profile.experience ?? '',
    );
    final locationController = useTextEditingController(
      text: profile.location ?? '',
    );
    final phoneController = useTextEditingController(
      text: profile.phoneNumber ?? '',
    );
    final skillsController = useTextEditingController(
      text: profile.skills.join(', '),
    );

    final controller = ref.read(editHustlerProfileControllerProvider.notifier);
    final mutation = ref.watch(editHustlerProfileControllerProvider);
    ref.listen<AsyncValue<void>>(editHustlerProfileControllerProvider, (
      prev,
      next,
    ) {
      if (next.hasError) {
        final msg = next.error.toString().replaceFirst('Exception: ', '');
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(msg),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      }
    });
    final formKey = useRef(GlobalKey<FormState>());
    final selectedProfileImage = useState<File?>(null);
    final certifications = useState<List<String>>([...profile.certifications]);
    final newCertificationFiles = useState<List<File>>([]);

    final imagePicker = ImagePicker();

    Future<void> pickProfileImage() async {
      try {
        final pickedFile = await imagePicker.pickImage(
          source: ImageSource.gallery,
          maxWidth: 1080,
          maxHeight: 1080,
          imageQuality: 85,
        );

        if (pickedFile != null) {
          selectedProfileImage.value = File(pickedFile.path);
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.failedToPickImage(e.toString())),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }

    Future<void> pickCertificationFiles() async {
      try {
        const XTypeGroup typeGroup = XTypeGroup(
          label: 'Documents',
          extensions: <String>['pdf', 'doc', 'docx'],
          mimeTypes: <String>[
            'application/pdf',
            'application/msword',
            'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
          ],
        );

        final List<XFile> files = await openFiles(
          acceptedTypeGroups: <XTypeGroup>[typeGroup],
        );

        if (files.isNotEmpty) {
          final List<File> fileList = files
              .map((file) => File(file.path))
              .toList();
          newCertificationFiles.value = [
            ...newCertificationFiles.value,
            ...fileList,
          ];
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.failedToPickFiles(e.toString())),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }

    Future<void> removeCertification(
      int index, {
      bool isExisting = true,
    }) async {
      if (isExisting) {
        final updatedCertifications = [...certifications.value];
        updatedCertifications.removeAt(index);
        certifications.value = updatedCertifications;
      } else {
        final updatedFiles = [...newCertificationFiles.value];
        updatedFiles.removeAt(index);
        newCertificationFiles.value = updatedFiles;
      }
    }

    Future<void> saveProfile() async {
      if (!formKey.value.currentState!.validate()) return;

      try {
        // Parse skills from comma-separated string
        final skillsList = skillsController.text
            .split(',')
            .map((skill) => skill.trim())
            .where((skill) => skill.isNotEmpty)
            .toList();

        String? photoUrl = profile.photoUrl;

        // Upload profile image if selected
        if (selectedProfileImage.value != null) {
          await controller.uploadProfileImage(
            profile.uid,
            selectedProfileImage.value!,
          );
          // Ideally we'd fetch the new URL from storage return; for now, keep existing until refreshed
          photoUrl = profile.photoUrl;
        }

        // Upload new certification files
        final allCertifications = [...certifications.value];
        for (final certFile in newCertificationFiles.value) {
          final fileName = certFile.path.split('/').last;
          await controller.uploadCertification(profile.uid, certFile, fileName);
          // Defer actual URLs to refreshed profile
        }

        final updatedProfile = profile.copyWith(
          name: nameController.text.trim(),
          bio: bioController.text.trim().isEmpty
              ? null
              : bioController.text.trim(),
          experience: experienceController.text.trim().isEmpty
              ? null
              : experienceController.text.trim(),
          location: locationController.text.trim().isEmpty
              ? null
              : locationController.text.trim(),
          phoneNumber: phoneController.text.trim().isEmpty
              ? null
              : phoneController.text.trim(),
          skills: skillsList,
          photoUrl: photoUrl,
          certifications: allCertifications,
        );

        await controller.saveProfile(profile, updatedProfile);

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.profileUpdatedSuccessfully),
              backgroundColor: Colors.green,
            ),
          );
          context.pop();
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.failedToUpdateProfile(e.toString())),
              backgroundColor: Colors.red,
            ),
          );
        }
      } finally {}
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.editProfile),
        backgroundColor: Theme.of(context).colorScheme.surface,
        actions: [
          TextButton(
            onPressed: mutation.isLoading ? null : saveProfile,
            child: mutation.isLoading
                ? SizedBox(
                    width: 20.sp,
                    height: 20.sp,
                    child: const CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(l10n.save),
          ),
        ],
      ),
      body: SafeArea(
        child: Form(
          key: formKey.value,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Picture Section
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40.sp,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: selectedProfileImage.value != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(40.sp),
                                child: Image.file(
                                  selectedProfileImage.value!,
                                  width: 80.sp,
                                  height: 80.sp,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : profile.photoUrl != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(40.sp),
                                child: Image.network(
                                  profile.photoUrl!,
                                  width: 80.sp,
                                  height: 80.sp,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Text(
                                profile.name.isNotEmpty
                                    ? profile.name[0].toUpperCase()
                                    : 'H',
                                style: TextStyle(
                                  fontSize: 32.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onPrimary,
                                ),
                              ),
                      ),
                      SizedBox(height: 2.h),
                      TextButton.icon(
                        onPressed: pickProfileImage,
                        icon: const Icon(Icons.camera_alt),
                        label: Text(
                          selectedProfileImage.value != null
                              ? l10n.changePhoto
                              : l10n.addPhoto,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 4.h),

                // Basic Information
                _SectionTitle(l10n.basicInformation),
                SizedBox(height: 2.h),

                _FormField(
                  controller: nameController,
                  label: l10n.fullName,
                  icon: Icons.person_outline,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return l10n.nameIsRequired;
                    }
                    return null;
                  },
                ),

                SizedBox(height: 3.h),

                _FormField(
                  controller: bioController,
                  label: l10n.bio,
                  icon: Icons.info_outline,
                  maxLines: 3,
                  hintText: l10n.tellOthersAboutYourself,
                ),

                SizedBox(height: 4.h),

                // Contact Information
                _SectionTitle(l10n.contactInformation),
                SizedBox(height: 2.h),

                _FormField(
                  controller: phoneController,
                  label: l10n.phoneNumber,
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  hintText: '+267 7123 4567',
                ),

                SizedBox(height: 3.h),

                _FormField(
                  controller: locationController,
                  label: l10n.location,
                  icon: Icons.location_on_outlined,
                  hintText: l10n.cityState,
                ),

                SizedBox(height: 4.h),

                // Professional Information
                _SectionTitle(l10n.professionalInformation),
                SizedBox(height: 2.h),

                _FormField(
                  controller: skillsController,
                  label: l10n.skills,
                  icon: Icons.build_outlined,
                  hintText: l10n.skillsHint,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return l10n.pleaseAddAtLeastOneSkill;
                    }
                    return null;
                  },
                ),

                SizedBox(height: 1.h),

                Text(
                  l10n.separateSkillsWithCommas,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withAlpha((0.6 * 255).toInt()),
                  ),
                ),

                SizedBox(height: 3.h),

                _FormField(
                  controller: experienceController,
                  label: l10n.experience,
                  icon: Icons.work_outline,
                  maxLines: 4,
                  hintText: l10n.experienceHint,
                ),

                SizedBox(height: 4.h),

                // Certifications Section
                _SectionTitle(l10n.certifications),
                SizedBox(height: 2.h),

                Text(
                  l10n.uploadCertificates,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withAlpha((0.6 * 255).toInt()),
                  ),
                ),

                SizedBox(height: 2.h),

                // Existing certifications
                if (certifications.value.isNotEmpty) ...[
                  ...certifications.value.asMap().entries.map((entry) {
                    final index = entry.key;
                    final certUrl = entry.value;
                    final fileName = certUrl
                        .split('/')
                        .last
                        .split('_')
                        .skip(1)
                        .join('_');

                    return _CertificationItem(
                      fileName: fileName.length > 30
                          ? '${fileName.substring(0, 30)}...'
                          : fileName,
                      onRemove: () =>
                          removeCertification(index, isExisting: true),
                      isExisting: true,
                    );
                  }),
                  SizedBox(height: 2.h),
                ],

                // New certification files
                if (newCertificationFiles.value.isNotEmpty) ...[
                  ...newCertificationFiles.value.asMap().entries.map((entry) {
                    final index = entry.key;
                    final file = entry.value;
                    final fileName = file.path.split('/').last;

                    return _CertificationItem(
                      fileName: fileName.length > 30
                          ? '${fileName.substring(0, 30)}...'
                          : fileName,
                      onRemove: () =>
                          removeCertification(index, isExisting: false),
                      isExisting: false,
                    );
                  }),
                  SizedBox(height: 2.h),
                ],

                // Add certifications button
                ElevatedButton.icon(
                  onPressed: pickCertificationFiles,
                  icon: const Icon(Icons.upload_file),
                  label: Text(l10n.addCertifications),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 6.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                SizedBox(height: 6.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }
}

class _FormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final String? hintText;
  final int maxLines;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const _FormField({
    required this.controller,
    required this.label,
    required this.icon,
    this.hintText,
    this.maxLines = 1,
    this.keyboardType,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(
              context,
            ).colorScheme.outline.withAlpha((0.5 * 255).toInt()),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
      ),
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
    );
  }
}

class _CertificationItem extends StatelessWidget {
  final String fileName;
  final VoidCallback onRemove;
  final bool isExisting;

  const _CertificationItem({
    required this.fileName,
    required this.onRemove,
    required this.isExisting,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      margin: EdgeInsets.only(bottom: 1.h),
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(
            context,
          ).colorScheme.outline.withAlpha((0.3 * 255).toInt()),
        ),
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Row(
        children: [
          Icon(
            _getFileIcon(fileName),
            color: Theme.of(context).colorScheme.primary,
            size: 24.sp,
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fileName,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 0.5.h),
                Text(
                  isExisting ? l10n.uploaded : l10n.readyToUpload,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: isExisting
                        ? Colors.green
                        : Theme.of(context).colorScheme.onSurface.withAlpha(
                            (0.6 * 255).toInt(),
                          ),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onRemove,
            icon: Icon(Icons.close, color: Colors.red, size: 20.sp),
          ),
        ],
      ),
    );
  }

  IconData _getFileIcon(String fileName) {
    final extension = fileName.split('.').last.toLowerCase();
    switch (extension) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'doc':
      case 'docx':
        return Icons.description;
      default:
        return Icons.insert_drive_file;
    }
  }
}
