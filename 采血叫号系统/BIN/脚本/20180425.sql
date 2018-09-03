 
 
--查询当前窗口采血人次信息
CREATE PROCEDURE [dbo].[UP_BloodStationFindBloodSLbyWindow]   
@DATE VARCHAR(10),
@WindowNum INT  
AS
BEGIN
 SELECT COUNT(*) AS sl
 FROM  BloodStationLIST 
 WHERE PrintFlag=0 AND Date=@DATE AND windowNum=@WindowNum

END

GO



