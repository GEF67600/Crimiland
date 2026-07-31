# Script de surveillance automatique du dossier content
$folder = "C:\Users\philf\Desktop\Crimiland\content"
$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = $folder
$watcher.IncludeSubdirectories = $true
$watcher.EnableRaisingEvents = $true

Write-Host "Surveillance de Crimiland activée... (Appuyez sur Ctrl+C pour arrêter)" -ForegroundColor Green

while ($true) {
    $change = $watcher.WaitForChanged([System.IO.WatcherChangeTypes]::All, 5000)
    if ($change.TimedOut -eq $false) {
        Write-Host "Changement détecté dans : $($change.Name). Envoi sur GitHub..." -ForegroundColor Yellow
        Start-Sleep -Seconds 3 # Attend 3 secondes que l'enregistrement se termine
        git add .
        git commit -m "Mise a jour auto : $($change.Name)"
        git push
        Write-Host "Mis à jour avec succès !" -ForegroundColor Green
    }
}