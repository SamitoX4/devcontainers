# Issues detectados en plantillas DevContainers

Documento de seguimiento para los problemas encontrados en las plantillas de `devcontainers/templates/`. Se irá tachando a medida que se corrigan.

---

## 1. `awk` con escapes incorrectos en Dockerfiles (CRÍTICO)

**Estado:** En corrección  
**Impacto:** El build de Docker falla inmediatamente al procesar usuarios/contraseñas.

### Descripción

Varios `Dockerfile` usan `awk` con comillas simples escapadas (`\'`), lo cual es inválido tanto en shell como en Dockerfile:

```dockerfile
RUN awk \'BEGIN{print "root:" ENVIRON["CONTAINER_PASSWORD"]}\' | chpasswd
```

Esto genera el error:

```text
awk: 1: unexpected character '''
awk: line 2: missing } near end of file
```

Además, la variante:

```dockerfile
awk -v u="\${REMOTE_USER}" \'BEGIN{print u ":" ENVIRON["REMOTE_PASSWORD"]}\' | chpasswd
```

tiene **dos** problemas:

1. Las comillas escapadas `\'` rompen `awk`.
2. `\${REMOTE_USER}` no se expande; queda literalmente como `${REMOTE_USER}`.

### Fix propuesto

Como ya existe `ENV REMOTE_USER=${REMOTE_USER}` en cada Dockerfile, usar `ENVIRON["REMOTE_USER"]` directamente:

```dockerfile
RUN awk 'BEGIN{print "root:" ENVIRON["CONTAINER_PASSWORD"]}' | chpasswd
```

Y:

```dockerfile
awk 'BEGIN{print ENVIRON["REMOTE_USER"] ":" ENVIRON["REMOTE_PASSWORD"]}' | chpasswd
```

### Archivos afectados

- [ ] `templates/java/.devcontainer/Dockerfile`
- [ ] `templates/python/.devcontainer/Dockerfile`
- [ ] `templates/go/.devcontainer/Dockerfile`
- [ ] `templates/laravel/.devcontainer/Dockerfile`
- [ ] `templates/android/java/.devcontainer/Dockerfile`
- [ ] `templates/android/ndk/.devcontainer/Dockerfile`
- [ ] `templates/android/kotlin-native/.devcontainer/Dockerfile`
- [ ] `templates/android/flutter/.devcontainer/Dockerfile`
- [ ] `templates/android/react-native/.devcontainer/Dockerfile`

---

## 2. `install-shared.sh` asume usuario `node` en el mensaje

**Estado:** Pendiente  
**Impacto:** Confusión en logs; el mensaje siempre dice `'node'` aunque el usuario sea `developer` o `root`.

### Archivos afectados

Aparece al menos en:

- `templates/java/.devcontainer/scripts/install-shared.sh`
- `templates/python/.devcontainer/scripts/install-shared.sh`
- `templates/go/.devcontainer/scripts/install-shared.sh`
- `templates/rust/.devcontainer/scripts/install-shared.sh`
- `templates/laravel/.devcontainer/scripts/install-shared.sh`
- Posiblemente también en plantillas Android (a revisar).

### Fix propuesto

Usar `$REMOTE_USER` (que viene del `ENV` del Dockerfile) en lugar de hardcodear `node`:

```bash
echo "Installing opencode and claude for user '${REMOTE_USER}'..."
```

Y asegurar que las rutas a `~/.local/bin` usen `$REMOTE_USER` o `$HOME` correctamente.

---

## 3. `JAVA_HOME` hardcodeado a JDK 17 en plantillas Android

**Estado:** Pendiente  
**Impacto:** Si el usuario cambia `JAVA_VERSION`, el entorno sigue apuntando a `java-17-openjdk-amd64`.

### Archivos afectados

- `templates/android/react-native/.devcontainer/Dockerfile` línea 46:
  ```dockerfile
  ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
  ```
- Posiblemente extensiones de VS Code en `devcontainer.json` de Android con `java.configuration.runtimes` fijo a JavaSE-17.

### Fix propuesto

Hacer que `JAVA_HOME` respete `JAVA_VERSION`:

```dockerfile
ENV JAVA_HOME=/usr/lib/jvm/java-${JAVA_VERSION}-openjdk-amd64
```

Y actualizar las configuraciones de VS Code (`java.configuration.runtimes`) dinámicamente si es posible, o al menos documentar la limitación.

---

## 4. Flutter: `CHROME_EXECUTABLE` apunta a `chromium` no instalado

**Estado:** Pendiente  
**Impacto:** `flutter doctor` o tests web pueden fallar por falta de Chrome/Chromium.

### Archivos afectados

- `templates/android/flutter/.devcontainer/scripts/setup-shell.sh` (o Dockerfile) establece:
  ```bash
  CHROME_EXECUTABLE=/usr/bin/chromium
  ```
- `templates/android/flutter/.devcontainer/scripts/install-system-packages.sh` no incluye `chromium` ni `chromium-browser`.

### Fix propuesto

O bien instalar `chromium-browser` en `install-system-packages.sh`, o no definir `CHROME_EXECUTABLE` si no se instala Chrome.

---

## 5. Credenciales hardcodeadas en plantillas de base de datos

**Estado:** Pendiente  
**Impacto:** Seguridad/documentación; contraseñas visibles en el repo.

### Archivos afectados

- `templates/mysql/.devcontainer/docker-compose.yml`
- `templates/postgre/.devcontainer/docker-compose.yml`

### Fix propuesto

Evaluar si se benefician de los placeholders de seguridad (`__SECURITY_ARGS__`) o, al menos, documentar que son valores de desarrollo local y no deben usarse en producción.

---

## 6. Inconsistencias menores

| Issue | Estado | Notas |
|-------|--------|-------|
| `configure-system.sh` ejecutándose como `root` instala Oh My Zsh en `/root`. | Pendiente | Considerar si es el comportamiento deseado para modo `root`. |
| Variación de paquetes GTK/GBM en `install-system-packages.sh`. | Pendiente | `nodejs` incluye libs para Electron; otros no. Verificar si es intencional. |
| Plantilla `example/` desactualizada (`/workspaces`, Dockerfile monolítico). | Pendiente | Revisar si se mantiene o se regenera con `devc gen`. |
| Mezcla de idiomas (inglés/español) en READMEs y scripts. | Pendiente | Estandarizar según convención del proyecto. |

---

## Checklist global

- [ ] Issue 1: Escapes `awk` corregidos en todos los Dockerfiles.
- [ ] Issue 2: `install-shared.sh` usa `$REMOTE_USER` dinámicamente.
- [ ] Issue 3: `JAVA_HOME` parametrizado en Android.
- [ ] Issue 4: Chromium instalado/definido correctamente en Flutter.
- [ ] Issue 5: Credenciales DB revisadas/documentadas.
- [ ] Issue 6: Inconsistencias menores atendidas.
