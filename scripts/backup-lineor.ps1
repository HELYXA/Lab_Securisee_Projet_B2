# Script de sauvegarde automatique - LINEOR Joaillerie
# Planifie via le Gestionnaire des taches Windows pour s'executer chaque nuit a 23h00

# Etablissement des chemins source et destination
$source = "C:\Partages\Lineor"
$destination = "C:\Sauvegardes\Lineor_" + (Get-Date -Format "yyyy-MM-dd")

# Creation du dossier de sauvegarde avec la date du jour
New-Item -ItemType Directory -Path $destination -Force

# Copie des fichiers source vers le dossier de destination
Copy-Item -Path $source\* -Destination $destination -Recurse

# Confirmation de la sauvegarde
Write-Host "Sauvegarde effectuee avec succes le" (Get-Date)
