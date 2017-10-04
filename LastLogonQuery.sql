
Use [CM_P01]
SELECT 
v_GS_COMPUTER_SYSTEM.name0 as workstation,
v_GS_SYSTEM_CONSOLE_USER.LastConsoleUse0,
v_GS_SYSTEM_CONSOLE_USER.NumberofConsoleLogons0,
v_GS_SYSTEM_CONSOLE_USER.SystemConsoleuser0,
v_GS_SYSTEM_CONSOLE_USER.TotalUserConsoleMinutes0,
v_R_System_Valid.AD_Site_Name0
 
FROM v_GS_SYSTEM_CONSOLE_USER
JOIN v_GS_COMPUTER_SYSTEM ON v_GS_SYSTEM_CONSOLE_USER.ResourceID = v_GS_COMPUTER_SYSTEM.ResourceID
JOIN v_R_System_Valid ON v_GS_SYSTEM_CONSOLE_USER.ResourceID = v_R_System_Valid.ResourceID
Where
-- v_GS_SYSTEM_CONSOLE_USER.Lastconsoleuse0 Between '2015-11-01 00:00:00' and GETDATE()  AND --'2015-10-31 23:59:59' 
 v_GS_COMPUTER_SYSTEM.name0 Like 'WM-%'
Order By v_GS_COMPUTER_SYSTEM.name0
