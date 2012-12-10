' http://www.motobit.com/tips/detpg_read-write-binary-files/
Function SaveBinaryData(FileName, ByteArray)
    Const adTypeBinary = 1
    Const adSaveCreateOverWrite = 2

    ' create Stream object
    dim BinaryStream
    set BinaryStream = CreateObject("ADODB.Stream")

    ' specify stream type - we want to save binary data.
    BinaryStream.Type = adTypeBinary

    ' open the stream and write binary data To the object
    BinaryStream.Open
    BinaryStream.Write ByteArray

    ' save binary data to disk
    BinaryStream.SaveToFile FileName, adSaveCreateOverWrite
End Function

' http://stackoverflow.com/questions/5907089/how-to-post-https-request-using-vbscript
Function DownloadFile(FileName, Url)
    dim http
    set http = createobject("MSXML2.ServerXMLHTTP")

    http.Open "GET", Url, False

    ' 2 stands for SXH_OPTION_IGNORE_SERVER_SSL_CERT_ERROR_FLAGS
    ' 13056 means ignore all server side cert error
    http.setOption 2, 13056
    http.Send

    ' read response body
    SaveBinaryData FileName, http.responseBody
End Function

' http://customerfx.com/pages/crmdeveloper/2004/02/10/how-to-execute-a-file-program-in-vbscript.aspx
Sub Run(ByVal sFile)
    dim shell
    set shell = CreateObject("WScript.Shell")
    shell.Run Chr(34) & sFile & Chr(34), 1, false
End Sub

' http://stackoverflow.com/questions/3641163/wait-for-program-to-complete
Function ExecuteWait(FileName)
    ' execute the file
    Run FileName

    set oWMI = GetObject("winmgmts:\\.\root\cimv2")

    ' create an event query to be notified within one second when
    ' the process has finished
    set colEvents = oWMI.ExecNotificationQuery _
        ("SELECT * FROM __InstanceDeletionEvent WITHIN 1 " _
        & "WHERE TargetInstance ISA 'Win32_Process' " _
        & "AND TargetInstance.Name = '" & FileName &  "'")

    ' wait until the process has finished
    set oEvent = colEvents.NextEvent
End Function

WScript.StdOut.Write "[x] Downloading Git" & Chr(10)
DownloadFile "_git.exe", _
    "http://msysgit.googlecode.com/files/Git-1.8.0-preview20121022.exe"

WScript.StdOut.Write "[x] Installing Git" & Chr(10)
ExecuteWait "_git.exe /verysilent"

WScript.StdOut.Write "[+] Installed Git" & Chr(10)
