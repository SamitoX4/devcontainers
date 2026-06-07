# DevContainers Templates

Collection of **development container templates** for different technologies.

This repository contains ready-to-use development environments based on **Docker** and **VS Code Dev Containers**.

Each template provides:

-   Isolated environment
-   Reproducible setup
-   Easy launch
-   Pre-configured tools

## Available Templates

### General

| Template | Description | Customizable Versions | Default Security Mode |
|----------|-------------|----------------------|----------------------|
| `nodejs` | Node.js with TypeScript, npm/pnpm | Node versions (multi-select), Base image variant | `developer` (user: `node`) |
| `java` | Java 17 + Maven | Java version, Maven version | `developer` (user: `developer`) |
| `laravel` | PHP 8.3 + Composer | PHP version | `developer` (user: `developer`) |
| `rust` | Rust (stable) + Cargo | Rust toolchain | `developer` (user: `developer`) |
| `go` | Go 1.22 | Go version | `developer` (user: `developer`) |
| `python` | Python 3.12 + pip | Python version | `developer` (user: `developer`) |

### Database Services

| Template | Description | Customizable Versions | Default Security Mode |
|----------|-------------|----------------------|----------------------|
| `mysql` | MySQL 8.0 standalone service on shared network | — | — |
| `postgre` | PostgreSQL 16 standalone service on shared network | — | — |

### Android Stack

| Template | Description | Customizable Versions | Default Security Mode |
|----------|-------------|----------------------|----------------------|
| `android/java` | Java 17 + Android SDK | API Level, Build Tools, NDK, CMD Line Tools | `root` |
| `android/kotlin-native` | Kotlin/Native + Android SDK | Kotlin, API Level, Build Tools, NDK, CMD Line Tools | `root` |
| `android/ndk` | Android NDK + CMake | API Level, Build Tools, NDK, CMake, CMD Line Tools | `root` |
| `android/react-native` | Node.js + React Native + Android SDK | Node version, API Level, Build Tools, NDK, CMD Line Tools | `developer` (user: `node`) |
| `android/flutter` | Flutter + Android SDK | Flutter branch, API Level, Build Tools, NDK, CMD Line Tools | `root` |

### Security Modes

| Mode | remoteUser | sudo | Use Case |
|------|-----------|------|----------|
| `developer` | Dedicated dev user | `NOPASSWD:ALL` | Recommended balance of security & productivity |
| `secure` | Dedicated dev user | `none` | Maximum security; install packages via Dockerfile only |
| `root` | `root` | N/A | Administrative tasks, Android SDK access |
| `custom` | Configurable | Configurable | Full control over all settings |

All modes generate **random secure passwords** by default (displayed once after generation).

Optionally, you can save them to a JSON file with owner-only permissions (600):

```bash
devc gen --template nodejs --name my-project --save-credentials default
```

This creates `~/.devc/credentials/my_project.json`.

## Quick Start

### Using the CLI (Recommended)

Install the CLI:

```bash
curl -fsSL https://samitox4.github.io/devc/install.sh | bash
```

Generate a devcontainer interactively:

```bash
devc gen
# Follow the prompts to select template, name, and optional versions
```

Or with flags:

```bash
devc gen --template nodejs --name my-project
devc gen --template android/kotlin-native --name my-native-app
```

See [devc CLI](https://github.com/SamitoX4/devc) for more information.

### Manual Setup

1. Open your project folder:

```bash
cd mi-proyecto
```

2. Copy the template:

```bash
# General templates
cp -r templates/nodejs/.devcontainer .devcontainer

# Nested Android templates
cp -r templates/android/kotlin-native/.devcontainer .devcontainer
cp -r templates/android/flutter/.devcontainer .devcontainer
```

3. Open in VS Code and press `F1` → `Dev Containers: Reopen in Container`

## Requirements

-   Docker
-   Visual Studio Code
-   VS Code Dev Containers Extension

Extension ID: `ms-vscode-remote.remote-containers`

## Template Structure

Each template includes:

-   `.devcontainer/devcontainer.json` - VS Code configuration
-   `.devcontainer/docker-compose.yml` - Container services
-   `.devcontainer/Dockerfile` - Container image (supports parameterized versions via `ARG`)
-   `.devcontainer/scripts/` - Setup scripts

## Parameterized Versions

Templates support **customizable versions** via Docker `ARG`s. When using `devc gen` interactively, you can pick versions from a curated list. You can also override them manually:

```bash
# Using docker compose build args
docker compose -f .devcontainer/docker-compose.yml build --build-arg ANDROID_API_LEVEL=36 --build-arg KOTLIN_VERSION=2.1.0

# Or set environment variables before building
export ANDROID_API_LEVEL=36
export BUILD_TOOLS_VERSION=36.0.0
export PYTHON_VERSION=3.13
export GO_VERSION=1.23.0
docker compose -f .devcontainer/docker-compose.yml build
```

Available parameters per template are documented in the table above.

## Shared Tools

All templates include:

-   **Doppler** - Environment variables management
-   **gcloud** - Google Cloud CLI
-   **opencode** - AI coding assistant
-   **claude-ai** - Claude AI CLI
-   **Zsh + Oh My Zsh** - Enhanced shell

## Git Configuration

The devcontainer will use your Git user configured in the CLI. If setting up manually, the following environment variables are used:

```bash
GIT_USER_NAME=your-name
GIT_USER_EMAIL=your-email@example.com
```

## License

MIT
