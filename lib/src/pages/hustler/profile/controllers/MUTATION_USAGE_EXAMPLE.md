# Enhanced EditHustlerProfileController Usage Guide

## Overview

The `EditHustlerProfileController` now uses `riverpod_community_mutation` for better state management. This provides automatic handling of idle, loading, success, and error states.

## Key Benefits

### ✅ Automatic State Management
- **Idle**: No operation in progress
- **Loading**: Operation in progress (shows loading indicators)
- **Success**: Operation completed successfully
- **Error**: Operation failed with detailed error information

### ✅ Better User Experience
- Real-time feedback for all operations
- Proper loading states
- Error handling with specific messages
- Success confirmations

### ✅ Cleaner Code
- No manual state management
- Automatic UI updates
- Consistent error handling

## Usage Examples

### 1. Basic UI State Handling

```dart
class EditProfilePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(editHustlerProfileControllerProvider);
    final controllerNotifier = ref.read(editHustlerProfileControllerProvider.notifier);

    return Scaffold(
      body: Column(
        children: [
          // Upload Profile Image Button
          ElevatedButton(
            onPressed: controller.isLoading ? null : () async {
              // Pick image file
              final file = await pickImageFile();
              if (file != null) {
                await controllerNotifier.uploadProfileImage(uid, file);
              }
            },
            child: controller.map(
              idle: () => Text('Upload Profile Image'),
              loading: () => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  SizedBox(width: 8),
                  Text('Uploading...'),
                ],
              ),
              data: (_) => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check, color: Colors.green),
                  SizedBox(width: 8),
                  Text('Image Uploaded'),
                ],
              ),
              error: (error, _) => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.error, color: Colors.red),
                  SizedBox(width: 8),
                  Text('Upload Failed'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
```

### 2. Advanced State Handling with Callbacks

```dart
class SaveProfileButton extends ConsumerWidget {
  final Hustler original;
  final Hustler updated;

  const SaveProfileButton({
    super.key,
    required this.original,
    required this.updated,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(editHustlerProfileControllerProvider);
    final controllerNotifier = ref.read(editHustlerProfileControllerProvider.notifier);

    // Listen for state changes to show snackbars
    ref.listen(editHustlerProfileControllerProvider, (previous, next) {
      next.whenOrNull(
        data: (_) {
          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Profile updated successfully!'),
              backgroundColor: Colors.green,
            ),
          );
          // Navigate back or perform other success actions
          Navigator.of(context).pop();
        },
        error: (error, stackTrace) {
          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to update profile: ${error.toString()}'),
              backgroundColor: Colors.red,
              action: SnackBarAction(
                label: 'Retry',
                onPressed: () {
                  // Retry the operation
                  controllerNotifier.saveProfile(original, updated);
                },
              ),
            ),
          );
        },
      );
    });

    return ElevatedButton(
      onPressed: controller.isLoading
          ? null
          : () => controllerNotifier.saveProfile(original, updated),
      child: controller.when(
        idle: () => Text('Save Profile'),
        loading: () => SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
        data: (_) => Text('Save Profile'),
        error: (_, __) => Text('Save Profile'),
      ),
    );
  }
}
```

### 3. File Upload with Progress Indication

```dart
class CertificationUploadWidget extends ConsumerWidget {
  final String uid;
  
  const CertificationUploadWidget({super.key, required this.uid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(editHustlerProfileControllerProvider);
    final controllerNotifier = ref.read(editHustlerProfileControllerProvider.notifier);

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Upload Certification',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 16),
            
            // Upload button with state indication
            ElevatedButton.icon(
              onPressed: controller.isLoading
                  ? null
                  : () async {
                      final files = await pickCertificationFiles();
                      for (final file in files) {
                        final fileName = file.path.split('/').last;
                        await controllerNotifier.uploadCertification(
                          uid, 
                          file, 
                          fileName,
                        );
                      }
                    },
              icon: controller.when(
                idle: () => Icon(Icons.upload_file),
                loading: () => SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                data: (_) => Icon(Icons.check_circle, color: Colors.green),
                error: (_, __) => Icon(Icons.error, color: Colors.red),
              ),
              label: controller.when(
                idle: () => Text('Choose Files'),
                loading: () => Text('Uploading...'),
                data: (_) => Text('Upload Complete'),
                error: (error, _) => Text('Upload Failed'),
              ),
            ),
            
            // Show error details if upload fails
            controller.whenOrNull(
              error: (error, stackTrace) => Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text(
                  error.toString(),
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
              ),
            ) ?? SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
```

### 4. Comprehensive Form with Multiple Operations

