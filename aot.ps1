Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;

public class WindowHelper {
    [DllImport("user32.dll")]
    [return: MarshalAs(UnmanagedType.Bool)]
    public static extern bool SetWindowPos(IntPtr hWnd, IntPtr hWndInsertAfter, int X, int Y, int cx, int cy, uint uFlags);
    
    [DllImport("user32.dll")]
    public static extern IntPtr FindWindow(string lpClassName, string lpWindowName);
    
    public static readonly IntPtr HWND_TOPMOST = new IntPtr(-1);
    public const uint SWP_NOMOVE = 0x0002;
    public const uint SWP_NOSIZE = 0x0001;
}
"@

# Find window by title (partial match works too)
$windowTitle = "CXone Agent" # Replace with your window title
$hwnd = [WindowHelper]::FindWindow($null, $windowTitle)

if ($hwnd -ne [IntPtr]::Zero) {
    # Set the window to be always on top
    [WindowHelper]::SetWindowPos($hwnd, [WindowHelper]::HWND_TOPMOST, 0, 0, 0, 0, 
                                [WindowHelper]::SWP_NOMOVE -bor [WindowHelper]::SWP_NOSIZE)
    Write-Host "Window '$windowTitle' set to always on top"
} else {
    Write-Host "Window '$windowTitle' not found"
}
