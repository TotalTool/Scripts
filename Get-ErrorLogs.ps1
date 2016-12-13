$smtp_server = “exch3.totaltool.int”;
 $to = “matt.bagan@totaltool.com”;
 $from = “administrator@totaltool.com”;
 $subject = “System Error Log Report”;
 $date = get-date
 $body = "Error logs from $date";
  Get-EventLog System -EntryType Error -computername Exch2,ttdc03,ttfs02,ttsql,veeam7,ttspice,ttwdm, ttcrib,ttcsg2,ttfieldpoint,ttimaging,ttmdm,ttsharepoint,ttweb03 -After (Get-Date).AddDays(-1) |Select -property machinename,Timegenerated,eventID,Message,source | convertto-html |out-file c:\scripts\ErrorLogs.htm
  send-mailmessage -to $to -from $from -subject $subject -body $body -attachments "c:\scripts\ErrorLogs.htm" -smtpserver $smtp_server