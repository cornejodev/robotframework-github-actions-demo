#!/bin/bash

find . -type f \( -name "*.resource" -o -name "*.robot" \) -exec robotidy \
-c AddMissingEnd:enabled=True \
-c NormalizeSeparators:enabled=True \
-c DiscardEmptySections:enabled=True \
-c MergeAndOrderSections:enabled=True \
-c RemoveEmptySettings:enabled=True \
-c NormalizeAssignments:enabled=True:equal_sign_type=equal_sign:skip_sections=variable \
-c OrderSettings:enabled=True \
-c OrderSettingsSection:enabled=True:imports_order=library,resource,variables:settings_order=suite_setup,suite_teardown,test_setup,test_teardown,test_timeout,test_template:new_lines_between_groups=2 \
-c NormalizeTags:enabled=True \
-c AlignSettingsSection:enabled=True \
-c AlignVariablesSection:enabled=True \
-c NormalizeNewLines:enabled=True \
-c NormalizeSectionHeaderName:enabled=True \
-c NormalizeSettingName:enabled=True \
-c ReplaceRunKeywordIf:enabled=True \
-c SplitTooLongLine:enabled=True:split_on_every_arg=True:split_on_every_setting_arg=True \
-c ReplaceBreakContinue:enabled=True \
-c InlineIf:enabled=True \
-c AlignTestCasesSection:enabled=True:alignment_type=fixed:handle_too_long=overflow \
-c AlignKeywordsSection:enabled=True:alignment_type=fixed:handle_too_long=overflow \
-c RenameKeywords:enabled=True \
-c RenameTestCases:enabled=True:capitalize_each_word=True \
-c RenameVariables:enabled=True \
--line-length 50 --indent 4 --spacecount 4 {} \;
