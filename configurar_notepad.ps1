# Poe o Notepad++ a abrir/guardar sempre nesta pasta (Preferencias > Pasta por defeito).
$pasta = Split-Path -Parent $MyInvocation.MyCommand.Path

while (Get-Process notepad++ -ErrorAction SilentlyContinue) {
    Read-Host "Fecha o Notepad++ (senao ele desfaz a alteracao) e carrega Enter"
}

$cfg = Join-Path $env:APPDATA 'Notepad++\config.xml'
foreach ($base in @("$env:ProgramFiles\Notepad++", "${env:ProgramFiles(x86)}\Notepad++")) {
    if (Test-Path (Join-Path $base 'doLocalConf.xml')) { $cfg = Join-Path $base 'config.xml' }
}

if (-not (Test-Path $cfg)) {
    Write-Host "[AVISO] Nao encontrei $cfg. Abre e fecha o Notepad++ uma vez e corre isto outra vez."
    exit 1
}

try {
    Copy-Item $cfg "$cfg.bak" -Force
    [xml]$x = Get-Content $cfg -Raw -Encoding UTF8
    $gui  = $x.NotepadPlus.GUIConfigs
    $node = $gui.GUIConfig | Where-Object { $_.name -eq 'openSaveDir' }
    if (-not $node) {
        $node = $x.CreateElement('GUIConfig')
        $node.SetAttribute('name', 'openSaveDir')
        [void]$gui.AppendChild($node)
    }
    $node.SetAttribute('value', '2')               # 2 = usar sempre a pasta abaixo
    $node.SetAttribute('defaultDirPath', $pasta)
    $x.Save($cfg)
    Write-Host "[OK] Notepad++ vai abrir/guardar em $pasta"
    Write-Host "     Backup da config antiga: $cfg.bak"
} catch {
    Write-Host "[ERRO] Nao consegui editar $cfg : $_"
    Write-Host "Faz a mao: Notepad++ > Definicoes > Preferencias > Pasta por defeito > $pasta"
}
