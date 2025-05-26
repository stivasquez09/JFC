# Infraestructura Escalable y Alta Disponibilidad con Terraform en Azure

Este repositorio contiene un archivos Terraform que crea un proyecto en Microsoft Azure, aprovisionando toda la infraestructura necesaria.

## 📚 Documentación

Consulta la documentación oficial de [Terraform](https://www.terraform.io/) para obtener más información sobre cómo utilizar esta herramienta con **Microsoft Azure**.

---

## ✅ Pre-requisitos

Antes de comenzar, asegúrate de tener lo siguiente:

* Una cuenta o suscripción activa en [Microsoft Azure](https://azure.microsoft.com/).
* Descargar e instalar los siguientes ejecutables:

  * [Terraform](https://www.terraform.io/)
  * [Azure CLI](https://learn.microsoft.com/es-es/cli/azure/install-azure-cli-windows?view=azure-cli-latest&pivots=msi)
* Este código está escrito para utilizar **Terraform versión 3.0.0 o superior**.

---

## 🚀 Uso del código

### 1. Configurar el acceso a Azure

#### Autenticarse con Azure CLI

Terraform necesita autenticarse con Azure para poder crear la infraestructura. Desde tu terminal, ejecuta el siguiente comando para iniciar sesión:

```bash
az login  
```

Esto abrirá tu navegador para que ingreses tus credenciales de Azure. Una vez autenticado, se mostrará la información de tu suscripción en la terminal:

```json
[
  {
    "cloudName": "<CLOUD-NAME>",
    "homeTenantId": "<HOME-TENANT-ID>",
    "id": "<SUBSCRIPTION-ID>",
    "isDefault": true,
    "name": "<SUBSCRIPTION-NAME>",
    ...
  }
]
```

Identifica el valor de `id` correspondiente a la suscripción que deseas usar y establécelo con el siguiente comando:

```bash
az account set --subscription "<SUBSCRIPTION-ID>"
```

#### Crear un Service Principal

Un **Service Principal** es una entidad que permite a Terraform autenticarse y ejecutar acciones en tu nombre.

Ejecuta el siguiente comando (reemplazando `<SUBSCRIPTION_ID>`) para crear uno:

```bash
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/<SUBSCRIPTION_ID>"
```

Este comando generará una salida con credenciales que **deben mantenerse privadas**:

```json
{
{
  "clientId": "xxxxx-xxxxx3-xxxxxx-xxxxxx",
  "clientSecret": "xxxxxxxxxxx.xxxxxxxxxxx",
  "subscriptionId": "xxxxxxx-xxxxxxxxx--xxxxxxx-x",
  "tenantId": "xxxxxxx-xxxxxxxx-xxxxxxx-xxxxxx",

}

```

#### Establecer variables de entorno

Es recomendable usar variables de entorno para configurar las credenciales:

**Para MacOS/Linux:**

```bash
export ARM_CLIENT_ID="<SERVICE_PRINCIPAL_APPID>"
export ARM_CLIENT_SECRET="<SERVICE_PRINCIPAL_PASSWORD>"
export ARM_SUBSCRIPTION_ID="<SUBSCRIPTION_ID>"
export ARM_TENANT_ID="<TENANT_ID>"
```

**Para Windows (PowerShell):**

```bash
$env:ARM_CLIENT_ID="<SERVICE_PRINCIPAL_APPID>"
$env:ARM_CLIENT_SECRET="<SERVICE_PRINCIPAL_PASSWORD>"
$env:ARM_SUBSCRIPTION_ID="<SUBSCRIPTION_ID>"
$env:ARM_TENANT_ID="<TENANT_ID>"
```
Nota estos valores seran anexados al Repositorio de GitHub Actions en el apartado de secrets para ser invocados en el workflows
---

### 3. Inicializar el entorno de trabajo

Ejecuta el siguiente comando para inicializar el directorio de trabajo:

```bash
terraform init
```

---

### 5. Validar los cambios

Antes de aplicar la configuración, puedes previsualizar los cambios con:

```bash
terraform plan
```

---

### 6. Aplicar los cambios

Para crear la infraestructura:

```bash
terraform apply
```

---

### 7. Verificar en el portal de Azure

Después de aplicar la configuración, en el portal de Azure deberías ver:

* El nuevo Resource Group.


---

### 8. Eliminar los recursos

Para destruir los recursos creados cuando ya no los necesites:

```bash
terraform destroy
```
