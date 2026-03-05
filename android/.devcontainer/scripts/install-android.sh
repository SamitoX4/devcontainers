#!/bin/bash
set -e

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}Iniciando instalación de Android SDK y dependencias...${NC}"

# Función para instalar paquetes si no existen
install_packages() {
    echo -e "${YELLOW}Instalando paquetes necesarios...${NC}"
    apt-get update
    apt-get install -y --no-install-recommends \
        openjdk-17-jdk \
        wget \
        unzip \
        git \
        adb \
        curl \
        software-properties-common \
        gnupg \
        lsb-release
}

# Verificar si se está ejecutando como root
if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}Por favor ejecuta como root (usar sudo)${NC}"
    exit 1
fi

# Instalar paquetes del sistema
install_packages

# Definir variables de versión (se pueden modificar)
ANDROID_SDK_ROOT=${ANDROID_SDK_ROOT:-/usr/local/android-sdk}
CMD_LINE_TOOLS_VERSION="7302050_latest"  # o usar la variable para definir la URL
PLATFORMS_VERSION="android-33"
BUILD_TOOLS_VERSION="33.0.0"
NDK_VERSION="26.1.10909125"

# Crear directorio temporal
TMP_DIR=$(mktemp -d)
cd $TMP_DIR

echo -e "${YELLOW}Descargando Android command line tools...${NC}"
wget -q https://dl.google.com/android/repository/commandlinetools-linux-${CMD_LINE_TOOLS_VERSION}.zip -O cmdline-tools.zip

echo -e "${YELLOW}Extrayendo en ${ANDROID_SDK_ROOT}...${NC}"
mkdir -p ${ANDROID_SDK_ROOT}
unzip -q cmdline-tools.zip -d ${ANDROID_SDK_ROOT}
rm cmdline-tools.zip

# Añadir cmdline-tools al PATH
export PATH="$PATH:${ANDROID_SDK_ROOT}/cmdline-tools/bin"

# Verificar que sdkmanager funciona
if ! command -v sdkmanager &> /dev/null; then
    echo -e "${RED}sdkmanager no encontrado en PATH. Revisa la instalación.${NC}"
    exit 1
fi

echo -e "${YELLOW}Aceptando licencias y actualizando SDK...${NC}"
# Aceptar todas las licencias automáticamente (yes)
yes | sdkmanager --sdk_root=${ANDROID_SDK_ROOT} --update

echo -e "${YELLOW}Instalando platform-tools, NDK, platforms y build-tools...${NC}"
yes | sdkmanager --sdk_root=${ANDROID_SDK_ROOT} --install "platform-tools"
yes | sdkmanager --sdk_root=${ANDROID_SDK_ROOT} --install "ndk;${NDK_VERSION}"
yes | sdkmanager --sdk_root=${ANDROID_SDK_ROOT} --install "platforms;${PLATFORMS_VERSION}"
yes | sdkmanager --sdk_root=${ANDROID_SDK_ROOT} --install "build-tools;${BUILD_TOOLS_VERSION}"

echo -e "${YELLOW}Estableciendo permisos para el usuario node (si existe)...${NC}"
if id "node" &>/dev/null; then
    chown -R node:node ${ANDROID_SDK_ROOT}
    echo -e "${GREEN}Permisos asignados a node.${NC}"
else
    echo -e "${YELLOW}Usuario node no encontrado, omitiendo cambio de propietario.${NC}"
fi

# Limpiar
rm -rf ${TMP_DIR}

echo -e "${GREEN}Android SDK instalado correctamente en ${ANDROID_SDK_ROOT}${NC}"

# Mostrar instrucciones para variables de entorno
echo -e "${YELLOW}Recuerda agregar las siguientes líneas a tu ~/.bashrc o ~/.zshrc:${NC}"
echo "export ANDROID_SDK_ROOT=${ANDROID_SDK_ROOT}"
echo "export PATH=\$PATH:\$ANDROID_SDK_ROOT/cmdline-tools/bin:\$ANDROID_SDK_ROOT/platform-tools"

# Opcional: agregar al bashrc del usuario node si existe
if id "node" &>/dev/null; then
    USER_HOME=$(getent passwd node | cut -d: -f6)
    if [ -f "${USER_HOME}/.bashrc" ]; then
        echo "" >> ${USER_HOME}/.bashrc
        echo "# Android SDK" >> ${USER_HOME}/.bashrc
        echo "export ANDROID_SDK_ROOT=${ANDROID_SDK_ROOT}" >> ${USER_HOME}/.bashrc
        echo "export PATH=\$PATH:\$ANDROID_SDK_ROOT/cmdline-tools/bin:\$ANDROID_SDK_ROOT/platform-tools" >> ${USER_HOME}/.bashrc
        echo -e "${GREEN}Variables de entorno agregadas a ${USER_HOME}/.bashrc${NC}"
    fi
    if [ -f "${USER_HOME}/.zshrc" ]; then
        echo "" >> ${USER_HOME}/.zshrc
        echo "# Android SDK" >> ${USER_HOME}/.zshrc
        echo "export ANDROID_SDK_ROOT=${ANDROID_SDK_ROOT}" >> ${USER_HOME}/.zshrc
        echo "export PATH=\$PATH:\$ANDROID_SDK_ROOT/cmdline-tools/bin:\$ANDROID_SDK_ROOT/platform-tools" >> ${USER_HOME}/.zshrc
        echo -e "${GREEN}Variables de entorno agregadas a ${USER_HOME}/.zshrc${NC}"
    fi
fi

echo -e "${GREEN}Instalación completada.${NC}"