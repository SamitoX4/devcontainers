# DevContainers Templates

Collection of **development container templates** for different technologies.

This repository contains ready-to-use development environments based on **Docker** and **VS Code Dev Containers**.

Each template provides:

-   Isolated environment
-   Reproducible setup
-   Easy launch
-   Pre-configured tools

## Available Templates

| Template | Description |
|----------|-------------|
| `nodejs` | Node.js with TypeScript, npm/pnpm |
| `android` | Java 17 + Android SDK |
| `react-native` | Node.js + React Native + Android SDK |
| `java` | Java 17 + Maven |
| `laravel` | PHP 8.3 + Composer |
| `rust` | Rust (stable) + Cargo |
| `go` | Go 1.22 |
| `python` | Python 3.12 |

## Quick Start

### Using the CLI (Recommended)

Install the CLI:

```bash
curl -fsSL https://samitox4.github.io/devc/install.sh | bash
```

Generate a devcontainer:

```bash
devc gen
# Interactive mode - just follow the prompts

# Or with flags
devc gen --template nodejs --name my-project
```

See [devc CLI](https://github.com/SamitoX4/devc) for more information.

### Manual Setup

1. Open your project folder:

```bash
cd mi-proyecto
```

2. Copy the template:

```bash
cp -r templates/nodejs/.devcontainer .devcontainer
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
-   `.devcontainer/Dockerfile` - Container image
-   `.devcontainer/scripts/` - Setup scripts

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
