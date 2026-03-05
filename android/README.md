# Android, Java & React Native DevContainer

## Summary

Development environment for **React Native and Android applications**
using **Docker Dev Containers** and **VS Code Remote Containers**.

The container provides a fully configured environment with:

-   Node.js
-   Java (JDK 17) required for Android builds
-   React Native tooling
-   Android SDK / Gradle support
-   Zsh terminal configuration
-   Preinstalled VS Code extensions for frontend and mobile development

This setup ensures a consistent development environment across machines
and avoids common Android build issues related to Java or SDK
mismatches.

------------------------------------------------------------------------

# Metadata

  Metadata           Value
  ------------------ ------------------------------
  Container Type     Docker DevContainer
  Base Environment   Node.js
  Java Runtime       OpenJDK 17
  Shell              Zsh
  IDE Integration    VS Code Remote Containers
  Languages          JavaScript, TypeScript, Java
  Frameworks         React Native
  Container OS       Linux

------------------------------------------------------------------------

# Project Structure

    .devcontainer/
     ├─ devcontainer.json
     ├─ docker-compose.yml
     └─ scripts/
         └─ configure-system.sh

  File                  Description
  --------------------- --------------------------------------------------
  devcontainer.json     Main configuration for the development container
  docker-compose.yml    Defines the container services
  configure-system.sh   Script executed after container creation

------------------------------------------------------------------------

# Container Configuration

The development container is configured with:

-   Service name: `app`
-   Workspace folder: `/workspaces`
-   Default user: `node`
-   Timezone: `America/Lima`
-   Java runtime: OpenJDK 17

Example configuration:

``` json
{
  "service": "app",
  "workspaceFolder": "/workspaces",
  "remoteUser": "node"
}
```

------------------------------------------------------------------------

# VS Code Extensions

The container automatically installs useful extensions for development.

### Development

-   ESLint
-   Prettier
-   ES7 React Snippets
-   Better Comments
-   Version Lens

### React / Frontend

-   React Snippets
-   GraphQL Tools
-   Turbo Console Log

### Docker

-   Docker extension
-   Better Dockerfile syntax

### Git

-   Git Graph
-   GitHub Pull Requests

### Visual Improvements

-   Material Icon Theme
-   Tokyo Night Theme
-   Error Lens

These extensions are installed automatically when the container is
created.

------------------------------------------------------------------------

# Terminal Configuration

The container uses **Zsh as the default shell**.

Available shells:

  Shell   Path
  ------- -------------
  Zsh     `/bin/zsh`
  Bash    `/bin/bash`

------------------------------------------------------------------------

# Android & Java Environment

Android builds require Java and Gradle.

This container includes:

-   OpenJDK 17
-   Android SDK tools
-   Gradle support for React Native

Java version can be verified inside the container:

    java -version

Expected output:

    openjdk version "17"

------------------------------------------------------------------------

# Post Creation Script

After the container is built, the following script runs automatically:

    .devcontainer/scripts/configure-system.sh

Configured in:

``` json
"postCreateCommand": "sh .devcontainer/scripts/configure-system.sh"
```

------------------------------------------------------------------------

# Getting Started

### 1 Open the project in VS Code

Open the root folder.

### 2 Reopen in Container

Press `F1` and run:

    Dev Containers: Reopen in Container

VS Code will:

1.  Build the Docker container
2.  Install extensions
3.  Execute the setup script
4.  Mount the project in `/workspaces`

### 3 Start development

Install dependencies:

    pnpm install

Run the Android app:

    pnpm android

or

    npx react-native run-android

------------------------------------------------------------------------

# Environment Variables

The container defines:

    TZ=America/Lima

This ensures logs and tools use the correct timezone.

------------------------------------------------------------------------

# Customization

You can customize the container by editing:

    .devcontainer/devcontainer.json

Example:

### Forward Ports

``` json
"forwardPorts": [3000]
```

### Add Extensions

``` json
"extensions": [
  "ms-vscode.vscode-typescript-next"
]
```

------------------------------------------------------------------------

# Requirements

To use this setup you need:

-   Docker
-   VS Code
-   Dev Containers Extension

Extension:

    ms-vscode-remote.remote-containers

------------------------------------------------------------------------

# Advantages

✔ Consistent development environment\
✔ No local Android / Node / Java setup required\
✔ Avoids Java version conflicts with Gradle\
✔ Easy onboarding for developers\
✔ Reproducible builds\
✔ Compatible with GitHub Codespaces