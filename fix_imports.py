#!/usr/bin/env python3
"""
Script to automatically fix unnecessary imports based on flutter analyze output.
"""

import os
import re

def fix_unnecessary_imports():
    """Fix unnecessary imports based on the patterns identified."""
    
    # Map of files and their unnecessary imports
    unnecessary_imports = {
        'lib/src/pages/employer/dashboard/employer_dashboard_page.dart': [
            "import 'package:hustle_link/src/shared/l10n/app_localizations.dart';"
        ],
        'lib/src/pages/employer/job_management/job_management_page.dart': [
            "import 'package:hustle_link/src/shared/l10n/app_localizations.dart';"
        ],
        'lib/src/pages/employer/profile/edit_employer_profile_page.dart': [
            "import 'package:hustle_link/src/pages/employer/profile/controllers/controllers.dart';",
            "import 'package:hustle_link/src/shared/l10n/app_localizations.dart';"
        ],
        'lib/src/pages/employer/profile/employer_profile_page.dart': [
            "import 'package:hustle_link/src/shared/l10n/app_localizations.dart';"
        ],
        'lib/src/pages/hustler/applications/hustler_applications_page.dart': [
            "import 'package:hustle_link/src/shared/l10n/app_localizations.dart';"
        ],
        'lib/src/pages/hustler/dashboard/hustler_dashboard_page.dart': [
            "import 'package:hustle_link/src/shared/l10n/app_localizations.dart';"
        ],
        'lib/src/pages/hustler/profile/edit_hustler_profile_page.dart': [
            "import 'package:hustle_link/src/pages/hustler/profile/controllers/controllers.dart';",
            "import 'package:hustle_link/src/shared/l10n/app_localizations.dart';"
        ],
        'lib/src/pages/hustler/profile/hustler_profile_page.dart': [
            "import 'package:hustle_link/src/shared/l10n/app_localizations.dart';"
        ],
        'lib/src/pages/language_selection/language_model.dart': [
            "import 'package:flutter/material.dart';"
        ],
        'lib/src/shared/services/orange_money_service.dart': [
            "import 'package:hooks_riverpod/hooks_riverpod.dart';"
        ],
        'lib/src/shared/services/subscription/subscription_access_service.dart': [
            "import 'package:flutter/foundation.dart';",
            "import 'package:hooks_riverpod/hooks_riverpod.dart';"
        ],
        'lib/src/shared/widgets/orange_money_payment_widget.dart': [
            "import 'package:hustle_link/src/shared/l10n/app_localizations.dart';"
        ],
        'lib/src/shared/widgets/subscription_widgets.dart': [
            "import 'package:hustle_link/src/shared/l10n/app_localizations.dart';"
        ]
    }
    
    project_root = r"C:\Users\happi\Documents\Business Projects\hustle_link"
    fixed_files = 0
    
    for file_path, imports_to_remove in unnecessary_imports.items():
        full_path = os.path.join(project_root, file_path.replace('/', '\\'))
        
        if not os.path.exists(full_path):
            print(f"File not found: {full_path}")
            continue
            
        try:
            with open(full_path, 'r', encoding='utf-8') as f:
                content = f.read()
            
            original_content = content
            
            for import_line in imports_to_remove:
                # Remove the import line and any trailing newline
                pattern = re.escape(import_line) + r'\s*\n?'
                content = re.sub(pattern, '', content)
            
            if content != original_content:
                with open(full_path, 'w', encoding='utf-8') as f:
                    f.write(content)
                print(f"Fixed unnecessary imports in: {file_path}")
                fixed_files += 1
                
        except Exception as e:
            print(f"Error processing {file_path}: {e}")
    
    print(f"Completed! Fixed unnecessary imports in {fixed_files} files.")

if __name__ == "__main__":
    fix_unnecessary_imports()