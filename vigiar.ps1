# Vigia esta pasta e corre "publicar.bat auto" 5 s depois de guardares ou criares um ficheiro.
# Fecha a janela para parar.
$pasta = Split-Path -Parent $MyInvocation.MyCommand.Path
$log   = Join-Path $pasta 'publicar.log'
$Host.UI.RawUI.WindowTitle = 'Vigia sistemas_1 (fecha para parar)'

$w = New-Object System.IO.FileSystemWatcher $pasta, '*'
$w.IncludeSubdirectories = $false
$w.NotifyFilter = [System.IO.NotifyFilters]'FileName, LastWrite'

$ignorar  = '^(publicar\.log|.*\.tmp|.*\.bak|~.*)$'
$pendente = $false
$ultimo   = Get-Date
Write-Host "A vigiar $pasta ..."

while ($true) {
    $r = $w.WaitForChanged([System.IO.WatcherChangeTypes]::All, 1000)
    if (-not $r.TimedOut -and $r.Name -and $r.Name -notmatch $ignorar) {
        $pendente = $true
        $ultimo   = Get-Date
    }
    if ($pendente -and ((Get-Date) - $ultimo).TotalSeconds -ge 5) {
        $pendente = $false
        Write-Host "$(Get-Date -Format 'HH:mm:ss') a publicar..."
        "==== $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" | Out-File $log -Append -Encoding utf8
        & cmd.exe /c "`"$pasta\publicar.bat`" auto" 2>&1 | Tee-Object -FilePath $log -Append
    }
}
