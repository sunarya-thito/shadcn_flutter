Get-Content analyzer_output.txt |
    Select-String "PUBLIC_MEMBER_API_DOCS" |
    Where-Object { $_ -notmatch "icon" } |
    ForEach-Object {
        $fields = $_.Line.Split("|")
        $path = $fields[3] -replace "C:\\Users\\LQQ\\shadcn_flutter\\shadcn_flutter\\", ""
        $line = $fields[4]
        "* $($path):$($line)"
    } | Set-Content undocumented.md