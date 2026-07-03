#!/bin/bash
set -e

MAVEN_VERSION="${MAVEN_VERSION:-3.9.6}"
TMP_DIR=$(mktemp -d)
cd $TMP_DIR

echo "Descargando Maven..."
wget -q https://archive.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz

echo "Instalando Maven..."
tar -xzf apache-maven-${MAVEN_VERSION}-bin.tar.gz -C /opt
ln -s /opt/apache-maven-${MAVEN_VERSION} /opt/maven

rm -rf ${TMP_DIR}

echo "Maven instalado correctamente"
