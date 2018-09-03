

CREATE VIEW [dbo].[BloodUser] AS

  SELECT UserID,UserName,PassWord FROM Users

GO

--更新采血信息
CREATE PROCEDURE [dbo].[UP_BloodStation_UpdateCollectionInformation]  
@CollectionDate VARCHAR(20),
@CollectionUserCode VARCHAR(20),
@CollectionUserName VARCHAR(20),
@Applyno VARCHAR(20) 
AS
BEGIN

  update Lis_AcceptItems set DrawDate=@CollectionDate,DrawUserCode=@CollectionUserCode,DrawUserName=@CollectionUserName 
  WHERE txm=@Applyno
 
END

GO


CREATE TABLE [dbo].[BloodCallLIST](
	[Num] [INT] IDENTITY(1,1) NOT NULL,
	[PatientName] [VARCHAR](20) NULL,
	[WindowName] [VARCHAR](50) NULL,
	[CallText] [VARCHAR](MAX) NULL,
	[CallFlag] [INT] NULL,
 CONSTRAINT [PK_BloodCallLIST] PRIMARY KEY CLUSTERED 
(
	[Num] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

ALTER TABLE [dbo].[BloodCallLIST] ADD  CONSTRAINT [DF_BloodCallLIST_CallFlag]  DEFAULT ((0)) FOR [CallFlag]
GO


