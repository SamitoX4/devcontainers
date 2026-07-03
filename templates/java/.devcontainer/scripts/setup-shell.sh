#!/bin/bash
set -e

REMOTE_USER="${REMOTE_USER:-node}"
USER_HOME="/home/${REMOTE_USER}"

# Asegurar que existe el home (por si se ejecuta antes de crear el usuario)
mkdir -p "${USER_HOME}"

# Configuración para zsh (shell por defecto del devcontainer)
cat >> "${USER_HOME}/.zshrc" <<'EOF'
# ----- Java / Maven -----
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
export MAVEN_HOME=/opt/maven
export PATH="\$PATH:\$MAVEN_HOME/bin:\$JAVA_HOME/bin"
EOF

# También dejarlo en .bashrc por compatibilidad
echo 'export PATH=$PATH:$HOME/.local/bin' >> "${USER_HOME}/.bashrc"
echo 'export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64' >> "${USER_HOME}/.bashrc"
echo 'export MAVEN_HOME=/opt/maven' >> "${USER_HOME}/.bashrc"
echo 'export PATH=$PATH:$MAVEN_HOME/bin:$JAVA_HOME/bin' >> "${USER_HOME}/.bashrc"
