class Automation{
    [string]$path
    [string]$name

    [void]Main()
    {
        Write-Host "`nMenu`n`n1. Rename Images`n2. Quit`n"
        $ch = Read-Host "Choose a number in the menu"
        switch ($ch) {
            1 { $this.StartProcess() }
            2 { 
                Write-Host "Byeeeee! I love you!" 
            }
            Default {
                Write-Host "Invalid Choice" 
            }
        }
    }
    [void]RenameFile($path, $num)
    {
        $ext = [System.IO.Path]::GetExtension($path)
        $newName = $this.name+$num+$ext
        Rename-Item -Path $path -NewName $newName
    }
    [void]StartProcess()
    {
        $this.path = Read-Host "Please enter directory folder"
        if(Test-Path -Path $this.path)
        {
            $ext = @("*.jpg", "*.jpeg", "*.png")
            $_path = $this.path+"/*"
            $child_count = (Get-ChildItem -Path $_path -Include $ext | Measure-Object).Count
    
            Write-Host "`nImages Found Count: $child_count `n`n"
            $this.name = Read-Host "Please input desired name"
            Clear-Host
            $progress = 0
            $i = 0;
            $files = Get-ChildItem -Path $_path -Include $ext
            foreach ($currentItemName in $files){
                $progress = [System.Math]::floor(($i/$child_count) * 100)
                $this.RenameFile($currentItemName, ($i+1))
                Write-Progress -Activity "Renaming Image" -Status "$progress% Complete:" -PercentComplete $progress
                Start-Sleep -Milliseconds 250
                $i++
                
            }
            Clear-Host
            Write-Host "`n`nSuccessfully Renamed files to"$this.name"`n`n"
            $this.ListImages()
    
            Start-Sleep -Milliseconds 500
    
            $this.Main()
        }
        else
        {
            $this.InvalidPath()
        }
       
    }
    [void]ListImages()
    {
        $ext = @("*.jpg", "*.jpeg", "*.png")
        $_path = $this.path+"/*"
        $files = Get-ChildItem -Path $_path -Include $ext

        foreach ($currentItemName in $files) {
            Write-Host ($currentItemName)
        }
    }

    [void]InvalidPath()
    {
        Write-Host $this.path"is not a valid path"
    }
}