```dart
class EditProfileForm extends ConsumerStatefulWidget {
  final Hustler profile;

  const EditProfileForm({super.key, required this.profile});

  @override
  ConsumerState<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends ConsumerState<EditProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _bioController = TextEditingController();
  
  File? _selectedImage;
  List<File> _selectedCertifications = [];

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.profile.name;
    _bioController.text = widget.profile.bio ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(editHustlerProfileControllerProvider);
    final controllerNotifier = ref.read(editHustlerProfileControllerProvider.notifier);

    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Profile Image Section
          GestureDetector(
            onTap: controller.isLoading ? null : _pickProfileImage,
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: _selectedImage != null
                      ? FileImage(_selectedImage!)
                      : widget.profile.photoUrl != null
                          ? NetworkImage(widget.profile.photoUrl!)
                          : null,
                  child: widget.profile.photoUrl == null && _selectedImage == null
                      ? Icon(Icons.person, size: 50)
                      : null,
                ),
                // Loading overlay for image upload
                if (controller.isLoading)
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          
          SizedBox(height: 16),
          
          // Form fields
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Name',
              enabled: !controller.isLoading,
            ),
            validator: (value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Name is required';
              }
              return null;
            },
          ),
          
          SizedBox(height: 16),
          
          TextFormField(
            controller: _bioController,
            decoration: InputDecoration(
              labelText: 'Bio',
              enabled: !controller.isLoading,
            ),
            maxLines: 3,
          ),
          
          SizedBox(height: 24),
          
          // Save button with comprehensive state handling
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: controller.isLoading ? null : _saveProfile,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: controller.when(
                  idle: () => Text(
                    'Save Profile',
                    style: TextStyle(fontSize: 16),
                  ),
                  loading: () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                      SizedBox(width: 12),
                      Text('Saving...', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  data: (_) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check, color: Colors.white),
                      SizedBox(width: 8),
                      Text('Saved!', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  error: (error, _) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline, color: Colors.white),
                      SizedBox(width: 8),
                      Text('Save Failed - Tap to Retry', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          
          // Error display
          controller.whenOrNull(
            error: (error, stackTrace) => Padding(
              padding: EdgeInsets.only(top: 16),
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.shade100,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red.shade300),
                ),
                child: Row(
                  children: [
                    Icon(Icons.error_outline, color: Colors.red.shade700),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Error: ${error.toString()}',
                        style: TextStyle(
                          color: Colors.red.shade700,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ) ?? SizedBox.shrink(),
        ],
      ),
    );
  }

  Future<void> _pickProfileImage() async {
    // Implementation for picking image
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;
    
    final controllerNotifier = ref.read(editHustlerProfileControllerProvider.notifier);
    
    try {
      // Upload profile image if selected
      if (_selectedImage != null) {
        await controllerNotifier.uploadProfileImage(
          widget.profile.uid,
          _selectedImage!,
        );
      }
      
      // Upload certifications if any
      for (final cert in _selectedCertifications) {
        final fileName = cert.path.split('/').last;
        await controllerNotifier.uploadCertification(
          widget.profile.uid,
          cert,
          fileName,
        );
      }
      
      // Create updated profile
      final updatedProfile = widget.profile.copyWith(
        name: _nameController.text.trim(),
        bio: _bioController.text.trim().isEmpty 
            ? null 
            : _bioController.text.trim(),
      );
      
      // Save profile
      await controllerNotifier.saveProfile(widget.profile, updatedProfile);
      
    } catch (e) {
      // Error handling is done automatically by the mutation
      // The UI will show error state and allow retry
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    super.dispose();
  }
}
```

## Key Features

### 1. **Automatic State Transitions**
- The controller automatically transitions between idle → loading → success/error
- No need to manually manage loading states

### 2. **Error Handling**
- Comprehensive error information is provided
- Easy to show error messages and retry options
- Errors are automatically caught and exposed through the state

### 3. **Loading Indicators**
- Built-in loading state detection with `controller.isLoading`
- Easy to disable buttons and show progress indicators

### 4. **Success Feedback**
- Success state is automatically set when operations complete
- Easy to show success messages and navigate to next screen

### 5. **Reactive UI Updates**
- UI automatically updates based on controller state
- Use `ref.listen()` for side effects like showing snackbars

## Best Practices

1. **Always check `controller.isLoading`** before allowing user interactions
2. **Use `ref.listen()`** for side effects like navigation and notifications
3. **Provide retry mechanisms** in error states
4. **Show appropriate loading indicators** during operations
5. **Display meaningful error messages** to help users understand issues

## Migration from Old Controller

### Before (Manual State Management):
```dart
// Manual loading state
bool isLoading = false;

// Manual error handling
try {
  setState(() => isLoading = true);
  await controller.uploadImage();
  setState(() => isLoading = false);
  // Show success message
} catch (e) {
  setState(() => isLoading = false);
  // Show error message
}
```

### After (Automatic with Mutation):
```dart
// Automatic state management
final controller = ref.watch(editHustlerProfileControllerProvider);

// UI automatically updates based on state
controller.when(
  idle: () => Text('Ready'),
  loading: () => CircularProgressIndicator(),
  data: (_) => Icon(Icons.check),
  error: (error, _) => Text('Error: $error'),
)
```

This approach provides a much cleaner, more maintainable, and user-friendly experience.
