Function Get-WallPaper()
{
 $wp=Get-ItemProperty -path 'HKCU:\Control Panel\Desktop\' -name wallpaper
 if(!$wp.WallPaper) 
   { "Wall paper is not set" }
 Else
  {"Wall paper is set to $($wp.WallPaper)" }
}

Function Set-WallPaper($Value)
{
 Set-ItemProperty -path 'HKCU:\Control Panel\Desktop\' -name wallpaper -value $value
 rundll32.exe user32.dll, UpdatePerUserSystemParameters
}

Set-Wallpaper -value "C:\Users\lab\Downloads\scripts\setbackground\background_white.jpg"