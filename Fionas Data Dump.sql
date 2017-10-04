Use [CM_P01]
GO
;WITH 
CTE_v_HS_Operating_System (ResourceID, Caption0) AS (
       SELECT ResourceID, caption0 FROM
             (SELECT 
             ResourceID, 
             caption0,
             row_number() over(partition by ResourceID order by TimeStamp desc) AS RowID
             FROM v_HS_Operating_System) AS HS_OS
       WHERE RowID = 1
),
CTE_v_GS_SYSTEM_CONSOLE_USER (ResourceID, SystemConsoleUser0) AS (
       SELECT ResourceID, SystemConsoleUser0 FROM
             (SELECT 
             ResourceID, 
             SystemConsoleUser0,
             row_number() over(partition by ResourceID order by TotalUserConsoleMinutes0 desc) AS RowID
             FROM v_GS_SYSTEM_CONSOLE_USER) AS GS_CU
       WHERE RowID = 1
) 
Select 
V_R_SYSTEM.NetBios_Name0 AS [Net Bios Name],
CASE
WHEN (CHARINDEX('Wesleyd1',CTE_v_GS_SYSTEM_CONSOLE_USER.SystemConsoleUser0) > 0)
THEN
   reverse(left(reverse(CTE_v_GS_SYSTEM_CONSOLE_USER.SystemConsoleUser0),charindex('\',reverse(CTE_v_GS_SYSTEM_CONSOLE_USER.SystemConsoleUser0),1) - 1))  
ELSE
   CTE_v_GS_SYSTEM_CONSOLE_USER.SystemConsoleUser0
END AS [Owner User],
v_GS_COMPUTER_SYSTEM.Name0 as [Name0],
v_R_System.User_Name0 as [User_Name0],
reverse(left(reverse(v_GS_COMPUTER_SYSTEM.UserName0),charindex('\',reverse(v_GS_COMPUTER_SYSTEM.UserName0),1) - 1))   AS [LastLoggedIn User],
-- these are the new comments
--Added these new comments to check version controlling
--CASE WHEN v_GS_COMPUTER_SYSTEM.UserName0 IS NOT NULL
--       THEN 
--               CASE
--                         WHEN (CHARINDEX('Wesleyd1',v_GS_COMPUTER_SYSTEM.UserName0) > 0)
--                         THEN
--                                reverse(left(reverse(v_GS_COMPUTER_SYSTEM.UserName0),charindex('\',reverse(v_GS_COMPUTER_SYSTEM.UserName0),1) - 1))  
--                         ELSE
--                               v_GS_COMPUTER_SYSTEM.UserName0 
--                  END
              
--       ELSE
--                  CASE
--                         WHEN (CHARINDEX('Wesleyd1',V_R_SYSTEM.User_Name0) > 0)
--                         THEN
--                                reverse(left(reverse(V_R_SYSTEM.User_Name0),charindex('\',reverse(V_R_SYSTEM.User_Name0),1) - 1))  
--                         ELSE
--                               V_R_SYSTEM.User_Name0
--                  END
       
--     END

-- AS [LastLoggedIn User],

--V_R_SYSTEM.User_Name0,
--v_GS_COMPUTER_SYSTEM.UserName0,

v_R_System_Valid.AD_Site_Name0 as [AD Site Name],
v_GS_COMPUTER_SYSTEM.Manufacturer0 AS [Manufacturer],
v_GS_COMPUTER_SYSTEM.Model0 AS [Model],
CASE
       WHEN v_GS_SYSTEM_ENCLOSURE.ChassisTypes0 in ( '3', '4', '5', '6', '7', '15', '16' ) Then 'Desktop'
       WHEN v_GS_SYSTEM_ENCLOSURE.ChassisTypes0 in ( '8', '9', '10', '11', '12', '14', '18', '21' ) Then 'Laptop'
       ELSE 'Other'
END AS [Computer Type],
Case
WHEN TotalConsoleTime0 = 0 Then 0
When (cast(TotalUserConsoleMinutes0 as Decimal (20,4)))/(cast(TotalConsoleTime0 as Decimal(20,4))) > 1 Then 1
Else (cast(TotalUserConsoleMinutes0 as Decimal (20,4)))/(cast(TotalConsoleTime0 as Decimal(20,4)))
End as [Percent Console Time],

CASE
WHEN (CHARINDEX(N'WESLEYD1',v_GS_SYSTEM_CONSOLE_USER.SystemConsoleUser0) > 0)
THEN
   reverse(left(reverse(Upper(v_GS_SYSTEM_CONSOLE_USER.SystemConsoleUser0)),charindex('\',reverse(Upper(v_GS_SYSTEM_CONSOLE_USER.SystemConsoleUser0)),1) - 1))  
ELSE
    Upper(v_GS_SYSTEM_CONSOLE_USER.SystemConsoleUser0)  
END AS [SCCM User Name],
employee.Name as [Employee Full Name],
employee.POSITION_DESC as [Position Description],
employee.DeptID as [Department ID],
employee.[supervisor] as [Supervisor],


--v_CH_ClientSummary.LastActiveTime AS [Last Active Time],
CASE WHEN v_GS_COMPUTER_SYSTEM.UserName0 IS NOT NULL
         THEN 
                 v_CH_ClientSummary.LastActiveTime
              
         ELSE
                    V_R_SYSTEM.Last_Logon_Timestamp0
             END

AS [Last Active Time],

v_GS_COMPUTER_SYSTEM.Name0 as [Computer Name],
--'WESLEYD1\' + 
operator.[OPRID] as [PS DataMart User],
employee.[EMPLID] as [Employee ID],
employee.[DESCR] as [Business Description],
v_Site.SiteName as [SMS Site Name],
v_GS_SYSTEM_ENCLOSURE_UNIQUE.SerialNumber0 AS [Serial Number],
v_GS_SYSTEM_ENCLOSURE_UNIQUE.SMBIOSAssetTag0 AS [Asset Tag],
v_GS_COMPUTER_SYSTEM.Name0 as [Name0],
v_R_System.User_Name0 as [User_Name0],
reverse(left(reverse(v_GS_COMPUTER_SYSTEM.UserName0),charindex('\',reverse(v_GS_COMPUTER_SYSTEM.UserName0),1) - 1))   AS [LastLoggedIn User],


--CASE WHEN v_GS_COMPUTER_SYSTEM.UserName0 IS NOT NULL
--       THEN 
--               CASE
--                         WHEN (CHARINDEX('Wesleyd1',v_GS_COMPUTER_SYSTEM.UserName0) > 0)
--                         THEN
--                                reverse(left(reverse(v_GS_COMPUTER_SYSTEM.UserName0),charindex('\',reverse(v_GS_COMPUTER_SYSTEM.UserName0),1) - 1))  
--                         ELSE
--                               v_GS_COMPUTER_SYSTEM.UserName0 
--                  END
              
--       ELSE
--                  CASE
--                         WHEN (CHARINDEX('Wesleyd1',V_R_SYSTEM.User_Name0) > 0)
--                         THEN
--                                reverse(left(reverse(V_R_SYSTEM.User_Name0),charindex('\',reverse(V_R_SYSTEM.User_Name0),1) - 1))  
--                         ELSE
--                               V_R_SYSTEM.User_Name0
--                  END
       
--     END

-- AS [LastLoggedIn User],

-- V_R_SYSTEM.User_Name0,
--v_GS_COMPUTER_SYSTEM.UserName0,


v_GS_COMPUTER_SYSTEM.TimeStamp AS [Computer Time Stamp],
v_GS_SYSTEM_CONSOLE_USER.NumberOfConsoleLogons0 AS [Console Logons],
MAX(v_GS_SYSTEM_CONSOLE_USER.TotalUserConsoleMinutes0) as [Total Minutes on Console],
v_GS_SYSTEM_CONSOLE_USER.LastConsoleUse0 AS [Last Console Use],
v_GS_SYSTEM_CONSOLE_USAGE_MAXGROUP.SecurityLogStartDate0 AS [Log Start Date],
CTE_v_HS_Operating_System.Caption0 [OS Name],
v_CH_ClientSummary.lastOnline AS [Last Online Time],
v_CH_ClientSummary.lastpolicyrequest AS [Last Policy Request],
v_CH_ClientSummary.lasthealthevaluation AS [Last Health Evaluation],
v_CH_ClientSummary.expectednextpolicyrequest AS [Expected Next Policy Request]


from V_R_SYSTEM
left JOIN  v_GS_COMPUTER_SYSTEM on v_R_System.ResourceID = v_GS_COMPUTER_SYSTEM.ResourceID
left JOIN  v_GS_SYSTEM_CONSOLE_USER on v_GS_SYSTEM_CONSOLE_USER.ResourceID = v_GS_COMPUTER_SYSTEM.ResourceID
left JOIN  v_R_System_Valid on v_R_System_Valid.ResourceID = v_GS_COMPUTER_SYSTEM.ResourceID
left JOIN  v_GS_SYSTEM_CONSOLE_USAGE_MAXGROUP on v_GS_SYSTEM_CONSOLE_USAGE_MAXGROUP.ResourceID = v_GS_SYSTEM_CONSOLE_USER.ResourceID
left JOIN  v_GS_SYSTEM_ENCLOSURE_UNIQUE on v_GS_SYSTEM_ENCLOSURE_UNIQUE.ResourceID = v_GS_COMPUTER_SYSTEM.ResourceID
left JOIN  v_GS_SYSTEM_ENCLOSURE on v_GS_SYSTEM_ENCLOSURE.ResourceID = v_GS_COMPUTER_SYSTEM.ResourceID
left JOIN  CTE_v_GS_SYSTEM_CONSOLE_USER on CTE_v_GS_SYSTEM_CONSOLE_USER.ResourceID = v_GS_COMPUTER_SYSTEM.ResourceID
left JOIN  CTE_v_HS_Operating_System on CTE_v_HS_Operating_System.ResourceID = v_GS_COMPUTER_SYSTEM.ResourceID
left JOIN  v_RA_System_SMSAssignedSites on v_RA_System_SMSAssignedSites.ResourceID = v_GS_COMPUTER_SYSTEM.ResourceID
left JOIN  v_CH_ClientSummary on v_CH_ClientSummary.ResourceID = v_GS_SYSTEM_CONSOLE_USER.ResourceID and  v_CH_ClientSummary.ResourceID = V_R_SYSTEM.ResourceID
left join  v_Site on v_Site.SiteCode=v_RA_System_SMSAssignedSites.SMS_Assigned_Sites0
left join [SQLINTAPPPRD].[WMHODataMart].[PSHR].[PSOPRDEFN] operator on 'WESLEYD1\' + operator.[OPRID] =  UPPER(v_GS_SYSTEM_CONSOLE_USER.SystemConsoleUser0) COLLATE DATABASE_DEFAULT
left join [SQLINTAPPPRD].[WMHODataMart].[PSHR].[Employees] employee on employee.[EMPLID]    =
(
select Top 1 [emplid] from
[SQLINTAPPPRD].[WMHODataMart].[PSHR].[Employees] 
where [emplid] = operator.[EMPLID]
)

--left join [SQLINTAPPPRD].[WMHODataMart].[PSHR].[Employees] employee on employee.[EMPLID] = operator.[EMPLID]


WHERE 
   (V_R_SYSTEM.Name0 LIKE 'CWM-%'
OR V_R_SYSTEM.Name0 LIKE 'TWM-%'
OR V_R_SYSTEM.Name0 LIKE 'WM-%')
--and V_R_SYSTEM.NetBios_Name0 = 'WM-31002'

AND 
(v_GS_SYSTEM_CONSOLE_USER.SystemConsoleUser0 = CTE_v_GS_SYSTEM_CONSOLE_USER.SystemConsoleUser0
OR v_GS_SYSTEM_CONSOLE_USER.SystemConsoleUser0 IS NULL)



group by 
V_R_SYSTEM.NetBios_Name0, CTE_v_GS_SYSTEM_CONSOLE_USER.SystemConsoleUser0, 
v_GS_COMPUTER_SYSTEM.UserName0,
V_R_SYSTEM.User_Name0,
v_R_System_Valid.AD_Site_Name0, v_GS_COMPUTER_SYSTEM.Manufacturer0, v_GS_COMPUTER_SYSTEM.Model0,
v_GS_SYSTEM_ENCLOSURE.ChassisTypes0, v_GS_SYSTEM_CONSOLE_USAGE_MAXGROUP.TotalConsoleTime0, v_GS_SYSTEM_CONSOLE_USER.TotalUserConsoleMinutes0,
v_GS_SYSTEM_CONSOLE_USER.SystemConsoleUser0, employee.NAME, employee.POSITION_DESC, employee.DEPTID, employee.SUPERVISOR,
v_CH_ClientSummary.LastActiveTime, v_GS_COMPUTER_SYSTEM.Name0, operator.OPRID, employee.EMPLID, employee.DESCR, v_Site.SiteName,
v_GS_SYSTEM_ENCLOSURE_UNIQUE.SerialNumber0, v_GS_SYSTEM_ENCLOSURE_UNIQUE.SMBIOSAssetTag0, v_GS_COMPUTER_SYSTEM.TimeStamp, v_GS_SYSTEM_CONSOLE_USER.NumberOfConsoleLogons0
, v_GS_SYSTEM_CONSOLE_USER.LastConsoleUse0, v_GS_SYSTEM_CONSOLE_USAGE_MAXGROUP.SecurityLogStartDate0,
CTE_v_HS_Operating_System.Caption0, v_CH_ClientSummary.LastOnline, v_CH_ClientSummary.LastPolicyRequest,
v_CH_ClientSummary.LastHealthEvaluation, v_CH_ClientSummary.ExpectedNextPolicyRequest,
V_R_SYSTEM.Last_Logon_Timestamp0


Order by
V_R_SYSTEM.NetBios_Name0 asc,
(cast(v_GS_SYSTEM_CONSOLE_USER.TotalUserConsoleMinutes0 as Decimal (20,4))) desc
