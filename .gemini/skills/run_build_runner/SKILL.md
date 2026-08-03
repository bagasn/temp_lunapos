---
name: run-build-runner
description: Runs the build_runner for Luna POS to generate DI, Retrofit, and JSON Serializable code.
---

# Luna POS Code Generation

When the user asks to "generate code", "run build runner", or if you have modified DI classes (`injectable`), network clients (`retrofit`), or data models (`json_serializable`), you MUST execute the code generator.

To generate code, run the following command in the project root:
`dart run build_runner build --delete-conflicting-outputs`
