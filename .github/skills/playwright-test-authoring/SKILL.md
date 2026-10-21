---
name: playwright-test-authoring
description: 'Create and improve browser tests with Playwright and TypeScript from a written prompt or recorded browser steps. Use Playwright codegen, implement tests in the existing project architecture (including playwright-bdd when present), run focused and full tests, and diagnose or fix flaky tests.'
argument-hint: 'Describe the browser scenario, app URL, and whether you have recorded steps or need help generating them.'
user-invocable: true
---

# Playwright Test Authoring

Create maintainable browser tests from user-provided requirements or Playwright Codegen recordings, then run and stabilize them within the repository's existing conventions.

## Workflow

1. **Understand the test request.** Identify the application URL, user-visible starting state, actions, expected outcomes, relevant credentials or test data, and target browser. Ask only for details that block a reliable test. Never put real credentials or secrets in source code; use the project's environment-variable or secret-management pattern.

2. **Inspect the local test architecture.** Read `package.json`, the Playwright config, nearby tests, fixtures, and page objects. Determine whether this project uses plain Playwright tests, `playwright-bdd`, or another established pattern. Preserve existing scripts, reporters, fixtures, naming, and configuration. For `playwright-bdd`, edit feature files and step/page-object source; do not edit generated specs.

3. **Capture browser steps when useful.** The user records the flow by running Playwright Codegen; Copilot then adapts the resulting code or steps and does not imply it has directly controlled the browser. Explain the command appropriate to the configured package manager, for example:
   ```sh
   npx playwright codegen https://example.test
   ```
   Ask the user to perform the flow and share the generated code or a concise ordered list of actions and expected results. Treat Codegen output as a draft, not finished tests. Do not assume the application URL or invent observed behavior.

4. **Turn the flow into a test.** Implement the smallest useful test in the existing architecture. Prefer role-, label-, and text-based locators; use stable test IDs when appropriate. Include meaningful assertions for outcomes, not just actions. Keep setup and cleanup explicit, isolate test data, and reuse existing page objects or fixtures where they fit. Do not add fixed sleeps to make a test pass.

5. **Run a focused check immediately.** Generate BDD specs first when required by the project, then run the narrowest matching test and the project typecheck or lint command if available. Read failures and diagnostics before broadening the run. Do not claim success when a command was skipped or blocked.

6. **Run the requested suite.** After the focused test passes, use the repository's documented test script and target project/browser. Check the report, screenshots, traces, and logs when a test fails. Keep existing reporting configuration intact unless the request requires changing it.

7. **Diagnose flakiness from evidence.** Reproduce the failure and inspect its trace, screenshot, console/network output, and timing. Classify the cause (for example, an unstable locator, missing state synchronization, shared test data, order dependence, external service instability, or resource contention). Fix the underlying cause using Playwright auto-waiting, a condition-based assertion/wait, isolated data, or explicit setup/cleanup. Avoid arbitrary timeouts, broad retries, and weakening assertions as substitutes for a fix.

8. **Verify stability.** Rerun the affected test, then repeat it when useful (for example, `--repeat-each=5`) and run the relevant suite. Use retries only as a diagnostic or as an existing CI policy, not as proof the flake is fixed. Confirm the result and report commands run, outcomes, and any remaining environmental limitation.

## Quality Checks

- Tests describe observable behavior and have assertions that can fail for the right reason.
- Selectors are resilient and the test does not rely on arbitrary delays.
- New code follows the current project architecture and does not edit generated output.
- Focused tests and relevant typecheck/lint checks pass; flaky fixes are rerun for repeatability.
- User-specific URLs, credentials, and test data are handled explicitly and safely.
