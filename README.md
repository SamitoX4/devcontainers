# DevContainers

Collection of **development containers** for different technologies and
stacks.

This repository provides **ready-to-use development environments** based
on **Docker** and **VS Code Dev Containers**.\
The goal is to allow developers to start working quickly without
installing complex local dependencies.

Each environment is:

-   Isolated
-   Reproducible
-   Easy to launch
-   Ready for collaboration

Over time, additional development environments will be added to support
more technologies and workflows.

------------------------------------------------------------------------

# Available Environments

  -----------------------------------------------------------------------
  Environment                         Description
  ----------------------------------- -----------------------------------
  `android-react-native`              React Native + Android development
                                      environment with Node.js and Java

  -----------------------------------------------------------------------

Future environments may include:

-   Next.js
-   Node.js APIs
-   NestJS
-   PostgreSQL
-   Redis
-   Python
-   Golang
-   Fullstack environments

------------------------------------------------------------------------

# Repository Structure

    devcontainers/
    │
    ├─ android-react-native/
    │   ├─ .devcontainer/
    │   └─ README.md
    │
    └─ README.md

Each environment folder contains its own:

-   DevContainer configuration
-   Docker configuration
-   Setup scripts
-   Documentation

------------------------------------------------------------------------

# Requirements

To use these environments you need:

-   Docker
-   Visual Studio Code
-   VS Code Dev Containers Extension

Extension ID:

    ms-vscode-remote.remote-containers

------------------------------------------------------------------------

# How to Use a DevContainer

### 1 Clone the repository

    git clone https://github.com/YOUR_USERNAME/devcontainers.git

### 2 Open the desired environment

Example:

    devcontainers/android-react-native

Open that folder with **VS Code**.

------------------------------------------------------------------------

### 3 Reopen inside the container

Press:

    F1

Run:

    Dev Containers: Reopen in Container

VS Code will automatically:

1.  Build the container
2.  Install required extensions
3.  Configure the development environment
4.  Mount the workspace

------------------------------------------------------------------------

# Adding New Environments

New environments can be added as separate folders.

Example:

    devcontainers/
       android-react-native/
       nextjs/
       node-api/
       postgres/
       python/

Typical structure for a new environment:

    environment-name/
       .devcontainer/
       Dockerfile
       docker-compose.yml
       README.md

Each environment should include its own documentation explaining how to
use it.

------------------------------------------------------------------------

# Why DevContainers?

Development containers provide:

✔ Reproducible environments\
✔ Easy onboarding for developers\
✔ Isolation of dependencies\
✔ No need to install SDKs locally\
✔ Consistent development across machines\
✔ Works with GitHub Codespaces

------------------------------------------------------------------------

# License

MIT