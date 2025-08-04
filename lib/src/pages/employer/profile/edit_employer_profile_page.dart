import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hustle_link/src/src.dart';
import 'package:sizer/sizer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:go_router/go_router.dart';

class EditEmployerProfilePage extends HookConsumerWidget {
  final Employer profile;

  const EditEmployerProfilePage({super.key, required this.profile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController(text: profile.name);
    final companyNameController = useTextEditingController(
      text: profile.companyName,
    );
    final companyDescriptionController = useTextEditingController(
      text: profile.companyDescription ?? '',
    );
    final locationController = useTextEditingController(
      text: profile.location ?? '',
    );
    final phoneController = useTextEditingController(
      text: profile.phoneNumber ?? '',
    );
    final websiteController = useTextEditingController(
      text: profile.website ?? '',
    );

    final isLoading = useState(false);
    final formKey = useRef(GlobalKey<FormState>());
    final selectedProfileImage = useState<File?>(null);

    final userService = ref.read(firestoreUserServiceProvider);
    final storageService = ref.read(firebaseStorageServiceProvider);
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
              content: Text('Failed to pick image: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }

    Future<void> saveProfile() async {
      if (!formKey.value.currentState!.validate()) return;

      isLoading.value = true;
      try {
        String? photoUrl = profile.photoUrl;

        // Upload profile image if selected
        if (selectedProfileImage.value != null) {
          photoUrl = await storageService.uploadProfileImage(
            profile.uid,
            selectedProfileImage.value!,
          );
        }

        final updatedProfile = profile.copyWith(
          name: nameController.text.trim(),
          companyName: companyNameController.text.trim(),
          companyDescription: companyDescriptionController.text.trim().isEmpty
              ? null
              : companyDescriptionController.text.trim(),
          location: locationController.text.trim().isEmpty
              ? null
              : locationController.text.trim(),
          phoneNumber: phoneController.text.trim().isEmpty
              ? null
              : phoneController.text.trim(),
          website: websiteController.text.trim().isEmpty
              ? null
              : websiteController.text.trim(),
          photoUrl: photoUrl,
        );

        await userService.updateEmployerProfile(profile.uid, updatedProfile);

        // Invalidate the profile provider to refresh data
        ref.invalidate(currentEmployerProfileProvider);

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Profile updated successfully!'),
              backgroundColor: Colors.green,
            ),
          );
          context.pop();
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to update profile: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } finally {
        isLoading.value = false;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: Theme.of(context).colorScheme.surface,
        actions: [
          TextButton(
            onPressed: isLoading.value ? null : saveProfile,
            child: isLoading.value
                ? SizedBox(
                    width: 20.sp,
                    height: 20.sp,
                    child: const CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Save'),
          ),
        ],
      ),
      body: Form(
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
                                  : 'E',
                              style: TextStyle(
                                fontSize: 32.sp,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                            ),
                    ),
                    SizedBox(height: 2.h),
                    TextButton.icon(
                      onPressed: pickProfileImage,
                      icon: const Icon(Icons.camera_alt),
                      label: Text(
                        selectedProfileImage.value != null
                            ? 'Change Photo'
                            : 'Add Photo',
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 4.h),

              // Personal Information
              _SectionTitle('Personal Information'),
              SizedBox(height: 2.h),

              _FormField(
                controller: nameController,
                label: 'Full Name',
                icon: Icons.person_outline,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Name is required';
                  }
                  return null;
                },
              ),

              SizedBox(height: 3.h),

              _FormField(
                controller: companyNameController,
                label: 'Company Name',
                icon: Icons.business_outlined,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Company name is required';
                  }
                  return null;
                },
              ),

              SizedBox(height: 4.h),

              // Contact Information
              _SectionTitle('Contact Information'),
              SizedBox(height: 2.h),

              _FormField(
                controller: phoneController,
                label: 'Phone Number',
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
                hintText: '+1 (555) 123-4567',
              ),

              SizedBox(height: 3.h),

              _FormField(
                controller: locationController,
                label: 'Location',
                icon: Icons.location_on_outlined,
                hintText: 'City, State',
              ),

              SizedBox(height: 3.h),

              _FormField(
                controller: websiteController,
                label: 'Website',
                icon: Icons.language_outlined,
                keyboardType: TextInputType.url,
                hintText: 'https://www.company.com',
              ),

              SizedBox(height: 4.h),

              // Company Information
              _SectionTitle('Company Information'),
              SizedBox(height: 2.h),

              _FormField(
                controller: companyDescriptionController,
                label: 'Company Description',
                icon: Icons.info_outline,
                maxLines: 4,
                hintText: 'Describe your company, mission, and values...',
              ),

              SizedBox(height: 6.h),
            ],
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
            color: Theme.of(context).colorScheme.outline.withOpacity(0.5),
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
