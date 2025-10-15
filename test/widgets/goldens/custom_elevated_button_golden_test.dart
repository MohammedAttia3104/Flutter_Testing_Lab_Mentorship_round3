import 'dart:io';

import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_testing_lab/core/widgets/custom_elevated_button.dart';

import '../../test_utils/test_wrapper.dart';

void main() {
  if (Platform.isAndroid || Platform.isIOS) {
    goldenTest(
      'CustomElevatedButton - default and disabled states',
      fileName: 'custom_elevated_button_states',
      builder: () => GoldenTestGroup(
        columns: 2,
        children: [
          GoldenTestScenario(
            name: 'Enabled state',
            child: TestWrapper(
              child: CustomElevatedButton(
                onPressed: () {},
                child: const Text('Register'),
              ),
            ),
          ),

          GoldenTestScenario(
            name: 'Disabled state',
            child: TestWrapper(
              child: CustomElevatedButton(
                onPressed: null,
                child: const Text('Register'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
