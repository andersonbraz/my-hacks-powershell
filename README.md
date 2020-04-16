# Utilidades: Scripts com Powershell

Atuando na sustentação ou operação de aplicações para ambiente de produção. Sempre nos deparamos com situações corriqueiras que demandam a necessidade de tratarmos incidentes ou atividades de trabalho em curto espaço de tempo.

Tratando-se de ambientes Windows eu costumo lançar mão de algumas rotinas utilizando o Powershell. E aqui gostaria de compartilhar meus procedimentos mais rotineiros que guardo carinhosamente, também num pendrive, e compartilho abaixo:

## Exclusão de Arquivos

Script para apagar arquivos temporários, ou com uma determinada extensão, de um determinado diretório especifico.

```powershell

$FilePath    = "C:\Windows\Temp\*"
$KeyWord     = "*.tmp"
$Files       = Get-ChildItem -Path $FilePath -Include $KeyWord -Recurse

ForEach($File In $Files)
{
    $Item = $File.FullName
    Write-Output $Item
    Remove-Item $Item -Force
}

```

---

## Exclusão de Diretórios

Script para apagar diretórios que contenham uma determinada palavra num determinado local especifico.

```powershell

$FolderPath    = "C:\Temp\"
$KeyWord     = "*Quarantine*"
$Files       = Get-ChildItem -Path $FolderPath -dir -r | Where-Object {$_.name -like $KeyWord}

ForEach($Folder In $Folders)
{
    $Item = $Folder.FullName
    Write-Output $Item
    Remove-Item $Item -Force -Recurse
}

```

---

## Compactação de Arquivos (7zip)

```powershell

$KeyWord = "*.log"
$LogPath = "E:\Logs\W3SVC*\"
$Limit = (Get-Date).AddDays(-150)

$Files = Get-ChildItem -Path $LogPath -Include $KeyWord -Recurse | Where CreationTime -lt $Limit
ForEach ($File In $Files) 
{
    $Item =  $File.FullName
    Write-Output "File Found: " $Item 
	& "E:\Program Files\7-Zip\7z.exe" a -tzip ($Item + ".zip") $Item

} 


```

---

## Validar Acesso ao Ip:Porta

```powershell
New-Object System.Net.Sockets.TcpClient("192.168.0.15", 80)
```

---

## Verificar Tamanho de Diretórios

```powershell
$Path = "C:\inetpub\wwwroot\andersonbraz\"
$colItems = Get-ChildItem $Path | Where-Object {$_.PSIsContainer -eq $true} | Sort-Object

ForEach ($i In $colItems)
{
    $subFolderItems = Get-ChildItem $i.FullName -Recurse -Force | Where-Object {$_.PSIsContainer -eq $false} | Measure-Object -Property Length -Sum | Select-Object Sum
    $i.FullName + " -- " + "{0:N2}" -f ($subFolderItems.sum / 1MB) + " MB"
}

```
