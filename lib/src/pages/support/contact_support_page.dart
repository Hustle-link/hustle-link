import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hustle_link/src/shared/shared.dart';

/// A comprehensive contact support page that displays all contact information
/// for HustleLink including email, phone, social media, and address.
/// This page provides multiple ways for users to get in touch with support.
class ContactSupportPage extends StatelessWidget {
  const ContactSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.contactSupport),
        backgroundColor: theme.colorScheme.surface,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header section with logo and welcome message
            _buildHeaderSection(context, l10n, theme),

            SizedBox(height: 4.h),

            // Contact methods section
            _buildContactMethodsSection(context, l10n, theme),

            SizedBox(height: 4.h),

            // Social media section
            _buildSocialMediaSection(context, l10n, theme),

            SizedBox(height: 4.h),

            // Office location section
            _buildLocationSection(context, l10n, theme),

            SizedBox(height: 4.h),

            // FAQ or help section
            _buildHelpSection(context, l10n, theme),
          ],
        ),
      ),
    );
  }

  /// Builds the header section with app branding and welcome message
  Widget _buildHeaderSection(
    BuildContext context,
    AppLocalizations l10n,
    ThemeData theme,
  ) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          children: [
            // Business logo/name
            Container(
              width: 20.w,
              height: 20.w,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(2.w),
              ),
              child: Icon(
                Icons.support_agent,
                size: 10.w,
                color: theme.colorScheme.primary,
              ),
            ),

            SizedBox(height: 2.h),

            Text(
              l10n.contactSupportBusinessName,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),

            SizedBox(height: 1.h),

            Text(
              l10n.contactSupportWelcomeMessage,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the contact methods section with email and phone
  Widget _buildContactMethodsSection(
    BuildContext context,
    AppLocalizations l10n,
    ThemeData theme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.contactMethods,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),

        SizedBox(height: 2.h),

        // Email contact
        _buildContactTile(
          context: context,
          icon: Icons.email,
          title: l10n.email,
          subtitle: l10n.contactSupportEmail,
          onTap: () => _launchEmail(context, l10n),
          onLongPress: () => _copyToClipboard(
            context,
            l10n.contactSupportEmail,
            l10n.emailCopied,
          ),
        ),

        SizedBox(height: 1.h),

        // Phone/WhatsApp contact
        _buildContactTile(
          context: context,
          icon: Icons.phone,
          title: l10n.contactSupportPhone,
          subtitle: l10n.contactSupportPhoneNumber,
          onTap: () => _launchPhone(context, l10n.contactSupportPhoneNumber),
          onLongPress: () => _copyToClipboard(
            context,
            l10n.contactSupportPhoneNumber,
            l10n.phoneCopied,
          ),
        ),

        SizedBox(height: 1.h),

        // WhatsApp contact
        _buildContactTile(
          context: context,
          icon: Icons.chat,
          title: l10n.whatsApp,
          subtitle: l10n.contactSupportPhoneNumber,
          onTap: () => _launchWhatsApp(context, l10n.contactSupportPhoneNumber),
          onLongPress: () => _copyToClipboard(
            context,
            l10n.contactSupportPhoneNumber,
            l10n.phoneCopied,
          ),
        ),
      ],
    );
  }

  /// Builds the social media section
  Widget _buildSocialMediaSection(
    BuildContext context,
    AppLocalizations l10n,
    ThemeData theme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.socialMedia,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),

        SizedBox(height: 2.h),

        // Facebook
        _buildContactTile(
          context: context,
          icon: Icons.facebook,
          title: l10n.facebook,
          subtitle: l10n.contactSupportFacebook,
          onTap: () => _launchSocialMedia(
            context,
            'https://facebook.com/profile.php?id=${l10n.contactSupportFacebook}',
          ),
        ),

        SizedBox(height: 1.h),

        // Instagram
        _buildContactTile(
          context: context,
          icon: Icons.camera_alt,
          title: l10n.instagram,
          subtitle: l10n.contactSupportInstagram,
          onTap: () => _launchSocialMedia(
            context,
            'https://${l10n.contactSupportInstagram}',
          ),
        ),

        SizedBox(height: 1.h),

        // TikTok
        _buildContactTile(
          context: context,
          icon: Icons.video_library,
          title: l10n.tikTok,
          subtitle: l10n.contactSupportTikTok,
          onTap: () => _launchSocialMedia(
            context,
            'https://${l10n.contactSupportTikTok}',
          ),
        ),
      ],
    );
  }

  /// Builds the office location section
  Widget _buildLocationSection(
    BuildContext context,
    AppLocalizations l10n,
    ThemeData theme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.officeLocation,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),

        SizedBox(height: 2.h),

        _buildContactTile(
          context: context,
          icon: Icons.location_on,
          title: l10n.address,
          subtitle: l10n.contactSupportAddress,
          onTap: () => _launchMaps(context, l10n.contactSupportAddress),
          onLongPress: () => _copyToClipboard(
            context,
            l10n.contactSupportAddress,
            l10n.addressCopied,
          ),
        ),
      ],
    );
  }

  /// Builds the help and FAQ section
  Widget _buildHelpSection(
    BuildContext context,
    AppLocalizations l10n,
    ThemeData theme,
  ) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.help_outline, color: theme.colorScheme.primary),
                SizedBox(width: 2.w),
                Text(
                  l10n.needHelp,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            SizedBox(height: 2.h),

            Text(
              l10n.contactSupportHelpText,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),

            SizedBox(height: 2.h),

            // Quick action buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _launchEmail(context, l10n),
                    icon: const Icon(Icons.email),
                    label: Text(l10n.sendEmail),
                  ),
                ),
                SizedBox(width: 2.w),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _launchWhatsApp(
                      context,
                      l10n.contactSupportPhoneNumber,
                    ),
                    icon: const Icon(Icons.chat),
                    label: Text(l10n.chatWhatsApp),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Builds a contact tile with icon, title, subtitle and tap actions
  Widget _buildContactTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    VoidCallback? onLongPress,
  }) {
    final theme = Theme.of(context);

    return Card(
      child: ListTile(
        leading: Container(
          width: 12.w,
          height: 12.w,
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(2.w),
          ),
          child: Icon(icon, color: theme.colorScheme.primary, size: 6.w),
        ),
        title: Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 4.w,
          color: theme.colorScheme.onSurfaceVariant,
        ),
        onTap: onTap,
        onLongPress: onLongPress,
      ),
    );
  }

  /// Launches email client with pre-filled support email
  Future<void> _launchEmail(BuildContext context, AppLocalizations l10n) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: l10n.contactSupportEmail,
      queryParameters: {'subject': l10n.contactSupportEmailSubject},
    );

    try {
      if (await canLaunchUrl(emailLaunchUri)) {
        await launchUrl(emailLaunchUri);
      } else {
        _showErrorSnackBar(context, l10n.emailClientNotAvailable);
      }
    } catch (e) {
      _showErrorSnackBar(context, l10n.emailClientNotAvailable);
    }
  }

  /// Launches phone dialer
  Future<void> _launchPhone(BuildContext context, String phoneNumber) async {
    final Uri phoneLaunchUri = Uri(scheme: 'tel', path: phoneNumber);

    try {
      if (await canLaunchUrl(phoneLaunchUri)) {
        await launchUrl(phoneLaunchUri);
      } else {
        _showErrorSnackBar(
          context,
          AppLocalizations.of(context).phoneDialerNotAvailable,
        );
      }
    } catch (e) {
      _showErrorSnackBar(
        context,
        AppLocalizations.of(context).phoneDialerNotAvailable,
      );
    }
  }

  /// Launches WhatsApp with pre-filled message
  Future<void> _launchWhatsApp(BuildContext context, String phoneNumber) async {
    final l10n = AppLocalizations.of(context);
    // Remove any formatting from phone number for WhatsApp
    final cleanPhone = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');
    final Uri whatsappUri = Uri.parse(
      'https://wa.me/$cleanPhone?text=${Uri.encodeComponent(l10n.whatsAppMessage)}',
    );

    try {
      if (await canLaunchUrl(whatsappUri)) {
        await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
      } else {
        _showErrorSnackBar(context, l10n.whatsAppNotAvailable);
      }
    } catch (e) {
      _showErrorSnackBar(context, l10n.whatsAppNotAvailable);
    }
  }

  /// Launches social media platforms
  Future<void> _launchSocialMedia(BuildContext context, String url) async {
    final Uri socialUri = Uri.parse(url);

    try {
      if (await canLaunchUrl(socialUri)) {
        await launchUrl(socialUri, mode: LaunchMode.externalApplication);
      } else {
        _showErrorSnackBar(
          context,
          AppLocalizations.of(context).socialMediaNotAvailable,
        );
      }
    } catch (e) {
      _showErrorSnackBar(
        context,
        AppLocalizations.of(context).socialMediaNotAvailable,
      );
    }
  }

  /// Launches maps application with location
  Future<void> _launchMaps(BuildContext context, String address) async {
    final Uri mapsUri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(address)}',
    );

    try {
      if (await canLaunchUrl(mapsUri)) {
        await launchUrl(mapsUri, mode: LaunchMode.externalApplication);
      } else {
        _showErrorSnackBar(
          context,
          AppLocalizations.of(context).mapsNotAvailable,
        );
      }
    } catch (e) {
      _showErrorSnackBar(
        context,
        AppLocalizations.of(context).mapsNotAvailable,
      );
    }
  }

  /// Copies text to clipboard and shows confirmation
  Future<void> _copyToClipboard(
    BuildContext context,
    String text,
    String confirmationMessage,
  ) async {
    await Clipboard.setData(ClipboardData(text: text));

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(confirmationMessage),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  /// Shows error snackbar
  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.error,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
