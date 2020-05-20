$FilePath    = "C:\Windows\Temp\*"
$KeyWord     = "*.tmp"
$Files       = Get-ChildItem -Path $FilePath -Include $KeyWord -Recurse

ForEach($File In $Files)
{
    $Item = $File.FullName
    Write-Output $Item
    Remove-Item $Item -Force
}


$FolderPath    = "C:\Temp\"
$KeyWord     = "*Quarantine*"
$Files       = Get-ChildItem -Path $FolderPath -dir -r | Where-Object {$_.name -like $KeyWord}

ForEach($Folder In $Folders)
{
    $Item = $Folder.FullName
    Write-Output $Item
    Remove-Item $Item -Force -Recurse
}


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

New-Object System.Net.Sockets.TcpClient("192.168.0.15", 80)

$Path = "C:\inetpub\wwwroot\andersonbraz\"
$colItems = Get-ChildItem $Path | Where-Object {$_.PSIsContainer -eq $true} | Sort-Object

ForEach ($i In $colItems)
{
    $subFolderItems = Get-ChildItem $i.FullName -Recurse -Force | Where-Object {$_.PSIsContainer -eq $false} | Measure-Object -Property Length -Sum | Select-Object Sum
    $i.FullName + " -- " + "{0:N2}" -f ($subFolderItems.sum / 1MB) + " MB"
}
