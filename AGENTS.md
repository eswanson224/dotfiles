# Repository guidance

## Project overview

This is a personal NixOS and Home Manager flake. Each NixOS configuration
attribute matches the machine's `networking.hostName`:

- `teacherbearcat`: Lenovo Legion laptop.
- `maniceraser`: desktop PC.

## Engineering standard

- Engineer for the best long-term result, not merely the smallest diff or the
  behavior of the current checkout.
- Treat existing code and configuration as evidence, not as the specification.
  Determine the intended outcome before preserving an existing pattern.
- Prefer established best practices and coherent architecture. When the current
  implementation conflicts with authoritative guidance, identify the conflict
  and recommend or implement the better design.
- For architectural or operational decisions, distinguish between:
  1. the preferred design,
  2. constraints imposed by the current system, and
  3. the safest practical migration path.
- Evaluate meaningful alternatives in terms of correctness, security,
  reliability, maintainability, operational complexity, and migration risk.
  State material tradeoffs instead of silently choosing the most convenient
  option.
- Preserve an existing pattern only when it is intentional and justified, or
  when changing it would introduce disproportionate risk.
- Do not infer intent solely from code produced by earlier assistant changes.
  Re-evaluate that code against the user's stated goal and authoritative
  guidance.
- If the user's request or cited guidance suggests a broader design than the
  current implementation, investigate that design before recommending removal
  of apparently unused components.

## NixOS practices

- Validate NixOS service and option recommendations against current official
  NixOS documentation and, when relevant, the upstream project's documentation.
- Avoid editing generated hardware configuration unless the change genuinely
  describes hardware, filesystems, or boot-time mounts. Keep intentional manual
  additions clearly structured so regeneration risk is apparent.
- Preserve unrelated local changes. This repository may have a dirty worktree.
- Format and evaluate changed Nix code with the repository's existing tooling
  when practical. Run focused checks first, then broader flake checks when the
  change and available environment warrant them.
- Never perform an activation, deployment, filesystem migration, destructive
  storage operation, or data move without explicit user authorization.

## Build and apply

- Apply the configuration with `nh os switch`. This is the installed wrapper
  for `sudo nixos-rebuild switch --flake .#<hostname>`.
- Do not apply or switch a configuration unless the user explicitly requests
  it. Building and checking are non-activating verification steps.
- Dry-check a host with `nixos-rebuild build --flake .#<hostname>`.
- Run `nix flake check` for the broader flake checks, including formatting.
- Prefer checking only the affected host first when that provides faster,
  useful feedback, then run the broader check when warranted.

## Formatting

- Run `nix fmt` before committing. The repository uses treefmt with nixfmt.
- `nix flake check` includes `checks.formatting` and fails when tracked source
  files are not formatted.

## Repository layout

- `hosts/teacherbearcat/` contains laptop-specific configuration, including
  `configuration.nix`, `hardware-configuration.nix`, `home.nix`, `mounts.nix`,
  and `packages.nix`.
- `hosts/maniceraser/` contains desktop-specific configuration. Generate its
  `hardware-configuration.nix` on the desktop before installation.
- Keep host-specific configuration under `hosts/` and reusable configuration
  under `modules/`.
- `modules/nixos/` contains system modules; `modules/home-manager/` contains
  user modules.
- Home Manager is integrated as a NixOS module in `flake.nix`, so a full NixOS
  rebuild applies both the system and Home Manager configuration.
- Group modules by concern, such as `base/`, `profiles/desktop/`, `desktop/`,
  `terminal/`, `services/`, and `utils/`. Wire them through `imports` in a
  relevant `default.nix` or host configuration.

## Communication

- Lead with the recommended design and explain any constraints that prevent it.
- Call out uncertainty and verify facts that are current, architectural,
  security-sensitive, or operationally consequential.
- When a best-practice design requires migration, do not present the migration
  as already safe: identify prerequisites, backup needs, rollback considerations,
  and verification steps.
