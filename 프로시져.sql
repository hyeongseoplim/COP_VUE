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
	[�Ϲ�����],
	[Ư��(�Ϲݰ���)],
	[Ư��(������������)],
	[������],
	[�����],
	[���ʻ�Ȱ����������],
	[������Ż�ֹ�]
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
�� �ý��� ��		: COP_ProcLogic
�� ����/�������	: COP
--**************************************************************************************/
CREATE Proc dbo.COP_ProcLogic
AS
Begin
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED


	Select 
		UMI.MajorCode
		, UMI.MajorName
		--10	�Ϲ�����	I
		--24	Ư��(�Ϲݰ���)	I
		--13	Ư��(������������)	I
		, Sum(Case When USI.SelectionCode = '10' And Stu.RegistStatus = 1 Then 1 Else 0 End) [�Ϲ�����_�����]
		, Sum(Case When USI.SelectionCode = '10' And Stu.RegistStatus = 0 Then 1 Else 0 End) [�Ϲ�����_�̵����]
		, Sum(Case When USI.SelectionCode = '24' And Stu.RegistStatus = 1 Then 1 Else 0 End) [Ư��(�Ϲݰ���)_�����]
		, Sum(Case When USI.SelectionCode = '24' And Stu.RegistStatus = 0 Then 1 Else 0 End) [Ư��(�Ϲݰ���)_�̵����]
		, Sum(Case When USI.SelectionCode = '13' And Stu.RegistStatus = 1 Then 1 Else 0 End) [Ư��(������������)_�����]
		, Sum(Case When USI.SelectionCode = '13' And Stu.RegistStatus = 0 Then 1 Else 0 End) [Ư��(������������)_�̵����]

		--20	������	O
		--52	�����	O
		--54	���ʻ�Ȱ����������	O
		--57	������Ż�ֹ�	O
		, Sum(Case When USI.SelectionCode = '20' And Stu.RegistStatus = 1 Then 1 Else 0 End) [������_�����]
		, Sum(Case When USI.SelectionCode = '20' And Stu.RegistStatus = 0 Then 1 Else 0 End) [������_�̵����]
		, Sum(Case When USI.SelectionCode = '52' And Stu.RegistStatus = 1 Then 1 Else 0 End) [�����_�����]
		, Sum(Case When USI.SelectionCode = '52' And Stu.RegistStatus = 0 Then 1 Else 0 End) [�����_�̵����]
		, Sum(Case When USI.SelectionCode = '54' And Stu.RegistStatus = 1 Then 1 Else 0 End) [���ʻ�Ȱ����������_�����]
		, Sum(Case When USI.SelectionCode = '54' And Stu.RegistStatus = 0 Then 1 Else 0 End) [���ʻ�Ȱ����������_�̵����]
		, Sum(Case When USI.SelectionCode = '57' And Stu.RegistStatus = 1 Then 1 Else 0 End) [������Ż�ֹ�_�����]
		, Sum(Case When USI.SelectionCode = '57' And Stu.RegistStatus = 0 Then 1 Else 0 End) [������Ż�ֹ�_�̵����]

	From dbo.Stu_CommonInfo Stu
	Inner Join dbo.UnivService_SelectionInfo USI On Stu.SelectionId = USI.SelectionId
	Inner Join dbo.UnivService_MajorInfo UMI On Stu.MajorId = UMI.MajorId
	Where Stu.UnivServiceID = 408401
	And Stu.PassStatus = 1
	Group By UMI.MajorCode
		, UMI.MajorName

End
GO