import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hustle_link/src/src.dart';
import 'package:hustle_link/src/pages/employer/profile/controllers/controllers.dart';
import 'package:hustle_link/src/shared/l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:go_router/go_router.dart';

// TODO(refactor): Separate business logic from the UI by using the dedicated controller more extensively.

/// A page that allows an employer to edit their profile information.
///
/// This includes personal details, company information, and profile picture.
/// It takes the current [Employer] profile as a required parameter to pre-fill the form.
class EditEmployerProfilePage extends HookConsumerWidget {
  /// The current employer profile data to be edited.
  final Employer profile;

  /// Creates an [EditEmployerProfilePage].
  const EditEmployerProfilePage({super.key, required this.profile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    // Text editing controllers are initialized with existing profile data.
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

    // Access the controller and mutation state for saving the profile.
    final controller = ref.read(editEmployerProfileControllerProvider.notifier);
    final mutation = ref.watch(editEmployerProfileControllerProvider);
    ref.listen<AsyncValue<void>>(editEmployerProfileControllerProvider, (
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
    // A key to manage the form's state.
    final formKey = useRef(GlobalKey<FormState>());
    // State to hold the new profile image file selected by the user.
    final selectedProfileImage = useState<File?>(null);

    final imagePicker = ImagePicker();

    /// Opens the device's image gallery to pick a new profile photo.
    Future<void> pickProfileImage() async {
      try {
        final pickedFile = await imagePicker.pickImage(
          source: ImageSource.gallery,
          maxWidth: 1080,
          maxHeight: 1080,
          imageQuality: 85, // Compress image to reduce size.
        );

        if (pickedFile != null) {
          selectedProfileImage.value = File(pickedFile.path);
        }
      } catch (e) {
        // TODO(error-handling): Show a more user-friendly error dialog.
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

    /// Validates the form, uploads the new image (if any), and saves the updated profile.
    Future<void> saveProfile() async {
      if (!formKey.value.currentState!.validate()) return;

      try {
        String? photoUrl = profile.photoUrl;

        // If a new image is selected, upload it first.
        // TODO(ux): Show a loading indicator specifically for the image upload.
        if (selectedProfileImage.value != null) {
          await controller.uploadProfileImage(
            profile.uid,
            selectedProfileImage.value!,
          );
          // Note: The photoUrl is updated via a listener on the profile provider,
          // so we re-read it here. A more robust solution might be to get the URL
          // directly from the upload function.
          photoUrl = ref.read(currentEmployerProfileProvider).value?.photoUrl;
        }

        // Create an updated profile object with the new data.
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

        // Save the updated profile data to Firestore.
        await controller.saveProfile(profile, updatedProfile);

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.profileUpdatedSuccessfully),
              backgroundColor: Colors.green,
            ),
          );
          context.pop(); // Go back to the previous screen on success.
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
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.editProfile),
        backgroundColor: Theme.of(context).colorScheme.surface,
        actions: [
          // The save button shows a loading indicator when the profile is being saved.
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
                        // Display the newly selected image, the existing network image, or initials.
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
                                  // TODO(ux): Add a loading builder and error builder for the network image.
                                ),
                              )
                            : Text(
                                profile.name.isNotEmpty
                                    ? profile.name[0].toUpperCase()
                                    : 'E',
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

                // Personal Information Section
                _SectionTitle(l10n.personalInformation),
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
                  controller: companyNameController,
                  label: l10n.companyName,
                  icon: Icons.business_outlined,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return l10n.companyNameIsRequired;
                    }
                    return null;
                  },
                ),

                SizedBox(height: 4.h),

                // Contact Information Section
                _SectionTitle(l10n.contactInformation),
                SizedBox(height: 2.h),

                _FormField(
                  controller: phoneController,
                  label: l10n.phoneNumber,
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  hintText: '+1 (555) 123-4567',
                ),

                SizedBox(height: 3.h),

                _FormField(
                  controller: locationController,
                  label: l10n.location,
                  icon: Icons.location_on_outlined,
                  hintText: l10n.cityState,
                ),

                SizedBox(height: 3.h),

                _FormField(
                  controller: websiteController,
                  label: l10n.website,
                  icon: Icons.language_outlined,
                  keyboardType: TextInputType.url,
                  hintText: 'https://www.company.com',
                  // TODO(validation): Add a URL validator.
                ),

                SizedBox(height: 4.h),

                // Company Information Section
                _SectionTitle(l10n.companyInformation),
                SizedBox(height: 2.h),

                _FormField(
                  controller: companyDescriptionController,
                  label: l10n.companyDescription,
                  icon: Icons.info_outline,
                  maxLines: 4,
                  hintText: l10n.describeYourCompany,
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

/// A reusable widget for displaying a section title.
class _SectionTitle extends StatelessWidget {
  /// The text to display as the title.
  final String title;

  /// Creates a [_SectionTitle].
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

/// A reusable, styled [TextFormField] for the profile editing form.
class _FormField extends StatelessWidget {
  /// The controller for the text field.
  final TextEditingController controller;

  /// The label text for the form field.
  final String label;

  /// The icon to display before the text field.
  final IconData icon;

  /// The hint text to display when the field is empty.
  final String? hintText;

  /// The maximum number of lines for the text field.
  final int maxLines;

  /// The keyboard type for the text field.
  final TextInputType? keyboardType;

  /// The validation function for the text field.
  final String? Function(String?)? validator;

  /// Creates a [_FormField].
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
