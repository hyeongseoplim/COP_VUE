USE [COP]
Go

Select
	number,
	ABS(CAST(CAST(NEWID() AS VARBINARY) AS int)) % 10000 / 100 as column3
	--ABS(CAST(CAST(NEWID() AS VARBINARY) AS int)) % 10000 / 1000 % 5 + 1 as column3
From master..spt_values
Where Type = 'P'




--select NEWID()
--select rand()

--Select
--	number,
--	NEWID() as n,
--	rand() as r
--From master..spt_values
--Where Type = 'P'
--and number < 10








/*
USE COP
Go
CREATE TABLE dbo.Stu_CommonInfo(
	SRSID int IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	MajorId int NOT NULL,
	SelectionId int NOT NULL,
	PassOrdinal int NOT NULL,
	PayOrdinal int NOT NULL,
	RefundOrdinal int NOT NULL,
	ExamNo varchar(50) NOT NULL,
	StuName varchar(20) NOT NULL,
	StuSSN varchar(14) NOT NULL,
	PassStatus tinyint NOT NULL,
	EvalStatus tinyint NOT NULL,
	RegistStatus tinyint NOT NULL,
	RefundStatus tinyint NOT NULL,
	MajorRank int NOT NULL,
	SpareRank int NOT NULL,
	UnivServiceId int NOT NULL,
	Rdate datetime NOT NULL,
 CONSTRAINT PK_Stu_CommonInfo PRIMARY KEY CLUSTERED 
(
	UnivServiceId ASC,
	SRSID ASC
)
)
GO

CREATE TABLE dbo.Stu_PayInfo(
	PayId int IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	SRSID int NOT NULL,
	UnivServiceId int NOT NULL,
	ExamNo varchar(20) NOT NULL,
	BankCode varchar(30) NULL,
	BankAccount varchar(30) NOT NULL,
	Amount int NOT NULL,
	PayStatus varchar(20) NULL,
	PayMethod varchar(20) NULL,
	PayDate datetime NULL,
	CancelDate datetime NULL,
	EditLogId int NOT NULL,
	TransNo varchar(50) NULL,
	ManualReason varchar(30) NULL,
 CONSTRAINT PK_Stu_PayInfo PRIMARY KEY NONCLUSTERED 
(
	PayId ASC
)
)
GO


CREATE TABLE dbo.Stu_RefundInfo(
	RefundId int IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	SRSID int NOT NULL,
	UnivServiceId int NOT NULL,
	ExamNo varchar(20) NOT NULL,
	BankCode varchar(50) NULL,
	BankName varchar(50) NULL,
	BankAccountHolder varchar(30) NOT NULL,
	BankAccount varchar(30) NOT NULL,
	RefundStatus varchar(30) NULL,
	RefundMethod varchar(20) NULL,
	RefundTypeCode nvarchar(50) NULL,
	RefundReason varchar(1000) NULL,
	OtherUnivName varchar(200) NULL,
	OtherMajorName varchar(200) NULL,
	RefundReqDate datetime NULL,
	RefundProcDate datetime NULL,
	RefundCompDate datetime NULL,
	EditLogId int NOT NULL,
 CONSTRAINT PK_Stu_RefundInfo PRIMARY KEY NONCLUSTERED 
(
	RefundId ASC
)
)
GO

CREATE TABLE dbo.Stu_TuitionInfo(
	StuTuitionId int IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	SRSID int NOT NULL,
	TuitionId int NOT NULL,
	UnivServiceId int NOT NULL,
	SelectionId int NOT NULL,
	MajorId int NOT NULL,
	TuitionName varchar(50) NOT NULL,
	TuitionOrdering int NOT NULL,
	Amount int NOT NULL,
	StatusCode varchar(50) NOT NULL,
	SelectFlag tinyint NOT NULL,
	PayFlag tinyint NOT NULL,
 CONSTRAINT PK_Stu_TuitionInfo PRIMARY KEY NONCLUSTERED 
(
	StuTuitionId ASC
)
)
GO

CREATE TABLE dbo.UnivService_MajorInfo(
	MajorId int IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	UnivServiceId int NOT NULL,
	CampusCode varchar(100) NOT NULL,
	CampusName varchar(500) NOT NULL,
	CollegeCode varchar(100) NOT NULL,
	CollegeName varchar(500) NOT NULL,
	MajorCode varchar(100) NOT NULL,
	MajorName varchar(500) NOT NULL,
	SubMajorCode varchar(100) NOT NULL,
	MajorNumber int NULL,
	SubMajorName varchar(500) NOT NULL,
	MajorOrder varchar(20) NULL,
 CONSTRAINT PK_UnivService_MajorInfo PRIMARY KEY CLUSTERED 
(
	UnivServiceId ASC,
	MajorId ASC
)
)
GO

CREATE TABLE dbo.UnivService_SelectionInfo(
	SelectionId int IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	UnivServiceId int NOT NULL,
	RecruitTimeCode varchar(100) NOT NULL,
	RecruitTimeName varchar(500) NOT NULL,
	GroupCode varchar(100) NOT NULL,
	GroupName varchar(500) NOT NULL,
	SelectionCode varchar(100) NOT NULL,
	SelectionName varchar(500) NOT NULL,
	SelectionTypeCode char(1) NOT NULL,
 CONSTRAINT PK_UnivService_SelectionInfo PRIMARY KEY CLUSTERED 
(
	UnivServiceId ASC,
	SelectionId ASC
)
)
GO


insert into dbo.UnivService_MajorInfo(
UnivServiceId
, CampusCode
, CampusName
, CollegeCode
, CollegeName
, MajorCode
, MajorName
, SubMajorCode
, SubMajorName
)
values(408401, '1', '본교', '1', '공학', '1', '컴퓨터전자공학과', '', '')
, (408401, '1', '본교', '1', '공학', '3', '전기공학과', '', '')
, (408401, '1', '본교', '1', '공학', '4', '정보통신공학과', '', '')
, (408401, '1', '본교', '1', '공학', '5', '소프트웨어공학과', '', '')
, (408401, '1', '본교', '1', '공학', '7', '건축공학과', '', '')
, (408401, '1', '본교', '1', '공학', '8', '토목공학과', '', '')
, (408401, '1', '본교', '1', '공학', '9', '산업경영학과', '', '')
, (408401, '1', '본교', '1', '공학', '10', '생명화학공학과', '', '')
, (408401, '1', '본교', '1', '공학', '31', '스마트자동차공학과', '', '')
, (408401, '1', '본교', '1', '공학', '52', '컴퓨터전자공학과(야)', '', '')
, (408401, '1', '본교', '1', '공학', '54', '정보통신공학과(야)', '', '')
, (408401, '1', '본교', '1', '공학', '55', '소프트웨어공학과(야)', '', '')
, (408401, '1', '본교', '1', '공학', '57', '건축공학과(야)', '', '')
, (408401, '1', '본교', '1', '공학', '61', '스마트자동차공학과(야)', '', '')
, (408401, '1', '본교', '2', '인문사회', '11', '유아교육학과', '', '')
, (408401, '1', '본교', '2', '인문사회', '12', '자산법률학과', '', '')
, (408401, '1', '본교', '2', '인문사회', '13', '비즈니스영어과', '', '')
, (408401, '1', '본교', '2', '인문사회', '14', '비즈니스일본어과', '', '')
, (408401, '1', '본교', '2', '인문사회', '15', '중국어문화학과', '', '')
, (408401, '1', '본교', '2', '인문사회', '17', '사회복지학과', '', '')
, (408401, '1', '본교', '2', '인문사회', '26', '미디어출판학과', '', '')
, (408401, '1', '본교', '2', '인문사회', '32', '세무회계학과', '', '')
, (408401, '1', '본교', '2', '인문사회', '63', '유아교육학과(야)', '', '')
, (408401, '1', '본교', '2', '인문사회', '70', '비즈니스영어과(야)', '', '')
, (408401, '1', '본교', '3', '자연과학', '18', '간호학과', '', '')
, (408401, '1', '본교', '3', '자연과학', '28', '식품영양학과', '', '')
, (408401, '1', '본교', '4', '예체능', '19', '커뮤니케이션디자인학과', '', '')
, (408401, '1', '본교', '4', '예체능', '20', '생활가구디자인학과', '', '')
, (408401, '1', '본교', '4', '예체능', '21', '실내디자인학과', '', '')
, (408401, '1', '본교', '4', '예체능', '23', '영화방송공연예술학과', '', '')
, (408401, '1', '본교', '4', '예체능', '27', '패션산업학과', '', '')
, (408401, '1', '본교', '4', '예체능', '33', 'VMD전시디자인학과', '', '')
, (408401, '1', '본교', '4', '예체능', '34', '레저스포츠학과', '', '')
, (408401, '1', '본교', '4', '예체능', '72', '커뮤니케이션디자인학과(야)', '', '')
, (408401, '1', '본교', '4', '예체능', '73', '실내디자인학과(야)', '', '')



insert into dbo.UnivService_SelectionInfo
values (408401, '1', '수시1차', '0', '', '20', '대졸자', 'O')
, (408401, '1', '수시1차', '0', '', '13', '특별(전문직업과정)', 'O')
, (408401, '1', '수시1차', '0', '', '52', '농어촌', 'O')
, (408401, '1', '수시1차', '0', '', '24', '특별(일반과정)', 'I')
, (408401, '1', '수시1차', '0', '', '10', '일반전형', 'I')
, (408401, '1', '수시1차', '0', '', '57', '북한이탈주민', 'O')
, (408401, '1', '수시1차', '0', '', '54', '기초생활차상위계층', 'O')

Drop Table IF Exists dbo.SelectionMajor_Personnel
GO
select 
	SelectionId,
	MajorId,
	ABS(CAST(CAST(NEWID() AS VARBINARY) AS int)) % 10000 / 300 + 10 as Personnel
INTO dbo.SelectionMajor_Personnel
From dbo.UnivService_MajorInfo UMI, dbo.UnivService_SelectionInfo USI

truncate table dbo.Stu_CommonInfo
GO
insert into dbo.Stu_CommonInfo(
	UnivServiceId
	, MajorId
	, SelectionId
	, PassOrdinal
	, PayOrdinal
	, RefundOrdinal
	, ExamNo
	, StuName
	, StuSSN
	, PassStatus
	, EvalStatus
	, RegistStatus
	, RefundStatus
	, MajorRank
	, SpareRank
	, Rdate
)
select 
	408401 UnivServiceId
	, MajorId
	, SelectionId
	, 0 PassOrdinal
	, 0 PayOrdinal
	, 0 RefundOrdinal
	, Right('00000000' + Cast(RowNo as varchar), 8) ExamNo
	, '홍길동-' + Cast(RowNo as varchar) StuName
	, '' StuSSN
	, 0 PassStatus
	, 0 EvalStatus
	, 0 RegistStatus
	, 0 RefundStatus
	, 0 MajorRank
	, 0 SpareRank
	, GetDate() Rdate
From
(
	Select
		SelectionId
		, MajorId
		, ROW_NUMBER() OVER(Order By selectionid, majorid, p.number) AS RowNo
	From dbo.SelectionMajor_Personnel A
	inner join master..spt_values P On (A.Personnel * 3) > P.Number
	Where P.Type = 'P'
) Result


--SElect 
--	SRSID,
--	(Case 
--		When RowNo <= Personnel Then 1 
--		Else 0 
--	End) As PassStatus,
--	RowNo AS MajorRank,
--	(Case 
--		When RowNo > Personnel ANd RowNo <= Personnel * 2 Then RowNo - Personnel
--		Else 0 
--	End) As SpareRank
Update S SEt
	S.PassOrdinal = (Case 
		When RowNo <= Personnel Then 1 
		Else 0 
	End),
	S.PassStatus = (Case 
		When RowNo <= Personnel Then 1 
		Else 0 
	End),
	MajorRank = RowNo,
	SpareRank = (Case 
		When RowNo > Personnel ANd RowNo <= Personnel * 2 Then RowNo - Personnel
		Else 0 
	End)
From
(
	select
		ROW_NUMBER() Over(Partition By SC.selectionId, SC.MajorId Order by NEWID()) As RowNo,
		SC.selectionId,
		SC.MajorId,
		Personnel,
		SRSID
	from dbo.Stu_CommonInfo SC
	inner join dbo.SelectionMajor_Personnel P On SC.selectionId = P.selectionId
		And SC.MajorId = P.MajorId
) Result
inner join dbo.Stu_CommonInfo S On Result.SRSID = S.SRSID


Update S SEt S.RegistStatus = 1
From 
(
	select Top 80 Percent
		SRSID
	From dbo.Stu_CommonInfo
	Where PassStatus = 1
	Order By NEWID()
) R
Inner Join dbo.Stu_CommonInfo S On R.SRSID = S.SRSID


Insert Into dbo.Stu_PayInfo(
	UnivServiceId
	, SRSID
	, ExamNo
	, BankCode
	, BankAccount
	, Amount
	, PayStatus
	, PayMethod
	, PayDate
	, EditLogId
)
select
	UnivServiceId
	, SRSID
	, ExamNo
	, '04' BankCode
	, '1234567890' BankAccount
	, 3000000 Amount
	, (Case When PassStatus = 1 And RegistStatus = 1 Then 1 Else 0 End) PayStatus
	, (Case When PassStatus = 1 And RegistStatus = 1 Then 'Virtual' End) PayMethod
	, (Case When PassStatus = 1 And RegistStatus = 1 Then GetDate() - (ABS(CAST(CAST(NEWID() AS VARBINARY) AS int)) % 10000 / 1000) End) PayDate
	, 0 AS EditLogId
From dbo.Stu_CommonInfo


Insert INto dbo.Stu_TuitionInfo(
	UnivServiceId
	, SRSID
	, TuitionId
	, SelectionId
	, MajorId
	, TuitionName
	, TuitionOrdering
	, Amount
	, StatusCode
	, SelectFlag
	, PayFlag
)
select 
	UnivServiceId
	, SRSID
	, 0 TuitionId
	, SelectionId
	, MajorId
	, TuitionName
	, TuitionOrdering
	, Amount
	, 'EM' StatusCode
	, 1 SelectFlag
	, RegistStatus as PayFlag
From dbo.Stu_CommonInfo S
cross join (
	select 1 As TuitionOrdering, '입학금' as TuitionName, 1000000 AS Amount UNION ALL
	select 2 As TuitionOrdering, '수업료' as TuitionName, 2000000 AS Amount
) T
Order BY SRSID

*/