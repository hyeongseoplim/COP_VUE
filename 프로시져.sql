/*
dbo.Stu_CommonInfo_4084
	ExamNo
	StuName
	PassStatus
	RegistStatus
dbo.Stu_PayInfo_4084
	Amount
	PayDate
dbo.Stu_TuitionInfo_4084
	TuitionName
	Amount
	PayFlag
dbo.UnivService_SelectionInfo_4084
	RecruitTimeCode
	RecruitTimeName
	SelectionCode
	SelectionName
	SelectionTypeCode
dbo.UnivService_MajorInfo_4084
	MajorCode
	MajorName
*/

/*

Select
	*
From
(
	Select 
		Stu.RegistStatus,
		USI.SelectionName,
		UMI.MajorCode,
		UMI.MajorName
	From dbo.Stu_CommonInfo_4084 Stu
	Inner Join dbo.UnivService_SelectionInfo_4084 USI On Stu.SelectionId = USI.SelectionId
	Inner Join dbo.UnivService_MajorInfo_4084 UMI On Stu.MajorId = UMI.MajorId
	Where Stu.UnivServiceID = 408401
	And Stu.PassStatus = 1
) Result
PIVOT(SUM(RegistStatus) FOR [SelectionName] IN (
	[일반전형],
	[특별(일반과정)],
	[특별(전문직업과정)],
	[대졸자],
	[농어촌],
	[기초생활차상위계층],
	[북한이탈주민]
)) As PVT
Order By MajorCode

*/
USE PIMSV2
Go
Set Statistics IO ON
Set Statistics TIME ON

Drop Proc If Exists dbo.COP_ProcLogic
GO
/***************************************************************************************
▒ 시스템 상세		: COP_ProcLogic
▒ 주의/참고사항	: COP
--**************************************************************************************/
CREATE Proc dbo.COP_ProcLogic
AS
Begin
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED


	Select 
		UMI.MajorCode
		, UMI.MajorName
		--10	일반전형	I
		--24	특별(일반과정)	I
		--13	특별(전문직업과정)	I
		, Sum(Case When USI.SelectionCode = '10' And Stu.RegistStatus = 1 Then 1 Else 0 End) [일반전형_등록자]
		, Sum(Case When USI.SelectionCode = '10' And Stu.RegistStatus = 0 Then 1 Else 0 End) [일반전형_미등록자]
		, Sum(Case When USI.SelectionCode = '24' And Stu.RegistStatus = 1 Then 1 Else 0 End) [특별(일반과정)_등록자]
		, Sum(Case When USI.SelectionCode = '24' And Stu.RegistStatus = 0 Then 1 Else 0 End) [특별(일반과정)_미등록자]
		, Sum(Case When USI.SelectionCode = '13' And Stu.RegistStatus = 1 Then 1 Else 0 End) [특별(전문직업과정)_등록자]
		, Sum(Case When USI.SelectionCode = '13' And Stu.RegistStatus = 0 Then 1 Else 0 End) [특별(전문직업과정)_미등록자]

		--20	대졸자	O
		--52	농어촌	O
		--54	기초생활차상위계층	O
		--57	북한이탈주민	O
		, Sum(Case When USI.SelectionCode = '20' And Stu.RegistStatus = 1 Then 1 Else 0 End) [대졸자_등록자]
		, Sum(Case When USI.SelectionCode = '20' And Stu.RegistStatus = 0 Then 1 Else 0 End) [대졸자_미등록자]
		, Sum(Case When USI.SelectionCode = '52' And Stu.RegistStatus = 1 Then 1 Else 0 End) [농어촌_등록자]
		, Sum(Case When USI.SelectionCode = '52' And Stu.RegistStatus = 0 Then 1 Else 0 End) [농어촌_미등록자]
		, Sum(Case When USI.SelectionCode = '54' And Stu.RegistStatus = 1 Then 1 Else 0 End) [기초생활차상위계층_등록자]
		, Sum(Case When USI.SelectionCode = '54' And Stu.RegistStatus = 0 Then 1 Else 0 End) [기초생활차상위계층_미등록자]
		, Sum(Case When USI.SelectionCode = '57' And Stu.RegistStatus = 1 Then 1 Else 0 End) [북한이탈주민_등록자]
		, Sum(Case When USI.SelectionCode = '57' And Stu.RegistStatus = 0 Then 1 Else 0 End) [북한이탈주민_미등록자]

	From dbo.Stu_CommonInfo Stu
	Inner Join dbo.UnivService_SelectionInfo USI On Stu.SelectionId = USI.SelectionId
	Inner Join dbo.UnivService_MajorInfo UMI On Stu.MajorId = UMI.MajorId
	Where Stu.UnivServiceID = 408401
	And Stu.PassStatus = 1
	Group By UMI.MajorCode
		, UMI.MajorName

End
GO