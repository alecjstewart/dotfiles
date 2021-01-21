function Dotfile-Config {
    git --git-dir=$HOME\.cfg\ --work-tree=$HOME $args
}
Set-Alias -Name config -Value Dotfile-Config

function prompt {
    Write-Host ""
    Write-Host "$env:USERNAME" -NoNewline -ForegroundColor Yellow
    Write-Host " at " -NoNewLine
    Write-Host "$($env:COMPUTERNAME.ToLower())" -NoNewline -ForegroundColor Yellow
    Write-Host " in " -NoNewLine
    Write-Host "$(Get-Location)" -ForegroundColor Blue

    if ($?) {
        Write-Host "$" -NoNewLine -ForegroundColor Green
    } else {
        Write-Host "$" -NoNewLine -ForegroundColor Red
    }

    return " "
}