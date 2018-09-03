 

CREATE TABLE [dbo].[BloodWindowsSet](
	[Num] [INT] IDENTITY(1,1) NOT NULL,
	[Window] [VARCHAR](50) NOT NULL,
	[Ifuse] [BIT] NULL,
 CONSTRAINT [PK_BloodWindowsSet] PRIMARY KEY CLUSTERED 
(
	[Num] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE BloodStationLIST
ADD windowNum INT NULL
GO

ALTER TABLE BloodStationLIST
ALTER COLUMN PrintFlag INT NULL
GO 

 
 
/*=======================================================================      
描述：晋中一院叫号数据写入
目的：写入叫号队列数据,晋中一院使用
修改记录： 2018-3-24 zr create 
           2018-4-10 zr 添加叫号人员指定窗口数据
========================================================================*/   
ALTER trigger [dbo].[Trg_Insert_BloodStationLIST]
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
  DECLARE @WindowNum INT 

  SELECT TOP 1 @Num=Num FROM BloodStationLIST WHERE Date=CONVERT(VARCHAR(10),GETDATE(),120)  AND cardno=@HospNo and PrintFlag=0 
  ORDER BY num DESC
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

	  SELECT @WindowNum=num FROM 
	  (SELECT  TOP 1 a.Num,(SELECT COUNT(*) FROM dbo.BloodStationLIST WHERE PrintFlag=0 AND Date=CONVERT(VARCHAR(10),GETDATE(),120) AND windowNum=a.Num) AS sl FROM dbo.BloodWindowsSet a WHERE Ifuse=1
	   ORDER BY sl,a.Num) a

    INSERT INTO BloodStationLIST(date,Cardno,no,Flag,ApplyString,PrintFlag,windowNum)
	SELECT CONVERT(VARCHAR(10),GETDATE(),120),@HospNo,@No,'P',@Applyno,0,@WindowNum
  END
  ELSE
  BEGIN
    UPDATE BloodStationLIST SET ApplyString=ApplyString+'@'+@Applyno WHERE 
	Date=CONVERT(VARCHAR(10),GETDATE(),120)  AND cardno=@HospNo AND Num=@Num
  END

END

GO



--查询当前窗口叫号患者
ALTER PROCEDURE [dbo].[UP_BloodStationFindCall]  
@DATE VARCHAR(10),
@windowNum INT   
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
  WHERE PrintFlag=0 AND Flag='J' AND Date=@DATE AND windowNum=@windowNum
  ORDER BY No 

  INSERT INTO #BloodStationLIST(Num,Date,Cardno,No,Flag,ApplyString,PrintFlag)
  SELECT Num,Date,Cardno,No,Flag,ApplyString,PrintFlag FROM  BloodStationLIST 
  WHERE PrintFlag=0 AND Flag='V' AND Date=@DATE AND windowNum=@windowNum
  ORDER BY No

  INSERT INTO #BloodStationLIST(Num,Date,Cardno,No,Flag,ApplyString,PrintFlag)
  SELECT Num,Date,Cardno,No,Flag,ApplyString,PrintFlag FROM  BloodStationLIST 
  WHERE PrintFlag=0 AND Flag='P' AND Date=@DATE AND windowNum=@windowNum
  ORDER BY No

  SELECT TOP 1 * INTO #temp FROM #BloodStationLIST

  SELECT TOP 1 a.Num,a.Date,a.Cardno,a.No,a.Flag,a.ApplyString,a.PrintFlag,(a.Flag+a.No) AS BloodNo,b.Name AS cPatientName,(CASE b.Sex WHEN 1 THEN '男' WHEN 2 THEN '女' ELSE '' END) AS CSex,CONVERT(VARCHAR(10),b.Age)+b.AgeUnit AS iYearsOld FROM #temp a LEFT JOIN Lis_OrderMaster b WITH(NOLOCK) ON a.Cardno=b.HospNo
 

  DROP TABLE #BloodStationLIST
  DROP TABLE #temp
 
END

GO

--查询当前窗口叫号等待患者
create PROCEDURE [dbo].[UP_BloodStationFindCallWait]  
@DATE VARCHAR(10),
@windowNum INT   
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
  WHERE PrintFlag=0 AND Flag='J' AND Date=@DATE AND windowNum=@windowNum
  ORDER BY No 

  INSERT INTO #BloodStationLIST(Num,Date,Cardno,No,Flag,ApplyString,PrintFlag)
  SELECT Num,Date,Cardno,No,Flag,ApplyString,PrintFlag FROM  BloodStationLIST 
  WHERE PrintFlag=0 AND Flag='V' AND Date=@DATE AND windowNum=@windowNum
  ORDER BY No

  INSERT INTO #BloodStationLIST(Num,Date,Cardno,No,Flag,ApplyString,PrintFlag)
  SELECT Num,Date,Cardno,No,Flag,ApplyString,PrintFlag FROM  BloodStationLIST 
  WHERE PrintFlag=0 AND Flag='P' AND Date=@DATE AND windowNum=@windowNum
  ORDER BY No

  SELECT TOP 2 * INTO #temp FROM #BloodStationLIST

  IF @@ROWCOUNT=2 
  begin
  SELECT TOP 1 a.Num,a.Date,a.Cardno,a.No,a.Flag,a.ApplyString,a.PrintFlag,(a.Flag+a.No) AS BloodNo,b.Name AS cPatientName,(CASE b.Sex WHEN 1 THEN '男' WHEN 2 THEN '女' ELSE '' END) AS CSex,CONVERT(VARCHAR(10),b.Age)+b.AgeUnit AS iYearsOld FROM #temp a LEFT JOIN Lis_OrderMaster b WITH(NOLOCK) ON a.Cardno=b.HospNo
  ORDER BY a.num DESC 
  end
 

  DROP TABLE #BloodStationLIST
  DROP TABLE #temp
 
END

GO