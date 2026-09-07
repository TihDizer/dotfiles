# NixOS Dotfiles

Personal NixOS and Home Manager configuration powered by Nix Flakes, `flake-parts`, and `flake-file` in a modular dendritic pattern.

---

## Architecture Overview

This repository uses a decentralized dendritic module structure. Modules are self-contained across NixOS and Home Manager boundaries, declaring their own flake inputs and exporting system or user configurations.

- **Flake Engine**: `flake-parts` with `flake-file` for automated flake outputs generation.
- **Host Management**: Centralized host definitions under `hosts/` utilizing reusable modules.
- **User Configurations**: Home Manager profiles organized in `users/`.
- **Secret Management**: Encrypted secrets via `sops-nix` with Age key authentication.
- **Theming**: System-wide unified styling via `stylix` (Everforest dark palette).

---

## Tech Stack & Components

### Core System
- **OS**: NixOS (Unstable channel)
- **Architecture**: `x86_64-linux`
- **Host**: `main` (AMD Ryzen 7 5700G + Radeon RX 5600/5700 series GPU)
- **GPU Control**: AMDGPU optimizations with `lact` daemon
- **Filesystems**: BTRFS and ext4 with tmpfiles management and swap hibernation support
- **Audio**: PipeWire audio stack managed via WirePlumber and `wiremix`

### Desktop & Window Management
- **Compositor**: [Niri](https://github.com/sodiboo/niri-flake) (scrollable-tiling Wayland compositor)
- **XWayland**: `xwayland-satellite`
- **App Launcher**: [Walker](https://github.com/abenz1267/walker) with [Elephant](https://github.com/abenz1267/elephant) desktop engine
- **Navigation & Widgets**:
  - `nirimap` (interactive minimap overview)
  - `niri-sidebar` (collapsible window manager sidebar)
  - `niri-autoselect-portal` for Wayland screencasting
- **Session & Lock**: `swaylock-effects`, `wlogout`, `sway-audio-idle-inhibit`
- **Wallpapers**: Automated `daily-art-wallpaper` service fetching daily high-resolution artwork from The Metropolitan Museum of Art API via `awww`.

### Shell & Terminal
- **Shells**: Zsh (default interactive shell), Fish, Bash
- **Terminal Emulator**: Kitty
- **Prompt**: Starship with custom status segments for normal shells and tmux
- **CLI Utilities**: `zoxide`, `eza`, `lsd`, `bat`, `ripgrep`, `fd`, `duf`, `dust`, `gping`, `httpie`, `tldr`, `television`, `yazi`, `bottom`

### Development Environment
- **Neovim**: Modular Neovim configured with [NVF](https://github.com/notashelf/nvf)
  - Languages: Nix (`nixd`), Rust (`rust-analyzer`), Python, Bash, Terraform, SQL, Typst, Markdown
  - Features: Blink-cmp completion, Treesitter, DAP debugging, Trouble diagnostics, Grug-far search, Yazi file manager integration, TV (Television) picker
- **Rust**: Pinned and nightly toolchains via `rust-overlay`, cargo tooling, JetBrains RustRover integration
- **AI Tooling**:
  - `jcode` built from source with OmniRoute AI gateway integration
  - `herdr` multi-agent runner via `llm-agents.nix`
  - `codex` and `antigravity-cli`
- **Editors**: Zed Editor, Neovim, RustRover

### Networking & Virtualization
- **Proxy & Routing**: `dae` (eBPF-based transparent proxy routing with GeoIP and domain routing rules)
- **Networking**: NetworkManager, SSH configurations, Cloudflared, Throne
- **Containers & Virtualization**: Podman, Docker, QEMU / KVM, OmniRoute AI Gateway container

### Productivity & Multimedia
- **Browser**: Google Chrome, Mozilla Firefox
- **Communication**: Telegram Desktop, Vesktop / Discord via `nixcord`
- **Knowledge Base**: Obsidian
- **Streaming & Gaming**: Sunshine (game streaming server configured for multi-monitor outputs), Steam, Prism Launcher, OBS Studio
- **Media**: MPV, Transmission BitTorrent client

---

## Repository Structure

```
.
├── flake.nix               # Flake entry point (auto-managed by flake-file)
├── flake.lock              # Locked dependencies
├── hosts/                  # Host definitions
│   └── main/               # Main desktop workstation configuration
├── modules/                # Modular feature components
│   ├── dev/                # Neovim (nvf), Rust, Zed, Nix, Jcode, Herdr
│   ├── networking/         # dae, networkmanager, ssh, firewall, throne
│   ├── niri/               # Niri Wayland compositor integrations
│   ├── shell/              # Shells (zsh, fish, bash), Kitty, Tmux, CLI tools
│   ├── system/             # Audio, Bluetooth, AMD GPU, bootloader, stylix
│   ├── utils/              # Television, MPV, archives
│   ├── virtualization/     # Podman, Docker, QEMU, OmniRoute container
│   ├── web-browsers/       # Firefox, Chrome
│   ├── nixcord.nix         # Vesktop Discord setup
│   ├── sunshine.nix        # Sunshine game streaming server
│   ├── steam.nix           # Gaming configuration
│   └── wallpaper.nix       # Met Museum daily art wallpaper engine
├── nix/                    # Internal flake helpers, lib functions, and tool wrappers
│   ├── flake-parts/        # Factory and dendritic flake builders
│   └── tools/              # Home-manager and sops-nix wrappers
├── secrets/                # Encrypted SOPS secrets (secrets.yaml)
├── templates/              # Module templates for easy expansion
└── users/                  # User home-manager environments
    ├── tihdizer/           # Primary user profile (Niri rules, starship, walker, git)
    └── guest/              # Guest user profile
```
