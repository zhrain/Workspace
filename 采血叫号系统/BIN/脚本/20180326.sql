 


DROP FUNCTION [dbo].[f_splitstr]
GO

--分拆字符串
CREATE    FUNCTION [dbo].[f_splitstr](@SourceSql VARCHAR(8000),@StrSeprate VARCHAR(10))
RETURNS @temp TABLE(F1 VARCHAR(100))
AS 
BEGIN
DECLARE @i INT
SET @SourceSql=RTRIM(LTRIM(@SourceSql))
SET @i=CHARINDEX(@StrSeprate,@SourceSql)
WHILE @i>=1
BEGIN
  INSERT @temp VALUES(LEFT(@SourceSql,@i-1))
  SET @SourceSql=SUBSTRING(@SourceSql,@i+1,LEN(@SourceSql)-@i)
  SET @i=CHARINDEX(@StrSeprate,@SourceSql)
END
IF @SourceSql<>'' 
    INSERT @temp VALUES(@SourceSql)
RETURN 
END
GO

DROP TABLE BloodStationLIST
GO

--申请信息插入叫号队列表
CREATE TABLE [dbo].[BloodStationLIST](
	[Num] [INT] IDENTITY(1,1) NOT NULL,
	[Date] [VARCHAR](10) NULL,
	[Cardno] [VARCHAR](20) NULL,
	[No] [VARCHAR](5) NULL,
	[Flag] [VARCHAR](1) NULL,
	[ApplyString] [VARCHAR](8000) NULL,
	[PrintFlag] [BIT] NULL,
 CONSTRAINT [PK_BloodStationLIST] PRIMARY KEY CLUSTERED 
(
	[Num] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

DROP TABLE BloodOrderList
go
 
--叫号序列表
CREATE TABLE [dbo].[BloodOrderList](
	[Num] [INT] IDENTITY(1,1) NOT NULL,
	[Date] [VARCHAR](10) NULL,
	[No] [INT] NULL,
 CONSTRAINT [PK_BloodOrderList] PRIMARY KEY CLUSTERED 
(
	[Num] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

DROP TRIGGER Trg_Insert_BloodStationLIST
GO

 
/*=======================================================================      
描述：晋中一院叫号数据写入
目的：写入叫号队列数据,晋中一院使用
修改记录： 2018-3-24 zr create 
========================================================================*/   
CREATE trigger [dbo].[Trg_Insert_BloodStationLIST]
ON [dbo].[Lis_OrderMaster] 
FOR INSERT 
AS 
BEGIN
  DECLARE @HospNo VARCHAR(40)
  DECLARE @Applyno VARCHAR(20)
 
  SELECT @HospNo=a.HospNo,@Applyno=a.Txm  FROM dbo.Lis_OrderMaster a 
  WHERE a.brlx=0

  IF @Applyno='' OR  @HospNo=''
  BEGIN
    RETURN
  END
  

  DECLARE @No INT  
  DECLARE @Num INT 

  SELECT TOP 1 @Num=Num FROM BloodStationLIST WHERE Date=CONVERT(VARCHAR(10),GETDATE(),120)  AND cardno=@HospNo and PrintFlag=0 ORDER BY num DESC
  IF @@ROWCOUNT=0 
  BEGIN
      SELECT @No=No+1 FROM BloodOrderList WHERE Date=CONVERT(VARCHAR(10),GETDATE(),120) 
	  IF @@ROWCOUNT=0 
	  BEGIN
		SET @No=1
		INSERT INTO BloodOrderList(Date,No) SELECT CONVERT(VARCHAR(10),GETDATE(),120),0
	  END
		UPDATE BloodOrderList SET No=No+1 WHERE Date=CONVERT(VARCHAR(10),GETDATE(),120) 
  
	  PRINT @No

    INSERT INTO BloodStationLIST(date,Cardno,no,Flag,ApplyString,PrintFlag)
	SELECT CONVERT(VARCHAR(10),GETDATE(),120),@HospNo,@No,'P',@Applyno,0
  END
  ELSE
  BEGIN
    UPDATE BloodStationLIST SET ApplyString=ApplyString+'@'+@Applyno WHERE 
	Date=CONVERT(VARCHAR(10),GETDATE(),120)  AND cardno=@HospNo AND Num=@Num
  END

END

GO
 
DROP FUNCTION [dbo].[f_ReturnReportTypeName]
GO


--返回项目名称
CREATE   FUNCTION [dbo].[f_ReturnReportTypeName](@Applyno VARCHAR(20))
RETURNS VARCHAR(3000)
AS 
BEGIN
DECLARE @ReportTypeName VARCHAR(3000)
SET @ReportTypeName=''
SELECT @ReportTypeName=@ReportTypeName+'@'+RTRIM(HisOrderName)   FROM Lis_AcceptItems  WITH(NOLOCK) WHERE Txm=@ApplyNo

SET @ReportTypeName = CASE WHEN LEN(@ReportTypeName)>0 THEN STUFF(@ReportTypeName,1,1,'') ELSE @ReportTypeName END  
RETURN @ReportTypeName
END


GO

DROP PROCEDURE sp_serverDate
GO


CREATE PROCEDURE [sp_serverDate] 
(@T_serverDate   Datetime  output)
AS
   set  @T_ServerDate = getDate()

GO


DROP PROCEDURE UP_BloodStationFindBloodSL
go

--查询当前采血人次信息
CREATE PROCEDURE [dbo].[UP_BloodStationFindBloodSL]   
@DATE VARCHAR(10)  
AS
BEGIN
 SELECT COUNT(*) AS sl
 FROM  BloodStationLIST 
 WHERE PrintFlag=0 AND Date=@DATE

END


GO

 
DROP PROCEDURE UP_BloodStationFindCall
go


--查询当前叫号患者
create PROCEDURE [dbo].[UP_BloodStationFindCall]  
@DATE VARCHAR(10)  
AS
BEGIN

  CREATE TABLE #BloodStationLIST(
	[Num] [INT] NULL,
	[Date] [VARCHAR](10) NULL,
	[Cardno] [VARCHAR](20) NULL,
	[No] [VARCHAR](5) NULL,
	[Flag] [VARCHAR](1) NULL,
	[ApplyString] [VARCHAR](8000) NULL,
	[PrintFlag] [BIT] NULL)
  
  INSERT INTO #BloodStationLIST(Num,Date,Cardno,No,Flag,ApplyString,PrintFlag)
  SELECT Num,Date,Cardno,No,Flag,ApplyString,PrintFlag FROM  BloodStationLIST 
  WHERE PrintFlag=0 AND Flag='J' AND Date=@DATE
  ORDER BY No 

  INSERT INTO #BloodStationLIST(Num,Date,Cardno,No,Flag,ApplyString,PrintFlag)
  SELECT Num,Date,Cardno,No,Flag,ApplyString,PrintFlag FROM  BloodStationLIST 
  WHERE PrintFlag=0 AND Flag='V' AND Date=@DATE
  ORDER BY No

  INSERT INTO #BloodStationLIST(Num,Date,Cardno,No,Flag,ApplyString,PrintFlag)
  SELECT Num,Date,Cardno,No,Flag,ApplyString,PrintFlag FROM  BloodStationLIST 
  WHERE PrintFlag=0 AND Flag='P' AND Date=@DATE
  ORDER BY No

  SELECT TOP 1 * INTO #temp FROM #BloodStationLIST

  SELECT TOP 1 a.Num,a.Date,a.Cardno,a.No,a.Flag,a.ApplyString,a.PrintFlag,(a.Flag+a.No) AS BloodNo,b.Name AS cPatientName,(CASE b.Sex WHEN 1 THEN '男' WHEN 2 THEN '女' ELSE '' END) AS CSex,CONVERT(VARCHAR(10),b.Age)+b.AgeUnit AS iYearsOld FROM #temp a LEFT JOIN Lis_OrderMaster b WITH(NOLOCK) ON a.Cardno=b.HospNo
 

  DROP TABLE #BloodStationLIST
  DROP TABLE #temp
 
END


GO

DROP PROCEDURE UP_BloodStationFindApply
GO

--查询当前叫号患者标本明细信息
CREATE PROCEDURE [dbo].[UP_BloodStationFindApply]  
@Num INT
AS
BEGIN
  
  DECLARE @ApplyString VARCHAR(8000)
  
  DECLARE @BloodStr VARCHAR(10)
   
  SELECT @ApplyString=ApplyString,@BloodStr=Flag+No FROM dbo.BloodStationLIST WHERE num=@Num


  SELECT F1 AS cbarcode,dbo.f_ReturnReportTypeName(F1) AS Applystring,b.Name AS cPatientName,b.HospNo AS cCaseCode,@BloodStr AS Bloodstr FROM dbo.f_splitstr(@ApplyString,'@')  a JOIN dbo.Lis_OrderMaster b WITH(nolock) ON a.F1=b.Txm 

END

GO






