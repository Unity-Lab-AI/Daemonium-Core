---
title: Running Daemonium-Core without Internet
description: How to run Daemonium-Core without Internet
keywords: [no internet, air-gapped, local model]
---

Daemonium-Core can be run even on an air-gapped computer if you use a local model. Only a few adjustments are required for this to work.

1. Download the latest .vsix file from the [Open VSX Registry](https://open-vsx.org/extension/Daemonium-Core/daemonium-core) and [install it to VS Code](https://code.visualstudio.com/docs/editor/extension-marketplace#_install-from-a-vsix).
2. Open `~/.daemonium-core/config.json` and set `"allowAnonymousTelemetry": false`. This will stop Daemonium-Core from attempting requests to PostHog for [anonymous telemetry](../../telemetry.md).
3. Also in `config.json`, set the default model to a local model. You can available options [here](../model-providers/).
4. Restart VS Code to ensure that the changes to `config.json` take effect.
