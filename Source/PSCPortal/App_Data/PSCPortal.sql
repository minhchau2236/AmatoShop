SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
IF EXISTS (SELECT * FROM tempdb..sysobjects WHERE id=OBJECT_ID('tempdb..#tmpErrors')) DROP TABLE #tmpErrors
GO
CREATE TABLE #tmpErrors (Error int)
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO
BEGIN TRANSACTION
GO
PRINT N'Creating [dbo].[Article]'
GO
CREATE TABLE [dbo].[Article]
(
[ArticleId] [uniqueidentifier] NOT NULL,
[ArticleName] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ArticleTitle] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ArticleCreatedDate] [datetime] NOT NULL,
[ArticleModifiedDate] [datetime] NOT NULL,
[ArticleIsPublish] [bit] NOT NULL,
[PageId] [uniqueidentifier] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Article] on [dbo].[Article]'
GO
ALTER TABLE [dbo].[Article] ADD CONSTRAINT [PK_Article] PRIMARY KEY CLUSTERED ([ArticleId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[ArticleBelongTopic]'
GO
CREATE TABLE [dbo].[ArticleBelongTopic]
(
[ArticleId] [uniqueidentifier] NOT NULL,
[TopicId] [uniqueidentifier] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_ArticleBelongTopic] on [dbo].[ArticleBelongTopic]'
GO
ALTER TABLE [dbo].[ArticleBelongTopic] ADD CONSTRAINT [PK_ArticleBelongTopic] PRIMARY KEY CLUSTERED ([ArticleId], [TopicId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[User]'
GO
CREATE TABLE [dbo].[User]
(
[UserId] [uniqueidentifier] NOT NULL,
[UserName] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Password] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Email] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PasswordQuestion] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PasswordAnswer] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreationDate] [datetime] NOT NULL,
[LastActivityDate] [datetime] NOT NULL,
[LastLoginDate] [datetime] NOT NULL,
[LastPasswordChangeDate] [datetime] NOT NULL,
[IsApproved] [bit] NOT NULL,
[IsOnline] [bit] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_User] on [dbo].[User]'
GO
ALTER TABLE [dbo].[User] ADD CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED ([UserId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[User_Update]'
GO

CREATE PROCEDURE [dbo].User_Update
(
	@UserID uniqueidentifier,
	@UserName nvarchar(250),
	@Password nvarchar(250),
	@Email nvarchar(250),
	@CreationDate datetime,
	@LastActivityDate datetime,
	@LastLoginDate datetime,
	@LastPasswordChangeDate datetime,
	@PasswordQuestion nvarchar(250),
	@PasswordAnswer nvarchar(250),
	@IsApproved nvarchar(250),
	@IsOnline bit
)
AS

UPDATE dbo.[User] 
SET 
	[UserName] = @UserName, 
	[Email] = @Email, 
	[PasswordQuestion] = @PasswordQuestion, 
	[PasswordAnswer] = @PasswordAnswer, 
	[CreationDate] = @CreationDate, 
	[LastActivityDate] = @LastActivityDate, 
	[LastLoginDate] = @LastLoginDate, 
	[LastPasswordChangeDate] = @LastPasswordChangeDate, 
	[IsApproved] = @IsApproved, 
	[IsOnline] = @IsOnline 
WHERE 
	[UserId] = @UserId

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[ArticleDetail]'
GO
CREATE TABLE [dbo].[ArticleDetail]
(
[ArticleId] [uniqueidentifier] NOT NULL,
[ArticleDescription] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ArticleContent] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_ArticleDetail] on [dbo].[ArticleDetail]'
GO
ALTER TABLE [dbo].[ArticleDetail] ADD CONSTRAINT [PK_ArticleDetail] PRIMARY KEY CLUSTERED ([ArticleId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Article_GetDescription]'
GO
CREATE PROCEDURE Article_GetDescription
(
	@ArticleId uniqueidentifier
)
AS
SELECT [ArticleDescription] 
FROM dbo.[ArticleDetail] 
where [ArticleId]=@ArticleId

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[User_Delete]'
GO

CREATE PROCEDURE [dbo].User_Delete
(
	@UserID uniqueidentifier
)
AS

DELETE dbo.[User] 
WHERE 
	[UserId] = @UserId

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Article_UpdateDescription]'
GO
CREATE PROCEDURE Article_UpdateDescription
(
	@ArticleId uniqueidentifier,
	@ArticleDescription ntext
)
AS
UPDATE dbo.[ArticleDetail] 
SET 
	[ArticleDescription] = @ArticleDescription 
where [ArticleId] = @ArticleId

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[User_UpdatePass]'
GO

CREATE PROCEDURE [dbo].User_UpdatePass
(
	@UserName nvarchar(250),
	@Password nvarchar(250)
)
AS

Update dbo.[User] 
SET 
	[Password] = @Password 
WHERE [UserName] = @UserName

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Article_GetContent]'
GO
CREATE PROCEDURE Article_GetContent
(
	@ArticleId uniqueidentifier
)
AS
SELECT [ArticleContent] 
FROM dbo.[ArticleDetail] 
where [ArticleId]=@ArticleId

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Article_UpdateContent]'
GO
CREATE PROCEDURE Article_UpdateContent
(
	@ArticleId uniqueidentifier,
	@ArticleContent ntext
)
AS
UPDATE dbo.[ArticleDetail] 
SET [ArticleContent] = @ArticleContent 
where [ArticleId] = @ArticleId

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Article_AddTopicBelong]'
GO
CREATE PROCEDURE Article_AddTopicBelong
(
	@ArticleId uniqueidentifier,
	@TopicId uniqueidentifier
)
AS
INSERT INTO dbo.[ArticleBelongTopic]
(
	[ArticleId],
	[TopicId]
) 
VALUES 
(
	@ArticleId,
	@TopicId
)

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[User_GetAll]'
GO

CREATE PROCEDURE [dbo].User_GetAll
AS

SELECT 
	[UserId],
	[UserName],
	[Password],
	[Email],
	[PasswordQuestion],
	[PasswordAnswer],
	[CreationDate],
	[LastActivityDate],
	[LastLoginDate],
	[LastPasswordChangeDate],
	[IsApproved],
	[IsOnline] 
FROM 
	dbo.[User]

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Article_GetArticleById]'
GO
CREATE PROCEDURE Article_GetArticleById
(
	@ArticleId uniqueidentifier
)
AS
SELECT 
	[ArticleId],
	[ArticleName],
	[ArticleTitle],
	[ArticleCreatedDate],
	[ArticleModifiedDate],
	[ArticleIsPublish], 
	[PageId] 
FROM 
	dbo.[Article] 
WHERE 
	[ArticleId] = @ArticleId 
	AND [ArticleIspublish] = 1

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[UserInRole]'
GO
CREATE TABLE [dbo].[UserInRole]
(
[UserId] [uniqueidentifier] NOT NULL,
[RoleId] [uniqueidentifier] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_UserInRole] on [dbo].[UserInRole]'
GO
ALTER TABLE [dbo].[UserInRole] ADD CONSTRAINT [PK_UserInRole] PRIMARY KEY CLUSTERED ([UserId], [RoleId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Role]'
GO
CREATE TABLE [dbo].[Role]
(
[RoleId] [uniqueidentifier] NOT NULL,
[RoleName] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[RoleDescription] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Role] on [dbo].[Role]'
GO
ALTER TABLE [dbo].[Role] ADD CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED ([RoleId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Article_DeleteTopicBelong]'
GO
CREATE PROCEDURE Article_DeleteTopicBelong
(
	@ArticleId uniqueidentifier,
	@TopicId uniqueidentifier
)
AS
DELETE dbo.[ArticleBelongTopic] 
WHERE 
		ArticleId=@ArticleId 
	AND TopicId=@TopicId

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Role_GetRolesNotBelongToUser]'
GO
CREATE PROCEDURE [dbo].[Role_GetRolesNotBelongToUser]
(
	@UserId uniqueidentifier
)
AS

SELECT RoleId 
INTO 
	#ROLE_ID
FROM 
	dbo.[UserInRole] 
WHERE 
	UserId = @UserId

SELECT 
	a.[RoleId],
	[RoleName],
	[RoleDescription] 
FROM 
	dbo.[Role] a 
	LEFT JOIN #ROLE_ID b ON a.[RoleId] = b.[RoleId]
WHERE 
	b.RoleId IS NULL

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Topic]'
GO
CREATE TABLE [dbo].[Topic]
(
[TopicId] [uniqueidentifier] NOT NULL,
[TopicName] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[TopicDescription] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[TopicParent] [uniqueidentifier] NULL,
[PageId] [uniqueidentifier] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Topic] on [dbo].[Topic]'
GO
ALTER TABLE [dbo].[Topic] ADD CONSTRAINT [PK_Topic] PRIMARY KEY CLUSTERED ([TopicId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[User_GetUsersInRole]'
GO

CREATE PROCEDURE [dbo].[User_GetUsersInRole]
(
	@RoleId uniqueidentifier
)
AS

SELECT 
	a.[UserId],
	[UserName],
	[Password],
	[Email],
	[PasswordQuestion],
	[PasswordAnswer],
	[CreationDate],
	[LastActivityDate],
	[LastLoginDate],
	[LastPasswordChangeDate],
	[IsApproved],
	[IsOnline] 
FROM 
	dbo.[User] a
	INNER JOIN dbo.[UserInRole] b ON a.UserId = b.UserId
WHERE 
	RoleId=@RoleId


GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[ArticleBelongTopicPrimary]'
GO
CREATE TABLE [dbo].[ArticleBelongTopicPrimary]
(
[ArticleId] [uniqueidentifier] NOT NULL,
[TopicId] [uniqueidentifier] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_ArticleBelongTopicPrimary] on [dbo].[ArticleBelongTopicPrimary]'
GO
ALTER TABLE [dbo].[ArticleBelongTopicPrimary] ADD CONSTRAINT [PK_ArticleBelongTopicPrimary] PRIMARY KEY CLUSTERED ([ArticleId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Article_SetTopicBelongPrimary]'
GO
CREATE PROCEDURE Article_SetTopicBelongPrimary
(
	@ArticleId uniqueidentifier,
	@TopicId uniqueidentifier
)
AS
IF (EXISTS(SELECT 1 FROM dbo.[ArticleBelongTopicPrimary] WHERE ArticleId=@ArticleId))
BEGIN
	UPDATE dbo.[ArticleBelongTopicPrimary]
	SET 
		TopicId = @TopicId 
	WHERE 
		ArticleId=@ArticleId 
END
ELSE
BEGIN
	INSERT INTO dbo.[ArticleBelongTopicPrimary]
	(
		ArticleId, 
		TopicId
	) 
	VALUES 
	(
		@ArticleId, 
		@TopicId
	)
END

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[UserInRole_Insert]'
GO

CREATE PROCEDURE [dbo].UserInRole_Insert
(
	@UserId uniqueidentifier,
	@RoleId uniqueidentifier
)
AS

INSERT INTO dbo.[UserInRole] 
(
	[UserId],
	[RoleId]
) 
VALUES 
(
	@UserId,
	@RoleId
)

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Article_GetTopicBelongPrimary]'
GO
CREATE PROCEDURE [dbo].[Article_GetTopicBelongPrimary]
(
	@ArticleId uniqueidentifier
)
AS
SELECT 
	t.TopicId, 
	TopicName, 
	TopicDescription 
FROM 
	dbo.[Topic] t 
	INNER JOIN dbo.[ArticleBelongTopicPrimary] abt ON t.TopicId=abt.TopicId 
WHERE 
	ArticleId = @ArticleId 

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[UserInRole_Update]'
GO

CREATE PROCEDURE [dbo].UserInRole_Update
(
	@UserId uniqueidentifier,
	@RoleId uniqueidentifier
)
AS

UPDATE dbo.[UserInRole] 
SET 
	[RoleId] = @RoleId 
WHERE 
	[UserId] = @UserId

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Article_GetSelectAll]'
GO
CREATE PROCEDURE [dbo].[Article_GetSelectAll]
AS
SELECT 
	[ArticleId],
	[ArticleName],
	[ArticleTitle],
	[ArticleCreatedDate],
	[ArticleModifiedDate],
	[ArticleIsPublish], 
	[PageId] 
FROM 
	dbo.[Article]

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[UserInRole_Delete]'
GO

CREATE PROCEDURE [dbo].UserInRole_Delete
(
	@UserId uniqueidentifier,
	@RoleId uniqueidentifier
)
AS

DELETE dbo.[UserInRole] 
WHERE 
	[UserId] = @UserId 
	and [RoleId]=@RoleId

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Article_GetSelectAllByTopicId]'
GO

CREATE PROCEDURE Article_GetSelectAllByTopicId
(
	@TopicId uniqueidentifier	
)
AS
SELECT 
	a.[ArticleId],
	[ArticleName],
	[ArticleTitle],
	[ArticleCreatedDate],
	[ArticleModifiedDate],
	[ArticleIsPublish], 
	[PageId] 
FROM dbo.[Article] a
	INNER JOIN dbo.[ArticleBelongTopic] b ON b.ArticleId = a.ArticleId
where  
	b.TopicId = @TopicId

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[UserInRole_FilterByNotEqualingRoleId]'
GO

CREATE PROCEDURE [dbo].UserInRole_FilterByNotEqualingRoleId
(
	@RoleId uniqueidentifier
)
AS

SELECT Distinct 
	[UserId],
	[RoleId] 
FROM 
	dbo.UserInRole 
where 
	RoleId<>@RoleID

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Article_GetPublishedArticlesByTopicId]'
GO

CREATE PROCEDURE Article_GetPublishedArticlesByTopicId
(
	@TopicId uniqueidentifier	
)
AS
SELECT 
	a.[ArticleId],
	[ArticleName],
	[ArticleTitle],
	[ArticleCreatedDate],
	[ArticleModifiedDate],
	[ArticleIsPublish], 
	[PageId] 
FROM 
	dbo.[Article] a
	INNER JOIN dbo.[ArticleBelongTopic] b ON b.ArticleId = a.ArticleId 
where 
	b.TopicId=@TopicId and a.ArticleIsPublish=1 
ORDER BY 
	ArticleCreatedDate DESC

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[UserInRole_FilterByNotEqualingUserId]'
GO

CREATE PROCEDURE [dbo].UserInRole_FilterByNotEqualingUserId
(
	@UserId uniqueidentifier
)
AS

SELECT Distinct 
	[UserId],
	[RoleId] 
FROM 
	dbo.UserInRole 
where 
	UserId<>@UserId

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Article_GetAllInTrash]'
GO
CREATE PROCEDURE [dbo].[Article_GetAllInTrash]
AS
-- Các bài viết có topic
SELECT DISTINCT [ArticleId] 
INTO #ART -- DS các [Bài viết - Article] thuộc ít nhất 1 [Chủ đề - Topic]
FROM dbo.[ArticleBelongTopic]

SELECT 
	a.[ArticleId],
	[ArticleName],
	[ArticleTitle],
	[ArticleCreatedDate],
	[ArticleModifiedDate],
	[ArticleIsPublish] 
FROM 
	dbo.[Article] a
	LEFT JOIN #ART b ON a.[ArticleId] = b.[ArticleId]
WHERE b.[ArticleId] IS NULL
--[ArticleId] NOT IN (SELECT [ArticleId] FROM dbo.[ArticleBelongTopic])

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[UserInRole_FilterByEqualingUserId]'
GO

CREATE PROCEDURE [dbo].UserInRole_FilterByEqualingUserId
(
	@UserId uniqueidentifier
)
AS

SELECT 
	[RoleID],
	[UserID] 
FROM 
	dbo.UserInRole 
Where 
	UserID=@UserID

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Article_GetArticlesNoBelongTopicPrimary]'
GO

CREATE PROCEDURE Article_GetArticlesNoBelongTopicPrimary
AS
SELECT 
	a.[ArticleId]
INTO 
	#TMP
FROM 
	dbo.[Article]  a
	LEFT JOIN  dbo.ArticleBelongTopicPrimary b ON a.[ArticleId] = b.[ArticleId]
WHERE 
	b.[ArticleId] IS NULL
	
	
SELECT 
	a.[ArticleId] , 
	Count(*) AS [NumbeOfTopics]
INTO 
	#TMP2
FROM
	 #TMP a
	LEFT JOIN dbo.ArticleBelongTopic b ON a.[ArticleId] = b.[ArticleId]
WHERE 
	b.[ArticleId] IS NOT NULL
GROUP BY 
	a.[ArticleId]

-- Chọn các bài viết thỏa tiêu chí
INSERT dbo.ArticleBelongTopicPrimary
(
	ArticleId, 
	TopicId
)
SELECT 
	a.ArticleId, 
	b.TopicId
FROM 
	#TMP2 a
	INNER JOIN dbo.ArticleBelongTopic b ON a.[ArticleId] = b.[ArticleId]
WHERE [NumbeOfTopics] = 1

-- Lấy kết quả cuổi cùng
SELECT 
	b.[ArticleId], 
	[ArticleName],
	[ArticleTitle],
	[ArticleCreatedDate],
	[ArticleModifiedDate],
	[ArticleIsPublish]
FROM #TMP2 a
	INNER JOIN dbo.[Article] b ON a.[ArticleId] = b.[ArticleId]
WHERE 
	[NumbeOfTopics] > 1
	
DROP TABLE #TMP
DROP TABLE #TMP2

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[UserInRole_FilterByEqualingRoleId]'
GO

CREATE PROCEDURE [dbo].UserInRole_FilterByEqualingRoleId
(
	@RoleId uniqueidentifier
)
AS

SELECT 
	[RoleID],
	[UserID] 
FROM 
	dbo.UserInRole 
Where 
	RoleID=@RoleId

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Article_DeleteFromDatabase]'
GO

CREATE PROCEDURE Article_DeleteFromDatabase
	@ArticleId uniqueidentifier
AS

Delete 
	dbo.[Article] 
where 
	ArticleId=@ArticleId

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[FeedBack]'
GO
CREATE TABLE [dbo].[FeedBack]
(
[FeedBackId] [uniqueidentifier] NOT NULL,
[FeedBackSenderName] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[FeedBackSenderEmail] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[FeedBackPhone] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[FeedBackContent] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_FeedBack] on [dbo].[FeedBack]'
GO
ALTER TABLE [dbo].[FeedBack] ADD CONSTRAINT [PK_FeedBack] PRIMARY KEY CLUSTERED ([FeedBackId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[FeedBack_Insert]'
GO

CREATE PROCEDURE FeedBack_Insert
(
	@FeedBackId uniqueidentifier,
	@FeedBackSenderName nvarchar(250),
	@FeedBackSenderEmail nvarchar(250),
	@FeedBackPhone nvarchar(250),
	@FeedBackContent ntext
)
AS

INSERT INTO dbo.[FeedBack] 
(
	[FeedBackId],
	[FeedBackSenderName],
	[FeedBackSenderEmail],
	[FeedBackPhone],
	[FeedBackContent]
) 
VALUES 
(
	@FeedBackId,
	@FeedBackSenderName,
	@FeedBackSenderEmail,
	@FeedBackPhone,
	@FeedBackContent
)

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[FeedBack_Update]'
GO

CREATE PROCEDURE FeedBack_Update
(
	@FeedBackId uniqueidentifier,
	@FeedBackSenderName nvarchar(250),
	@FeedBackSenderEmail nvarchar(250),
	@FeedBackPhone nvarchar(250),
	@FeedBackContent ntext
)
AS

UPDATE dbo.[FeedBack] 
SET 
	[FeedBackSenderName] = @FeedBackSenderName, 
	[FeedBackSenderEmail] = @FeedBackSenderEmail, 
	[FeedBackPhone] = @FeedBackPhone, 
	[FeedBackContent] = @FeedBackContent 
WHERE 
	[FeedBackId] = @FeedBackId

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[FeedBack_Delete]'
GO

CREATE PROCEDURE FeedBack_Delete
(
	@FeedBackId uniqueidentifier
)
AS

DELETE [FeedBack] 
WHERE 
	[FeedBackId] = @FeedBackId


GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[FeedBack_GetAll]'
GO

CREATE PROCEDURE FeedBack_GetAll
AS
SELECT 
	[FeedBackId],
	[FeedBackSenderName],
	[FeedBackSenderEmail],
	[FeedBackPhone],
	[FeedBackContent] 
FROM 
	dbo.[FeedBack]

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Menu]'
GO
CREATE TABLE [dbo].[Menu]
(
[MenuId] [uniqueidentifier] NOT NULL,
[MenuName] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[MenuDescription] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[MenuNavigationURL] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[MenuOrder] [int] NULL,
[MenuParent] [uniqueidentifier] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Menu] on [dbo].[Menu]'
GO
ALTER TABLE [dbo].[Menu] ADD CONSTRAINT [PK_Menu] PRIMARY KEY CLUSTERED ([MenuId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Menu_Insert]'
GO

CREATE PROCEDURE Menu_Insert
(
	@MenuId uniqueidentifier,
	@MenuName nvarchar(250),
	@MenuDescription nvarchar(250),
	@MenuNavigationURL nvarchar(250), 
	@MenuOrder int = 0,
	@MenuParent uniqueidentifier
)
AS
INSERT INTO dbo.[Menu] 
(
	[MenuId],
	[MenuName],
	[MenuDescription],
	[MenuNavigationURL],
	[MenuOrder],
	[MenuParent]
) 
VALUES 
(
	@MenuId,
	@MenuName,
	@MenuDescription,
	@MenuNavigationURL, 
	@MenuOrder,
	@MenuParent
)

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Menu_Update]'
GO

CREATE PROCEDURE Menu_Update
(
	@MenuId uniqueidentifier,
	@MenuName nvarchar(250),
	@MenuDescription nvarchar(250),
	@MenuNavigationURL nvarchar(250), 
	--@MenuOrder int = 0,
	@MenuParent uniqueidentifier
)
AS
UPDATE dbo.[Menu] 
SET 
	[MenuName] = @MenuName, 
	[MenuDescription] = @MenuDescription, 
	[MenuNavigationURL] = @MenuNavigationURL, 
	[MenuParent] = @MenuParent 
WHERE [MenuId] = @MenuId

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Menu_Delete]'
GO

CREATE PROCEDURE Menu_Delete
(
	@MenuId uniqueidentifier
)
AS
-- tạo bảng tạm chứa các mẩu tin sẽ bị xóa
create table #temp
(
	stt int identity(0,1),
	MenuId uniqueidentifier
)

insert into #temp (MenuId) values(@MenuId)

-- duyệt lấy ra tất cà các mẩu tin cần xóa
declare @index int
set @index = 0
declare @max int
set @max = 0
declare @temp uniqueidentifier

while(@index<=@max) 
begin 
	set @temp = (select MenuId from #temp where stt=@index)
	insert into #temp (MenuId) 
	select MenuId 
	from Menu 
	where MenuParent=@temp
	set @index = @index + 1
	set @max = (select max(stt) from #temp)
end 

-- Xóa tất các mẩu tin thuộc kết quả sau khi duyệt
delete dbo.[Menu] 
from 
	dbo.[Menu] a
	inner join #temp b on a.MenuId = b.MenuId

--where MenuId in (select MenuId from #temp)
            

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[MenuMaster]'
GO
CREATE TABLE [dbo].[MenuMaster]
(
[MenuMasterId] [uniqueidentifier] NOT NULL,
[MenuMasterName] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[MenuMasterDescription] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[MenuId] [uniqueidentifier] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_MenuMaster] on [dbo].[MenuMaster]'
GO
ALTER TABLE [dbo].[MenuMaster] ADD CONSTRAINT [PK_MenuMaster] PRIMARY KEY CLUSTERED ([MenuMasterId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[MenuMaster_CopyMenu]'
GO
CREATE procedure [dbo].[MenuMaster_CopyMenu]
(
	@SourceMenuMasterId uniqueidentifier,
	@DestMenuMasterId uniqueidentifier,
	@DestMenuMasterName nvarchar(500),
	@DestMenuMasterDescription nvarchar(500)
)
AS	

-- Lấy thông tin khóa của nút menu gốc ứng với giá trị của MenuId trong 
declare @RootMenuId uniqueidentifier
declare @RootMenuId_NEW uniqueidentifier 

select 	top 1 @RootMenuId = MenuId , 
		@RootMenuId_NEW = newid()
from dbo.[MenuMaster] 
where [MenuMasterId] = @SourceMenuMasterId

/* Đọc dữ liệu lên kiểm tra
select 
	@SourceMenuMasterId as SourceMenuMasterId,
	@DestMenuMasterId as DestMenuMasterId,
	@DestMenuMasterName as DestMenuMasterName,                                      
	@DestMenuMasterDescription as DestMenuMasterDescription,
	@RootMenuId_NEW as RootMenuId_NEW
*/
create table #temp
	(
		stt int identity(0,1), 
		MenuId uniqueidentifier, 
		MenuId_NEW uniqueidentifier,
		MenuName nvarchar(250), 
		MenuDescription nvarchar(250), 
		MenuNavigationURL nvarchar(250),
		MenuOrder int, 
		MenuParent uniqueidentifier,
		MenuParent_NEW uniqueidentifier
	)
					
insert into #temp
	(
		MenuId,
		MenuId_NEW,
		MenuName, 
		MenuDescription, 
		MenuNavigationURL,
		MenuOrder, 
		MenuParent,
		MenuParent_NEW
	) 
				
select	MenuId, 
		@RootMenuId_NEW AS [MenuId_NEW],
		MenuName,
		MenuDescription, 
		MenuNavigationURL,
		MenuOrder, 
		MenuParent,
		NULL AS MenuParent_NEW
from dbo.Menu 
where MenuId = @RootMenuId --AND MenuParent is null

declare @index int
set @index = 0

declare @max int
set @max = (select max(stt) from #temp)

declare @curMenuId uniqueidentifier
declare @curMenuId_NEW uniqueidentifier
while(@index<=@max) 
begin 
	select @curMenuId = MenuId, 
		@curMenuId_NEW = MenuId_NEW
	from #temp 
	where stt=@index
	
	insert into #temp
		(
			MenuId, 
			MenuId_NEW,
			MenuName, 
			MenuDescription, 
			MenuNavigationURL,
			MenuOrder, 
			MenuParent,
			MenuParent_NEW
		) 
	select 
			MenuId, 
			newid() AS MenuId_NEW,
			MenuName, 
			MenuDescription, 
			MenuNavigationURL,
			MenuOrder, 
			MenuParent,
			@curMenuId_NEW AS MenuParent_NEW
	from dbo.[Menu]
	where MenuParent=@curMenuId
	
	set @index=@index +1
	set @max=(select max(stt) from #temp)-- order by MenuOrder
end 

-- Đẩy dữ liệu vào bảng Menu
alter table dbo.[Menu]
disable trigger all

insert dbo.[Menu]
(
		MenuId, 
		MenuName, 
		MenuDescription, 
		MenuNavigationURL,
		MenuOrder, 
		MenuParent 
)
select 
		MenuId_NEW, 
		MenuName, 
		MenuDescription, 
		MenuNavigationURL,
		MenuOrder, 
		MenuParent_NEW 
from #temp

-- Đẩy dữ liệu vào bảng MasterMenu
INSERT [dbo].[MenuMaster]
(
		[MenuMasterId]
      ,[MenuMasterName]
      ,[MenuMasterDescription]
      ,[MenuId]
)
VALUES
(
	@DestMenuMasterId,
	@DestMenuMasterName,
	@DestMenuMasterDescription,
	@RootMenuId_NEW
)

alter table dbo.[Menu]
enable trigger all

drop table #temp

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Topic_CopyTo]'
GO
CREATE procedure [dbo].[Topic_CopyTo]
(
	@SourceTopicId uniqueidentifier,
	@DestTopicId uniqueidentifier,
	@DestTopicName nvarchar(500),
	@DestTopicDescription nvarchar(500),
	@DestPageId uniqueidentifier
)
AS

if (@SourceTopicId = '00000000-0000-0000-0000-000000000000')
	return

create table #temp
	(
		stt int identity(0,1), 
		TopicId uniqueidentifier, 
		TopicId_NEW uniqueidentifier,
		TopicName nvarchar(250), 
		TopicDescription nvarchar(250), 
		TopicParent uniqueidentifier, 
		TopicParent_NEW uniqueidentifier, 
		PageId uniqueidentifier
	) 
	
insert into #temp
	(
		TopicId, 
		TopicId_NEW,
		TopicName, 
		TopicDescription, 
		TopicParent, 
		TopicParent_NEW,
		PageId
	) 
select 
		TopicId, 
		@DestTopicId AS TopicId_NEW,
		@DestTopicName, 
		@DestTopicDescription, 
		TopicParent,
		--(case when @SourceTopicId = '00000000-0000-0000-0000-000000000000' then NULL else '00000000-0000-0000-0000-000000000000' end)AS TopicParent_NEW, 
		'00000000-0000-0000-0000-000000000000' AS TopicParent_NEW, 
		@DestPageId 
from Topic 
where TopicId = @SourceTopicId

declare @index int 
set @index = 0 
declare @max int 
set @max = (select max(stt) from #temp) 

declare @CurTopicId uniqueidentifier 
declare @CurTopicId_NEW uniqueidentifier 

while(@index<=@max) 
begin 
	select @CurTopicId = TopicId,
			@CurTopicId_NEW = TopicId_NEW		
	from #temp where stt=@index
	
	insert into #temp
		(
			TopicId, 
			TopicId_NEW,
			TopicName, 
			TopicDescription, 
			TopicParent, 
			TopicParent_NEW,
			PageId
		) 
	select 
			TopicId, 
			newid() AS TopicId_NEW, 
			TopicName,
			TopicDescription, 
			TopicParent, 
			@CurTopicId_NEW AS TopicParent_NEW,
			@DestPageId 
	from Topic 
	where TopicParent=@CurTopicId 
	
	set @index=@index +1 
	set @max=(select max(stt) from #temp) 
end 

select 
	TopicId,
	TopicId_NEW,
	TopicName, 
	TopicDescription, 
	TopicParent,
	TopicParent_NEW,
	PageId
from #temp 
order by TopicParent, TopicName


-- Đẩy dữ liệu vào bảng Topic
ALTER TABLE dbo.[Topic]
DISABLE TRIGGER ALL

INSERT dbo.[Topic]
(
	TopicId, 
	TopicName, 
	TopicDescription, 
	TopicParent, 
	PageId
)
select 
	TopicId_NEW,
	TopicName, 
	TopicDescription, 
	TopicParent_NEW,
	PageId
from #temp 

ALTER TABLE dbo.[Topic]
ENABLE TRIGGER ALL

drop table #temp

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Topic_MakeMenu]'
GO
CREATE procedure [dbo].[Topic_MakeMenu]
(
	@SourceTopicId uniqueidentifier,
	@DestMenuMasterId uniqueidentifier,
	@DestMenuMasterName nvarchar(500),
	@DestMenuMasterDescription nvarchar(500)
	--@UrlPattern nvarchar(2000) -- e.g: [ ~/?ModuleId=########-####-####-####-############&TopicId= ]
)
AS

if (@SourceTopicId = '00000000-0000-0000-0000-000000000000')
	return

create table #temp
	(
		stt int identity(0,1), 
		TopicId uniqueidentifier, 
		TopicId_NEW uniqueidentifier,
		TopicName nvarchar(250), 
		TopicDescription nvarchar(250), 
		TopicParent uniqueidentifier, 
		TopicParent_NEW uniqueidentifier, 
		PageId uniqueidentifier
	) 

declare @DestTopicId uniqueidentifier -- Hiểu là khóa của nút Menu gốc sẽ tạo
select @DestTopicId = newid() 

insert into #temp
	(
		TopicId, 
		TopicId_NEW,
		TopicName, 
		TopicDescription, 
		TopicParent, 
		TopicParent_NEW,
		PageId
	) 
select 
		TopicId, 
		@DestTopicId AS TopicId_NEW,
		N'ROOT of [' + @DestMenuMasterName + ']' AS TopicName, 
		N'Root of [' + @DestMenuMasterName + ']' AS TopicDescription, 
		TopicParent,
		--(case when @SourceTopicId = '00000000-0000-0000-0000-000000000000' then NULL else '00000000-0000-0000-0000-000000000000' end)AS TopicParent_NEW, 
		NULL AS TopicParent_NEW, 
		PageId 
from Topic 
where TopicId = @SourceTopicId

declare @index int 
set @index = 0 
declare @max int 
set @max = (select max(stt) from #temp) 

declare @CurTopicId uniqueidentifier 
declare @CurTopicId_NEW uniqueidentifier 

while(@index<=@max) 
begin 
	select @CurTopicId = TopicId,
			@CurTopicId_NEW = TopicId_NEW		
	from #temp where stt=@index
	
	insert into #temp
		(
			TopicId, 
			TopicId_NEW,
			TopicName, 
			TopicDescription, 
			TopicParent, 
			TopicParent_NEW,
			PageId
		) 
	select 
			TopicId, 
			newid() AS TopicId_NEW, 
			TopicName,
			TopicDescription, 
			TopicParent, 
			@CurTopicId_NEW AS TopicParent_NEW,
			PageId 
	from Topic 
	where TopicParent=@CurTopicId 
	
	set @index=@index +1 
	set @max=(select max(stt) from #temp) 
end 

select 
	TopicId_NEW as MenuId_NEW,
	TopicName as MenuName, 
	TopicDescription as MenuDescription, 
	'#' as MenuNavigationURL, --(case when TopicParent_NEW is not null then @UrlPattern + cast(TopicId as nvarchar(50)) else '#' end) as MenuNavigationURL,
	stt as MenuOrder,
	TopicParent_NEW as MenuParent_NEW
into #tempMenu
from #temp 

SELECT * from #tempMenu


-- Đẩy dữ liệu vào bảng Menu
alter table dbo.[Menu]
disable trigger all

insert dbo.[Menu]
(
		MenuId, 
		MenuName, 
		MenuDescription, 
		MenuNavigationURL,
		MenuOrder, 
		MenuParent 
)
select 
		MenuId_NEW, 
		MenuName, 
		MenuDescription, 
		MenuNavigationURL,
		MenuOrder, 
		MenuParent_NEW 
from #tempMenu

-- Đẩy dữ liệu vào bảng MasterMenu
INSERT [dbo].[MenuMaster]
(
		[MenuMasterId]
      ,[MenuMasterName]
      ,[MenuMasterDescription]
      ,[MenuId]
)
VALUES
(
	@DestMenuMasterId,
	@DestMenuMasterName,
	@DestMenuMasterDescription,
	@DestTopicId
)

alter table dbo.[Menu]
enable trigger all


drop table #temp
drop table #tempMenu

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[MenuMaster_MakeTopic]'
GO
CREATE procedure [dbo].[MenuMaster_MakeTopic]
(
	@SourceMenuMasterId uniqueidentifier,
	@PageId uniqueidentifier
)
AS	

declare @SourceMenuMasterName nvarchar(1000)
declare @SourceMenuMasterDescription nvarchar(1000)

select 
	@SourceMenuMasterName = MenuMasterName,
	@SourceMenuMasterDescription = MenuMasterDescription
from dbo.[MenuMaster]
where @SourceMenuMasterId = MenuMasterId
	
 
declare @RootMenuId uniqueidentifier
declare @RootMenuId_NEW uniqueidentifier -- Được xem như khóa của nút Topic gốc sắp tạo

-- Lấy thông tin khóa của nút menu gốc ứng với giá trị của MenuId trong
select 	top 1 @RootMenuId = MenuId , 
		@RootMenuId_NEW = newid()
from dbo.[MenuMaster] 
where [MenuMasterId] = @SourceMenuMasterId

create table #temp
	(
		stt int identity(0,1), 
		MenuId uniqueidentifier, 
		MenuId_NEW uniqueidentifier,
		MenuName nvarchar(250), 
		MenuDescription nvarchar(250), 
		MenuNavigationURL nvarchar(250),
		MenuOrder int, 
		MenuParent uniqueidentifier,
		MenuParent_NEW uniqueidentifier
	)
					
insert into #temp
	(
		MenuId,
		MenuId_NEW,
		MenuName, 
		MenuDescription, 
		MenuNavigationURL,
		MenuOrder, 
		MenuParent,
		MenuParent_NEW
	) 
				
select	MenuId, 
		@RootMenuId_NEW AS [MenuId_NEW],
		@SourceMenuMasterName as MenuName,
		@SourceMenuMasterDescription as MenuDescription, 
		MenuNavigationURL,
		MenuOrder, 
		MenuParent,
		'00000000-0000-0000-0000-000000000000' AS MenuParent_NEW
from dbo.Menu 
where MenuId = @RootMenuId --AND MenuParent is null

declare @index int
set @index = 0

declare @max int
set @max = (select max(stt) from #temp)

declare @curMenuId uniqueidentifier
declare @curMenuId_NEW uniqueidentifier
while(@index<=@max) 
begin 
	select @curMenuId = MenuId, 
		@curMenuId_NEW = MenuId_NEW
	from #temp 
	where stt=@index
	
	insert into #temp
		(
			MenuId, 
			MenuId_NEW,
			MenuName, 
			MenuDescription, 
			MenuNavigationURL,
			MenuOrder, 
			MenuParent,
			MenuParent_NEW
		) 
	select 
			MenuId, 
			newid() AS MenuId_NEW,
			MenuName, 
			MenuDescription, 
			MenuNavigationURL,
			MenuOrder, 
			MenuParent,
			@curMenuId_NEW AS MenuParent_NEW
	from dbo.[Menu]
	where MenuParent=@curMenuId
	
	set @index=@index +1
	set @max=(select max(stt) from #temp)-- order by MenuOrder
end 

select * from #temp

select 
	MenuId_NEW AS TopicId,
	MenuName AS TopicName, 
	MenuDescription AS TopicDescription, 
	MenuParent_NEW AS TopicParent,
	@PageId AS [PageId]
from #temp 


-- Đẩy dữ liệu vào bảng Topic
ALTER TABLE dbo.[Topic]
DISABLE TRIGGER ALL

INSERT dbo.[Topic]
(
	TopicId, 
	TopicName, 
	TopicDescription, 
	TopicParent, 
	PageId
)
select 
	MenuId_NEW AS TopicId,
	MenuName AS TopicName, 
	MenuDescription AS TopicDescription, 
	MenuParent_NEW AS TopicParent,
	@PageId AS [PageId]
from #temp 

ALTER TABLE dbo.[Topic]
ENABLE TRIGGER ALL
drop table #temp

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Page]'
GO
CREATE TABLE [dbo].[Page]
(
[PageId] [uniqueidentifier] NOT NULL,
[PageName] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PageTitle] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Page] on [dbo].[Page]'
GO
ALTER TABLE [dbo].[Page] ADD CONSTRAINT [PK_Page] PRIMARY KEY CLUSTERED ([PageId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[PortletInstanceInPanel]'
GO
CREATE TABLE [dbo].[PortletInstanceInPanel]
(
[PortletInstanceId] [uniqueidentifier] NOT NULL,
[PageId] [uniqueidentifier] NOT NULL,
[PanelId] [int] NOT NULL,
[Style] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Order] [int] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_PortletInstanceInPanel] on [dbo].[PortletInstanceInPanel]'
GO
ALTER TABLE [dbo].[PortletInstanceInPanel] ADD CONSTRAINT [PK_PortletInstanceInPanel] PRIMARY KEY CLUSTERED ([PortletInstanceId], [PageId], [PanelId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[PanelInPage]'
GO
CREATE TABLE [dbo].[PanelInPage]
(
[PageId] [uniqueidentifier] NOT NULL,
[PanelId] [int] NOT NULL,
[Style] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_PanelInPage] on [dbo].[PanelInPage]'
GO
ALTER TABLE [dbo].[PanelInPage] ADD CONSTRAINT [PK_PanelInPage] PRIMARY KEY CLUSTERED ([PageId], [PanelId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Menu_UpdatePostion]'
GO
CREATE PROCEDURE Menu_UpdatePostion
(
	@MenuId uniqueidentifier,
	@MenuOrder int
)
AS

UPDATE dbo.[Menu]
SET 
	MenuOrder=@MenuOrder 
WHERE 
	MenuId=@MenuId
	

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[MenuMaster_Insert]'
GO
CREATE PROCEDURE [dbo].[MenuMaster_Insert]
(
	@MenuId uniqueidentifier,
	@MenuName nvarchar(250),
	@MenuDescription nvarchar(250),
	@MenuNavigationURL nvarchar(250),
	@MenuOrder int,
	
	@MenuMasterId uniqueidentifier,
	@MenuMasterName nvarchar(250),
	@MenuMasterDescription nvarchar(250)
)
AS

INSERT INTO dbo.[Menu] 
(
	[MenuId],
	[MenuName],
	[MenuDescription],
	[MenuNavigationURL], 
	[MenuOrder]
) 
VALUES 
(
	@MenuId,
	@MenuName,
	@MenuDescription,
	@MenuNavigationURL,
	@MenuOrder
) 	

INSERT INTO dbo.[MenuMaster] 
(
	[MenuMasterId],
	[MenuMasterName],
	[MenuMasterDescription],
	[MenuId]
) 
VALUES 
(
	@MenuMasterId,
	@MenuMasterName,
	@MenuMasterDescription,
	@MenuId
)


GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[MenuMaster_Update]'
GO
CREATE PROCEDURE [dbo].[MenuMaster_Update]
(
	@MenuMasterId uniqueidentifier,
	@MenuMasterName nvarchar(250),
	@MenuMasterDescription nvarchar(250)
)
AS

UPDATE dbo.[MenuMaster] 
SET 
	[MenuMasterName] = @MenuMasterName, 
	[MenuMasterDescription] = @MenuMasterDescription 
WHERE 
	[MenuMasterId] = @MenuMasterId

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[MenuMaster_Delete]'
GO
CREATE PROCEDURE MenuMaster_Delete
(
	@MenuMasterId uniqueidentifier
)
AS

DELETE dbo.[MenuMaster] 
WHERE 
	[MenuMasterId] = @MenuMasterId

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[MenuMaster_GetAll]'
GO

CREATE PROCEDURE [dbo].[MenuMaster_GetAll]
AS
SELECT 
	[MenuMasterId],
	[MenuMasterName],
	[MenuMasterDescription],
	[MenuId] 
FROM 
	dbo.[MenuMaster]

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[TopicTemplate]'
GO
CREATE TABLE [dbo].[TopicTemplate]
(
[TopicId] [uniqueidentifier] NOT NULL,
[TopicContentTemplate] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_TopicTemplate] on [dbo].[TopicTemplate]'
GO
ALTER TABLE [dbo].[TopicTemplate] ADD CONSTRAINT [PK_TopicTemplate] PRIMARY KEY CLUSTERED ([TopicId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Topic_SetContentTemplate]'
GO
CREATE PROCEDURE Topic_SetContentTemplate
(
	@TopicId uniqueidentifier,
	@TopicContentTemplate ntext
)
AS

IF (EXISTS(SELECT 1 FROM TopicTemplate WHERE TopicId=@TopicId))
BEGIN
	UPDATE dbo.[TopicTemplate] 
	SET 
		TopicContentTemplate = @TopicContentTemplate 
	WHERE 
		TopicId=@TopicId 
END
ELSE
BEGIN
INSERT INTO dbo.[TopicTemplate]
(
	TopicId, 
	TopicContentTemplate
) 
VALUES 
(
	@TopicId, 
	@TopicContentTemplate
)
END 

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Topic_GetContentTemplate]'
GO
CREATE PROCEDURE Topic_GetContentTemplate
(
	@TopicId uniqueidentifier
)
AS

SELECT 
	TopicContentTemplate 
FROM 
	dbo.[TopicTemplate]
WHERE 
	TopicId=@TopicId 

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Topic_GetTopicPrimaryOfArticle]'
GO
CREATE PROCEDURE Topic_GetTopicPrimaryOfArticle
(
	@ArticleId uniqueidentifier
)
AS

SELECT 
	t.TopicId, 
	t.TopicName, 
	t.TopicDescription
FROM 
	dbo.[ArticleBelongTopicPrimary] atp
	INNER JOIN dbo.[Topic] t ON atp.ArticleId = @ArticleId
WHERE 
	atp.TopicId = t.TopicId

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Topic_GetTopicById]'
GO
CREATE PROCEDURE Topic_GetTopicById
(
	@TopicId uniqueidentifier
)
AS

SELECT 
	t.TopicId, 
	t.TopicName, 
	t.TopicDescription, 
	t.PageId
FROM
	dbo.[Topic] t
WHERE 
	t.[Topicid] = @TopicId

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[TopicAuthentication]'
GO
CREATE TABLE [dbo].[TopicAuthentication]
(
[TopicId] [uniqueidentifier] NOT NULL,
[TopicPermissionId] [int] NOT NULL,
[RoleId] [uniqueidentifier] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_TopicAuthentication] on [dbo].[TopicAuthentication]'
GO
ALTER TABLE [dbo].[TopicAuthentication] ADD CONSTRAINT [PK_TopicAuthentication] PRIMARY KEY CLUSTERED ([TopicId], [TopicPermissionId], [RoleId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[TopicAuthentication_Insert]'
GO
CREATE PROCEDURE TopicAuthentication_Insert
(
	@TopicId uniqueidentifier,
	@TopicPermissionId int, 
	@RoleId uniqueidentifier
)
AS

INSERT INTO dbo.[TopicAuthentication]
(
	TopicId, 
	TopicPermissionId, 
	RoleId
) 
VALUES 
(
	@TopicId, 
	@TopicPermissionId, 
	@RoleId
)

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[TopicAuthentication_Delete]'
GO
CREATE PROCEDURE TopicAuthentication_Delete
(
	@TopicId uniqueidentifier,
	@TopicPermissionId int, 
	@RoleId uniqueidentifier
)
AS

DELETE dbo.[TopicAuthentication]
WHERE 
	TopicId=@TopicId 
	AND TopicPermissionId=@TopicPermissionId 
	AND RoleId=@RoleId

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[TopicAuthentication_GetAllByTopicId]'
GO
CREATE PROCEDURE TopicAuthentication_GetAllByTopicId
(
	@TopicId uniqueidentifier
)
AS

SELECT 
	TopicPermissionId, 
	RoleId 
FROM 
	DBO.[TopicAuthentication]
WHERE 
	TopicId=@TopicId

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Topic_GetAll]'
GO
CREATE PROCEDURE Topic_GetAll
AS

create table #temp
(
	stt int identity(0,1), 
	TopicId uniqueidentifier, 
	TopicName nvarchar(250), 
	TopicDescription nvarchar(250), 
	TopicParent uniqueidentifier, 
	PageId uniqueidentifier
)

-- Thêm phần tử gốc
insert into #temp
(
	TopicId, 
	TopicName, 
	TopicDescription, 
	TopicParent, 
	PageId
)
select 
	TopicId, 
	TopicName, 
	TopicDescription, 
	TopicParent, 
	PageId
from 
	dbo.[Topic]
where 
	TopicParent is null

-- Lấy tất các các phần từ còn lại dựa trên quan hệ phân cấp
declare @index int
set @index = 0
declare @max int
set @max = (select max(stt) from #temp)
declare @temp uniqueidentifier

while(@index<=@max)
begin
	set @temp = (select TopicId from #temp where stt=@index)
	insert into #temp(TopicId, TopicName, TopicDescription, TopicParent, PageId)
	select TopicId, TopicName, TopicDescription, TopicParent, PageId
	from Topic
	where TopicParent=@temp
	set @index=@index +1
	set @max=(select max(stt) from #temp)
end

select TopicId, TopicName, TopicDescription, TopicParent, PageId
from #temp
where TopicParent is not null 

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Topic_GetTopicByArticleId]'
GO
CREATE PROCEDURE [dbo].[Topic_GetTopicByArticleId]
(
	@ArticleId uniqueidentifier
)
AS

SELECT DISTINCT 
	t.TopicId, 
	t.TopicName , 
	t.TopicDescription
FROM
	dbo.[ArticleBelongTopic] at
	INNER JOIN Topic t ON at.TopicId = t.TopicId
where at.ArticleId = @ArticleId 

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[TopicPermission]'
GO
CREATE TABLE [dbo].[TopicPermission]
(
[TopicPermissionId] [int] NOT NULL,
[TopicPermissionName] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_TopicPermission] on [dbo].[TopicPermission]'
GO
ALTER TABLE [dbo].[TopicPermission] ADD CONSTRAINT [PK_TopicPermission] PRIMARY KEY CLUSTERED ([TopicPermissionId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[TopicPermission_GetAll]'
GO
CREATE PROCEDURE [dbo].[TopicPermission_GetAll]
AS

SELECT 
	TopicPermissionId, 
	TopicPermissionName 
FROM 
	dbo.[TopicPermission]

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Topic_Insert]'
GO
CREATE PROCEDURE [dbo].[Topic_Insert]
(
	@TopicId uniqueidentifier,
	@TopicName nvarchar(250),
	@TopicDescription nvarchar(250),
	@TopicParent uniqueidentifier,
	@PageId uniqueidentifier
)
AS

INSERT INTO dbo.[Topic] 
(
	[TopicId],
	[TopicName],
	[TopicDescription],
	[TopicParent], 
	PageId
) 
VALUES 
(
	@TopicId,
	@TopicName,
	@TopicDescription,
	@TopicParent,
	@PageId
)

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Topic_Update]'
GO
CREATE PROCEDURE [dbo].[Topic_Update]
(
	@TopicId uniqueidentifier,
	@TopicName nvarchar(250),
	@TopicDescription nvarchar(250),
	@TopicParent uniqueidentifier,
	@PageId uniqueidentifier
)
AS

UPDATE dbo.[Topic] 
SET 
	[TopicName] = @TopicName, 
	[TopicDescription] = @TopicDescription, 
	[TopicParent] = @TopicParent, 
	[PageId]=@PageId 
WHERE 
	[TopicId] = @TopicId

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Topic_Delete]'
GO
CREATE PROCEDURE [dbo].[Topic_Delete]
(
	@TopicId uniqueidentifier
)
AS

create table #temp
(
	stt int identity(0,1),
	TopicId uniqueidentifier
)

-- Đưa topic đầu tiên vào danh sách
insert into #temp (TopicId) values(@TopicId)

-- Duyệt các topic sẽ bị xóa cùng topic đầu tiên theo quan hệ cha-con
declare @index int
set @index = 0
declare @max int
set @max = 0
declare @temp uniqueidentifier
while(@index<=@max)
begin
	set @temp = (select TopicId from #temp where stt=@index)
	insert into #temp (TopicId)
	select TopicId
	from Topic
	where TopicParent=@temp
	set @index = @index + 1
	set @max = (select max(stt) from #temp)
end

-- Xóa toàn bộ danh sách cuối
delete Topic where TopicId in (select TopicId from #temp) 

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Article_GetArticleByIdForPortlet]'
GO

CREATE PROCEDURE [dbo].[Article_GetArticleByIdForPortlet]
(
	@ArticleId uniqueidentifier,
	@ArticleDate datetime,
	@NumOfArticles int
)
AS

DECLARE  @sqlString nvarchar(max)
DECLARE  @NumberNew int
SELECT 
	[ArticleId],
	[ArticleName],
	[ArticleTitle],
	[ArticleCreatedDate],
	[ArticleModifiedDate],
	[ArticleIsPublish], 
	[PageId] 
FROM 
	dbo.[Article] 
WHERE 
	[ArticleId] = @ArticleId 
	AND [ArticleIspublish] = 1

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[DocumentBelongDocumentTypePrimary]'
GO
CREATE TABLE [dbo].[DocumentBelongDocumentTypePrimary]
(
[DocumentId] [uniqueidentifier] NOT NULL,
[DocumentTypeId] [uniqueidentifier] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_DocumentBelongDocumentTypePrimary] on [dbo].[DocumentBelongDocumentTypePrimary]'
GO
ALTER TABLE [dbo].[DocumentBelongDocumentTypePrimary] ADD CONSTRAINT [PK_DocumentBelongDocumentTypePrimary] PRIMARY KEY CLUSTERED ([DocumentId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[DocumentType]'
GO
CREATE TABLE [dbo].[DocumentType]
(
[DocumentTypeId] [uniqueidentifier] NOT NULL,
[DocumentTypeName] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DocumentTypeDescription] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DocumentTypeParent] [uniqueidentifier] NULL,
[PageId] [uniqueidentifier] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_DocumentType] on [dbo].[DocumentType]'
GO
ALTER TABLE [dbo].[DocumentType] ADD CONSTRAINT [PK_DocumentType] PRIMARY KEY CLUSTERED ([DocumentTypeId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[DocumentDetail]'
GO
CREATE TABLE [dbo].[DocumentDetail]
(
[DocumentId] [uniqueidentifier] NOT NULL,
[DocumentRender] [image] NULL,
[DocumentDownload] [image] NULL,
[DocumentExtension] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_DocumentDetail] on [dbo].[DocumentDetail]'
GO
ALTER TABLE [dbo].[DocumentDetail] ADD CONSTRAINT [PK_DocumentDetail] PRIMARY KEY CLUSTERED ([DocumentId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Document_GetDocumentDownload]'
GO
CREATE PROCEDURE Document_GetDocumentDownload
(
	@DocumentId uniqueidentifier
)
AS

SELECT 
	DocumentDownload 
FROM 
	dbo.[DocumentDetail] 
WHERE 
	DocumentId=@DocumentId

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Document_GetDocumentExtension]'
GO
CREATE PROCEDURE Document_GetDocumentExtension
(
	@DocumentId uniqueidentifier
)
AS

SELECT 
	DocumentExtension 
FROM 
	dbo.[DocumentDetail] 
WHERE 
	DocumentId=@DocumentId

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Document]'
GO
CREATE TABLE [dbo].[Document]
(
[DocumentId] [uniqueidentifier] NOT NULL,
[DocumentName] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DocumentTitle] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DocumentCreatedDate] [datetime] NOT NULL,
[DocumentModifiedDate] [datetime] NULL,
[DocumentIsPublish] [bit] NULL,
[PageId] [uniqueidentifier] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Document] on [dbo].[Document]'
GO
ALTER TABLE [dbo].[Document] ADD CONSTRAINT [PK_Document] PRIMARY KEY CLUSTERED ([DocumentId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Document_GetById]'
GO
CREATE PROCEDURE Document_GetById
(
	@DocumentId uniqueidentifier
)
AS

SELECT 
	[DocumentId],
	[DocumentName],
	[DocumentTitle],
	[DocumentCreatedDate],
	[DocumentModifiedDate],
	[DocumentIsPublish],
	[PageId] 
FROM 
	dbo.[Document]
WHERE 
	DocumentId=@DocumentId

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Document_SetPrimaryDocumentTypeBelong]'
GO
CREATE PROCEDURE Document_SetPrimaryDocumentTypeBelong
(
	@DocumentId uniqueidentifier,
	@DocumentTypeId uniqueidentifier
)
AS

IF (EXISTS(SELECT 1 FROM DocumentBelongDocumentTypePrimary WHERE DocumentId=@DocumentId))
BEGIN
UPDATE dbo.[DocumentBelongDocumentTypePrimary]
SET 
	DocumentTypeId=@DocumentTypeId 
WHERE 
	DocumentId=@DocumentId 
END
ELSE
BEGIN
INSERT INTO dbo.[DocumentBelongDocumentTypePrimary]
(
	DocumentId, 
	DocumentTypeId
) 
VALUES 
(
	@DocumentId, 
	@DocumentTypeId
)
END 

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Document_GetDocumentRender]'
GO
CREATE PROCEDURE Document_GetDocumentRender
(
	@DocumentId uniqueidentifier
)
AS

SELECT 
	DocumentRender 
FROM 
	dbo.[DocumentDetail]
WHERE 
	DocumentId=@DocumentId

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[DocumentBelongDocumentType]'
GO
CREATE TABLE [dbo].[DocumentBelongDocumentType]
(
[DocumentId] [uniqueidentifier] NOT NULL,
[DocumentTypeId] [uniqueidentifier] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_DocumentBelongDocumentType] on [dbo].[DocumentBelongDocumentType]'
GO
ALTER TABLE [dbo].[DocumentBelongDocumentType] ADD CONSTRAINT [PK_DocumentBelongDocumentType] PRIMARY KEY CLUSTERED ([DocumentId], [DocumentTypeId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Document_DeleteDocumentTypeBelongTo]'
GO
CREATE PROCEDURE Document_DeleteDocumentTypeBelongTo
(
	@DocumentId uniqueidentifier,
	@DocumentTypeId uniqueidentifier
)
AS

DELETE dbo.[DocumentBelongDocumentType] 
WHERE 
	DocumentId=@DocumentId 
	AND DocumentTypeId=@DocumentTypeId

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Document_AddDocumentTypeBelongTo]'
GO
CREATE PROCEDURE Document_AddDocumentTypeBelongTo
(
	@DocumentId uniqueidentifier,
	@DocumentTypeId uniqueidentifier
)
AS

INSERT INTO dbo.[DocumentBelongDocumentType]
(
	[DocumentId],
	[DocumentTypeId]
) 
VALUES 
(
	@DocumentId,
	@DocumentTypeId
)

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Document_GetDocumentTypeBelongTo]'
GO
CREATE PROCEDURE [dbo].[Document_GetDocumentTypeBelongTo]
(
	@DocumentId uniqueidentifier
)
AS

SELECT 
	b.[DocumentTypeId],
	[DocumentTypeName],
	[DocumentTypeDescription] 
FROM dbo.[DocumentType] a
	INNER JOIN dbo.[DocumentBelongDocumentType] b ON a.[DocumentTypeId] = b.[DocumentTypeId]
WHERE 
	b.[DocumentId]=@DocumentId

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Document_Delete]'
GO
CREATE PROCEDURE [dbo].[Document_Delete]
(
	@DocumentId uniqueidentifier
)
AS

DELETE dbo.[DocumentBelongDocumentType] 
WHERE 
	[DocumentId] = @DocumentId

UPDATE [Document] 
SET 
	[DocumentIsPublish] = 0 
WHERE 
	[DocumentId] = @DocumentId 

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Document_Insert]'
GO
CREATE PROCEDURE Document_Insert
(
	@DocumentId uniqueidentifier,
	@DocumentName nvarchar(250),
	@DocumentTitle nvarchar(250),
	@DocumentCreatedDate datetime,
	@DocumentModifiedDate datetime,
	@DocumentIsPublish bit = 0,
	@PageId uniqueidentifier,
	
	@DocumentRender image = null,
	@DocumentDownload image = null,
	@DocumentExtension varchar(20) = null,
	
	@DocumentTypeId uniqueidentifier
)
AS

-- Thêm thông tin vào bảng chính
INSERT INTO dbo.[Document] 
(
	[DocumentId],
	[DocumentName],
	[DocumentTitle],
	[DocumentCreatedDate],
	[DocumentModifiedDate],
	[DocumentIsPublish],
	[PageId]
) 
VALUES 
(
	@DocumentId,
	@DocumentName,
	@DocumentTitle,
	@DocumentCreatedDate,
	@DocumentModifiedDate,
	@DocumentIsPublish,
	@PageId
)

-- Thêm thông tin vào bảng chi tiết nội dung của tài liệu
INSERT dbo.DocumentDetail
(
	DocumentId,
	DocumentRender,
	DocumentDownload,
	DocumentExtension
)
VALUES
(
	@DocumentId,
	@DocumentRender,
	@DocumentDownload,
	@DocumentExtension
)

-- Thêm tin vào bảng quan hệ với Loại Tài Liệu
INSERT INTO dbo.[DocumentBelongDocumentType]
(
	DocumentTypeId, 
	DocumentId
) 
VALUES 
(
	@DocumentTypeId, 
	@DocumentId
)

-- Thêm tin vào bảng quan hệ với Loại Tài Liệu CHÍNH
INSERT INTO dbo.[DocumentBelongDocumentTypePrimary]
(
	DocumentTypeId, 
	DocumentId
) 
VALUES 
(
	@DocumentTypeId, 
	@DocumentId
)

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Document_Update]'
GO
CREATE PROCEDURE Document_Update
(
	@DocumentId uniqueidentifier,
	@DocumentName nvarchar(250),
	@DocumentTitle nvarchar(250),
	@DocumentCreatedDate datetime,
	@DocumentModifiedDate datetime,
	@DocumentIsPublish bit = 0,
	@PageId uniqueidentifier,
	
	@DocumentRender image = null,
	@DocumentDownload image = null,
	@DocumentExtension varchar(20) = null
)
AS

-- Cập nhật thông tin vào bảng chính
UPDATE dbo.[Document] 
SET 
	[DocumentName] = @DocumentName, 
	[DocumentTitle] = @DocumentTitle, 
	[DocumentCreatedDate] = @DocumentCreatedDate, 
	[DocumentModifiedDate] = @DocumentModifiedDate, 
	[DocumentIsPublish] = @DocumentIsPublish,
	[PageId]=@PageId 
WHERE 
	[DocumentId] = @DocumentId

-- Cập nhật thông tin vào bảng chi tiết nội dung của tài liệu
IF (@DocumentRender IS NOT NULL AND @DocumentDownload IS NOT NULL)
BEGIN
UPDATE dbo.DocumentDetail
SET 

	DocumentId = @DocumentId,
	DocumentRender =@DocumentRender,
	DocumentDownload = @DocumentDownload,
	DocumentExtension = @DocumentExtension
WHERE 
	[DocumentId] = @DocumentId
END

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Document_GetAll]'
GO
CREATE PROCEDURE Document_GetAll
AS
SELECT 
	[DocumentId],
	[DocumentName],
	[DocumentTitle],
	[DocumentCreatedDate],
	[DocumentModifiedDate],
	[DocumentIsPublish],
	[PageId] 
FROM 
	dbo.[Document]
	

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Document_GetAllByDocumentTypeId]'
GO
CREATE PROCEDURE Document_GetAllByDocumentTypeId
(
	@DocumentTypeId uniqueidentifier
)
AS
SELECT 
	a.[DocumentId],
	[DocumentName],
	[DocumentTitle],
	[DocumentCreatedDate],
	[DocumentModifiedDate],
	[DocumentIsPublish],
	[PageId] 
FROM 
	dbo.[Document] a 
	INNER JOIN dbo.[DocumentBelongDocumentType] b ON a.[DocumentId] = b.[DocumentId]
WHERE 
	b.DocumentTypeId = @DocumentTypeId

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Document_GetAllInTrash]'
GO
CREATE PROCEDURE [dbo].[Document_GetAllInTrash]
AS

SELECT DISTINCT 
	[DocumentId] 
INTO
	#TEMP_DOC
FROM 
	dbo.[DocumentBelongDocumentType]

SELECT 
	a.[DocumentId],
	[DocumentName],
	[DocumentTitle],
	[DocumentCreatedDate],
	[DocumentModifiedDate],
	[DocumentIsPublish] 
FROM 
	dbo.[Document] a
	LEFT JOIN #TEMP_DOC b ON a.[DocumentId] = b.[DocumentId]
WHERE b.[DocumentId] IS NULL

DROP TABLE #TEMP_DOC

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Document_DeleteFromTrash]'
GO
CREATE PROCEDURE dbo.Document_DeleteFromTrash
(
	@DocumentId uniqueidentifier
)
AS

Delete dbo.[Document] 
where 
	DocumentId = @DocumentId

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Document_GetDocumentsNoBelongPrimaryDocumentType]'
GO
CREATE PROCEDURE [dbo].[Document_GetDocumentsNoBelongPrimaryDocumentType]
AS

SELECT a.[DocumentId]
INTO #TMP
FROM dbo.[Document]  a
	LEFT JOIN  dbo.DocumentBelongDocumentTypePrimary b ON a.[DocumentId] = b.[DocumentId]
WHERE b.[DocumentId] IS NULL


SELECT 
	a.[DocumentId] , 
	Count(*) AS [NumbeOfDocumentTypes]
INTO #TMP2
FROM #TMP a
	LEFT JOIN dbo.DocumentBelongDocumentType b ON a.[DocumentId] = b.[DocumentId]
WHERE 
	b.[DocumentId] IS NOT NULL
GROUP BY 
	a.[DocumentId]


INSERT dbo.DocumentBelongDocumentTypePrimary
(
	DocumentId, 
	DocumentTypeId
)
SELECT 
	a.DocumentId, 
	b.DocumentTypeId
FROM
	#TMP2 a
	INNER JOIN dbo.DocumentBelongDocumentType b ON a.[DocumentId] = b.[DocumentId]
WHERE 
	[NumbeOfDocumentTypes] = 1
	
	
SELECT 
	b.[DocumentId], 
	[DocumentName],
	[DocumentTitle],
	[DocumentCreatedDate],
	[DocumentModifiedDate],
	[DocumentIsPublish]
FROM
	#TMP2 a
	INNER JOIN dbo.[Document] b ON a.[DocumentId] = b.[DocumentId]
WHERE 
	[NumbeOfDocumentTypes] > 1
	
DROP TABLE #TMP
DROP TABLE #TMP2 

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[DocumentType_Insert]'
GO
CREATE PROCEDURE dbo.DocumentType_Insert
(
	@DocumentTypeId uniqueidentifier,
	@DocumentTypeName nvarchar(250),
	@DocumentTypeDescription nvarchar(250),
	@DocumentTypeParent uniqueidentifier,
	@PageId uniqueidentifier
)
AS

INSERT INTO dbo.[DocumentType] 
(
	[DocumentTypeId],
	[DocumentTypeName],
	[DocumentTypeDescription],
	[DocumentTypeParent],
	[PageId]
) 
VALUES 
(
	@DocumentTypeId,
	@DocumentTypeName,
	@DocumentTypeDescription,
	@DocumentTypeParent,
	@PageId
)

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[DocumentType_Update]'
GO
CREATE PROCEDURE dbo.DocumentType_Update
(
	@DocumentTypeId uniqueidentifier,
	@DocumentTypeName nvarchar(250),
	@DocumentTypeDescription nvarchar(250),
	@DocumentTypeParent uniqueidentifier,
	@PageId uniqueidentifier
)
AS

UPDATE dbo.[DocumentType] 
SET 
	[DocumentTypeName] = @DocumentTypeName, 
	[DocumentTypeDescription] = @DocumentTypeDescription, 
	[DocumentTypeParent] = @DocumentTypeParent, 
	[PageId]=@PageId 
WHERE 
	[DocumentTypeId] = @DocumentTypeId

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[DocumentType_Delete]'
GO
CREATE PROCEDURE dbo.DocumentType_Delete
(
	@DocumentTypeId uniqueidentifier
)
AS

create table #temp
(
	stt int identity(0,1),
	DocumentTypeId uniqueidentifier
)

insert into #temp (DocumentTypeId) values(@DocumentTypeId)

declare @index int
set @index = 0
declare @max int
set @max = 0
declare @temp uniqueidentifier
while(@index<=@max)
begin
	set @temp = (select DocumentTypeId from #temp where stt=@index)
	insert into #temp (DocumentTypeId)
	select DocumentTypeId
	from DocumentType
	where DocumentTypeParent=@temp
	set @index = @index + 1
	set @max = (select max(stt) from #temp)
end

delete DocumentType where DocumentTypeId in (select DocumentTypeId from #temp) 

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[DocumentType_GetById]'
GO
CREATE PROCEDURE dbo.DocumentType_GetById
(
	@DocumentTypeId uniqueidentifier
)
AS

SELECT 
	DocumentTypeId, 
	DocumentTypeName, 
	DocumentTypeDescription,
	PageId 
FROM 
	DBO.[DocumentType]
WHERE 
	DocumentTypeId=@DocumentTypeId

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[DocumentType_GetPrimaryDocumentType]'
GO
CREATE PROCEDURE dbo.DocumentType_GetPrimaryDocumentType
(
	@DocumentId uniqueidentifier
)
AS

Select 
	d.DocumentTypeId, 
	d.DocumentTypeName, 
	d.DocumentTypeDescription
from 
	dbo.[DocumentBelongDocumentTypePrimary] dbd
	inner join dbo.[DocumentType] d on dbd.DocumentTypeId = d.DocumentTypeId
where 
	dbd.DocumentId = @DocumentId 

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[DocumentTypePermission]'
GO
CREATE TABLE [dbo].[DocumentTypePermission]
(
[DocumentTypePermissionId] [int] NOT NULL,
[DocumentTypePermissionName] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_DocumentTypePermission] on [dbo].[DocumentTypePermission]'
GO
ALTER TABLE [dbo].[DocumentTypePermission] ADD CONSTRAINT [PK_DocumentTypePermission] PRIMARY KEY CLUSTERED ([DocumentTypePermissionId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[DocumentTypePermission_GetAll]'
GO
CREATE PROCEDURE dbo.DocumentTypePermission_GetAll
AS

SELECT 
	DocumentTypePermissionId, 
	DocumentTypePermissionName 
FROM 
	dbo.[DocumentTypePermission]

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[DocumentTypeAuthentication]'
GO
CREATE TABLE [dbo].[DocumentTypeAuthentication]
(
[DocumentTypeId] [uniqueidentifier] NOT NULL,
[DocumentTypePermissionId] [int] NOT NULL,
[RoleId] [uniqueidentifier] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_DocumentTypeAuthentication] on [dbo].[DocumentTypeAuthentication]'
GO
ALTER TABLE [dbo].[DocumentTypeAuthentication] ADD CONSTRAINT [PK_DocumentTypeAuthentication] PRIMARY KEY CLUSTERED ([DocumentTypeId], [DocumentTypePermissionId], [RoleId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[DocumentTypeAuthentication_Insert]'
GO
CREATE PROCEDURE dbo.DocumentTypeAuthentication_Insert
(
	@DocumentTypeId uniqueidentifier, 
	@DocumentTypePermissionId int, 
	@RoleId uniqueidentifier
)
AS

INSERT INTO dbo.DocumentTypeAuthentication 
(
	DocumentTypeId, 
	DocumentTypePermissionId, 
	RoleId
) 
VALUES 
(
	@DocumentTypeId, 
	@DocumentTypePermissionId, 
	@RoleId
)

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[DocumentTypeAuthentication_Delete]'
GO
CREATE PROCEDURE dbo.DocumentTypeAuthentication_Delete
(
	@DocumentTypeId uniqueidentifier, 
	@DocumentTypePermissionId int, 
	@RoleId uniqueidentifier
)
AS

DELETE dbo.DocumentTypeAuthentication 
WHERE 
	DocumentTypeId=@DocumentTypeId 
	AND DocumentTypePermissionId=@DocumentTypePermissionId 
	AND RoleId=@RoleId

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[DocumentTypeAuthentication_GetByDocumentTypeId]'
GO
CREATE PROCEDURE dbo.DocumentTypeAuthentication_GetByDocumentTypeId
(
	@DocumentTypeId uniqueidentifier
)
AS

SELECT 
	DocumentTypePermissionId, 
	RoleId 
FROM 
	dbo.DocumentTypeAuthentication 
WHERE 
	DocumentTypeId=@DocumentTypeId

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[DocumentType_GetAll]'
GO
CREATE PROCEDURE [dbo].[DocumentType_GetAll]
AS

create table #temp
(
	stt int identity(0,1), 
	DocumentTypeId uniqueidentifier, 
	DocumentTypeName nvarchar(250), 
	DocumentTypeDescription nvarchar(250), 
	DocumentTypeParent uniqueidentifier, 
	PageId uniqueidentifier
)

insert into #temp(DocumentTypeId, DocumentTypeName, DocumentTypeDescription, DocumentTypeParent, PageId)
select DocumentTypeId, DocumentTypeName, DocumentTypeDescription, DocumentTypeParent, PageId
from 
	dbo.DocumentType
where 
	DocumentTypeParent is null
	

declare @index int
set @index = 0
declare @max int
set @max = (select max(stt) from #temp)
declare @temp uniqueidentifier
while(@index<=@max)
begin
	set @temp = (select DocumentTypeId from #temp where stt=@index)
	insert into #temp(DocumentTypeId, DocumentTypeName, DocumentTypeDescription, DocumentTypeParent, PageId)
	select DocumentTypeId, DocumentTypeName, DocumentTypeDescription, DocumentTypeParent, PageId
	from DocumentType
	where DocumentTypeParent=@temp
	set @index=@index +1
	set @max=(select max(stt) from #temp)
end


select DocumentTypeId, DocumentTypeName, DocumentTypeDescription, DocumentTypeParent, PageId
from #temp
where DocumentTypeParent is not null 

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Module]'
GO
CREATE TABLE [dbo].[Module]
(
[ModuleId] [uniqueidentifier] NOT NULL,
[ModuleName] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ModuleDisplayURL] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ModuleEditURL] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PageId] [uniqueidentifier] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Module] on [dbo].[Module]'
GO
ALTER TABLE [dbo].[Module] ADD CONSTRAINT [PK_Module] PRIMARY KEY CLUSTERED ([ModuleId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Module_Insert]'
GO
CREATE PROCEDURE [dbo].Module_Insert
(
	@ModuleId uniqueidentifier,
	@ModuleName nvarchar(250),
	@ModuleDisplayURL nvarchar(250),
	@ModuleEditURL nvarchar(250),
	@PageId uniqueidentifier
)
AS

INSERT INTO [Module] 
(
	[ModuleId],
	[ModuleName],
	[ModuleDisplayURL],
	[ModuleEditURL],
	[PageId]
) 
VALUES 
(
	@ModuleId,
	@ModuleName,
	@ModuleDisplayURL,
	@ModuleEditURL,
	@PageId
)

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Module_Update]'
GO
CREATE PROCEDURE [dbo].Module_Update
(
	@ModuleId uniqueidentifier,
	@ModuleName nvarchar(250),
	@ModuleDisplayURL nvarchar(250),
	@ModuleEditURL nvarchar(250),
	@PageId uniqueidentifier
)
AS

UPDATE dbo.[Module] 
SET 
	[ModuleName] = @ModuleName, 
	[ModuleDisplayURL] = @ModuleDisplayURL, 
	[ModuleEditURL] = @ModuleEditURL, 
	[PageId]=@PageId 
WHERE 
	[ModuleId] = @ModuleId

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Module_GetById]'
GO
CREATE PROCEDURE [dbo].Module_GetById
(
	@ModuleId uniqueidentifier
)
AS

SELECT 
	[ModuleId],
	[ModuleName],
	[ModuleDisplayURL],
	[ModuleEditURL],
	[PageId] 
FROM 
	dbo.[Module] 
where 
	[ModuleId]=@ModuleId 

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Module_Delete]'
GO
CREATE PROCEDURE [dbo].Module_Delete
(
	@ModuleId uniqueidentifier
)
AS

DELETE dbo.[Module] 
WHERE 
	[ModuleId] = @ModuleId

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Module_GetAll]'
GO
CREATE PROCEDURE [dbo].Module_GetAll
AS

SELECT 
	[ModuleId],
	[ModuleName],
	[ModuleDisplayURL],
	[ModuleEditURL],
	m.[PageId],
	p.[PageName] 
FROM 
	dbo.Page p 
	inner join dbo.Module m  on p.PageId = m.PageId

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Page_Insert]'
GO
CREATE PROCEDURE [dbo].Page_Insert
(
	@PageId uniqueidentifier,
	@PageName nvarchar(250),
	@PageTitle  nvarchar(250)
)
AS

-- Thêm thông tin trang mới
INSERT INTO dbo.[Page] 
(
	[PageId],
	[PageName],
	[PageTitle]
) 
VALUES 
(
	@PageId,
	@PageName,
	@PageTitle
)

-- Chèn panel nội dung (mặc định) vào trang vừa thêm
INSERT INTO dbo.[PanelInPage] 
(
	[PageId], 
	[PanelId], 
	[Style]
) 
VALUES 
(
	@PageId, 
	2, 
	''
) 

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Page_Update]'
GO
CREATE PROCEDURE [dbo].Page_Update
(
	@PageId uniqueidentifier,
	@PageName nvarchar(250),
	@PageTitle  nvarchar(250)
)
AS

UPDATE dbo.[Page] 
SET 
	[PageName] = @PageName, 
	[PageTitle] = @PageTitle 
WHERE [PageId] = @PageId

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Page_Delete]'
GO
CREATE PROCEDURE [dbo].Page_Delete
(
	@PageId uniqueidentifier
)
AS

DELETE dbo.[Page] 
WHERE 
	[PageId] = @PageId

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Page_GetById]'
GO
CREATE PROCEDURE [dbo].Page_GetById
(
	@PageId uniqueidentifier
)
AS

SELECT 
	[PageId],
	[PageName],
	[PageTitle] 
FROM 
	dbo.Page 
WHERE 
	PageId=@PageId

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Page_GetAll]'
GO
CREATE PROCEDURE [dbo].Page_GetAll
AS

SELECT 
	[PageId],
	[PageName],
	[PageTitle] 
FROM 
	dbo.Page

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Panel]'
GO
CREATE TABLE [dbo].[Panel]
(
[PanelId] [int] NOT NULL,
[PanelName] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Panel] on [dbo].[Panel]'
GO
ALTER TABLE [dbo].[Panel] ADD CONSTRAINT [PK_Panel] PRIMARY KEY CLUSTERED ([PanelId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Panel_GetById]'
GO
CREATE PROCEDURE [dbo].Panel_GetById
(
	@PanelId int
)
AS

SELECT 
	PanelId, 
	PanelName 
FROM 
	dbo.Panel 
WHERE 
	PanelId=@PanelId

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Panel_GetAll]'
GO
CREATE PROCEDURE [dbo].Panel_GetAll
AS

SELECT 
	PanelId, 
	PanelName 
FROM 
	dbo.Panel 


GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[PanelInPage_Insert]'
GO
CREATE PROCEDURE [dbo].PanelInPage_Insert
(
	@PageId uniqueidentifier, 
	@PanelId int,
	@Style ntext
)
AS

INSERT INTO dbo.[PanelInPage] 
(
	[PageId], 
	[PanelId], 
	[Style]
) 
VALUES 
(
	@PageId, 
	@PanelId, 
	@Style
)


GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[PanelInPage_Update]'
GO
CREATE PROCEDURE [dbo].PanelInPage_Update
(
	@PageId uniqueidentifier, 
	@PanelId int,
	@Style ntext
)
AS

UPDATE dbo.[PanelInPage] 
SET 
	[Style] = @Style 
WHERE 
	[PageId] = @PageId 
	AND [PanelId] = @PanelId


GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[PanelInPage_Delete]'
GO
CREATE PROCEDURE [dbo].PanelInPage_Delete
(
	@PageId uniqueidentifier, 
	@PanelId int
)
AS

DELETE dbo.[PanelInPage] 
WHERE 
	[PageId] = @PageId 
	AND [PanelId] = @PanelId


GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[PanelInPage_GetAllByPageId]'
GO
CREATE PROCEDURE [dbo].PanelInPage_GetAllByPageId
(
	@PageId uniqueidentifier
)
AS

SELECT 
	pip.PanelId, 
	PanelName, 
	[Style] 
FROM 
	dbo.PanelInPage pip 
	INNER JOIN dbo.Panel p ON pip.PanelId=p.PanelId 
WHERE 
	PageId=@PageId


GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Portlet]'
GO
CREATE TABLE [dbo].[Portlet]
(
[PortletId] [uniqueidentifier] NOT NULL,
[PortletName] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PortletDisplayURL] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PortletEditURL] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Portlet] on [dbo].[Portlet]'
GO
ALTER TABLE [dbo].[Portlet] ADD CONSTRAINT [PK_Portlet] PRIMARY KEY CLUSTERED ([PortletId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Portlet_Insert]'
GO
CREATE PROCEDURE [dbo].Portlet_Insert
(
	@PortletId uniqueidentifier,
	@PortletName nvarchar(250),
	@PortletDisplayURL nvarchar(250),
	@PortletEditURL nvarchar(250)
)
AS

INSERT INTO dbo.[Portlet] 
(
	[PortletId],
	[PortletName],
	[PortletDisplayURL],
	[PortletEditURL]
) 
VALUES 
(
	@PortletId,
	@PortletName,
	@PortletDisplayURL,
	@PortletEditURL
)


GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Portlet_Update]'
GO
CREATE PROCEDURE [dbo].Portlet_Update
(
	@PortletId uniqueidentifier,
	@PortletName nvarchar(250),
	@PortletDisplayURL nvarchar(250),
	@PortletEditURL nvarchar(250)
)
AS

UPDATE dbo.[Portlet] 
SET 
	[PortletName] = @PortletName, 
	[PortletDisplayURL] = @PortletDisplayURL, 
	[PortletEditURL] = @PortletEditURL 
WHERE 
	[PortletId] = @PortletId


GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Portlet_GetAll]'
GO
CREATE PROCEDURE [dbo].Portlet_GetAll
AS

SELECT 
	[PortletId],
	[PortletName],
	[PortletDisplayURL],
	[PortletEditURL] 
FROM 
	dbo.Portlet


GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[PortletInstance]'
GO
CREATE TABLE [dbo].[PortletInstance]
(
[PortletInstanceId] [uniqueidentifier] NOT NULL,
[PortletInstanceName] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PortletId] [uniqueidentifier] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_PortletInstance] on [dbo].[PortletInstance]'
GO
ALTER TABLE [dbo].[PortletInstance] ADD CONSTRAINT [PK_PortletInstance] PRIMARY KEY CLUSTERED ([PortletInstanceId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[PortletInstance_Insert]'
GO
CREATE PROCEDURE [dbo].PortletInstance_Insert
(
	@PortletInstanceId uniqueidentifier,
	@PortletInstanceName nvarchar(250),
	@PortletId uniqueidentifier
)
AS

INSERT INTO dbo.[PortletInstance] 
(
	[PortletInstanceId],
	[PortletInstanceName], 
	[PortletId]
) 
VALUES 
(
	@PortletInstanceId,
	@PortletInstanceName,
	@PortletId
)


GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[PortletInstance_Update]'
GO
CREATE PROCEDURE [dbo].PortletInstance_Update
(
	@PortletInstanceId uniqueidentifier,
	@PortletInstanceName nvarchar(250),
	@PortletId uniqueidentifier
)
AS

UPDATE dbo.[PortletInstance] 
SET 
	[PortletInstanceName] = @PortletInstanceName, 
	[PortletId]=@PortletId 
WHERE 
	[PortletInstanceId] = @PortletInstanceId


GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[PortletInstance_Delete]'
GO
CREATE PROCEDURE [dbo].PortletInstance_Delete
(
	@PortletInstanceId uniqueidentifier
)
AS

DELETE dbo.[PortletInstance] 
WHERE 
	[PortletInstanceId] = @PortletInstanceId


GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[PortletInstance_GetById]'
GO
CREATE PROCEDURE [dbo].PortletInstance_GetById
(
	@PortletInstanceId uniqueidentifier
)
AS

SELECT 
	PortletInstanceId, 
	PortletInstanceName, 
	p.PortletId, 
	PortletName, 
	PortletDisplayURL, 
	PortletEditURL 
FROM 
	PortletInstance a 
	INNER JOIN Portlet p ON a.PortletId=p.PortletId 
WHERE 
	PortletInstanceId=@PortletInstanceId


GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[PortletInstance_GetAll]'
GO
CREATE PROCEDURE [dbo].PortletInstance_GetAll
(
	@PortletInstanceId uniqueidentifier
)
AS

SELECT 
	[PortletInstanceId],
	[PortletInstanceName] 
FROM 
	dbo.PortletInstance


GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[PortletInstance_GetAllByPageId]'
GO
CREATE PROCEDURE [dbo].PortletInstance_GetAllByPageId
(
	@PageId uniqueidentifier
)
AS

SELECT 
	pip.PortletInstanceId, 
	PortletInstanceName, 
	p.PortletId, 
	PortletName, 
	PortletDisplayURL, 
	PortletEditURL
FROM 
	dbo.PortletInstanceInPanel pip 
	inner join PortletInstance pin on pip.PortletInstanceId=pin.PortletInstanceId 
	inner join Portlet p on pin.PortletId=p.PortletId
WHERE 
	PageId=@PageId 

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[PortletInstanceInPanel_Insert]'
GO
CREATE PROCEDURE [dbo].PortletInstanceInPanel_Insert
(
	
	@PortletInstanceId uniqueidentifier, 
	@PortletInstanceName nvarchar(250), 
	@PortletId uniqueidentifier,
	@PageId uniqueidentifier,
	@PanelId int, 
	@Style ntext, 
	@Order int
)
AS

IF (NOT EXISTS(SELECT 1 FROM PortletInstance WHERE PortletInstanceId=@PortletInstanceId)) 
BEGIN
INSERT INTO dbo.[PortletInstance] 
(
	[PortletInstanceId], 
	[PortletInstanceName], 
	[PortletId]
) 
VALUES 
(
	@PortletInstanceId, 
	@PortletInstanceName, 
	@PortletId
) 
END

INSERT INTO dbo.[PortletInstanceInPanel] 
(
	[PortletInstanceId], 
	[PageId], 
	[PanelId], 
	[Style], 
	[Order]
) 
VALUES 
(
	@PortletInstanceId, 
	@PageId, 
	@PanelId, 
	@Style, 
	@Order
)

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[PortletInstanceInPanel_Update]'
GO
CREATE PROCEDURE [dbo].PortletInstanceInPanel_Update
(
	
	@PortletInstanceId uniqueidentifier,
	@PageId uniqueidentifier,
	@PanelId int, 
	@Style ntext
)
AS

UPDATE dbo.[PortletInstanceInPanel] 
SET 
	[Style] = @Style 
WHERE 
	[PortletInstanceId] = @PortletInstanceId 
	AND [PageId] = @PageId 
	AND [PanelId] = @PanelId

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[PortletInstanceInPanel_Delete]'
GO
CREATE PROCEDURE [dbo].PortletInstanceInPanel_Delete
(
	
	@PortletInstanceId uniqueidentifier,
	@PageId uniqueidentifier,
	@PanelId int
)
AS

DELETE dbo.[PortletInstanceInPanel] 
WHERE 
	[PortletInstanceId] = @PortletInstanceId 
	AND [PageId] = @PageId 
	AND [PanelId] = @PanelId

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[PortletInstanceInPanel_GetAllByPageIdAndPanelId]'
GO
CREATE PROCEDURE [dbo].PortletInstanceInPanel_GetAllByPageIdAndPanelId
(
	@PageId uniqueidentifier,
	@PanelId int
)
AS

SELECT 
	pip.[PortletInstanceId], 
	PortletInstanceName, 
	[Style],
	[Order], 
	p.PortletId, 
	PortletName, 
	PortletDisplayURL, 
	PortletEditURL 
FROM 
	dbo.PortletInstanceInPanel pip 
	INNER JOIN dbo.PortletInstance [pi]
	ON pip.PortletInstanceId= [pi].PortletInstanceId 
	INNER JOIN Portlet p ON [pi].PortletId=p.PortletId  
WHERE 
	PageId=@PageId 
	AND PanelId=@PanelId  
ORDER BY 
	[Order]

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[PortletInstanceInPanel_UpdatePosition]'
GO
CREATE PROCEDURE [dbo].PortletInstanceInPanel_UpdatePosition
(
	@PortletInstanceId uniqueidentifier,
	@PageId uniqueidentifier,
	@PanelId int,
	@Order int
)
AS

UPDATE dbo.PortletInstanceInPanel 
SET 
	[Order]=@Order, 
	PanelId=@PanelId 
WHERE 
	PortletInstanceId=@PortletInstanceId 
	AND PageId=@PageId

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Portlet_Delete]'
GO

CREATE PROCEDURE [dbo].Portlet_Delete
(
	@PortletId uniqueidentifier
)
AS

DELETE dbo.[Portlet] 
WHERE 
	[PortletId] = @PortletId


GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Authentication]'
GO
CREATE TABLE [dbo].[Authentication]
(
[AuthenticationId] [uniqueidentifier] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Authentication] on [dbo].[Authentication]'
GO
ALTER TABLE [dbo].[Authentication] ADD CONSTRAINT [PK_Authentication] PRIMARY KEY CLUSTERED ([AuthenticationId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Role_Update]'
GO

CREATE PROCEDURE [dbo].Role_Update
(
	@RoleID uniqueidentifier,
	@RoleName nvarchar(250),
	@RoleDescription nvarchar(250)
)
AS

UPDATE dbo.[Role] 
SET 
	[RoleName] = @RoleName, 
	[RoleDescription] = @RoleDescription 
WHERE 
	[RoleId] = @RoleId


GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Role_Delete]'
GO

CREATE PROCEDURE [dbo].Role_Delete
(
	@RoleID uniqueidentifier
)
AS

DELETE dbo.[Role] 
WHERE 
	[RoleId] = @RoleId

DELETE dbo.[Authentication]
WHERE 
	AuthenticationId = @RoleId


GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[User_GetUsersNotInRole]'
GO

CREATE PROCEDURE [dbo].User_GetUsersNotInRole
(
	@RoleID uniqueidentifier
)
AS

SELECT UserId 
INTO #USER
FROM 
	UserInRole 
WHERE RoleId = @RoleID

SELECT 
	a.UserId,
	[UserName],
	[Password],
	[Email],
	[PasswordQuestion],
	[PasswordAnswer],
	[CreationDate],
	[LastActivityDate],
	[LastLoginDate],
	[LastPasswordChangeDate],
	[IsApproved],
	[IsOnline] 
FROM 
	dbo.[User] a
	LEFT JOIN #USER b ON a.UserId = b.UserId
WHERE 
	b.UserId IS NULL

DROP TABLE #USER

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Role_GetAll]'
GO

CREATE PROCEDURE [dbo].Role_GetAll
AS

SELECT 
	[RoleId],
	[RoleName],
	[RoleDescription] 
FROM dbo.[Role]

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Role_GetAllByUserName]'
GO

CREATE PROCEDURE [dbo].Role_GetAllByUserName
(
	@UserName nvarchar(250)
)
AS

SELECT 
	r.RoleId, 
	RoleName, 
	RoleDescription 
FROM 
	dbo.[User] u 
	INNER JOIN dbo.[UserInRole] uir ON u.UserId=uir.UserId 
	INNER JOIN [Role] r ON uir.RoleId=r.RoleId 
WHERE 
	[UserName]=@UserName

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[RoleInRole]'
GO
CREATE TABLE [dbo].[RoleInRole]
(
[RefId] [uniqueidentifier] NOT NULL,
[RoleId] [uniqueidentifier] NOT NULL,
[RoleParentId] [uniqueidentifier] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_RoleInRole] on [dbo].[RoleInRole]'
GO
ALTER TABLE [dbo].[RoleInRole] ADD CONSTRAINT [PK_RoleInRole] PRIMARY KEY CLUSTERED ([RefId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_RoleInRole] on [dbo].[RoleInRole]'
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_RoleInRole] ON [dbo].[RoleInRole] ([RoleId], [RoleParentId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[RoleInRole_Insert]'
GO

CREATE PROCEDURE [dbo].RoleInRole_Insert
(
	@RefId uniqueidentifier,
	@RoleId uniqueidentifier,
	@RoleParentId uniqueidentifier
)
AS

INSERT INTO dbo.[RoleInRole] 
(
	[RefId],
	[RoleId],
	[RoleParentId]
) 
VALUES 
(
	@RefId,
	@RoleId,
	@RoleParentId
)

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[RoleInRole_Update]'
GO

CREATE PROCEDURE [dbo].RoleInRole_Update
(
	@RefId uniqueidentifier,
	@RoleId uniqueidentifier,
	@RoleParentId uniqueidentifier
)
AS

UPDATE dbo.[RoleInRole] 
SET 
	[RoleId] = @RoleId, 
	[RoleParentId] = @RoleParentId 
WHERE [RefId] = @RefId

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[RoleInRole_Delete]'
GO

CREATE PROCEDURE [dbo].RoleInRole_Delete
(
	@RefId uniqueidentifier
)
AS

DELETE dbo.[RoleInRole] 
WHERE 
	[RefId] = @RefId

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Article_Insert]'
GO
CREATE PROCEDURE Article_Insert
(
	@ArticleId uniqueidentifier,
	@ArticleName nvarchar(250),
	@ArticleTitle nvarchar(250),
	@ArticleCreatedDate datetime,
	@ArticleModifiedDate datetime,
	@ArticleIsPublish bit, 
	@PageId uniqueidentifier = null,
	
	@TopicId uniqueidentifier
)
AS
INSERT INTO dbo.[Article] 
(
	[ArticleId],
	[ArticleName],
	[ArticleTitle],
	[ArticleCreatedDate],
	[ArticleModifiedDate],
	[ArticleIsPublish], 
	[PageId]
) 
VALUES 
(
	@ArticleId,
	@ArticleName,
	@ArticleTitle,
	@ArticleCreatedDate,
	@ArticleModifiedDate,
	@ArticleIsPublish, 
	@PageId
)

INSERT INTO dbo.[ArticleDetail]
(
	[ArticleId],
	[ArticleDescription],
	[ArticleContent]
) 
VALUES 
(
	@ArticleId,
	'',	--[ArticleDescription]
	''	--[ArticleContent]
)

INSERT INTO dbo.[ArticleBelongTopic] 
(
	ArticleId, 
	TopicId
) 
VALUES 
(
	@ArticleId, 
	@TopicId
) 

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[RoleInRole_GetAll]'
GO

CREATE PROCEDURE [dbo].RoleInRole_GetAll
(
	@RefId uniqueidentifier
)
AS

SELECT 
	[RefId],
	[RoleId],
	[RoleParentId] 
FROM 
	dbo.[RoleInRole]

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Article_Update]'
GO
CREATE PROCEDURE Article_Update
(
	@ArticleId uniqueidentifier,
	@ArticleName nvarchar(250),
	@ArticleTitle nvarchar(250),
	@ArticleCreatedDate datetime,
	@ArticleModifiedDate datetime,
	@ArticleIsPublish bit, 
	@PageId uniqueidentifier = null
)
AS
UPDATE dbo.[Article] 
SET 
	[ArticleName] = @ArticleName, 
	[ArticleTitle] = @ArticleTitle, 
	[ArticleCreatedDate] = @ArticleCreatedDate, 
	[ArticleModifiedDate] = @ArticleModifiedDate, 
	[ArticleIsPublish] = @ArticleIsPublish, 
	PageId=@PageId 
WHERE [ArticleId] = @ArticleId

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[User_Insert]'
GO

CREATE PROCEDURE [dbo].User_Insert
(
	@UserID uniqueidentifier,
	@UserName nvarchar(250),
	@Password nvarchar(250),
	@Email nvarchar(250),
	@CreationDate datetime,
	@LastActivityDate datetime,
	@LastLoginDate datetime,
	@LastPasswordChangeDate datetime,
	@PasswordQuestion nvarchar(250),
	@PasswordAnswer nvarchar(250),
	@IsApproved nvarchar(250),
	@IsOnline bit
)
AS

BEGIN TRAN
INSERT INTO dbo.[Authentication]
(
	AuthenticationId
) 
Values 
(
	@UserID
) 

INSERT INTO dbo.[User] 
(
	[UserID],
	[UserName],
	[Password],
	[Email],
	[CreationDate],
	[LastActivityDate],
	[LastLoginDate],
	[LastPasswordChangeDate],
	[PasswordQuestion],
	[PasswordAnswer],
	[IsApproved],
	[IsOnline]
) 
VALUES 
(
	@UserID,
	@UserName,
	@Password,
	@Email,
	@CreationDate,
	@LastActivityDate,
	@LastLoginDate,
	@LastPasswordChangeDate,
	@PasswordQuestion,
	@PasswordAnswer,
	@IsApproved,
	@IsOnline
)

IF @@ERROR >0 
	ROLLBACK TRAN 
ELSE 
	COMMIT TRAN

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[PictureType]'
GO
CREATE TABLE [dbo].[PictureType]
(
[PictureTypeId] [uniqueidentifier] NOT NULL,
[PictureTypeName] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PictureTypeParent] [uniqueidentifier] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_PictureType] on [dbo].[PictureType]'
GO
ALTER TABLE [dbo].[PictureType] ADD CONSTRAINT [PK_PictureType] PRIMARY KEY CLUSTERED ([PictureTypeId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Picture]'
GO
CREATE TABLE [dbo].[Picture]
(
[PictureId] [uniqueidentifier] NOT NULL,
[PictureName] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PictureContent] [image] NOT NULL,
[PictureDescription] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PictureLink] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PictureTypeId] [uniqueidentifier] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Picture] on [dbo].[Picture]'
GO
ALTER TABLE [dbo].[Picture] ADD CONSTRAINT [PK_Picture] PRIMARY KEY CLUSTERED ([PictureId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Article_MoveToTrash]'
GO
CREATE PROCEDURE Article_MoveToTrash
(
	@ArticleId uniqueidentifier
)
AS
DELETE dbo.[ArticleBelongTopic] 
WHERE [ArticleId] = @ArticleId

UPDATE dbo.[Article] 
SET 
	[ArticleIsPublish] = 0 
where [ArticleId]=@ArticleId

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Role_GetRolesBelongToUser]'
GO

CREATE PROCEDURE [dbo].[Role_GetRolesBelongToUser]
(
	@UserId uniqueidentifier
)
AS

SELECT 
	a.[RoleId],
	[RoleName],
	[RoleDescription] 
FROM 
	dbo.[Role] a
	inner join UserInRole b on a.RoleId = b.RoleId 
WHERE 
	UserId=@UserId

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Article_GetTopicBelong]'
GO
CREATE PROCEDURE Article_GetTopicBelong
(
	@ArticleId uniqueidentifier
)
AS
SELECT 
	t.TopicId, 
	TopicName, 
	TopicDescription 
FROM 
	dbo.[Topic] t 
	INNER JOIN ArticleBelongTopic abt ON t.TopicId = abt.TopicId 
WHERE 
	ArticleId = @ArticleId 

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Menu_GetAllByMenuMasterId]'
GO

CREATE PROCEDURE Menu_GetAllByMenuMasterId
(
	@MenuMasterId uniqueidentifier
)
AS
-- Khai báo bảng tạm chứa kết quả trả về
create table #temp
(
	stt int identity(0,1), 
	MenuId uniqueidentifier, 
	MenuName nvarchar(250), 
	MenuDescription nvarchar(250), 
	MenuNavigationURL varchar(250),
	MenuOrder int, 
	MenuParent uniqueidentifier
)

-- Thêm nút gốc vào bảng
insert into #temp
(
	MenuId, 
	MenuName, 
	MenuDescription, 
	MenuNavigationURL, 
	MenuOrder, 
	MenuParent
)
select 
	MenuId, 
	MenuName, 
	MenuDescription, 
	MenuNavigationURL, 
	MenuOrder, 
	MenuParent
from Menu
where MenuParent is null and MenuId = (select MenuId from MenuMaster where MenuMasterId=@MenuMasterId)

-- Lấy các mẩu tin thuộc cây menu lấy lên
declare @index int
set @index = 0
declare @max int
set @max = (select max(stt) from #temp)
declare @temp uniqueidentifier
while(@index<=@max)
begin
	set @temp = (select MenuId from #temp where stt=@index)
	insert into #temp(MenuId, MenuName ,MenuDescription, MenuNavigationURL, MenuOrder, MenuParent)
	select MenuId, MenuName, MenuDescription, MenuNavigationURL, MenuOrder, MenuParent
	from Menu
	where MenuParent=@temp order by MenuOrder
	set @index=@index +1
	set @max=(select max(stt) from #temp)
end

-- Lấy kết quả trả về
select 
	MenuId, 
	MenuName, 
	MenuDescription, 
	MenuNavigationURL, 
	MenuOrder, 
	MenuParent
from #temp     

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Page_CopyTo]'
GO
CREATE PROCEDURE [dbo].[Page_CopyTo]
(
	@SourcePageId uniqueidentifier,
	@DestPageId uniqueidentifier,
	@NewPageName nvarchar(500),
	@NewPageTitle nvarchar(500)
)
AS

-- Thêm mẩu tin về trang mới

INSERT INTO dbo.Page	([PageId], [PageName], [PageTitle])
VALUES					(@DestPageId, @NewPageName, @NewPageTitle)

-- Thông tin panel trên trang
INSERT dbo.[PanelInPage]
		(
			[PageId],
			[PanelId],
			[Style]
		)
SELECT 
	@DestPageId,
	PanelId,
	Style
FROM dbo.[PanelInPage]
where [PageId] = @SourcePageId

-- Thông tin portlet trên trang
INSERT [dbo].[PortletInstanceInPanel]
(
		[PortletInstanceId]
      ,[PageId]
      ,[PanelId]
      ,[Style]
      ,[Order]
)
SELECT [PortletInstanceId]
      ,@DestPageId AS [PageId]
      ,[PanelId]
      ,[Style]
      ,[Order]
FROM [dbo].[PortletInstanceInPanel]
WHERE  [PageId] = @SourcePageId

-- Lấy thông tin trả về
SELECT * FROM dbo.[Page]
WHERE PageId = @DestPageId



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Document_GetPrimaryDocumentTypeBelongTo]'
GO
CREATE PROCEDURE Document_GetPrimaryDocumentTypeBelongTo
(
	@DocumentId uniqueidentifier
)
AS

SELECT 
	t.DocumentTypeId, 
	DocumentTypeName, 
	DocumentTypeDescription 
FROM 
	dbo.[DocumentType] t 
	INNER JOIN dbo.[DocumentBelongDocumentTypePrimary] abt ON t.DocumentTypeId=abt.DocumentTypeId 
WHERE 
	DocumentId = @DocumentId 

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Role_Insert]'
GO

CREATE PROCEDURE [dbo].Role_Insert
(
	@RoleID uniqueidentifier,
	@RoleName nvarchar(250),
	@RoleDescription nvarchar(250)
)
AS

BEGIN TRAN 
INSERT INTO dbo.[Authentication]
(
	AuthenticationId
) 
Values 
(
	@RoleID
) 

INSERT INTO dbo.[Role] 
(
	[RoleID],
	[RoleName],
	[RoleDescription]
) 
VALUES 
(
	@RoleID,
	@RoleName,
	@RoleDescription
) 

if @@ERROR >0 
	ROLLBACK TRAN 
ELSE
	COMMIT TRAN


GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[FeedBackRespone]'
GO
CREATE TABLE [dbo].[FeedBackRespone]
(
[FeedBackId] [uniqueidentifier] NOT NULL,
[FeedBackAnswer] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_FeedBackRespone] on [dbo].[FeedBackRespone]'
GO
ALTER TABLE [dbo].[FeedBackRespone] ADD CONSTRAINT [PK_FeedBackRespone] PRIMARY KEY CLUSTERED ([FeedBackId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[HTMLBlog]'
GO
CREATE TABLE [dbo].[HTMLBlog]
(
[DataId] [uniqueidentifier] NOT NULL,
[HTMLBlogContent] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_HTMLBlog] on [dbo].[HTMLBlog]'
GO
ALTER TABLE [dbo].[HTMLBlog] ADD CONSTRAINT [PK_HTMLBlog] PRIMARY KEY CLUSTERED ([DataId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[PortletMenu]'
GO
CREATE TABLE [dbo].[PortletMenu]
(
[DataId] [uniqueidentifier] NOT NULL,
[MenuMasterId] [uniqueidentifier] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_PortletMenu] on [dbo].[PortletMenu]'
GO
ALTER TABLE [dbo].[PortletMenu] ADD CONSTRAINT [PK_PortletMenu] PRIMARY KEY CLUSTERED ([DataId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[PortletNewsInBrief]'
GO
CREATE TABLE [dbo].[PortletNewsInBrief]
(
[DataId] [uniqueidentifier] NOT NULL,
[TopicId] [uniqueidentifier] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_PortletNewsInBrief] on [dbo].[PortletNewsInBrief]'
GO
ALTER TABLE [dbo].[PortletNewsInBrief] ADD CONSTRAINT [PK_PortletNewsInBrief] PRIMARY KEY CLUSTERED ([DataId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[PortletTopicDisplay]'
GO
CREATE TABLE [dbo].[PortletTopicDisplay]
(
[DataId] [uniqueidentifier] NOT NULL,
[TopicId] [uniqueidentifier] NULL,
[NumberOfArticlesDisplay] [int] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_PortletTopicDisplay] on [dbo].[PortletTopicDisplay]'
GO
ALTER TABLE [dbo].[PortletTopicDisplay] ADD CONSTRAINT [PK_PortletTopicDisplay] PRIMARY KEY CLUSTERED ([DataId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[Article]'
GO
ALTER TABLE [dbo].[Article] WITH NOCHECK ADD
CONSTRAINT [FK_Article_Page] FOREIGN KEY ([PageId]) REFERENCES [dbo].[Page] ([PageId]) ON DELETE SET NULL
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[ArticleBelongTopicPrimary]'
GO
ALTER TABLE [dbo].[ArticleBelongTopicPrimary] WITH NOCHECK ADD
CONSTRAINT [FK_ArticleBelongTopicPrimary_ArticleBelongTopic] FOREIGN KEY ([ArticleId], [TopicId]) REFERENCES [dbo].[ArticleBelongTopic] ([ArticleId], [TopicId]) ON DELETE CASCADE
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[ArticleBelongTopic]'
GO
ALTER TABLE [dbo].[ArticleBelongTopic] WITH NOCHECK ADD
CONSTRAINT [FK_ArticleBelongTopic_Topic] FOREIGN KEY ([TopicId]) REFERENCES [dbo].[Topic] ([TopicId]) ON DELETE CASCADE
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[Document]'
GO
ALTER TABLE [dbo].[Document] WITH NOCHECK ADD
CONSTRAINT [FK_Document_Page] FOREIGN KEY ([PageId]) REFERENCES [dbo].[Page] ([PageId]) ON DELETE SET NULL
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[DocumentBelongDocumentType]'
GO
ALTER TABLE [dbo].[DocumentBelongDocumentType] WITH NOCHECK ADD
CONSTRAINT [FK_DocumentBelongDocumentType_DocumentType] FOREIGN KEY ([DocumentTypeId]) REFERENCES [dbo].[DocumentType] ([DocumentTypeId]) ON DELETE CASCADE
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[DocumentTypeAuthentication]'
GO
ALTER TABLE [dbo].[DocumentTypeAuthentication] WITH NOCHECK ADD
CONSTRAINT [FK_DocumentTypeAuthentication_DocumentType] FOREIGN KEY ([DocumentTypeId]) REFERENCES [dbo].[DocumentType] ([DocumentTypeId]) ON DELETE CASCADE,
CONSTRAINT [FK_DocumentTypeAuthentication_DocumentTypePermission] FOREIGN KEY ([DocumentTypePermissionId]) REFERENCES [dbo].[DocumentTypePermission] ([DocumentTypePermissionId]) ON DELETE CASCADE,
CONSTRAINT [FK_DocumentTypeAuthentication_Role] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[Role] ([RoleId]) ON DELETE CASCADE
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[MenuMaster]'
GO
ALTER TABLE [dbo].[MenuMaster] WITH NOCHECK ADD
CONSTRAINT [FK_MenuMaster_Menu] FOREIGN KEY ([MenuId]) REFERENCES [dbo].[Menu] ([MenuId]) ON DELETE CASCADE
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[PortletInstanceInPanel]'
GO
ALTER TABLE [dbo].[PortletInstanceInPanel] WITH NOCHECK ADD
CONSTRAINT [FK_PortletInstanceInPanel_PanelInPage] FOREIGN KEY ([PageId], [PanelId]) REFERENCES [dbo].[PanelInPage] ([PageId], [PanelId]) ON DELETE CASCADE,
CONSTRAINT [FK_PortletInstanceInPanel_PortletInstance] FOREIGN KEY ([PortletInstanceId]) REFERENCES [dbo].[PortletInstance] ([PortletInstanceId]) ON DELETE CASCADE
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[TopicAuthentication]'
GO
ALTER TABLE [dbo].[TopicAuthentication] WITH NOCHECK ADD
CONSTRAINT [FK_TopicAuthentication_Role] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[Role] ([RoleId]) ON DELETE CASCADE,
CONSTRAINT [FK_TopicAuthentication_Topic] FOREIGN KEY ([TopicId]) REFERENCES [dbo].[Topic] ([TopicId]) ON DELETE CASCADE,
CONSTRAINT [FK_TopicAuthentication_TopicPermission] FOREIGN KEY ([TopicPermissionId]) REFERENCES [dbo].[TopicPermission] ([TopicPermissionId]) ON DELETE CASCADE
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[TopicTemplate]'
GO
ALTER TABLE [dbo].[TopicTemplate] WITH NOCHECK ADD
CONSTRAINT [FK_TopicTemplate_Topic] FOREIGN KEY ([TopicId]) REFERENCES [dbo].[Topic] ([TopicId]) ON DELETE CASCADE
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[ArticleBelongTopic]'
GO
ALTER TABLE [dbo].[ArticleBelongTopic] ADD
CONSTRAINT [FK_ArticleBelongTopic_Article] FOREIGN KEY ([ArticleId]) REFERENCES [dbo].[Article] ([ArticleId]) ON DELETE CASCADE
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[ArticleDetail]'
GO
ALTER TABLE [dbo].[ArticleDetail] ADD
CONSTRAINT [FK_ArticleDetail_Article] FOREIGN KEY ([ArticleId]) REFERENCES [dbo].[Article] ([ArticleId]) ON DELETE CASCADE
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[Role]'
GO
ALTER TABLE [dbo].[Role] ADD
CONSTRAINT [FK_Role_Authentication] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[Authentication] ([AuthenticationId]) ON DELETE CASCADE ON UPDATE CASCADE
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[User]'
GO
ALTER TABLE [dbo].[User] ADD
CONSTRAINT [FK_User_Authentication] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Authentication] ([AuthenticationId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[DocumentBelongDocumentType]'
GO
ALTER TABLE [dbo].[DocumentBelongDocumentType] ADD
CONSTRAINT [FK_DocumentBelongDocumentType_Document] FOREIGN KEY ([DocumentId]) REFERENCES [dbo].[Document] ([DocumentId]) ON DELETE CASCADE
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[DocumentDetail]'
GO
ALTER TABLE [dbo].[DocumentDetail] ADD
CONSTRAINT [FK_DocumentDetail_Document] FOREIGN KEY ([DocumentId]) REFERENCES [dbo].[Document] ([DocumentId]) ON DELETE CASCADE
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[DocumentBelongDocumentTypePrimary]'
GO
ALTER TABLE [dbo].[DocumentBelongDocumentTypePrimary] ADD
CONSTRAINT [FK_DocumentBelongDocumentTypePrimary_DocumentBelongDocumentType] FOREIGN KEY ([DocumentId], [DocumentTypeId]) REFERENCES [dbo].[DocumentBelongDocumentType] ([DocumentId], [DocumentTypeId]) ON DELETE CASCADE
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[DocumentType]'
GO
ALTER TABLE [dbo].[DocumentType] ADD
CONSTRAINT [FK_DocumentType_DocumentType] FOREIGN KEY ([DocumentTypeParent]) REFERENCES [dbo].[DocumentType] ([DocumentTypeId]),
CONSTRAINT [FK_DocumentType_Page] FOREIGN KEY ([PageId]) REFERENCES [dbo].[Page] ([PageId]) ON DELETE SET NULL
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[Menu]'
GO
ALTER TABLE [dbo].[Menu] ADD
CONSTRAINT [FK_Menu_Menu] FOREIGN KEY ([MenuParent]) REFERENCES [dbo].[Menu] ([MenuId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[PanelInPage]'
GO
ALTER TABLE [dbo].[PanelInPage] ADD
CONSTRAINT [FK_PanelInPage_Page] FOREIGN KEY ([PageId]) REFERENCES [dbo].[Page] ([PageId]) ON DELETE CASCADE,
CONSTRAINT [FK_PanelInPage_Panel] FOREIGN KEY ([PanelId]) REFERENCES [dbo].[Panel] ([PanelId]) ON DELETE CASCADE
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[Topic]'
GO
ALTER TABLE [dbo].[Topic] ADD
CONSTRAINT [FK_Topic_Page] FOREIGN KEY ([PageId]) REFERENCES [dbo].[Page] ([PageId]) ON DELETE SET NULL,
CONSTRAINT [FK_Topic_Topic] FOREIGN KEY ([TopicParent]) REFERENCES [dbo].[Topic] ([TopicId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[Picture]'
GO
ALTER TABLE [dbo].[Picture] ADD
CONSTRAINT [FK_Picture_PictureType] FOREIGN KEY ([PictureTypeId]) REFERENCES [dbo].[PictureType] ([PictureTypeId]) ON DELETE CASCADE
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[PictureType]'
GO
ALTER TABLE [dbo].[PictureType] ADD
CONSTRAINT [FK_PictureType_PictureType] FOREIGN KEY ([PictureTypeParent]) REFERENCES [dbo].[PictureType] ([PictureTypeId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[PortletInstance]'
GO
ALTER TABLE [dbo].[PortletInstance] ADD
CONSTRAINT [FK_PortletInstance_Portlet] FOREIGN KEY ([PortletId]) REFERENCES [dbo].[Portlet] ([PortletId]) ON DELETE CASCADE
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[UserInRole]'
GO
ALTER TABLE [dbo].[UserInRole] ADD
CONSTRAINT [FK_UserInRole_Role] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[Role] ([RoleId]) ON DELETE CASCADE,
CONSTRAINT [FK_UserInRole_User] FOREIGN KEY ([UserId]) REFERENCES [dbo].[User] ([UserId]) ON DELETE CASCADE
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
IF EXISTS (SELECT * FROM #tmpErrors) ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT>0 BEGIN
PRINT 'The database update succeeded'
COMMIT TRANSACTION
END
ELSE PRINT 'The database update failed'
GO
DROP TABLE #tmpErrors
GO
SET NUMERIC_ROUNDABORT OFF
GO
SET XACT_ABORT, ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS, NOCOUNT ON
GO
SET DATEFORMAT YMD
GO
-- Pointer used for text / image updates. This might not be needed, but is declared here just in case
DECLARE @pv binary(16)

BEGIN TRANSACTION

-- Drop constraints from [dbo].[UserInRole]
ALTER TABLE [dbo].[UserInRole] DROP CONSTRAINT [FK_UserInRole_Role]
ALTER TABLE [dbo].[UserInRole] DROP CONSTRAINT [FK_UserInRole_User]

-- Drop constraints from [dbo].[User]
ALTER TABLE [dbo].[User] DROP CONSTRAINT [FK_User_Authentication]

-- Drop constraints from [dbo].[Topic]
ALTER TABLE [dbo].[Topic] DROP CONSTRAINT [FK_Topic_Page]
ALTER TABLE [dbo].[Topic] DROP CONSTRAINT [FK_Topic_Topic]

-- Drop constraint FK_ArticleBelongTopic_Topic from [dbo].[ArticleBelongTopic]
ALTER TABLE [dbo].[ArticleBelongTopic] DROP CONSTRAINT [FK_ArticleBelongTopic_Topic]

-- Drop constraint FK_TopicAuthentication_Topic from [dbo].[TopicAuthentication]
ALTER TABLE [dbo].[TopicAuthentication] DROP CONSTRAINT [FK_TopicAuthentication_Topic]

-- Drop constraint FK_TopicTemplate_Topic from [dbo].[TopicTemplate]
ALTER TABLE [dbo].[TopicTemplate] DROP CONSTRAINT [FK_TopicTemplate_Topic]

-- Drop constraints from [dbo].[Role]
ALTER TABLE [dbo].[Role] DROP CONSTRAINT [FK_Role_Authentication]

-- Drop constraint FK_DocumentTypeAuthentication_Role from [dbo].[DocumentTypeAuthentication]
ALTER TABLE [dbo].[DocumentTypeAuthentication] DROP CONSTRAINT [FK_DocumentTypeAuthentication_Role]

-- Drop constraint FK_TopicAuthentication_Role from [dbo].[TopicAuthentication]
ALTER TABLE [dbo].[TopicAuthentication] DROP CONSTRAINT [FK_TopicAuthentication_Role]

-- Drop constraints from [dbo].[PortletInstance]
ALTER TABLE [dbo].[PortletInstance] DROP CONSTRAINT [FK_PortletInstance_Portlet]

-- Drop constraint FK_PortletInstanceInPanel_PortletInstance from [dbo].[PortletInstanceInPanel]
ALTER TABLE [dbo].[PortletInstanceInPanel] DROP CONSTRAINT [FK_PortletInstanceInPanel_PortletInstance]

-- Drop constraints from [dbo].[Picture]
ALTER TABLE [dbo].[Picture] DROP CONSTRAINT [FK_Picture_PictureType]

-- Drop constraints from [dbo].[PanelInPage]
ALTER TABLE [dbo].[PanelInPage] DROP CONSTRAINT [FK_PanelInPage_Page]
ALTER TABLE [dbo].[PanelInPage] DROP CONSTRAINT [FK_PanelInPage_Panel]

-- Drop constraint FK_PortletInstanceInPanel_PanelInPage from [dbo].[PortletInstanceInPanel]
ALTER TABLE [dbo].[PortletInstanceInPanel] DROP CONSTRAINT [FK_PortletInstanceInPanel_PanelInPage]

-- Drop constraints from [dbo].[DocumentType]
ALTER TABLE [dbo].[DocumentType] DROP CONSTRAINT [FK_DocumentType_DocumentType]
ALTER TABLE [dbo].[DocumentType] DROP CONSTRAINT [FK_DocumentType_Page]

-- Drop constraint FK_DocumentBelongDocumentType_DocumentType from [dbo].[DocumentBelongDocumentType]
ALTER TABLE [dbo].[DocumentBelongDocumentType] DROP CONSTRAINT [FK_DocumentBelongDocumentType_DocumentType]

-- Drop constraint FK_DocumentTypeAuthentication_DocumentType from [dbo].[DocumentTypeAuthentication]
ALTER TABLE [dbo].[DocumentTypeAuthentication] DROP CONSTRAINT [FK_DocumentTypeAuthentication_DocumentType]

-- Drop constraint FK_TopicAuthentication_TopicPermission from [dbo].[TopicAuthentication]
ALTER TABLE [dbo].[TopicAuthentication] DROP CONSTRAINT [FK_TopicAuthentication_TopicPermission]

-- Drop constraints from [dbo].[PictureType]
ALTER TABLE [dbo].[PictureType] DROP CONSTRAINT [FK_PictureType_PictureType]

-- Drop constraint FK_Article_Page from [dbo].[Article]
ALTER TABLE [dbo].[Article] DROP CONSTRAINT [FK_Article_Page]

-- Drop constraint FK_Document_Page from [dbo].[Document]
ALTER TABLE [dbo].[Document] DROP CONSTRAINT [FK_Document_Page]

-- Drop constraints from [dbo].[Menu]
ALTER TABLE [dbo].[Menu] DROP CONSTRAINT [FK_Menu_Menu]

-- Drop constraint FK_MenuMaster_Menu from [dbo].[MenuMaster]
ALTER TABLE [dbo].[MenuMaster] DROP CONSTRAINT [FK_MenuMaster_Menu]

-- Drop constraint FK_DocumentTypeAuthentication_DocumentTypePermission from [dbo].[DocumentTypeAuthentication]
ALTER TABLE [dbo].[DocumentTypeAuthentication] DROP CONSTRAINT [FK_DocumentTypeAuthentication_DocumentTypePermission]

-- Add 30 rows to [dbo].[Authentication]
INSERT INTO [dbo].[Authentication] ([AuthenticationId]) VALUES ('386df162-2ad2-49d7-9c1e-1b398446b724')
INSERT INTO [dbo].[Authentication] ([AuthenticationId]) VALUES ('167e4091-4e35-430b-9e45-2445948632eb')
INSERT INTO [dbo].[Authentication] ([AuthenticationId]) VALUES ('6d712c49-21a8-419c-a52f-36c164322207')
INSERT INTO [dbo].[Authentication] ([AuthenticationId]) VALUES ('a6cea14b-adef-4312-b43d-37a9cd1e647a')
INSERT INTO [dbo].[Authentication] ([AuthenticationId]) VALUES ('35afad4c-8b06-4137-8224-3d6a72d78cf1')
INSERT INTO [dbo].[Authentication] ([AuthenticationId]) VALUES ('6123d6f7-1bb6-4b4e-9694-5af25f08063b')
INSERT INTO [dbo].[Authentication] ([AuthenticationId]) VALUES ('c7b4b616-ea76-41ee-b79b-67e6317960ae')
INSERT INTO [dbo].[Authentication] ([AuthenticationId]) VALUES ('b0c4a5a3-3077-48ea-b8f2-79adbd598ff3')
INSERT INTO [dbo].[Authentication] ([AuthenticationId]) VALUES ('c597c438-d847-4e6a-ad60-7ab6fe8b98bf')
INSERT INTO [dbo].[Authentication] ([AuthenticationId]) VALUES ('396a0724-3a85-46f1-a1b2-84981a242251')
INSERT INTO [dbo].[Authentication] ([AuthenticationId]) VALUES ('8deda2fa-37d2-491a-b625-85b559b5099c')
INSERT INTO [dbo].[Authentication] ([AuthenticationId]) VALUES ('74c4e30a-2048-475b-ac0f-8ab9b4c694e2')
INSERT INTO [dbo].[Authentication] ([AuthenticationId]) VALUES ('345a137f-a2d7-4c14-a1dc-9012c379c1b1')
INSERT INTO [dbo].[Authentication] ([AuthenticationId]) VALUES ('72daf62e-e11a-4498-81a2-987db9d09669')
INSERT INTO [dbo].[Authentication] ([AuthenticationId]) VALUES ('3817f820-e6f0-4553-a511-a3da72435609')
INSERT INTO [dbo].[Authentication] ([AuthenticationId]) VALUES ('37293782-f7ad-4f51-ac8f-a45e045891be')
INSERT INTO [dbo].[Authentication] ([AuthenticationId]) VALUES ('c444e2f8-f819-4b95-a185-a6519bc0d494')
INSERT INTO [dbo].[Authentication] ([AuthenticationId]) VALUES ('56a94f37-61f6-4203-b520-a71bb0a29bc1')
INSERT INTO [dbo].[Authentication] ([AuthenticationId]) VALUES ('e34524bc-c69f-49cc-981a-ab6a140ebb68')
INSERT INTO [dbo].[Authentication] ([AuthenticationId]) VALUES ('39463254-c41f-4f2c-9002-addf436eaa50')
INSERT INTO [dbo].[Authentication] ([AuthenticationId]) VALUES ('8b43d932-0d27-490e-bb4b-bcdbed114e8f')
INSERT INTO [dbo].[Authentication] ([AuthenticationId]) VALUES ('696d4ac3-9a21-455c-a5d2-c70873dedd6b')
INSERT INTO [dbo].[Authentication] ([AuthenticationId]) VALUES ('d584a32e-1218-475b-adb4-c71093105121')
INSERT INTO [dbo].[Authentication] ([AuthenticationId]) VALUES ('4d4c63cf-c535-4af6-9413-d0a54e07caa8')
INSERT INTO [dbo].[Authentication] ([AuthenticationId]) VALUES ('4b86e33f-be48-47ec-af90-d429357426d2')
INSERT INTO [dbo].[Authentication] ([AuthenticationId]) VALUES ('71420c3b-3be9-4fad-a36b-d90fa7917fb9')
INSERT INTO [dbo].[Authentication] ([AuthenticationId]) VALUES ('bf4a025e-5bf6-4581-a92b-dac42029cd90')
INSERT INTO [dbo].[Authentication] ([AuthenticationId]) VALUES ('86ac345d-5b6c-44e8-bdb1-e0c50527ba65')
INSERT INTO [dbo].[Authentication] ([AuthenticationId]) VALUES ('173ca55d-89e8-4166-bd2d-ea364f92d110')
INSERT INTO [dbo].[Authentication] ([AuthenticationId]) VALUES ('e34375e2-b729-4afe-974a-f1dfb6bbfb39')

-- Add 5 rows to [dbo].[DocumentTypePermission]
INSERT INTO [dbo].[DocumentTypePermission] ([DocumentTypePermissionId], [DocumentTypePermissionName]) VALUES (1, N'Phân quyền trên loại tài liệu')
INSERT INTO [dbo].[DocumentTypePermission] ([DocumentTypePermissionId], [DocumentTypePermissionName]) VALUES (2, N'Hiệu chỉnh tài liệu')
INSERT INTO [dbo].[DocumentTypePermission] ([DocumentTypePermissionId], [DocumentTypePermissionName]) VALUES (3, N'Xóa tài liệu')
INSERT INTO [dbo].[DocumentTypePermission] ([DocumentTypePermissionId], [DocumentTypePermissionName]) VALUES (4, N'Thêm mới tài liệu')
INSERT INTO [dbo].[DocumentTypePermission] ([DocumentTypePermissionId], [DocumentTypePermissionName]) VALUES (5, N'Duyệt tài liệu')

-- Add 54 rows to [dbo].[Menu]
INSERT INTO [dbo].[Menu] ([MenuId], [MenuName], [MenuDescription], [MenuNavigationURL], [MenuOrder], [MenuParent]) VALUES ('c4da31d7-e39b-4a71-8c4c-02d0f2f83d42', N'ROOT of Master [te]', N'ROOT of Master [te]', '#ROOT', 0, NULL)
INSERT INTO [dbo].[Menu] ([MenuId], [MenuName], [MenuDescription], [MenuNavigationURL], [MenuOrder], [MenuParent]) VALUES ('a652e3c0-d70a-4106-859b-03104dd7fd6a', N'Sản phẩm', N'Sản phẩm', '~/Default.aspx?ArticleId=2c028a31-f656-4a1d-b419-39964aae2e9d', 2, 'f014bd49-8254-4512-8776-8c623bb24e6e')
INSERT INTO [dbo].[Menu] ([MenuId], [MenuName], [MenuDescription], [MenuNavigationURL], [MenuOrder], [MenuParent]) VALUES ('17bf9be7-944b-4040-946f-03b4b11bf911', N'Giới thiệu', N'Giới thiệu', '', 3, 'f014bd49-8254-4512-8776-8c623bb24e6e')
INSERT INTO [dbo].[Menu] ([MenuId], [MenuName], [MenuDescription], [MenuNavigationURL], [MenuOrder], [MenuParent]) VALUES ('f864676f-8fcc-4860-abb7-065be8812f8f', N'Trang chủ', N'Trang chủ', '~/Default.aspx?PageId=00000000-0000-0000-0000-000000000000', 1, 'f014bd49-8254-4512-8776-8c623bb24e6e')
INSERT INTO [dbo].[Menu] ([MenuId], [MenuName], [MenuDescription], [MenuNavigationURL], [MenuOrder], [MenuParent]) VALUES ('91264aeb-577b-4b49-8843-169d4193afe3', N'item 1', N'item 1', '~/Default.aspx?ModuleId=af0dd9fc-002d-494b-8ad4-b9ebf1943068', 2, '416b4d1a-1f98-450c-bdd3-6e9de7770225')
INSERT INTO [dbo].[Menu] ([MenuId], [MenuName], [MenuDescription], [MenuNavigationURL], [MenuOrder], [MenuParent]) VALUES ('59950629-f19e-4036-a108-1923b819ed75', N'root', N'root', 'root', 0, NULL)
INSERT INTO [dbo].[Menu] ([MenuId], [MenuName], [MenuDescription], [MenuNavigationURL], [MenuOrder], [MenuParent]) VALUES ('33849027-b529-4dc8-ba10-1972fe9b77f9', N'ROOT of Master [duc test]', N'ROOT of Master [duc test]', '#ROOT', 0, NULL)
INSERT INTO [dbo].[Menu] ([MenuId], [MenuName], [MenuDescription], [MenuNavigationURL], [MenuOrder], [MenuParent]) VALUES ('39a7321e-5a4d-4c50-8725-1a4339310d28', N'ROOT of Master [test]', N'ROOT of Master [test]', '#ROOT', 0, NULL)
INSERT INTO [dbo].[Menu] ([MenuId], [MenuName], [MenuDescription], [MenuNavigationURL], [MenuOrder], [MenuParent]) VALUES ('b52c54ef-5be5-40e8-80b6-1da9feb64a1b', N'Menu 1', N'Menu 1', '#', 2, '62af0c41-bff5-447d-8f7b-a416b56092a9')
INSERT INTO [dbo].[Menu] ([MenuId], [MenuName], [MenuDescription], [MenuNavigationURL], [MenuOrder], [MenuParent]) VALUES ('6823a5f4-cab2-493f-9166-276f9a9b3936', N'test4', N'test4', '#', 1, '28049f37-4613-407b-8aea-9c1d96244cb0')
INSERT INTO [dbo].[Menu] ([MenuId], [MenuName], [MenuDescription], [MenuNavigationURL], [MenuOrder], [MenuParent]) VALUES ('34c972aa-c032-426a-a21f-307af0d8f3ec', N'HRM', N'HRM', '~/Default.aspx?TopicId=1cb794bd-2bf2-422a-9143-2dacfc6c842f', 2, 'a652e3c0-d70a-4106-859b-03104dd7fd6a')
INSERT INTO [dbo].[Menu] ([MenuId], [MenuName], [MenuDescription], [MenuNavigationURL], [MenuOrder], [MenuParent]) VALUES ('4d127925-d8f6-4132-af86-3098d0ddf3bc', N'Năng lực công ty', N'Năng lực công ty', '#', 2, '17bf9be7-944b-4040-946f-03b4b11bf911')
INSERT INTO [dbo].[Menu] ([MenuId], [MenuName], [MenuDescription], [MenuNavigationURL], [MenuOrder], [MenuParent]) VALUES ('4102c44a-5077-45fc-8815-315f276768d3', N'item 12', N'item 12', '#', 3, '416b4d1a-1f98-450c-bdd3-6e9de7770225')
INSERT INTO [dbo].[Menu] ([MenuId], [MenuName], [MenuDescription], [MenuNavigationURL], [MenuOrder], [MenuParent]) VALUES ('b9889250-fb18-4de9-b4e0-35f37cdc1378', N'Menu 2', N'Menu 2', '#', 3, '39a7321e-5a4d-4c50-8725-1a4339310d28')
INSERT INTO [dbo].[Menu] ([MenuId], [MenuName], [MenuDescription], [MenuNavigationURL], [MenuOrder], [MenuParent]) VALUES ('1c57b480-841a-4988-90d7-3f78527ef320', N'R&D', N'R&D', '#', 2, '0a9bed79-f877-4c79-b0d0-4a822a91610e')
INSERT INTO [dbo].[Menu] ([MenuId], [MenuName], [MenuDescription], [MenuNavigationURL], [MenuOrder], [MenuParent]) VALUES ('0a9bed79-f877-4c79-b0d0-4a822a91610e', N'Hoạt động kinh doanh', N'Hoạt động kinh doanh', '#', 6, 'f014bd49-8254-4512-8776-8c623bb24e6e')
INSERT INTO [dbo].[Menu] ([MenuId], [MenuName], [MenuDescription], [MenuNavigationURL], [MenuOrder], [MenuParent]) VALUES ('5c6259f4-8923-46fd-b2ed-4e8bdf241473', N'test', N'test', '~/Default.aspx?DocumentTypeId=9ce8f106-610a-4ab7-b9cc-e3f09f78fdda', 1, '63a4ce07-40fa-4d64-802b-fbe029c5c8e3')
INSERT INTO [dbo].[Menu] ([MenuId], [MenuName], [MenuDescription], [MenuNavigationURL], [MenuOrder], [MenuParent]) VALUES ('f99bead5-71d4-459d-ad23-4f5c42b54516', N'test', N'twse', '#', 2, 'ca638f4e-0952-41b3-a405-e565225e96d3')
INSERT INTO [dbo].[Menu] ([MenuId], [MenuName], [MenuDescription], [MenuNavigationURL], [MenuOrder], [MenuParent]) VALUES ('416b4d1a-1f98-450c-bdd3-6e9de7770225', N'ROOT of Master [Link 1]', N'ROOT of Master [Link 1]', '#ROOT', 0, NULL)
INSERT INTO [dbo].[Menu] ([MenuId], [MenuName], [MenuDescription], [MenuNavigationURL], [MenuOrder], [MenuParent]) VALUES ('c8aca712-c902-46e2-80a7-6f82eedead03', N'Ý kiến khách hàng', N'Ý kiến khách hàng', '#', 2, '6a4ef359-1e55-439c-b09d-94f4e861e4a5')
INSERT INTO [dbo].[Menu] ([MenuId], [MenuName], [MenuDescription], [MenuNavigationURL], [MenuOrder], [MenuParent]) VALUES ('64f0cdd4-3a8b-4899-8a25-74b30835f865', N'Tuyển dụng', N'Tuyển dụng', '~/Default.aspx?DocumentTypeId=788d9266-fc5d-4fb4-998f-0a34a975d8ac', 7, 'f014bd49-8254-4512-8776-8c623bb24e6e')
INSERT INTO [dbo].[Menu] ([MenuId], [MenuName], [MenuDescription], [MenuNavigationURL], [MenuOrder], [MenuParent]) VALUES ('62658a64-8dd9-4a76-bedb-80fcf523bde2', N'Tin hoạt động kinh doanh', N'Tin hoạt động kinh doanh', '#', 1, '0a9bed79-f877-4c79-b0d0-4a822a91610e')
INSERT INTO [dbo].[Menu] ([MenuId], [MenuName], [MenuDescription], [MenuNavigationURL], [MenuOrder], [MenuParent]) VALUES ('5e8ff4ea-89a8-460c-86e1-8540507d834d', N'ROOT of Master [Link 1]', N'ROOT of Master [Link 1]', '#ROOT', 0, NULL)
INSERT INTO [dbo].[Menu] ([MenuId], [MenuName], [MenuDescription], [MenuNavigationURL], [MenuOrder], [MenuParent]) VALUES ('71a60fb1-d8cb-4391-b4d5-8b0cc2726635', N'OTS', N'OTS', '#', 3, 'a652e3c0-d70a-4106-859b-03104dd7fd6a')
INSERT INTO [dbo].[Menu] ([MenuId], [MenuName], [MenuDescription], [MenuNavigationURL], [MenuOrder], [MenuParent]) VALUES ('f014bd49-8254-4512-8776-8c623bb24e6e', N'root', N'root', 'root', 0, NULL)
INSERT INTO [dbo].[Menu] ([MenuId], [MenuName], [MenuDescription], [MenuNavigationURL], [MenuOrder], [MenuParent]) VALUES ('1b8cd6d6-f042-4b17-a935-8fa30bc30e1d', N'Hình ảnh hoạt động', N'Hình ảnh hoạt động', '#', 3, '0a9bed79-f877-4c79-b0d0-4a822a91610e')
INSERT INTO [dbo].[Menu] ([MenuId], [MenuName], [MenuDescription], [MenuNavigationURL], [MenuOrder], [MenuParent]) VALUES ('6a4ef359-1e55-439c-b09d-94f4e861e4a5', N'Khách hàng', N'Khách hàng', '#', 5, 'f014bd49-8254-4512-8776-8c623bb24e6e')
INSERT INTO [dbo].[Menu] ([MenuId], [MenuName], [MenuDescription], [MenuNavigationURL], [MenuOrder], [MenuParent]) VALUES ('06a43a98-a9da-4160-b02a-953bed517e13', N'Menu 1', N'Menu 1', '#', 2, '41a58716-caa6-406f-a4a0-ac98fb577b50')
INSERT INTO [dbo].[Menu] ([MenuId], [MenuName], [MenuDescription], [MenuNavigationURL], [MenuOrder], [MenuParent]) VALUES ('a3ba5b2a-6580-4445-b824-99ea312ea612', N'Menu 2', N'Menu 2', '#', 3, '41a58716-caa6-406f-a4a0-ac98fb577b50')
INSERT INTO [dbo].[Menu] ([MenuId], [MenuName], [MenuDescription], [MenuNavigationURL], [MenuOrder], [MenuParent]) VALUES ('28049f37-4613-407b-8aea-9c1d96244cb0', N'test1', N'test1', '#', 1, 'ca638f4e-0952-41b3-a405-e565225e96d3')
INSERT INTO [dbo].[Menu] ([MenuId], [MenuName], [MenuDescription], [MenuNavigationURL], [MenuOrder], [MenuParent]) VALUES ('adbe4206-afc7-4e5d-950f-9cbb9b574617', N'Menu 1', N'Menu 1', '#', 2, '39a7321e-5a4d-4c50-8725-1a4339310d28')
INSERT INTO [dbo].[Menu] ([MenuId], [MenuName], [MenuDescription], [MenuNavigationURL], [MenuOrder], [MenuParent]) VALUES ('62af0c41-bff5-447d-8f7b-a416b56092a9', N'ROOT of [menuMasteTest]', N'Root of [menuMasteTest]', '#', 0, NULL)
INSERT INTO [dbo].[Menu] ([MenuId], [MenuName], [MenuDescription], [MenuNavigationURL], [MenuOrder], [MenuParent]) VALUES ('947ab870-c018-4984-bad7-a641b3cd075d', N'root', N'root', 'root', 0, NULL)
INSERT INTO [dbo].[Menu] ([MenuId], [MenuName], [MenuDescription], [MenuNavigationURL], [MenuOrder], [MenuParent]) VALUES ('41a58716-caa6-406f-a4a0-ac98fb577b50', N'ROOT of Master [test]', N'ROOT of Master [test]', '#ROOT', 0, NULL)
INSERT INTO [dbo].[Menu] ([MenuId], [MenuName], [MenuDescription], [MenuNavigationURL], [MenuOrder], [MenuParent]) VALUES ('c540ca17-8b2e-4406-b6a7-b8332614f10e', N'Open Content Gateway', N'Open Content Gateway', '#', 2, '6d6c1a2f-c57a-4ba4-96e0-f782cfaa388e')
INSERT INTO [dbo].[Menu] ([MenuId], [MenuName], [MenuDescription], [MenuNavigationURL], [MenuOrder], [MenuParent]) VALUES ('72bf3fe4-e55c-4e92-995f-b85052be641f', N'Portal', N'Portal', '~/Default.aspx?TopicId=1cb794bd-2bf2-422a-9143-2dacfc6c842f', 1, 'a652e3c0-d70a-4106-859b-03104dd7fd6a')
INSERT INTO [dbo].[Menu] ([MenuId], [MenuName], [MenuDescription], [MenuNavigationURL], [MenuOrder], [MenuParent]) VALUES ('f3c1c60d-ba13-463a-a17c-bf2901e8a6e1', N'Tin tức tuyển dụng', N'Tin tức tuyển dụng', '#', 2, '64f0cdd4-3a8b-4899-8a25-74b30835f865')
INSERT INTO [dbo].[Menu] ([MenuId], [MenuName], [MenuDescription], [MenuNavigationURL], [MenuOrder], [MenuParent]) VALUES ('b3971b3c-f8f7-40f6-9d0f-ca01cb4439b0', N'Liên hệ', N'Liên hệ', '~/Default.aspx?ModuleId=af0dd9fc-002d-494b-8ad4-b9ebf1943068', 8, 'f014bd49-8254-4512-8776-8c623bb24e6e')
INSERT INTO [dbo].[Menu] ([MenuId], [MenuName], [MenuDescription], [MenuNavigationURL], [MenuOrder], [MenuParent]) VALUES ('7cef25aa-f509-494e-8cd4-cb3aecece0df', N'ABC', N'ABC', '#', 1, 'e543b463-d684-410e-90f4-fd8536d90d87')
INSERT INTO [dbo].[Menu] ([MenuId], [MenuName], [MenuDescription], [MenuNavigationURL], [MenuOrder], [MenuParent]) VALUES ('7c3d2ad8-6c82-43b7-bd31-ccb52d2ca690', N'Giới thiệu công ty', N'Giới thiệu công ty', '#', 1, '17bf9be7-944b-4040-946f-03b4b11bf911')
INSERT INTO [dbo].[Menu] ([MenuId], [MenuName], [MenuDescription], [MenuNavigationURL], [MenuOrder], [MenuParent]) VALUES ('cc9cb182-1431-41ba-b1e7-d21e4d0f5767', N'test2', N'test2', '#', 1, 'f99bead5-71d4-459d-ad23-4f5c42b54516')
INSERT INTO [dbo].[Menu] ([MenuId], [MenuName], [MenuDescription], [MenuNavigationURL], [MenuOrder], [MenuParent]) VALUES ('62f6874b-1d46-41d8-ba3a-d8cf9daf6610', N'Menu 2', N'Menu 2', '#', 1, '62af0c41-bff5-447d-8f7b-a416b56092a9')
INSERT INTO [dbo].[Menu] ([MenuId], [MenuName], [MenuDescription], [MenuNavigationURL], [MenuOrder], [MenuParent]) VALUES ('a0b1cfd9-233d-4933-92cd-dd95e77d1437', N'item 1', N'item 1', '#', 2, '5e8ff4ea-89a8-460c-86e1-8540507d834d')
INSERT INTO [dbo].[Menu] ([MenuId], [MenuName], [MenuDescription], [MenuNavigationURL], [MenuOrder], [MenuParent]) VALUES ('6de11164-1ef2-403c-982f-ddf720e37fb9', N'Z39.50 Virtual Union Catalog', N'Z39.50 Virtual Union Catalog', '#', 1, '6d6c1a2f-c57a-4ba4-96e0-f782cfaa388e')
INSERT INTO [dbo].[Menu] ([MenuId], [MenuName], [MenuDescription], [MenuNavigationURL], [MenuOrder], [MenuParent]) VALUES ('6e4071ab-11dd-40ed-803c-e118932f56bf', N'Văn hóa công ty', N'Văn hóa công ty', '#', 1, '64f0cdd4-3a8b-4899-8a25-74b30835f865')
INSERT INTO [dbo].[Menu] ([MenuId], [MenuName], [MenuDescription], [MenuNavigationURL], [MenuOrder], [MenuParent]) VALUES ('eb040668-0f46-404c-9d42-e188b511c3d3', N'DMS', N'DMS', '#', 4, 'a652e3c0-d70a-4106-859b-03104dd7fd6a')
INSERT INTO [dbo].[Menu] ([MenuId], [MenuName], [MenuDescription], [MenuNavigationURL], [MenuOrder], [MenuParent]) VALUES ('ca638f4e-0952-41b3-a405-e565225e96d3', N'root', N'root', 'root', 2, NULL)
INSERT INTO [dbo].[Menu] ([MenuId], [MenuName], [MenuDescription], [MenuNavigationURL], [MenuOrder], [MenuParent]) VALUES ('85c55674-7d59-4a67-9c84-f3bfa65fb5b9', N'Thành công điển hình', N'Thành công điển hình', '#', 3, '6a4ef359-1e55-439c-b09d-94f4e861e4a5')
INSERT INTO [dbo].[Menu] ([MenuId], [MenuName], [MenuDescription], [MenuNavigationURL], [MenuOrder], [MenuParent]) VALUES ('6d6c1a2f-c57a-4ba4-96e0-f782cfaa388e', N'Dịch vụ', N'Dịch vụ', '#', 4, 'f014bd49-8254-4512-8776-8c623bb24e6e')
INSERT INTO [dbo].[Menu] ([MenuId], [MenuName], [MenuDescription], [MenuNavigationURL], [MenuOrder], [MenuParent]) VALUES ('aa5cb58e-ea1e-4090-a584-faa270f9091b', N'def', N'def', '#', 2, '63a4ce07-40fa-4d64-802b-fbe029c5c8e3')
INSERT INTO [dbo].[Menu] ([MenuId], [MenuName], [MenuDescription], [MenuNavigationURL], [MenuOrder], [MenuParent]) VALUES ('4ff95d1d-593b-486a-9f50-fbaaa748a1ff', N'item 12', N'item 12', '#', 3, '5e8ff4ea-89a8-460c-86e1-8540507d834d')
INSERT INTO [dbo].[Menu] ([MenuId], [MenuName], [MenuDescription], [MenuNavigationURL], [MenuOrder], [MenuParent]) VALUES ('7b6e5a89-5c29-4dc3-bef8-fbd13eb1d727', N'Khách hàng tiêu biểu', N'Khách hàng tiêu biểu', '#', 1, '6a4ef359-1e55-439c-b09d-94f4e861e4a5')
INSERT INTO [dbo].[Menu] ([MenuId], [MenuName], [MenuDescription], [MenuNavigationURL], [MenuOrder], [MenuParent]) VALUES ('63a4ce07-40fa-4d64-802b-fbe029c5c8e3', N'abc', N'abc', '~/Default.aspx?ArticleId=3087da8e-bd08-46f6-9331-8e3c6af66bf1', 2, '33849027-b529-4dc8-ba10-1972fe9b77f9')
INSERT INTO [dbo].[Menu] ([MenuId], [MenuName], [MenuDescription], [MenuNavigationURL], [MenuOrder], [MenuParent]) VALUES ('e543b463-d684-410e-90f4-fd8536d90d87', N'ROOT of [duc test]', N'Root of [duc test]', '#', 0, NULL)

-- Add 1 row to [dbo].[Module]
INSERT INTO [dbo].[Module] ([ModuleId], [ModuleName], [ModuleDisplayURL], [ModuleEditURL], [PageId]) VALUES ('af0dd9fc-002d-494b-8ad4-b9ebf1943068', N'FeedBack', N'~/Modules/CMS/FeedBack.ascx', N'', '00000000-0000-0000-0000-000000000000')

-- Add 1 row to [dbo].[Page]
INSERT INTO [dbo].[Page] ([PageId], [PageName], [PageTitle]) VALUES ('00000000-0000-0000-0000-000000000000', N'HomePage', N'Home Page')

-- Add 5 rows to [dbo].[Panel]
INSERT INTO [dbo].[Panel] ([PanelId], [PanelName]) VALUES (0, N'Panel Top')
INSERT INTO [dbo].[Panel] ([PanelId], [PanelName]) VALUES (1, N'Panel Left')
INSERT INTO [dbo].[Panel] ([PanelId], [PanelName]) VALUES (2, N'Panel Content')
INSERT INTO [dbo].[Panel] ([PanelId], [PanelName]) VALUES (3, N'Panel Right')
INSERT INTO [dbo].[Panel] ([PanelId], [PanelName]) VALUES (4, N'Panel Bottom')

-- Add 4 rows to [dbo].[PictureType]
INSERT INTO [dbo].[PictureType] ([PictureTypeId], [PictureTypeName], [PictureTypeParent]) VALUES ('00000000-0000-0000-0000-000000000000', N'Root', NULL)
INSERT INTO [dbo].[PictureType] ([PictureTypeId], [PictureTypeName], [PictureTypeParent]) VALUES ('077b972f-1a51-415e-b48a-19f39219d165', N'Tin tức sự kiện', '18b1f09f-1476-4b7b-b01d-4c137d34d6e5')
INSERT INTO [dbo].[PictureType] ([PictureTypeId], [PictureTypeName], [PictureTypeParent]) VALUES ('18b1f09f-1476-4b7b-b01d-4c137d34d6e5', N'Hình ảnh Cấm xóa', '00000000-0000-0000-0000-000000000000')
INSERT INTO [dbo].[PictureType] ([PictureTypeId], [PictureTypeName], [PictureTypeParent]) VALUES ('d9bb9996-63b4-4279-85d9-a137b4a41893', N'Hệ thống', '18b1f09f-1476-4b7b-b01d-4c137d34d6e5')

-- Add 5 rows to [dbo].[Portlet]
INSERT INTO [dbo].[Portlet] ([PortletId], [PortletName], [PortletDisplayURL], [PortletEditURL]) VALUES ('d224d65d-d2a0-4f4d-9c30-c8030c995e62', N'MenuRad', N'~/Portlets/MenuRad/Display.ascx', N'~/Portlets/MenuRad/Edit.ascx')
INSERT INTO [dbo].[Portlet] ([PortletId], [PortletName], [PortletDisplayURL], [PortletEditURL]) VALUES ('d224d65d-d2a0-4f4d-9c30-c8030c995e63', N'Scroll Message', N'~/Portlets/NewsInBrief/Display.ascx', N'~/Portlets/NewsInBrief/Edit.ascx')
INSERT INTO [dbo].[Portlet] ([PortletId], [PortletName], [PortletDisplayURL], [PortletEditURL]) VALUES ('a224d65d-d2a0-4f4d-9c30-c8030c995e64', N'TopicDisplay', N'~/Portlets/TopicDisplay/Display.ascx', N'~/Portlets/TopicDisplay/Edit.ascx')
INSERT INTO [dbo].[Portlet] ([PortletId], [PortletName], [PortletDisplayURL], [PortletEditURL]) VALUES ('d224d65d-d2a0-4f4d-9c30-c8030c995e64', N'HTML Blog', N'~/Portlets/HTMLBlog/Display.ascx', N'~/Portlets/HTMLBlog/Edit.ascx')
INSERT INTO [dbo].[Portlet] ([PortletId], [PortletName], [PortletDisplayURL], [PortletEditURL]) VALUES ('0bc0168f-c7e9-40b1-b427-ec904103b250', N'Search', N'~/Portlets/Search/Display.ascx', N'')

-- Add 5 rows to [dbo].[TopicPermission]
INSERT INTO [dbo].[TopicPermission] ([TopicPermissionId], [TopicPermissionName]) VALUES (1, N'Phân Quyền Trên Chuyên Mục')
INSERT INTO [dbo].[TopicPermission] ([TopicPermissionId], [TopicPermissionName]) VALUES (2, N'Hiệu Chỉnh Bài Viết')
INSERT INTO [dbo].[TopicPermission] ([TopicPermissionId], [TopicPermissionName]) VALUES (3, N'Xóa Bài Viết')
INSERT INTO [dbo].[TopicPermission] ([TopicPermissionId], [TopicPermissionName]) VALUES (4, N'Thêm Mới Bài Viết')
INSERT INTO [dbo].[TopicPermission] ([TopicPermissionId], [TopicPermissionName]) VALUES (5, N'Duyệt Bài Viết')

-- Add 2 rows to [dbo].[DocumentType]
INSERT INTO [dbo].[DocumentType] ([DocumentTypeId], [DocumentTypeName], [DocumentTypeDescription], [DocumentTypeParent], [PageId]) VALUES ('00000000-0000-0000-0000-000000000000', N'root', N'root', NULL, NULL)
INSERT INTO [dbo].[DocumentType] ([DocumentTypeId], [DocumentTypeName], [DocumentTypeDescription], [DocumentTypeParent], [PageId]) VALUES ('9ce8f106-610a-4ab7-b9cc-e3f09f78fdda', N'Tài liệu', N'Tài liệu', '00000000-0000-0000-0000-000000000000', '00000000-0000-0000-0000-000000000000')

-- Add 1 row to [dbo].[PanelInPage]
INSERT INTO [dbo].[PanelInPage] ([PageId], [PanelId], [Style]) VALUES ('00000000-0000-0000-0000-000000000000', 2, N'')

-- Add 9 rows to [dbo].[Picture]
EXEC(N'INSERT INTO [dbo].[Picture] ([PictureId], [PictureName], [PictureContent], [PictureDescription], [PictureLink], [PictureTypeId]) VALUES (''ac8511bb-aed7-4220-bd7a-15eec245804a'', N''Chàng trai bị liệt thành tỷ phú_small'', 0xffd8ffe000104a46494600010101004800480000ffdb0043000302020302020303030304030304050805050404050a070706080c0a0c0c0b0a0b0b0d0e12100d0e110e0b0b1016101113141515150c0f171816141812141514ffdb00430103040405040509050509140d0b0d1414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414ffc00011080066008203012200021101031101ffc4001f0000010501010101010100000000000000000102030405060708090a0bffc400b5100002010303020403050504040000017d01020300041105122131410613516107227114328191a1082342b1c11552d1f02433627282090a161718191a25262728292a3435363738393a434445464748494a535455565758595a636465666768696a737475767778797a838485868788898a92939495969798999aa2a3a4a5a6a7a8a9aab2b3b4b5b6b7b8b9bac2c3c4c5c6c7c8c9cad2d3d4d5d6d7d8d9dae1e2e3e4e5e6e7e8e9eaf1f2f3f4f5f6f7f8f9faffc4001f0100030101010101010101010000000000000102030405060708090a0bffc400b51100020102040403040705040400010277000102031104052131061241510761711322328108144291a1b1c109233352f0156272d10a162434e125f11718191a262728292a35363738393a434445464748494a535455565758595a636465666768696a737475767778797a82838485868788898a92939495969798999aa2a3a4a5a6a7a8a9aab2b3b4b5b6b7b8b9bac2c3c4c5c6c7c8c9cad2d3d4d5d6d7d8d9dae2e3e4e5e6e7e8e9eaf2f3f4f5f6f7f8f9faffda000c03010002110311003f00fa66e6e96256cfd29da65bc97ee36a9c03f7aabcf662372d3bf27f86a6b2d68b5cad859c5e6ce71f28380a3b64ff004ae972b1f9e50c1ca725cdf71d3c3059e896ed70c019154b3367a71cd7e67fed13f1093c71f1275ad4b4e9eee3b29a4f2ca4cc1c1d9f2e401fc3c671cd7dfde3eb3f11c7a15eb4521b7fdc12488faf6c026bf3d7e217815fc2be2b486570d1dc8126587dd63c9538ae3a935747d861305529eae3648e35f426d434e8b54b2411812082f6285cb019fbb2a8ea14e0fd08ed5f427c12f186a169767c2babb6f11c6c6d243c91b71b933e98208f4e456b7843c3de1ab4f0e5bdac36ff0066bebb0a5d2e0864dfc7cf19fee9e32a47a11d0e75fc7fe1c4f09ea3a26ad66b18bb82e04770163dc591c052d81e9c0fc6b81575cea07af8ccbbda61a536b6fcceaae9b6a329e3835e59e3c5137d92257c399810de9cff0089af40d42f94c592c00c671eb5e6de24d46cddd6692758e443c076c77f4af414aceecf8ac22b544edb11e8360fa5deea70ab79e5a351bc0c01924e71e954be135e797f1474870360fed11c7a7cd58c3e2141a75c4845c472b90a3a67a76e2a5f8657a971f1034bbb88e11efd5c0c631961c570e21f3497aa3eeb0fcce9556d3578bdd1fa4fa84f1da786af6e6621608a2677278c01c9af9fbc67f12fc35e2ff0ddcd96997df6bb9443748221c6578da4fae0f4af63f1c917bf0bfc450648f334f99723a8f96be0bf0c693aaf865ee51e08a76e0c4cafd0e70723e86b3af1a736e355d958f2b034eaf2c6b50579267a3c5e35b3fb1c51f9c4155553f21ea062b85f1c6a73dfc330b789ae247b431c71a0f99db24e00fc6bbad17e27ddf864036fe13d01eef6ed375756ad2c878f76c0fc00a9751f8edaddccd13c9e1bf0f8319e0c367b187ae181e0d7ccc70f4e2ee9ea7e87ed276b347cdb79abeaeb011796f24018f96cb2c4038fc3ae3df15edbfb2bda35bf877c4d70fb19a7d4f70dbd71e58ff1ae8f52bed1bc6ea6696d05acac3949406c1fad6dfc35d0e0d034fbf86040b1c971e67cbd33b40af7702e2aa5923e633c849e15b6efaa2d4b048d2b9e39634549308cccf9539dc68afa0d4fcbf951ddeb7e202033f980ec52cdcf4c0cd76bf03f484bed3dafae416ba90876c8ea4ff9c7e02bc766dd761e2fe02a779fc385fc7f957d17e01d2ffb123fb30cac909f2e40383b480430fc7f9d5d4ec7d5e5d4b9a6ea33a3f1269c9796296cca36cb3469cf705c647f3af907c59f0d6d87c4a9d3c476ff0068b4492436e24242ec3c0c7d086afb1b3fda77688e76cb633a4aca3a3e412a7e9d7f115c6fc4ef08cde2086f2786dd679920325b6000526ea7df9007e23debcdc4d3954a4d4373eb7095234eaa75363c63c35e114b1bd75d33484b8208585cba30231c603608fad6b7c41f006a527c3ff11888c6fadc308be42103aac9121758c1effc64e3d16bd97c35e1bd3b41b4b6682009235b2091e4249cedcb1c9e9c9e40c0a689a0b89e7276bc6d9c8ecc0f1fa8ae6c3e0951f7a6ef23ab198d5885eca2bdceddff00e01f933ae78ef5fd449f375099633d150ed1fa572f35d5c5c31323bb9f56626bb6f8ade154f05fc42f106881462c6fa5894e73f2672bff008e915c04926d43b49249e78c5177d471a54e0af4e297a1611fe7000627d6bd23e155c793af698c4f297287f515e556d21f381c91e86bb9f04de18351b59376dc4aa73f8d4b4b4149b9426bc9fe47e986b37a2e7c05aba039dd6328ff00c70d7c9fb0a1ce5727d0ff008d7b4e9ff14f43bbf0f5dd8bdcbc73bdbbc603a1c312b81835e453db26f07ccda47693a1ae6c7ddb8d8f1f22928c67193b3b95411bf32a2b0ec40208fcaa50b03a1dd00607a8c7f8d49e561c050b9ea3cb3d7f1ab5e6bab61c37a61ba578cdf73ec5228aac56d2661458d71d14722bb6f0a5cac765e5aab1dec496ed918ef5829142c8011129f4c106ba5d017ecf625481cb9381cd7a59734ebe9d8f9dcfddb05b75466cd1032b9c37de3fc5453a443e637d4f6a2beb3951f945e474de1db637f3697115c34f3077cfbb0fe400afa956c766b37132f1fb98fa7d4e7f90af923c21e24974fbbb3b831adc4b67279651ce378c707d8e0f5f515f54f85fc5f67e2dd361d5608e6b549034463b85c1ca9c704704641e6b2ab251f899f75808f353bc11734cd46d60d4f504768927da9dc6f7ea4647b678fa9a835dbff22c6e0acf146586d2cee176e7827f019af2ef883e26f0868babcb7bab6bda6e9b7046cd934ce676038002a1dc0fd057cf9e34f8dd61717728f0adb5f6acd1e4092ed195517a310bcc8fd71caa800f726a6e92bb67a0d6a7b27c50f8b936bdacda784fc26ea2491b13de9e8a0740a3b8f53ec6bc6bf691f8dde20f076ad69e1fd1b5c3a796b62f732db22ac8d938186392bc03d31537c25bebad3ecb5ef1b788c4706cdc902aaeddaa396ee7d71ebc57cc3f117c7177e32f156a9aacd230fb4cc4220e36a0c6d5e3d0578f3ab2a9886a32f751ee51a4a9d08b945394bb9ceeb3752c93b4d33bbbcc4c9e6c8492f93f7b27ae7d6b032047213f5fa9abef3cd70e6d19da48dc6620e4b6c7f45f407d2aadfda3da42524428e06195860835bb8b493e842a8a4e517ba2bdbcaa64cf6aed3e1cc2ba8eb71239c4119334a4f4088371fe55e7f092a4807ad763e0abdfb0e93af4eadb5fc8102127182e71ea3b55aa777638aad471a6dafeae7aed97c5cd36751f6ab2b9810f465024047e073d3daa2f0ef8e27bbd6152e756d21f4e666cb06686541ce06d6c64ff0081af239ae3f7bf29c05eff0099ff00d94511bb2945760c09084360e7a2f7f60df9d767b34d1f34e114f43ea1b1b08f5374fb2dcac81ba3210c0719cff9f4a70865835e92c9677096b6d1b5c679fdec9f32a8cf4c26091fed5739fb25783e3d6fc41ad6a93a2c50dadb456db87015a77cb9c038f96247fa56f787af24d7b4fd53c42fb51753be9af002c01d8ce5630075c050057254c3c249a68de956ab87929464ce8bc9911573b998742075fc3a56de9ae62b26dca14e49c2ff003ae520f12bc6ca0c9818c1cd6f58dd89b4d6942aa83b8e14e6bc9cae2d621dfb3fd0f77889ff00b127e6bf264267c9277373ef455212b6075a2beb4fca2ece3ffe16525b5cdc1d2ec66d4a36da9e77faa883e70a431e4f5ec3b57dcfe17861d17c0da72118f2add46d07ab607f335f1c5d68f143abe95630c41627bd8502af3fc59ebf857d07f137e31e91f08ffe11db4d5adef2f12ee5d8b0d84624972ab9ddb73c8048e0726bc0c6734eb429b3f4cc97d9ac2ce70bd93b6bd6dff0e785fc4df08695a77c4bbd9f5591eea7bd3737b3ee211720a95c6de4a8424727b74af98aff0050d5be2ef8f5acfc3301b1b48c3436b05b9f2c98f27ae3192dd71fe15f4bfc69375f106f06afe1fd3b537864b6b984bdc5a49095dd11032ac01eb8af99fe0378887827e22da7db47d957ce304e6418311e993e9835d939c614a4a8d9b48aa71f695d46b5d26cfa513f67fd534cf85cd6a3c4fa8adac455af2dae089e38dc8dcca880673918c023d6bc43c7bf023c49a0daaeb165613ea1a4dc0328318dd2c031cef51d40c1f987e2057ddde07d16dfc4fa64d789a8c9f65b4b558e1b749331c8c172d2e0705989273ef558f82eea1bbb8d51ee84a91aff00c7bc8d9495001966f4f40073dcd7cb43173a72bc9dcfaaab423285a0ecd6cba1f9cba3e88d6f39bab95485a3c826700ac795f9723dfb1a9f5cd386b16a54131cc0feea37e5d57bab7d3a8f63ed5f687c53fd9e3c27aee8f06b7a511a2dc4ea658e68dc35bb9c670c99c1ce7aae08af9bb47f853e29d635192dedb4b8628a394c26e659479582323e73d5475ce322bf49c255c3d7c328f2b49f467e7d88956857736fde5d8f009eda7b5ba7b778d84c87054726ba1f0c5bcd259de5b295595e48df66f00900f4ea39f6af70f17feca5e3bd2edd6e6eac23d46de5f955b48984e41c670540071d7900815e39278525d2a6b88511d2453f3432f0e08e3818ae2fa9caedd3775f89d52c5c6a42d2567f80d7d3ee200b1ca0ef03057af61db83dcf6a82594c5f7b2b904f1c1e8c7be3d6a5fb65edb22abb178cf2a24f9c7ebd29e9aaab0db2db2b03c61588fd0e4564e328bb331b27aa3df3e0f78ae3f087c10f1add46fb6e67fb6b21e872b6eb6f1ffe3d3b1a9b4773a6f86ac411188e2b18f18cee24264e7dabc4e4d7cdaf82eeec200628652d94e3bc88c7a7a95af5437dbbc3ea9bb19b655e7fdd02b19ab23195db473a3c7b199320141fcebd9bc1faa0d43c1b69701837988c73ff000235f365d787ee61219544807a715ef5f0ecc5ff00083e976e2e2279521c4912382c8492707d0f35e56060a351c9763d7cf2a7b5c3462bbfe8cdf595768e7b51501b39c1206ec0ff00668af76e7e7fecdf63a3d0ae74d8fe22e8d3eab7505a58da17bb79266daa4a8c28f7396e9ed54af7e316a569f18753f1759e9316b7a47931e93047760c52c4bb8b968f3f74b377239da0715e6f19d3236904524f75a6dd00ef348a6496de439c6e3f5e38e08abb730eadad358db5a40e925c6c5696761e54ccbc46415c90fdb9f6e39af77fd5ea12939e2a5cd756b2d3fe0ff5d8fa1c363aa50a0b0f495b5bdfb9f5bf863c79a0fc4dd295f4b90db5f26e5b8d36ec059edf6f0c08ef8e0ee1c722b9af13fec75e18f1778a6cbc43a858abdd46fe65c470318d2ed71c2c85319ec7239e319c578e7857e00fc4af16dbcfabe96d26897d6b70d342d724c571238e0ae38f94f3f780ce3a57d3df033c4de31d42c6f745f1ae8579a2eb7a62a099a551f679e2390b346dd0ae548201e0e3d6be23179650cad54ab8794a6ba256bfdfd7fadcfa2a588ad5f97dac526bab33b42f86f7df0ed94681a7efd337b0fb1dbcc3102765556392393c03c547178a2da4beba8c05f3a3cb4d6ae855c0f4653c8ae93e26fc70d0be19e9f22244dacea20a85b38a550c7774273cfe18c9af39f08eaafab78b5b58d5fecf75aa5e22c86dec41296fdd222c7efba8ea7a0278e99af269e575aa4a35abd37083eef5fb8f43fb553528c6d2925db437f4ff00874f7f657b6ba9d843a569f74cd3c703be5d492bb1719c2923240f527d2ac37c358ecc85b1b168f2b810ef775ec06769031d4924fe7d2ba3d246a1e2058d65b531b4334de644a76e5b76572dd40c11d39ae9218ee2ced65314b1db5beff26311a60390bf39c0e4e0f1d49edd4d7d9c70f4a108c52d8f989d79ce729b7b9e6ba7d9ddf8699aca0be86e1d5c700e06ee721233921473c9c1c7ad79e7c59f82de1ef8a5664db58edd7ad5577dfe98be60dbd0ef5006e6cfe3c57b358e876d6293453c09f689e6263f9009020196f31c0e00ebd49ed8cd63def8c34cf08e9335a69b08b7b65cc93dccadf7f039249e838fc00adfdf6ad1767dcc2f18c937af91f05f8fbf676f11697b9ed67835058c62558cf972e73c3146ef8eb835c8e9bf09b5ebce25860b3c1c6e9e5c6ef70064fe75e8df16fe396b9af78a0c8ef08b02aed6ff0065508be4072aac5c72c4e33d78af361e39d66556b9b3be962824c0cbbe590e7180a7d78e6b96a2c54d72b945f9d9a7f8687bf4b074adcf669db6bffc0feae75917c24d1f4cb02fe20d54fd9061992dc6c071ce371c93f80ad9b7f1df8474768662b1c9a4c4c3cc4b88dbcdc0e015c8f980ce71c74af32d4f55bdb3ba57bf7b8b981c65a5b89499476da003d3e94dbcd2e6d6a08750b569ad6dad983431b927791df1f81c75e9dab95e025523fbe9b6fb2d17f5e677c2108ff0e2aff7bfebf3d96ba1eed38f0078a3c2be28b96b1b69e3b6b669a0beb53968c1523e52b8f98305383d735f36fda65d2e1824d2b51bbb5b863c490b30da33ce735d66a5e3abebad05ed6cede396dc58cb68e11cedcc8c37cae070cc00c01c0079faf17b2ef4a610baecb79410257e11891c1dddfebef5582c2ce846519bdfcee6955c27a5b4f4febb1ac3e2cf8b61fddff6a5b49b3e5dedd5b1dcd15343731470c6ada742ccaa0161247cff00e3d45767b18f6fcffc8e6582a36f8bf2ff0033e89f815a5e87e38f895696ba8eb69a4c93452096de48c3fda9b8c448a4e017e78ec471d6beecf03784b48f841e0d874f92ea0d374cb5696e3ed17f222b3c8ec599e46217246428c740057e547813c576d7b187bb965b55b691374d16567b77ce54afa9c8ce0fa715d5eabe2fbff16df23eb17f737f1798cc9aa5d4ad34b9edb8b13edc751ce2beb31387fed0519c6a7b8fa7f5faec7c961f111c227170bcbb9fa39e17f1c69bab6957bac69b7a9aa5998bce8a5b6f911cf99b30b91939604127b74eb5d878a34f7bcf0f5cc7757d3698b244cada8594be44b6208fbe1cfa1eb9e38e95f0ee97fb4aea5e1ef86fa7e85a7dba69f7f610f96bacac6d711caca491b06d0aa79ce5b77cdce2bce35df8c7af6a3a24767a86bbad6a96d3c86596cb52bb2f6939273ebd3d558e2bca594d4bb6e4a2afa7f4bfaef63d49e6549c52b5d95bc3ba55af893e2869b0eb1ae49742fafcc5f6fb85d928db96f3147192db460f43bbdabed3f01f8624d2bc497c6dacbfb4ac09f323bc09b5003d40dd8008fc6be12b4d705b5fc771a7d9b4173ff1f3142cdb3eccebf3249139fbc4632001d010735ee5e0efdb7b5db958f48d4b44d375cb509fbdbbb476b59667c75119ca1239e3201c718aefc5e1e751a71d4f161522b7d0fb1cca92e91a8cc826b704992510952d8039c6de7900018e99a4d475db3334567a522cd750c62348e3fb900206771ec47e75e19f0cff006808bc6b657d2e93629622c66f2a48a71b667c7466c1f9491ce39c7bd65785bf696b2d4b5b6f0b7f62cde1bd6967954c3200d1ce031f9d1c63391f36319eb8cd7814a71a95274a3f147747754a53a708d47b48f65f13dfad8294de19b684623a05c70a3ea7e627e83b57c81fb437c4d8975287c2f68aeb0ae26bf741c11d561247af04fe03d6bd6be337c4593c19e0ab9d490c73ea2cc21b5873c19181c139ec393f857c4d3f88f55d45ee67309b9b99642f2cc1863773c93c13d4d6fa4558e8c1528d49fb496cb6febfe0a13c473da5f4da7cd653347b0c91bdb372aa4e0851ec79381deb9b92181eee28da3996ff003e6286f936fa1f43fceb467bb36b1da9b889d660fe624a3001e7921bb9e79aec8584bad5adcc720b7497cbcc534638901e8c0ff351f42295ae7d2c22aa3f3d37d3a77bbfcfceddb89b5b84b7909d7d9d86711f97c84f4c0febd2ac44d20be8eda3fb41d3271f2eff00941f400e327a7ff585751a1bc1a646d69ab3abdc81c4b20dc1c1fd707fba3923ae2b2f51b3ba17322c8a2d74b9395e3250f663d80f4f51d0139a2dfd7f5f87e86ea165afcfa7dfe57b27d9dacdad4c8ba74f0e5f476ab6c7ecd759e00c2a1e87d80fccfbf158f3e9315b44d71ac0fb7da37cb89325507600771fafd3bf4707d9ed26783559c5c49ff2cee1f9078e38edc751d48e9cd6499648b5358da1dda6b0222694fdd3ed9edee7b73536edfd7f5d3bf67a984e3dff00e1bd7b59eeb65a24d68ca2ba0e9b22868f4d7f2d8657e71d3b77a2b49b438d989d908c9ce06e3ffb21fe67eb453b7f56ff00ed85cad747fd7fdc232ef23717b34914cf1dcaaae5801b5c0e70c3bd75be0bf11b5a4177751a61624c4f0300c8fc678cff00fac514556435aa3c4ba4dfbbd8f96c7d38aa119a5ad91a4b7d7bad6993dcdadc3dbe96f200f672b6f24f6e71faf5add36f61a269b06a0968d75049fbbb9b3964c460f3f73827a7209e41a28afb787bd1e796acf05e8ec8e66ffed371a5453ab2a69ed2318e35244a80751bbdff00a552b8d5ded5934b049b63b5e3978f323dc07e7d79fd28a2bcda926bde4f5345d8e9be12f88b57b6f19efb7bb30c92c66de739cf99b7eeb1f7eb5ea3f1ba01a1f87b4ed4653e7ea924a0adca0d8f105e728c3907de8a2be1317a66b49adddae7d5619df2fa89f4b9e4be28f891affc43d3ed6cf5aba4b95b446952658fcb790fdd064c1c12071c63a9ad2f07f846df5d8b536b9023b8d34a9c212508232a7b6e3ea0f14515eda4a751a979fe06d82f7254e2b676fc5aff003f97438ef8a1aeb6fd2e68a200089a3556e060f1d0703a74147c3f91b5bd2dad44b241709233c72a1e0600c8c760723ebcd1456725ef35e6cf52127f58f92fc55ff3fbba1d66a1a3d96b105a4c55e2b88030ebb82b03cb0cf5ce3dbb1acd87579b5d67d20aaacaa4234a4f1c8cfd7381d7b1e98a28a725676eff00d7f5e7a9d976a3192dff00e07f4bd34db431e2b383451f62901b9b69a2f394b7dfd9d707df9fa0f7aad3dadccd62911789e394808ec08600f4c8e87fc9a28a8fb29f7e5fc6f731aaacdc56cb9edff6edadf76de873eba45d9505756ba0b8e3e6238fce8a28ae0f692fe923bd6169f9ff00e052ff0033ffd9, N''Chàng trai bị liệt thành tỷ phú_small'', NULL, ''077b972f-1a51-415e-b48a-19f39219d165'')')
EXEC(N'INSERT INTO [dbo].[Picture] ([PictureId], [PictureName], [PictureContent], [PictureDescription], [PictureLink], [PictureTypeId]) VALUES (''0acb981c-7540-44bb-87b0-2f2edbab6a98'', N''qua song PoKo_small'', 0x47494638396182006400f70000dac8b6c9866699aebaa56749504b4afbfbfbb17966d0bba9eaab8fb7a690aec5ceedd4b149532c312929e8d7c875894c9b6247aa7257d897776835248a5337d39a83f9e9d0c88e50a86c5294573adad1cc53672f864b33647436748967784733926b3249241b885844886855965c41c57b62e8cd90a78a76987965a7866877422b9a6a53bd8266958986785746b79778867976886447733a2895a5999a775ab89b84453936cc9377535f5a9b9898889998cbb39aa4b7bab5a8712c1816ca8c71dea486897855c4ab975c3124e7a67d6c823ac5a787674436776865a4bacbc8a867a89765d3a04ea65b45d8ba789a8866697865394a26a799979786589b8376efc772888755b69967a487594d4d63d5936c767747b27253b99656a9a7a4dae4eabb7c5d7a5339647845a27537a4bac7dcc28e786646d0dae1b26549b7a8a6b3795caa9686b26c558b8484b18139f5f7fbd18c684728218a7266d6bb88b27559d6b99e9db3c188382e552a1f9b9864866b6379746a35201b82452c79625ac8a677edf3f78995569979478b7a81957a74685249eab7a0a8becd7b7273e8b255614a435b6560ae937986754993955c543a31626b63b98b70e5e7e9655853d9aa96a78749b69b95b6b8b87b91938e847bf6fcfd46332ae7eff4161213aabec6aa915bcc936ca99e9f745b52b4895aa2b5c4654327bc735dd68c77deb664e49e87a5583a682f1f98a571ab8c83ceb276839a6539384bf5eeebdaa7767f9447653a2fbd934a7a7850e09d7af9f4e98a4643647554f8e3ba69451b69625c754d40855e51655a38bc7254b38c4a869b87a96f4b99908b616842f3f3f78ea0a0904b349a864d978d91d5ab614e403e9c6a60765427828d4c602b21be7955974d46695c60cfb38672181a421e177a3b36975c547c2724c1b3aab06e4bbbbec5a5afb5241d1e736e73888b5f8f5f694244545f637b66512cfdf8f5b47954b88c8f875b1eb6afb080947790523094a05882592c1a191b501c1efbf7fbacb7bea25d75d19e9dc0c9be9e656f3c2f2e512e2a844d51772c30adb1b1c0a05fceb06ea19192ffffff21f90400000000002c00000000820064000008ff00591888e0aca0332ac7fe1558c890e1bf8710234a9c48b162c52f369a15b291f1d1115f8fee356870ef880811234480bc772fa3a266972cca9c59d18001671108fe4aa3b0a1cf023425020d3a53ddb7910d36793cf2a8c1515abe44901001219b08159b38c27a198a22d0a132c1d21ce8cc008d6cbf24fd8bc7f0cd4f857027be8915ebab58a2145b7cdb9b94e9bdbdf83e90804098c4e0152b3ee0bbd78c0081655ee1de151a77664e9cce44b48a77eccd9b789eddfe74f8b0402c0d071258daf6c5dc64bc1161bc3bdae0912f1bdfeef922b10203869c2b204450337065c64162ed2eb4f8b5b2cccb2bd06ad0d4f998f5cea1df16f87240488d1a270811ffd243689b060d925e132d00eee8d190718e50f8ed3b021d356a5844ba71e38701119b8c8488506f4dd4105e0461b082669c01728c830e5e979d5bff9c2104232f30c208157ec821871e7e10f282114200f0066c12edb1d7519be483594e180cb0828c88a16040243fdcc082222211124b69a3352724694145a0a0550068c209204b02e2a493d685e6d93628a4f0c20b2750a107887a7ca80715277cb7c38f283e04ce6cdfd850d0082ef8e24b18865170042d1ec5b042043756b0c23d8a70818e72413a242482c189408324c770a2e8924d5e87dd1b54a610c90b29a0e0e1088558ba250a8c5859831064a28844277bfd62c00a317c30043e137c10c607134cff804f1c4af902811a1544f24821c94cf3e3426e055b80683e391754705359c2d9a28a3e09e1836f0080c21391744a83872888a2070a286c8bc209948eb8833965f6f28e488851b0d851f8a8c00105aa36f3c826477cb042001554a0d23403fc3aac94a18176a07a164170d20a07bc91a8245f34fc85244f2e79cc19954a9a020d236c2947c6d7d2e04c95921a60c41f0094fb0e1f8f388381086dd2e232551840e00b36b9fc828101fc55008433136063c057003f4a6c7328c6f0cb083084a20127929c719e064e432c09c49cd450652417633cc20a231cedcc0834a06a960129a440222ea276529201020d40412e1f4040070b7483010105d34410c02912e4ff6b0007d3d003e4b0ff6627a8b1348de047872d2c13ca3edd407dc619f52cdd30271ad040439558601cc3d6bfb830c2083138430762a78eb2c2880ea0e8051f28b33d10042bccbd5fbe3f4442f7de12dcd0bb0110b0d17a4481121c5421a2248f841e48f8410d22fe8492461a97402d09273b0401360a34046134d706c7e0829db2e7744ed846d40188269ead0f48c3677cc1f4179e99f3c524283bc34200fb0b64c00fa9a044055850821ff0ad0212f841ee0c608a1f84aa22c6c38b2226218ac5254f14932844060b410024b4401d67908411ec0436d2c540040b8a010962e08b6cfc860e06a0030468708e18a4a01af550800272a84332f8d01387508027ff7448b9503ce203cec88f024bc00616f0e7064090000c15788a1fd04d7725304499b6f80f8d14c2059350c44b9ad18c8cb0841a489083f45240ba5f784f7c28940a0b8f0001fa0c20662b508320626084037403889e2003297cf8434f04d290de90c73268872702aa810e2bcb00bc30c00230b0c1147430057122c1052e748313f09b9c28bf0008140d4b515f3843b33421c65616e2251cc908470850885eeca105348881190a41ba37d92a0c22c8c007e868a401181302bc411523e6d00d429262903e1c6420c960481e2432028819001bd8f0bf0888006f22c0407f30908de0e0e9040608850e7518c443b8739df1d3044d00d1347606719d0a90970d1e51ffc64db084253600280126e807ef3d627c31f8081d3f4001117c4005c2c164cc0633001184010b3b388027ec204852f0e099d0b4034705e90d1e7801052b2041063210812be2e80691b889088ef00bc444c012f8c4a73bdfa9807bc6ef0df25408fb4079869eeed4a8ed54c02338c212a438b5011929630615e1824db8c00c330d830a1c4a0112bc6b0011000317e8000630b0400dee70c10afae80952d8e199227dab20ed2000b7daa1a464e0010d32c0010e00331bd3002c05b2e18b4d34438c7e58010dbcb0ce9df2d4a890e5e9e474ead8ca3ab619ff04e83f47720f0e668400619c5721c260860f88a0141cc8c03733400235b0410d0150e01323108646ff30c28f6ead6b5c452a00baea5600bd254531d841013961e303d3c88572b1410b322aa21085f0030aa8500c6f0cb1a74948c251ed9954a422d59ddab56c1280d80ca790e4a9b9690c196d4080c3b2240c6170810adc9181def4c648901cc0dd48405627c6200618adc72582cb03baf276b7bef5c65d47d0078656651ac9c506365e22465a2ece0f9398042296210f201e42bb806cac651d1bde0f971888d925830d38cbd9cc7e56bdedb5418014510ef886b337f0fac0073200010eac62564aa1000b6860a8045ce212222db06f459a5bdf02b7b75e08830c1a2a020ec880b90165cc73a15b086a88a217484042265ae0057964d7c340a46c89779add362781ff14674e021992d06258b0d7ce645caf46622c92da7c84762905093ef030040ee8f703748a0a09c0f083cfbde012f2283070edc08327efb6b74fae2b325e2595570d131f4951c42f7e218ae85eb8791a6b430ece7c084f244188ad0ea2abb37b0841be59ceb8f6a19c9fd9e232b6a4bdcd80459e071acb06f0815e61a001045410073ef04906bea0240b56f03612b0e10615b8410c1a910248577ad2bc9d3429329d6952b4410570928a4a68f18bb2fc2002a3ee9a2814e7872d85191c39f08634a9694821ae3390d985f35bdfeccc8e928224ff14767b0910cb61af58c60d88c341e9a092305020b5286401ee5c6b80d8e6e8bf34d846a4c90d5c4967dac922ffd5810a5c759223b8e07f06a8c0290a62243d1cad6b8a130535fc800418e400cefdfeb70e733867b7129c907385a6531bce9171fc739636784703308b3243e524020370211de666080450118125a04324409e004f481ae54a76f2934b4a0a64f8e20832a0c54722918a480420153f58010bacb8827893fa25c87b2522bcd06f4376e3df41dfe89c09394d7ef300294fb7b39d45f24f327ee35c013a220db0890146fb67004ebcc50dc05002befd000cff89010dd630036420e3db963630c9278d0c170cf323294040054a90af9b492015d35e90285c40e1f5da0009c590873cf24a06210eb11e86f4440edb0a676a667a06c3c0c45f20df922cf7b9fb04b8fcff3736b1097cd022068419c0ff021023122463a5603045094ac03f03b843f52f40860ef4bf7fd7cf80dc6a8769b5b772be800215900aa7a07125600a7b730aa6804910e002af3446eb350930a00ecb177dd1e77c0ac0033c20447630033a300c1e5082500005ba000548b1172dd1544f15502bf60e98f7084320022ad41b0f180119800df3610a3ab24d6365007032058c900398a003fb9784fd27003a80694e664d2de00b1f203eff63450654022c700a0b680aa4b732af3450c076587e5076fc96573330039e300cc33003ebb00e33c0031e708250000990b00874788223b122f7b0540d000bee711459e6149d803234e80b27c45a6cb07503f13fd8f6036cff800677445b2080058c80844978843a7084faf77a95e6811eb80f54f00bbeb020ed267f1d674501b080aa988a10005d14c84f8ae0076be00576800ceb800c24e801c3708271e801ebe00190808227080938800376a8827b311b7b4846f7802680785ee2f7082a500a82516514504718e00c5581014d504e84d10432e20e8270028c7086c8208299688998788e025052268502bf6083e2837e37e371a7608f151000a948588a404b62c44f85f00b54f08bbdc88b5060820719877258820a69827f2183c7a6149b908c7c211271e01427430ba5f03214e02ed330152a800d327007cad557c8e4362440034bf00252a08448c87f9870849a788e6b101d27e40216ffe502d9a07e39d21f0d7803a9109412c006bed04aada411234005bdc8907278904e5982e0b0904e198c50c00797c70771402b8fc00718b92248619527e3724ae1021ca0022a900c22d007d8300d97347f9180012b4502e2082e3de005e8f892fc9784ad807c9690020aa242271106bee0028d4437f3c706198006a5970a08800001900f62745813a80866800299e0017b80994e398c7448957668879db9089fe914c7860ff830048fd06ce2277e71700f56397ee5300566a0143aa6027dd05586910d6c601f6aa083a9350529b00409309c22d87a67a8845e700075200acd60238801012754651fa0083671475bd704c940020d740aa7708012800145b9658aff7004cde00296d994a1299ac5289aea099ac5688cc5c8073e100743200332b091433004dfe003df60953e606cc6367e6170024f10068f500e1f609f1c4002c5c50e3cd67e1c10034f5003b3689709808e336097c5990694400f3f900fad290a046193bf40014549076c40027d4002063000bd62a2227049a7700b01c08fad04907270009980039d4987a0498ca25987c628a4ef598cdf409f326096d33804b4c00727e3a4b0d39fc6363e4bb0064f300531e032f6f901a965181030000c1a046b309cfb7086665a9c3a609ccad9a11e9a0df8f00dcd605fd0490282c90659073874100006900ba2800f9b900b8b990a60009947e07222f00854b5061a800459ff009fefd99e9f09a9ec598cf43901496a9fb1420b21308856d96cb3c1958d100e79c00a676806b44068f5e92eec405c1cd00761b086d867a66a98a66db80e6ab8037550076bea0c8bd15e9b006855110647c001b4a014180040bbb74da7d09841990a016051b94001d8d00745290a663008dbb008f04900ef4900e380038d0aae04d0a8e1aaad38909fb1122b323004b102a5cdd66c23716cb6f0001ee00879d00b1eb109211002718007966a9f491a060c5982aff00a1e50b01ef0000afb00095007426004d590007ed02342c04138491524e02622900dd9d052011494dcc9988d0904ceca0631829dd14a55914005309009e3e0ade310b32ffbb23840b338ffe018ef490dc53801ec9aae3ccbb321f00d2180077c302bc06006e5a0084150099fd0087ac014b4300459790dfc8aaaa5b05590f0006220060f50045c3b0b5b2b06bac0b5c3690446400562480842900084d00a84059d32f30b2c207f06d475a7d0ac08209412200170100060d0047d900c6840028a10062fb000070000bdf0b2386b8c8bb090031bb91e40683e9bae4340b4f4499fa5700575c00823d00a2f700195e00ea2a0088f909a59d9af84460b2b270284000e1ee0b5631bb662600cb6eb012f900d23300923f12d29001e60920db960270eb502dca985f38780a670b7200b07cedbb73fc00dfa100de078508cb0000e6001008082035bb0d070b00fff60b0078bb0b350b078d0af3d6bb952cb07abf20173e00aaec0084f700569f007b5500bf1e50b513b68f9c9a4661906aaf70b6bc00a0f600c5ecbb50f30b6baf0046c840de6450554f02dce200ef6800ed9900f2714062b60403f800677409268f080250007a7e0bc01e0bc0ac406c9900cc18001f830022f0000006001167000057bc3e1fb00505004baa0b525b8b0088c0778b0affe3a01ab20c459c9be4320080b60024e300a2f50034600004ac004c220986f570a4cea32d4788d0ab2028cc00f4e90084c000d45a0b05c1b08dc8202cee00befd00cf2cb2df9a00ff6d00aad809374aa9d0bd804d38006f3507a6c100cc1307ffad8b7fac806a9180010fff0083450037500000e10c904ec01b31008ba70c6ba30b68b600c630b051bc0c99cdc6cd740b9477c0d7c20c478a00232f00726e00afdc00ffcf0b0a8e1064cd005c2ea02f0f550eed25577924b39c10489b0003b10080f300bc66c052b800241800223f00d9310c1843002d8900d06600f84e00226d15018b04d052473a9400f688006823c7fe4bc3f40600886200d880a2eca39c3da4bccd080c65cdbc3b6d0c3c52cb6bac0c9952b03464cb4f339012bf70765e00a4ae00a4cf0073ba0010bd005b46ccbbe505cff25158cc426c2310ac0bc0be6800b0ed0030adb08c92c0729e007ef500868f10bb9800d54900fb9600f7ed09aaed20490680097247f25ff8006aa10ce822c0dd2100c6040073a9d01ef45058cb0039430c3d9db0e5cbb050a6b0c0f600b690cb6f46a0b5690b0aa0cd07dd007556dc449eaaabd4005aee0044ec00c5d50030080bdaed005a8d005680998ff45bcbb410c11a004a890085510c9b1600e3d5004c8ac39dc825972c02d23400854600028d00a84d08c0d700419a00a7c7c07daa00d77d0c77d1cce94cd0d5ce0557dc09f8f200a29c00875b003659dbd001008d060050f60dae1100e0f10cf0a2baa4ff000e1000db1e22e1c900c56669fb6d9571a0403e87005cc50054c200807b000d82b0b89800ac2a012c6644c194b01708d1f4e00dc7510c9d9bb003dd00820a0cc9cf204dfa007cefff00b824d056b60c7be709152975a19900cd6e0039dd0093ea00faa70d3940d890a02011f402a8fa00761220429400f0e80bdb8d003ed10088e1008ed90078e30e05b100e058ee00f10088160a966d907adda07ff2a03b73909d4900996900061200c5550099e8dbd4640cba8c00f82b02024c005c4800163f548fc5005a84032d4bd00325e09aa1704207d02858004a33302d37502adc008f9100d32f80eb490de77700d3ec0e43e000fb920df36ad0adc6008448001b43088cdc90842f00277600f94600816e0007960ccb3000dd000cf046e05045ee08ef0e621d0b3aba0ae461c2b436006bd000e992005db20052a3006fc80054f30dd00f0026340cb62ff7d0e198001c440035b770e3f5006555006d4ed00005006a8c004cc0002761204427d02dc2207f9400bd3e50c27300df820839dd0002aa00ac9100d8fa00ffa7007f9d004377dd35aa0057b13002bd06c7b282235800e275001459d0666d0014590ec668cecc9de0ef69a07d0be04ac900743100dd6be0a737eb94cfa4a48400d7bd006c5100af5f002193006c4200a2780bd0b900020e00664cc0f5dc00215c50560a0042620e32610c9905c07638c0a26500b10303a279002ad5029cee00271e0dd228002d9f0089da0ea7c900caab0d2d9300f0f18ce377d0bf367d359472b47a008422dc506800e942007d9f0001db00545a0f22b9fecc8fee07970e065ff1e08b4c0cfd61e0db142b4a5b0027a000ea2000383500cc56009f5d0a2699502d40d000910369570bffd2008c4a005d10ddc4c90ef00a001003007735d05b5d00720203a297002620fd8f8c04bd95010f7f0f0eddd09f89098cc3b0df21d0c5ae0c12b9c0131804d4760062e700296f00242600ab9f0d06a80052dff005bc0ec2edf010fd00ec61c08c61c07176e9f71c0172ed00a88206699e00f3020050770031100018a80020790f4dbe01d5d500bc2c00ccc200ca39008178005295007358cf5b2f0db4c30b4e9308561cf08a03e02be800f2e901999f10dedfd0eedad0874f003e47cd3c11000b7e0c1ab70d5aa40493aa20723c0084640a1be300424ff10563760c62aaff25ddb011db0011bc00a0750be3d9000ac9095a83c044eda1264240a72000e30500c2d000369b00d09001011b88471b1c6c141070000ec30226c4ca50b19c630ab2664c701070734005082aa4aba6b1326d0fae58c462b67d946f8f25568a5b3239dde75a2a9480b31127deea82a01470b1c557d56f5e9c32e0298001228fd70412505151778281003c3e247b57ad502419b35ab4807b045ea49ea31c3c1996e71e2f061cbc7878d6604c0514332021c8c16725a78d92624021d1261c230d22009a1860346408c1935c60d28007514d611b25149152613f0c0bb566ac4af69b9ee6813f7cbc51196d936c9a4f90e0205197d646440e3b344ffd055b1fb70636155021043067c89fa15470584732ce0dc0062695da0070f8a4cef5064d6030f8166b1f2f26ac8107cf8d4c6993449d1a0362890f8c9040389975069b6a989100145901828005800e000718d4ac6504298170ee86f813a0e10422166121943063c7cc047911556c8c71a0c73f9e583097f1961a6993ad984031956c1e30e6ea4e126a83e26584505183160a1024a10a084923a0c10e1886bfa402e0050b4a8a0822d3a6060830ec428e201313ad8e0c825670984165abefb4e1144c0e90509420c0007894c9068639f50d439c000814ea8a18614183948a1035eb88291513492ccbf0417d4801926385061023e148941847c8ee0c39a3b3270ffa14a455cb08126d61af873021532c8401512a3c1231a4d57e120821f8040c01052495dc1073e542081373840f96d09278f54528c27a388425631742945062aa9f40391650601271314be746faf502eb9c4002ece31a015356bd8863f8512b8a2214676906c0138b739600166d8e1a08f23b078a4105abe79071e6db2c9e6037df081c72d1f58eb840f1928a5801d7684c223847fafc1838301acaa00885b80008212432829878f09d819401a20b550ea0947c2b1021a68a4db00c9269d1443850f54a0658223c4f462197f5220e42e2460c8a4057500e8868508a489408a049e40811100620120b14f52e0879113fa4b68e81d760000040e20e08096173ed9ffe41b751bd0669ad1a281079f7bf0e12344116518229a21725b45533caec1378301e840ea072d6e90a082840d31e29a10fa5855b9ba6f31c2114796c8e3f0250c5fc2913cacf0c08a9261a4c58f5e9651c792130821440ff73291821ea54fe0020c2ea8b0a806146a90843f6b9fe8a28e352cd1c03f38853082e00128a0251257f0c1fa1b0c83b7e61a7c0a51c49706686a40f77f010ee1f9b6e3f88084013060830e354a6021801b6e1892e1184292986250e0f8cd91299ec80363c47b487c098d3f905f055ff4f0e384275a6923583df4e8a5054b50021df3408701a4018673d44008093800ea8460010724e00f8ce0c7d04e908037696007db7801dc0690ff0119d0e00f8f68cb35d47584113cc207d750042d7cf1a84e84013678884308dc462fe9516f003bc40006b8600aabb8ea7b461842082ac50da4b4aa027f9842383436058e85e37084839ffc4aa60744c08010fbdb871436270e24b4001de2e04327e280013094401a3548481d76c0268c306407fcc0a0104eb003daed20016b801b4e3ee0823f944260cf730b014670041f7c8316f088c6373ad10c0afc29603ea064277c1006124000024dd864130670bdb92d674886a04148384082d105c07c407882156c010d5b3cc00a5678c212ac90072c404e7e2e1804e710218749e8410af64042ccd0418810b8e51168acca0a5af1a63abce0099161c815a880911aff584221434b0023e0c60da97de00aa50098958a18877bf8a001f242e73d3e209b68d8905e3299de003649024eee901b72db5e00b847234ad0c288ec800012550984175821085b98e512fe7085257ca2964fb0222110b1c58bb68010fe4004165b608f090c612db9e0420058e0ac149c0023dc32829a6ce70a213c13000cdcc801b671020fe68e165838420886300119c8400566bb46276ce08bafb9c005a59880a69259494542801868b0673eabc7053a7001ab55f981f70c91821044a32824a00af78070852b487409fcf8c3273ed1d6b796cc0f3080412b5ac0b962a420138840c22008810d5a982c0ed8a0031c02c085081c6007271082032ca0819e19e1ff0fd57080101aab4785d4631b5490983dd9410b1a84210e3f15ea5045da896fe4e311bec800079a11b079be831603e0466d07405562d096b6c4b0940f91e2bd1b7d20247d386549e100841a28e31382b0855b9f90d64f2ce10a2318c11ec228052ab481582380015f095108197c80033c5201abc0b082141ca081184cc80bfef0871d2ca0b21b9182810e900614741602c928c50acc1002a00a355f6da309017c410112ad855e219a6d30b48a060c70030d53dd2109fc94814c1e8505dda344240026540e108305420c822da630058506210558c042442721875e80a30539b0440e8a810551d01509f9a0050728100615186700a6f0a71a4ec05800ac69011affa8063f5ee034ffec00b2deda460d6810b501a802843188814f836a329196d1, N''qua song PoKo_small'', NULL, ''077b972f-1a51-415e-b48a-19f39219d165'')')
EXEC(N'DECLARE @pv binary(16)
'+N'SELECT @pv=TEXTPTR([PictureContent]) FROM [dbo].[Picture] WHERE [PictureId]=''0acb981c-7540-44bb-87b0-2f2edbab6a98''
UPDATETEXT [dbo].[Picture].[PictureContent] @pv NULL NULL 0x071f686d89f0d016486d2202c1a04330d8c08d08ef700024e817a5de9901a9d2a13735304218ae3184f04260c34a8984316cb185200842a19f1805160481043920621052580600194105710c0211d4a0451f44408148e2e3385c28813fa59500211c00d50ea881209ea081d939c0694353ef0b1ac1013c4300842e0882976164b638e0e1082428f310da46c97a75e208742801184ce16636b0e1b61f848d9d298061080c80187430c00d8c7005f1047a460ba3448983f0842904a1118260b13264d6dd1ae3470efe18c45eb1a10250835a067190810806904430bca01e75908cff62dfa8d28464248e4363c408fa602962f7210c5818ad503f40a5e911db4f9a715b253bf1085334db14a688f6b49b908116f53893c4104856114b874854e00566f8b32f5610808391aa065bd882186c1184204cc1c482c8447ba841054634621283c8c1fe1031843e809a03538b438f2150d29f18b90e26b844921978dfa5656468a95e831954c00176649203be3017bf3f7004329380ce7d90e435aee1f147a4511acf2ef9004e8e72917c8002d9260617d4c00230a881db2c7841059410640a44200009639821dccadc29348206e99e427b60a00733e8a10dc0ca81e6fc3004c123980322255906d0e8133818205bf558c809b6b190f862c4400b51b51964ffe0e36c6740055628071e6871047c5f3b19b2696a0890cd9623a471e47d6fc2c9976fecdf532093da965be2b1c78248dcc015827804724091301b45130b9f38b115846e8b7064820a990882195ad002a6e7204ba208ecd4fd24365a10bcab0b002dd08200308205028032108225a8030d48b53bd13d05298409f03762e00612f880143083381889b3238a3fd114e2f90008c00035408a12203936a0aa26d0b2641897221a0215883a6cab9ebf50031c04bf1bb80268088315900650501804b0914fa884f59b822d6884439b023d0882b96a836268813690022f680324f00519242e3f891019e4007f23b29f08800d32823250ac35309002692cdd4bb2470883ffc2e302ded2c02908017c202d175905a0f2857ff3a7002881148c36346802125085696087e5eb83b6f9a9b3d33e4d223c0c909bef8b844f508618f8372d481885a900b462b1ccb3854630032b8001eb6a011dc8012a58865008851ce8856600b40f54812130a3f0d23e5631c015680183b3a9350000044cb56d829d30188066e1020cd4407e10a993999e47ac0a7f02036733052e28b916cc8064a846a280906be8c059cc35392bc108500303004716480165100111630e0400820ab88113633ff7c302659802476883ee2a8665c88116900229b0042f00877ba0058b83411f78872ec433522bc00018812048350349c01aa8831a50afa14901623807309006ff69e0020b8b045048bcdeb00a93423c3aa083be9b3355a0806a7c41a2c00613e1039fa2145ccba46cb3a799d433fa308014d802544a0a8551c74868317e70abc5d18e226883d19b317ff0074ba0b44ab3011914afd6a28581ec407ca39e7320c00078012f788204d8a604689a044035fbca19a4080030e086b2fa01500085de483cc5e3020cd8214dfa3b0ec805a2208a3b08aa5548a6975c44b9d3240cc8b646442335784441300308500350381875048514f884b4ba823cd80a68f88a99818136f007540c856041845ef847f1923bdde1830668003c082f3c432238302c46b0043e3b0037620405118288e445c90b800b5023676446938acb6e8400b9a3c6ff179c3a10c4863ec086128906b7f132f1023599d4360c5881c0ccb073a88f0130837f0b4285614b2c780047482be8888ee99819f45806545c86cff3031b90144c2a411250013ed804f92cc8b851252d90063940815658100589c837729a4800830bf0276950bc015083e4000362983ad54330d5034119404e1540ce7cd114b7209edff33188d3247b92cbbf8400ebfcb182c1c41bf8013510840e988576b08222a18e2298991658863648c5a233ca5e58ad122486c0a485067804456886477811eddb36c0018504408111a801855020558b48355025c3ca2d4e22bc01d838a082112cfd353c5c852d5d9b7f690b9f5a440c93c9123c071c7c52b6b4270c78cfff10d3ce0a085062988ee9f00ab0f898176d816288c204d0cc1cb0b149380211e8213ac00919b8071b5004605084479880b112463058cd1bd80121180114f896333c004648801fa80059b8cfd6d2b54aa100bae3b8b0fa29a0ba43b6090178781ebe29213c00341acc360cf01e5791805bb0985b20825be8c80c980012089574fc819332032471d12278928fa9d116f00729c88150f082954182300051addad14d68864210055130832360545ca3adb234322140815f5888aeb4047aa00774a08775fc80554039c1938db5b93bb5781ee8b1211bba3bb7719b6f28a160032a1f93bb01308405a800385023c4c3c800908574bc015910159f548315008628d880ffe9a8958f495618a8b76270d634f0062fd001172081471c49dea2856628071730831130835f28074665876fa218385003143801fc689a03a08479400320628331e283167927e5bc3b1f102a5a3833641b8218383cfa788d238883e7cbc657bd520d9d86910b442d6b026e181d9f20827424025dd58248380762951527b1958c8d02edc24c7fc8016fd807f84004115881bf18c92a7d84720006171801d0f30333f085d8d8170840837328012d008513400117288788b40734f8010908006e988679c08790ca17b7708b21903a08610b5fd002b01dc221d4d51f8800177884e5c45c0f5c4494ac460c232e50f989c42dc05b4d5c1688818f6100de65805bc9d8ff0d888262c8847a5b0368f5823490023f90ce911cd4f714859635033388013d8801c005b2a248bb14e9098b19853028052aa0821fb85569800019e031002b113ea0a16bc83850a3856ba005574905b12ddd84a15f22900016800058242d92f13f1f1301111058503084dba55dc3ea8d082802df8d152861e0e065801ca0ab8d42de34488336188101f846fad0293d7882fa53c8206859ea728119dc975591860bb84409b88930b80504f8895160073cc08638e01b3c30113c68c35c03ce0f90810808120918e21626e25b30e216560312f95f0016afa9f30503201522b098f20900693887c22356b5add38ff95d5b41cf8bf2870b4e5e180051eca183355581ff6710841478822720043950b71800ba11680427d6de5283bd0244989f900615c007b37984b6d994383083c1d33662780d12e80d3eec437f5a4d482ec0dafd013aa0809110092ba1921904820530e09fb8482cde2162f05db5cd5852f6dd0610de3d4004cfb960559403bbc5412e788d21d0db67788618c0029fb90f149083f07d0251bd3661e45e2b369ffbb4e20928074110842b108452288747008646e823eb24ab1374c667e38260308503d29e52e3c31ff02716c84092f1050e10af9289844e9ee2663b076eb02710500510a895df7592e0bd952848e565d80399698534808f418801ec493c9c8045a5f58138e00510c0021ad8e546d03c1a70075ccb80ffed85835bc8b2a428cb09608076409cae280268888112c480bf48e4fa38076884cb77d6a7aed52a676cb63eec0d351081a11a2a2a61814e36408c3c873993d90ca0800ea858e06de07beedd62d883361884560805290805243041ef7b8d527804aa8e03477a873870074118031070877400815aa80510704e61a4985b088009b883600886c97d8647b0d825998e07d8020a20e9bb8d4b96c32a62b427621bd3996c693a285067533c0a38825e890413400038400355d0365de31776700733f0dd23b1587ab6155bb1817b90823d180499a14218f8851364010358d30f208049b0816f68807e6d00b67007ae068174480737e08731406155a8ad60b068128886ff3b3005200800b77e0463e0e20e404cc4ba6bc28b0038ebe971210a0e480699dda41e8233ad82cb1e0ae251b90569c01482faa00ce09772485bcc1e6a52b615decd013968037e5645248800039069a89d843d0007b8d80406e08552d8843878e65b7e86317008761066daca6d8b41c4df0e800fd8db23b1e70d70816dbbdb0850d315a0498d938da0122ae24a063c934b39e302604500099006c6c6b56c03810c70870c00862ee6dddf05de0d500406b807cc9e60f6268450708fc3eb0d3ffa1f2ac42e603083876e8467d06f232ff221f0310aa02d69f8a060d0026e384dc4936c1ab08524b1670830003af88b0808cc0ad724621bf08db3129198c1e88638ff62538321860312ef174f23863108f3c87e06dfed625b49e50d3006deed621a4f6f44680370d8831600071a308000285b0808835ff0e71d3084a15903756b0465a80465008167708722e7055ec0b7011f0020793834080662bb052e68844a7802332892e0050613dcf22ed7b52f07ce9f1e1719108f10500b3cc003ab9dba17c48026c84bba8311124050e123ae1f3b65cc4ee58a3503f4a6ec2731068ef287f60007448880b6c40045319d6da8034a30826af88320ff842ee8817ee8077ee80261a87410801a252f0122808055b8833ee0092d88802b98827228872df88a0e88816f4493c0a48018e8a1c094750af800407987814c2454192d802c194f0703ff41044e12f8c60f222e77280a065076cceef83ca7d87b600016df006030062944022a40875e7a5230888044470421b8911710845130815d98033310841e700227e80725a80561e0877ee8822e0081e3c8249f208112e90336c8801510046936832030863c075134898015682de98c80dc6a4404c3079928cd068085d2ecd7d102aadb9a064ff2500b8b0162808d0f60f606a0f1b9eff85be90060e8f32d3006aaef80fbfb1251786fb31c540a10855050ac6af8042c988305b0000b30812000814ae0079e77822e708c5a1084d6c2330e680234400376d00d7750ae1eb8776530862800861508c72eb73037ac8f1e124c941b1b58188771c882dbb77dd7a6c3ffb4590557240a805d012e18700a70016a30834768804d88021bc06764a5fa5b29ee54b7056048797f400202100593a28339730124400123d8050bd88532a8069b777c5c98834f10862ee8079eef874a90ed74201110e2d217118a0f58821e70853900881e57966cd96066801a35112088f84082588408dc30acc00081c487060d6065e9e8b1232c3e21f0e0c1378d04050a1c54381c90120389661c2101b3f1e8d1a67bf71a4461b0a1e006632ecc18db022c05ba568390449210e01c8930a2cc98a963c1c22e130bb6eebabacb95ab7e5d84f1eb67965f8f31abd6ae9ab0124f29413dfe38293347e08e1e31301888804104870f1523462086c162065a1bc7ff7d6c1c32ce4819d82660eba342860c0e2416d282056b1c395b5ba89a011645a30d065b0a1a33068caa3130295a203200c4e9b90c85fc24587015ebd605bb865f5de0e4b8934a20f829e9a744c9271063849155562e06962baeca983031c71580031022285c214245180c7efd1ea628025f83718cb390a3dff85e88fc9047e2f9204244361024f68d468c91d342107a98d148235b88b645100f9ab11a300c04c0020c7e000104280144e08e1f650cb78b70c291d85557583da7442db574a1441795bca80472fd5c01420c537cd2832bdd71570d25356ca61004141cb1196187ad30c00a1c2c365f631e8d738d7e214076c40024e4c2810c71bcf3ce621d2112ffa1198aac16c414115a114423b6046146330cc021010a0620c0210bc4c4f0825d6594e1ca717e7647dc7026d008a320200813a3303d2811163f950882c52757fc314777dd1981ce0910d041641847a81711064c42b00209b4dc231f63501242cd47f8e917471cb4ac42123e7c7cf3a5679fd1074e262894668c196e1a6b0bb26694c300281b46721b0b60e8498320828c0182746e687b0133618db8cb73c7f5f049b59292e528b9ca2c8156a0999e800e0d2ba8c14204188591e40a17912002059b7094c5389eb19a851f03db700d64b4e2412bad7c7ca9d13b9f1948ce1e6cae664bb1416c114e82188fd62c023f38551831cf94e20e167f00cacf182dbb215b4c2d173851a21380fed90f3f91b65c093f5d8050c927955ed1435dddcdf1442b3444c0020b6a90500a04061c0681be2929c658af02f73a302c085b6965c3df74f20e811b7de32b7d88e4b1441e533cb1e613539cf0c49b6d061110003b
')
EXEC(N'INSERT INTO [dbo].[Picture] ([PictureId], [PictureName], [PictureContent], [PictureDescription], [PictureLink], [PictureTypeId]) VALUES (''47ab4927-e482-4285-9336-49eedf21f6ec'', N''VinaPhone cung cấp iPhone 4'', 0xffd8ffe000104a46494600010200006400640000ffec00114475636b79000100040000003c0000ffee000e41646f62650064c000000001ffdb0084000604040405040605050609060506090b080606080b0c0a0a0b0a0a0c100c0c0c0c0c0c100c0e0f100f0e0c1313141413131c1b1b1b1c1f1f1f1f1f1f1f1f1f1f010707070d0c0d181010181a1511151a1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1fffc0001108019c01ea03011100021101031101ffc4009900000105010101000000000000000000000001030405060207080101010101010101000000000000000000000201030405061000010302040306040404050303030500010002031104213112054151066171223213078142521491a16223b1d11508c1e1723324f04316829253b2c263738334442511010101010100020202020301000000000001110203211231044113512232140561ffda000c03010002110311003f00f95900804020100804020100804020100804020100814241db57581c680bac4ba6aeb13a71748d74aa03b16626d1c7b152a256ddb5ee3b9dc0b5dbad65bcb97650c2c73ddde6980f895cbaf59cfe49cb79b6fb0fd67736efbadc65b2d9a0633d42dbd9c7aa47d2d8e30f3abe2bcdd7eef3fc3ace553bdf40c3b3dbc57173b8b9d6f715fb79e385ae63a9dd26a6fc42e7cfef6ff0cbcc6726db59e9ba4b5ba8eedacf306d5b20ff00f6ce27e057a39fd8dfe13620d0af4f36560a05b427058c080402011a101c518102a01021402054094080580a040880e0805804020100804088052116b42cc0854e04c39ac1197854100804020100804020100804020100804020102a41db57581c6aeb195d818aeb115dae91aee8ae04a52b5fc78772dd4d6fba73db4fff00c583a8fa925fb3da2e4bfed2ddaefdf9c47e67114fdb60e6713c178fd7d717cad47bad69d37149b7f4ddab2d62d3a4b9a07a87bdd8d578ba97b7450755fb8f3ef763616d6d6d2d95d42d3fd42e9d72f98dcbdde57b232da44d1c9b52baf97e9cfe4fb31af7ccf25cf79738fcc4d4e3dabd33cf99f888d687a2b6fe93bb96f8750dcdcdbcac880dbbed8b48f58ba9592a3cbd8315c3d3d2f3f88d5d757fb677569bdbadba7c477b6ac8613206dc425ed99ccac8cd2e787bb1fa415dbcfd12c23e37c723a390697b096b98707787f812bd50714c1182880a20440234205a628c14402d61688128b1a440ab581022c684051014280a290880402010080a2028a68e56b420451584f17358d465e15040201008040201008040201008040201008001687348e44634e7f9e012072dede69e4f4e28df249c58c6b89efc038fe4b7ee243b6ebf8fcf6d2b7b1d1bc53f10bbcee271c7883a8410780381fcd76e6a5d61404e1c4e341dd8aeb2c8d4db5dab71b91aa1b69a46661ed8dc5b4e60b41af7ae7d7b487d6b7dedb7b597dbcee6eb9bc633ecad9ae746c73f4fab369ab5a2bcbe6c970ebf6636f2b3eaddc3acf70b59f609591436c256facca343b54274b4875356b19d41a1e0bc7e9ed2ba73e6c641edfcc5daa4b9683f4e34aa73fb122ffa6a50e812f00b676b5b4ae97e55ee5da7ed44df2ae99edece4bb54edd1c1e2b40af9fdb9fc27faa81d3dff8cbc6e5b8b9b2b9be2b3b7654973ab56b88345d3fb3eccfa563ae6792e6ee4ba969eb48f2e71e3526a4aed7ca4fc217dbbdc337adb23bf0d63770b5668bbd028658b848e0302e0b2779f96b3b45df184c39a60160281014080a0a2010080a2d60402c69100b581022c6840205aa04580a04050a04402c02010098116010145239a059822af02c2010080402010080402010080402010081689469ba27dbfea5eb1dc8596cb6c64687527ba93c10c439c8f35a7705168fa5f67fedc7db0e89d986efd6b3bf78ba6005d0baacb76bce6031ae6b881cde428eba6ce587ea5f75fa31bb8c1b5ed10b365d843bd3b8936e81ae9238f9b5ad10877c5571cdaa7916fdbbc336e573f60f9a5dbcc85b68fba6864cf8c71701e10e5e9e3cec46b4dd2bed96e7d53b5417c2e6ddb14f39b66c41daee811f30880a91f14ebd7eacfa6ab76ae9a9ec2e269af210eb98267416f1c8039bad8ea3e470381d3f82e7ebfb4ebc78b4f6fb9754cb70d7dcee57531f2b5beab8461bf4b63043037b005f3bbf7b5ebe3c5adda7aa3728764b8db2689a5b79289befd8d2d9353051c086900b5cb3fb997c0fd96d5fd4436495e2473c0d3348ec4d05057cb929bd45f3c3abae9bb38c02256b8385406e241f82894b2a0cbb15bb5e1a26123a9e402a69fa9759622caa9ba6cd6b212c71209f134529f9aef2f2e579a4ba36db8b9df7cc6ce681ad12f8a80654aaafecbfc22f3543b87466d3330b5baed8b4d5920f10af25e8f2fd9b3f29be6a13d2fba6dc4cd1385c4388923656af8ce7a57aff00bb9e9cef2a2dcac5f6971a47fb4fc6271e5c8fea5dfcfd7528742bad0b45891440881688110080407140202880a20288128b1a29820440b44088040b540944053152110080405160440290510435f3d61008040201008040201008040201008041a6e84e98837ddf238efde60d9ed8b65dcee066d86be56feb9326a563e9bea2eaee9be85db368dcfa563822e96980f4ade1735d701cd2756a8cd4b4b88a7a8f5cec547857badef1f5175eee0d7ce23b2db21d4db6b1b7d5e978b373dc7fdc93b725bf42f4c1db40e73b59c3b78af6f879c73bd2cacb6a7cef0da00c26870a52bdc9efeb24f8579f36b79d3ec9b688db35a4b2c12318e10682e6973b9b68735f27d3d75ece7c97db4f4cee77f14664c1b1d68f7e25da8d4d49ceabc5d7a5af74f38deec7eddda00df5dd8b1d4738e1f15cfecdfc2f9fd2fb5413698626d34f84d2a0fe2a5b4eb366b49e330cb0b0b223400b720b759f58ae8ba5ec8dd6a0c703c035c70fcd6c317f6bd3769514898d769a1786807e242a96a6c57ee9d116372cf4cc0da38d7533072de59798c1f507b7d3c0d7189afd4df28cc1f885eae7aae5631ceb6dc2d66746e69a330703910bb4bbf979bad3a2dce86c9197077999a4e14e58aaccfc227ff5557fb5c174d7472c7a58f19d3c4d77d5fa576f2f5b117862777d82ef6f78a8d71bb22dc68792fa1c7befe5c6caaa208c0f0ccaf44bac2258d1c100804088040201008040201603b9025102a0281022044020160440b4581100b014408b1a4a941117ce504020100804020100804020100804020107b87b60ce8db0f6cee2fba96390c17f7d244c9e02439b3318df4dae7540a35b5700a75af2cdf5f243b9dcc22e7d78b53a92b0e0f6fca48c96e3355609a935f10ccf357c27a8d16cb60f99ad60617bc8f2b454fe4badf79cb78e35e89d3bd25200d7184be61e58f803fa97c8f7f7b5f47cbc9afdaf62862d42667aaf268d269e07fcc02f0ff66bd93991b2b7dadac8042cc75118f269e2b136aeacff00761d2e65349d181d58fd2ead56ce53aee47060d39bda29dc16e375dc2c9591b4876aa50bc7e977cddc130d4a6411eb74ad198a11950f35a5a9f1b008e9937815789d77469143470229add9aa919a8b2db412123872015cacc63ba8fa32d668e49a369f5695d03e61c95ce9cfa9af31dc2ce4b77bdac84c4e8ce2284b1bfa09c81ef5e8e6ebc9df388d792dcb2c9f23e37524156c9a5a43dbc9d418a485a8236fb5ba6fa0e25d38609581de10f6fcc1bdad5d66a2b1fd57d3135bcdf710b291bc79463fc17b7cbd91632a4119f3a61c17b675ae748b5a10081288021004202880a2044020ea8b184402c6928502d0ad60a20e56347140202880520a2045804094469288222f9aa0804020100804020100804020100804020d647bfddedacb18666b2f7639a205db662d88ba94712053f76bf3e6a61a9df69ed4ee149a3dc770d9e47e76d2c42e6361ff00f51be22d5d648c373ed5edc5bdcfa769ba5f6f2e69018d8adfd06bfe2f24aceac9092d7a9742ececba6b3ececbecad3fefb9de27fc1c6abe57ec7bbe8f878c6ca6b7b2b363a186ad39fa8d353abe9ef5e2bddaf6fd644bdab6e6c95646f1eb36b20d433ae6b244dad5d96dff00b4594f191a9a47170f9574e654f561f66db2b217b98d2d1e72405d3eb5cfec8b796a35fabe4940191ab5ce3c3b3e2b31bae61d7ab49ae9c7491c8f0ee4c6adad5cc9236d7c2f0285a71c3e0ab0d3dac31a4babe1e0315b8dc74482435c28b5246b49d543470e1cd548cd218daf14752a71f8aa911580eb0e9c314ceb9b6796c171ff00f22303534bbea2322bb7371cba8c45c320819e84723e58c38e0280507615de3cdd432edaafa6b463c35a46a6bad9e4812070e14e4a930e5dedb69756febcb188a589e239a1ad5a09e5449708f33eb7e9566dd70eb8b7ff0069e41c060095eef1f5ff0029eb98c7114af1a66415eb73145ad250a05a20440201008128811074b01c1022c0a812ab5810140b1a2810140811022c0200ac08a4056b5ca088be6a820100804020100804020100804020100826cf3b65db6061c5d092dc791355822024635fc335ba36dede74d3b74dc6085b19325c3c08abc00ccaf1fecfae3d9e1c6be9ddbb69b4db76e82ced9be16374b8f1d5cc85f1fab7aafa339c43103279248da00a78850006bf1e2b616aff0063b19230cab6a62f135cec0b8725da472b5aedbacd8e903b20ec8725e8e2387756d3d9463c34a54d454e6ba58e72a86f76e8c39c5801a8a16919d172c769556c81ce35734b7460e68e098ad4c6dbd285b8579502dc64a71c70d54f822b4c120e2fc1b5a2c8da2e036b56d68ae24a5e416970041ccad89a6e68bee2d9f13401a85294192eb1cebcb7a936a92c2ea460635c79915241ec0ba4ae3dc402d33b240d8b4ba3f249e2a374e74c715da38a640c7bfd3648d1eb6973a7a93e389b9503682a95355dbaec5ebe9b5b96b5f6b290637b687501c01496c27cbc6fac7a624da6f9ef1a5d04a6acd03068e4eaafa1e5efacb19c039e0bd6e749558d080a202880a20440204a205402029c9630202880a20288110080a204a2c69100a4229a05ad728222f9aa08040201008040201008040201008040207198c6e6f1f32cbf935276cb592e2e446ca6a22a01e3d8a7d2e46c7d0beca74f864171b9c806b60f420a8a0cb53a9fc17c9f7ef5f53c39c7a94c75121b91f982f1c7aba33696927aeea805d5d61dfe0af98e75a8b7b761a39d9b47874f15e8e5caae6c08ab5f800bac73a9ef986822830cdd9ff1568c419da251dbd898a407460173694ae67b531bae8462800a00a728e2485c05453b96fd5ba8d2b312780c7e2b7eaafb23ced76a0cad3572e0b719b0e358e6001c2840ef57f573b4e4740e25c28064b516a83aa3649ae1a2e1ad1a1a74bdd8020735d24474c6ce0c324618e019102034e2097675a66ba4ae560f57d281c6ddad6bdc285d4ad03b3009a9549b0c42d7dcdb4ac6c757444ba2193869e5deb5283ba6db63bc6d1259dcc7136e2304b5ce69d4e7053cf5f5ebe1763e7fddec65b2be92de58c44e63a81953e5e7438afb3e7def2e1dc41a0560a04088040202810250ac0b4405102201601008c08040510220101c163494408a41453422d68f0a084be6a82010080402010080402010080402010083b8890ea7d428b195a0e8db569dc0dd4ad2e8edc6aef3c970fd9eb23b794d7d51d1d631596c9651b47a64b448631c0b86a35af6af8dd75afadcf38d0c718c08fc14e2d261b6118a838f06ae9cc455d5abaad07268ccaefcc72a9513c35be9d681744d87592f33dcaa271d3a468f2e6ab188f712348cbb53033ea0750818fd2aa36bb2e1515c9539da8d71a5b812063c566065cf874e918eaedf2a60591fac62ea3b816e151f0558cb4e4746b685b51c7b5313ae375264b4f489f03853450568a9958abddbed9ed3088b4f881a83470af03cdddcae39d515edb186e05b39fa5d53a5bdd92dd4d40b39256cc2492a2373400e69a6216ea137d5b5172c7d1da9c68f69a1ad78b68b2f3fcaa5797fbd1b3d85bdec1716319123eafbb95cd7876390ab9c47fed5edfd4ef7e11d4798517d040a20e68802101440880aac02010144051014408b181008040880407058d08128a4229a0a62b5ae68821af9aa0804020100804020100804020100804020e995d40f2c42c656fba0ec1a23719854dc5c3228db8f1cd78ff63ad7a7c63e99b5a470b40f281407b8517c87d458c320189352b75a9cc9dba5bce8ba44d4b8af284b0715da5458785d675c00c00ed5d226bb6dc9a02465c95445746e5aec6b43c956986a59c3995fc9524c32e75906848a7048105cccc3a00a8ad0548c1533eb0c4f7123dc461ac655c551869ef9c1696341e6862547347a4bc020e47b111624c528778079db88afd3cd138e6ec19632598c8d199c16cacac96eb68f642f908c4bb535c09ab5c388568b1473989e3d57e2e8b06bdde604f15a9a86eb884c6fb72d6b252dd6e63b10e1cda4aa911549bbdc5cd9597de5ab3d496221ce6b7106219d3e957d7e0e59bf746237fd3f69b83a474b6f306c96af6d3411dbca8bb7e9dcace9e446a0afa95c82c80558d239300a4251014080a04050204280580402c0204460401080a20458d080583953408d187241057cd5040201008040201008040201008040201074d7d331558c7adfb7503661b5b8329136e1af3a8d5ce2388e4def5f3bf62bdbe11ef56e6b1d726e78af9f8fa07593b034734c6a5c578ca54957134e7dd169a870c720bac453f1dd027c4285b885d2269e6bdee000341c6b557114f37d37374972d2b998871d20d0f32ae243242d6f89a40c816a408d8272ef00cf3d4a838607868d4007378d0e0166b1d163dadc1bf8a68471c2b4d27303b15186b09243505ba322304458574fe9c6417785c285c9acc535c092e2b1c74f10c0b8e6aa54d8cddddb37d673ea75b8e97b7803ce8ba472aaedca06c4f631ecab8f8a377169e4a92ae648c8670d7b5cc6bea2403c4c35ceaae7cc4b29bbdbdcd85bbf6d1ff276aba25d0b1e308a4766c04e414f97795d24d794dec2d8a77c6d38b4d0b4e60f25f679baf353340bae30942b142880a290880407140204a2028b022010080a2c60a204e28040942b1a5a20458128a68428d0820af9aa0804020100804020100804020100804020ee3607480530e3534594af61e8781ec7ed3751d23b5d4496b29576834756bf282be77ec47afc6d7b5c1723ed9aca605781f45c09985a703a8647b11a6fee5e08a65c554313e3b9356b8508198e4ae54589715d55cd23c6385330bac45498a59dc4e9d5439802bfc55c4a7c56af2e05cd3a3982a98902d5dae8d2d7119b4835549a7c43266e6814c966b1d32da6d631cf2c466b742bd9300359a9ca810022241a10476a08f33651852ad18516cb5861ad91a681a4761570353c4e91ba4b8068c6bcd6e32c55ddc4e6c4f20f8860d3c911628af7d4866066156bc54b9a38ad95179526f6f25a6f6205e59251cdae5fa9768e3486de3bc863fb77e97535491f94d7b1544d48bbe9f76ebb4cf6a29a836830056ce236778f9dfa96cae2cf759619dba64612d71c082471d582f7feb77fe53df3fe155c731419e23f995ecfb4bf873e7e3f20adc3488cd0b31a28980a296910080e1da811602881100815630204a204a140b558d205942158053472b5a2839a082be6a82010080402010080402010080402010081401a86ac02c2bdd7a6e0864e8cdb2f6d19e26100d3cc34494f172c715f3ff61eaf17a0ed77c27b28c970d54ad17cf7d24ed524b180707d68e0de48d351b65127a6e15afcc382a16db6c05ef0c0e0e3c0f0571357b0d9c71b3c31d5c78f15d639d4a8c0634bdb5041c4954976c710280d315b2b13193e9750f85c73aff355a9a9308d4d25d88a700b5803981e3c24118808197ca0bb1751c3915583a696060e20e6400981a3135eed41c4f2c95631dfa71b9a5a1c0d39a9d1cfdb3680500a713c55ca8b55f7bb718da686a2b5f8ab913aa0beb1ab0d0548caa54c6d8c9ef11fed33d3686b2a63b88fb0e4bbf2e1d473b4564d36cf6eb9addb589e062f15ad0fc174d734cb4dfe2dbafcc0f946879346b8654e1a94decfebb57f67ed9f426fd7cedff74db45dc8d148eda4a886a7e7d2d22bf15e6ebdfa93e1eaf3f357758fb31edbef76124563043b36eac044125b10d01ff287b09a16bbb02787efd97e55dfe9debf0f96b7dd9afb65ddaeb6bbe606dd5a3cc72341c2a3223b0afd079faebe7f7e762050aed53c8a2c09428052a144051014c6a8128b021405101440b458c144088040944ad2051422014d0945ad1e141017cd5040201008040201008040201008040201015283e9bf6aec6d6ffdac8e76c7e936073daf98d0d5c2b52476e0be7fbc7a3ce9fdb5ce8df489b46b46903b39e2bc3d47d0f3eb5776f3963f4bb3cdc392877b1711d8493b2adf08cea3e60b625696566226860a0d3c7b55c455bdbc4f91a03497d3323815da39d4a82d1c1e448050e25c4ae9226d249142d9454d01c804c4ed217c4c663e2fd55c56b4d37753473637529811869fc73486183b93855923e8ee00725d241c1be6b63073ee558e76a432ea0734191fa7b324c4fda9ab8dfac633a18439c0d08c30434d3779b6757c40bdd8d3b1662b5322dde0690d2e0fa67d892a2ca7db796d3821952d1976aeb2a72abaf2c9a5b5d35d59762cc6cac1f525bc9138b6a7d37386bc33032552b9f50c6c4ea6e02874b8f85b5e6451a7fd2e5d1cf0ec3d336f7bbd7dd5e38ffc77ea8e01fed927ea5c7baefc46cf72dc6eec7697b36f0dfba7d1b06bc839dc5d4e4b87a5ff000efe73e75e25bdd9f526cbbb365dc2e1d2bae2b2b2e1a4e924f0c72f82f9ded3a9f31f77f56f9f5322abde8b08ef2c766ea58d803a767db5d380c4b99e52eed5fa2ffcaf6fbcff0067e7bff47cbe9d7c3caa857d897e5f3ae67c115302c05131a28980a26044c02968a041cac020558c0811008058d72b01458114d08b5a288202f9aa0804020100804020100804020100804020118f79f612f9e7a6376b2323dfae66910baa230d200a8a6788e0bc9efcbb715acdc2166dee61f53f70b8c4f6f0d2d6d757c6abc3e91ecf1e9336f35780eae91f3f35e77b35aedb9ce6678d4784f20b6312672da6a95e469c4358295fc5544bab6dfa87d387c0d18e976155d6567d0f8ea060928f703fe2baca8bcb9b9de63003cf9410011daba623151b9f510b701ec3469cabc5315222dfef8f8a06cd151d1c8435ce1c1c5244d3037d8591fab34942d1892730bac8e76b2bbbfbb763b7873223ea4adc9a16e39eb3575eee5cde91e96a63799a84c6bab6ea4dc2e4b1f6f27aad69064d24d6aeefe4a469b6fbede5d1b67209072c3822969149bc4529700ea3f306a567d55ad46cf7770cd2413a4e0e69ae6b515ab80b658e8e341cd7445677ac76993d16cf1b7534e2f001f2f344fe58ab4372e98476eca5e42fa869156ba33daaf538d95a558cd4fa0791578ede4b8775df8867718ae64bc83434989ad2e7e9e24ae779f95f3de7384dff00a659beeceeb4385c9f1c0e7707fd2a7d7cfe17fa7eb7cfadaf39eb9db2467b617f6376cd173b7cb1bf49193daea61debbffe6ef357ff00a3dcf49b1e0555fa59326be17308022888040201014408a541025160440ab18102201022c68a204520a29a395ad1428202f9aa08040201008040201008040201008040201231e95ecb6ff736dbf1db9d2065b5c31d89a921c3c8d601cdc6ab87b45caf45eb1dc1d0496cd748d25ee123a95398a015f8af175cbd3e55b0e98b7173671c87105b5a85e3f4f87d0e3e5a332436ec686bb538b685b44e6950ef2f0c915493e2c9a177e7946b3f77711db3cbf510e68ad2b5c3e2af9e1bf6a87b8755da86b5ed7d248f30de2bbf3c26f54dcbd4b15c6dce963716bd98918e3455f573753ca373dbaa1c7591504513ead50cfbccf6104b637c48f09d029405a32734f34b196c61f77ea7bbb90e88cda221e1af355cb9566aee789ae24032c872ad55a2c88136ed7111a0d351981c95488bd275875def36513a385b086babe22c35c7b53e9117d5776bee6759450b1ac746e880f08d0310ecb8acfa3a73e8d5ec5eeb754970373b44972c6f189aeff10b9dd76d8f49e9ceb1b7dcc35ce63addfc627b5cd7d7b8851f2cf87a0ed726a00d7f1c7f82e92b955dcf136589adce998543273ed5fd377365d322f007697e14a05713a6f7a89f15e452c2d0e888f50b879579fd5e8e2c524fd7fb55a4afb46c8d7ddb307918803960b95f5759faf6a45af545bcc5a1b200e38e09fdb2fe4efc2ff2a7f7a3449d03b8df01432c71c521e6e0ecd7b7f4f99af37b5c8f96cafd04f98f9ffc928501408000204402c01405149a44342969288058d080408811601022c029a11601057af9eb0804020100804020100804020100804020118b3e9dddee769de2defada411cb1b880f201003869381078151d4d547a97535ecd35a4776492c6b2371c286a1792cd7a38b8f5cb32fe98e93daef3796fd9457f035d03e473457500eceb46d1ae078af377e1af571ed233b75eeaf4dd9dc48c6cec9e9e16b81f09ed5d39fd5475fb319ddd7ddddb5d239f048187e9cd7a39f1c70ebdd97dc3dc58ae647bdd70ef10a5030e4ba4f273bef55137595abab492435cf481fe2ae709bef4d47d6cd858e6c6d91c1de605c9f43fbaacf6cf77771dbc08e0b58dd18c83c7f34fa1fdd5ebdd27bb74a7b83b5697334ee1037fe531f4d40bb8c7dca7ae5d7cfbd796fb87ede6e7b4ef019b7b1f3dbc80bd8312411dca2475ac63f6bdf0b831b672ba5fa5ad35039ab9518b1b0e87ea4bc0c732c5e0c7816bc86d7f1552b3e8b9b0f683a8ae2702e228eca004032ccf6e15fd22a567d997ca3da363e89b28a28191c62564218cab9b5c464714fb2f9e646e6cf6886d632d6b40ae62945358971ed76a4091d182f3897635fc54d66a55bdbb223e06e91d8b04d6cb230549a8e2aa083ba5fb445a1d93850838add65e50b6d95b2d8343807d1c63771c973ea6af9647a8bda6d8ef2e1d7db64cedbafa57ea94925f1b8f71269f051fd31e9f3fd8fa98ff00c0aeb646b26965f51c3370e2a3af2917d7bfd8beedc4d9bda5dc4c7ff6bd3738773857f8af77e9fe5e2f77caae0bef73f8780570ff0015a12850080a628395204029051022909428168b14440204a2045204053920453414580c3920ae5f3d61008040201008, N''VinaPhone cung cấp iPhone 4_small'', NULL, ''077b972f-1a51-415e-b48a-19f39219d165'')')
EXEC(N'DECLARE @pv binary(16)
'+N'SELECT @pv=TEXTPTR([PictureContent]) FROM [dbo].[Picture] WHERE [PictureId]=''47ab4927-e482-4285-9336-49eedf21f6ec''
UPDATETEXT [dbo].[Picture].[PictureContent] @pv NULL NULL 0x04020100804020100804122cad1f777905ac63c73c8c8dbdef340a7aeb26b665b91f57f4e7f6f5ed749b545677d04f36e623065dc1b33d87d43c437568fc97cdbfb5d6be875faf273b8c07ba7d197dd1d0b2392f05f58b8d18f228f6b7e56bc73ed0baf977af3fa7363cf6f7ac375ea6805af526f9766c76d808daad855ec6ba807a60773462bd9f48f3fdeab99d3acbfbb30ecd33aea365bfad2ba56866923cecc3e956951bb0716e4ead0a18282b540115cd3475c1028a5106e3d97dd4edfee0eda1ce221b9718246f03a8507e6a3b74f17d45bd6d2c9a60ed20c91383a3229520e6179f5ebb14b7364d86de496d6d5ae9cbbf75a451c47e954c9cd5541bd6c55f4ee6dcc4e18381e07bb353b5d670b8b0b9e9a9240f6442a3e6a725b2b9f5c569adafed8b7fe3b6839d00c95cc71bc54b8ded755df825525463c38a9a1c6be219a1859a46b4638b1dc56ea549bd9639cd7134607692465dea55d3bd9600d64b6cd38905ecef19fe2aa3257267918f7177871c69cd46aec94eefb2b27b1b7898753dc2b8a8ebe57cfc325ee5c2d1edbeeb699d61d4f2de0757f92f47eb5b2b97abe4f95a18f730b68e6e041ff25fa1e7f0f0d73adda748c96a75c550d08684349452d2205a290880a052d2a0e685634516508804094581102ac0840408b0082b97ce584020100804020100804020100804020105d74ab5eddde0ba0f6305ab84ba9f978710b97acff575f0b277f2f58db3dcddeb69dc66bb7ccfb9b794d5f13dd534f94b17c4be76f4fd47d39eb83fee4f58da753f488960935bda5ae76bc5c1a3e5ee5edf0e2caf89fb163c6ac6f596ae90ba06cc1edd243b0d35e545f4a3e654fde77f82eb72fbbda2cdbb344e8844f820274923ce6a493e25a294826b5e39a010083aa840ad6d4674417fedfb98deb4d94b8f87eea2069dae51dba78bed09ece3aea6bbc74ad7b42f33d867d363dd47b45789c8add46d576e9d2fb45eb1ee9a0687e6256e0efc42dc6fdeaa19d110c13074372f6c6720ea1aadfab7ed57965b60b56e9136a0a59b568268236b5b88f82bd6e1b96f99e56bc7771516988eedc0b6b5703876a69f574cbc748ca929a9b15b71e3bb77ee1f134686135009fa82d4f49f04d241b835f431b6a050f021544c48de648a181d2e9320aeb731b8ba9c9477f0be2eb8d95cf98fdd5dc5e9308a44c7700a39f95757143eea4d6bb7f42ef17228e716021a4d6a5cec060bd7e1cffb38fad7c8f7370fb89e495f40f79a90dc31f82fbd3f0f1754d516b094280a20440b452a734c102a91ca0552a73e24616a95a451427140880405102d160e6850145812850572f9cb0804020100804020100804020100804020ed923984d0e7985966967cb796a19b8ec36f711d43d8d10cc73a5325e0f5e24afb5fabfb17eb8ac95b7562c92d651fb5264ee0485dbcf1e3f4f98a1781535ef5e9783f9701685142800c2e3e169239a34e4b6ee60ad090333da819a230a827f4fdc9b5df36fb9153e8dc46ff000f63b259d457372bee28a675cc514cc610c9580d0e19b6abcdd47bbf835711912eb69c3e71c94c6eb832bead6b5b50e57187446d2030f842dd61ad14786920f6ac6a1df45710bb535d56f79295a82eb96d4ba46e978cfb14511dd7e431cf041a1a693c421522daedae8ce935233056e20e471366797b7070e270ad15728e8f5dcb33c0754781fe5ccf7e0aaa61ebc92f67861759d1d26bc41fa792e5dfcba71874dcdf07b1f2dbb9c23c9ad3e1513e15d63cd3fb87ea08a2e96b3db23f04fb84da9ec1810c8b9f7b97d2fd2e37e6bcbef5f3b380aafb31e4e7e7f210255022028100b1bae6850d0a71a28a422342960a1408b0d1458a728040a805812a56044057b1056af9cb080402010080402010080402010080402002d90ad9fb6b7d13b79876ab815b6bc7e9ccd2abcdedcbd1e36b47d436747cd6ef88b74389692320170f3e9ecef9f879bcd512b9a79af64af999f2e15a40c32417164f6360606815f9b04692f84afb63a4531a941507346040f5a49e9dcc1265a646bbf07274a9f97de3617717f43dba606a668185839d5abcbd3dbfc2ab7a8ef9b492361637e6241c93192a15a6f316bd1727d3757c35c2ab35d24583a72e2d7c635b0799c4e5f826b31d7aacd41d5afd3da9a63a9258a466870f8aaa296f6de3d27d2707807c59e0a68a999a43b539b837cd4c564654ddb636b83defd5879a838ad4acadc9730c4706b7269f32ae51d189a4ff0091318c53c2050618957d262c76db8645231c0ea6d6952325c7fe2de56bb8de58436525dba411b631ade4e0d0dfd4aa73f6557c89ee4756c9d4bd4b35d8a8b486b15a34e5a01a977c57ddfd5f2c8f27a5d650f9a831ed5ea91c61163094405102201008395354550128942290b541ca038a950a202982044029094408816850562f9cb080402010080402010080402010080402016cac6cbdade97ea9df3aa6d1db0591bb96ca46cb3171d31b5a33d44ae5e95dfcf5f546fbed049ba5b06bdf15b4f2b0eb26a4027b978e4c7a7aeed8f2ade3fb4beaef55f2d86e9692b4e2c8e56c8c71f8d085e8e3b79af0f30eacf6bbae3a55e7fabed72b201fff006a206584f73db97c42eb3a73bcb2a43730411de053f1fe4ab627ea916d75e88f10ab4e5d8b4c752dfc8f6398052b81586a2d02d60a202a6a0f1197c0d53f31b3f2fb6fdb6dd2c6ff0064db0b1dea456d6b1b4938f883710bc7d5f97bff0086eafaf2075b9d6d0e1a722175c73bf9607a8e1db7712d8e2a3272ea163702a2c76cb8ce4f2efdb10abd86eecbe77b01d4d1fa8159d454b16bb4eff6977107412071af8c3b31f82994b1672991cc0e02a3e6e1455a9c302e216bfd27822b99589ba8d7764d05cf8ce0fceaab1368dbe0918df49cfa93e214a60162752844f0c2f70a4ce381ec55116ba8744af91efc096d70e6dfe6ad3aa9ea2dc5f06c1b8dfdab8367b785d246ca938b732e5939fb5f974df87cf1bffb97d53bdd97d9dc5c98e077fbac8fc3abbcd2abeb78fea7327c479afb5d651c4fe60fe0bddcccfc38da0e2b58458c2205581288110050140b2b74505145348b2b5ca902d029a11637421a0a34514e8440204a205a9e7f914156be72c20100804020100804020100804020100805847d67fdbecdb3ecbd056f3c0dadd5e39ceba943751d5aa9a49e4bcbebd7cbdbe5c3d5e1df59732ea0ef0b726ae17a5de1710debfc24001a7203257ca2a4c8cb4ba63a3998d91aef335c0107bc15b3a4e323be7b2ded96f6f32ddec56e267673420c2efc585aae75518f3cea5fed2fa4ae627bf62beb8db6e0f95929f5e33f89d4ba4f465e5e0bd79ed175af463dcedd2d0cb624d23dc2deaf88f6bb8b5749d39df362f0e06a3f1f8023056e63820127e196fcbea6f61a677fe1f1c8e387a840f80a2f175f97d3f39b1ea535c3a5b67b6b4769c3bd7595cfa9f2f38e9ae9ebfb2dda6bcdcafdd72e7c87d3611955d4192dc75ebbf86fa4114b151cc04118838e1dbcd6df971dc64b78e99dbccaeb8b390dadc3457533004ffa7cbf92e1d72e9cf6810f506e1b7cf1db6f0cadb3bc97ada9638f277d2b57ababa64570d0f6bfc0478646a26d46b5ba91b3bed6771736b40e1fc525458b330b75fac5b806e8c30fe0ba48e56958c603e9b5e753c50171c2ab1848dd23232c0cd4c234d7cb4fa4ab45673a961747d3fbab3d321cfb695a4378d5b52abce7fb373e1f2e39a43a84789a6945f7fceffabc57f24ef56d08041ca0552c0812881100b283828a11655128a422da0514220102d114453414408804054f34156be72c201008040201008040201008040201008041b8f6ff00dd2de7a4b55b4444db7c86af85dc0f30b8f7e72bd3e7eb8f5ab2f752cf7285b35a4ad8e4779d95a51783d38b1ece3d79e9add8bdcaba7698e677969f9f159c75d2baf097f0dfecfd5115d86907c4730af9edc3ae1a18774661ab11daba7d9cfe87e7be6363d44d41e20e2aa589fad4096ef6fbd85f6d751b27824149229007348ed057483c37dcdfedaac2f44fbaf473c5b4e7c526d8f3585c7f4124961ec573b72bc3e73ddf66dd367bd7d86e96cfb3bb8cf8a29453f0e6dee5d274e77943a2acf8467cbe9bf61eea31d0b1834f0caeef5e2f5f8afa5e17e1e98c2e96a464725bcd3d232dd4715d6cf7cc71d4e86e4b5cd70380a1ad1768f3db5c8ea27c7060ff00f7016eaad695c8a9c54baa5dfb78bd30b7eddc239e9e626ad70f8acb0bf0a1dbbad61944bb76e1fee6ad2f691e123552a6a98d9db57d2f70f81d25948e32db368eb790e346bb83bb94d8ad4fbb8832fa0bb81baa9feeb4934ee53236d5dd59187e8c4ba8434927c41b53f8aeb1c6a30607dc090821aea38c7c0119d16b0ebe4998e24032b640185a7224646bc11881bfc425da2f5a2ae73e17785a7896e4ab8bf2dfe1f295f1636e5f1b4105ae21dfea0bef78cff578bf946a2ea110250a274510d0b02260558d25057b1022ca051472a5410144a1145051014407058d2201634880280af620ab5f3961008040201008040201008040201008040242b41d17d17bcf576f916d3b5b01964a19257792367d4e2a3bef17cf3afa036cfed336a65b37ee77eba1754ac8e89ad8e3ff00d3a812bcf7d75e9e789cb5d61fdbaf4dc333659f77dc26958cd2ea3d8c69a7700b963aff00758da6d7ed86c7b7c6d75bcf720fd4e96aa79f34f5e87372d8b718212eb397d60df90e0e5b7839ed88feb7bd4576e8a404b41f23b02a7976eb1a2db7700e7073c52abbf3d3cfd468ade7616b4b08ec088d52f58f4074a759d9bad778b51eb1148aea3149633cc3850fc154a58f9c3aeffb6deb4d86496e36561deb6e1e26fa74170c1c9d1f1f82ef3d1caf2b4f66efae76eb19f6cbe8e4b79a296be94cd31b9a0f369ff35e3f6bf2f678c7b4d9dd558c2dca9559cd6fa439bf593375d9a48410646b7d48eb9d4722bbf35e6b1e550931ce6199ce1039a19a88ad1c3255ade79556e7b98b764ae9e5606105a0b9c281ade22bcd34eb9612f7a99973ba39f082d6483c4ed21c09ad69538e9ed5b8e6f53e8df5e42d99b37a8d2006d0d6b51535f829b151be82d9efb22e06ae71ac6efd7c9cb31bab08a46cb131c1875b58d73e838b450ad602ef5adb4440b5d1b896b8e65a730b58ee3f4087386b0f2316e1a518af9cd2da731b6874b9d434cf4aae3f2dfe1f276f153b9dd9779bd57134047cd45f7fc7fe2f0ff287dcba345100892200a04a205a2969385102516508a284a29512850094267d8a2810080580a20458a1440880c5055af9cb08040201008040201008040201008040b440516d1f4f7f6ddb6ed7b7f4a4bbad5a6faf2477a8e3f2b1b93715f3ff0063bf97afc79d7b65aee4dd25daf3ca8bcf3a74bc52b7798237974afa0e44aeb2b3eb4f1ea1824205bc951d857a39ae5d44bb7bc6c82ba8579aae99cabb7fe9bb3dd63d51fecdd0f24ad1427fc171bcbb4eabcfae6e6fb69bcfb3be67a6fad1921ae87f715ceafe16f65bdbcd34d55cedcef0d0596e2d9684d43b2d4ba4b1157d6b741cd6b5c711c064b230c6efd39b16ef18fbab56199a2acb86802463bb1c28e5b79957cf763237bd397db457133598f2cc06207eaa2e3f5c76fb4a7f6f7326018e612d2281c0d082baf35cba9fe1e31ee1f4975f0ea496cf662c1b6cc7d564cec28ba637639e9df66b53a3baea0ba7de48d21de90a86547614c66b59b97b71d3b7369ff1ecd904ad1a416b406d3e09a8c45e92b76595ecb6a5cd752a4358294a0d21c3e09a9d6a889e383d4b6783116574d46a0ee694e5376792601ad94f880275f0c7348ab132dadb5bcf8a8e70aba84101cb521d13217bcc8c2fa0c69801f82dc4a8ef816dbddcf19f2c6ea35e69c28ab8ff0091d7e1f2aeeb23e5dc6e6579d45d23b1196755f7fc7fe2f1f5f9445d13a10d080a040502044029691300b02514508a54452059a108aac0880402c02045868434531ec4512a82ad7ce5840201008040201008040201008168813f2079a05ffaa5414027e46efdbceaebddbdb26db14c581ee2f886609398a2f1fbf96fcbd9e1dbd2b6bf73b78b7a32621ed0684d578a47d0bca6df7b8325ec65b42d272702bac8e3d45bf4c754890063a4c79af4735e7ee3d0b6fdd240d696bc381cd55ae2bfb5de069c4e2b315aef74daf6cdf2d1d6d76cad45639066d3d842cbcb674c35e74dee9b34ba5c4cb687c938ce9fa973faba5eddc37571152a1cf8ce4e6e207e0b516341b56e7a8e827491912aa56d8d2d9de46e003e809e2aa573ab111b24616901cc7605a71056cf967db19addb67fe9d28b88195b7762efd29785ceb5077866ab2178d1a8346385705488acb7b8b5786870d4e39b5c8e923a7b62119656ad3f92c319cb8b230ee0d9ed18cd61c1da72c4e6d7226c48b112da4c19346444ea34122ad1abb73c16d4f2b6b701a0bf4d1b521d43a9a01c922aa6db86c308f01a1ca9c56a69bdd246b6221cc7ea764e04ff0082a432f78c371653c5520c8c700062e59c5ff65751f326eb1865d3dd4d35710e69fa83a857e83c6ffabc9dc42a2eae62880a20440202880a2c51101452c72a684515428a472a4081101976a01601014e4b02203851142850552f9cb080402010080402010080402016c8cd4dda76cbbdd772b5db6cd9aeeaee56c50b79b9e68a7ab8a91f55f497f6add0bb7d9433f514d3eeb7ee6d658db218206bbe96b5b490ff00ee5e7beb5da79c5cef5fdb4fb53b8db965a59cdb6cfa7c1716d33dd43fe995cf6fe4a7fb3a6fd797897567f6bdee16d324b2ed11c7be5883fb6e81c193d3f542fcff00f492bb4f445e1e5f75b7ef7d3fb9b197b693585ec2ed5e95c46e8dd5e54767f82bd9513637bd2f15f75c6e116ddb4d8bc5f3bfdf941a42c1f538af175e363e8f1efad3f537b01d7db6db9bcb6be82e1d1f9a18cb83bf35bcde67e5cfd3d2ff000c15beff00bfec17c2df7689f0babe635a1ee5d7eb3f871fbdbf97a5f4dfb88ff499aa40f8ce4e05455491badb3ada29c81a803cd56b31b0daba86365097d41ed4f96e46a6daf6d6f63d274b9aec0b4e354498b9e94daee460d7c35ffe325a3f0ad1663755573d15f6e0496570e7399f2c98acc569a65c5cdabf44ed23f5225696fbc4b10c482de6aa7c26c4f6eef04d086c82ad7798157a9fc197d9c4627359e2b778a533c16e1ac25c5b3ac2f26b7a1cfc0e3cbe2b9f55db8e9d19eadd3522be63860566b691a1cf8c4a181c6b5701e6242a4a24770e6cb2dbc80c95797b4e20e93c2851922df6f9aaff000803406b4c74a6a6f721536791861ac6348fa49ffe95511aa4ddae656d935a4bc3e43e27020d07c56d6216d0d89f701a012d68e3dbdaa65f974ea3e7cf70b6876d9d4dba593b111cc648b0c743f15f77f53ad9f2f17a328bd56390581568e5014280402c34102886914b5ca9a11455052129829088040880580081012b008ac080aa0aa5f3961008040201008040201008169f0efed41e81d1fec67b85d576c2f2cac45ad8bb165d5e3bd163c7e8a82e77e0b9df58e93cebd1fdb8f613acba5faef6fdcf798ade5b0b60f904f6d2894364028da8c0ae3e9e9f0ebcf0fa223dc18cab1f2698c6389a0fcd799d7eab086f2d6503c63f8aa9d27fad31ac05ba9b895ba2a7a8fa6f60dfec24b3df6c22beb72df2ccdd447fa5de66fc0adfbb3eac7744ec9d0fd0aeb8b1dae311b247eafdc76a7d39126a54f3eb7afcabfaec6c8cb637b521d5d4bbc91cfa603af3da6dbb798652d8db235e2a47169ec2315ac7cedd49d0bd41d1978f9191c936d873343a9a1566b753f63de21998d21fa5e7235a8ee5cf17adaecbd4571016b253560f2bcaad4d8deecbd49247a5c0f7ac63d0b66ea3b4bd6358e7524398282f0440e2dc41c884350376b26496e6ad048418c9ae5b0ce6179a63829562546e91d16918d322aa5462f36ab83e869767c8ab951557d4fb38b981b750125cccd9cc2cea379acd436ee7bb43d9414d4c7732b2475d4bb731b612184873b8b85349552234b2d9baf21d6001335ae7b4d287c3c3e298d371b9f246c2c2185a3c8ec1de1cc6a0981996e9a1af275b493a435c413abb28aa473eaaaf78b82f6470b0e4299d71f828eeaf89a9760c113e30d35c054d0f15c7f975b1e73ef974cfefc1bcc5e6bb6b607d7eb61ad6bda17d3fd6f7c793d3978acb03e2716bc6970cbb57d6f3f5d794daed6055212881507280580e08114b5ca9a0a28aa270520ee5239280581102d1022028b01445110082a97ce5840201008040201008040246c6cfda1d9edb78f70b68b4ba8c4b6e25f5258c8a82d8c5715cbdfac9f0bf392d7dcb0cb1b630c6d18e68a02dc0d3e0bc9af4fd8fc76e1eec50fb38bcdaed678cb668dae69cff00e82cb193b53cdd3cd8abf673be270c9af25cdfc4d4ae763b4ee1817bbc6dce3f72c26319c8cf10fc95ea721ebdeafb566df23dce048189ae014de9b387876ebd7fb69ea17b9cf3a0baa1f55be717dd6eba7bad36e7c6c2d9aa0e46b92ed7979eb6767bec12e9a3bc27023057a8b1dded85a6e91ba036edba32d1a185b5a9770eca76ae9ca2d78fefdfdb96e305f5c3adae596d2d7d58e18bc4dd27f0c96de553a555bf49ef5b68f42fc6b2dc9e2a172bcbacb16760e75a1a484fa67f25a968768de628ee9add54af94f353acfad7a66d1bed630c99d87072a94bcad5d7b13d98905bcd6a2b21d4fb6b01fb9849fd2a3b98ae69bda2e3d4b7c41d5c42ce6b6a6b6e8c2ed75a0e4ad16278bc6b9b8e2d76144d319dbcb770b87d01f4bccd75722a9a8f6e6e5ef7b24c7512585a2b4d3f573af620efd7f4e27b219409a2a831b8e22b977d16a7502594114f55b1b6a4b9a412439d98d27e54351e4bd85b186e01cdf0b5e400b75326a9a2903a43234f803a807cddebcfe9d3d3c738d1d9873b417602b4af6059d5548a3f7924b01d0ae1391eb7ad18b46fcdaf8fe0d5dbc9e7f57cff00b8c0db884398dfdc60a93cd7d4f0ef3f2f0d8a3208cc508cc2fa9cf5f69f0922dc685340b700530140b0215810a96908534229b1445200b2c08429a11602880408100b02551ba5a23453bd054af9cb080402010080402010083b00134e7f1fe0b2b798f4ff0060f6ddd5bd7505ec5633be38e1968f113cb0170a79802170f7bf0ebe3cfcbea5b683ab653a9964620ec9f338300f86257971e9f85ac56fd476f0092edd089066c612987c2247d610894c32d04a0d1cd2b7eccbe6b28776b299be600f25a8b2ab379ea1b2b2b771d6d2da62dae0a3b75f38f10eabea38ef2ee782d2431b266f85a0e00ace7cf5e8bf0f25dce292da67473d491e57735e9e78c70eeb8db7ab6e2c25a12e0cef578e1af47e98f724f818e9469e6565e597a6ba3f7a373daf78b3b4da0c724f351b712bda5ec0c39920106aaf9e9179d7a46ddd42db96b5d2c86595f5739ef35353deb7ec62de7b3b3be8c365883eb99a5560ce6e7d076b3b0985c5aefa54de552b11bcf4edfed2f3210e746cc4380e0a7eaed3a87b65eaa9e39191cafab6b4cf22a5b636f63bec5238303890554ae5626cd248637b1de28dfe576744bf29fc29ed66920be2cc4b0f052a8b5b9883e32ec68de1d8ad26a39ff68349a532282beeddeb4cc76b3a4b698735b295cc2ebab6b66e8716cb18f09ce81aea1cd5c8e76aa778dc36f92564914c1b2789cd93301c7e57d1319aa89b79b578716bff007e2a7af3025f4af2387e754c6eabaef7537bfb508d2cd58fd47b6b92e3d74f4f9f09d62d634b0b3170f0d7fc571b75dacc689b7b6d656e6f2ea511c4c6ea2f7e0037b55f3ceb9f5d63c2bdc1ebd93a8f76023246db685cdb56f179a50c9f15ebe3878bd3b66a09dc1e34907e2bb5ae1618dc2c9c099a21e1f9c725f43f5fdb3f29c40a0ff25edd6128b414e6b0220558394038286914d0945954e4a8025028a128b022010144087058110294516a7920a85f39610080402010080402da1fb2b496eeee0b5845669e46c51b79971d23f35368fb5fdaaf657a2ba5b6b8269a08b70de646b5d717770c6be8e77cb16aa86b473a2f2f5e96bd138af4a63ed61691186b58300d0001f80517ad573f0e5dbb5a34535807ea381aac3eb545bc7525b7a4f8ead2ea66157c1397906f1b8cd733486d0d6e58efdb1f52f3f5cd7b79b2aa76eebcdc9933ec9ed314b18fdc6c983c772de653ae7945df7a8aee48f4c87cf81c574bcb9fe3f0c26ed76e8efe17b6ba0e6ba71f0ddd4f92c6df7089ac93e6ca4e2175466b27bff4e4d6b1c8451ec60a878495cfae598b2bc9ade7610f2d603e25d6c793ecd9edbb9d8c579ea4728b97c86af95c31680b8de5d79e9e99d3bd4b2c8f8e3d646ac9d5c92c6bd6fa7b7bbcb4633d71ea308f328b6b71b9b2b9b1bc88385351cc05bf7acfa99dd368b2b8b7731f47348a10556b1e0bd7dd3f7db1ddbaead1a5f68e35240f29518efcf5aafe9deaeb9d71191a5ac07c4b1b63d8365bf8eea20d3e570f0ad8e3dc357b03639093816f159d3384d88196c848d755c30216caaea204919aea73a839724b5314fbcdf45b6c2db873756b751a064ab8677ac86e5d74cf42e2363c9bc738c70b438d28e352577c7167775bfbbb27b6489cc6faa2b2b1c400d769a9cf9a9ad9f289b78dcf722c99d1ba28da2b255c493f4d0643e0a2f6efcf9b4d1c3e8c2da0a90285b864bc97aff2f579cc4fb7bb8ade275d5c3db0dab1b5965711a47605bcf36fe19e9dc7967b89ee3c9bf4c2cec8187698708db5f1c9fa9ffc97b39e31e1ebbb58a8a42732787e4bd11e7e932dc80473e68d59b256101dcf30ae566224fb7325f14674bbe95eae3deb9e2b6489f1bcb5e0d57bb8f594739aac1ca6c02cd60a0a27da042a1a14d08b2adcd1402812b348a29a11ae500560020438e6804050ac345021aa95f39d420100804020100805b44adb2ecda6e16b74df35bcb1c807fa1da94dfc363ebbe9ceb7fb881b39792d310798c6641e0be73dfb0dee9ee9da7a7208a6d2f6e61de1fc89aab9ca71e67bff00ba7bace5ecb69c868c43c1382dfaba713516cbdcebe981fb87d5c73754aafa9d4c5a6cdbdc335d3656c9435ae7c56ce751b8d45cc1b46e76cf9e52db7dce0697325230900e04a5e7172b01b95c09a3d719aad9ceb3aaaddead1b26d3ea814980aaacc39aabdab7e7c5188a46971c9846649c829746c64f6ef79936e64bb9b9d6a6ed81f1b695f09e754d71efa65370f67b70a97d9dd3240726bb05dbeef1f5ca827e8fea5da2ec31f6
UPDATETEXT [dbo].[Picture].[PictureContent] @pv NULL NULL 0xee76bc2ac05cd3f82cb5bcc6b7618b7bdbdcc6df5bb98df95fc1658e91ea1b47554cc8d8d90558dc2ab958a8d66d5d5906a1a64d0ffa6b453abc6921ea1f5a3a39e31ed552a2c42bd3'
+N'1dcb5d1cad1231dc08a846663cefab3a745b56681a2369350d02945357cf695d21bfbd9035ae77fb78627153aaea3d02e2417568c95a33cd5cf971fc1ad95e2399d0ea25a72079ace6aba4db8b31ea16114d7c55d898f3ff00752d6e19d13b84915755b11202330066b788aedf3ac1baee371781964d2667f847cc48f8d574fb6394e35e8fd37d1d7f7328bddf6432ce402d81c4968d380c02e7d76be7cdb9658c16d17a70b435a003cab4c82e3d57a39f852ef77d65b65b3eeef6411b00c3fd5c837372c9c7d8ebbc792f55759ddeec4411d62b361f0400e63ea785ebf3e3ebf9787d3d19b6d4baaec49e2bbe3969f8b35a26c64d39207a17bb52a825b64a635cf20a7e62309296b99e368d3cf8ab9e96188a6ced5f511c9a491500ff0005db8fd9bfc988d358cf11a169239b715ede3df9fe4c3461940ae93a7b957f772cc7070a54539aa9d43010b184534215956e54054a972a281144a2028b02202881020e96029d8829d7ce750804020100804020101541ed1d13b85cddf4cda4d6af22e2d6b19a1c70c9793ae72bd1cf4d4c769b1f525bcb6db85b321dcdadf0cad1a493df82be22fed5e637fb349b7ee13d9b35509a39a713f05cbbeb1e9f18abbedaef6c9c259229216bc55bad8e683dda94f1eaede9c425b6f32c2e1a490e1990baf35c2f2d3c17fb96e5b548eb7bad770d1e284e0ed278aceab371036edd0b19e84f810686a928b1dc37bb1166e8ce356d1a39abdd3141d393dbc1be58dcdc3755b4570c7bda72a0c973ef611f4fdcee1b7eff00b60631c08d3481fc885cbef5cbbe5877c134376609016bda78e4175e7a951d45bd96d26e1c18e779f2a6345d351235161edbb2e748b9aba239d689f61a5b4f6cba76de2a18c393e0d633acfa1238899b6f3e991952aa723a7d991b3bebab37fa7704ea67152dd6bb62dfa2b96e938b87053b4bf2b1dc2c997711639ba81c39aa73c79fee5b2dded376668a326107510173eb975e3ad6cfa477d64f0189e2808c2bcd6f3d633be52ae593c576d2dc0135a85b8969e0a4b146e7788f12baf3f29bf083d43b15beebb25fedee146dcc6e8ebc89e2b6eb2578f6c9d0161b04a194134ecf3ca40a82b9dae91a275c5b889de8343a468ca870f89f957392badb18aea4f71b69da58eb7a8bcbd69a88a3755a0fea70c1759e6e5d7a4791750754ee9be5d9b8ba92a01a46c6e4c1d955e8e3893f0f3deed55b1a49a9c7b55d9ae761f6c7cd5a70e334841d3642e7e9e0824c6fd2ee69a24b65ad0f2c9359849a4d2da1430cb9d4b768228f73aa3b1343915cc91c61ae2437eacff8a1875b21780ed78f2aa4eab71c4ad8893aa368042a9ebd431cba0b27795ae07bd769fb553851b531fe4791deabfec98566c13487c12023b42dff00b31b80f4e5dfcb2464f207fc93fec430d9d8770186869edd5fe49fdf198e7fa0ee5427d31dc1c07f14fef87d5c1d977302a6023b091fcd3fbe37eae06d777f30630712e7014fe29fdf0fa97fa6802aeb8880ec24ff0000a6fbf2dc3f6bb3326ffba69f569207e6a2fb98edfb4da33c3591fce465081f0cd67f6d3ea69bb4db48744139131f2c72b4b6bf1c93fb69f543bab3b9b493d39dba49f2bb81ff004aefcf72a4c57b95ec150be6ba840201008040201008041e83ed5ef0eb7b996d1c469275b476ae3e91d39af6cbfd8ed6face2b8847a570d1512354f0bb58aa5ebfa961b93135d35a9f11737531fdfc171efcf5e9e3bc7aa8beda7a8ecc596f16713652da014a81dc730b85f1ae97d5e11ee47420d87707496953692795a7369e4ba71d2ad64f6dbf9ed276cb138820e345df1c6c5aee2f8ae0b6e6301a1c2af0381590d52b9feaca4389c72550d68f63b5dae5dbee22b9d5f7045607462a6a3b13f25b8b6d8baaba836390364649f6cd39bdae03f35cbae09db6ff00f9ced7bbc4d648df4aec64e387f05cf9e713d46bba4ee22b783ee257091e7ca33a2bbd62646e36deacb67696b9e1a7e0a652f29977d46c0dfdb35ae457691cec506e5bd7aa1d5f1139552d2460b74dcac8ce5b2c7a1e72ae014daa915eebd65bdc32585c1ad3db4aa635b3d8b7974b0b5ce21cdefc94eab1637d0c3751105a1d5c0aadd4f331938449b5ee8d68148cbb0e4b9f51d35b59e973691cf19c5be6ee55f6448b6d8ae62923311755c3cb45d78e93d45a8d259ccb7877abb5ce478dfb91d55b674beeaf83736bc453b0c96ce8da09791c147d355f7c7887537b95baee65f059eab1b47e0403e370e4e70cbe0ba4e1cefa6b1afd4e26a6b5cfb7bd76991cadaee38ddc42d919a90d0d6e0ab0d23a403b518e03dce38058244268168edae7573412237f8483f8a0569d6f15380cd073351ef0e1c32404c451ac69abc66103f6f039a35483f052d3f23816e5a90477ca3565a532189db6b18fa91aa8389e2b3e0c59d7c1e1c3b02c57d4c48cb87d7f79cd1fa6887d5c4704bc2790fc566b5c3ac62e2e7bc9e6e3fcd34751ed9060f734e8e3527f9aaf86078b76fedc3106b7b1a13e02c6d681ab481dd8514ce52aebcdc24925f46327e192b920916d0fa4c12bb177e054ab4924a273a5f88ed4d352181af8041763d581de590e6dee2315d38e9188bff8f5a7ff0038ceb97cabb7f618c3af32c20100804020100804020d274039c7a96de1141ead59f15cfd3f0be1f4df49864d62eb3b87697b051a4f35c3cbb9bf2ed62beeaca2dbee9ec0dabab5af30bada434f906a1234e9232a60a2d52a3aa6e59bad81b7b91591a3c2ee2b9ce2475fb3c82f76e7dadd9888c330464af59f67168d75cdd476719f39cd313a91baec9756170192b0e191016aa568bdb681cedf7569123236f8c60404e627be9a9f7221bb9f6f8840c2e8d86b2919a74ce31e63f752dbbc10710701c42876b8d2ed3d717d130c65c034705bf495caa44bd6f7a1c0b1e438666aab9f38cbd365d25ee3365d30df9008f9955988b5bb65cd8ee2c060906a3910b99ae6eba76c2fa2f4e7035f07d29fc167c1b58adf3a56ff006ed45bfbd6c7cbf504ab8aadbb74badaae016d5f0bbced24e0b9d547a4ec5bcdbdd5bb4b0f9b9ad8cea0dff6c3731096104bd9905b66b21ce9cdc5f2466d66c1f4a51728e9d49fc2d218fed2ebc326939e1c42ebcb934314a2502461a57cd55d226bcdff00b82e937efbd162f6d99aaef6a3eb603c462f9b2572b9d8f945adc68301ff0058517771ea63b6b0568463cd663257750dccd550e24909c8a6846b1c7354c3f1b00581d6b4d168e99441d80e70a37007cdd881c21ad6d1b91cca056452914030fa96075ac8e224905ee39140e324739dc820ecea3c3f141c362639c0665458d8b485c18c0d68a347253629db64a9ae4530d2ea2e187f24c341200a8fc16640b1b5de734a0e1cd3206ee2e0b5ce6834072a2ac49963ce92732724c6e19dceefedad4b479de69fe6ab1881b541aab33f000d057f8a60993c85fc74a0e63049141f04161a590b292667cdc5a1230c7fc8ecca99f056cd60543a0402010080402010080416fd29762d3a8f6fb839326697771342a3b9b17c3e8db4dc191dd5403406a3b57879975dd7570d76e6cfb8346cecc34735dfecc8a3b98e58c54b298e5c96a912216efb831dcb2a1cda035a50fc16e33eccf5b74e3370b9bc8656d216bf4b64208753b130fb2d765e8bd8ec2e7d58e33248df2972dc4ead374daedaf07a7246df4c799d4c47c5315a91b0f4fedfb738fdac01bac51c79fe29222fca75d5b42f6c8d906a69c28724b09f0f2aeb1e8c96da596f6d07fc6f33dae23c3d8b31de562438b1d50715957394cbbdaefe2dadbbab5ae368e7697b863a4ace3d35cbd3cf1566fae5a03a39086f30575cd79e74d574cf596e968e65272e6f2712a2f0a9dbd7ba77addb7d1318fa07f1aae363a4ad4b5f15dc5e3c4382cd256677ee966381b8b6c0d7cbd8ab152abf6591f673e871d127d0725122f75bfb0bd8e48995705d2573ea21ee96a61ba6dec20b5a4d5c00a2e5d4c5cbab68658af2ddaef9db876ade29626d8cef8f07e23905d35162c6b0dcb2482466a8e669639872d2730aa5458f92bdd9f6e2efa3fa8a40d693b5de3fd4b1973cbcd19ed6aed2b9f7cb04e908c1748e2e0924e081c8e2d471c90486b40cc55530adcf240a3b168758c681571a7620744d1b4015c3e5ed4032ea3d552dc102baf5ee1860a5a6fd47120d7241dfabc9531d7aa7995825588703a8e6a6b62c41f0d01c3929aa2f856071ce3a476a0e29920e279cb1b4e482331da8d4e215261e8c81e3190c914a7ba7bef6fdb1b716b303d8b52b021ad608da28d028103640a76a09568d3abd47e0c6841dc97471d23039838ff1558c37ebcbff00c416a58250ea10080402010080402010771bcc7231e0e2d35af68c52c6caf54b6eb67bbd09c10e8f4b43fbfe65c2f31da74f56e94dce3dd2089f0924bb0a0e0573b151ab9fa39cf87d5f5353dc2ae615bc96a9a4dbd96ce22481badbf505703570c6debe28618d96f2378d3cddf44a2ae5865b5b9225696c83c24703dab274cc5906c725b802849cd6e987b6a7451485970d26319114592ab0e6eceb0385ab5ed3c4bcd7f82d4b01be4f657fbf5aec37af745697048748c343a8e59a8f5eac74e0f5d7b13047307c3b8175bf2206aa2f2ff757a6348fe9fd96d3643b53e20fb62da3ab9d572fbe7e0ea7dbf2f0beace939368bc77a24bec9c7f6643cbb57bbc3d2dfcbc5ebe79f856dbb1cd70d38d325e9ae15a5d9afeeadde1cd71ad782e37974e6bd27a7baa1e74c72bb481862b975ce3a377677d6b335be20e0ec082564aa55ef3b7dbc64dc35babbb82da457437ee63281d4a64b9dae98d16d3bbc5750fa53105a3f8acbf2cb312ed75dadc3a8e0627644049f0d9f2bbb57325783e561e2ae542c238a8ed75c3802af58a8ebae91b1eade9cb8db2768f55cd26dee30d4c78e23b55f353d47c6dbe6c37db46e771b7df4663b9b57164ad38569f30fd2bd3cd79fae50db169ed4b10eea00a2ae7184122d0aca9200fc503a000683f1408811a07340a30344071581c664815a09780325b5896cb726950a7558990c65a01a61c962b1298c14af1ec5342e9c78d3b160351191a04095350de233c423506e6e0ebd233e6b52ea1ae90d68ab8e483abd9996d6ce1cbf32b444db2131c0667ffbb31a93c82d0f39c5c4d3240e411091c4bb068f3391872595cec1828d1c113a2285cf778412eec55ad3ff00673f228c79da9740804020100804020100804169b3dffa2ef4243fb4ff00c967d5baf47e80ea29769dd1b6e5e5d0cc7f6cd705cba8e9cd7d1fd3fba36e616871d4d70c0f25ce3a54fdcf6782e222ee2056ab6dc18ddc2c24b6969e5fa5e125d1cc2eb1dc2b697c7d0bb22914c7ca5475ce2907eceeb6fba304e3c1f23f20e1fa56f143ee8860e8f33985d116b895ae232c4e6ae44daa4ddfa462dc6e2da70745dc1235ec77120705cfd79d8de7a6b771bf96da20c92950df1735f33d39b2bd9e77587ddf7c7bf511427e9f994c9aed14f0986ff5db5c34490cbe663b31dcbdfe331e4f6623aaba56f36398cac6ba5dbe43fb538e03f5af5ebc9d442db775644e68a6a233598ce6b75b44d6772d058e0d93e95c7a8eb2b5368f7c2d0ed474f615322e55dedfbc432801ce05a30a1e6a2d56243b60867709da6b5cc356637506eba7374b2b8f5ed4b9f03b17460e213153ad68f6864d2318246904732985e9790c6d6349761c805b1cd631cfe105e3c2150936eef507840a7f35b2b2b13ee87b4db7f57597dd4005bef1137f66603cf5f91fc1769d22f2f94778da6fb68bf9ec2f627437703b4491bf0ffd43f4aef2eb85e101d571c12c4da718c04e2a98738d10257c2802816a10724d7b1002b540eb69441dc1fee8a2cac8bb6c6c6b438e2a564a343b3469c61395429a15d8500c00cd606e5928c35c299040cdccad82d4d7cc7f15b8cb55f6ad7cd28ae54a95522756b081532529a706ff0035314aebe26e6ed96e316d753fb950952b80cb953e0838b789d23f4028277a6e780d8c60102fa70c22b2b802336a22989f770c01b035ad2335ad42feb573f51fc5063d62c20100804020100804020101528343b36e2e731b19752684d5a5477152e3e80f6f7a8a67d9c4356af0e209e2bcf5df9f97b0ed12b6e600d7bbcd82dfc876ff0063b79edcb5cdf101e12aa44eb05bd6c32c5a9ae15a62d78e09bbf95eaae2deaeedc36dafe317300c1ae7e247c735379cfc1a75f730bc875b12c6f10ec68b66961d3149e9b642d3a5de57f05d2751161c80fee00ecebcf929eaa245bef9b3c77db7f11281e170ccaf3f5ccaf4f1d58f1dea064f6770f865043c667fcd7972caf47da21ec97edfbc6ebfe0bdbe2f37a7cb55d57e95c7485f4628e1a2a2abd31e7af08ba67db4e180e927ca4f14a8596d5bcc96cf0e0e21dc8a9b152b6fb5f5831cd1a882efa4ae563acabddab76b592e75b3c21d8d145e57f67a56c77d1be3187e0a28be696482840a7356c869d2456ee043463cd428e4576d738641df8ad61e74ba9e0870a725ba24c370d6b9a0b896f101209d15f6a2587ca7257a6311eeafb55b7f59ede6e2d40b7de606fec5c60049fa1e175e7a458f95378d9371d9b71976edc2175bddc268e63b8f68fd2bd13a79fbe51fbd53992a11a2982c09c502615a71e4811c502c789c503a05103b66cacc7881929b49172dad31516a8b424d5a01ec4d6ba0005811d5c4d4628196f8a6683886a083bacbaa46c63218b8f62e88d3f631e8b66b8105f2643b165adc499dc22667835a982bb6fabccd73f51d0d34392075e5cf7860c5c7ca11a9bea5bd9c41af702f19a0af9b7c35223c01cd188aebc1aab249573b302aefe0ab188b79751365c1c6aeec5823fdc8e67f04158b161008040201008040201008040e432ba295af0724cd35ec1eddef2dfb66398ea907162f37a4c77e2bde3a637932471d08a85914dbc53fa910c6aa90aedc606ea702016bb82e77e1d599bfe9765d03e953fd2554e851dc74aee501a46dd4c19694bd3169d2a2ea291f697711318cb562145adc5ecdb7edcd3ac4635725ba9fa99ba9626446869a87e08d799f5feda6fad9d340409e3f1369f30e49fd64e9e4db65cddb7720dc75b1d42398f8ae9ccc675d3d0b79b891dd1f7a69421807e2aed72af1fdcac64b9b57b80a3e3c8f35b2a2a8e2ba7b06990103eae4ab0d4fb091d34d432e8637893459f56ce9b0db7d48c36464a748e355cac5f3d36dd3bd5e2da46c4f793db8ae563b47ab6c7bddbdcc2dd26a4e614eb71782da2999538aac669b16258488c6a032518380d6b5da882981c8e7abb905504b60930207879aa13a3b8686e92dd47eae3f8ad94918df733db1db7acf6974b135b0ef1034fdb5cd078f4fc8fef573b73eb97ca9bc6d57bb4ee13585f42e86e6076892370a107b17ab5c2c57d426b9d380d42d6b941c941c54a076369cc2077492560b0b285d1e2050a9ad8982a466a6a8b56e18e2b0765dcd070ea807040dc06ba8d28b452ddb8beea5757007480aeb9ada2234b1a310d1453568dba5c16c4437ccfc02d63b0df42d591d69a5b4c79a0e25b96dac05f9caff002f308d52dc5dc8e71738d1a78a08beb4921a0c00fcd18b1db246075392a81bbc77ab706a283b160343b920a758a08040201008040201008040202a82e7a6f7a936fba1890d765c829eb995b3ab1ee5d11d56f71654d1873355c31db9af64d9b798ae23688c920f14d558b9ba01f0fa8382caa9509b296d54628dcd73a7e289419e7647aa46f1cd663751a5dca1737c4ec78a48cb557b8dfb446ef160700ba488b58ddc770ad5ba975e53ac075059886f997d6de1756b2372c56d88abadc773f53a5666bfc2e974b29cfb54d6d61a6ae9a13a58dfcd6c4567f73b26c726b6b4fa3273e0ae31d4db1ee9b6456f753c3ff1ee9baada706b1b872afd5d8a93565612ddba82b8725cec758d1d9412bf4b9a0972e763b4ad774fdfefb6f232310bbd2faa8571ea63a47adf4ddddc4d0b7d43de0ac96b3a91a4d2e2df09aae989d30f8cbbc247c549a8f342c6914350563522291c682840a2dd121843c8195335825452c51d4d72a54f72a1e79ef1fb6769d59b69dcf6d1a77cb765581a3099bf49ededcd76e7bae7d70f9627b59ade59219d8639a23a248dd839aee44735df9af2f5cd72d340a984283871e4166872183d43d89a2c196e1adcbc3cd35aee389b5fe49a26b3d311e47d4af669a285e10f869c7b9028cf10b074e250373ba8c344a396be901776705bc8a26bbd4b96378be4a955d27174d0054d0d06268b9eb506e34cd7f0c74ab4789cac392c8c7ca71ab19e279e7d8829f72bd324a4914a7942080d6c921a9c904a82ce591c1ad6d69c96b130c71da30869d53bbcd4f285a1b85b579271461fd4c419f52b08040201008040201008040201000906a330835bd39be4f6de99a9d0332b9f5153a7ba743f547dc40c64528a8189c335c6bd1c7cbd52c2e9f34003ce2b0a6eefd48aa48f07355f566a8ef3778c122bf985322aa9aeb7c9055a0e0ba4e516b3c3a82574ae65456ab3ea6b8bbbf95eed40e1c96a75477f726babf155cb1437f72273a1a35025554a1ef57d464364c3e185be3ed704c66a8e405ce049ad1313a59628e588b1edd41cb609bd35bd5ac3149d33bf0d7b45dbab6d72713049f53792a4d46de761dc760dc4dbc87d48c6314adc5b233eb69e4b2c5cab5d8b7f644f697b7039ae563a4af47da7ab2c668dad78008e4a3a8e9cd6f7a7b74b295be0a6392990b5a88ee0168afe483891cda1389e4b28e1cf606538a9512292af1a9d4081c6b03a5347784f0481c71f16838077054245b82d76bf116b7e5182a94af28f79bda01bcc127516c7153738856f6d5a28d95bf50fd6bace9cba8f9d3d09048e8dcd21cd3a5cd3810575d79f01b7972a62b74c3b0edf23f12683929d31611dac518a5134c76e6800d3319268464746d723db826873cb9045006878140a5e4e5f9a01c48a57140dcd42cae21a9d0666716c0f20530c13914fb68f52edd2708ff8a7558bb248889e79ac904089c191cd72712f3a183b39aa0d4f27a56c183cd262fef414da5d2cb91416b06dc1b1fa939d03e941c5cdfb4110dbb74d73a7f35ac30da8c3cc79a07a31418f154c7543cbf820a150b0804020100804020100804020100825d95c16c8195a35d9762cc1e87d07badc5bdf08f5803cd52335cbae63b716bdefa777e8a48da0bc127b5728e95ab64d14d1d09ad5748e7551b9ec16b70d739be171c8857f58abd3cff7c82e2c262c93169c9cb116b316f3037ce61cf567d88d5a4923477a6315379333c41c410b2150646416f66eba75096794f32a9159291ef91e5ce3579352b524737c3cb8fc10009a0a70c9045b98639da6370c73695bacc5e6cbd40c9acd9d39d40fa44d34db770f9a377d2e27e4ef5753f28bbc6cb7bb25e08ae994d42ad7b7163dbf5c67928b1d79e8f5b5c481a2489d8762e762e5697a73ada4b191ac98e00f3538e8f59d87ae36fbc8c0d7e25cdad45b6e904a58d268399586245c3855a62150ef994ea801e00e02a39aa63a0ea9ad30cb96281d662e0f2ec464b5a9514ae2ec4d69c33fe2b59893ae6c1aec1a707029acfac78efbafed136674bd43b1dbe3e6bdb460e3f5b3f92eb3b72bc47893a360790e1a5c3fea98ae92b9584d2dcbf34067528cae5f983cb25b815b89a9152980738614a2018f35a69f8a00135a57e28d26a3541ccd42d26b9649d311af9c196aeec192722b7656d6173cfcc50595dc9e9dbd06672ef411dac05ec8cd74443c5da9188571eaddce5b18a93f92a1263b7b7b1655ce0f7f358205c5dcd7126967979d50731401b8035d59b96b1218c6b30031e681cd2a82e91c9067942c2010080402010080402010080402055b68f5fe84d9df3edd0ee33b406167800e2bc7ebe98f479c6db6ebe8ede5681468ec532ba58dc6d3bbc2f0dac988e0ba4ae562cdfb9c6da02eaaad4d8a7ea2b28f71b32d6b46a68c0aa4e3c9a785f6bba3849810680a2c5dde0f50815010505ede3e52f8e3cffc16328dea6962dbad6d757888d4e5511548c7634a85a93bc30ee41c0a815e1da81a6e2f405c451dcc4e8e40299871cd54a7e56bb17545b9b41d3bd484c9655ff83b80c6481df4b89c4b15622a26efb65fec77747d1f6b28d50cec358e46fe82a6c5cae62820bdd25b28649c01e2a2c759d2ff00607de58dc36aeae3c0ae7d45caf52d9b7b94c6d6b8971e745c6ba48d76dbbaebd2c91da6ab2157d6e0ba87e51c39aa63a9daea001a6831345acd70f31b5a1c4d0fcd50704344530126b6953ad5a42e1232a41d5cdc5343d1481a4b4b4b9a450834a515ca9b1e37ef07b47412f516c107ebbbb16e240fa9802eb2a2f2f1070a0a664679e7c97572a323cd135cc871c02d00241c314013a40271fa7b5604180cf041cb8b78648d26bc2bc5071313a5ad0311914e9889bab88b17f727218d9db4b78e9c4d4f720997275cec1c1be221047b92628684d5ef34a0e4918e221f676f57e12bb82a8204ae7dc3bc58379adc1d88b4b68301c93077403bd630f4713dc3c20a0ecb2402a5b40a8250f2419c50b080402010080402010080402016856b1ce76968a9ec582d2cb67f508333b4fe90a3bb8de66bddfa5b6592dba4ecd85a1ad730b9bda0e4be7fa5daf679c55eed2fdb48034114cd76e226d77b6f55c2c708ce0ee6ba636495b0da372fb821e0ea1c0159115a9b169941d46a0e068bac72aa1eace9265dda996ddbfb8d15078d566b5e4fbc4171048e8dd50e19aa157b631cfbe3518114595b5d7503dafbf746300c6068f8aae5ceaa8368ec054224e0ce87041cbcd1b4a550315f1201b89aa06ae2dd933743c071e04705529561b07504764c3b36fc0dc6cd31a365f9a1773693885aca777ee9eb9d92665cc2f6dded73f8adaf198b1c3e92e1e5777acc6f353768bb63b491e2ef2b957695e95d2f7b13c35afc0ae562e74dc5bc55a39b42381a64a717ab5b1bb95a431d88195118b6639d29203b4b0e60e0b598e256b28d0d7171edc50c332075681ba0f3729aa390dd4ad25aef15390cd4eb712a3bc8d95343539356ca58b7b69e10c25d1825f810792eb2b9d787fbc9ed23ad8cbd45b2434b77f8ef2d1b8e8fd6c03f82e93a73bcbc571a8c867893518705
UPDATETEXT [dbo].[Picture].[PictureContent] @pv NULL NULL 0xda39d8e5d8e58119a2451c412502381a52b8762c1cd1d4a11820e496f014081727039a0e24c68066b1a83bd786cdc2b504516c4976a004110a643146bb6c8d75ccb8e0df0d5023036bf72f150d3489a789e6b5283348e9e5af02aa0511860a94d66b9e66bdc1356976b665fe393c2380e6a589b4683418230dbdd4cf355526aa39059ad65563a04020100804020100804020103b6f6f25c3c3183bddc965a2f2d36d644d07277353a355d17d257fd47bbb2c2d4696328eb894e4c8c66eaf32b8faf4ede5cbdd6fed5b67651dac6c059034440f764bc7baf5e63cff0079b17dc4fe1e2715eae23cfd51b5'
+N'f45b8ca242411dabad899d36bb56cceb5118ab69c68a70d6860d30b0f88772d661dbabb8c425b5ad462b35b8f24ebedb9d1b3ef59938f8a8aa5319bdb6d806c7291839d5af62dacaa5bf98497b2c8dc8bcd3b864ab973a8e4014fcd6a403435e0b0352f84619f340cd7141db70189a2c062e245695cd50e1f1b656963c07573ae2a993e52f62ea2b8d8dafb0bd8cdf74f5c6135abf1d23eb6217e13ae36c65a35bba6d323aef63948d137cf1177cb20ec5363674bfd93757c659235c4b4e545cec7695e9dd35be1b814d54073c572c74d6c228c3981d1e09869d8aedf1c8237e5cd63560d7b5cdad2879a0e9ba1d990eef464a666638d0b6b8716a8b15aee18dc478dd4a648a4cb778638890915c895bacc4e6dddab83e19292444699194a8a725b3a458f04f76bda49368925ea0d8e2326d729adcc0d15f449f9801f2aefcf4e563c8f335a800d7c598c3860bb38b9a20701af33df87f058387347341c1a1c31ff04084e34010705c7d4e0b2355dbe9a5b91c0914f8aa4d48b2223b60e35a06d4ac6a36dcc7cad71387a9212e7720102de4f5a35940d02802d4988c5315500f7e040353c02c644db4b2a69964a827267245c4daf30b1869ee15afe4823c9217babc16d6638f54720b1b8cca2820100804020100804020168956362fb979e11b7cce5368d0c16f140d0c68029c54870f88d061dab07bf7b23616d6bd252dee9acf772bbd4938d18ea34772f17b75f2f5f92df7ab8612e04d1448eddd66cfdbba4f179ab9af4f2f355c5b88cc05c30a64bac461db2bc6b0f8c6592caac3d3ee51364e60a9ad57dfeecd2df0820e491aa2ea16b27da1ec96a5b4ad3b5544eb15eb0b7d96471068cf0b5ddab5cfaacb035ad4e27fc57488755153dab4212294fe6b0372e0cc50304d33c14851e5c102b95042fa9e4b40e01c349c5bf4f0fc10aeb6addaff00a7ae1d2db8f5ec25245d59bf1639a7b0ff0082dd4e35eddbe0b8dbcefbb038cfb691ff002adab592dddca99e9ed59f55ceaac762de64b6959234ea1961915c3ae5df9b1eb7d3fbd47750b6a40ae41442c5fbe28e51539ac6e9e85ce67ed915670282450ea00368815b0335ea6b8803304946ea416192941a0379a9c569c9ad9e68dd608a5566374cdc47342d12ea60a6607359193e4c586f6d9a49b6fbda384be16c440d25bc8aedcd67523c47dddf6ae7d86e9fbc6d31b9db3ce75491b7fecb8f3fd2bb4e9c2f2f2fe55f09e55ae3f05d2571ba0ea341abe2b1a42e1993820e0b9a1de1a91c9684d4f201a539a06c81acd71e4b31aacdf4bbd38c73765dcb535225718ec295f13c51a1635dbb4db5b362cc86e3de55489b508024d480890f70140303c96a92edad31124a31e0de4a75b89ada530c51ae64934d4f0e48c472eabaa83922ad256691cd188d6616b42010080402010080402072085d34ad89be671a02b2d1ab82ce3b789b1b31a0a953a148400d3f36083db7db5ddfedfa3a189be563ddab1e78af07af3f2f67998df37c6ba426b4ec5738f86f75451eece75c021d4155de472ada6d170668e9c4f05a925c453c7238386072a2daa4464f28afa8c231e6a036fd323866de611aabea4b9316daef160700ae2185dc262dda208ab8cafd67b9239f4a9d4d6e62a5748985f82d1c935ec40dcc7f05822bdc01a29a1e1e16f3c2a9072e78a601504a124927b82d1d71c10238348a1c9446136fbfdcb62bc37bb6485ad77fbf6f9c6f1da325d27436b66fdb777b5fea3b292d7b456ff6d762f8ddce31c5aa6fcb65c5e74ff507d9c8cabbf6c1a026b45c7ae5e8e7a7aaf4f6f305e46d7b6669ae6d538d68332d730d4201923c3aa48a290f36e1b5f0918e7540fc2ed4e6b9c49a26374f692d05ce268324c34d5ce31d0026a717150be4cd86db6914ee9dfe295d9635a2dd674bb9aded6f6d1d6d70c13452b743d84020b791aae93a458f9d3dd3f686e3a7a69775da6274db3c86b2b462f84f234c74f6ae93a73bc3cc294029dc2b4229cf05d5c4db8822992042e14ab454ad084bbc4838028e18e5cd1aa8de4933dbc67eaaa26a7b2305cd73bcb18ab6bcd646a2cf217bb0c95445715686d789c91b224da5b1ff007a415e411589adcbbd60526830281820935e28c0d6388ad3141d8600ccf158446d251acbad68402010080402010080413f64205f349e02ab28d3b710a0058d21684a341c06a41e81edf5cc8edaae636bbc31bf2ef5e4f5fcbd3e57e0cef3239d31a10bbf3f86757e502dd8758255d4ebd0fa718e30b40a9a291657cc99add4321c16295b239af8cb88a91895821b5a4ca5d534419deaf91cfb7646c3524ad4563773983ae1ad18b626fa63bf9ae98e76a23a8082335ac1c5684c3239a06677068a1355221835782504aae1862325b8c3756f35a3a6869f1569c8235d71401d04206de70770ab7860b307304b796174cdc36d97d1b98f120546b1dbc1231b8d937fb4df9baa00db7ded98cd64ea08e5ed8ebf37605b63675635dd3bd42609db1cb07a5234d1d514a1e442e563b4e9ea5b66e6d9e3683802b95b54b1f0bb00477a348e6615fe082543350500aac123eebf6a80d4f228ac323d4706e8389cdae59869f6b5b18f10a770aff04c353ede460610d7509c8adc654892182785f0383648e4147b5c2a08ed5b2a6bc03dd4f65ee6cdf36f5d3b0996c88d77364cf3b3f5b0716f62eb3b475c3c6de2950e1420d0d4e3f805d658e3650749c382d1cbc0e681ba54d4ac14f7cef5b718199e97627b1059ceea374b710156087403b51076da012bc3dfe51e51cd62d348c0026a06481470403bc3e1389e681ba9460612107449e4b15865064d68101c1007b10080e7f920100813140a8266d55fb8c3cd4c1651a98b5691f9a8a1c15a1a2d0d1a57041baf6e357f4bdc294f30e59f15e4f5fcbd3e3f81b868f51dab3afe4bbf3f84dfc988f4d45335758dd74dfada1b9d38a9a2fee69a1dabe2a54a81e9e97d694c7fc90436e674f969f9a159dea0d3e936b4d7ff006f2ce9fcd115e792fa9a8d7cd5c5757236df52a397041d8edcd5047667eaa60821dc7e6a432dd5a820946ba7b382a638f0d50762b51ceb877234a33c797e6839f1530e5d99a0e1d5a63cb140375e86ff00a7c5dcb2310a7f57eee2fb3d5f7b5fdaf4abab57e9a7f82a1eab69fd47fa4db7f56a7f5ba7edfa5e7d1ffe7e15fcd4f58de5b6e9bfeabe8b756ad34c2bcd79ba7ab96facbd6f447a9e7e392d62c8528757c29fe481ac751a7c28a487dbfed8d5971ffa08a481a6b867f32043c74d69c29fe481f6575369e458275bfa9d9a51297fb5e9bf5534d7c55ff34547cb5ef37fe0dff9449fd0ebf738fdefa34f435f0d34ff00ed5df872ef1e79e0d474fc1767070ead0f3e08197ebd1e1cd60afb3f4fefddea79e9e041224d7ab1545351e8d4dd5e5ae2884e6e5e1f2ac5bac29866803aaa29970403ebc79fe481b3d88c28a7141d3b5614e58f7ac51bf0a0ffd9
')
EXEC(N'INSERT INTO [dbo].[Picture] ([PictureId], [PictureName], [PictureContent], [PictureDescription], [PictureLink], [PictureTypeId]) VALUES (''0ea8e907-7de3-4761-972c-59e693778789'', N''Chàng trai bị liệt thành tỷ phú'', 0xffd8ffe000104a46494600010101004800480000ffdb0043000302020302020303030304030304050805050404050a070706080c0a0c0c0b0a0b0b0d0e12100d0e110e0b0b1016101113141515150c0f171816141812141514ffdb00430103040405040509050509140d0b0d1414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414ffc0001108017601ea03012200021101031101ffc4001f0000010501010101010100000000000000000102030405060708090a0bffc400b5100002010303020403050504040000017d01020300041105122131410613516107227114328191a1082342b1c11552d1f02433627282090a161718191a25262728292a3435363738393a434445464748494a535455565758595a636465666768696a737475767778797a838485868788898a92939495969798999aa2a3a4a5a6a7a8a9aab2b3b4b5b6b7b8b9bac2c3c4c5c6c7c8c9cad2d3d4d5d6d7d8d9dae1e2e3e4e5e6e7e8e9eaf1f2f3f4f5f6f7f8f9faffc4001f0100030101010101010101010000000000000102030405060708090a0bffc400b51100020102040403040705040400010277000102031104052131061241510761711322328108144291a1b1c109233352f0156272d10a162434e125f11718191a262728292a35363738393a434445464748494a535455565758595a636465666768696a737475767778797a82838485868788898a92939495969798999aa2a3a4a5a6a7a8a9aab2b3b4b5b6b7b8b9bac2c3c4c5c6c7c8c9cad2d3d4d5d6d7d8d9dae2e3e4e5e6e7e8e9eaf2f3f4f5f6f7f8f9faffda000c03010002110311003f00f9d740d3dadb51b769110230600a673d0d7abf8546ed26db238db8af25f075e4b3ead0a4b233a10c00eb8e2bd87c171e7468b27a647eb59476b1e462dde8a7e66a88940000e694c1f3138cd5efb3ed22a4f27e52318239a19e0dca51c4187231f5a16d94b600c7a8abab1295f7a77940718a0cb9ae55f2028e293cac11f2d5e111e38e4526dc9ce3340d329ac63772075a536f8eddbd2ae087773e949b075c5234e6b228f958c92381de9c141380bd3b8ab4e818ff004a58ad8a3839e08e87ad2d8a8cae426d091903eb4d16bcf03f3ad558fe5f4150188eeebc50697d0a3e50180463de90c60123a8ab66239e78ef935114c9a6252b32a491051c73545d42b569cd19208c91cd55787776a0a52bb3c7be26438f110200f9a107f535cc243c724576bf14a0f2f5ab53d33091c7d6b9255c6074af0b15a5467e9794bbe122761e1a1bf468b23b91fad6918c60f031e9543c26a5f4ac67a3b0ad678f0bd3a57b349de9c59f9ee3972e26a2f365178811d2abbc7d7bd5f75eff00a542c9b871d7deb4386e67bc631c0e4d40f18f4c0eb5a0d09e78a81e2079078a0ab9957f3adac2d2b10aabc9cd717a8f8b6f6e17fd091523ce03fde26ae78f75128d159ae496e580f4ac9d2eda592548adad941e32c462b394b94f770785f6a94a4889a1d66f1374b3c8093d47140d4359b37c7db0c76c9ddd7766bd574cd044b60a24550f8c118acbf1278667164c20d800ff006739ae358957b367d23cb528dd2381b0d686a5a823e14bf46553fad76de48b8f0f4e71f7a27e3b5796dd09f47d432ebb70792a2bd5347952f7c33bd1b72b4647e95dae5cd138fe0d3b1c8e9bf35b478e7b57a4fc3c05f4cd6954e311c6fd3d1ebceb494ff472bd7e638af4af86c098f5a8f039b4ddf930af121eed5b1eee33dec249f91f53f87d7ccb4b6607968d493f85761a7a0318caf1eb8ae3fc267cdd1ec187530a7f215dc69c9b517f235d6d5cfcf6e57d62df769b77ebe5b7f2af29f311b8c8af5fd554ae9d744727ca7207fc04d7caa9f149f0566b2524f528d5cb565cb6b9e8e130f2ae9f2f43d28c4afdbf5a4102e791cd70f6bf12b4b75512fda216ee71915ad6de31d36e89316a51fd24f94d63ce99d32c2d589d008955c1db50cb000188ee6934ed461bb7016e61949e46c7049ab6e06d2071f856d177479d5a0e12d45bc5063b172bd6dd47e448acfb85018fad6ade91fd9da7b1fee32fe4d591b99d9f70c7bfad2832b131bcdb18cbbad240476c62b941182a4e3a715d7b36548e3a5730b09dce07a91cd7a5867ba38b53c77e38f876f3567d2bec76b25c30deade58ce3a75ae2b45f859afac8931c69fdf797f9bf4afa46e63c8c63ea0d66dec38036818f5aeff535788708f2c51e5f1fc377ba40352d4ae6ed40fb81b6afff005eb534ef05693a6293059c6ae3f898649aeade23dbf2a84c3818e9eb41cb2af525d4a496caabc2e31d85588e2dc32073d2a64830dcf4a7942ae08e16830bb2208491c1abda5a81332ffb350ed0c4fd3ad59d3131724e472315125a33ab0f2fdec594f518b13b9e793549a12074c56beab1fef8e7bd663039500f4a23b20c45d5468c3f2bcef10f4ff53076f563ff00d6abf246318c71db8aafa44466b8bfb9ebbe5d8a7fd95e3fc6aecf19047bd51949d9d9144a6074e298f1ee39e39f4ab86300629be5633c703bd416a4ccf910e69a6df9ab8c8370e846714be40f43f9d3487cf7dce1bc325a0d560231f7b193ef5eede078c9d27db7b0fd6bc4f44b5945c45304251640091d2bdcfe1e8f374b9770c6256a22f73bf17feeece81a32d9c8e29e2238e78156fcac8007414ef28e08e9c551f32e452f29bd29de571d319abab0fcbef4be47cdd3ad26ccf98a691f00feb4822c8383f80abf1c1bba0c1a6f9241e46295cabdca6d6ec40c12a7d6830fc9effceaf08bd0714c742339148a72d0a7e50efeb53c51631c67dbd2a458783c64d588e3c03cf3eb45c706432478ea33fcea0319dd8c11cd68b20603393556440a4fcdcd0747314e44c29feb5198b0093566542dd0e7de9194ed20fd6826e50914e081938e6ab347ff00d7cd6830cafa1a85a3e9c77a7b1517d8f27f8b70ecbdb07ea0a30cd70bc28ddd38c57a47c5e8b2ba7b7fb4c07e95e78b0fc983cfb1af0f17a543f4dc91b96117ccebbc1387b0947a49f9715bb320553904e6b2bc09129b7b90474707f4ae9a7b5ca9da339af570eef4e27c66674ed8ba9ea6149b71ed4d4404fa8abb3d86f4231c11514368628957ef60639add9e4a89525886e1daaadc00aa4fb76ad491090401c8aa3736e7cb7054d22d46ecf1ef1b5d91a9799801ba035d5781ed0ce914ae324815cc78d348927be5201c97e83d2bd0343b44b3d2e173318218d46760c926b8b10fddb1f6d964559791e8da3da426066917a0e3355f56b1b5997cbc15561f7f3c03587a178b4b16b7490dd424edde632a41aafe2ed52ee43e408e6789392b16013ed9af3e308ad1ee7d34a778de2796fc49d1cdbef788ab6c3c953d6af7c32bb1268b796acd90a0b2f35b7a9e97fda5a5cc67b516ae578cf56fad62f8034b101bd19caa122bd1a524e2e3d8f9fc55370927dca7a72b62503a073d2bd2be15a93ac5ec47fe5a58ca39f50335e7f63188ee6ea3231b652057a17c2e6d9e2a850f4922953afaa1af376ad63d6a8b9b06fd0fa67e1d4867f0c69872493028af46b24daa075e6bcc7e16b31f0b69e476054fe0c457a7d8e7191c8f5cd7733f3896e4b711f9b14c84e72a457c03e3cd5db41d765816d9644048f43c311fd2bf41c47cfad7e7bfc6ab53078bae571c896553ff007d9ae694233a91523dacbaa3842a72f91809e35b661fbdb7962f7539ab30f8a34f97a5c3464ff7c572063393e9ed50cc9f23f02b4784a7d0f5238c9f53d83c177adfdbba74b1cbba2799464135f414a085c9fcc57ccde039bfd1f496cfdd9507fe3d8afa68fcd111e9deb869e8da38f337cca1233fc41722d742b69ccc22f2cc83e6ff00781ac7f09eb52eb76492cd8df8c9c0c03c91fd2b73c41a0c1e20f0b8b79b202dc36307d541fe9599e1df0e47e1e574476915f1f78e71eb8fc4d6f4b954657dce5c4ca32a71496a922dcacbbbd7dab0b60fb438038c9ae9a584121ab9f9405be957a7cdc57661be26792ed62acc98200acaba8d83fb7bd6d5c6324e7b75ac9bbc98cf27f1af4d3b184f6b994e9cff003c546531c6463b55961ebd714cf2bd7af4a67210a465483d8fad2c89b8018ebdea70848c600029bb7d0f1487a91ac7b5368cd58d3542ce87b9c8a66cda327f2a92c976ce84f66a52d51b51769a61abae25079c62b1350985b5a4d3e7ee216c7bf6ae8f594c95f5c66b96d4c0b892dad47591f7bffb8bcfea702947e13a710ad59dc5d22d8dae9d046df7f6ee6fa9e4ff003ab120cb7b7bd394f20f514d99f18ed93d2a8e4bdf52b3367b13cd23671df35318f03039c9e6a371b47bd22d58aae3af1de8c0f5a946391ed4d11b63ff00af4b602859785ef34e904d750b43186e413d6bd43e19912e95718ce44ed915aefe10d3b508ff007d13b28e8371c1ad6d1746b5d160f2ad62d899c91dcfe3511524ef23ab138ca33a3c91bdcb690e303079a79806d3fcead4318650718a718fe6db5af99f3d265411e410467b834ef2c639e98ab9e50c1e3f1a530800771458cee518e31bb1f952f967774ab5e501d78a4d98e7b6295865365e7819c52f95900d4fe493d7a9a578b7275c1cd2b157d0ade595c93d28001e01fc2ad087249c641a89e3da78183eb458149a18ca01eb559937b9f41575871c9e7b54263c0381ce2a4d54ae42c81b3800e0535a1f973d78ab10c644632bce29cd18618c5069a199242307d7af4a62e9ed39190715a7159b3b72323deb445ba43083c0c76a66f4f53c8fe32e9621d2b4f7c7226dbf9835e50d161722bdb7e332b49e1c85b1c2cc0ff3af1758fe5279eb5e3e317be7e9390b4f0cd2ee761f0e9031be5c0fe13cfe35d7cb10da063a5717f0fe5d9a85cc5dda3047e06bb9627038cfad77e1bf848f9acd9258b999af6dc92698605e0761ed5765186e075fd6ab4848c8c62bab73c5d1155a2507a6735525881cf23156f703918151346172477a02e70de26d20ca52554cb21e47ad6bf8721592211b63683b48f4abba95b0784aff007ab33468469f752db9ced3f3ae3a57062a1cd0b9f519362792aaa72ea6f6ac96360234b60cfc8dcc7a035025f2457a18c4973111f36ec8151debcb0c88f110f1f7e3256aa6a6f35e88a28a5725b19608005af3231babb3eddcbaa43bc4c6092da4951020209d83b5731e1b8045a75cbaa145762704e4d6d78a64d9a6bc76e0bb2ae1dbd2b2f4b3247a61c8ca152722bd1c2c2d16d9f3d9854e69ab1ce46bb756be5f56cd773f0edb6f8b74c19c13215c8f7522b8a27fe27377c75c37e95d7f822610789f497cf02e133f9d715456adf33d1a5ef611af23e93f8452bcfe198c152be5dc4a833ecc6bd734f5dc8720d7927c2d702cf50873f72f6418fcabd774dff567d6bba5a33f359bf78b98031ed5f057ed016e20f1a5f0c1045d4a3f5cd7df047eecfd2be1ff00da62d3caf1b6a0718ff49639fa806b0daa40f4f00ff88bcbf53c508047207d05433c6361ea38a9f18c7f3a8a64254d77b3b96a769e09931a4d9b03f7251d7fdeafaa235ff478dc9e1947f2af93fc1273a21f5594ff00315f5558cc67d2ecc8ef1aff002af17fe5e48bc7abd1832e201fd9138f4b807f35aa0e001d7e9cd5e8c13a65efb4919fd0d67ef0c71ce47514d6ecf2aadda8bf21c40dbd335cdde2817b21ef9ed5d1ee01307a7ad606a207dadf1e80d77e19da6724b629dc2e07ddef542e63ca1c0c62b5d9415071556640cb5ea18b5a1ceb2f38ebcd309cbe074ad0bbb609d0607b555c0dc38eb4ce1774ec30282318eb4853ae7ad4e47383d2a373f39f4c5037b0c58b00679a9a250922e3390452292e3a718a543f32e79f985266907668b1ae031a46cbd4f15cae9ea2eef6f2e9b9453e4467d8753f99fd2ba1f1addc967a7426001a691fcb40dea7bfe1d6b32cacbec56d1c2bcaa8c13ea7b9fc4d670d8efc5ab4afdc58823678e053658473c1e2a52df3602e314d7cb3363a568701548c2f4ef50bb0dc720e074cd5a0a7183d6abcd190ad8383d8d052d487cb00e40e7d682467ee9fcc54c8b9383d69a6319a5a94ac7b85ac25509ce7d855c8e2ef9c525b45c63a7156618776ec74ad2c78f27a8aa87a8fff005d04fcdd067daae450158d49031f5a8de0dc72319f7a9d88bdd0d4403814e58c1ebd054c89c638fa7a52797f29fe5488d515bcb01b3c1a1a30a39e6ac2c7f29278f7a0af3d383409b29b4619481c7b9a16338ab0ca79ebf852aa0c703f3a0abd880458cf7e3f2a8648f0c38e3157f68008a85e2e47d280b949e3e303f0a6ecc28eff005153ba30391cff004a43197c01c67ae2a2c6cb6b116001ef4f8a032e0106afdad8093af03a568fd992151eb55ca6f18e8667d984080e39354eea5c2fd2b47509704e062b9fbb90b31e7a7bd1a1a395b4471df15d8cde166ff66453fad78e247c1e6bd8fe232eff000adc9e7e520feb5e3e842920f3915e36357bc8fd0b86e7cd466bccd6f071dbac3819c98ffad7a121dd1ef3eb8af2dd1f578b49d4c4f2f0850afe39aea61f1fe97970d310b90471f9d7561a7154d26ce2cdf0b5a78a72845b565d0e8e5fde374c0155a51c9fa56449e3cd21beece7fef935464f1de9609cdc1c63d2bab9e3dcf13ea95fac1fdc6c018638e0e695993182706b9d93c7ba501933ff00e3a6afe8fa9af88862c43c801c6f2b85154a49ec4fd5ab2de0fee1f71990aaaa6e6eca3bd53d7743bab5d0e4ba4ca5c1224c8f406bd034ef0f2e9f6e65914c92e325dba55ad42c56e74b86475ca1055d71d8d292ba763dbc3619516a52dcf2dd3b519e3446b887cd42324a8e6af5deb311b72b6f6f87c75db8ad66d0ff00b31bc9739543f29f5534d3a742f711c6170ac73935e0ceca4d347d95395e1eebd0c5f0ec0be64d05c8dcd3608623f4ab573e1b5459a38d845d8a91f2835a69a617d623403692df211dab4353b7960f3f0bba42cb807b8ef5eae1e5ed208f0b174d46563cb6f7c17a947a9cd74912cb130ea8dcfe55634256b6d5ec8952ac9321208e7ef0af44b65925054a9dbd3056ab5c6869771abaaed9e270e8d8f7e9515b0fccf9e3b9787c5f247d94d687abfc3494477fad438c62ecb74f515ec7a48c27afcb5e2bf0cbcc1aeeba2460dbe54900f4056bda34963f28ce7229bdcf87aba499a6b831b0ef5f1a7ed576de5f8bef1c0c6648dbf38c57d9a06324d7c9dfb53e986f3c4b3807059626c9ff00771fd2b9aa350719799e965979549457547ccdcff8535f91fd6b5a4f0f4e878615049a2dc28c6326babdb537d4f5fd8545d0d3f0413fd9572bd76c87f957d4fe1f6dfe1fd3e4ebba04fc38af96fc1f6725945791c830cedb940efc57d39e0e90cde15d3581ff0096407e59af25b5ed64d0b1c9fd5e26d5bbefb0d4060f0633fa9aa21413c0ad1b6f9acf5018e7cb53ff008f566a939c7ad5477678d575843d03b722b1750502e580e32b5b2d260edacbbd00cff3019c57761dfbe8e47b144e4a74a8d97e5201353632a7daa124b4648e0d7aa8c6f6285e80157d40acc624364f02afde1dd85f6aa5226e0475a0e39eac62e5baf033c0a6900374ebd6a44ce307b7e54d78b3ed40ae19c3100f514b1a280a7b29a01da0f1ce3b564eb170f3347a65ab117171f7987fcb38ff0089bfa0a2e5c55de85eb87feda99f50271696e7c9b7c8e18ff1bff414e08a17af3efe95b06ca287428ede250b146aaa07a0158853e72bd70702b381e8633ecbf21c506cc2e0ff003a85533850318e69c3e590ae79a21ea475cf6ad5238137b321f28638cf5a80c7bcb7a7ae2af98c95c60d57f28e18600e28b1454da17ad44464f41f955a9141181c1a67e0bf9520d7a1eef6eb9207400d685bc67e6c6719e82ab5b28db9ee79ad0b65f6fc6b46788dea49b49ed9c7ad46a9f33027156961237707fc2811ee3822a2c4ea40211bb91d29194efe95742854f4cd42c3e61f283ef4ec26efb95b6673e94a2338fa55a68946081b41ef9a4c00314589f995193ae3a9a6853c8e9567685245050b71d69587bad4800c67bd42e08038efd6ae88f83c0e948f12ece7f21431a33cc45ced55ebd715a567a66141239ef9153d8d8e1771f5e3357a6c448157938cd16b1d74e3dcae6d76a9c61466aa5d7c8dd724559b8ba2a4e719f4159b2b339249e7d28369492d1156fcefe7bf5c560ccb8624f4cfa56e5c12c31dab22ec1240fbdeb52ccefa9ca78f1049e17d4001d10915e21bf2013e98af7bf14c7e6787f504c7fcb26e3f0af9f77128001dabcbc5abb47dff000ccb4a911977672deba450e0c9236067a51ff083ea23ba0f5c035b7e1bd9fdb5641baefe9d7b1af4a0a99c15c03eb4f0d4a3385e48eecdb1d5b0b59469bb268f157f056a2c71e6a81f8d463c07a87fcf68f1f435ed6f64ace30b81dc91d691ece20b8618aebf6305d0f17fb4f1327f17e0793f873e17deeb7ab476ef2a7920869580e8bfe26be84f0f785ec344b64b5821555036af154fc0160b2497370170a5f68fa0ff00ebd74b7a811cf6206463ad3494363d5a752a5582954773225c59bcd6d265a3707667d7b8a68b957b3fb32dbc8c48c72b81f9d5dbe845db329fbec37291d9853ac2eccabe4ccbf3afcbc0eb5698dee73b77a2059079872251ceee99ac6d63c3ef6654ef651d41ed5de5ed88b984c673ea08ed550c0f24460ba06e2123190a370ac6b51559799d14ab4a93d36388d2cbbea10c65b9c1c377e056d4c63b85505732a9c648a8db4d4d3b508a543ba30480cdc11f5157846092c3079ebeb4b0d074e1cac8c54d4e69a654108447fa567db9292264f0720d6cce988dbb8c5665c0f2923ce00dd5d47048ebbe19c87fb7af199b06444e0f7238fe55ed9a5360ad7cefe1dd41b4cd4fce5e0a3f23d457bf787ee56f618a546c87506b9aa2b3b9e0e329b84f996cce89586457cb5fb58c4d1ea2f22b321304443038e848afa8f71047f2af9aff006afb5c8f3392a6d463db0dff00d7ae2afb45bee8e8caddabbf467cabf68bb078bb93f1a1af6f939fb56efaad568e7c120838cf5a9dd8383ce73debb1d1a6d6c7b0ab4fb9b7e11bc9efa6b9f39c1f24000018ce6be90f87f3799e0eb004e4aa91f4e6be69f05102f7505ce328a7f5afa37e1ab893c1f6fcfdd9187eb5e3cd28d6691ae2af2c2a6cebed4362f57a036e4fe44565ab9c8e2b46c989b8953a6eb79073f4acd276a8c9cfb55477678153f8707ea296cc80e302b2f5227ce523deb5aded66bfb831c237b805b1d381595a9c2f1dc00cc87071f230383f8575519255123274a6e1cf6d3b907fcb3600f6cd57760aadce4e38ab046c56f4f5acabdb82a481c0fa57b08e393b22acf2176c9c66a3c13cf6a4277b0e72053c3065cf4cd0723d467940b6475f4a47e4719383d3d29f8c1e4e698d23f23f43de807a14b52bc4d3ace5b899b6c71ae491fcbea6a9f876c9d37dede717d75f348bfdc5fe14fc3f9d417edfdadaec76a466dacf134a3b339fba3f0ebf956ce43303b71eb49c92dcde14e6d7baae6f08c3698d8e78ae6ca3239c75f53dab5ceac967a54e64da914684b3b1e14567cb12b5ac73c4fe62ca010e3a608eb582a8a37b9ead5c3ceac236dd15163cc8ccdfad48adfc2bfad569e47de9b770dc767cc3afb8a9a38594824e735b4657d8f3aa5195176912173cff002a819b039193dea56c8e0fe7eb5037c8b91d47ad68cc55885b20e01241e79a6796ff00dd3f9d4b800ee3f5a378f6a407d05690ed8c5695ba80fc7e46ab41100d9fc455d893243015a5ac788dae84bc80e01e9d09a6ec1b8678f6a90f3c76a558b7151dfdfa52ea4b7711a3053ae3d3d6ab32ec931dfd0d5ff2094e7f5e6a123748772e31d3bd3b11777b11150a9cfe551152bd79f6f4a73eff003bee7ca477a9133b4719e7ad20b9088439dc01e29c91649dc2a5f2fe6e9f9511e71d39a05718c800ff00eb52450199ba10bef5232b3c817f4ab85422051c1141ac75115446982706a8cd72771c0e3a66a49e70dc722a9bb0e7ebdc54bb9b73f443646cf24d576604b2e3a0ce6a6030b82726a3d8371e703f9d48732285c9283a6475cd674e06091d6b52ee32d90ac062b3dadcb1cb1ce3daa5dcd6366616b509974dba5f58d87e95f3a11856503041c57d48da63dd5bcea14e0a915f325d406defae63ee92303edcd79f8b5a267dcf0db6aa4d32e787ce359b0c9ff96ca2bd816c97702578f7af1bd2a6f2f52b261c62543ff8f0af6c91cf23a1f5aac1bf719d79f2bd583f22a5c284e0706b22fefe28d1d47cc5454fa9ddb0ced6efeb5cfb235ddcc710eb2385fcebb9ad2e7caa9be65147ac7822d45ae836fc7ccebb893ef53eabbcc871c7cb806b420b4165630463a2a8150dea074523939c560f73eca9c6d048a96708996da53c86ebf5ab6fa6798be7460093b8acd6d462d36d9239084db29ebee2ac59f8aaca2243cc0827aa8247e95a89f62c248461644f2dfa7d6a9ccad1dc14c819e99ad479edf528b744c2453fc487a5433d91b88b6b1c3af426833d8c8bbd3c4f6f301f3cf8cf3dc563d91f34631823b62b6e5b7b8471f36e6078c0acf842dbdf4a8e319f997154887abb915d5b958f8e7dab27558f1071d86715d48896ea2dca304f6ac9d46c080e0e3e6040cf634112473fa45d1794163f7862bd8fe166bbb646b195b9ea99fe55e3417ecd72074298071eb5d0e95a94da75dc3731e77c6777e15125cc8e7ad4fda42dd4fa589e983df8af08fda92cfccd2627c70619173ebc835ecda3ea4babe976f76a1943a8383dabcb7f68f884fe1d8c819215c7e95e657f80f3f2df771497afe47c392af952600ca9a0cbe50c1fba7a1ab1709999b8c75aaa02953bc12b8c648e86bd2e87aaf466d7839c7f6addafac1918fa8afa13e15cc5fc36e9fdc95b22be73f05a18f5c9949e1addf1fa57d07f0966c6897aa3a89bfa57895efed8eaabae13e67a1e9f207be8d07f123ae7fe026b2cd68d9af977d6afd72c47e6a45669936c98e3834a3f133c1a8bf751bf7668e8330b7be95c90b8818e4f4e39ae72f1c5c6eb94b416cad2f2ddcb11ce456f58fc9248410098997e6e9d2b2f54b6bbfecd899e38e380b1c956c9639e1be8455d3d2b267a54b5c14919665dd19cf2df5ac2bd62f29ec9eb5bdb008df90081c560c9cb107bf3c76af7ac7cc54764461828e0d3f195200e2a238ced1f7bad2f99b7b7e02aac71bd4937734ac4f73f4aad2c84ab1c903d075a15988c91c0f5a0d2cec73f7976de1e6bf9ded25b859a53297888, N''Chàng trai bị liệt thành tỷ phú'', NULL, ''077b972f-1a51-415e-b48a-19f39219d165'')')
EXEC(N'DECLARE @pv binary(16)
'+N'SELECT @pv=TEXTPTR([PictureContent]) FROM [dbo].[Picture] WHERE [PictureId]=''0ea8e907-7de3-4761-972c-59e693778789''
UPDATETEXT [dbo].[Picture].[PictureContent] @pv NULL NULL 0xe980003e98a9fc37e2bb3d6e6fb247693c6426edce3818f7abfa8de45a7d9dc5e4ea0c50a33b29ef8078ae27e1afc4997c47ad3d95e431445c130989718c7f09f5e2b9ea2ea7bd829274ced350b71a8689aa5979cb099a32819cf0322a5b2bbb6b3d0ed2d1ee6379218d1383dc0c565ebfadff0062456645a2dcfda2e840589c6ccf434be19d61bc49a2cd3dc5badb4915c3c7e52f3f75b1cd72ea9687a6edd4d09240cb6ec5973b87356449f363392066abc7079b044fb00653939f4a9917739391b5863e95d74b63c3c77c6889c91bb9c8cf7a8263b860f7abbe4b609078fa5579573d0fcdf4adcf37729396db80492474a6847c73d6ac6cd801ebef49e5afab7e7459b0d4fa3adb3dcd5c84066047e3cd476d164608ab8908dc0815bdac780df51eb1865e700e69d1a9dc3d2a68d7238e2a55fdde58f5038a560f52bb96018290bdeab107209eb56dad9a75cae00ee4f02a3922c15e43007351bbb0da692935a10483e5ce3207a50002a0818cf35249190fc0001ea3d29444769a0cee46546170727ae3d280c3aeec549244ab129ea49ed5188c60023e9422d8c1c3975e00e053a497319cf27b9a69560d8e8b4d7c046c703d6815da2b13c1cf35195073e869cec01e48eb418db6ab1efd3d0d2dcb4458e3079a81c379a3fbb5784608e47351342e5be45fd28b1a2284833903b8fcaaee9fa589c02c38f7a9acb469eee7fbb8507935d1a582da201800714ac7751836eef633974d8a0591553b1e7f0af8ebc576ff0067f136a880602dc37f335f69dcb264e3d3f3af8ebe222883c69aba74fdf93f9d79b8af84fbbc99a55f957639e89cc5344c38daea78fa8af6692f4cb193d0578bbb7eec1e817b57ab5b4e25b589bd514e3f0a9c1bd1a36e20d391fa95ef5b3c1e9567c1da7ff68789ec900dc10f987f0aad723729ed5d5fc25b30f7fa85db0e230235faf5af41ec7cb6120e7591deeae4436f91db02b3e4914a2e7afad5ad7589b076ec08fe754ae5d2dedf2dfdde2b06cfb381cceaaf1dc5c6d9a30e8cc707d08ad0b18a082251b1473d40e2b99b8d6962ba58fe53d4ee7e9c9f5ad38b52caa93d3d8d6f6d0c54d36ceaed52079372a84917bad68614a1cf7ae6f49be5925655e4e3a56acb7e23889c1e3ae290f463ae1106496fcab9bb910b4e72c7d391c56849a9cd371142dcf42d55e4b49f692d22abb9e063a53b19b1b0848bfd4ee523a856e2abea17248f9f9357e664b6897e5e71827b9358d7ce486918f2016fa527b19984fb26ba91b3c6735df784bc1efac18669884b4383c1c96af154bf9ae564f32524313803b57b7fc11d69eef477b47624c0ff00293e86b97daddd9186314e952e689ecb676f1d8d9a4312808830a3d2bcefe39da7db7c340ff777718ff66bd16d24cc3f30e6b89f8bb097f0c16270037f306b9ebff0d9e3e05b78a81f05ea717917240e7e6e959135bba824395ce71835d0ebd6de5dfc8d8c8c9c62b1650c71c1c7a577c358a67b534f9996bc1048d7d54f27cb71ff008e9af7bf84f362def54e31bc1c578378414af89ed86386c8ebeaa6bdcfe14ffaebd4cf6071f8ff00f5ebc7c4ab564763ff007491e9f0cdfe916bdbf7ab5992c9b6e5c93d188c53d6f1d35086344dc5654cfbe4f6a9afb4bbcb569269ed9a38f7e771c1ea78aca324a76678d528d4951524b4b93e9a89737b1c4df75c153f91accd56d0693a6c3099b108259632c4e3e956ec1d6d6ea3b890164539217ad43e23bdb0d4618caa4ed2a13b1a423033d7f956914fda2b1be1eb535879424f53056433abf1c63f3ac6ba60246c0e7b0ade601636edc74ac19f873f5af7d6c7cdd657d8a8cdb9c9e98ee69e08efc66a094ef6eb8c75a4573bba67d28d8e648b25700f20fa52ec1b4fd39151249b57d6a446dcb9047f2a068ad750c7730bc53a6f8a452ae9ea0f06bcf3c01a259e8ba9ea17c2d4b4b15cbc50e5beead7a3ba938c1c29eb9ae6bc1b691bdadf395059af253923fda23fa54b8f31e9e1eb2a307d4d1927b5be451736c26d9279aa3390a7b1a486f21b1578adacca2b92c7674249c935a8b0243c05007b0c531f6f181c8efeb59fb046b2cc24f448a46e65545540e49c71b7803bd6947c8185c71c7d6a3393800e47b8a976e391f53cd6aa3cbb1cb52b3aceed0f126090460f7e7ad5494e339e79a7bb8de79e4f4cd43216c11d335673d882490e719e293cd5f46a6ce304678350eeff006aa7987c97d8fa96dc7ca3b66ae8395c0aab0052303ad5a8623bf8e41ec7b5751f364c8a57902ac46ca17a06c823914c0b85c678342aecc771e9521713015391f8540c779c6315664c200d8c93da9a54139e05027b10796cec4374f4a7aa9da4738a9c90307f9544ec4b1a2c221f2f2f8cf19a6ec1ea73e95348718fe7506ecc9ef8e952d149d991cc9865cb37d2a09ce107ca09e9575e17930429eb52c5a69947cca79ed5363551727b18863de380727be2a68ada593e50a48f4238ad8bbb7b2d0ed5aef51b986cad57ef493b8503f3ac9b5f8b1e0159362f89b4f2f8c8cc98a0ea8e1a4d9a16ba4c9b72c99e7bd6ddbe931c28be62862467151e9be27d23588d8d85f5bdd467f8a190355ab9bf55fba718e293bec7a14a9c21b89318adb384da3a5645e5d2fcd96e7eb4b793b1058e735cfdf4fe5e49cf35362e53ec58bcd48200146f27bfa7d6be57f8a2abff0009b6a47ae5837e62be82b8ba6793058015e07f146029e2db9247de4539ae2c56b03dfc8ea5f149791c826190f3918e6bd27466dfa4db367f807f2af37450a4802bd0bc38de6e876d8cfddc57360f768f7388a3fba84bccb374df21e3f1abbe14d7350d2f46b86b79d536ef72981f7b9e48fcab3af57086b9ad5a668eddb6b15666032a719e6bd37a2b9f2784a9ecea2d373d43c39e36d575cd2766a10c12ef5fbf17c8df974ad1bdd723b9d2dc96c4910dacbe9815c6787958da008769c76aa9acccd6d6f71133112bb821bd47a578f46bca53e591f7f88a31a747da474d0d8d1ed135fd3e29e11f302558771cd5e4f0a188e56678c7a93591f0ea5945adf2c2467cdc807a74aeadade49c9f3a46fa29af66ecf0a92e78a9343b4f892d58932ef238dd57b7bdf4a100c408793fde3e95520b0b70ac0a9c63924d5cb5430f009c63033dea59d29742e051d5bffd555ee581071c85a9b3bc64d3762ed65e09c77a131b5a19d70e59416e83a0f7ac5d58b0b2b83dca1fe55acc1618f6f3c1cf35997e4491b2f07208a4d9834796d949bd2bda7e0446563bd93a2960324578a5bdb985a507a07207e75f437c24b0fb0f8760638cca77f15c297bcce6cc6a5a828f73d62da5c274cd72df13a3377e1298038c38e3f4ae920625060fe35cdfc4f69a3f055fbdba969102b05f5c114558f341a3c1c24b971107e67c41e23d39fed52ed6e55dbaf7e6b92955b6b824861f9d771e2866794cc3ee4a49233f7581e456258dba4915c975f9b1c1aeaa6fdc573e926bded0cff094663f12e9ed22ed2d281cd7b7fc279026ab78a7fb9fd45796132c1ae6906593ce2d2c4c24200ce71c57a87c2e3b3c517716320ab71faff4af3315fc54ce84bfd9668f4898cb05cf9ab183b592456c6738ed57af7c5136ad692a496eb1172bce08e869f2c6020c827354a441b476e7a562a9a6ee788f1d5234fd92d86321317a03cf1557518825b8ef8eb5a4c81477c1aa7a8c205a3b13818ae88e92479eb56643fccbea2b0afd429e32335ba8371c67358bab44724af2318af66f74633466ab862476ef9a4de841c76ef503130a127a83cd0cc0a823a1f6a8b9cfcbd492393a81c7b6696391959b71e3b0a8954e3239a7332ef03bfa5304b427336074ef9ae73c1db97fb4d4e42addc807fdf44ff5add10090ed04e73c1acef0f5a2c57daddb8ce52eb7f3df728341ac748bb1ae18640ebdfad217f4c1a68528a7b7d290746cfd6aae64297c6303eb51990a9e7e9532a03116cf3fcaaaccc06052bd8d2cc61b96676c8e3daa39e53b811924d0a368c720535a4a91a2173d719fc6ab956cf5352b961283ebde9fb0fad2d4abd8fa9239b62af727902b56ddf7e38e7e9583a502c885f2c4715bd13a845e4d7746ecf999a51762761ebd852a8ca0f5a37293ebf4a1be52a31dfa51d4cfa0a38c60f3e947193e9ed4a5329e84d3594af039a648d6e6418a6edcb376a71057a73526e19ce39c5494426366650011cf6ab761a0cb34a3e53b6b5345d377b2b30eb5d7db58c700c0519c529591df87c37b4b3673d1e84b146a0af35e7bf197e30693f0774279a644b8d42518b7b553824fa9f6af60be7115bc8fc050335f981fb47f8c27f187c50d599a732c16f298225cf0a071c7e358b95f43dca74173a8a464f8ff00e2d7887e276ad25c5fddc82263f2db231d883d00a7f87be15ebde218125b68fca89ba3487ad6b7807e175e6af0dbcc90870fcb39e8a2beb4f08f83121d3e0b4b78599228c206c75f7af1b19987b1f7696e7de65b93c6a479aaab23e535f871e34f06b8bbb1ba70f1f3fba720fe55d7f84ff6a1f14e85a9436be22856fed4108e597648a3d735ee3e2df015e3ea62da4bcfb3d905dcc21fbe7db35e45e3ff0086de1fd484d6da5cf22ea518254392fb8fd7d6a70d98b692a9afc858dc960d39535f7bfc8fa2ec7c4d65aee9705fd8ce25b69943232f4358fa9df066db9ebfa57ce9fb3ff8b6f7c39aeddf85f52124664c9851f80ac3ae33ea2bdf59773ee61d6bd772e6768ec7e7d89a0e84ad221923f3240c0fcb9af1ef8a90f97e24463fc50ff235ecb28da001cd7927c64431eab632360064615cf888de9b3d0c967cb8c81e7a57e63f5e0f7aeebc2526ed16218fba587eb5e7b71789138677d8bd327b5749e10f13598b7166ce15ddc947cf0dedec6b2c1e1ea6b3b687d5e7d569ce92a69fbc9dce93517f971d0fafad72bac3622427a0914e7f1ae8af24c9c127e9581a9a8b8b6957073838aee92ba3e3297b92526767e1e6fdda85e98cd52f17afeebccc60af34df035f8bad3e36272dd0d6c788ec92e2cd9941c915f351fddd6f99fa94e2ab616ddd0ef05e9b25b69a00c23901d89f7e6ba45ba09c3c809f5f5a66951c66c2219fe003ebc54ef6d10380a2be9343e5e1eeab2248a747c0ce4558439ea6aa456c0ab6091c702a742a10039e9d6935d8d548b0260b920e00a68994924706a1d881b8e7f1a07c9200a07d28b073142e260c1907de079158d79762da2919ce0053815b77f0ee96465c2b91dab95f10c65a01ce1811d6a65a21455e5639578df7973d09c9c0afa23e1f303a0d8e0f1e58af9f9af921b96490e31c7b57ad7c25d70867d3257c8037c47d47715c307aea73e69877ecd4d6c8f68b4ced5e9c566f8d137f856ffe53f733fad6c6989e64679f7acef1b47247e17d436609f2fa1f4c8cd69557b8cf9cc22fdf43d51f0ff89ad99f51d4ecd539ded24631fc43a8fc4572505ccd6d1491b41236ee460576fe36d4a2d375fbdca3798af9461d8d7277de20b5f319a346da7903d3359d39cf91595cfae9c20e6ef22a5addde5c5fe9c24b62890cb1fcc01e81875af62f8792f93e39bad9f3825c0c1edcf35e37fdbd1b3e3c93cf039af5cf86d67269be3586d65605d460b0e9c8ff00ebd72e21b724e4ac68a31546693b9ecb148646da47bf34dfb3868db8e87bd5f4b3c1c9ea7d2a3684a9719a713e36ad8a9321083be3d2b33517dd6ce3a70735bcd18f2413d2b2afe10d6d20f63fcaafa8a12499cf4322edcf6f6acad5480f9cd68443119ec3d2b375465538eaddabd85b0aa18d2a23c84139cd4121f9fe9dead4b1f3bc1c0c74aaa10b9e7247b527b9cb7638314e7be3834b1346c304313fa8a23dc4040c4007a5485403918145849a436098c12e40e6a8e9b74b0f8bf5252a479d6d14d8edc12b5a21067a83df22b15481e357619c1d3c039ff7cd522e37b346d3e19892060f6342a60b31e54fe148f22f393f974a15830fd695d6e093d846202900eef6a81d4796b9e1bd2a57da41217f1155e49860e32714af7dcd52b221903745edef555dcafca4e7d33daad9ea4707233555d007e738fa5431c55f71bb4b3b30e38ef4fdd376c7e543b9f2f68e99cf34e0cd81f3629a2763b9d2be3f4d6da5477973a17988ec4379371d0fb645749a3fed19a26a0ae1f4dbf81a31b98008fc7e62be6ff0fdb5c6ad6f359339071b94134cb38a5d3aec16603076329f4afb2783a4eeac71cb0b4e4ef63eb1d3be3ef83af655885e5cc2edda5b571fa8cd6e597c55f085f3909e21b2461c6c964d8d9fa362be36d4a1974dbd062ca290190814fb902eed56ec2e24ce241efeb583c0d37aaba32781835a367db9ff0009968981b758b063d40fb42f3fad6b5a3aea161f6cb7227b7ce03c6c1831f6c1e6be1d6b79356d20dcec064b6c23617aafad7d2dfb367c551acd8c5e17d46358b53b44c593aa8559907aff00b43f5af9fce215f018675b0eb9adbdfa2ee7a79765343115b92b4da5d3ccf417bc7899bfd1a4620f238045573afcf6d3affa0ab2fab39ff0ae8352b5fb14ae31bcb72cc7939ef5cfdc0323118e07a57c14339c4d5d62d2bf91f69feaee5f4a1cdcadbf566943f102f6d15445a6db87ce3734a48c7e150df78f75bbff00ddc522da83de34c1fccd67411f9ae156361df257a55e366ae9d3f215db3c557b5aa4ecfee38a960a109be4a69c57abff0080727e2ef116baba5dd16d4ae8158d88db26074af81ee2437dafcb3cec6577959d99ce7273debf42fc43a43ded94b12aaed742ac587232319af813c5fa05d783fc557ba7ddc5b1e3958ae47504f0457a380ad29a719caefd4d7114a119a9c616f91f43f802fae62d2b4cd334d891afae47eed9beea0eec7e95ed1a3de43f0fe1679354967b961f3b1e559bd07e35f3e7c20d7512ced2e0b869a0568c73ce0d7b8f80fe1e26afa91d56fa579e597e601d890a3b003a01fe15e56212849a67d9e11fb48297f49116a1757fe2c99c7cfe7b2b390afb30bdf3f8543e0eb1f0f58c0b2c3f67937121a44732720e0f27b8a97c6d671d96a8520678d21984aa627da1ce31b5fd47b561334f777256d54c9375d889f2d71c62e51d1e87a3c9af3257b10fc48f07585e788346d5ec92312c570b899780413c827d2b73c6baf58f84ad7ed7711ce6d55c444c2a1f6b1f539fd6b2751865b68634b8023321d92479c807b114ebed2dbc69e13bbb391c40c4794d26372820e4362bd1c2627d8ca3ccfddea7ca67183a589a724e3ef6e8e1756f8ed6d6b7221b7d2a56ff006e59428fc8579ef8dbe205f78ab51892eade18218c90821ce707be4f5a3e22785ee7c23aa2d9ea5b5a6541878c1d9229fbac0f706b075095ae6ded65823011142963fde15fa152a342a414e1aa67c1c68fb0969a34564b4922d49adae640b0b1c1dfe9daaa5ac603dcc0aac38243370411d08f7ab9ac6c596dae64632c922867c1e320f4aa9a8ddb7dbc5d27fab90e47d3b8ae9e55636bb6f53bcf0aeb875ad2504afbae21f91f3d4fa1ab571d49af3fd2ae64d175b4641ba39382aa7ef03d2b46efe20c092347f66903038209af1b11054e57e8cc9509ce5ee2b9d4f843501a56b935abb61243b96bd16e1fed1037738efd2be7cb8f19a49776f70b118da36e5b3dabdd7c3970baa69b149bb20a03c1f6af98c641465ce8fbbcb253f65ecaa2d51d1787674b8b24e7e64f9587b8ad1b8700e17af7ae774b90daea12429c071b863d6ba1560c3715cb57af467cf0523cdad4fd9d471160949f941e7de9cb2fdfcd55738cb81f30ef52453865f527815a995c9c8dcc00ea694010b02724f7229800dea4363b54734859c8dd9146a223b8ba856e9558e379da0fbf6ac8d7ac1ae1401c67bd60f8ff005b7d245a143965995c8f402bae8eea2d56c56646caba8607ea29357293ea70faa6801ad415ff005ab9e4f7f6abde01d69b47d5ed25724aa49b181ebb4d685d608653f857331b2c1ae08c7dd660715cb5216b346a9fb58ca9cb668faf744b85922041e0ae41a7788e312e81a883ce606e2b17c3772b1d9443a6100fa715b57328b8d36e909c66261fa1a26af067c751fddd68fa9f05fc55568fc4f763820e0fe95c049975e3f235e97f17a109e2698e3aa29cfe15e612131bb75c1ed4e82fddc4fa7adfc49218571c8ec457d03e116dff00116c9bfe7a08c8fc516bc0090f1b15edc57b9f84670be31d0a5ecf0c07ff001c02b8f16ace2ceaa1ad39a3e88f20e41155190a16c8e3b56ba9db1824e171c5665c4a83b8c1ac63248f97ab45dae8ae537478238078aa17d6fbe27c0ec7a77abed7081083d338aab2ce877724718a6a4998fb39c6cec70f191b594f06b3354c3c80f52060122a64ba325c3ef70a04ac8171cf06a3d454000d7b51d89aba232a40e5baa803ad412e2352472c7d2a69d5874e841e7d2ab45133124f19f7aaf2385e9a86594162064f34798e46d75033c62a668988ea6956d7cec6ece05160525d4890ec523a9ec6b1103378aeeb824adac638f766ae8459800f5c66b1b4f8c7fc251aab01f2a470a75f627fad1ca6b19a5765f7527f87b7e54223f07b01d2af470893ae00f4f5a7ac0918619e09a3908f689994cac3d7e94c90b28231f9d6935ba6e38e951c96c841c9cd1c857b48a33c65802700d26d57c807711d6aef929b7db155a3b0589cb0eadd68e463538ee4050953818a67947fbd57c443a8a4d8bfdea7c82550f3db2bab8d0f5349258586c6e403d455ad5aea0bc99aeadc1104879cf507d2abdc5c4fae69c25dd9b8846180ee2aaf85ee52daf1a2b95f32d65c654ff09cd7dd293f99aa57d0ea23b98358f0eae193ed56c71827048aced09b7debc12ba08a65da01e99a6dedabf87f5269238835bb0ca07e8c0f6aa96b135d4ad736ebe5aa9dc6307247d3da9ad514f745c0f75a15cdcd9c85840e70eabdc7622b4ac754bbf0fdc2dedaccc09c35bdda70d138e86a6d511752b0835057576ff56ea0f2be99ab1e1a30df5b5c6993aa93202d1311deb29d353a6d3f99a42f1969d0fab3e13fc57d23e2678592dd996dfc4d6d185bfb4620163d37a67aa9ebc74ae9345f0f4da86a26dd591323712c7e603e95f0fe956d73a47892c6faceea4d3b53b4983437319c146078cfa8f507a8afa0bc01f1af52f1378d974bd5e1367e24dbb92e2223c9b8007f0fa1f6afce27c2aa9629ce33fddcb5d7bf65e47d4c73a93a4972de47d3367e0bb4b35194372c39f98ff4ab074d860e12d902ff00ba01a8fc2fe217d52ce33750bc7303865e80fbfb56e6a37515b812a28545e0a6ddc5bf1ed5e656c56030157d849a52f2d4e98c711888a96b6661dc5824a87fd1c1e3fbb5f3dfed05f00acbc77a6c9736d02c1abc119fb3ca0601efb5bdbd0d7d35677b24c37a81e5938dbb40a96f61b4b980fda6da465ee5429fe953fda98272b29d989e12b6cd1f935e1eb4d7fc1be22782e2cae225b7984770bb4903f1afb53e1b78a96f74b89216190b8af46f177c28d0b547fb65b20760d992174c6f1e99f5af009b4a9be1f6b9f2b9860966658d58f271cff2ae7c462218bf82cdaec7d065f1fabc357ea9f43a6d5ed06ad3dedadc4a60b9f3372b7a8cf6ae83c3d676f6d14767691ac64fdf9db93f9d731a9ea706ab123abfef7d4707f3a34fbd9227559a491d33f750f26bcdb3b599ee2969a07c4382dad8491c4e65917e6671d062b2fe1b6af14ba76a2b2ab176b804281fc246335d66bfe12fedfd18bc7fbbdd9cc43a9fa9ae33c2cbfd83ac44b320d993048a47fdf27f3af53011a356a2a557667819a46aaa4e70dd19ff0018fc2327893484bb823334f631155461f318f39c0fa1cd7cecf76d25b3d948be4a97dc0e3a1f7afb6b51d3a5bf5312463cb6192ca3d7b5781fc45f823a8c377717da5c42e571bde1cfcd9efb7d6bee30d569e0bfd9aa4d25d3bdbccf889539e212ab08b7df4ea78ab44d6e1ad2e01dbd51bfba7b1fa5451a7ee66b5946c61f3479f5f4adfbdb396e6d040d6d29bfb5251d0c64301ef597246da82a21062b88c63e61cb63a57b17becce2b59d8cd90892de3e4acf0b6303ae3b1fc2a8ea96e240b7519dccc3e71fdd6ef5b26ddae67c4a0c573d049d327deaa4f6b22cad0c83cbb81dc0c06fad615692a91e59236a551d297344e69dddf83c0c7a57d07f09b538e7f085b063ba5dbb739e98e2bc3efed8cabbe340b20e1d3fad7a37c2186e3fb1a724305f35881d31c57cae3684a10b3d8fa8c1e254e6b9773d0752d4bec776b34721250f4c5761a46a10eab611cf136e07ef01d41f4ae33fb144a544b3ed2e33536897bff08d6a820126fb798ed7527383d8d72616a287b8ceac5d1735ceba1db4801c85e47eb559632b21e318a9a79502e76e09350248d83c820d7add4f1584fa82444024bbf70a338aa179aabc16ef36df295790cd8e7d00153390cd81851ed5c9789755df3f941be48bf22d4ee437632b572357919ae944adea4d4969ab5dd940b0473158906d0b9e82b3cddc6723287e503ef77f5a269d5e19047b0391f292dc0359b33e6e85e93c40d2b7cd70b9e9cb542970279c489246d20e410d922b8b97c3776f2eef3a23939fbd5afe1fd34e965e49591e4270307b77a96907335d4efedbc73af5ba855d4a64038e1aa73e39d7e5523fb56e304608de79ae605ca157fdda82581043f41e95720f2ee2665440338da03676d4dd9cae107d08afed0ea2de6ce12573c65d727159bace976da759227911f9d3fcd8da32abff00d7aeaad2cbed178109c4480966f451d4d7277d33ebfad12bd2490220feea8e07e94452b836edab3cdfc5ba7cf677714a2dcc30ca9c498f95cd7a6f85653fdafe1a9075304039fcabb2d43c3d67a9e966c2e625921db8191d3dc7bd729069a742d7344b52dbbc9da81f1d40638fe95c58b4da4cf4f09356947c8fa56e15d902e703ad673401884c7cd5d29b512c2ad8c702aabd82ec2718c571c6278b5276bab9cffd9088d81ef55dec4b607426b766b6c2f1c7d6ab4f0e029cf06ad45230f6b2d8f30921513b3606e563ce3deaa6a91e0649cafad685f294beb80390ae401f8d52bfcb443b0af7a3b238e5aa6653f200c76e2ab40b85e7ad5b6385cf7c557078f4fa55a5adce193d2c3dbe55f7fe74e8476c671e9da99210abc8a7db36073d0f7aab1089494e73c1f5ac5f0f47befb5a9d86564ba28a7d9405ad9da4724e5739c9ae7fc1134973a2bdcc8c4f9d7333afb2ef38fd28b686b7b459d1215438c0a4f964e831e94d2c3049a4121551c1ef556314c42b8cf407bd42e379031c54aec4
UPDATETEXT [dbo].[Picture].[PictureContent] @pv NULL NULL 0x8cf438a855b71229d85b0dc751f91a8e4755383d7a559b7b29afdc240a58faf615d5691e128ed409ef1816eb96ff000a96ecec8eba5869d4d76473ba668371a9386d8522f53d6b7d7c'
+N'190851f2a9fc6b525d4153296c8113a173ebed550cedfdf6a56bee7b14e8c69ab247cd9a65e4d613c6540ddf76404f515a9aae8b736656548b10cff32907355e6b07bfb28eeedd4b6462455fe757f45966ba952c6e242d167081db8435f6eb5f78f352e859b1d3af35cd1a54725e4b619193daab787e17b3d4a267236b9da413d8d584bebef086a92a8dafc60ab72aca692497cd5fb546a4444e7e5fe035514b52b7b588f57b2974bd4a48f05509dcbdb22acc533595dda5fc4d8877824ff70e7915bdab4b06b1a2d95da10d22fc8e0f5a7784a386ed2ef4f9915924424023bd559f2dd0d692b09e2458bfb444d0ba34738122956079ef4dd54cf2c3a7eb96d2186f2d082b2a75475e86b027b14b0bef2c0608adb5d0f43ce3a76abb7ab79e1c69eda0732d9cea1b648370da7d3e958d48a925168d29c9a7cc8fbebe1f6af71ace8ba35e34644b7b6a93c8547192a3247e35e86d04621c4fcffbd5e43f093e3efc3bd53e1ae9967a9eb3a7f86756b4b45b674b993cb7050637ae7820e33c5701e2cfda4fc29a65e4b0db5eddf8a1f90a964098febbdb15f8ee27856ae37132abcfcabd3fe191f635b38845c528dfccfa4e3d42c33b239a1523a80c2a4b8d6ac6188892e615007259c0af896e7f690bc999d6c34bb5b16e70b7aaf363d3b8e7f0ae2b53f136b371e26b73a8ea2d732bc8acea8488c03d82f4000aeb8f03d393d6bbfbbfe09c1fdb13beb0fc7fe01fa050eb5a64f954bab565ef8954ff005a8751f03699e33d2eead0a40ed728537b44ae41038c1ea3f0afcf7d643e9daacdb18a90db90e7ad7b57c3df8557be3bd2ceb33788b51f0fa4910fb29b595c6e7fef30dc3e5fa75aeea1c2b1c14fdabad74d76ff008253cd65515946cfd4a7e2df085ef80f53586ed5dec9d8ac77238c107055bdeba0f0f6853ea96ab2dbc32cea48c328e33e95ce788be17fc423671594fe218a584e4146ba69fce7cf042904e48af79f877a5368fe1fb1d3e79a37bab78d63b8ba03f771b7f754776f7aa964f094bde9e9e48f469e71529d3b463af4b997a4e8da8dac7e44b65296c7dd51b881f8560eb1f0bc6ab7d706469aca4914b47188f2491dcfa57bf417307876d8bbc7b148f96363876f735c7dff00882ee6bdbaf2208e4b4906e88382d2237fbfe9f857451c9a8d3973b6d9c55b38ad563cb6499e4bab5d6a7a75d5b5835cc71b48a1142a1de48182707a7ad42f677f3c863b5918e78f3243fcebd1f51b293579c4b716b0c778ebb5e4881df27d476a9acbc0d7b2ab2c68f106eb9e2b6795e1d4b9ac727f695771e5b9e432780a48a5fb5dd286620bc932c5f28e98e7bd58d1bc0d6ade64f6a9617129237acb0060fec38ce6bd5af3e1cce623baea076c70858e4fb735e6fabe8b7fe1bd520bcb162a81b6f908b919ef9ae8587853778dce6f6f2969226d37c0fe10d7351367aa787ecedef0e76a3c5b0c8473815cff008eff00660f0af882f666b28e6d2d836d0607c85e011c1fad77fa0cb67e2cbf498c696baac243e4afde23a91ef818f6c9aec9adf22ed890064156f41b4577453b5cc5b47e75fc44f85d7fe0bd625b3b96f3d7ac17b1a90b28f43e86ba8f08d9a691e0ad326f339babaf26700636e4d7d5de36f0e41aa490d95cda422da6888512a8dadcf73ebdebc2bc5fe029fc29a55f69f6f6ef7101956e20503254839e0fa579b8f8caa534b7b33d7cb274e9d46e6ed74670d161375aac4d23130c6ac80ff082335911c115c6916772adbe6ddb189f5e6b666bb46b8b89d9cc6f7165f321eb902bcbf4ff0019c7a4f842ea0775fb6c3705a242324826be7214aa493696d63ebaa4a9526949e8cf56b4f1868d2411c73ea56f1dc636b46ce3208a957c49a2b21dbaa5b15519244a0e2bc2b11df5dc9ac5d420453021228586edd8ebed54fc9974abd8cdcdbec807ef0c40f247a935ec467a59a3e6e705ccdc4f68bdf1de8b1c9e5457a93cec70ab165abcebc71adf936e9021512bbef624fe3fe15cdf84556ef5d7971b5232582fa555d7af4ea3af9568b2a1800c73c1ad96e70cdeb61487bb79a795bc92173f26704d316d9d9e106e5806197ebf2d586df2c48a4a9333f381dbfc8a04afbae65e30b88f38fe55a58c1b2bc71cad1e7cf3967daaa18f4f5a74b6afe6ca12e98a46bc12dc93e95722465bb8e30a98823dfd78a647968146ce6e65c8e79ebf4a5626fdc862b4b83f6753707749cb0dc7e415e8df0bf46915351be92432a47fbb8db39049381fe7dab8e3859e69b682624d980781ff00d7af6af0c689fd8de02d31029f36ecb4e477201dabfa96fcab296c0d916b23fb17c11777bf765bf97ec90e7aed1cb91fcab92f02da79faabcc465615fd4d767fb42463c3fa8681e1a4c03a75824938ff00a6b2fcedfa605627806d8c7a4bce47cd2b9fc871fe3536b233674e587a71595ad582dcfd9e718125bc82407dbb8ad22707d055794e411d462b394799345464e2d491efd692ab5940ea3ac6a7f4a8f608d70016f43587a6f8c34b4d12d5a6bc86191a14cab38ce40c631f85655c7c4dd1e06fde5e82413858d4b6457977e5d05f54ab5758c59bd7d751db4bb1dbe6c676e2b366d5ada40b86e41c57337df156c55de482ce59c918dee02915f3f78bbe286a71f89ee0dacaf1ee6f9577e42fe1442f395ae6b3cbe70873ca363d7f537126a77657253cc3861d1be954ae1498f073543c297b25f787ec6794ee79230cc7d4d5ebc27cb041c1af792b2b1e04b5465b02323f0aae07519ab2e7620073d6ab3c815491f9559c1242cbc82454d6815a3397c1ec2abeedc8141e7ad488485237751da989125e49e4db487390149c8fa573be073b3c2ba62e79f2b27b7526b6aea4d9693b13f7636e0f7e0d62f821b7785748cf24dba9e0734cb76703a0524a00714f6711aa823762ab96cc981c60524d2a2465cb05da3927a014edd8cd05c5c008c4f02ba0d0bc272ea51a4f3616161b87b8f735e6baafc43d02c55b37cb330fe0854b67dbd29b63fb41476560b6a1a59915b282484a90bdb3eb43848f430f4d735e713df74fd3edec902c0a9c71e73f0a3fc68bb860917e7b812b9c9073f2e6bc2dbe384779b5a59cc633c641007b7a54f1fc478ef0616e9013c8e6a2e96c7adaf63d6eeace1993723818203267a1f5aa474e93b3c647ae6bce3fe127b8b8e63b9cfa9539ab4abab3a860e704647ef40feb53cc89e67d8e0743f109d21e4b655dcaff002952380d5467324577290db096ce7f95615bddb1b9591c64336ffd6ba8d46d19de19946e59141fad7dc425cd66b63c9e5697a1735689ee6c2d6e8a9724052d8a9fc371b37da6da41fbb74c853eb57f48d53ed5e1f934d3096993e640075155f43d523b0d5e09264d8a0e1838e99ad947468bea8c84796ca6d8598046c3276ada92f25d12f6def2d5810c376d3d0fad5af11db5ac9a83cb032c904b860e878cf7abd16956facf86d8a2e2e2d8e3e53d450ef64ffad068cbbb99b5081f536876a3be1d54e706adea3abc3ac6996a2d14b5c409b240dc1aaba35ac4664b499dcda4cc03afa1ec6a7d7fc329a0ea452095c46406463dc526a49a8fdc3d2d7e850d2817bc8adee91023305fde0e467d2b5754d0e3d2b529235f9b66194fb54b3e969aae829789ccf0b6c97dc7ad32d74db9d4ad2e241764dc5b2640939debe9f856764b568af2347c51690a8b4ba445025886768ea4556f134f1c57505c03859618d948f5031fd2a13757dac6990d98815ae2dc12a50f2cbf4ad3f00f81bc41e3bbb163058c9716b1b6d92678ced83ea7fa75a89350d5f42d7bdb11ea337fc2436f6b2e9f1bde5c84db247121661f5afa77e1b78a351d5fc2da449abdafd9e5b38ca8b3c6c5f94606703a639c56bfc21f008f03e8575670e94bf39daf7ae01676ee7279c7b575da5dbc5f68b9b6b984436e21ca8c739f5af1eb557517ba74c528bd4ada76a173e32b9fb15858c5a7c4a3f7d36df99077c1ed5b5a3f82a7492e2f0cbf65b1b352d0ac63e69580fbe73d3daba3f06786574fd165900db2de30249eb827fc2ba2d5c245143a7c2022ca30c7d10726b86106ace5ab3694ba47639683c37094173701a69080774adb8e7f1aa3320b89cc36c81e427031d07bd6b6b1a91d4655b4b360908f94cb8ce7fdd1deaddae9c74bb6f9156df3f7a59b976fc2b5b985ae53d27c3674e2f72ed1073fc730e054d35cc5233209e5b9ff0062dc6c4fce924115cb7ceef7247f131c81f874a3cc4886d54fc40a9b771dfa19f7ba5da5d4445c247145d7cb8fe6627ddab86d63c376b19616d2488339da4d7a2cd1c97230a9b077635957fa329421e4504f73cd203c7e5b59346d496f22c79e8db837ae3b1aebbc3fad8d724119c4786323a13cfb7e02af6ade19125b3884832638c9c66bcfae23bbd0b50599a265646cf06853e4767b1495cf50d5ec1750b33185122f5ce3a5798f8daf2c34ab296dd635babd2bb4203d3ea7b7d2b36e3e28788fc55acff6769da44ba7d9af06424879074c96e807b0a4bcb3fb3e21bf83ecee785de41ddee3d6bc7c6e3dd3d28c6fe67bd82cbfda2e7aaede47ce9f182792d6dad7ec70cc9248cde7c8171b57fbb9f7af1bbeb7786452c3395c827f887f8d7da5ac784adf52b775c2c8a7f848af1ff1bfc1a796dd8d8aaa30390a4715861735a4df2d55cafb9a6272ea8b5a6eebb1e032cf2da5cc722b9dab8298e303d2b625d56648caff00ad5b84e647192a07207d6a5d5bc2f71a7b882fa3f21d39527a1f6cd635bbcc6f255230194fc99e0f6e2bb2ac17c50d518d29b6b965a346d785145b5b5ecccd83b79239c76ae76ca5f3ee2e67f30ba9278e7824f15d4e85a65d4da4de416903dd4edc2c68b963c1edf9573d6d6f3e9c82da7b536d2b5c796d132952a47ae6a22d5ec73493bb91a1fbb5b9407388e3248c739f5a8a02af6d6c371dd2c9b89f6cf6a74f23ac9a8395042aaa13ebd4f152c2089ed97628f2e2dc07e15b1ccc70907977ae1ceee1539f6ab9127fa4c0a5c848e3c93fed554b7264b341b3892527af279ffeb55c8a656b8bc201caa853fecd022de990bdc1897ef3cd38f9460e467fc2bec0f0ff0083bfb4be21f84fc36572b13db4128f40882493f5635f357c26d046bfe3cf0ae96abccd770c6323ef65c03fcebed4f868125f8a3e24f1095023d2f4bd435153e849654ffc7718aca4aec3b1f20fc73f117fc24df15fc51a806cc4d7b2247e9b14ed5fd056f6896d259687a5c71c792f0ee624e39cd7966a370d7b7f2c8d9df34a58fae58e7fad7aecd0bbdb5a244c631147b0fbd4cc46b58680f7b0bcb24e8817f85793591771886e258c1242b119a207b9b4394b8653ed51cd233b33b9dccc724fa9acd2118770a45d3951d0e47148db88fb83752de5c88ee5c1049a80dd13db35e1d6d2a347dce12b43d846fd871de011c64f1c0af12d75decfc53789212ee818eec77af6967041ce73ea2b1eebc3f657b334b2db895cf76aaa3555395da30c6a588872474377e1bcfe778374e7182361c11dc6e35bb7b27ee437a1aa1e17b55b0d2a3b78e358e2427622f000cd5ebf1988f7f6afa0a73538a923f39af074e728f6335db39cfe5504872a738e69f370c477ac5f136ab2e93a34f7288ad22e386e95aec79aa2e72515b9a6ce912e6491517a64902aacbae69f6c097bc8540edbf35e4175e2579a555920494bf3f331e2b3e5bf404909e59ea5739ae5facc5ad8f7e393cbac8f5ad47c73a3c70c88277977295fdda9ee315cbe89e3dfec9d0ec6cd6d0cb341188cb96c038ae23fb51072f1b367d299fda68a7807143c42378e55caacf5f99dd5cfc47d4a462628a1873df058d655e78ab56d451964bb60ac30caa0018ae746b308e195bf2a5fed8b6c8e4a8f5c566ebdfa9bac0286d016df4cb0895bcfb669998e77094a63f0ad0f36c5e2f264b7ba30b208ca8b8046d072074f5acf17d0480e2507eb5324b0c8bf794fb8356abbfe62de1e5d626a59b6896ebb71791af5285438a5bb8f4292df7233c921206df2b69fceb32368492377eb520f28f49001f5a5ed13d6e47b26ba31b6d15adbbbb432dcc03fd86ae822f185c45122072c14019688127ebcd620116de5d7f3a5108c71b7154a4fa321c1754743e2cf0b9d22f2dd114088c607cbf4ad7d2655d434536640fb445f3213e95d378dacc5c5941385df98c6303be2bce74dbf682fb736e52adb58d7d9e065cd4b95bd51f3f1a9ed2edab1afa5eaada6dd25c10460fcc3dbbd6cf8aa582e5a3bab50ac9280580158bab5a0864495798e51f91adaf06da26a7e75a5dcbe5c7b49438e4d7ab76fde5b9695fdd29687307f32ce73fbb939507b1f4a40d73a4dcba248f1f6c0e370a9858c56f745436f789f19cfa1aecbc51a7dadd69763a8c51af2a1588aa716acfa304f4ba39416d24b61f6cb466ca1f9d0f383ea2b57ed971e2c9aced4c6b14c06df318f06adf8420867ba9ac8007cd4cedcff009f6aa684685ad216c810cb927db3fe1472b4da7d3f40bab2eccb36af73e1f7beb39224943fc8c0b703de9f79a3dd7871ede48ee148b8873823b1ed4df145db5c6a93dc5a46678e401c320c81c77f4a806ab79e23921b79e2d922a85899471c76fc6a74766fe63f226b7d0047a39d420bc992f2373c2376fa57d99f0834783c2de08d22de395da79235b8b96ce0c9238dc49fcf1f857c69a778823d03fb42cefa26b6b868f09f2e4135f6a7c23d56c3c65e0bd2ae232c923db2029d191c000820fb8e0fa57978c76492d4e9a4ae8f468ed639a312db4a825c9628f8c1cf5045674f62b71abc6edfb947658e45c671edf4ad3d1bc2b11b532de4ee5813b638c81903d49ab72e9525fa30b4b37674e0497330033db21726bc946cfd0dbbd2965676c2264da6450a4f19f6ac7d4a19f55bc924dc22b58d3667bbf3fcab0603a8ea7ad3695ae3c118b30b74c2d519108edc9f4fad74da6ddaead3dc18d192de3202ee18df81d47b536b950f77a8470db6896be7b60cac3033d6b199e5d466dd22c8c0f41d056e6a4f6b68564b826594fdc8fa9fc296c21927cdc4cbb3770918e8a3fc6b3b8ec65fd9a51855500f651d0548b6c22fbdf338ad293cb86377dc07bd56119907984e13b0f5a7b858ceb8124bc6f2a3d05575d33272d9c9ef5aacc33f29dcde8a327f4aaf75a88b421762973d9d8027f01934598b4ea67cda4238eed5cfeb5e068af50b062091fc46b7aeb5abed871179607711f4fc49ae4755f11c93964796e5d7382d190054b4fa8aeb6472a34fb8f095f3473976b790e11a293ee9f7f6a76b9e1cb5f1544b06a2859a220dbccadb255273dc53f58b259623224333e47de7f9aacd9dc1bcd2eda797e792320038f994af1cd79f5a92ebb1f4380aee4b91f438197c1daf689f3dadca6a36cb9dc937c92ae3a7b1ac7b4f1758ea76ff00be4781ce571221539efd7debd32e7c542262f059cb30ce1988c0cfb572fabebb657d791c074d0f70cc4f96804807b9040af93a93c155a9ec615173f6b9ef42bc6324ae785f8ecdbdcdfb44c88cadc8381c8ae3a0f0f41777b1c50c2ab2e7e5651c8f7cd7a9f8f7c1f1eb773149a6c46c250c7cd6906149f61ebed5ca7fc221a868372b7915d095d01ca6deb594b17470afd8ba9a9c55e74dd4d49f44f08ae88f27d9ddc4d20064914f4f419aa3adfc3db1d56f4dcdd899a4fe29627193f5f5aeb341d6ade4b010c836dcb939ddd8fa55b8ec0dcce2211f2fcee0718a7eda6a5cd73ae3429ce3648f356f83ba76a50de2da5f4d049b77af9c38247a7ad798de5bbd86af716d231530c441c9ea6be9af12c72da1b6b6d898401a3994719ee0d717e2ff0003daf8831a8c36c1259536c81473c76aeda18e953d6a6a8e0c660928b74a3aa3c4ed1dd62d386ec33bf23fb9c9352ace443a836d070e0607f1f1d6b7e6f04a432da247218bc8ce1251f7f823ad73f7da65ce976d771dc2b472b4b94620e31f5af5e8e2a957d60cf9c4f43dabf6608c4bf1afc3ace0116ab25d0f6f2a1793ff006415f4e78459b4ff00861f17f53ce2483428ad437a17539fd6be5cfd9926117c4eb8981f962d1b5075e7bfd9241fd6be893aa7d9bf672f8d33ab60b5c59419f6c8aeb5b8d6e7c630fcfab5aa7f7a651ff8f0af66b9768ad5de34deeaa4aaf4c9af14d366075bb2f4f3d0f3fef57b6330c1feb59cb7224cc0d36f358bbbadd796915adb6d3c07cbe7b5683d587fcaa9dcc8218ddd8f0a09a9dc48e7afa50d7729cf19c74a8d064f03f1cd58b5b67b88f7ae0ee3ce47356058b29fb809fad7cf5697ef19f5b43f851b762a47048e720a8153fd98ae3281be869c62646c18f1f4a961850f24907d0e456173a2c8d0d1b8b6db8390c783535eb7eedb3dc545a70540db4e413c9a7ea00fd9f8c9fa57d361f5a7167e7f8e56ad512ee666d0496c938ed5cef8df9f0e5e0238007f3ae8864a9e0e7bd6178bc6ef0f5f0c7f0135d0f54cf2e96938fa9e1f75007756f99885242f41d6aac914ae091130cfe9562e5d9db60ce4293fcaaf69f14f716fba36e8bc822bc557e547e88d2bdcc5292aae3611ef8a8c47212096031dab65ee4aaab10b8624038a89c195d36c418b740a2a2f2ec5a70eaccc68e4c646d39f7aaf209220c5946dc75cd742ba64c47cd0a20efbda95745b437314b70de7c68771857856f626b484672de27354af4a9af8ae6c7c36f8617de3585efae58695a34472d753f05fe82bd06cb49f857a75d45a7b3ea5ac5db38406d6366dcc4e3b715cd6a1e36d4b55d3a3b2548e2b18c612de34c28fc3bd57d0fc5575e17d6b4fd48c4b2c76b32c8611850c057a11a708ad15d9e3cb1339eadbf91e89e35f855e11d31e4b689350b4d4060ac1c30191d09cf06b84d13e1759cda8f93a86a26ce363f7a45207e62bbfd0f5e8fc777735e2b796039791a538e4f415e91f0c7c1163e29f1e691a4c8e2ee3798492809f2ec5f9981cfb0c53951828bd07ed6a35652392d33e09683a5e9ef7518fed5709b9155c2ab9f406aaad9d8c6a15fc1726f5e1b19233debeded73e086817b0b7f67443496ea1215cc79ff77fc2b897f813ac8760b7d6a573c1dcc38fcab82ee3ba33ab46a54b38cedf77ea7cb91ac7a868569e62ee592156fd0570daef876082dee1d908953e78e4c7de5eeb5b1a078bf4e4f0be9de6cadbd2054602362148fa0ae9a0b08f5db0c4603ac8bb91c720d7d2d2ad2a33e781f2e94a9cddd68799698cf7d02d815f337e3c960338c76fcab5ed273a5cf1ca8bcc4795f5f5151da39f07f89e24922de884940ddc37f8547e2195a6bf9248c7931c8321457d7d1a91946f1da4753e8cd6f1ab58ea1f66bdb54daecbb642bc73eb59de1eb917121b19d98c2df7412700d3f434177633d937cc4fcc80d53b36163728e50978df27f0ad63b3453df534c69b26977b2013b44ca7ef062091f5ae8b5b8ac2eb47b5be528f2600703b9ef599e2271acc31ea302ed40a15d01fd6a8e857263bb48586e81f823b53bdd69ba16da1b3e14f12da69b2dc432a9114cbb738e3359b7573716176bb602191b72376233c526b9a3be9d7eca8a30df329c76ab3aa4b75a868b6d7c8ea1a01e43a81f91a8f68d3e6ee5d9356ec5fd7629b50b7d3f58b8863746701a06e770539c7e38afa2bc27f1bbfb725f0fc3a65bdb2c723017523c61a4b75031b5476c57cc96fa8de6bba5d9e9f1151711395008c023d6bd2fe11f87f52d13cd9ee2d819ddb0bb7030a2be7b36c4c2851e6fb57d11eb65d41d6adcad7bbd4fbd2ce2b692c23916ee1915577061200706b1749f1ce9a7c4afa5417f6e6f95772c5bf2255ee011dc7a76af117bd9eead3cb9d5738e839af36f16788a6d2f52d3a2d3ad4dc6a62e50c288db18316c0191d324815f3586cc1e22a2a6a1bf99ece232fa7420ea39ede47d53e37f16682355d36db56bf86d6e267d91db2cbb0cddf07d4715b91eb6ab1bad943b99f1b4e3014638af807c730f88af6fb5f93c4eb2c5aba90c165ff0096433cecfa7b57ba7ecf5ac3eb165a5dee9fac4f25c431f9379a7c929915b1c670791d8e6be9674a31829277fc8f9b84f999f43c11885cdc5d666b86e7a74f61525c6a934a36ac4d1a7b75c5578ad351b97c9b910e79da1735a31e8ffe8ecb737b249b873b462b8ee8dacce72f75708eaa88d3ca0e1517845fafad695a25e4f10925b379df1d246db18fa0ff001a965d2aded7f7d01f2020e6791b00566daf8cece2be681a5bcd45949078db1e7f1eb4a55231576ec28c25265a41797f31b7693c84e9e55b0c7eb5ad63e118ad46e58cc0c7ab93963f89ae7355f8873e9081e0d291d48e9e6e31edc0aceb5f899abeb303bdbe90b1aa9219b25b1f4cf5ae5962e9257e63a161e7d8ebef7c21a74c3f7f713499eaa6527f95737a9683a3e97b9d24f2c743e74981fad711a8ea3ac6aef7919d4ee8cdb372421b62a91ec315e7961ab799797115eeefb66409526624961c02335ccf1d0fb29b34faabdd9e9baac560378fed18adf8c9024cf1f80ac44b5d2238a578f5a66908fb9131049c7439ae75de4bf74121daa38f9075abb6f8d2db729539eab9cef1efe86b0963b9b4712e34395de2ec68e9f691b5c9b5bd82e2318dcbbc829203e8cbd3f1a8bc53e1cd37488611a734637cbbdd5ce5beee319ce7bd6de85a8d94cc446e8247ecc7e6fa53f50d26199cc93448e06595d872bf8d7895a9d09467ece9284dad2515668eb853945dd4ae7945ce9f716f2ac12fd9e7b32bb811261f7e79057fad4161e1fb4d635130481e38d0177287a281fe45757acf8797548fccb165322e482a73b87a035cde9ff6cd1ecae4cab9b998e0e3ef2aafdd047b9afce2b606a50c573d5bb8c55dbd7de7ff00059d325ed2a28c56e71fe3bf0243673eeb28f008deca87257d307d6b3bc29e208ac6ec5bea24bcb82b1ca78fa67dc574be20d524b58101c1bcb82552163cfe3e99ae6b53d06796d63b80b19b8232d0819c9f406bdfc9de371b4dd49c6f0be9dffe18fa8f630a494693f792d4ddd60ca23ccb1ade58483e691064a7e15c9ea5692da4e9259de3465cfee9837ca4fa30aab61e24bcd0a60632d71612af1039e54f7193d2996022f16789048b1b8b688ee78036003fe35ec36a927296c8e4ab2b6fb9cfdc5f5fddea324d280ea09df12afcbe87154b54f2ef9447e4284c60e4751fe3ef
UPDATETEXT [dbo].[Picture].[PictureContent] @pv NULL NULL 0x5ea9e2ff000fc0b69fdada62085e3189523180cbd09c763ea2bcde7830c31d3a8c578b3ad38cfda41ee7c3e2e751556a4697c1fb38f45f18dc5cabac713e997b11ded8209b7703eb93c7d4d7a9de6ab9fd9b7e2f400e49bed3e4ebdb7e2bc7ed6cae048b35bc124a1396daa48c77cd6f5df887fb0fe1bf8dfc3e2da4b91aec504b14a1bee345206e47d335f5b97e60eb251abbf71d26e71f43c334cb8c6ab68de93a1fd457bce411c57cf169294bf80f4c48bfcebe820c0a57bb21496a23b77ac7f10394d3df071b88071f5ad46e9eb593e203ff0012e7fa83fad41256d29f319e4800f4cf157d656519'
+N'ddf9d65e912c5e43090856dddeb57c88e4505586477ce6be7711fc495cfabc33bd18dbb0f12123fd58627df1520c32ff00ab20fd454691286c307dddbd2a4590c6c3712003d481815cfa1d7664b6c362b6571f31ea29b787f70dcd32eef22b45669e5545eb927ad733acf8fac6d63654cc871d7b57d2e19feea2cf85c741bc44d25d4d743f262b13c4ce8741bc0586e3190335c75d7c40bbbccadb8112f4cd615f4da85fb7ef2e1df3db35d3cf1bd9b392383aad29f631a6b2564492305a4390d93c018e2a6d39a4b18c825589f4ed56a1d36607e63d3920f7ab2b65803800d714a9a83d353e969d69555ef68658b384c0093bb6b1215fb53adde673b572abd3e5ef5af6fa7c21b748455c47b2b4041db9078ef446128984ea424b4573263d2ee2e7000ce7b9ef5d4e91e13d121b659b54bdb891fab5b5b20047fc08f1595ff09259c52ec66dbc718ee7b0ac0d5fc78a2e85b2c6eafd0f15d1ea70b8df54b43abd6aff004a8a375d36c5a145fe3964dcff008e38ae1f54bf29b95f208382adc1157b55b2b98b4237e6765563f701eb835c0a24de21d7b4fb4123b99e50a79ebcf3fa534d2d050a6e4b9ae7d09f0e2cdacfc370bb2fcf704ca7e87a7e95f58fec87e1a371adeb1adca994b6845b444f666396fd00fcebe71b0b64b2b48a141848d0281ec057dc7fb387868f87fe17e9f2489b67bf66ba7e39c1fbbfa01454768a5dcda115747a837a54591eb523639a8f77b5731d1e87e67f836dc5c7c3bb746c6f11b296f7c9eb5d6fc3287ed1a2d9edcb15cafaf438af39f0a78b2dfc3fe1b4d3a551752ee6dcc8dc006bd3be08dc412e8db7cd53324eff00bbc8dc149e38fc6bd28b52774cf99a94a7194b996847f15bc00752d37ed76ab8ba8cee5238e7d3e86bc9f79d534c593056e2038743d411d6beb0bbb78ee60921906558104578dd97c25d4bc41f114c1a722c563313f6b9df848b1fc5ee4fa57a981c47b397b393d1ec35aab33cc74bb97b5bd8e5fe1c807e95dfdbfc2fd77c6dab409e1fd366bdf3c0dceab88d3dd9cf0057d1de0afd9fbc11e17304d2d849afde06dc5ef4feec9ec1507f5af67b3bb8745b68d1aded20dab886ca250b1a0ed9038af5aa639ffcbb8fde09465a6e7cefe0afd90eee2d25df52d64798e0ee862b72d129ff007c919fc0561f8a7f654f13787ec9ae74796cb59d83718213b24f5f941ebf9d7d44baceaa44f3eab3c5670ac64ffacdbf4dab8e9ed5ce3f8fae75aba363a3db79a47caf7b29c053fec81debc59e6ff57bca5517e0cefa582ad8969528dff43e39f13e97a8c8b6f1dcd8cd16a518daf6cf11565fae7ad6bf843e1e6a12c6ed7e8ab6f2f3f6723bf626be9bf12f826dae2196faf6e1e5d440e5e4f98e076cf6ae7742d365bfb68628e1324cdcaa20c93efed5e062b89ab568b8d15ca8fa9a19252a5efd795ff23cef47f869a7e95b64584b3f673c9aebacf48600057089e83ad7a569bf0d65b86517b2f951f5648796c7d7a0aea34cf0868da7b96b70ea55401f28725bd493ed8af2230c4e323eda4efea6d2c661b0fee525f7688f36d2fc2da85eb22dac12cab9e59c855c7b93c551f11fecd5e20f1278a6df55827b1d3acfca0b2acb2b172d9c82028e3f3af67b5d36f8e4391e5939c22e3f3ad51a55cca17cc25f03b9fe95ea65f4a5869fb57a3f53c9c562e7898f235a1e791784658f40d3f45f15b595dea7cc71ea7b3725d73c2499ef8e33dfbd61e8df0abc33e1df12a5f5a580d3b5885cb17b40d16d3e85470df4208af5f6f0fc1711b2ddc02604e46e19c7d2a9da7da74eba1f6cd3db51807cab2749913d03771f5ae1c6519fb653a751c13dedff0003fe18f0dd1b3524581a87d86ce29a791551f8c9ea3eb58daefc4bd1f41d36e6e9af21b99621c5bc5282ecdd863dcd74777a425fc2f3c72992d3f8a261878c7a32d78d6bbf0674dff848acaf345f221b196ed65be8a524f039f93d0920020f6e95f494e4a9d14e4f9acb73584b9a4a274b79ad6a171a4432dfb66e6650ec83844279da07a0f5ef8aa5a4684d7f7057ce2cf91be42c47cde829babea0ba8de2a42336f103f37f7cfafd2b6fc2eead15b1500665209fa0af9e9ce537ccd9edc62968856f0bb03892e240c3a090075fa8a9ec2d24d3671199848b839dabb47e55a9a86b7636f2f9525c0329e0469f337e554275baba3badedc4408c6e9bafe5583bf535562beb1a7dbdf465d9bc8917a4ca704578ff008afc342f6f8085965ba0dc4c87861ee6bd3ef3c2b3ea04f9d77231fee8e17f2aa29e069d2e5713c7b73d48e40a49a40cc7d0bc03e468a1659cbddb9de5bb2fb54c3c2b35b0cb3c613382a88315df4564b6d1ac60e7031cd55bb91628c87c63de95d8591c70f0c5adc9f27ec50a4e4fcd338c301ed50eabf0ea4b9b1782db5578c75f2c9dca7dbad5dbcbf13ce4469bc29f9989ebed502eb9e41fdc5985957a18db86f622857ee4bb1c42785fc47a14ec63cec53c188ee423e9533c914f716f35c0486f2339c370ae71d0fa1aecee7fb6b534dd88f4f88f5390ce7fc2b9db9d36cb4a90bbb7daae09c939dec4d455a71ad070a8ae989371d51e5176979aef8a2f2eae6c5ace541e5ab14dc0a8e80301c8ef9aea747d42cbc3fa76a3773b38ba081115f18e7a103ae7b5759e46b9aa0c451c5616c7819405b1599aaf818cf194b8ba1231e4ed8c0fd6b7c3c961687b0a6b6d8ea9621ca128db57d4f24b4f09a789f55b88e09d444773292bd198e32707a0aecadbe1d58e8d7362fa55b9b69208fcabec96c4a4a821876273dfdeb42c7c2773a15d34d605892369017777cf4ae814eae6da692526dd76e3cd9230a13dc735e15786326e70f75c65eb74744712b9545b77ebd8e1bc412db5b47246f2aef954abc69f788208248e80d7250d969f6f87b6b38d950e375d3ee2c7e9d2b7a6d1c4734a5775eee272f22100fbe6bce7c63f0feffc41a8c308d56586407220518545f7c5561f0b5125095a115d7e2679d569c2ad5f75731d735d5dcb79261c20c0455806d419f6f4eb5997bf66b98dc4a087dc76b05c8231597a7fc28d7b42b91716dab4c1ca956493e68dc118e56a9df5878ba2bd5823874f7e4908c4a97fa1a9951afcdcb42a29fadd7ddff00ea8617d845cabc5af4d4f21f14e9cba3f89268a33988b874c0e80d7b646dba243d72a0fe95e6fe3cf0b6bf26352bad1a5b74854f98e8e1d7039cfad5fb1f8afa4bc71c6e93c4eaa17e603b57da616356a518b92d7ad8f0abb846768bd0ee18d64ebe33a7cdf41fceb353e2268ec3e79a4873ddd0e3f3146a1e21d3750b29d20be86462bc286e4d6ee9cd6e8c14911e9d2858986d0dcf435a11edfbd8556f6ae7e3ba58e3009041ee0d3ff00b4153eeb30fc735f3f888fef19f55847fb989d3a5e0420190e00ee6a96abe21b7b1b6265994739f2f68258f6ae6ef35e302e15c16ec08e2b9e9229afee59dd8cb29e546781534e8736b2d8aab5f9748eac9bc41ae5d6bb386c08a351b4007b56545a7091886cc84f26ba2b3d11d93f7b8007524541753c70c9e45ba19643c0da326bd08b71564ec8e0714df338eafb9971e8f0c64c99dadde992dd416c30b82c0d2ea7f69827786e711306dad839c1f4a96c7447b891e386325d53cc2dd4815ba8f36b2679f56b2a5eed3d0aa259af0911a88d7fbf2718a9ac1ad219449772f9e179f27a6e158da8cd2859d0315298fe7593a6131ea52a96dd953deb39554d72c51d34f0adfef272d4dabbd561d4249a2b483ece15f1d4922b3753be9c590f986f5629bc28048a6d87cb77758e46f1fcaa0d454b59b03d7cc26a39ddf7348d382e852b9206a16cc3b843591ad301e27247193fd6b5af78b9b53d32ab593aca93e2104fad5477154f8743d2bc592227806d0066240248c7039ae5fe0968bfdabe297be6198ecd0b0e3f8d8e07e99adbf196f87e1fc4c73b58719fad757fb3f68434ff000bbea132e3cd2d3b647f08e14575db63cba4fdcb1e97e1fd227d6b59b1d3e2462f753a4238f52057e89e97611e93a6dad9c436c76f12c4a07a28c57c4df0d34cf14ea765ff000935888ada0b4937c5919c85ee2beb8f871e30ff0084d3c316f7ee152e87eee745ece2b194e33968ef63a145c6d75b9d439c533343b03dea3c7d2a4b3f222381ede420fdd3deb5f4abcbdd26e92eec2e1ade74390d19c7e7501789c00196407de9429b721864af6c1e95abe683ba3ce84a33dcd7f117c49f1a5cc27cbd49dd4af223f90fe98afaf3e03e986cbe1ee926e771b87884b33b72cccdc9249af8f2d84770a416e6becaf878cd3683a65bc6494f2a370cde9b719c77e4576e1aabb36f526b52518687a35aea1b6e425b2e65718f34293b17dbdfdeb7342b597ed0f77711a9da7f742450c41eed9f5a5d234bcc4bc601e83b9ae9ad749221fde371ee6b69cd2bdcc69c64f5868797fc5c9646f0fde4a923a337cc5c9e87d8564f8181fb15bc56d888141b8ff9ef5d8fc5bfb2c5e159aca00af3dc308c1c74cf27f406b87f03b3dbc1a5ab70660cd93e80f15f19994a9ca4953b7c8fb9c86938d39f3773d06eb422f641de5126464863563c0b6fa768df69b39e258a47fdea38eaebdd4fae3b0acc7bd9aead752863392837039e94693702686c6e65c86b7711c983ced3c57365fc8abc79b667a18fa729d0925b9dc4dacc0015820665f56381f9556fed3b92331451c60ffb39c7e75a72d9da3045823da40c311ce6acadb2ac046cc2838c9e735fa2c68d38ad8fcca552a37b9832ea3a8138fb5301df6a8150a5d5db63fd22672473ce2b5e55432ac78676cf55c28154edd527bd9e37567488f5084fe19add4a9465c9a27b9cafda3d6ed973c397329bf314aeccaebc64e706ba19ad2379012cea08eab5836b34304f14b1feeca38c86aed6ead849096e091ce45726220a324fb9df424e74da7d0cb8e148240f15c9561d3cc031f435cbf89adf4eb079678edd4dcdd2ec92d8b1daa7bb8f6feb49e2fb8ba4dd6dfea925caaca0e0f4e99ae5af259ad2d23375335c488b867739c9ec2bc8c4ce118b82dceec3c252f7afa1c8d9ab58fdb6cd9794976c6c4f3e59e47f33f956d5f5f9f0ef87ad656531c93398e155f71d49ad6d0fc3e2491e69486964e5b033b47600d47f1174d8ee2cf4b88e55a19fcc5e786c29af1efa9ea58e76d7568f4355990f9b752e4ee64ce7e99a99bc4bad4bfbdf31957ae02803f5ae735349aea68628d9bed2c465bfb8a3f956841a30b8ba82dbed125cb9e5833f0a3d6b7495ae66dbb9a56be3cbab394adc013a9ec08c8fcab7ad7c7da548079dbe17c720ae6b99bdb2b2b7d466b78a032476f165f6ff0013f5ebed5523b0862fdfcc8394cedce1547d6b36a2f7452e63a7d47c79a6423f70f24ec7b05c572d7de21bfd698a5b5bb91fad66cdaa5bbb98ec6c4deb93f7972a83e87bd3a29759b57595ac1238c720873915ceeb5183b391d71c26226aea3a09169b7d23e2e8cd1aff00cf345352b4b716a76c1633951c16618e2badd2bc4d6fa8c416ea3db2af0c47635af8b7b88c94c371806b4bf54733838bb3dce1f4e922bd629749247eaacc78fc2ba7b2d22ce08d5a38573feef34c7b649206690227944e5daa0feca5bf48dd649b0e3f85c84503a9e3bd4bd77049962f4840555467dab066b37b8620607a91d696e74252a4dbde4dbc12305ffc6b2e68359b304a91327b119a2c82e6d416d159ae70011df35caf896f9750b90b2ca12da3e4e5bafd0531ceadaace600ac83f8890400294f855631be560edd4b9e68d10aedec606abacc161a7c972caaa8a36c71e3ef1ec2bcdecafbfe2646e5dbcd95db2c47735adaea49e2ef11c96d14a63d3ed98a260fde3dcd6ce9be0f834c6de3e7dbeb5c55aa25ee9ef60e8b8ae6ea58b7bc92e620d30007a1ac6d7b4f8ef63dd0c9b2553b948ec6baa1a43dea80071ed599a8f8726891888d94fd6b8a2ecee8f526d5acf53cc3c6d3f89f5bd2ee2ceceead225f2984d1ca8448ca073b5ba60d7837f665a6a165f2c822b85eaaf8e4fb57d3da8584ad1b472c2b229e0ee1dabc9fc63f086deec99f4ccdadc0e7ca27e43fe15f6396e634e0bd9d656f3ff0033e371d97c9be7a5f71e3b35b4f64c46e618edd8d4abe45f15596336d26301d7a7e22afdfe9face837252ee1703a7cebb91bf1a126b1be03ed30790718f3233c57d7c7966b9a3b773e6a51941d9e8ca7706eb4305bcf49e23d006cfe99aa9a249aaeb57f24bf6896d6d22f99f2c403ec2a86a76525fdfadada112419cef5ec3debb0d36cc5bd92db44a49c0039fe75e5629c1fbb148eaa5370d5b1f6e93caecec3703ce7b62ba9d0b4c7908b92822b58170f276fa558f0b784e4d426f28a6d561966278403b9a4f176a6924874bd30ecb383ab1e376072c6bcd9a8a562a94a7524945f9b33b58d60ea3335b5a308e351cb9e056c689e1d86daddc4b77148240acc8aea5b8ec48eded5e6f2dd2b9314916e80f7070c7dea38348f34efb09f91d559b630aeda596e8bda6856231b29fbb0363c6114706ad12200a9bb8c1e2bbaf00ac115c5fb3a19247b508a08c2affb59fe95e35e237ba164de6412078ce04f11c7e7d8d779f07aeef6efc2fa8bc85e50aa419a4e483d856188a1ecb4b98537f68e5bc40449a86ac5486197390303835cfe9cd9d54e71f30edf4ade9b8b8b8fdec3207243248a41e7af355cd8a44e274b54538c6f8dc91597f66d57ac5ad4f5a399524926995a10125bac6472a78ed5535738800cf25f9fcaba1b2d2e1bb2fe5dc7953b81fbb97a1c7a1acbd6f49ba41e5bc787ce72a722a2582af0776816328cba98579f7ad093d85675f8377e278a1f3a342cd8dec70a3dc9ad8beb499a3802c7bca8c363ad619b4dde30489d95033fde7380063bd64a128bf7958d2752328fbacf60bad1ac35df0f5a585cdeab41825cc2fcfe1c5757a7de59e9de16fecdb1940202a6d2083b47f3ae5fc3de1e9e358961293ab2926453c28adfb4b3b5f2d94dfdac572adc45292370f506b44edaa38e3149591f52fc2bf899e0db3f862745b9d622b1d4858b43e5c88c079983820e31c9aef7f6622b1784af19ef127966b8cedde0b70392475af84e5d4a7d3e62162866e7aabe6babf0878e24b5bb579ae4696a3189a289a56fd18573c28aa77e5ea6d2973593e87e923483d69be78af904fc4ebfd4748f2b44f8b496b7857e58753b1f2549f4de724570f2f8c7e35891c2f8c74d75c9c32ea50608f515b2a57ddfe04dfb1f3be99e6ccd6b6d143b59c840c4f1cf7ad8bc925d26f5ed2ed0074e0b563c576f985500213a0031deb7eff4af106b08bff12616a8dc992660a7f0c9aa937a5ce1e58ef7b15a2b850e4c6d8079c03c57d95fb3eea035db4d2e36907c90e300f402be27b9d1b50d148f3d136b75d8db80afa37f649d6249aeeea067388948033d01355ed961e9549f6573556a8923eddb7bb8a18f64203ede37f6ff00ebd4e2496e061998ff004fc2b1746d8b1a19a40a58fc818f5fa5761656b146caadcbb73b40e95f1753155f16ef2dbb1d118d91e39f10f5196eb549ecade2321b580fcd8e11df8cfe5fceb2ac12755d3dbcbf2e3b78cc606339aed75fb090789358b1408c25d972981cb10318fc314db845bbd2ecf51b5b612a5b12b736bd0a9079ae6b3b1f7997b852a10b7520d1eceefcc7558cef9f9dbfece3bd3edf4db8d32e66b47c059871e9c76ff3e95a7a8ea4f2ac5abd800c550131c63865f4fad57d4755feddd07ed9a790f3c63cc519e491dbfa56b1d3aec754bdee9a1dff00852e5f5dd3d597c8b7688794e99258903afb66b44db5e8925b4f2c155219033800935e59e09f1bc7a4eb963732bf9315f9d92231fb8c3a13f8f15df7883c7f15a22470c8b3dca4b97208e53b1cfaf4fc6bebf098eab3a6d24ae8fcff0031c1c30b5e51975d4d4d4740b98611207418601953e51f9f7a8a1866b0b7b8b8770f94c200a76e47bd606b3e2fb3b4820d56faec3cac01169752ae2353d7e507afbd617897f688f0e358dc589d4ec60246d590ce30bea401e95dd0cb2b62310aa24eda3d55d1e34ebd2845c6e6b5c470dca24bf6e851cb6590b0c835e93612f9da5c322626531024a1cf35f337fc2d7f0233964d5ed6e9c0e819998fe00575de02f8fdf0fe25b8827d76cf4cc728d26e8c8f6e6be9f1182aae9df76bc8f330759fb47171b5ceff00c652437b35a5b248914a497fde7b74fd6b9a5d00ca5c5f3ac9283b805e83ff00af599aa7c48f0cf8b3c470c761e218757812dc91f6500ed248ea456845ab6edac8eb7089f2072407c7bfad7c4e36328d569ab1f4f854b90e8ad963b78d540d9c7a571de321fda7a869d141f34ab2938f45c726aedd78ae35888915e3c70768c838ae620d4eeee85ddd42a225932a8ccbc8515e7289dbcc8c29e54875bbe8d06e6f304795eb8c74fd6b57c3b6e6d2e64b99880719c75c7b5731e168aea4d56fe18f32ced217663e95d8be8bf6181a4b99cc8ecbc449c0cd6cec972a22376ee61cb71e7dd4b183b7cc669256f6cf43f8570de38f1644dafe9fa3a3f976ecf997b1f5da6b6bc5fe26b6f07d8f546bcba6d888790587bfa2f53ef815e29e2cb833886f15cb4a8c18b13c939e6b96a3fb3dcf570b4925ed65d0fa43c2e607dac146dc76aea6f923bcb7d80845c7000af1dd0bc5df60f0edb4a0e5dd40ad3bad7ef05b89a195a4948dc57775af01d2b33e8fe2d51a3aa696fa75e34f0c85d5b8745ebf5156f4ed7a7b40acb224f01e0b2f0c3ea3b571ff00f099a5e2ed9cf9320ea0f06a8ddddc8a45ed84acd22fcccb9e245ee08ef5e961aaca9ae49ec7918bc346ade717a9ea9299f540be4e595b9db8fe95f2afc69f8c1e28f097c48bed3ac752bcd2858e238d20236302036594f5eb5f4668fe2594d82bd8babc6e32403c8e3a7d6be51fda82d254f88715dbae3ed7691b9c1cf2320f5afa6cba942ad7e49ed63e5ebce54e3cc8e83c1ffb5e6a96ad1a6bf6706a089953344a62931ea40c835e97a2fed1de11d6a4629aa1d3276f9bcabb1804e7a64715f19b5b95c9073cf391511b604eee0fe1d2be86a651427ac5d8e18e36696a8fd14d3bc6363a8dabc90cf0dd43c7efade40ea7233ce2b1bc79e2c8b4bf0bdcdc47205661e5a1f563c0c57c2ba46aba9e8b3096c2f26b6707398a4299fcbad755aafc44d6fc4ba7c365a9ea532246fbc1d8bcb74c938e6bcaa993493f72499d54f1d0bde48f74f06dcdbcca0ab80c0f3ef5ddc7244e55642304f06be51d13c47ace86fbe09a3d4203ce01dad5d1c5f1c27b79152ead2783d4b74fcebc3c46555e9bbc91f434731a324927667d5da6cd040a48dbf5aa7aa6a90a027218fb578a683f1517518479738e7b6eae853c482e97960723d6bc6951707667a71a8a7aa36b50d4e090b02a01f615cf5da4171fc3fa52b4825fba704d1e4fca01193eb4d2b09b661ea1a15bdd215645753fde1915e5df103c0da4c56ce23536b3c8386878fd2bda65b748627766db819e6bc6bc57aa1d4b5298a8dca9f2a81dcd77e1ab55a72fddc9a3cdc552a6e379c4f35d17c2e9a19955e7f3599b3bb1ce3d2bbaf07784ee758bb6f2e2dca8064938c73557fe11f77bf5822613371b8afa9ea2bdd34bf0e45f0e7c266eee4859e54ce0d7bded1f27337a9f28e9aa95b916c705e33d560f07e8eba6daaa8ba99713c89f7b1e95e35aa6bbe64e915b2191147cec7ab377fc2bb0d4ee755d5eeafafade133ac9947c807e527b564cc34fb98551adcd9dd2f53b71cd77e029c2a3f693d6c3c4fee97b2a6ac8c3b2874ebb3b6e51edc9e8cac48ab775e1892d22f36dc0b884f2197922aa6a08b6526dc9901e8ea081459deea0a76d94fb491c44c7afe75f4768c573459e4efa3462f887509ad74c78632793ca11d2baaf84daaca9e1fbbb790ec5955db611d4d719e2a935382d661701a276e7eee335d77c168ffe25f39b9512b046da1f9af17307ccd3b1d34ef1868417d65672217899927fe246c609aaba76957f717e9059db4c6693eeaa8ea3f962b72d7c04fa8dccd3485951d8b0dbc9c7f4af63f84be044b1b199e3561239c97639381dab0ad9ad3c3d2e587bcfb1e8e1b2ca988a8b9b4478f5e7c3ed69486fb100c3aede07e55a5a6fc37f125f46ad650ccb2e70627195c7ae4d7d42fe128d2c8cd14666651b881cfe959963e34b7d1ee4c32a6dcf0005af116738a92d12fc7fccfa186478752f7e4ec79c787bf668d4356b2336b5771da3edc9d96f9dbf535e0bf153c211f82fc602dd765e2458225036b1cfb57d93e31f8d767a3693e4cd70232c388d473f522be4ef89fa8e97e2ad61eead65b9b9dc4179251b1723b28f4adb0d88ad5a6dd695d3f2d0cf30c1e130f497b0f8bd45b8f13cd2e8f6369095d3801f34899f9c7d6ba5f84fe0ed4fc7dae9d3a1812e4b46d2bc92f45541b891f51c63deb8bbab712e8d63b10c8c0f000c9afb03f628f085cdb69bab6b97b105276da405baedfbcd9fd07e1454d23647890939d99d6689fb3df81fc5ad7724da52c43ecd1c88d6ce50825793c77aa971fb1a787aead564b1d56fec64619c3859173f4e0d7b0781f4c3a76a3e21b7e0a44c044476423207eb5d7d8956b64da41181d2bc8a1292a928dde87a1552dd23e42d77f63ff10d8c6ffd9da9596a4a3a2cca6263fcc579c49fb30fc4359187fc23cad8246e1711e0feb5fa14d8fcaa12173d2bd25524ba9cc92e88fc848f70459141c06eb8eb5dd6abf112c62821135e42aea83237e4f4f6af33b3d6193458d88f95dc0c13f9d65c8f69f6967fb1a36e2499082c4fbe0d6b29e9633861d4f5dcef2ebe236997a8d1e24b9078f9171fcebd13f65bf157d9fe25cb6f1dbcb04373090a1cf520f15e2f628cc1594a2c2064b2003f957a27c0cb67b8f89d6d736ec5e3b7859fe9eb9ae771f6aa51b6e8e974634d687e94e996163a9dbd9ea1
UPDATETEXT [dbo].[Picture].[PictureContent] @pv NULL NULL 0x25eabc70c7b8c7d71839c8af48d026b6b886f6e210d2f96e08dbc13c74af28f867069c90c77b35e436f12c625c49c097a8c7b05c7e66ba8d0f568afeec8d3c5c431cfb87da2e25e653c8c018e3f1af0a9ca74a294f6d96da132a93925093d8ccf1eeb7696be28d2b52b6b39844ccd0ddcf8f917238cfe3deb0c6b317857c6333492674cd48070c4f01fa7eb5dd47e114bc5b8376a9666450ae73b9641c8c15ce31efd6b87d77e175f35b4f6b6b35bea9a7b0252362d1bc3ee18e460570d7ad085670e9dd6c7b782c4429fee2a3d3bf423d43535f08eab95c3e917a77467b231edf8d72da96b91782ef1f5081bfe25774e5a451c889bb9c7a1af2cf883e3a7f094177a55ff89acf539e2188ac2d879eea47f7e45c2a91f89af21bbf893a9eb51087539a5b98f39550ff00281e9818af7f019357c67bd1568f769ec74e2338c2d04d45f33f2d8f73bff8e9e1d3a96ad6f813dbcf0b186645e23980e9ed93debcc87c62f116a90cb6e9a90d39dc158d2dd001f8b1e726b0750d37489f4d89e19552e5ff00854e36ff00f5feb5'
+N'cf4fa73db5d88e62637c021871fe79afd2f2dcad6062e94657bfdc7c3e658f798494ea45685bfedfd4e3bd90dc4f34d286f9c4cc5b27f1ad137d65ab36c963fb34edc2b0e84d5487ecfaa44e269963bb8b80fd37fa66a82594b77298a3daf20e41561815ed357d25a33c85a21d7b04fa4dc8c9c3a9cac83bd5eb8bd835cb7f31888af635c303c07154afdf50b54fb3df22487f819c648fa1a7d8ea766b6cd05c59e08fe38f9e6895dad095bd8d8f847e2b97c13e398ee1dbfd16e54c0ed9cecc9183f81afb02c6e2e12708ba1ea324671fe92881837be3ae3debe26b8d2a1bad38dcda4c5d81f9a223e615e91f0e7e3ef8a7c3f0c7a6bea26e0c2bb618af32c981fc39e08fcebe6730cae78a97b4a4d27e67ad85c4c292e4a88fabc59a5d16db72a1080ce8a9965f661d40a35395a4d39e212476cb1ae0055e08f6af1eb5fdb33467db06b9a0deda5c0215e4b7d9281ea4670dd6accffb49782ef65d9f6bb9911b9567b52847b139c1fcabe52796e2a9bb4a9bfccf5956a2f58c8f4df0a58a6836ed2b465aeee172d9ea3d07d2b9af899f15f44f04e9ef3ea1763ce2311c319cbb1c7451fd7a0af1bf88bfb43eb125acb07872c7ecf6cc306fa63b9beaa833f9b13f4af9eaf2f27d6b5092eb59b9b9bc9e5e5ae6493730ff00eb57a584c9aa547cd595976ea7355c6421eec35675de26f8917de2ad5a6bf9d0491ffcb38e16ff00549d8014ed1fc570eb36ef1f9bbf02b89d5341b8d2163ba8253240dca4c9dbd8d62da5d49a66b515f45c44c717300f43d58574e332982839d24561b319a9284f63eb7f0569edaae910b48f88d5462b64ddbe9cf22b9f973804d79efc2ff1693a51b7521a343c30f43d2babd53521728141041ee2be02a526aa38b47dcd3aabd9a9216f218afdce172d9c800f5aa96b2cba74b8c305cf2a79c55ed2634719270715beba45bddc7863b4ff007871517f67a35a1124aa6b1d19e7f37c68d03c237eda76aba6dc1640248eeadb9c8273861915e63f183e20d87c4fd46cce99025bdb5a060ad3bfef9f38e0fa018e057a2fc48f84961af1f33cd92d6f946d5b855ca30ec1857cf7e21f0bdc78575136d7f03eeeab2270920f5535f7595cb09514654fe35fd687c663e188a6da9af7591c9a65c459f9d31f519aa32c6d049fbc52bee3bd695ad9596a716d4b89219bfbb29c8fcea0bbd22f34790311f27665e56bea54a4f75f79e0bb1404983d01a962bc31100394cf661915aff65b4d674edf115b7d4633cae30241593358cb6ec04b1b281dc7229b5196fa13e869db5d24982d08ddfdf81b1fa55b78a4957e4944aa7f82718fd6b9b01b7e23ce7d56b56c350b8807efbf79111c83c9c54ba4edfe455c592d5ece5f322f32c65f507295b9a2fc40bcd35825e299631ff2d63e4516b2437b0ed826403fe79cbcaff88ac8d434b6819a436ef19fefc2d907f0af2f1181a5557bc8eda38bab45de2f43d7fc3fe36b5d4630cb2ab83ef5d7d96a30c8170c307debe76f0d693aaebba9c76ba5c06e6563cc88bb42ff00bc6bdd7c3df0af5e8107daf568a045196664e07e35f118ec2d2c2cadcebd3a9f5f82c4d5c42bf23b77e841f10b5f8b4cd09d1180924f94578ed8dbdcea37f6b0dbfcb2bbefdec7033db93c57a4fc54f075b69fa74734da8cd7d725c2aaa2ed403b9f7a6592a681e1ed0adee34f7985ec6d771b328c23025777be5723078c60d7361da8d9c55d918e4e69a9bb2347e027c31bdf1478c9269d4082de5669d9d864803271daac7c78f1035edc9b2b5cbc3e67971aaf7ec38afa1fe1ff0087a5f02fc18b9d7aea3b5b5b9bbb5630ab8f924dc7049c7b743eb5f2b69207893c6c6e656678ad499307a67a0fd7f957a756aa50f796a78f85c3c94b9a0f46745a2f85a1d2f4786d760326dcbb7ab1eb59fabf812d2f87efed91cf5ce39aed251b578c1fa5665e5d1313316200e315e1294f9b993b33e9e54a0a3668f34d47c256366a6110870dc61b9a587e12c02149e581a352370e4f4addb722eb554924fbad2617d80ef5da6b17c9244b0c2dbb2a177376aed78cc4c7dd537f79cb1c0d09a72704791ea3e0cb6be866823b7fb408909265e40e2b91f0814b1b8bdb7550a8d191f2718af75b0b431697a8f96837bc6d973d49c5785f8777c77d7e800ced20e474fa57551ab3a8fdf6d9e66634234a8a71563dafc2be1649f41b4931b43c4ac4e396aeabc3ba9c3a3ca6d5c7958e15bb1ad1f09d90ff0084334964e18db2fcceb919c54571e134d6e40af7051b1fc09d3f1af3e4d36ee7d061e0e14e328ae86b3f8b20d34ac88791cfca7352e9be32d3aeee9a77b28431eaec82b9b97e1e3427125f498ea0151c8fad6a69fa025844cd1471330ef23ee22a25cb6d0ec55252d24ac729f1d7c1efe335b4d634596185e15d93ab0c065edc63ad786f8c7e1ac9a0e9705cdd4919b89df60109c0cfa91f406be9bd73517b6f0ddcc0f6c933c836471c7c0663d326be74f1769dadd9ebeb0eaf76b3a476e664897f80b640cfe15dd8672935152b1e6e3a8d28d3955946efb9cd787e2c0b1e3e52ac3f2afd13f835e1cff8457e1ce8d68c36cd2442e25e39dcfc9fe9f957c27f05bc33ff0009578d3c3ba7edc89a5064239c20393fa0afd1b8e1112222f08a3681fcabbe6eeec7c9515b94fc25279d79e2997b09f603f4515a16121b29e4b66e47df4f706b1bc10f9d3bc48ebf79ef6403ea38fe94b63a93df697677adc491379330f4e707f5af054dc6b3974b9eac95e363a969323ad47b58fafe755e398b0001e6afaa9da2bd8d8e3bd8fc70bab292dbc1b148b06d8a47da64639e41c9ac420951fcebd3e2f861e25d4b49fb12f876f162dfe61773b07e44e0549ff0a2f5f8d03cba7c56d1fadc5ec6bc7e75cd2c4537af31f4b4329c645b4e9b573cff0049b875c5a32978a66cfcbd41af6efd9aaeec34df8853e9f704493dfc0628256e41933903f11915cc5bfc21beb31e67dab478723059efd49fd2b434df025de957b0df5bf88348b6bab7612452473365581c82085ad6962e109a93fc99bcf24c5544d72dafe68fd10f85c6cdb4e6b2b8b68e5b8b272a3cc50df293c115db0d32de5d41af110ac85b700a7e5ddd338f5afce983c53e37b19e49e3f8856f14afc33473b82dce7fbbeb5653e25f8fa25dcbf12f6b0ffa786ff0af0715838d6aae54a568b77d99c2f20c66f2b7de7e92c71470a07906f76381bbb57cb9fb5bfc7bd6b41d63fe101d0a68ec4c96cb3dddd46c44d206ce1171f7471ce3ad783db7c6df8ad6cf9b5f88515c8041024990e48e9c30ae13c7d67e3ef88be2593c49abff00c4e35364553776b2270abd0617a62b4c1e12386a8aace49db656fcee613c96bad256b75d4a92d9dccd21672373724b13d6a2cc765751c264dcfc1ff22ac69de24d434c87cbd5b4896541c348179ff0a7dd5ee8dabce92d94de45c20caf9836ba9f4f422befb0d9f4e124dc3ee77fc0f3abe4ce0b4641e21bf305e5a4b09ce48e8783cd7531ebf6fa9dd44fa840a7626c047f33ef5caddc2351bfb625552e01c95e8afc53bcdf25ca3e51ff00bad5f6b46b53c4fef22d59fdc7cbce94a8fb925b1d7ea1a1c13e65b09158633b73583224f68f92af1ba9eb8e4551b3d499267f2a42af1f706ba9d2fc5aaee915f468c08c6f23e53f5f4aebe5925e4fee39ec8a27c4724f6c20b9852e00e8cdd6b434efeced68c76d25a1b690f0ae87a9ad3bcf0ac17d6cd7365c4806768ff3d2b9c632db37319564fbc31c8f43570a0a4fde7ef10e4e2696a1e0ad5343517708736ed9c4ab59128999944ca24653924af5fc457a4f82fc68bac5a7f646a12ecc0ce5bbff00b43fa8ae5bc4ba5be997b208019e024ed2a3a7d3d69c69c2f6a9b77ec26e5bc48e1d1ecb5eb46f263f2ae97fbcd93f8e6b9fbcb0974f9196543037bf434e1a84d04fbe1cc722f503fa8ad2b7d7e5d42e235d4104d19f9721791f5a895351f8355f80efdcaba5eaed76cda7cb2882671b619401b58fa11fd6b9dbd8245bb68ee53ca65243155c73eb8af46f11fc3a8ce9d1ea56f958cf3943d3ff00ae2b96d4e4b7b89e1fed081e66550a64b76fbfee47ad61c9abd36fc0be6e8cc2b4d5db4995acae0fda2ca5ea07239ee2b2b54d1164ba02dae07944fcac0f207bd74ba95b69ca882d1240ca380fc01f81a7e9f6b63a8446de47682ec8f909c6d27d3dab9e74f997bc5a9599a3f09afdbc37757765a896446c34123f008f4af4c87578e59555183293c62bca2d6f96de26d2f5443e51e1252398cf620fa5411dd5f786750004a6441ced27e561d8a9af91c6e472a951d5a32bb7d0fa7c2668a9d354aa2d1753e84d364daa3e6ebeb5d3d95da6d085b1bb02bc4fc31e3f82fa411bb847feeb76af46d33594902b641f415f155f0f2837192d4faaa35635127167791db43729b58020f196e735c578d7e1cdaeaf6cf1cd02cf175191d3dc7a57536176be5a13df9fa55fb8d4ade28cf9a7e5eeb5e645ce8cf9a0f53b2718d58f2cd687c79e36f87f27862e58b5accd699f96688e48fa8aa9e19d275bd61275d2ad5b58b78a3695d3baaaf51f5afaa20f095a7c44f163e8704ca93c70b5c5d28e90a0e81dba0249e9c9af46d17c05e1af07e893f957f6d2ddc2a11a0b38822018f9ba0f99bebd6bec296775a346d28de5dcf8fad95d375bdc97ba7c733fc1db761b0ea4f69a9b9052d563c80719c673cd54bdf83de38d3e049458fdbe20788e2e5c8f5c75afae751bad02cee2def17473aaddc399a15488c4525c6012c7a1c572b3f8a619afaeeeae22bcd1ee5177446e0031b39f42a49f6c1c5610ce317bdd3f2d3fe01a4f2ca5b5ac7c9daad9489be3b8d3e5b2be897263c61b1f4ae64dcced2326df6afac7c6be23d1fc616cb6f3d8c7a95cc3b8437821d8f193d4eeee0fa5617853e1968f673b6a13c4b34e4ee50cb954fc0d7b10cf634a9f34d7bdd91c4b27a93a9cb07a773c4bc3ff000f35ed6d925b7b76891bfe5ab12bfa77af5ef0cfc18912d43eb370d28ebb07ca0d7a34d7e9a7db05b3b70d9f44c05aa3a9df5f6a6b0b5c4ab06063311e4835f3b88ce71788bf2be55e47d161f29c350b36b99f9ec54d3ef74cf0995b7d3ed15e607e58e14e4fd6badb3bb92e2fac6e35984476c46e4b65e707fbc7d6b938adfec4e56c6d8b4ccdc48febee7bd77fe15d90da4b26b12ecbc1fc73a91f2e3803d87b57852f7b5dd9edabad364799fc76d4ad75bd4b49d2f4e876c323aa190ae3249e7f4cd71de17f0d5f78cfc7fa28d49cadadcdc25ac16f19c958c37968a173c557f885e25b8f11f8eed2d74850d2fdabc8b6dca407763b075fad7bb7c1af05daff00c24be1fb47b643e21f0fb4d1dd4b6c44915c48a432924f1b87cc3f0af4f0ff00b9e556dcf9ccc63ede528a77e5b7a1e9dfb4de9cd69f0df4ad0b4f5499ad4c76d732c43fd5e06307b0edf957c2179ad5c7867c457f0d920b88237d8c03624c8ea71ee6beb2fda53c5f0695e1f9b4f9646bfbcbd6fed1924872a00c908adebd0d7c33a8da492cf25d5bcad3127731e438cfa8feb5ece5f8758ca93954f87a1e762ebfd52108c373d5bc3ff16ac2ea75b6be2f68e78fde8c7eb5e832d9dbea960d242c1d4af054d7cbcba9cc309731a5cc7fed8e7f3aedfc13e33b9d1f1f6491e6b31feb6d1ce5947aaff856b8cc91c173d0fb8ac366ea6f92b7de6edd2cda5ea2e84928bd0fa56c41ab2cfe5e32d231c0aa7e20d52cafed239e1953f7df3139e82a2f0c6a1a4594e2eefaf634c1f9225cb103f0ef5e22a152a3f762dbf247aeabc21bc925e67a969fa2c8744b990ffcf163f4e2be69d2a36935fbd82252d2302428ea7d6be821f18b44fb249636dbe491e32837a6c539faf5af9d343be13f883519986080ea0a374aeca384af4af3a9169799e7e698ac3d5a4a14a69bf23ecdf87fa6ac9e0cd1be73b4db264671dabaeb4b4b6b504c50a975fe238af99b41f8f779a368d67a7a69b0c91dbc4b1872e4120743d2b521fda4ef3189ac1117d54e48a6f25c6ca3ed142f17e68eca59be0e305173d52eccf78d62d12ef717089953f2fad79b788251a4b3324a5001c81cff00915ca4df15f5bd5e2f32cef2d65888c88b661b1f8d57f0e689aafc48bef37508ef6db4a89be7991c7952907941dfea452965b5a8479ead920fed5c3cdf2d3bb652bff156abe2489f4dd1ece4bab82df2ccbf2aa11df71aea7c2ff02b5096db5abdf16cb1dede9b2f311a12482769c607a0c62b6f5ff88fe1ff000166664b58e386358aded61506591b3d80e83dcf5af3c93f689f131bcd46e4985a39d0848b6604400e318a88d0ace29c55bf5396a6255476a92d3b147e055a0f027c4fd065b895640ccd6e6300820bf19e6bee81216031dabe32f821e3fb9f8a1e37d0ac758b1b3796106e05e4516c9772720123a8afb1d4ed19cfe1551e7bb53dcf3d7b34ff0077b18be03933e1ed5e41fc57d29cff00db422a0d39f179e20d380fbf89d07fbc33fcc547e019557c1b72f93996ee43f9c86a7d0be7f1fdca1e775921fe75e438de9ce5e675b769237b459fed51c32119dc818fe55ae6f14123078ac2f0f379768cfd81603f06358171e36822b8950b8cab11fad7ab1d6299c4d6a7c40c2574c492ca633d99c9feb52ad944ca372861db23a54d756ee019002a83b377aa2d75800739cf4af9f5394b767f44ca108bd1179ad21550195463b01556e8418006d5007e74f925859b73b38c0fe1accdf1ce1e4f9db070be8b50d3358d48ad08e79e38c329008c679ace99bf74404551f4af63f863fb33f8b7e2958bea76b6e967a4a67fd32e4ed56f651d4d72be36f86e9e17bc92d1ef3cff002d8ab1030334d3b68ce79d5a7526e9c1a725baec796ccc09dc429033c5456a66790b44ef09c754247f2ad5d4b42fde008ff2e7073556eccb146b1c4ca074caf19ae98ca51d627338c1e9343edf51d6d1644b6bb91e3894bba48e186d1eb9acd9fc4f1cf188af74c898a671340363fe351bbcd07980f2586339ac8b9731b1fe363d462ba21525d4e0c46170f53e14743a65f9b9651653fda3690cb0c8db645fa1aec6c35bb69613f6fb75320201729b4a9f7af2099b0e1c02847cc1ba7e55d1681e2979af16daf0874906049e9e8093d6be932fcc67859778bdd1f0d9ae471ad17286e759ab476f0eabf68b2605251b594118cd496ec2618e847507a8ac2d6ede5d3ee58a038e1d08aea3c2d63ff099a21b1056f628d99d40e4607f2afd13098952f7a2ef167e575e84a9b7192b346b7873c4336897488cc5a02791fddff3e95e8de2cd220d6fc370ea9a6c6be6a637edee3d3f1ed5e3b14cdbfcb91764aa70ca7a835e95e06d6d74b46b3b8901b3ba5da771f954fd7b66bd794138a9d37a7e4705fecc8e26e258a262d1b14954e411c15356acfc592c5222de0f3a1ce09238ad4f18e9760b792cf65711cb36725030e7fde1fd6b8d8bccd5aebc9252dc2f1f37001a72a909fc7a4bf312528bb23b8bed32c7598165b52aac46460f23e9eb5c9de417ba75c2c689e648df742ae777b7d6b6f4af04ea7002d16a31aa1e4c4013f8d47347a9e917de7cceef22708e1723eb8ac62dc5de3a5fee2a56241e2bf10d9e942c2e6336d138c299073edf8d64e9a67d3dccc98931d41abbabebb7facc67ed13f9aac31c00054569e20363079525a47236319ee6add2e44fda2bf6688bdde8cdd874fd3bc5503162b15c0182c06307d0d725acf87ae74695d255ca0391301c7b56fd86b1a7a4caf3db341b860b29e3e871dab61ad8789a211da5f671c2ab00df81358c745a2d7b1a3d4c2d2ee2c3c49a04b697ef1adf41feaa663827fc6b9bbdb6d41acc40f6f2c90c7c2315cedfa1f4ad2d6fc097ba2334aea5901e59460afe1e9ef56f4bf115fdac0602f14d11ea928e4fbd670a4e7769073ababb3849ec9908ba82778a653b4a771fe35daf857c717da708e3bbb8866e830090c07a73c56d47e128fc4b6ad75687cbb850494c64ff00f5eb8dd4749960668dc2f988704670457955b2ba38cf76aaf7bb9dd431d570cef07a1ef9a078ca2b981501d920e76b75ab535f5fea92de7d965f29a284b93dc2e70581ec47afbd78e786f5885225b5d44ba30c2a4ca3047a574ede293a381f69904b0918170b95dcb9e8c3b57c3e3b24a984939c3de8fe28faba199c7170f6727cb23d074bf0f37832d7fb57ce9e48eff318f2d8a16039209fa9aedd3526d1ed21b289a21191b991472a7ae3f135e7e3568b59d0a186d6e19d14868a20dc2b1ee0547e25d6445e2830472ffaf75249edf28c8fd2be5e516ef63daa6953e58b773bad575e31dab32052f82783d2bcecc53ebf7524b317f294e08ed5b7e1e9bfb675892ce69046b8c0cd3756b16f0edd4b1ab16898e739ac14d41f2f53d25479f5e867476115a5da6e006c1f77b5773a54704b6865203363a62bcde7d495a4003743806bb4f096aca96acaccb903ae7ad4d4bb89ac2314ed125d46e6358bc9db839ce3d4566c5b6023700d93c06a9f579d1eea3753f36783d722a83dd19665c9dd83c62b348d5be85f9f5192dae06c432c991b140e01aea74b9ee35ab1b8bed66ed5991182c6142aa01d3029b637da2697a76fbf8dee2e9f848e21963fe153cfa5c7ab7872fe49628ad21c6d4079c03dc9a1a6a3ae88cfe27a23e6cd4ec1357d735ed712f5e18f4458648427f1ca5b8c1edcd7d0ff00b3068c2f3533afdddec891339dbbc6007da59b81d4919c7e35e11e15b4d42e34df894d05a5b5c6901a28ae1a5e1a3224f91a33ec47eb5ec5f023516d2e5b19758bafecfd31423453f555c060bf8e7afd6bd78df92493dbfcb63e3ab494aba6d6eff1b9c5fed31e2e9fc71e37d4a2b1b75488cc2da268d7619028fe479af0fbcf0b6a9a4b09a787614e4af53b7dfd457a278cbc471e95e37866d5606ba7fde4b26d60e19998e1b8f6e9576cf58f0ef8cde186f2f5ed01959bcb8dc46c88070327be6be9b2cc4c70b866a71767d524d1e56328cb1155da4aeba33c61b4459e43349383bf9db180056a6891c1a45dacc2dfcf51dc8cb2fb8f5fa5751e27f844b05e24ba06a12ea56d70c7cb864522438ea463a8f7ae46e346bbd2a5f2ee166b67071939033f5afaec3e2b0b8ca6951b5d77ff00267815a8d6c3cbf7973d0676d235bb0da62b7b794ae47cbb437f81fd45705aa5a1d2e423cdf321ce038604afb1ff001ad8d17c4171a565668d6f203c14954138ad8bdf0d699e28b7fb468e563b903e6b76e3f0aeb6a54649a8d9f97f5a9836aa2d373cf6772eac0927deb98f011964b9be0f92dbdc6e3e99ef5d96a566fa7c8d0cf098a4e782383f435c77836416f7fa86fcf12b77e82bcace9aa94a338dbfaee8de83d1a3d3b50f0bfda744b69a070678902ee07f43edfcab9410cd24a21f2d967cedf2c0c9cfb0ef5dcf8256e7c67790e8f0694d7924870934795c03dc9ed5f4b7843e0e7843e13d92eb3ac94bbd4d403bae0e4a37f7631fd6b8e79b430718c29ae69b4bdd5faf63ba960e55df36cbb9e57f0c7f675bb9bc37a86bde27bd3a0e9e20668d646d9b5b1f2bb1edf41c9a8b56f89f6d73e18b1d0bc2a058595a5b885999f73c8dfc441f739eb54be3bfc65d67c6737f650b77d2f4389b31db03c4be858ff4ae07c17a5d8eb4d7d25e4696d6b69079cf2c64ab31e800fc6b969e1e72be2b19abfe5e91f977379d6841fb1c3fdfdce4b59b6bd7f1042b7aef33e4ccd239c96c74cd6ae9fa6cdacde45656ebfbd989451f875aab3213a8dc4bcecced40ed92abf5af53f803e1efed6d7355d4a45cc3a6d8cac09ff9e8ca42fe9935cb8aafcef996db22a945ad198bfb262edf8a5a5fb5b4c3ebc57dd7bc0463d38af86ff654756f89f67b5427fa3cbc0edc57db5349b6076f453fcabc49bf799d5456fea735e0b94af81ecc839df70c4fe2c6b4fc26e27f1ceb171fc36d6cb1fe38cff5ae7fc2d388bc13a40271b9f767f3356fc19784685acea23896fa7709eb8ce05788dda935dd9e93d657366f3554d23c30d333618c6d20fc493fd6bc266d525966772ed96624f35e83f15b55fb1d85b58a301b8007e82bc75efdc3b011b119f4af523a4523ce9bd4f13b6f8a967e2932341652d938ff00966f2f9aa3f12335243a90ba919b1b481f38f4fa578f782eeda4b890a0259c7014727d2bbe8966d3aedd2e37abf9637a9e3049c815c35a8c61b687ead95e6b5f1778d6d6dd4dcbfd5c37eea3ea7a9a6e97ab5ae9d22c92fef110ee29ea6b9bbbbe3173d89acc13bdcb4c037ca00624fa679ae58c6eec7d22afc8b9fb1f72e95fb622782be11c56b3c56da7fda50ada79927ef1940c6522519c7fb4703eb5f29788fe34e9dab5ccf3cff699a7958b3306e3f95798f8b2ea6bed76594ca5b66163cb676a81c01589242e4960319ea40af49d253b39ea7c0d6cf674ab54786a6a377aef76fcf53ba93e2369ad92f2ceac4f423a5443c5ba7dcbf171b4f60474ae1459b946270c490738e6a292c64662c061bfbd54a844c5710e256b2499e8e2f22627cb9165239e2b2af6e01919b201273822b868d6eec9cb099d49e383d6b5ec3556999629f0d9f4ed43a56f33d4c2e7946bcb96a2e56cbf77772dd5c334afe6b11804f61da9a5bc86daedb94630075a86e23784e1b1c9e08a8a49b12a9fbc31803bd24ac7b7292923d2b43d4e29bc3f2457904b710ac65e329c95507e60327b75c7d6b4fe126b0744d7eff51b59
UPDATETEXT [dbo].[Picture].[PictureContent] @pv NULL NULL 0x127b78a220b6e2bc37bfafd6b0f449c9f09da32c24b2ddb20c7de2190822b95f0478885bd8ea7648bb2595d5be539e06735f57925751aed549597ea7e5dc4146cef15a9eb1ac6a116bf752dec2a6da7dd9181f7aad4da4ea535b29600abaf31a3719ff003dab91b5bfc6d2c4a377615d3e97e26b88595832c98e467835f774dcf5e5764fb1f0f25dc67f615d5b9334f1ba0031f276fae2a54444031823d4735d7e9be26b3d40edba5fde11f75b827e87a1a96f745b0ba3e6a3ac6c47aed20d76d34e09bb292316afb1cb5a6ad77a701e4cefb3a846e47e1e95bf6be3fb778e41a843e63631823fa8ac4bcd26e6ddc955f3d33d5460d665caee6e609013fecf5a1ca9d9f2cade4c9575d0dd6b8d1efa36732b5b4adc90a318a8ecf46b799888b5184c87a075c1fceb19ade76501a36850ff001b2e2ad416eb14588c076f5359d2a729bbd396c0e496e89db4cbc59da1f24cad9e191723f3ab104dfd873a4eacd15c0e71b4e0fb1a86d759d4ac188865da3fbb8cd4c7c417fb4f9ad1b0ebf3a026ba24aaf2da51bbee426bb9da5afc42d1f56d3d21bf7f2265e3732e48ff0011fcebcff5e934a4b8696c6e7187e630a707dd7fc298fa82cd2ef96da197d405c55882dec2f08ff895484938fbc715cb2954b5f975ee569d48348f10b6977427b7bb18c7cca559735adab6a761e2e64dd18b5be03897a2b1aedb40f859a2788e18c2dc2d8cc57a839c1f420d73de2cf85b3f87663894ddc20e3e4e33f4f5fa52bb9ab4d59fe009db6d51cbdfe89a'
+N'b69f02091e1b88d87cbb1c35747a0b5c1d35e3d674c966b265dbb8286c8f5f622b374df0c8b9093b2b7959c633d2bd27c17afd8e859d3f50513452728cdfc43fba7dfd3f2ad6b509e9293ba7d7bfa8a1515f4d0f24b5d5e4f0beb25f49795ad55b26dae9781f419ae83c55e3cb5d6aeed2eece192dee6120fef070dea335d778cb41d3f55dd71a64436afa0e53d8fb7b5792eaabf6195e3119120e36e320fd2be7eb64982aadbabee3eeb63d5a599e2a97bb1775e67b569de20d27517b3962bc8e2ba914719c1cd745e27956e34a57621f03ef0af98ed5268a50e59d1fa8ec47d2bae5f185fc3a52c8933305fddcd0bf2ac3b30af94c570bfbbed70d2bfa9f4d85e2277e4c447ee3b3bcb5d804d1b654fcc31deb63c37791ddaa807639e0d70be1bf1aa4ba6b25ea486dd7e5490213b4fa1aa12789e7b0bb77b581b6b1c85638af029e538caf274e14db68f6de6985a4949cd6a7abeb4a6300027cc1d083d2a6f87f13ea3ae0b6ba2446c792ddabc76ffe24eaf2ccaed1c600c6141ab56df133519e55920d4058dc67832202a7db22bb25c3d8c847df5638a59f619cbdd6d9f549f075b2ef28fe6cca78239ae3be2b789aefc09e05d42e2eee2deca370228e2fbcf31ec31dabcb20f8cbe31d390ee910f6f33ca0ca7f115e5bf163c53aa78c921b9d56e4dcec90058db851f415ad2e1dc472fb49b4d2decf51d4cf70e95a95eefc8bde1af883ac69be1cd4b4cb59f658ea932bddc7b010f8395e7b735f54699f0a355d6be1936a367e2081f407b78da38a23ba6619f993675dc0935f32fc13f87bab78f2e3506d3a04b9874db73797103360ba2f5da3b90327f0aed7c65e3bf1078512c5b4d90e9f68e03c4f6c7e465c771ec735c35631949c20ecd1e1d39ca53e6abb3398f8a7a3eb1e1f9ed12fec5addc46064c38ce33839ebd3f5af3e6bcf3c6d9590af4f7af69d4fe24ea1e31f083ddea0eaf7b082a19501561ef9af248649a39848f0c0caff003f29d735f5b9162ea3a5f549534eda9c79961a9d3b558cef737fc1bf12af3c21771c91917f1a2794239c9caa673856ea2bb4d53e2368de3dd590b5aae9eab6fb1c5d7cca589ea31c9ae5f4a9342d623f22eed52d66c754e33f4352eade00369199ecc8b883190075ff003ed5db572da352a7b682e47de3faaff8070c71d5230f66fde8f99a4de0537ee24d2ae207b365fbb3bed643dc73ce2af691f093c46648ef34eb9b77c1c7991b92bf43c735c7d8df5c69c3cb53e6459c343372bf4f6adbb7d424be50ba76a575632f4fb1bcedb0ff00ba73fa56d3a59852a7ecd554e3d1b57fc5332855c249ddc1dfc99b57fe1dd5b594922d43455b729f2bde5d4890c471c67e6ebf95786dde870e81e27d66d60bb86ed14b1f32dd8b264f604f5af54d5bc28f7b037f684f3d8de85dca2e642f1cbf426bc82083ec3ae6a9081f36e38e6bc9c652afecf9eacefe8acbf5fcfe46fed29495a11b79dcf68d1be31f893c35e18b1b0d16ced342b7581564bbb684196638fbcec7919ae4b55f166adac5f0babbd4ee6f2e87496594b91f874c54ba17886e24d3aded2eed55ad235085f1f36daeb750f0469b73a32dee96811c0c939cf3efec6bd7c161e8d0a768d35aebb59fdfd4e5ab5ea55d1cf45d0c3d23c44d7b325bead1c7711b70a48ebedec6b23c73a44fe1ebb69f4e94c56774a0e13ee9ef822ab5c1da183028c0e08eea6ba0d23501e22d1e6d36eb0f2a8f949f5c75fc7f9d76622842c9ad53dbfc8ca94db76671d04bf68b746ddbcb7248f5afa9fe08787ce81f086fef5d089f5149a7248e76052abfc89fc6be4a4d1af60d49e18098dc3ed64c121bf0afb2744f1d69173e08974d889b39edac1a216f28da4e23c71eb5f158da6e94a2ba33dfc2cbda3bf63c33f6578547c4cb4396c8b5901c9ce78cd7d9baa4822d32e64071b6176fc94d7c7bfb3768973a17c49d30dcb28373a7c93aa0eaa3a73e86beacf155f7d9fc2daa484fddb593ff004123fad78f269c9b474504d5d3ee729757eda77c38d1923ff5ce8153d7730c7f5ae9f47b6fb1d8e9b65fc10279aff80e3f5ae42e409a0f0ed963223884acbf41c56ecfab7d8744d42fdcf5ca47cf61ff00d7af1a1fbc9c63db53d1a9eec7d4f39f885acff69ebd390df245f20faf7ae437fb52deddb4d33c8c72ce4926a81b9e4fcffa57a8798f5773ce34ed69745b691341d074fd3095dbe72c466940ff0079b8fc715c36a57b279f2493b169646259dce4b1f53566ff00e2b5e786f485b4b1b684cf759f3269d03ec5071851d327d4d7273eb32eabba7970588190a3033f4af39c256bbb1fafd3af86551d2a7baf22c5d5d6572493ce2a9e9b36ebcb8524ed6898607d2a6fb5dbc3668de5e6e37125db90076c0f5aa5a748cfa939cfcd229e4d34acd1d0e7eeb44de248447a8b0d8583223640cf5507fad653dc6536307d83b6d35d1eb33a5e5c473469e586863f941ce30a07f4acb92190a92a993e9d2bd08ad0fcbf12daad24fb99827863538ca83c74a8d76820a1273dbb532ecbacc3ce01c93c206e95309142e4e14fa53d8c16a559e2f318fccd91efc55095195baec3ea2b598af3d306a8dd614e4f27ae7d29a6ee269743793513abd8882ded63885a4219df3966c75627df3d2b2bcdcca0f5350e9531669760046dc138a5870f301db3c915935691f7797d6756845b3d7bc39749a7785347b9923f357ed4f2189c800b046ffeb578cc8f7565a8adcc61635df9213ebcd7b9fc40834cd1fc03e15b7b151e7ac265b9995f3bdf6f61db1902bc65a78e518241603903bd7450938cb991f399bfbf349799ea3a34f63e22b3864b2942cc3fd6464f20fd2afc96f369a7f791e141fbc0647ff5abc4bedb2584c26b495a0914f186c1af41f0c7c5e69952cf5a88311c2dc01d7eb5f7383cca32d1be57f833e2aae15ef13bd8a4fb56d0adf28152ade4892616575dbc6431aa8750d1a5b68e4827304c39071907d8d5ab5b296f6ca4921649948c9ec6bea56229d4f8d6be47952a6e3b1af6fe22bd8622aac926efe23c62b4b4bf14c50381710ed007248dc33fcc57216ebe545b589461c7cdd2a44b83e6952c18633915bc2309da5197de64f996c7a7c5abe977fd4a28f5423f5ffeb8aa977a1e9772c7cb2aac7a489943fa706b876645519e0b722a559a4893744cf91ce558f15d13a3396f1467ccba9d34be12452a16f0b313f7778cff002abba77c33bbd5ae264fb412b1a6f66ea147f5ae56cf5cbb51bd667f70ea1b1f9d755a078eaeec848a0423cc1b4b0806e3f9d63ec24f64ff0011de25dff8572f6502cb03ade29190a460b0ff00648e0fd3ad515f2e004203b863208c11f5abde0ef1f0d3f549349d45f7c12b168d9d7000ff00eb5765e2ef095b5fdaadf5a361ca6448bcff00df5ea3dfad74d1ab2a0f4d576665385f53cf0ea935a5d89e09196503031d0fb11debd0be1f78aac7c497f0d86a61465b0627e9f55f51edd4579888654bb305c214997a0ecc3daad478b7b88a58f31cd1b65597ef291deba2a518d683a943ee338cb95ea7a1fc5ed397c13aaca6de0dd6d70011b7a06ecc7d88af14d464bab8dcd24e369390ab5f43c9af5a78f7c2f0addb2aea502f94c4f43c7f235e3bad782dede591d414f9bf84657fc4570519ce34b91aba36e557bc4e72c7c4fa9e95811dd89540c6d90f38a9478a12f6e9669ecd0b0fbccaa0fe3515de98d6cbba78709d9d395350c3668aa644c0fa52746359da32f931f3b5b9e93a5683a478c6cd102a24ac7e523eeb1f4f506b26f3c3b168978d61716ea339c1907df5ff0011587a36a53e913f9d6685fa09133f2b63fad7a3bea36df11ec40924f2b508c00a428073e8deff00ce95a587a9771f55dd10ed516862e8505a69575129e74e670b3db3f2bb4f7fc2a87c43f0ae9b65a8b0d06e82a483718b786d99ed8ae775f8eeeca67b5b92f1c89c75c67deb9e8fed51b868e690fa61a956a109cbdae1d68fb740849ad2626a7e14d561f9db320ebbba0ff0ac98ede7b7631ca8633dd5c75aedb4af134d6cc23bcdcd1742e067f31fe15dad9786f4bf145a95558b7c9ca907e563fe7f1ae37ed3bdfc99b5d3d8f2fd235ebdd20aed25a2ff009e6dd0fd2a6f19de695ad68692fd9fecd7dbc13b7807f0adcf10781ee7c3b310d1bcb10e4a8e481ea3d45721e308d13498590828655e2b0ab4a1528ce50d1a5b3fd074e725349967c197b7ba4402f74fbd92ce72fe530898a964230c0e3b7b7bd7aa78bbe1edf4bf09346f146a1776a34fba9bc882159c34ec4b373b07ddc153c1af18d01a41716d0b602c8e1abbdf8812dae8e2dec6c6e9aeec632264765dafb8804823b10723f0afcc669b9248f739f9549be862786f518adeda6d3f5396586d58e3e55009fa9ed5b375e0686ee0f3b45ba12a81fea643938ae652e5b5283cf9632a80ec0f8f969d673de6952efb498c7edd41afbccb70905878d5a6bdeeb6dd1e557c44a72719bba219ed66b294c5710b42dc8c30e0fd0d6ef87bc5579a46d566f3a11fc0e79fa7bd6ad878bacf568fecbae5a853d04b8febfe356ee7e1e1b980dce8d3add4206e319eaa3dabd6e7e6fe26be6b7f9a38de9ac597934ad23c708f2da48b677ea07ee33807ebfe1fad733a869173a54cd05d4262901c03d8fb83552386eac2e71b1a0b84391bb83ffd7aed34ef1543a95ac769afc2258cfcab70061969252a49ce16717bf6f9f664de32d1e8cc9d17c5f25ac26cb55845fe9c78fde72c9fe7d4579b78b2dec2cfc6fa9358319ed191645dc738c8f515ea5e21f084fa447f6881bed56079120fbca3d08f6af1bd76dc41e24bd09c298c37b6315e3667183c3b943becf75fe68eaa2e4a5cb23bad135578ed60375670dc42e819a3718201f423915d86977b05bdbefd12ed40fe3d3af0fe614f7150f862c74cf16f84ec2dc32c57b0c4aa1c1c1c815cf5f785f53b4bf16b1dac971233e11a252735d54dc5528ca4f96cb7e9ff0003f2159df4d4b3afe9cb7b2b5c3e95756723f24c603a1ab3e00f863a9f88675d46306d34f898869dce0be3aa8039aee7c31f0eb56d36dcbea57120675ff519c85ab8da1cfa33992ce692ddbb943c1fa8ef5f2b8dce63674683bf9f4f91edd0c03769d45639fd4fc296da26a11dc5ba65d9f2d2b1c9aa9e34b841a35e167549bc862800f981dbdbd2ba5b9ba9b53b2893cacdcc67cb18fbac7ae4d492f8095fc39acdfde1cdc0b49085feefca718af979569ce5cd37767bd18c546d0563c6be07f8cf51d3fc6f0df1537b3476a5363b6095efcfad7d3fac7c45d3fc4be15bbb5899adef66d911825187f998035f2efecf1691ddf8fcc5382145a49c77ce457d13e2ef0a43a7ff00634c301fedd1fd718271555a7cadc6c71e1d5d37d6e747a4486e355d46e09056da210c79ec40c9accf88fab7d8746b3d3d5b0586e7ff003f5aab75e218bc37e07d575a9177af98d2119ea37631fa550d771ab98b51661399e2592261f7429191815c187f76f3f91d55936d23ceb54b8ba291ac1b51a57daa5fafe55e1daaeb1aa5bea77917f685c7c933af0fc70c6be8692c1a5b9964241583e73f8d7ce3ad3a36b37e71d6e243ff008f1af4a8c9bb9ccd24b4390f16316914671e5bb807db8aada21678d949e4a1228a2b93789f734b4c6cedd899e42aca0f233c0356ede50b79010305b3d05145611e87d17d92559cb44a0f65e3f5a82598e00c9c51457a0b647e6f8e5fed1328cd6d1c849740493c9accb8d924ed122ed00f27bfe14515472c56a4a81570a0100739aa7712f9926d0a318ce0d145441ea39e88b1a6a2a24bb4632a4d57b6726e003d7345144dfbc7d6e57feed1f99e99e3e97768da55b212a91d9eee79ea6bcdedadbedb199149daad8396c1fd28a29c5b49b478d992fdeaf42586dd65999c052ebd0b0fbc3dfde9979671bc7b5e352073b87decd14574dddcf1da4436dabdf787e1f31272f1336d5889c815e97e0cf18cd27efed4342ecb8746e55851457d66535aa4e7cb277479789845272b6a7a5e8bacdaeb76db5ad4c6e3a9078cd3e6d0ad6f332c40c6d82781b7f951457d4bd56a79928a21b8b096cac566f3fcc40a7e565c9c0aab15db44e4150c8c3e868a2a615eac1d949985484546f6145d2452f319e79e1aad41ad34a764710041c0c9a28aebfae5786d2fc8e7518cb7462f88f52679518aecb885b2ae86bd87e1178fa5d4f4f962b88cb8b74c4abd98138dcbe87d4743ed451451ab3ab56f37b9b38a51b23a25f0cc1abcb3b90a801e38e50938047f515c94fa7f9777731311e75bb95771d186714515e852938e2124f738a695c5904960ab2db394703183c861e8477155ec3c5b26a33c907964100fcac72a31e87a8fd68a2af13ee566a3d48a2ee8b1646db5b073114551b9ba64d25e7812292cd6ee3648de4ddb368c025464ee1d3a7a5145724d75ea74496872f05c1dae17e509c103fa54b6f746ce5fb4db168a55ebcf0dec68a2bd19fef30bcd2d5a38d692b23bfd3ed74ff889a321bab731dc10de5cf9f994af5cfa8e78af38d5f4a6d02f4db4acb367eec8a307af714515e229ca9d48b83b5f73ae4934ae43757414ac2506718c814fd2eeee74a9da5865c2fde29d88fe868a2bd6c6454a939b5aa393e1d8f51d135e8fc4fa7c71dcc4c4904c6f9f9948eb93fd6bc97e2ef87a3d3ecfcd8884732abb220c23024f38ec7dba51457cf6292745b7d8f4296ad320f0169965acd969f6714722eb9797a9143712c9fb8488f62b8ceecf7156fc6d64d6f7a22693cc991bcb7918641c1228a2bf2f8c9fb571e87bd88847d9a76ec6f7c338eceff4a9f4dba84b83316f3382791d3e94ed77c1074c59a7b5953eca99631383918f4f4eb4515fa1e19b86121523a3b1f3f5d2bb39d7b488229032ae33cf5ad4d1358b9f0bdc2cb048cd0820b459c71ec7b1a28afa2c524f0eaafdad353822df3347addd68b61e36d0cddbc3e45d246b2798a31b815c83ec6bcb6ead8402e2da4c3b46e50b0e87d28a2b970cbf7ea1d1a77f3d0d6b6914ce8bc0facbdcdac965719954379449e7385c83f971f80af1cf895611e91e36bc8222767940e3b0ce781ed4515f3f98a4f0d7f33be86b14cd7f08d9dc6ad79a7dada4ff00659a62910932463381ce3eb5f7e7c3bf853a6f84f4811487edf7c170f7528e73df6fa0a28af9eceea4a0a9538bb4651d5773d5cbe316e4dad87789bc256c2dbcd5c027dabcb35fd363847620fa51457c2bd25647d2c758ea71620549a7800e19d5c1f439c55ef1aeaada77847518c65dde1963ddedb7ff00af4515db0dd09688f9f3f676befb37c4469641e630b67fc4e457d19e3cd59a4b1d2e439dc2e4b7e51b51453c47f119cd855ee3f528ebd6516a5f0dc58b8f924b667627be17358be04bd377f0eb45f332cf12b41b8fa2938a28ae7a3fc37ea5d4f8d19d7576216bf60bf2f93923e99af93b50d65e6bfb9936fdf959bf3268a2bd4c3abdce4a8ec91fffd9
')
EXEC(N'INSERT INTO [dbo].[Picture] ([PictureId], [PictureName], [PictureContent], [PictureDescription], [PictureLink], [PictureTypeId]) VALUES (''68706d99-845b-4c15-9133-72a95e28f2a9'', N''qua-song-bang-capPoko2'', 0x474946383961ea015e01f70000b0c7cfa6bbc96d524aa86848948b6aebd3b58d8c54514949d1baabc98664af8d50b47966dbc9b4ebac8e302928ebd9cb758a4ab9a78e48512c9a6345da9877faebcfab73566834248a5236d8d0cb52692ed19a86965738efd093768b66906831647533a96b53472218c77a62874a32c79051784632997866975a43a78975885843bb8465f1ca7497adbc889999536054886755996952753826b9a66e784229a7b7bba586669876572b171495a698d4a652e0a586cc8b706d8639b89a87c8ab9a4c4e63423633883229c9a967364623886647cc9577a95845583223b89963d8ba77b89878e8b468687766988884dfc78a887978947b85897656a69763a89897a57631786765d9b99bd7946a634539c9a98998989884452bcbb69c89756777784531211ddaeaefa8a8a2dbab97472821ac863eb6674765784255291eac9578aa968898a9a9798c8cb76a54baa8a5d68b68c9a976898682786457e9e9ea7866439cb5c69cb5bdeef7f799797679553b666865edb9a1eceff6ab5538b98b72f9e3b7ca9964a88a87ba9a987977775a6660987844683017876a65d9dce2bababa887646553a33171010d78b76ecb5568b9f51767869e0a67bdabb87aa7548423127e39c86999589787854ad9ca1ddb766d1943a939ca665382e667755363648974834cdb5756643268f9f6846394987562572738765683e6f481b859984dfb3c0825954f9efe478552462563865281fd8ad68676658bab6a8976a65fff7ea7937326a595bbba0533d1716cab689e79b79b574498b5716814843d195a8b88987988b94a8adb18ea8b78ca5a1985651eddee421191cc1c6bf616279905866792424898c8fceb56bb9bdc67d17179a4845903837bed8e0746b6eaab6a49745289b67758f651fa78c95b45a636a7575414254665427faeef8876b75ad6817965526b7adb1adbdcebe8497fadf947a282f6f18234f461e51181dc57c2584485699b6aed7e4df6a292c53292b9c465918181940292cb57352b5735abd7b5eb47b5af7f7ffbd725cf7f7f7bf7251be7c52b37c51f7fffffffff7fff7f7fff7ff21211fffffff21f90400000000002c00000000ea015e010008ff00572c10b8a060410b0b4e58901583a1ac87b24e448c7842622062ffec65dca8b123477b20438a14c971e3bf932853aa5cc9b2a5cb973063ca9c49b3a6cd9b27810509e2a0a79543026a41397482928320a3162d1a954540962c4a1765c923c06953a84aa1f6dccad5c1bbadec169998aa2a8f0a55aa60c4480be36c1e5e4fb1bedbb97354ddbba30e0415b034c881038b8e019b83b3b0e1c38813d334b8c0cfc18ab2162e9405e36108850b25caf272c81a618f264d761c49d2a369c5a853ab5ecddaa53d583c1df873a00ce8bb6c562e7db5bb54ead34548b3c085db746cd6455d93f72423d584005ebcf2a83a3b612d8c09aa8aa850c1cb84094e5083ccffa54b9eee81bc076af15df4374bad4d845bcb9f4f5fa663c6271620946cd96108880e3de485351a95749a69a5651492810cd6e7e083101e2646109e6ce54f295e4c00863f141e355e10be21e79b557141f5546c5b55d8d53bcdbdc58b00db9d85c2742aa815438c2abc9505274af144d7517479229e5f7ad5a25e16e959015f844c36995841f73d16d97ff14426cb7f0bfdd750655ec8f28d82faf013e698629649da481f2d089a93ad15c8e69b2bd973088afef8e3090c85e000464fef54285e880e48b5c88b50712200784f7d351b578b7ac50e2726bce81c8eaa4ca082a531a010c38d2868a782779cf008dc873ccd65d728761159955e0758f10b2270c6ff2aeb4a8c1574423c165469016656f217c3210d45844706ff94a90f481c8909d2b10a9ea926836ecefa52b42d512b2d9388d4d2674f7572b8c89e0ea8f8ce3b9400b6c83b4c81e714a27121271ba38bbe1356a479448aa30a9d4e60e97637c65084be3162102a8fec0c8954aa74a1f7d7c27a0d320800d746cca641f9f1cadf02b2e8d7eb433054260b1e82f4d30f48fbd8b30f3dca66c44fb1cd8e440f691f8526719c324f3b7384dfb462619dc534cad557520d69e27abff5c8edd1f13e4a2f7438a270a90a37e27be9bff81611c3044e7ffa1d8f94184c5eaa79e5b5ea5f56d4c2cccd68d7576bae16ebb710c6162c1403321d1f224b141889f4b2b2ca1eff7bec992f978cec68a2a58d92b52a1588b8e1accd41452d16cae64fcfca059ac5b83b868895528a4a0eee9e8f6661c25b796010a3d3005b6a69d635aeaeefa62a60d01d27487042c95ca4d69514c359e45536308c079f1a63715313c27f1a630cb7449bc290d6436e8c6ccfcb2f83c47798f6f0a3a6cb093ebb389b639e846ccdc23b99012628cad6b3cf3f1f40ee53e04545d7575b51fe2e8be0d1dbb4eaa8a3e074d6fe435d750608b04f856a1194e8da784e45a4bf08e00059f00b14dea38ff259b030c48bdb9524a31fb745664bc370deddf2469aea89c46fd5a39eb340c3c2c3b1c93428b3071fa6373e9a91ef828ab147222c81a26248ce875b019787ff82b023ac800838c0e1d6fa36e4a850d16274a6931a0ab0a6afea680a6b45f0df763475a9eac420049bda172f0ec88eaedda537ac32522d162194036ca1826d4ac9f770281f832ca44ac7b392c6acc41055a0c07930384438a4c73deb614f7b253c53cb5a189a39aa46247c98832425498c39ccf00ed172d382e8b81a4418c309f0ead6bbfc214472f9a688993bd7867ab62170850552a5c3d714abe8c54d5d2d8c99ead42c07b82930c6ed8b9622c17794624610d98561e9518f1eac700065d08335d47224275763abfd84e08e56bacc7fc018838ea10506dc48c522f5b64213d25091076a5049c4b71a90f08118ea784006e6c9807a66e001c440041ffaa1ff8f7e2c5241eb9ca661f22987e4cce6a075dacab87c3346e1ec2836ddaad39edec1091a98000351ace5178109c6011c2f045ea4e2147bf9c56bc6ed9a37002977b6b60824e40e297f79412d0e100d3904210e7ca08f2605ea20b7c12d3292e10f18193237ecc0001917f91b3957e82c732a881e271b1cb40ac7c8c2eca3597320c603e489000474e1073f704317baca800c20621bf650aae2d8c9d3c320e2010780d7287d0686b94845154d21ceb964b3a70dc96b11b4e085146fe9d18f82d1b016385e62c1f8baea1cd60237889b644fbaafb1f02808b73b8a9060ba306e08e01dca40041c13731a17c66aad3743083512cb5aa05ee9b5b6dc545a54e1a545ffdec19c4b4d6422ab27b8a9b610b555950948e6a08e0c30c0183f88807223e0033538570d9888801b7e600c62cc7086db336d5b6b620f446460112a7a97037cd828527a8512c2219156cc0b8689021603fdc3da2d37eacbc74e56b22118802dedebd30c5a6002b2db11d7e88794bbd0b477a195664cacb5a6353928b83383db357b85991368c996aa584b37f140429761d21e984ce1874132e2a682841eb8edde3ad70adcd0acec24c7e2433c19d055e6fac0c6cd55430a9c80073cd880c72970ee3732400c4c6297a9fc149376b78b12441023034639da78a71c443e2dc2298b40144f16355176d80b6af3cd6f61157bdf93c64d3f8c2da9490d221079ace0ffcd2b90c702e6f1dfd85916b3c9a98b5e82a00c4b1e66a7e9747084141cabb8e9aab558226a6c87d14d551c2215fda81e26270d6210bfec0eb7a574896f6b62a84a35d0525df149aefacc7dc011c473f0ae31be9a5c1f2cc1071bb0711a0291825ae3a1d66ac0c309bcd063275061c88890e491f9705d98119a8efb90a431d29750fb29d1019488ca8b9003aeafc80b96db71ac61f5fbc5325ff3db73fea57e4d3a0f83f801ce6ff6030fce4d10c672c78829f251700e508a48faf3262d6e7023eb1368c3055583893e9e2d19cde8b6c020a92406f1a417ae708563bad2339434f5386d4e15aed085fad608548ba58f97f12103c6704304b4b0011fb8da174bff18b98d0391865a3b61c778700201a01008271c82d72788b91b6261d67c2222d8684deb8bff315a26af0411ab3086bbe6ca153014a3da4aa94afabcc2225a3c47b05efcf66211fb6d931abadcf3c82fb9d3cd0323f0a0ec683ffbba79f0665cc1ceb2a33218900083d3198efa99dc65e76f03aa5351fbdbcc892da92d897a9d7e21e3d1cd323288b78169c6cb70f18dbf83e32f29694e7fb8c468fab48a4db20f7fd2e30e7300792c0461722d98fcd5298fc00f4c5e6b5b7b21e7bcc6c34fbc508b9b43c1098108841a4c3e5db076f59efaaca1d15b92017a44403ca3bc5f4f564975225e2e88d78e5414b7d8edc97eb4fa5e3774aeca6d8179943bdd4608ffff068c30fef09bdffceb16c82fdf6d17ae20df987de6c36d473d93d2fad6fef261315bd1a6c1fe6f53d19b320c9ad268d6b00d97566cd725797730438c87800bc8788cc7701f766909c754ded36f32946ac640052c877aa6677238d67229d072b2577bbde6057260057820074dc10d5ee005049002817063aad76a37f6035df50073600ffc347c717256b10051ca3139e675144a017d9cc0342aa01d00d329d5875f87d575aca57de5d6182be0075898855a787e5c187eeaf666fa811d26302a3db159479114ca10497c705537244785c3777a0787edb464c7c6268606541646520367357f1403d4801192f778f29780838869c5a680c4b6800ae87898f67094ff764eb9f54fa3e111329601df6009b5b6049a0807ae76637e90022837824bc07213e41eb706059c4114312707557108ae187332e8035a00563f3006cd2508bef70076e78329710718e10653d73908d5133b413f0ec00eb450235f9452dc74586a865f9360581db52927957d1660030b600308513103818d3660032980854bd08559a81fd3c1093b418ce9682a75374357254da5855aa2817f71944efeb65aac9547dc94296a81297f14328f87888a588804a9880b38880a277f108888f6e078e52412512512c6027ac6100b3c66034bb00169e007aef66a3ef08d69b0041b298228a817b7868272200778e0055010052f280056c01939d77a8150833fd0055affb00482a07a5d4064757841f64018083075923339ce4675f26202508319d8988ddbe83666d67587350103f03afa75036104464ed83c6a210b37501112a110f9818d586804e3b804eb66048ed14d63883b0e802aa522008140644596568bd3626ca57ff6e8863984716d28318a953159b2515e046660460dc5279083486c8c39908ec9980429438a28880ec769950689273612880412ea600c98e00439e707399902a8b7045a9006e068729f686b50c08a59700229c019b5a00a2a790878808a50409b2ca96b2fd772819072373906ab6772be9701fbc48bffc007b092085b2639ea13513f4309bc300c115110d8788d15f195bbb29d911578165052fae23fb4ff5440db4115cef11c55c1165e192c97015950a296e8b7047ef09d2a904408231eaac00395300663500073700700c5127a296a93b8777e3955c8a912fe372557128045300cdaa16182608004d9988b69a19099881a6a9085387995f670d3136299b9421f8709ba760218a90599289fac178b2299023fd6635e0041b2e004e0c48a72e08abc667bce6305560003bcd67aad970635a8051fa87a5a80003bc88b59f50f41c82db3d133ebf333149561f9918d90d1314ba816456035b8d45831a05f58f33f00532f6f012aa292154f81165e1a03da6966ef398e3ee085ddc40bb7832e48219d0bb0017c4a016390019b9938be35a8718881082a68c307548bb551b6ff741d7e74290d01698898a1907990954aa994fa9882e8880d976221316273b08132499a6970027eb004e1687aada789b6d663047002b5900587900281e4055521072990a39cc16b50600502700829099b29d063df586b69a00523f7034be00baa170108f0003fc93892f40f6e1065091551096565567a0237f010fe5216d3210054e114e29a23796016d956451c8002f0a51d18206026100a03830448101648f0146691615e29590a31670571857e107e73ba040b100379904448f10e5910195818672bb001fb04a0daa597a5814ecd32a8869aa0ff7052572270b63401c3b0456a0103be400cfa60a9989ab2289ba9162a990958999f576916f7a9c3f5492fff088e7e600327a089a79a93abc9aac3ea63323a9bb179730ff4ab7800032b79732f08149c91a3a1098eb4d67aa567a4295083cf9a53461749d46a14d85a0cceb6278b003511f19dce73166e21ae45533490323a24b08400633a1c6067b523af037340a1e21d820566835766ffba02e6c7a77e10022a7039e4a10a67160318e00c28b0000fc02c27436a916b420055a02a46389987b179e98300e7b1b7744531d2103f805d2b9bb2a67bba9aca901228b3e77449ea100b2700033700a3302a05a76a03b2f8a2368085df98732700054b2b003e7673727065aad0b427a0a32b6905c77b08cd8ba2be506babf989a669a45ac091b3d805ba68747ef6a40705b6a2ff4484ef900791a11094a11d45901dd30117644409ecc00ef49a65791b45738b5118f01d178004173030fb5b516d1b1dd3d745b1755f03b10219c9a74bb002852b6fa32000c04402b420049f700d08702ca5767f1698c106c2547e6733178425cd7835c3b02f34f2477e90016825799069499674ba2c7ba11beaa197d470217679ee2443eae0063a2bac4b6003b69b0237609af249bb3d0c7b27fa8272a00a29b06b40716572908a2720059cd163c08ac47210bb5e30832d87aab7168eb238062a9a063f308b0cb00d6cc85376870994805046099dc5b0085ea910b1155be50977f50abf8b90bfa1b2bf6e8b01a5533a2640037bcc09fddbbf788b287a8baee2fff984df57761b407246200b07cb5959802fa6f30c42f00c4700909f364e21e1a93434b319dcc99dbc7f4cb6751f7b350fba3a59240b6e00ad24b6c298dac261406c2decc246b68094a980954969f47049dbf0bab40ba34b90bc58b8b33b80aa44bcc3aff782ba668236c019aa40ae407a73154114b1eb8a44e1bc4401033beb031bd9c33ee6c55a7005d77bb5641cad12d35b96f00e8bd22d4f47847b220062995858b9298a1623dd4103769bbffb7b01ff0c4b244002bc30d0de4103822c03778b04644006ed3539edb515d10629a6634b71330ff250963bf0c846b000f50922107475f8f20999bcc9d4d32c2503559e165526a442a03cca164b8f4c267069ff169eaa432331900208400cd523cbb5cc073f0dd46a88ba1aaaa10d69909baa698a2743328600af0a8e18690330409abb6b7a49f08dbb6b03442105c99b7304c08ab099bcac5815bffa82b087cdcc6b9bbbd631278a07afe6078190b315419aa679056380aab3f80365dc56c8120850ea437b4284b2f10e87d09eb69452b68423f5b235b473b784cc090a6d02043dd024f0165cf01d82bcc7ec302eeff039cbf774ed452e90c22f31d07d2b90003cc0a7aaed0731801579f51c53c401252d0819d15bd32338820389b8e5d285d4db96eb3d4bd656f4c54baab3450f1a036ec000736042965acbb40cd49614d42e5cd403e9b2ba0ccc8d189059150ba55a1136ff9004b17bbb29000770108e36706b49e0cd37c0b4b0e768302ad6b77abcbba6b39bc1c4f2ad6b87e0cde78da2ae9606be90b33a4b9a5f9c93bea0055fc500ea7c2d24034aa35457e342654150b6fb18464e532fa180405fb14aa44409b563c816e51d806cd0819cd917c00e0d2d15ece00042b4273b010638202fb5a39413100203a16ee4f7c8251702c4111d4c830220f50c9afc037f737793ab5ba10c38be0dd3954b3e092e2dfb189efe9345f8921d28a0d3448648cd1d49b5ecdc5b6ecbc426dd2a4b6c0bd9988678dd47dd80a1bac450bd04527008b71bb02a2ad73bab16c9cbd5cd1cac297073beda1455bc6b4b8ccdf9fdabbe1bbb60b9c41ca989f2ff99b337e0d6759d934b508b3d397474c407fcb00f0cce575eb1089b0d2e8be00581774b95453b9ded74eb434a605b57cc01d034f044944d021825e282bcbf272e0078556d9dadb08e0d29ae3e0116b0026a77e31bbd010ba00ad1311d65812fc7f3099a8c00d5932646ce542f9d4298696c01b5533c05eaf2b53a00a4168280001930074ac598c2d6e573c0e55e3edd95da808f7990923990a157aae0b8b337000318f98969000759cdad39ebcd30d0e6b18b0769e1057fee053040d68194e7b039efd11cbb790096833ed73a5b9a436c033160031b609a9270f1b298a418c149da533271b033a0b3572a7e0015f19d05440234c0d02eee15ed15cf2a5e5794ff2002ef503b6d5b3af69b23afaef2a1420661210049cc099b8d3fbc801644850240150f0381da6507ec24c7dad3512feb8b01bcee0c9f300ce2a4798333b32ffdc90fa9e4322d87c2134620ab45fff33431800738f8ed582eee6110062c0cf7722fd46f4ff7e85eba976a88198808f01e834ba0f09fb8bbe59dd5f46e0345501152e0cd2f68ab44a1d55dc28a749016d76caa40ba92c9abb45ff97ade7d022b9002099106662992bccbdf46a005b8a0a246aad7ab304d6835075e907cf7d3d93df19ab8a2952a4002a150afa17d658bf0742afefb50d1d98f6251bc8051b274f6a61329429f65d0b1bef95a19dc78a58da16e4d1f7e14b001c1be01f3d9163bff122905ede34730c119c02cd8f3115dffc914f7880927ca5edfec88ea83233cc2522435373201b22008b15056e0fea9e20e107cc20c0c33878fc1396110cd51a70e5141837c244ee473878fbd89162d52dc489161041b786c9c586203c60d3f36fcf85992d2868d1b27fc9cbc0103c62129304e08907322c5891b5e840a502507069e1331441e3a71c2cb099d4d814a5de033c54b994bb4fa49e107a80d2d61c7c0f111b64b017bffd4ae65dbd6ed5bb871e5cebda3ef01140779fde50593d7c1bb77410454b51023040a0c246871e2948597635ebc16b1a3c46ef2a22c9cd8bda364c2441e0c1c50a09850daf4e83c2a4c70321159950a15aa5ec7901522a9ffe1100b74afe0c1c3c86f0a46286cd8b0638c16230b62f05ac798132d5a184270706681983e7bfdf6fdc3fecfdef7eff4ec89b77767fc79f2e0cb7fbf939e9e79f5eac58bf75e7f6edab473f5efe7df3f468c0946530105d854284285180e4921160432c8600e7eccbb68a2822a4c68208710d110910c3554a7a08324ba43238a4a3471a2396219e9041bd248418a1b5e526909386c58e02518602ac22418e4a8c98b43b290c527290eb1c90b188ab0e9049c608a0a062f86946ac8a09a5a20a513645189ab921648c1022dc392440b1ac3428098edfa53734d35b7b187182a28f167cebdfa028c9220d851058f792cb02084100244e13f596883e1355e5488ff4cd1c83ccba2b501512862820100b5d4b0180854cd84475b4b14b661224521045976f3a337e0826bc4880d2ad9408b0d8cb02186d53869ee025a7899ee085f2ed247adb4f8d147d8f0ce8baf58f2cc53963df1e04bef587bf6c16fbf69d9b4f6dab8041df040d854b1a9085902c12416061059459f6d4494688e8412d2308c0e39dc3003441ca477a1104f0c63dd135164200da9d2480346956c4821092d5c32c9021b76bcc128286d92430016a12af2489b748221061be818d22659626a2ae418bc8841aaae5680aac515589ae7a51850d2028ee35208eb07b4b0d559e7efe610831207f62a86afc02c5b44151b2dd04de905c0fc0fb7424355218f465b7bff94175506c5ed4f3fbbb634841830806e315a68688d045e3018d0b00556681b55e184a360eee2ea36c28fe54ca0651de84c18b58f767ec08e9e7de801b63ef0e633b6d8f89a4576bcf68e7d96be6a77b6fcf2b702840185438b904dc99bbcc0030f3530498418750f6277df821edab05e44a081fd750de9452822140d02715fdcd7cdc087916e48210d1bbcb0f12a3fc88ad14998582cc2739c6c22aaa91b5431b2c79b6c3232265580b249e4c20c4d32e4135650e9361b4a6ac9fc056eb861092dc690048e34cc441373fcefb367959f83f6a72f3b2161118be0c42196a61b049ee04f99ca148108941812d0e0399c301b820cd3b5a6e9461e6e5b9a9f02a5ff1a093e870634e00509060428dd8c80373c58d5705c381ce2c0ca0829084164784103e8e82a04ce08412abab3967de8a31fc31a967ba0a538c6bd075af23196b4ec939ffc4551679252c5815ee3ad8c79010a0408841aa8e00663d84e7510819742a0610c66242211c60863bdec058d7bc18e5d1161974420d2ae13a9a30b0af84a1a08101319b1440be68b51cc9a573d3980eb063911c02162a4a4ebe54100d9ab49538a00159bc40c284ffb8f81fe533e3fcc230645e0981f56908696d928264bc0c515ae003f2dfc8001ab90622dd7d2332a04412ffe181a18de4140cc1cc24608e46055c0368c0742f0863290c1735a3381ad21b06d2ba066358b198f3fff4d800318e085a742330cc3c46337a86ac4dccce9c2561167250b08d03038001d142ce0084758c01ca4f52b20fe6a5a8c935ce2c8f3ac254e6e9f87b36541f973a8d8543163da3b04149cf0c52fa2b18d739057edd2f88d06192315f6ca001b39ea2038326321eac8174328daae84f0eb20ff1a89c156049397b0a4465f89811fdc87493a440f0644c9514dbea58ad4f0f47b359102e842569b1814660230808d92b4644a5122c806e6a3aa056ec0b0f88dc90f33ebc2030c67d0fcd9630eaba0422bdeb197bde4851d6b65470177b31b0e7a305088218109705836488d2a047e22e6955ad69b53f1e0542bd8e002b009b6002536069512a73c46d01bdf04e7ff851ba01b718cb004f381e906c3e0022d42308f2398c117de81627db4a31dc2110e3f484cdc11d513b9636da770b32528586d0b97e79d447b0c3d8450bc40808752e11bccf80630dab82136869118157d1dbdec55bb8e268219754411ed524a473e64200249589148a817c81ad9400aed7b494c6ef03c55b8ef5079d0c9024097a42b4af25b409185e7aa48b2ab2af03fa45101536bba92494c400537a0eacbe691141669c1954ba89f163240cbdb5e4eac73f8861c46113430fc8f3393b18c82a629cda5810d05db2401174a98b6b5edd502e29c26354f752a5ff8e6373c48802909bb0079c4231e80b2401b42a0e3b6a930012ce481642950e4b909c7b25cff59c061fe430b12e0f808f5f8817ddc222c2b1b2eb54be4f2e31e87b87f7c35, N''qua-song-bang-capPoko2'', NULL, ''077b972f-1a51-415e-b48a-19f39219d165'')')
EXEC(N'DECLARE @pv binary(16)
'+N'SELECT @pv=TEXTPTR([PictureContent]) FROM [dbo].[Picture] WHERE [PictureId]=''68706d99-845b-4c15-9133-72a95e28f2a9''
UPDATETEXT [dbo].[Picture].[PictureContent] @pv NULL NULL 0xc2636e0b0c64911389dd440ebdd522140241855844200ebf0086188acb8c8ee679b9ad53c87317423b7b25021362941045e955a183f04e1d0898a914a4f29418dd8825f9a8898ccc7b5e6ff954363ab181426390a4d8a84000ecd56d4d3cfd9f105cb5694a5581809196921558003637b280296d60d593c14f12afd4820fae400c325b8e5d89708200dee1bfbcbc63ad6408020c74e387b75233c4811ac60490491a54f395988285ac8c7ff39b581901b0d5dca03c74538f05a850c890154e398de0ee557dfb37d06eb20a8681814f8460056da8070f52812df914aeb58debf2ff77feb11dc3a529d8c15ea8518a22073958c10ad1e8ad43c5c08c2d40010a71d80215a8a0c6e282c318af33b4ec985b2f38c2d10d5b70d04222b22193ee2e210fc04549dc27052fc4c4902f5942124e208552c2e4067448521e42f63c525b35361b439015f350c598c137491b43b50299a69cd2644a4bf3b892ac2770eb97c5ba261c5bc218ae2089b268e101a55df89af83107353a0168bcf40760168184cda822056fc5f18dcdad630ffe49c52b96a68b79e3876f1347f1e19ef790fdf0d8152420012b18c1e4253f6416aeaa85468e1bb8efe695101c01506d30ec006a0c6c6c097c9f460468e3669bf0b6c7be4710a7bd1c6a510b01d422e2bd95b8c6a1ffe085687063e35bd88232a030083a6f620b9b905d478f3b2f913a97e51e22863a28ba210bdd110164729f918042301995a461cb532f7b3d57133a3c9d943680cdc6fc0b1b492a29669ea3836c389954303dbb69888d590c56300f3f188022b8817920401b7899518a112dd8b5b05802069883d8bb966d08230410800cfb9fbf10203220030118260da2a672e320201b4110ab265312ac5559bc56d901cbe2b6c1e2361aebb6de6804167a37737a371c7c37df40bcf5b10014a8351e88870198321e1803b66393c2b10fd93a3826341cfc68ad248c4029c43d01e0092aac429e88382be8ad436033a138042b80046ee0866890b86838c368f082280006e9c2b3ff3082a37a618636328638f88685a8beea6b3992830844c0052d8089a2d289f3aa181649834938013a20894a7a1ecf1940cfc19a98b1003a40908d290df8e38524a909a753054e92056dfbb0a599801018b0a95a8101889979c887ff731f254189561a9325f80162384229c227cbe107e5728277008362a83bced08c771000a420266a5221ca93077333ac05e03a627c361793b1e1308231a8841da846161437de6899c98341c86a046f949b734ab255811b195b093f08010c58001ed8b73eb8862163005b12b3b8783d5a94c231138056c8bddad3bddad34236f3422fd8424880382ad4032b003e3574026ba0824dc004364ca344f8860c80864488834468b9ffd69143923ba93960003f542f1870349b709218518086411a0558123af834523a2faa812605baa2ff2802a9e10501e8af1b8881f4a31a527a9abd3a0116f3ab6adabf099005f329c049b0aa97c1352539015f93045c200b0630b89d298f32ba030c510768688830a80bb5d00865d188b9d88707781004c80264b38c2cb8001158043e41a00da2bcc7aba61108c1be1bca6d4bbce1a0c631300ecb0241c2a226cc13b71a6c04ca3a4c74a2001aecb6cf433c5ff08309a0a7c95b803690075681402954387b8c3d013880cec4c289c1c25a50057e8405da93382b80b8d4bc3dd6b4825a404d2bf03d2888028d9bb32da0b344d8845f300668600637bcc87ab13eff62c83e04b88219701f2f18c04c741f1fc1923c288214382f185192f34b92d68899f629904a14b0a9498df9cb833cc8024f42b51bd82b106b1b2f699979c8ba65a4343f4945a63c09b038bb9aeb2a92f2cab5c04a3ef8157db088aea4075bb487308006680000033d50043550028597022550075dd011e94f89b0c57f981d3c009aa11920d6b00c3ce0ab642c46ca8b3c1aab316394b6a69984dc681b5f50326aacc631e8cbe080ac1c1327ca7b2cdf9841c3dccb708cd16e7b3196580940a9073f480064e4810d80c7cd4cd208c4c22aa4c2897952828c38db5bcdd1cc422825c85a28c368f0bd2fdc422db4824188cd2dc0846f182e3cb32e88c8ae2eb882ff2458a45654121d49c434709f3c90023f28028f614418a0039734014e7ca402f98fd7d014033989f4730cefcc36b0b9ba3e414fbff241a9b2807c98841829c0989900f6b2015fbb82a8d40206c80000d8ca81b08806dd1775385007c5900205007060d5030587567dd50465060030865a45d0053d5551d5875fc9006010296390030022a0c6680dab639a0d522119ec8d21cbc605a8070b18804a4120236d51e3d88106e84b1d84ac26a3d1152232cd2ba7c4541523983cc333c795203c16923c0a1803cc54527825b356f04ccfb4d2d34c4d29ad3d9ed8422fb53ddad3bdd79cd289614dd6b4c2dce3864180828e339d33dd1092920806d8be3625aa4c8489ff56d03ba1138047e253468c8d9ac803130027a5e1164fd2144d298242800190bd1a9f54b11fbbba0ce220689b000c4081ab3ac000b3817c089fa99182f9443b2dc8a800080054bd55023d50a2255a590d005865da560507a2855a00705a70a0d5047d5aa33d2354ad880c1003e3d22e0170003008025ee00424708c21c1a0740bac656556c2aa077890d6dc702cde5041c5abc670a4b16e0db219ecdbcc7b376f842cc9731b135c899689870dea4623b8827e8857c78db02c60527e7cd2879b3d887bb87fb53d2ba4832bccbd5a6805dcbbbd3cc8477ca4d7451000d3d4bd6888825ff05a3c3b3462488858b8023888ceefc9d4f3ca02bd7ba40e1cba3c484eff253190f36a0d9a90b5403d90d188014f3a90f01480cff80f68f29a55cba03e81d91b108d09f0937cb08101a0d44970c4d420895dab395cf8d41a18daa7b55a006086a875daa165d5a18d5ff97d5ff985d556a555668855a875daf5b55f5be54d4460063110833532064c58045fea264e489452e91ac4fd2b6e84acc8c3b11d9bd62163bc58814170338ebeac040a20521d7be0c8fbd618e4011b65567325ac0d42575312a7750b0e1f7a5c1936287aad57269d1855a8c2cb25482ccc8256f0611feecc2c38800300dd212662225e04243e00253e802058842c65b32d6ca85fc0841a90c37bd12e463389445459f7b981f0c4581b90a45951bf249944f87adeffa4ba8101e916e56d35e5cdadf0e404e7451038de2b1ef3206c123c0c5acfd19800025c0105988449c88709781e15a003e88483b32b0b04600066385f5a4ddaa95ddfa865d5a7dddfa1ad83f83ddff945dffd9ddaaa9ddaa13ddfa7356503c55faffd556348043c58044a108044510598c43fa5095111adbc2123d1ff83071e5b81e2d88172ada67928acb8f483e1a8c64ae081191527744b37ca3361137eacc9abbc20bbb11643d7c61a8111f88d04c880190ee75a22e22066d22a8cdc498ad22accc70318627766e22116802366e22456627b0e027cc6e703d0bd86d238a1d84228f05a3335066088859a33890154e42ff6e11cb158a429823c48a4517a4effdf3501d8b8aa1b501b15501b4179e303290201285613d8ce4ae91ab9ca63b0f94951d2a641998497301f4a4364f04c9f56d28219b802486e5aa2c55fa2ad814a5e5f56655f4ffe64f9ad013b00e5f97dda4d066570a88151a6d51a58836ff05a36fa0658108c41099493716065ecbb7534e1101d01c3f2654041bc954800aef91a145d2c0b988796f90d1335ac366031b1e666ca8366b1beeb647c2b74759b78a8870d6a8415f0816dd00f7d00508b0050b6c0ca7d11085e558bf7a0507196c2231e627696e751e3472aace1783e627b6ee77a1e207a0e8251c8e77c069a5110003df06748d02220b1022720d36f88484bf081ed6a9893c8832fa683c6301efff7c90218c8079036bff88b01f0b4e8ff989502692a0411b043868dccc8822cc88343260d1e73d9af011469bda068cd140e288d49e893edf583ef65de22d8aa5d5b822e689044685af6ede9f8856a528edf3a18eaf9f5e4a32e65a87def0070ea5266da00c85f4986d5f55de51a684327300adc58d41ba80d15a36bbcd6eb1985873f11275f4eacd308906dc280d410c5dc60311084071f03326534b767ee6adda05149335c68435c6434b70c10888aa88811798f118117ad4c550c1950050d5568200802fd10fc9cec35b1c50829238218f230830b726e67744667cfad42247667211e85015a047c1ea0272e6d0720ed45180526266da0d10b7dde673474edffdf3b845fd804af158314b80a1d29824432af3c385d4052044e008a22f053a4cb0252725e8b26a5792802b5010dd8e0af564b0d15080591565ebdca6eed1645692d0d1428e94009902238c5b6f65e985084a9a1031b988135954a063006a79ee4f9b6effe5e753ba8035757f500e064f99d6fa2aedfa9756aa83d5f00580360e8f5f64e8435a0021b0094a7d12f4bf113203337b146c6678d87625e46c4e2001a5887b36d630cb8f6ba420211000376489bd1b0806f958710a8144bc1a61006324001bcb6be919659090fac871d0b0137e8f1067dd0a34dd01ec7f7045d551ffff1082572b738ecc1c188012588d8c1f705edca1daff15fd98720a004271762ffd23d67729ed7ce76e22048627cf6043ce9727cce0bd3c678bff078cf2cd82ca5b8dff3825ff8858e53038059a44954e81b5004e99ea498004fa0988056784ef0046e90f68c4421404257146e32908dc600889e1ae7708c8da6143cce6eb93dc549d7f4d3389001b8aa15c859ab2a0256d06df8c1859abb020460a3a2a6f5f3f5e41a70f5fae6e4faeee44fe66fff7eefa6be6fa206803aab814db86201de0435f0446ab380db58f01f4337133fb76437250b98804fa00519580757682b132081baf28c0b60ab0b90815cd1376fe381263b0249cfeec3e2e30cd28d1468f7c2c063cf17047dbfdad56f7dd7c7d5ff94ec19e60781b0777e97d55835d0dc0f55ff5485507a906ee9f64ccc6867216e672526cd1ca6f821c6722c7f787cc6938f0f0cd3b672d2c66730dfe717d867d65c33a180825fa00227701198a83f3c15443a18209e78093ad0d8e1e5f9470163cf586052dcf38d06d956db68032181f46b0cc600085e2a50c40861d0a0058303064c08c130448c8603424ca88802858a091626155970e34621183760a828e2470bae31337e7461608c59801a0166d2a429b3469d3a3803e4b459d3669d0076828283e93366d000e064d26406a0c69a1a6280d5605663939b18162cc418266b418cb0100f868017cf6cbc3667e32d58b0c2cf8a7813386020418b06274eb46470e27b412f17121c86c55b6164030f2346fcff2468336cc21182c306143c5839c4d6b60b6cbc5d11838433141850600260fa343370a757b36eedfa756b6861a0ddd1f78fdebfdcba77f3eeedfb37f0e0ffeecc66ad1a3672d3e08e0380064d40960359a04b17d0aa7a965602b6d792e3bd169deddba36709b228c8a8f341d09f3fe0fe807af441ded3775f0b96152b72ac40d962c90901369c40471eaa14f15111ad2cb2880079d870431e741c58441e110a108a001066919709c3dc908f0a26e481411e246050840a184c10628879e545421128343489416d60a6108e145564500c325e34905632dec0551152c420e1097068d1859208b804934e314979135041e5941395360d35144e764c19d3724cdd04ff8094522eb70630c044b5540e89041203350ec560435811313411590899e5d60a8931b6403c0939f42309bc90308c8cc360e6961f8a21e60b0f3cc025d745174d304c9d138855d05636b4b5420a7e0812c340787c839a6bcc01b0dcaaa72dc7aa71c9c51606ad7708772baeb8da435c1877cc8148acafaeca9c6aaa22b75c0000c0379d008b48e79eb35944279e75e445a75d76d7ba17ddb3d34a67de28f0bdb7c828a3ccf79e000708d09d77727063490a379c70821479084087bc452c381d1d0f8637a1bd7998908509109ac0a12af3dc808109248c48820a0371500489211efc571e17c580273c16c473d04416e0b9d0c613f88811072a6056d10407e651ffd2cb372481122e4b76614c0646c96407cf5e8a99931d5df654134e39b5d042523b1d9514984bed846c0d694a5dd51635c462670c5fdd1011cb3b2ee4109e21302aa91192fa71b6666d79dc963c2bb8fd160f904aca43677e001a51c42a84653241041534a4050b9cb0d90282180340228914ab5c6baac24aecabc2b62a6b6cced1669b3db96aaeb93d884063dae78caf1679e4c3166bece293ab9645b4f02db8a079aebfdeadb8e492bb1eeeb8a7676eb8b70721c101b83b30df7cb5a05bcb76faad6b051e04c80b030caae4f1511ee62d92050c02e6d18a2a851491c5cb59849285861c4e7082c185369c77450c87180a87a3c98890c71e9f058f2e5b3924ffa78e7ca31cc33c56b4a22250084579c89e92ba80922b18a381544a1a4f7e563431e1a48248399a976cb21470f0644b53e2e04c96429335a0a9062664c61680110031cc456327088b8fba2623934d60228cf243a47078b61dc2052e6fc161a420051749bd2d6d0b08010a7891075ea8c240b2e891a50aa29513046e337e7003e938583aa7a06a74ae6215b294523acabd463661504718f8609bcdb19137f60803b05ab538584d6e58c99ae37124673ac745ab3ce6c99d7a1654bbf850c20185748003de71c84322b2918d149e2371a7aefa08e005029003f204600529cc8b800492c30db44189f308a0080f6a45162604be3c882f0b313001fc384103915840ff600d3381093010b115b98f04b0bc402e33d210ccc4231ef3286631f577a3850c60861ca814412c404315e4a180148ac10d9680122d5c0101086820942c18c1a03065263fd3c9d0667225a585f08248cbe0076f9213606c822ac0b0cad4c400030c70210627d011344df6cc67caa88a6e3b5b6756b0801ee610887ea29b5b8cb8150b3c5115036356814452a73a85007083b3811f1487ac319a4e56785c554db448473282ae39a0a38dadda782b7bf081567ce0431ce528c7d3914ea73df5e9e994c238d6f9f18f80845d10281104442ed5918df407548b0155a70e6f3d8c4ce423c37500e3d1675db5e8ce25e5e0052910f08015ca8252912080ecd52b1430fff01e8604c60957e6211448e08409b0b9305f96687d1549912e4d80171a986020351c265b0065ccb39445211b6b2643665843ad4c2223d47c591e8e84cd1468a1b35de866035f82ce3a70096858921269a364cea190d3274b099a3a8f86419f112d4a75a82730826642aa98b0066a70821a5e18914a71802e18a8cb68b4325123a6ed87741b419f224537b4a94d7fa4aa900078c1baeb4d470ed0dbdadfc262012a7aca704a498de4b8b8d295322e8c4a514a52b428c6c719c75865ec153df4915f99d2f40e345587735cfa393d9e8e4c2114d6e268626004a3b455f3558ab394ba204a48d8a8495d2455a90a860c571591fe88645583972ef7ace73d60b50eff778a200702c1800e0aa230834c09036ddc2b064508052bc597575872e84031b065a1b870dc22f032b082a501c464b431832c7601c72c66c7e0a1903bb16c649809e08a5861020212f0031f5152cdbc890066bc04b54233213a2b485a9e21c50e2d60ed4fc274a598c81669e88c49d0585b0770e4600d75e06d9a9c962c35a5008695c2005d48c005130844539a92e2440357c5b1e1d06d7c52a8da367a515e504b5ad1e9ce773ff2116c86e0a389488d5302805e9e968e7407365db29483e07666318f1c145daa4ee31c7500b85677d8af3d685ad3d9a4f10ec4f19ce5f6983aa08270266472304f0d8c5295ca3ada00086420736755a62635a9efe030b89ffffa61076c98dbe72271ecec739fafa2f800ad9043856070634a283208d84b011d4cd0a01b7c6060030bc596e57a015e14e1c775b965a176596486d18006a3a9c84388b9007928b60d1690f2fe0ed2061b3136caf398c407182630b216810efe9c820f7e808b6e3e8919cc4027cf526bce36af99b67538da68c53413a4c9c468b225276bdfccf300ac410cba0d400b5468951a2c650d6ab801cb52665c12d04006348818462ac5512a72050593b9866622330caf8cb7baaad0eebea4e3e97441a7bbaa80812c462d2f2adec0178703805354b3ea571d98a771bef5b265dd600413fe710c66d51d5d63395a259b35012693adfbaeba61a134a579b423e4fd2e5fffa1de7abeeb71567cb44deff5843bdc4d1d9e23c7bd9ef4b8a715e6828fb9cee555ed8cc7dee02160282efc8e52da804038be018508363e13c08004b12c6c111c860143392c30321a880a3840025fe6b286cc3c8831e5310fb394652b5136663df8c49815c8a3fc2b98474444f47b0a85c4066076120310f08daa54b0b451ea799bdf49ce3adf599e76de999b218d9d610969e1dc9f6d426f9950549853d4e480189cc08a5c045d241a177001928dc871a5886185c530148a1070012d3cc3d87d4208d2820972012f0c030cd8982a6441bd990779a80bb7b05d1ec8c1dbc5dd0dc8c2bc9c801ab89ce0a5861d35dbacf184b38991e8104bb53d5bb46911ac19ff1ee55d9e1705cb1e4d5e5029a11da5d47cd9da15aa469cbd17b4d104ab404be8859e2155d552691b1a6a9b1936d5b73dd2b94d521a928bba64d2249d07bf14018c510218ac1584b092845088bfe1182072c205d0c0cbe0525d60e0f48dc6077080c9f0536038629e30d9c41d133ca0453cc84302ac4002009162508062f04027bacd244c80c3c4db0da800f065930f5c411774819324420bf4d6fddd5c9a95c9cdc9d696e4e200d61f06194dd1fcdc50e019d00c453df556006cc22c220554d4401a40d1684ca02e25222e55a3a1f0022f98c009d242a160a3330c032fd042386aa309ea455e400718bc83b7cd07754047eb4c470d16c10aea950da8011588ff01fd015eaa454eac89511786d011d6111796d413665e164d5b7ba5cee581914fb597433ad88385110871a13fbe57df1121e7ddda8235dbaa7c1eeea807ea9d21e9094fee84e42339d5e9a5247a3c0b57f90ef1f4ce56b19b3bae07f8340b85519800a8222a69832a6c4d5d118c88c40029d4155f54632e190a8924a52e451f6099080ad08fc64d5c5b14d33cb44d6224c60650c0061881566e40562e46a4b88d05a080210acca829020ca441028919037c43d24d092fae130306e06c09200192560dfcdccdb1165de25ccf75c99badc126b899026e8239e9049a00c30da04cc4d0050a1857356e888be4052d301a366263a17c022f3c8309762627acc33ab0ff031a8800837c5bbdb58757598bb4408700180836ade0090017156c0126ac8118a5863f6aa4127210d38021dfed944f255e127ae11ce1da4236e44072de17095eb27861731621adf9e6442a18450a15ac79e1755e9bb39c614892de498a6449a224538118b9b9e11c5e47ed4892b8bc472b7407f228c87ab44228c08e22ad550cc8672a015f5d015cc3144288dc852c99c0a29188891c575d14e8403ce6713584fd748cc4515cf925000f682528968d625c288662a81f7c1c17544884208829f9001c30d037b90455e84430d659cff89f2ea656cfb8999bf99cd0d5198da65697205d0b04833202c32ce62897f00c09050001ac48ca1c970446ccc1e0052720ff013b346916d0020ad28210746667ae032dacc33884a0337c233af04293d6820bbe43b4a41bbbb09b1cb4a62ad041a8c5660a408113c48113fc822520a06954c53e82901ca9d34fec6981d591404e1b1e15d87a8dcea016e749f11d164ee79e02a46f3a1b0805c51e55e445cec4766e1b24a9a33ae28e27e48e2774980374eaa75e95b86d5889a50b2cd447520d8f56bd4716180fbba152b72d82845118f9dc98b4004c28844259928a60e96ac364a006429f8122da634a2083b6c53c445af671a2a3948d42b98d55e2908502c2d918c1129c1f0a880835dd800dc8db0da4c10cb4442c24020364c04b541006cde82fe6995e02605f16208d0a60bcaed99ae5ff25cf6c4254f00c54f4a84ed0931d2826601928461c17f5e1d2885ce6302043085c431b5cc39672e6383c430ab6c10284433c50c330384339228fb3a88bedb05eabd2810d428f771d821478c10978811740411ce0011e1c8217384120e08113acc1a929c71d4964b325456f0e0de1456176e62ce405e1a122a1e3e429e0b5934552a7102e6d6e02243f4a2717eeec4f0445748ca4773ed5493652a752c2a6a29e522152a79ede87959b52cdc70b7cd5d592d8d9766c7d4c0b98c247215158522d88009c401194c3f5a880f7c815c09d48bfe1122f1cd7635444c9b0cca1590ac419849331d644b1c508c0c526ce03d86046e0180611b94d272a065ce4038954ffd381009f14f8c10c6881932000b9320033f0a8bc6e89d0c1a83c71893ba5d69bc9a8000e85bce29ceb9a961d6c0202fe591dacc12ce6e53c4585254cc0b01ae8f4e192c36444d684800a7ce33550c302801da04cefc252c3355c433ba0c395ae0327f0023a6c47c7724b74c00ebaa8cb7678871798ec21c000ccaa2c1eac2c0140411438c1164c4522301dde21eaa2f62618fe1d1de55173765e72222a18096a495d9ed35a64b339ed033fb0826521448e948161e1a20640ba8427544155b979277746d2d88a9b87f903187cd80b164f4b8ecbeaada47b6c47f05407986e5bbd295216d8802220c122b815f06999ae5648494c9f530e93a44d144218c4618dff4c431893a01c44a43904dfa4ccfcccc3db40ebdb340a424d80b616c90d90551a2c011cfcc03719432298ebeaaa68edc2a8ecde440dbca8fed959d0f0e22ce6a2d1d822cc09dd3c2963ccd11333fe5954d4c00928af10df5261bdcca35dca3070c1336ca9f4666cc6a203097e2ff87a9ab46ccb24b19d25cfe01c7a4758c9c121bcef275b81ab7e157e584134c481250083e2b81cd3f1e9a43a7004eb5440566482152143de5173e6e915421e06d7447c3d67062745e545f04849b09eee297c08cf549d30b771adb88ddb337bf0869df087919e5285cb57a1db88e98edb72d5e7b5de79e8612251183bdcf00de830f640889605a82e61e00646da44718a05ccffc33c202b3d4b190a0c00134b19653053fb4cdfa2fdaadecc73e3d6b3f9350ae72e4c61890482d8401af8002c260219b7dcbfd265cc59102d02e6baf60ccfc16bd21c8dd0f48c4ef0cc9bdd6b49e3c41fb7b19b91901d88410c10ac2f15ecfa
UPDATETEXT [dbo].[Picture].[PictureContent] @pv NULL NULL 0x38afa65c44073e034e6f264e73e6948e036882ef5ccd95ec8cc20caecb7464b2ba78872aac4bbb9ce901e887f1e48e26e9877e0c42cdc6829d5a9e032faaff22b09fb6d77b115e0027'
+N'27d216a1b40570e52dead0ba574f00309f1e70d5b693950400ba39c054d935b875b087d9f5547570b95195b6a9ef0bb887528d5832cf47c7565216bcde7c5ced2289e9f53cc87c860297a99f211a68f4cd0fa7d4494610ff19912957b2d68f3485cc32f10dc15aa00c5c402116d6fc5806421893db18810fc0c5075408be74b1837cb1168c6be2180303ec2f38c06e01aa99bdbe535e0643bca62bedcef1ce10af8ac69c48f7ae0bfc9ff0ee4c9d09af25508c2f2d5ac3196cde64c4c9a080336080336ca65d90c02263666572c2227002ecc921e8cd21f220cf0b33f599821a0c707210d4c22188f20160b31e40413458012c60522db8e93dce1f4cc884ff1e732f5b9e1e350ead4dad7bed720327674d5c61060b2d385c09d33c706fbad786bfd7d05c2d5f1703566d6de9792d5eaf612365aaefd8470c97187ac6deebd987b3a4c73797c73b6cd84d6601bdec4b59b1421e10d6888cff8830ed8d4598cc772725f475cd92d710d8cc0524d2c00520816aeb45817e6ea110eb5332ae1f6ca51f4c42c31cd0831c906eff8031f03619ef2f4ee416f056900959740106839db7a8bafe5f9ac9b12ebe6b0b2883f0e22ed200834ee4a8f0261d01a4082e351cc00dee52e64dd6a9c0300c062397f7f295b776b1f776a1ef79b8ad7db0ddb450877719380c0bc0210cf825cbc180d78228e7473440c12ffc821a584282efaf5520ea8737b0d22ed8571bc77362f88371b5865fa44a19f384f344aeeb693a45ed868b78f0ec35eab9e1a766d88779c27fab6410642a225142b95cfbb9d4427b9418572573b8c89eb96c27dddadb522912857102f0b5021264ff018188c8f4b9b3f31684e11ef28a146c7757a31007c6c301143f559d6aff8592d25b8f935b3a52025e91809285403c34cab55648613d8822981267fdc0b8d640e260754ce4e5ebc671cfa9b10925b748a7ab5f8e165deea51c07e0264cb7002a2348e762d0e416012caf60e155307d7749e44d5d64a392f2c5646a3aecc4deeac5b7db967abab4eabab0e67cc342341cc25661921ce8817ee8c1804703241cc220b8691cacac133801ad8b013e8ad05c377bd3fe5daf33e7b365b004b7bd7ce169168e384db8b53a79b8ddbb7d00d3754a467b527dad33f3f5f00cb648aee152852df1b8c73ba8cb0b94d8eea44b4b12cf7c5c4789a56aacbe833fb0fb22b4ff587970022b89883ba3c8a3458458008e3429ba9513229613625efc850c0c7164f1930ccc7e212e291914033363950983413ae25572898d9873401e103936a10fb76ad337ec2f6f9b109e052074eb6b9e11a01a3f771bdf1cf1164d8c0abaebc228bcc2fcbd2237cef168a1275dbd2c7a658ac8524a71c41c97c0d0002dfc051230e95de5c57665fbd9b621b7918bb734fd5203841c0103051c10f0a2562d2b56042e946345e1c24156a2455b0805ca212b5ea0e0c1e8c41a9535350294ac73f264497001560258a9125c4c932a01d4b479d32638002c03d429a9f2670097408906e51914a5c9a43e99226dfab3a94fa3537f06717015ab55ab9eb46a7510c4ff93837707801c38302a48d74566d3a61d7520085b0706e18e5a1bb760ad036bf7a6350bb7add5770e2805a1e4000ca5454804c028b7284b1613794ca8f8a0a2c884093138730e6101b4851b166268ce4343c6052417d0b842c20e896b4e2648a840a179020712264cd0e014ea352530fec060bdbae89d0830ec5cd1e08562c0023f1b36dca89d27469e1b376c70d7e22651f81ab112d5b053c3bc1d3b2d6ab468a15e7d9df335eaa45fdf2298fbf727cdd36f5fc7bdf3d40b9040f9cc7b6f9360e83b6f13f7da73703df48091820bde66e30d031534dc50050ef2e0a5374e441c91932c4a5c841d4e16a1e41d308623ce1fb1e23a200b1a09ba310b016a4c68ffa05ae4f8d18a43e4a845958816a288a2873292c30b2fe238018a38d470c2892d80b12300fa92e2492700986129a795a40253a898baf4d2a5345f7ae9a8a9740a4aa69ea8ea89a99466524acea9501a734ca8f694b30eabb03accb8b428094bab51be3ae085bfc0bacaaf1adbca8688b8def20b2e4ae0da8bae5a0a626b53b3d00a022d42dfa18445b15055058645166b65320d51c82c86223a1ba0b3d24ad3ac080e54b0f0021157530d89752e9081040e6e1b40331438005106195ecb82121c5c7c07db45683101c4de68e1428501e2990e0e3f58c94305458a80410a1bdcd52282f2c2230fbdfeda436fbdfbe2b3a3be7ad50b263f02f5f5095f08e9730fff40fdde83af0517aeccb20560ea00c6bd35021410182f78332114def22021c35e6ddb10838d79a341b212474471b0e17050d52e57231b48155504b0b9e61b8b1480c887e4d008061f1f82e8c8437cdcc88b210ff1e2908ea2a4d2895fc410e3bca76262c64c30bba4f34e368d7ab326a184aae9a52dddcc9acea7945a0a50a87e42db4e96bc06744f3bb12ace3848c13a0c2cc00ed04bd4ae48352b0bb4ea327c54b6b8e28baf83e8f29b2f540d1df4b0e250cd828ec5209b0c83096c8de106ce36c36d820e5528d904152921e31d32c8804d44d544a481dbdb42c095d9d27733811dc8b240a2441354516198104e08e133e42710571e1e8cd0c288094ca0a3ffd622a4e0ce8608baf8465e7afded7762f702be9824f420165fbffb5a003fc200aace377df8d24bd0c016364998620727ae2f9d134ea3dd6318c8030a54503a92e54180dd3259ea44842d6c15063234ca11cd58858c9ad54c0e3613c89004904139c020830ca945d01432b423296469495348939a84118fc4c10996909ac4f843959d50e54d63fbd2dc56c2a634e5c44f71a38953ea96363b49a54f79c2a1519218c4941c264678cb4a5bbe6229b3346a545db10ba7b8e81709c4657007f88a5db6f8a9bcb4c26f7e090caa5ca42a175d4e00a19099643c3781d04d2274b52a9d0077c309e1f8a318313a8eeb6013ac60390703b6439e0590170202162175bcffe0c53050308c18c8c2780b08cd0216b0024fae8007a1a48e166e3099d0adab5dd9eb0279ca038cf2a8a73ff5e197c2c627bf2c9d6f61fa0918c1fef3a0fac46f61f0594f83de13804d58cc41082b500b0840998d7d2c43b39a000133a4a104e6019b24e085331741065771ca55be13401e54c119d2842006305045117296c19b65f01020540543e6f94e131e02161d645a930ed14f2f2c84235088c6200611a54d00c33f754362494872c3b1fdd018648bc950e6e69233e9444c29e1939eb654a723b68d6b4d2c4a54e6b4a7bc4d311b8272cb5be492b72064e32f7c610ba6c082a9c2cca81c7fa14ba36a118445b4052e5c494bcb8ad322cb2d228e329bccff6662209a3c1a703734b8408bdc510cab82012ca3b082005807bc1199209131f84c3c16308f796832049be1908686819bdb14cf029c0ca5f38c60040a3c6f07362859116e70bd22d820062988002b6b509e7af92b62efc14f2de5d7d860fe0b600893e5fa289630025d2c406bd80431231630f5a92f7d1a3381642683c091758804e85a6b863ef6a13ca8e8a77314c036271982059095930b90050cd4c95b0caa2283bbbd207085560b2119cd6702d8483ff1d0cf146a04223e8ac63fa1000c89494c4bec29a2d81c5a929b60cd265feaae776f12d1a134b14f1ec59342db1637f70ab127f499c9467bc22fc4b41152559c22a61c20c8c0b825a65c04cc0bb2ff5810c3cc282e7cf1d4df361518c0a06530570103514fa523df65a1809c3941533d77bade5c800c60288688ab4a9c6b1d42009c100119005819148895aca0fca43c18591a159000c7dad426079c81824a8620c674bdab1146e907ca1481afd7db8e0d7ee006632402a1de4bcf9514863e015dccb1eb438ff8f2c3b0f5fdf2415db62c7ef493208435e84114036d8094e1cc006a88034520200165755a0ef12232e1cc5139d179c94e82d2173ce8e4025825cf0cf21606a063a73a3f381010260dc542f2116f7fe605105ea2b94613801e2852d08f1c740d084de882fae4502c91d76b3691dbdb0010d187868d2a49dc28128bc8a7f4dafaa344940fae23ecd2ff298e82a52a75005a880dec00b374a666718027347516bfd462456f91a95e7e2ab8b6fc143188c1d6b5c820805620210b8b08451eec089a0debeec3ec0083b544f08e5b4c980c9400b724b5c92d15f082042f067227e7ca034fde969113d80d17b8f0ad677001c7ce38826d1310caba3e9cc86330b20992dcd7eddc200211400033ec20ea030d48970a13d08040ceafcfa6e7b2f2c16ef914261f3b002cb2ebd1ac322de6cb2aef671379908c33a1b9a1d24dd3c7abc5669e23a38a61c862d0985c802f1ad108a6f3c00f2bd82d6f179de84487ee821fdce08f2c1d4f1556ba081f3cae0a23c28d4178410f09d1431c7e11ea8302e3272409caa9b33426b9c3ffa9d53589684bce048086920d6b7a8af57c15ead1f4e6a94e6943fc49be5c9f3ab5255569210ca2dc2281b0e8ad2e6691804c43b596515d6ad907680580d1882ab314e45370f98adedcb2086d6bdb4513c6dc2254c40915987334379840c97c838415a7e842f69695ae8ab056b1dab69344ae6b2813200f4d5a203718c831c886b1f0058ca0e1a17c8311e84a642d2c019ba4b881ad6e5008c0a661b0e1b16efe0e5465cf3e3640e35b6c97e7139fcaf2c7f1eb797f95f9558350ebc762f2e7e6160618e4803776aeb4aa696466c5ce54e0430460b4b2a066906e04fcc00f2c00e94289e91a8107024dea6c050664219d3843164843050a4d15e2e9666ac60bff76eb046e208346c8d23ac8ebb64a21a6cb22208267ac001206210eb6e0175c800a0e8a4b32ead456e2d47642ee98c1a2d4244dbe84091d2aefcceb4b44ead60caff0686d4edcc7f1764da3140a4be84350b2c238800d8c0407a666245402c751666a2ec4e80d49052ffa420d1f072d0a05a85c2f31b005f616410e1423146cafa94e403462c0c32e40767881432620d198ca104f47927c6edf928f3a2a6103b80feae4c1f9d02a0606a091c80afbfa4d149d6703b460037e250f6c850e4ea03b0a41b09cacb0f0c5623a8e9622ebe6180699c82c7d0e8b967209e4606efff2257ff2271705f0e4ac8032b2a063b2e043524b01e98c43746e826aa6a940c908ff7c41eaa463058ca0112e911b054d0445900447630162a09238239e54309ee8e010d269c30802066e409efc69481c82477866c186241a30c212640813c4a006c0e14bee446cc86b27ba240a6b82090340bcbc8b09c54beff28e4d164ad78ca8f0d6a64fe4abbef20f25b484d650c20e7aad50aa888abe822b44857102078c446553460151ee70a6eaf0c04e4fa74e4a0e83200bac026f8cea1d900a0d2203c340c70208d11c4f870b14510560001a318029a54f9b100e646ca3343e23b7a6a312c660077660c8fccddf5620b73869043c69049ca711eeaadf12a0e1fc80c87c803230a3f8feaa3b6ee03b0c2b3cb2e417b94cb16ed1cb1eab6aec032f0710e6ff2e0b7e5a2017f54300312b40bc00022dc46312902949669b2270cfaad117a8a311fc80935680e936a01b3bf302e3713b2e29ae6cc0022c290464013561c00b6a269ef2200461c006608020da5136e9a0eb7ec45312024858c8b9fe4949064119d64024e62420c1a1061432ef223221612d4bcaeb26a021a28c4126d406236b8d6e9062be06cf0b4f825f6a88236d72bff68b122ee52c24c02c7ecad88840a7fca230f48b0ec30830ea505208c51ffccb2f5624f6ee2b315a013266e3f644a310cdf1c5c4aa33a889178e92e08e529b30c092a632ae3ac90fba710cc6a001c66003b672ae4069ae9ecee142a911b80f2d3f2901d69232f2a010904c154e2005ffcacf07e8253c9881193e6e300166cce2a7fee6c37cca07b48201e46eceb3f2a54791a9b208933d0ecb3c222b0e2643324c24f868a344532b3281f26662403aba91c8b07101f000942ab1112cb111744b74388393fc201e9047b74e13060ee10650d0040460c36cc0661ced048aa031d2512f08426818c20a60c00a2e41487ec6b960e1176a6038efeed592d326cccb2023eaee22d2261221511532d6b6f34fa4e2250cd56d7ca2ff188a0b93424b48a286eaaebfb26d0c576f5497ada69c4d028cadc188c00c43a52d2e4fa848e52b1887542048a754afbfeaf32a2ee5a75225f64e65115ac144308c10899234cc89106bccc77423c79c016438a0ad8eef33ff1eb4028d202bf780422b8102b672f93c145c399002982f44136005347105fc600936200f58c156900c3bdce506522016b8a7b0bc64cbdea3606cb1e3eea3cb16c63fecc35f484ecbee32e4822997c82c1765ce501fe43d94619c3606656683b4164832734405904e2d37c0123740d0e22ad0ba94632d91079aea066ecfb6c4f22b756bc3e4b1661c5047d474c334e804d4a94e078246fea246cce2681862487c04166a211ab8a116dc6e0dc6044d1832225d6d6cca6727c2ab261a2aa220d57d84023a81082632ea0bad66bc6ea93ee22b25ca87536f896c73b42061040fad429048f2524885d8d862142ac5130cc713cc22a5749530a808c0fe4ba7ee42c2ffac2a467a32668220c478f254987136f2c07844a3cf16373490a71327a0ad7cccc78aa791ccf441ffac4bc7600ff6a0011ac02ca1aedf1eee43898c0238330146600434f11e343133fdc0077ea5084eb408b4435eb3271662f4380f6b3e7089cadc4ffeea8f2f850961ad6ccdd2e72fdde34a6a6079114b3fb620622b76444c24147c6319a554152c604bbb9464bd92df78807b2bc112354974e2ca5ccd95f9bc120363e01034a456c8899c4ee01d1bc3b7404800d6626723c3205a8167b68e4870f60080d30aa20018be410c36a12498f0387528ee84e2382172696de23825b86abde4a118f5828fa23bb7508996a861ebae391d38269cb606b22dc2a8488affaa288be4505306470ee702d888a06eebc22bfc416f493230d6827114a5bf8aa1c4be62557f55c2aea5777484137841ac4603409b0a344a909190271e2c201ea698acaa18b7720b34e4ca08c4b7013ab7012aa111d2d293e68afbcab25bc5975b9bef1ee0011ea6f8aca403fc52917631c30652a03b22e01b8cd45efc458f17eb2f63ae5ff9322f8997cc80147ddc2f62da6379e507b1606e0d0cd09948eb374844442453008a40167c61332b6107a8c3dfa86101c89263c7407c2f50572c6004b86f2cc1f71b1760c338635d62a09c6040024fe07a808bea04e2a7cca230cc827f6f0498d1682d6ac107070a135c091800b281f36eee7e226ca8d639a3b6d5ff8cb33ec2865f0ed5bc226a20ff044fd6c6281ed82ed3013d94b06c737477c5b984a328bf1cc01dd6162d6695240be352dad6135cd52f522a0864188af4cb2ae29350c82867c52846fca1c46204a884830cfa303280033b62e058d1692893a7911e341e5c7704ae6f019ccf7be7e189e36a1b37a042bd7807b08007565713c3d243b9f14239f6428d002df1818da738ae2c9032120dc9e87845f3410dc48062ae640d7e3a1d08b35fcdc72efdd81675913d484e7803a45f0e243015eba83d6bd784513da84c40c6670d90b14d4d260b7c8344746466ca492d4f9793c5d708bc321ec0b71bd1f81217009d262004e481c83870ad3956d0d0298f0c1196251006fff2e004e84015e8804ec34d870b3b2e7244f474aa46aa2d2e386d219c001324c47c7422464b02965c0e4c923346f5ae39217582e58b9caf790ab92bef40d5e4fe044b08a686e40e5ff2254b58fb96ce391dd2610d84211d84a138f2d32aaa6a0cade250d242a850353ed3d0854ff200823b2c0c7af5ba222b044ca087c387ad8a247fea548c8a0c1843734cc09c0651893de3f8a4b893c2122dd112eac2720538ba71e3019428008d3d1774c137016eab1e4eda439bee8cbb9502cc551ee6211e385a3a6ca0636ae5038a4f056c600adc650922400c7e5a1884c1053641187e7a0d78947727bc30f7cf1771d4617b77cb9e5a970286fef612a9f9afaab7cacdff36266544841975644a57803a38b64239f64b41197c2b51c6692cada854ad9b2e7c372001d6f7adf5fa065c4b360f810e1aa308f437a045a54674a42fbe49870de76fd60e0abc2010c4201102c0ba9436be3c123e123852fd2e6cbe8b6c9a336cbe36528fd3bc1c6a4f36b583bf96a1840948c319966a201d8021075cc0c1510115d8402cf2a69d09436fc810f26e2a1bbe88546418b889005563f52a04e9f20e8c8a7a52677faa3eeb33ba8b81240f80458c8a1df20c09c0edf6843289390377e07aacbe571457e0a2e121ad9607793494fbb6f842bb3512f2bb1ea678be57197c29c08cef8aa49b8fbfc714c029eea6077c5eed38057c60c1f5dc059e5d18ff201cc2d7e03c8081c139eb90973aa8f1a5c3b12ca92f6bfe0253fe428e5f6f4eb3bc8032ba457a03911967262917e0c5cb5a7c7d5c9316a01b47d6ae358959422095c7f5dec5770c1a61049e78c3d20a0548639b6e260fe4809d8ebc46f2f77e73d6c0e450dae0a2dadee205ac204aa0200502c1959837ee3c52cbec4e28f6aea1e4aed5a2d0bc3e9b6c4bbe26a0d9182abbeef6e425c230b6198ab603a43d28fcb6bbecb6f9bccffb9c0d3ca009daf3d10349bf4c75d9586ff5c6f3b86978716455f2945ee9258f561d007f030731321d70bf423108175be22d32e40d092a2357f2dad4a7128a2bd0794671bf0d1e056c4b13f75b1e5a7705ce970738190bffceb50de261d74391aeeb8a0379c05ccd2a334f201442c1732ea356e63509dc05fdd6e0d927ffc11f7cda255cb31afca7053060da0ffed48747ab8c17d10718c55d178151b1823a3f82e19820811720b044478b31b1896660e00488ac1249597c1b6105c8aa33b995331b411e6e6700a26305789c33c5b7172ae1ae9ff872a16f1854015d6c06b075ce209a5c670d82b1136c11ec826fff661fe3000f52800af2f8b0ea8b21cbf66dc0446c635b9a237281cb5c6af5ced5a4999ae3c63fc210475b40180002950b61e9d6e44095e3a04061c250b1f1d004a287891e200509e2c001187ffec038c0983164484f1f3f5efc38eac0c58b240f10217912a6037f0eff289d34797111c620077a0a58c9d19dbb62fe8866cc49e91d1830481685a2c40e49963c2a6258bd6a758256ad212cc85bc123acd8b02356c40b31014588053cfcc80b3120c4a410f0e08530030f2c8f04f2e4c18b574fde88c109c626389c6085bc050b6cf8b98184068c181f54dc2852244d1a1b49d444c821cc8568d1c236852e5d7aa0b035a5d7046b013b58b0356bd2b55863a745ee16af73cb86cdfb758d1a756ad8d97d3cb8ece5af95ff3e9e9bf6a6609be4e431618217f6edd805e41190455511597e366ca8841ebd791e8c1734daf09e027c1e74dbd897c7a3917efde7f58fa8f7570874c163818056a9a08a78dfa94287000efa744016073cb848ff4a8bf4b488278b54a8d34529d56205247138810715df30331c71b9d9110000c630030071c3b5d82200281e57238cc60060238f3cd610408b3bd658438c3e26c2e38e31d651871dc501695c3a76a4238c1d35ace182431e64898a28a878f0e5440f41d44499119dd9c44dc51423d2516d96b41225367d74802741c8e4c9282081e4264e33e1a49203ef4cd8d3491b0935141846d534ca2272be4349168ba0011527bca830c155996eb59580edad5098612bd463c1006985a0583ea6a2808256280c800209b49070043c5fc9138f7df5d4331861098c9058628bcdb3c00a4bc0c0090d98a950c40d97d990861f53a4a10615398ce6826903b1469a689b6c922dff43b4b926eeb86b00775b73cbc5d69b6ed041578373c035976e734ff2b6096dca1cf2dd75dc99104a1eaa5c47872a30d8609e79eaa957563cf96d205f231434b2401bf100269858fbcdc7c37ff1e06ac1c5041618820a26c390471672c8a18a840e4a28e10117cedcd3018d62b8e14a410870482d835041801adf7c93e2704e02f963002cb6586491000459e48e400630a4d3333a1d6300456add740030260935934f16b4da1aa830a42545615274269966ba5da6072715e5d19b21d114529c2ba144049f26cd64679f345d44134d370741890311164ab83fee303214514b1d7511256444bac8e548709205b345c430411128882e7aab315810f20282ad00ecff602b2c7096a931083800073424cb05061cec4e8b2be624330d07a8b675561bf52cd0eb6082f5d5577b7ef852c40526605699b3a4409b46676a58022eb6a4e5002e1bde873bd040ddabb6da6dbbcdfb5b70e85ab922fcee23a71bbaee0263c71ad3cd2686177968a71d7f61a708fd52851c4e501e8829b012106bc40818c30323e8273f7b81dd020233020a8ec081f019ccae02530fc0c4e32fb06b430886c12c150880170e12c0845c58b30dd9ec4218aa99cc2ea2129e04a1168738402de280073cb80145cc00c770eae03570a0086a5083d28f9ec634ad312d6bc349478d8c01a500a4e34ae9c8c1167d648c2069ad0ec010c66c1ae2902f8d692290a088ffdb0861a638c6b11371931b46362228916ca47078a39cce82300a9304d2012471809efa2892c1ddd11f80d42146062521c405a1238e13ca9a3a92114a2c020941b81c2736c90e322cc20454c1541126802915a0409503985d57e2c198079665047d818bab7447820bdce2166858071748f00912fcf2135c78c6278eb00223f0401e2604ccf1fa02c28b5d8c58c55a42119040825392420585b8cc0d52900605a4410c6a289ff7b425bef1852b34dec256beccc59b73b1eb35f4848dd18e73cf1501677dcd494e7464b3066058e2100220e5bff2500494e5a1603048c1068c6004f8e887021450e60357f09efc28b3117cd915eb3298c18e75ac57bb621eae02ffd3bc78984a1528cc020b5f46289d5cc885315b9ccc6eb8a19ce9a9165e989017a0800735242211cc58a2138b88351a39116a388a12906084a2daa463aa3f3a0e68502190b30d078a29b2830bd8203eb6496422d8f000369a50d63211028e4d606b13f4204739ce6d7219d923de30e9479dc8496776f2db473c81488efc09231dc9490e3322333d958423908bdca26cf2a8a66cd2729b2be52953a9ca4c5925
UPDATETEXT [dbo].[Picture].[PictureContent] @pv NULL NULL 0x2e21b8d8f10283bc0b962a2d1800261764b08e0bc84006b3e2c030041482231c6100f248187b4c68b10f8e70847589870518b3021fa8e00279f840114cd6cd0fd820054948430a72e0836b8d269dd9ea566ace879af3b97335a611176cb03410ff80f6133aee829fd1d8a51ce0c40b18b3690130b68007ebfc0b3b56c983c006461e5f84a5111b9560235ee7300a0a9875c71bcc7e1b41965ec903a57da1254a077316d04de07fdfc982836ae1c20af9d085308cd9cc3894d81bd6420e12b202144e10083710d5a82caa81125d04804418676a4dabc154ad541b1ad9481a0749c8d9b6b845b34d04ab1e'
+N'2088d662c40cb2b101ad70435344ce8a56b5aed5ad7224041de59ab8ba85648f1bb12be51a9594309fe44e3bc95b9b3822d8c409564f7b33894ef2580c30b8030788925c461c2527c9668e0c64c882094c664a55025a2ba01b00672de64cd5d9252e13c0800cb840835f928017ba9bc05a80eb87086eff60070fe58159ecd30678d887b7f6a1cb6f19b304158402034520052926508813743305cc9d82252cb185af8275d7e76488f946931a6c81d55b0cf956d9ec100c769a715df6930d3ead54bf799dcb4a4603460b6a000c4c40e110aaf0cebf9aa502fb164c155ec8b47ef522e007166b2c62f9e8087c11d2e4b14e3023b8d882fbf2d11510d8843158a50a58c88b09d5a21631c370cd3c4cb39bc97066239e9015bc708214b821162b9651538d14242b29edc85d5ccd69acb8b583b811ab0c41e320468e10823c4d0c6085725caf6c262813021b538663cdd7aad626c03c4d769b0925d11ce7bce2794e23e1531f8f3e133c52a26e380cc23b32d9a19a50a228ffc5180aa270804999b26343484082e5c8c009529a4c74806e15a75ac5d98b5d70c16741dd026a4702dda1c02a9d5d80b9239ab031d8d60fb00b411b06106abaf85d400582e5029690875557a63231b041ac37b35c356c810abad63575d5a94eed6a9734ab911296c4d7be19c78b39baa962fd80311cd4174d1a57c2b635f0e005180c8c3bbc28820508785f8139a6581f455ea6f57d3c76efe557ab33f00647ca3ae40946b7c89ba507091402d021083c17e6f08368aa120b352a083494e9cd0e70882cb4e2e178484104865a83251e0789559cea8cf1a9459113f9c75b94c697dae8460fb081c8f9178598a69a0e2e300871e55674747337f7020788736c45ff654d50121aa1471cb11144b1282b21533ad32680e5738974376c72572691434ff7116fd6816b326791e311dcb7494ed17568c00e228004d86132a19316638729ac8202c3300171214dcf7416edc118a8d31597b60046e00befe10b09933010e5077c5142026206770117b0d515bfe50726400318f06aad560836700311372d36900393972dd4757998375ded8486e1421bc1401ad3763546d35ed4f67e455303ac7787d8060c62f00d24127b02d06d06950713e085e2b650cc8207b10484069600aa833c11d46e1d530fac23521b0452bda27c21b42bcda75f237531fc864a2b247031230004b7388dd27d3d21211db2381742500260058710796ea07a47d4ff54f973369d675e22977f5b521b39b06412d13611e146f8e74604f1556de5726662656dd55635f78c8490802f90800a188d6c9547105837685614ddb811ef90133295334e87471f7157e778571458573851662388385b6649574781e1f849a1b0495d2715620703a82468fe864a1cc02ab3e577d27431a7068407b96eca748412f4501ba05fcaa418be051771616815c9596e9702d8410a54f1011f70038f7103ceb5193eb00563a886e5c34e6998866768795f056ce0126c2e301b56126345438778982238290d76000cf5778762e0045e7008b2373005c50b79d07837106e5491202a00032700849f354baff3156d411622f55195887cea76898bf1410596ff3cc81361c35094e0510b02a78aad184369292986755372d00a02200787400029a0063e400562000cb80124c7111a5ab27fc2d00254c27f13d13660d2103a1737c3488cc2987f08b1643847806572653b278dd5080484000409d856d5088d65b2651981571c4181689611e07881329333a229133e275885f30e8e836675c366189138eeb88e0e5075263814381067a8e9149cf0495d279cd86159346832fec6012a00905cd159d25477407802bf853a86a76f7be1697cd789fae507af6301265491b3659117b900294003aca002dbf40113700333e08569108663886b985772d5e53d66b892979792e34310358024556463019a93326663acb797b5817adf80ff0978200bb2000344791d2b74035e6832f6454003130327e05bcda4760fb4180fe46961a117f1265223a53cb2145affe1a1c667a2b8222013300c2b64611c6653a98853aa388e3c013324269787507e78896b623010d4b6096943116cd01063e2648da97f10d1098e298c4ed68b86299986c98c9ce946c4188dd4f8029b49087af099559a651e8149945475de8837e0c87d88b37088f3741e110707409adcb81118e10e41c126efd02127f17436011265ba9b8f530c58570c36b12159c009a1209c9b137662674afe06681820a918e00c1c606902d20621e35bb0843a056201b2408586774151c97b2be0070f143ba6229e47b0833be84a0b700259e86ac6f5ff013100078e074e23991096d02dd89210a0215da2914e67283ec3b686d8c210f53755b8411be9d093b5e19f795810e7020cd52a0681800727f0a0aa8020f6759449894af6a50272a00274900730408505925b0bf02bfa165263d189889160c9f7409bd82b87d13a3c7084f1566f678142dd666167694330b3385990123df1497aa5618b23070e92505ee004d5620939a00671f06366735659daa472d48b523a8c14d1468a39a556da8066d209584a114f5a111e60805d4a8d258b5665d54635b16512489a6b42819363a80abb0859900588730072a0070e900dba399bdc981197341428e1a749719a95a3116c32812788b3c5809a7e86a88a9aa826e0676247ff3aab34a92a505a72f72a53d81526d4a9b2f0a9062261cf992b83d7599a6a7824a3aa5a612a03c0aa9c15030b3001a78001ac800194e1917090045da819d4f2ab09a11adf93109b001ac2d692f789792cb92dd36a2ee7421b3d59a079d893acf70d549002277002310003096532dc6a30cd1203c755a1a8eb94a0ea4acf194bfa66aa23d09da0227c61f12bb2e460806160fb75891984601c85aa68f16fd4777d2ee3326ca99a92e22837b3a380f8a010e70496a00639100747ea027093a5713456df6b982a4b268619be75c4366db3737125b256da04c658116fa507325b8c908056907056a7997476d58d97147452c7b317b28a3d310a6876a74361b3806aff8260c01389639b340b598933a80ee09b56e79bbe79b57e160a5adba8dba14ac705b6bc107724107772c7aa3b98aea01a02b00b3ac3d09c9c656813c0aa13393b71313bae02c3ad9ab786d61527a002b9b34d8550abf930034b30a1f0b904d74bb109e16b4a0cacc12a6cc6da2dc47aac2547c5b4711bcdea5e409687fee906d87a02b240bae2c1ad63775ccd52c6e54a155441079f3300c3d0c602024b9328a2215aa2123416adf32bbadb2b07364108c62be130bcbb2b20ff3aa3844228d64728710933cebba684626102f3a00fe70469706b564abee67bc911f1a44c2a566f23be136180703456976026f4abbe8b3956ed1b116d3408f80709a66c8cd9bbffb26d14b282f2a6664a759624391ef10e7aea282ae8bc6ad68d336175774a14e7a88e4dfb4822f18e64ba149053b54421278bd00a188c1d8a6a02c5f9678226b6794002263069222ca93898b7aea45984360cac22a9c0a4164780029f50a928b09cf26c321820cfe4dcaa756b69b363012ac00a24400a1e59041ee903536003d0a20633e00362f0abbecac4c210acfbb96be2636cc23a3ec50a6ca3a15d65135096ebac1f7d87b1a0064e20ba563119637c3230106e9f6383692c304e19033a18bb7567aa739c0099a65110251606b61f12530914801e3bd0003bb003eaa11fbcd2d31d130f47d06fbc800e330a1e2f8461d8f7203e1b21329443e061617230ff197309b16a40007120cb982c11ee9bca6f534794c9b2972c8c9d40476bbdb22bebbdedfbca65628cab5c11d820b32747cb1e70727c1dd7b2dc4672a211e998cb6bb214df0829bf9c531b2227137228048c2896f473ea8813b729281ef1281058d883ea0e8af29b9a24009c8004a1b01da120031710838e7a5c18801d5c60025c00c294c62acd59c2309ace608b0162cb0b34400bb4c005cef0cebe0d69bffddb892a03d8410299652a308c838c160237505aae1603375008ecb904d913929af119492c1a25f9aba1215d0b315d182d1a4e2cb9508c860c011ab5c11ae2e2acd2a0a02990ad3100c6fb080390baba4bb9942abd94024340939129d760c26a9bff9010a54c611151f241017b012c3c40519540d40d40e16340e1174ee1445d091b94d4ff31c82f054387ec138b508a3445703ebbc834043330200531c0d55e9002964000f41bd7f947d629ab9894e9c98ba9c96c041134cec97cddbe7e5dbf67e572d840bfacecd715d1d74bfed7f5db466565a584dd65a479a7dd887589ddcbbf6c137a961407000b1ab1b441118f42a1285487370c0c125926287242d849b7265897e5d39c055a1b0a344003a88d0468304adb5ccfdf1cdbe0fc4bbcf009cc099038c82a621bced8410ba9bd0eaee00ae3c0058dbe0ec9b00ea9f5e8aeb00e9c7001c962cf3b082bb5edaa965604acb04da4100385900240bc044b60d069e0ff03096d2dd6922d8d7b2d0291868f6b4e1a9d6bea34d1ea3d3e8e2b5dda426c6b200d5d9cad3700c6268d02feed39ff166e2b4d40ff2d300213d331d0c6a7e32960817711a5691555512395008d20e1425dd4457d1ee73106168ee195f01e3f3d311d634213f0521666d51c468aa6e8431382e22ec47d30d52c0f7a0830ee044e001169f5366cc4c9e7ab734d66caa84ce34deeca4b3ecb7a6dbf76fd5651f6ca6df410d92bcb7fcde4ce08b306288278e40f742614bed91189ed0097e3e62bc875494157683ad9826ab36cc2d927810334abd9da78f25547a8830a06d3ec1da17001c1a9da79903953b1dbf58c1d3410e8222cceae25b6bb2da94fcf09a90dffe9ae80065bafe9b4604cce205bc37004cee0c628505a344002669716f7dcaa99420a00fdc32179dd4be0039b31051170f70c6d2d5be0f79be73d0d3110a051728ebb79c36a79c07eacd822065d1cba16f0c5ccaed2a3531526739414c60b3140ed9762a16861b6700c41088ee00f3531f85a18a5bfd3c0d27c60a11f465009ec7ee1e951faf5d00628e00c2d636122ee1359709633f532519d61fcdeb37270198720052780076910d618cfc934ee46a44ccb43aef0728df1406ed73f5eca4b5ed7511eb3ad7ce46582e4a75c659e29f26bd5098450134b61a6c5d05871b6f260d0cb948004bd7c115eae14982467af39d99243490001c68103770ede390812ff048cc083032981f1b7d05d3146138b1503f3ee1d994579f2680b8504cca22c48609473d0310f06152a3098e06202e64c122430dc4481e2e64b1948d88910b18e13ad67ce8c3afbe4ecdab5112398d683ba60818510137472c889022b87095d27c4989087950a0e456ed82090afd094086a6c2888802b4d841c39b6d4759117555ebe7df3d6bd5bd7eea61c7c85f9cdcb868d8b4d799529568c98ef16316e0405b2b1e084ac189d3b4f50051a058c222d55f0caa322358c97bc4c78cc2380170c59216284c06d219e05a90bfcf0001e3c78d311c013d46b93bc4d88e56de2d593479c47a346951aec69907d47a54a141a8da8374185aa2c02046439805efd28ff010716b1377ffefc81f9595a092009e3061d1887bc10488300013df0a0090f0621d003023c8004920309743042081f6c021b489ac030c30c2fdc90c12620c106410721e4508f264c3491901708214443179be80443423a61b109166fbc71c517de8108a31e277207878586dc88123428d1088920904062114a9e144820828af107237faec4e1a22aafb492ca81dea1c48185c414284c88c000128720dd01e3498e54812d9436b3a0043f7f0480cd251264a241a6986820810b9b726a09031268e0849375d6a1c599618eb826847aae81aa1ee22e2d8e87155690679eaac8e200030eb0caea2b15482145850f0a39cb86340a59428b192cb1c107b9c4a08b8aff2d5c5046b2c5fadaabb15d1b93ec30170e3356186136390c1b3dcee3e690038e31d685cadcf0c19714343bc136cf8a98005c1562306d3cd57851ad8822f220218f3ee12cef36aa745b209edeec1d61850578f88d870412906781158e6b63003306386282848f086180362c058e3a2328e02e3b8b2bd9ae91e342404105f3b200b93df4483ac03dfa6a39a096f216312f3df35a714f0e29f290e38413f048c112025059308e0411f459c4032111f1c20619f4d0c1179b8806436c9cdef043a80b9471c516f5d04345ab334c31431a67bcf16b165fb09a46b2178ac8017fd4b468cc8cc020c3484ac830889d45166912092423729bca88b62c864d2eb5b46820ff07c2e4f1f03107c2a14a358b513322272951290f75914889a356c0a0cf230c5632e15013fa1c1d509b5420f425994840779847876987524bc3f98e76f09ae2c1083f12f063537806b02a540ec82a35863c3e28027956d15ae286256299210d037c8860890870c50bb1c57e752caf5d81450c956a8fcda15a65f0f8618c2ec6f0020c2036b9d6321ffcd8f604cd6ef00c05b06020b7b4d2ca3d8d693e9787d778a43cb2a84d087ab32fe070aa5e521941025630820550305ff540d8118ef0090e1805050c83ce0a22d6080a50ac6216db4e77de208f360cc363bcc08fc8d2a39e45a42c3ee7514f7a4aa69e2ca8420eb19182cd6ca0b3049108430db250833eff64b4243a0841422b918c4e4408acdd488a38c29007be66b51ae9816c2de21a8ec408231c91ad6c05220410c8341034ad09070e20c346c8103732e82d8e7163d222d8a1373008c91f64b28845304225424ea48d69335c10c26410313da447856cdc489cc489024a8100da6092915a418920d4c223edda139f46470b1ad04050a713cf4d4cc012d40d03058f3a421b28c514594205772be8ddc036b580795860003ad989f05010960f4ce0033728440cce92061fc00a176a88000196209708c4420cd9e30bf7b8c72bc678cf2ee573c15e8e35cebe08430cd774011b94d1851f20c00f78380112fc010431fc4010d9a29f662cd02dcf7c650230100f68c40340ffd5a44635af410d0c5b918518f0c637fce257bffc502f87ea2b60f2d8d4085888300e7cc2a31c88a52d13309d4618818414dbcec5b653c2e3904b15bc00190fd1539f96c9073fb510d9794826003aa8820e8780c1096ce084383488681caa90d13ce033073dcda91582aa819e3645316a4d4535d25155c978d5aa82918a15c2a2d86264a332b688459de8c40b8614a635b1292373041319d841099fcc911d735d44a2f8e8a32101ae4a17b9482027e28fc146e920486a9323cfb436c85d4420775b4428c462164b48211491bddb93ee53c050fea94fa51c5d4d30d0b19bb4c42a5e99c03006904187b5e11eb65c40c0e2310fa9ecd253bf0cd54e58221e1a4cffa010ac62550aa6a08619dc602e1188401ad2208d19c4451a74298c5fca278cc244173084214c5d90e582c28ccf056b908634c44019045cc10782f0831f4e70832c80c1135058c212e8b7023ce8b336fd8c81fe6250041488eb7faa6849bb4ed3ae02c6f4100bf0c56f26ba80e5c4c3c10e6e836eea11db7a39181e053b424707358078c8431e3cc814494fda880d9c303bdca100883906607484ac3c2fd6214ecbd3b299eab086211340116000032948c10629200014947a213d5ce8694523b215bb9aa32f36d98c4e16a3d8c6c6c52fd6c8467a709618a9ace425ef084c94086c96e036c7b91d89494c92eb9991a057322c64231b594860dd31912c3936b0ff84fc2b4312ebb6362db671905b08cbb2100a13b0220627d0191d30ab374aa44725a18449296940ca520a8a25a31d5e4ef86b95614e6000b7c98d8379a39b10588037f398c76ea8f24b43b57ab4456005295a758356cd457ac8150373e792830874e19ad7ac2e7705a3ddc09c1330d1e5aeb0f5e217c28821160860400132c0801fb03305c390451006520b27e4539ff8bbcd673aa33f530db43403cd036a109a6e9d52e210e9d5d7021a3601dce0061e54098183a5c2c20980542b9f2081104880827c4f7082c01901754aaa701296b862182be108dad09961c0303e33cea94d3f066390d5b086f7e1cf0df473330214d56851cb9a8baac8d53236596b5683fff90b8020732e2eb9aa34df9a594f94b5294fb9e62fd7d10b9e1484b50d1607724cf39913c5893d322951a1e00412da0c37a93b3270736653e3d404113147044818411223cb34243f9fa94df4d146e814418059112014970d451c3949098fbc4626a294b42943c7924ca3ceefc31b6da73d4def187cbadea656356e06501560ee0475ace04221de62031b483e0dd05c820de872bd08582202cdedb525be1918eae680588dc941aeafb905d6f36a9bdfe3265fc4c0802b3080010f7880ed19e0863478210b0ef0c44046c10d6febd333f90328fff62b2e73b5642504b47b1e4a1284034b05df1cebcae21b066a7dc7031e1be4c233b8c0055a7081030d856005ff8b9329ea4c47c4266cc00e76900b0a1c67d5a7318fc5613c9f8b83ccd1f809821b9b3139b8012980811fc303021804255a22223b22aea12a957bb29e6b39b299b91c19a3b3a24033d22a269b399afbc098e3409923036d7b1c21811b33cba435e3849060c1a5d32b2410817738334a100130081c1c60042be923be8a88300b928838883e8b1231293a1c5c9bc4ca821f3a9e22480135c88129a083cb2a026d681345ea88d7f0ac5222254a332512401dab700997d8099bb80952c90985f134500b814950bcd5ea8a5011ad42218509488329b081ccb3812910bdcf5bae0890065ee335608b8508088c614b36efa10cf10ac4bbd884ef41bdec423617d80237ffd0820df8813df8810d10845ed8805ef005553800a2438881080220b01f1b38817d0a01703b3eb0d8affc5205fe2228d79089d870922cb09fa9c0b7e0e1a09c181582cbb70a1b808e1a3ff1c38061c08d08d3b77c01b1f5138e849b0e1342311073b010a838d9f818f360999ca28f99c2a12c588484b831f3e08f1d4b01e44a81a33911088404ac411113c19094ab9068c81a786c47acd190ac793298c39114c9910f04821be1392ad2b2990382107432100cba27c9c1249c239f601276b8805040141ab8800b908116348144a181900083359bc836cb12aceb2b1fa112881024bec908833093b7e1bac63a3a453a0018100b15508414682e35508422088525ffd4863972922cbc3b49232519a00119589dd15281ae202d43a909330c265219bcd5aa37388c4332ac89e4491ecd53ae25c0c3cb0344e41acb40e43c4114afd4c38b5db10bbea88b5f5b3d65038cbf58cb1c40804bdc8031f0857018015fe0015fb88676100276688844728051a805fbd9270be08ce31b8d578c4500fa9ccf3101d7184701c80cdd58b50c0b94f11b3f30a4b761f43ee091c3811ba684410147711465c49705b094a64800d83ca9122a21105b8178088196e085ddfc986ffcc68ddb38f718c720408ffb10801da303f4b13d1b309177ec222a82c7a6d147e784479e2bc876dcb97cbcaa636091eaac2279643282bc9aee1c1ba013c826134884ff34a38760842c4141324083a663c1cf7ababc6b4144913a165c84232103b609c23823bbbfd9c1c622bb28213bc4ea2b1ca01cca29023a60050c70c234c881193080139082560805fe80bb45d006e8cbbba40451a43c1d42f1bb9b10ada90cc661d2be7a9bb7e0d12d9610aa135080141003e29a8125d8b55c03c4ba082fb4343640b404be10a7c978cbb744274acc1eea12361e45803170d22675d20d08870d903767680767184c4602be830882033804539305530b3771eb8c22888161201718400100733e9630202751055e5420536b9851213f1920a581c38d05c24dab48460e781480033899a0852ca84c65648e87513fdc392988f317155b538f014e70ff0c991ae246711c47c872199ef2a91370030420863f58022bc0105840118394473d8005e8fcc7eebc477d5c39ebc4397facaa2ab29aefbc3267395526fb39abd21a849c391cdcba858848915cb38bcc3ba594018becc89020832cb800bd42831bac08438a0814eca31f8c1cc8d1880235d0212c50cac19b3c2884b150843468ae1c20001f93023ac80253688553882c4e68051330548b5c5619d0577ded13a92c2d56824a51119534f434db689886c14a60d42d15b80102b0042798825d83262d10851d0daf1d1d365e0baf4044a75f898c252d1f1e5dbd8c1db65c9306681b83f449594f6ca731d8005f58800d68846b380267188745b92b6d133e3960c51bffb000c834d3af30d3fe0917d3302815c05418988a61a4a8e5e0a8400114fdd10d7b0998e548ad0e1a060ea8095a60ba39ca887760872cd8cd47718ed74c386a54a146588189134301683141c3b18e9bb18ebb9b002409f990839e920235e8820cb08755580239b04ef28455ef2c4883fcc7ef74559e1bc8ac2a2b8394b981e4aa2a134f16915c30b291293ad52d5a11c6424111b8ab338b56bce384522a5dd23101a8aba316bc803c6ab389d8c13e92dd8ce01bc0123347e21b07e0ab36a11b2a11124ac8023a483b56c803528881b9682e01515e1ea383d4a50302fa49420bd150d8487efdc23d3951d4c9ad51a1cad0dcbed582c35179d12210aa34b0044bff50aeba20cb1d35598ecd01d12359c1d815d8fb0b24b5df8c5d83616b0c3130060668d2f4e9854bfc811ff0c497f585035e006a908a6b788671706076301ce0138086ba8156c40d585cd3fc120f72e1e05a2c894508d352bbc6788830dc18860970060ce00274a1377a892d7b898701386180a385756019f218052e159362005b19e005103adb12e28e21ae3fdc5c311c024ef988299589294cbdb14df5a943388114880562d88755f0030160c8597d011951910b7c019ee322c34d55ac59d563a805424863318a4715b9c72953480b3c4f33fa400c0cba99d3ba851081a4ab
UPDATETEXT [dbo].[Picture].[PictureContent] @pv NULL NULL 0xc88dfcacd13101522a1d4953dd16e4844588d60b40033060848a70ac2199ba38ff73aca39bba4872004b6e133259ab56b0821b401ecb290402d8bc34b081b3d0190029e514508441833a4ec88265ad488de404eb9d8998703cd4d10aad1815d4f234f075cadc2aad1bd0993c1c2f6882aeb18c85614bcbc2d88b8c5dd243a444b79c4424fda6c1b08b354080ffbd82f4b9022775d90de0446fa6d210b8867058806168e09b7d87e0339c5198c59f85e7e3fb8afde9af6160be72c982005c457266d1833d82d4e185c0c30daacd170a32e23ee002a1a8854338045580084402031140837578864f608a84ab8446cd8595a2807ac04d17f2184e980f188229719c31135085dc2c6901140090939913f0821348047bb8e22c3e00f594630f7c816cff885c604d48cafdc72b8347eef4ce9d6be3ea24c8cb65390be4623a9eb96c806a2090dd36834f24c8c8593e5d4a1ae4412ea52ca001244083a56bdd50b80092c43a6c859b041da4908449c7aa12b7d1e4c7ca83ff50841b280245903ce2ca015198020240b4f7258029f0'
+N'3102c883cb6a92564eca8c24ebea05add03951341ca660e434af18265d5ed843385f4b30e66b422ec100c46596dfc138c4f80dc48c85df1c50865e11b6477cc4c220af2bb882f22a2fffed022dd8c41fb8441fd8001f30824fd4025f90856140066758078d8860e0a3845130530ba8e00a1ed370e9affeea9f8e290de943025d74da1038028441185d4e61437106d411618c0a0e5fffa0a07a3802f2430786a6061510018c7887bc72860f82981222a1ea40b1218e84ef585bd010007b3d0f18b2d72c7065b14d8d52e398f308c0fba00ff3500529b88198f68299bee215108010fc690ecc9103c8060c9780a7666a9cc3695f0dea5d6555ac59631447d50aacd5a033233d9e2334b0ea44c6ea0fb5cf52b2c8a86307d68dd64459643519d021b941d9652c2aa1a321f94f77786b1158a38d609975958234a86bca9b818a35df00610bc0362e1ba0835688c1268956b2cec831a75ed03aa560d2e534d765ee155f57530d0218365ceb43c1705f60c30b498c5f90150c5410851c1027614085408f66bd08f4d9f3dfdaa33dd83ef46dc66d4edc00dbffde446a50856140077418474fd0b6e00bbe924989a10d370bee27fd694ad4f99f965884776028b0404dd7710d18e484f03e617aab2011e2810d30a94de1817aa00618408643385364d84d1550a0e918628b6980fccee84ac8058ce98e918ae1177ab1dde48542450292560157e20567008b437619fb380f3af0022938043938042ba88159f88702388156c06917a722b301820f9763a66e7720e8f07b4f48858c633a9ed534aa39ee5cf1c57d555555631649e33d2ed6d60d7319a8c88f44caac96347df571241073b116097fd8c1201cf202551321a1eaa94b93941c13ba59080655de1c58bb29e0c309ed43519050ba10055711ec3cb89b89947144beea31ffe757a4a48917151ee111d832d42d0252815e89df614305bc30d2ec21d9bdd88b5e49faba08745108f4aaf77341df0bc868823888b6f282edd886edd9be82f519e02ed86d7096059b1d07c20c0276d659075019b50982d498e786fa74716b4a35358dd2e004ca018b5121015a90ba39728051bc9220008bc563a0de2e3170de80e0a820458d8a84a38e62b718ec3876eea88e6527e2377883782017de748d010b645a48379d20810b708575e08010e08526314e1c92031e83015568e85a68813ba88002a0865aa0770d8f1115b9e97e247e17e77009e8f09d7e3220187ef59cb903e8e99feef07c1ffe0984dc9f3b5c42881b76400319d779acdef9875fd6a4ff843a4451f8a88bd665651211689c46762b30b8056295081f49b321a9b320d95d3dab134b5a3b80107589c09482a2724c111501a1a51c0ba7788125274ba850482e92c97811c9858e1d39c99041632497925c48a0248101434a9629499cc490c784893c7208a042952347ce9c0d737a6083cac5961c62a489c929ac674f176cd8b840057528500f563da01295152b53a0c60a20b8c2a0cb95b057c896bd72566d972e1bc6f81a2664dcbb779e1ce0bdeb0f8c950894dcb97b97278f0a151362208e112271e2092850144151380fa7778b60a070c6e50299779cb22c7a370a4cb1bdaa42848837c257a30d1b76548aedda088f05f546dcaea75bf788468d6257ff6a207c8f70e0c673c5a6402141bd019331f0c2a062250613181ea32021c315775a0342700a92e580000159b2c8b901438e002b726ad5da448c5f0118b55e1022f402c80bfcf9f5ef970d7f03f6b75f81fdf1f742360a0a6820824048406082064a904d840740b8e082073438e18109e687608117a181c6451720c1c9053274148a0c2eca00928b208914e305267ec4492817708204183800864331601049a408641089833f388041c622482a29a492c594462492643800062574484100040618708901a2a491d04107e580e64e04f8b388795970b20812686494d1911b79d4a2482499d4274c27f949024d34d094871759e90494502ef01454538cee74504fff5c45e5544e514d9553279d58258a078f782a8aa85ae5140b036b75f1435b67a98a56176390f583165af872843374bd13045e7809a00a0c5eb8e1c32280b529002f841536c161872176986413a820d974e10511030a3420c18e65bc20830e180ee4ba082f8ac5b3000fad01374625ea6e5049233ce056cf35bbf1e65b6cc409d700bec6c5960b059528f74673c3582bed632a7080c204474c40022d5c08910c779fb4c1c1225994f7a61c52ac27402def1d504b29d0f07385000702f8e10b11f66721810eee3761361a1a386084107a58a0800256c8337f0262f8c2010ea64cc87db52408c4011b21e10a471ff1e8d18b2baeb8638c2ff688868a52ab888608ffc500e90e933f8ad064d93f2e09c645658f5d2418fe50f2ed3b4d8261192c52182005049740e00141a21030aaa8968c9a0311609447d1223d6274241922384ec6892a8614129f347081b9499a97341227348452132f067820aa541e0ce2e852a860c5534f698acad32356e5e47a5739797ac6a69f7ad077dfa5837ad0a96db5d5aaacb3c24a7caa3f6ce0c702b20840c95dbb0681075911e0e146178bf8d3bd3f0e2c826c61d116e1acb5cd963f19279454cb012dd9b2c30e2faa0c03a71cc3c8128f05e5ae806ebbed8e6107ecaac4061a118e11203081bef94d708693af7c550236119c60c0ea819aef384661ca5ad80006c00119d042255c90d8388ed006ff4e90a715026805c6a4108313e0c102301040c86a110d70ccc20fb00891886c060420ccac67336bd0cc7eb8b205e1cc4243ac19116116b4246608882d131a7fee53b3fde8c140434b10d34ef4b43c458d452caada8a543427156dcd8c4810c19282f4232b3d0e496fc3c13b3052241c38801271034310b484253250228f7420dd25bef02508f42d21a08a0001bc503a5410c0037c348f09ce13278cd8c96c90ab138e7844031908e193231149e6463292507022952329940a22393b4f05052bb2bc8a5668172a54cc0e91a5131c2cb1228a473c0291c2ec5d2784a94b0888c2546dd1c2f18e372b1ffce007b08aa6169690022b1c6014bbdaa613c2a2851404ff420d6ee05ef746e1852c508230d2914e6114160365a9e25985c1c02228b1085970c0042418060a86e1cf102c20a0028d473de4812e7549705d137497bb7c3382702c1038f9c2d7038363d106242760f0d01f6a42f09d0b0e60021de4820c4a328c2308c110c9f8443de8599e039c47003038c106d4b2817994073ec7d8843afc500b4200516946fca1cb2a0444220431a907c090cfb281a1242a48680ae290811a445524fe5002f8499a88aef8023dc0e28a434391212e52d63c6d2d4f2cb25a193bd24943eca823732a9bd8dc412530382e724c2a86e49020472251e200e5d055dcf408484a208112b0e01b22f9d609ddf5cd008f4883148a0003485c4215ff0228c6c5de844a3961329365831c694550a22f522d246ded919e4257285530f62a4db8ca5576374cab40e00cbdcbed1910f94b510553b7b30ba63121d0836242e0b1bb0595f298e94c66ce6a561178a617461184776c737a0e1885aa7e108114082202307000950ee0861ff8203ce263a76420a3ac688d4f0595c90262002ad080eae61a6d08a83c16308205fca617fa6a80ba624360e3fc6b81f69268038b83d185020736fec2c21be451d078c4a30d1dbde0110680824fa0e4132888c70022368c7a0cc34d6fca02974ee007415c610f0c18031e3c069f6030e03e434b2acf8608c42102d9c7fbe150112114b40249913f17eacfd01c34b42d7e15695076ff9015bf0a8b9cbd408d4d432d183d0292a86d0d4f5093abd7702024b1d1b14974aad35ec9a0a2c7592908e590402b88e0003294438ff55c44105ac1d8be7de10ca6d05d310d20072ffc200d79c8820ae1b6623831ceaf7682f36849fbb8c895e8b426f2e2055049034e9880508481c1229a90dbbe712ab9a97eacaa7b4bcce39ee1b8c20426ad8fcb6ae4f6ce03c5dcd46359dd37695c415611389e0f22b08408143b553e80830f527080ecee2a57d83d44aabaa0857076415860380034d5e08b10ac6311aa88efb3a03501cc406b7cf33dc10a9c87e136c05bbf02fdef7fcf65e05410275d16e517bf1bb86fe33cb812c8a12005b0c08304c823e1f2980786ffe3e1510e869403ce38423c56308269180205f7a81f0dcf93853cc0e0062958c218d4528002684115f0e186189c40640e01d1a84e551a878418a1a212e2aa52e50f213ad104582c953f47fecf0e5f008ba31fa83fd8002b218ede093d74c2e94d274413a271f4fc1c5d0f1ee108d7bbec75af9fa8cb7ebdc58f84c408b3b1a3449223c39438d2a37794ed1de53880294c21013d6621cf8b2847282e4687292441010638c3170c90842980890074108025d250845080a66ee7a9e4e22e39a735e71549a58d239d34bd69aea7f273aea5c9b16040876cb06153c94564af3da0bbded9ba98844e352283d903e2f67a53b22eee197adf7be43e2202cb9bee747db0ff846a1a3f0d3e58be177415045de1e51d323dc40952908268623f055488a6001c00051fa821100ba08633d02000154426fd28808163d8dfcec25446007e70778643d006ddd8c65c16b7380383b387ff37c00ef45fbf1998bf61d483051cc0f84b462947c1bd4102209cc22d00c379541f70000790400c58006ac01b0f9881107c423c1c01c6781c8b15c10d388f1ff4c2183040013cc006e0410bca0a36d55c90cd0c86105986b84c11a50c15f587cff95c13dcc77f10821e4042135c02244082075c825570ca2534c1135a4513d2561556a1ef5c4598a1c8d771619e6cd998a14889400e69880d5ef5151998083b945d8a58449d50422bd4dd1798429eb502ff0b2d82360c860014c124e04319948002cc8012c041e011000c2c9a00b8411aacd02264c9c580069c80d69cd4491c59da263d4ee7a1a1896c1a8aa0918b98c0e88d5af31182aeed1aac6d4a6fb11e721d570ff89e31f50022f5002b6a40eea99aea9da2eea0e223e440aa4440f1f562b12dc1f22dc1302e811c609703d4c20994c721d880f5352334f562f605c20f04c2092c4238a9810ff8c20284408a25cb06bdd3b9494bba510625a8c2fcad403dd806fed1db01c14bfff44225c4632f14c0be3414ba000c833d5002f68bbf3460c13520162887c11d1c04ae8004c2c3007cc2274c832bac833e2d6408f20043b6c1089a074c6581afdcc002f8c10fb460ff3dba600154003154c00b66c18f399512c1dc54298d80fc5093010158215911c24227f4dc6c3521145805e9445224f552a854a14f76ca500e252c790aebc0528aa016121882d735e5537aa15c819dd73c0e9308095ea51d1a6e0469e0808ef0081a5082899882222882014cc10dd0c10d9c001d64010ce0011d78c1215c9f02544109d8a52dd88202140229c0097aa481a221c101e8519ca4d222c8899c20d624e615dc4d1a1a66a256765da7c980097c0e4d888e0afc0a1e2c0236f0d6aed1a27119d3aefd9e30c5622c76262e9ee20bcc6272fd1e72f50d2e680130221b31062331fac0091c00f46d57b1a5410af4a60d9c40332e811b68c1b0fd0038f900ff1e08023845802f6c23350c433bac435b16410cc0c03b55e704a4cff894e321cc1f02a923bdf5466ff0000ff01fc035402a1847232090bd0ce045351872e482bf34c24062816fbc4123dc2716509811bc414126c0fe2d803c78d02724438998031aac032839430298014b0d00c638621614c1098e5c1730c00314000364e82a54c0c9adc22a6cc0524915d0241d84e0c70bd8e47fcc161236c11152a1ae59a1a7040e50860a5096ce2e3dd28d02252e750a8fee12a7316597356517ca159731e5e5d109d901899a659a52b21d18a4122a6d4416d8800f48c2865e810f74412166811510805c7a8113604217d8405d6a4219e0830e284019cc843698001e4400ff5b8e471020c1612ece45b08324d6c991f8a99f3ae66975118fa848287c1aa1108a3e8d1a0ca48014004114f6162b8ee6a919132eb662a51282ef696a2768806abec0a0cde20bb4e619a0020244c05fa640f505820ffc256fa6801ce8e6ae40416fa6800d342370561f341667aae20178dda61a08822fc882333cc3388c032de44163a00ffac5176552c209f0801f1cdc08c04b389ccbb9bc0bbd35422f2c503c16c76fb0e76df406b80e9c3e06c77c2a877e36427ebe41bbe6e7baf2a77f1e1c80fac10aac003c302477a0812b9803778c0317c8c33df4417378dc015c4c75a2601a78a4869e4a0110c32a68e803ac420e0940cf255d7e3c5d102e61505a21ff524ea12de968dff4921576ca56f0a8e0f0ceef988e2f65c5e77561913a6547b802cc6e615929e9189e5ddacdc946ac0f937c0ee8a0080ddcc0f2792402200003a0170184c221a8c75fe28113088299e6832668425db26919a84025e58100d880149c476e1aec9d8aed9c84651c35a66366c493a2c19ee2892a192aa25a6661f84aaf7203101c83a9f5dea01593697ac071cda2ee6840a4c2e263a1e6ef01eea079eaa66840cffd9ef0355b0c14eb38f0821780530a78412d405fac3a8015a841ade2010cd96a70a6c0b0215baaaa8217088220dca6f84167b10a013a64647562a7636ca7fa70828bad4079eaae82bd4bb88a2b783210bec5866fecc6b8fa46ff2ebce771d4e77dba6b02fc67bbf2c07ebe81bc4220049ae70acc431f4c830cacc33a5c007718c2bf0ee8c046a823ba892a1482adfa41045cc103306c8742ac0b86e8126c6c14f2da6ccd282dcd528e02e5ef5cc5ece4daeff440ae91ac8e8eac8f06b02e8dca23f8e824869d917a44919e559e3c25d7696246fc48317cde45a41212e00019182a2ae98809c081122441125ca9d1e202abb602d3c2401a44800d8453d4de8002e8c03994810268822d944135545228f84a0ac040398886d0441a2564e5247252da9e565f31cd16ea88a17ee2a0d4046154270cf9012694c2311c83434c81efc15aefa928a7322ee35aea19fc2de19a826a666add3d966a726affaf996a1af8410acc43c41ceb5269ee36e1452df4261ee0ea09087233aa412f5a9317700b78f9021e30b22fa4803f11eb3808c0616467854acb3cd14416e081bdeeae6f18c102c18b6dc09bbc5c4329f7c67ab227bc299082cde77c0a9cc0a52b85b5abf336ef7f462f0f3ce0bc2680ee4a2b3c70012d88042fd0c2058c830c90807f1d813c1c81613e621e9ca00dd4b10f2080fb6e288712c32c7ca80b62f3141430ede4a8feb28efef2af13faafef14d36ed116162213906221009b73ed11252261b0e36c22188dd1d749f005d02c595d9e08508290b0ed135f09a87de205e44312d0c11574400728c110440002e0421ad8401edc800dc4c095a6c1b16d5fff0458800200429ada300ffbf02766411ca4011d8402582e022da0d3462056d9ae19589648588625893c71a1feac2959a6f8c0802cd8001e04c23758012700c1163cc00c186e0f6840a776aaa7a231538beaef05ae01e416087cea1964ea19a866a7f6dc63894117d4aaf5a5400c90c333a083091c231f6f933fd44220d42a70da8017c075af1e9b0fc4b52aa0430ac84232a043b79c40ea2ec0303c83107082002046754286b4ac44d6668109b05bbb9dcb27175001656b3d6498195c431f7cc235607629b3a74381e7fdb5e708bc6b2320af3fdae7ba3e60f542e02ce732415a6f79fa410218c1072e24170c030914b30c38c30a38e8084c001a888761b642ff75da003176013517805848ec2c686801ac027d904e51f22f908aca2efd0e00bfd2239c330013132972ca6fcdceeee468568882ea053031b1de001fd36e611e5e392997ad08cd162947e473d7d9b45fa1016968e5da320d2011340600823874800290421a2c34432781f29db4ad56b40d4c81c2fe80f644c00d00820e94c00e97000fab80367cdac7e10101e40168a183d66cc49eae5de7a5e1060f6a277a4ea8990017e8d3f85c310cad000cb4a526b7e0e04100304140a76a55a70e9a5643f590df9e8fd75d546f8a2934352e12005807a7ada6aa0c8c03fdd0425ae3c5f76c9315341b0c11c0e70627205b5f20f4e621cc0f35f800178cc33520432008c2fff80514353c038586a361c45761d0840058c002f8766437c227fb06bce846451e81ad7c421f1c411f3cc3c45d8333fcae05b541028d67bbe2a76f5080bbd6726b3b2f2de7b22e97a71140606d27036e3bc387fdb2104cc0c1b541024c00190c77f8c440fa0e631a7441067c2887eec103cc47493e400544f71590ce4f56b7755f7730f58e76f35a02734aeb9573b20fa5391ffb30d9daeaf5788f13d78d5c9e9d8c161a4e30057bfbb777c4599148463009206544406784a849c21f2478261442210c81123cc1132840b149c15bcf80020c6d2fba811b20800fd8b00ed8c20e0b7c197c004da092004881174881365cc03078af6176d1a621561a76119ea4c8ffe7881edc5a07b2940f6208320ca0c14ce5c10960e81458bb8f0b9a901b927181c01abb71cafb78e08a6a31c17cdd998207c4f00d48c10d007270aa002df0c23020032f60f9f7207d10ac6aaa06b2170072af3663701e82090c033508021e50c30204ab72a6aeb0ca024bc340859adbf848072fd0c4090454eef6ee9f5736bc1dc1273c43443ec334240339904332cc7d29ef463ce897a4fb3da6af2b2d93f6a6aff603fee72ec7f62e4f6b02e8821008010a6ce0307c821090803c18813c90360a3809682c425aa260046c80c26628c32280fc42acfb5ef32acc00018fca2e15bba7bc922814d7a7c87eee1153eef11a64b1a6b337fb301d5372ad62edf5cdff711de9ce669ab69f96479c42a7e9f3d7711dd3a81d922c09dcd5b4d8ae2d4dc4c015b07b8277c03228c0f783421280930da48122f8012ea0b00d54db0f18ad0ff8a10e60b82d08bc021cfc4c24fc09c0801598802b102a407042b208494183070f5e40a29053c350a14cd03031d104060c7930a828322146c78e2a4ca44891070f024933663ceaf1e8910108a64c15b235c4e523086760768200c1e6991e3b3bbd30a5d325849f103c20485304c6091b369c9e38c18bd7b01b31163970e04f2b577ffe6af95892c6061e0278bc483d91e2299e13b260f0a2454d103259d47cf98ae2c6d730bf0b905152356142118d2a1063cc43c2440c0bf246f048c08347ff23ca2346b46973e4931072e4c63d9b26641c2d19b49e39ebd3e7da8805f1068468b300736dcc6f46e07ef326418211bd7bf34ec0fb0d0fde92254fa6bca2771f215c3e0ddbec8c4b1bc9f72893189865511615376ef88900274d04060f1e14d883e0fcaa55150ac427c6efc194471e1e89c2affffe7dfefb77426a27965882a093030dece48c03153c90100d3af1604106758a30409d0c3c0aa8097f3ac3c305cfb84044110d31080d24d048918c14171251860b5e1c51c60b4e4c510434c800838c1cc1c0a1981d775c84935038110189899690a483259f7862491632194281298b38c1071b96e80217050af1810104108805cc08aa2841131dd0d4a10405ff3e2061b15338c942806804c8e321872e1048cf82f46c284f2438c933504e689088a2c532e260238f62b8ca23a960708301386c80a383276c5926ca2474704413471ce1a9a59b02ecc1439d1ec1e98533021c1502022238a1882a9f52eb041590816118598679a7ab5f1dc0238d34d410492d294ec003aa644f50051d5ec641e6195adac163013c04c1030655ecb28b93455481a1301410430c035ef268cc8205e481ecb7ca30aba78d788e182d195a6881ee1367fcba4635d5acc38cde10eaa9670483efb12db7da865b38b8dd881b0eb8e4924b60804fb878068578da18a08f10aeaba791374c58e480eeb228c286f022d0220d41ce2b800106ae4020830affb6816fe6022a98e50a51f2f30029a18946aa3f5144491043537bf0c0d406191c8a410f57a59042a123d4096b0daafeb0c133b8a630d0850e4ad1ecb30b326446190bb2910c11e0ce51041dc198bb1811c8e0b3a1228f54a1492799ec808526334922892192b8c18734b2ec6286426ca8194c3019f0a10a4d302fa1045b74605331132e4047ce4360b0539b21f74e7def50f224f202d71f32d44d122c42ec038e3aba2a84ab6e90e5aa3cbe7960861b0a59f2151d98101c54cc1dd181c0005d7289d50061fa70a7a32c49e306a6a04aeb0464615041165962908593aebefaea003c445a7c59ef6d4841aa1890518596753e1b871764f0c2c30d4164e1861ff8ff42101bc8022504500414a8825ce6fa5c0c42608178c8a360b69117c1eaf58c7d0de31a100cc13564538f6bb461048de8c5061ab18010c8261e05bb473dee9130dbf4e637be8198c48093c389518607f2e8c3118661060a50000b09a8873cf0618636eca61edfcac213f300031bf8210911d8400a228080f4cc6c0c5d600031dca39e993dc03d29015ad10c2434a4e86727584390063cc413a0208842207a81821e74470a25a807153a83045e20010928488f675815212674203050c24438ba0518eaa6a21321a1441750db8c5024c915ade86c40bac58f0015281885420417c8830502f7b725090e53655000206c61031ff8e00a57c0850160808b99512e03ff0cd08223ce710e4d9ca30443b0059b6a970701002a147988e209f230a43be5
UPDATETEXT [dbo].[Picture].[PictureContent] @pv NULL NULL 0xa975848a1d0d8884cd429960316eaa1d0a160541c734ca0216705411f23029a81441124a60020b40c502792ecf111d2850800634200318a013a6d8c987ce700908c4c206b392c2b28e7582f2c5e0043750c53bb8f22b393825056a0844f7d4a22c3cdc40a12a58872b68318ed02063010b0884207c1005f6a96180ec4020620a532ec4a0cb0445886008e0d1860a164c33b309411f9e318c10c4a3a4aea9c7025660041e54a21763d84125369080cdc8e685304c980c6dc39bdc0047383a040e73263319791c618295d8c31e7650c4182eb1881c584477baa3b2a794470b3650ff0302e243b32e8c418bee794007f6c080023c6016053000d090761f09a9113f3681804b1064949face49f89b45a83b8f60242acea8e86b49aa90209480f0d456a10d200214c71471cac16923d72076be3c6a216cd566d9434db26d1c6a2db82010d7eca93096440064e90c00805e880129cf4b727205709b638a60286e0071f44a09657f04111967085996d37035728810e3e558632e8c01680f09c0a6220081510492009a4031dd2f59050c860bea1a0012726021188188a22decc880a268002dcf1ce022728700862a08223d463035059800a6cf10a2588431ca012070b3027cc197ce1b110f8421c075420810af47a3e21c0ca66e51484222b2de56bca0dffc8b095f4bd232dec4b411ae47702efa5c02d6fd9d63a548187903e831ad4e8051ef0200b5f502310bee0f1f9b29007999a4b058b31017a433000cdc4d0859a21ea02da40b005f88207e180'
+N'd7087cb103148ea10163802a0fea7184012851a76d78e108ae8a19dffc063712abe1c4803302b032073914684003ceda80dd0c87026f30c3b74e968556a82c057e488316ea9a862e64a000dabd4217f03a87f7c4273e15708f160c909ffbb4d126f7c41004487c130ff5e0280c22442710d909817602169a7d4166cf000b5320926b1012da174c516c431ed2d6870c3619de81831eb1160cb7801b1a6e94a24a2ac492226a1bb6778437b319442106c1013b1642ff2813704120575652074e228927b45309a050c2105e21a542bc12103ee842cd70218514b0e70119e8652f15700e34694273e44d029b54a00a55388306acb82f9142a18a43d0819b26b0af353d3e1189140a228ca19d4538800270120682b2286781cb7915153cc30c055e810554f0f012b04070f3d44424223104458080b20015d53df159140888627b29668b546ee0851b20ab7cb2780a25b6b215301ce07b36c6b15abca0acabd44fe2b44086909fd10e6408421031c003ffce9e2c5fe4010c8b90f2945570ae8ba077007dcfa94ee5a519daf8c13582a64c231a118e4694b0112864aa9b37e09acd1ca1a73a8d610cf1cc30cdd3f0cfbe910773c02a8f04ff6ca0014f3d3460cfba030ae4a211f5a0c15b5196052958bad211b8d2c06536b35ab2c7d4ab40cf1fd003c60a4c619f45f140aa85e6920ff760c46a041b1c5975897ebee0d7ab3abe01a43ffdeac3a241b27ef54d3a11b6d472ff0ba8ad3e8460f1b6bab5b6dae23edbb631592270a3e1163870878ed0c06db2d1484779a201633cee482620b99e001486001740210187600195e01596a104c46b08e0600c6ce90a4482bb0c2e031e0017aaa11bce04bc8e87bcd884155ea416e0abca0460114c401ba2480a382e226050e4f2abbf10e5bf048ce5726777ca69017ec73b6c200690ea06544001caa01b8409733ea500dc63156406175202047002048e8e2552ff8d401c0b02a6807866257ea4420aa4c00ba4e0109c421642602d16010cbc022c746c2dd8270dd6502adc0206c2872ac621c8aa421652a0174e801a4e0019ea47100e21c90ea1eef28017f0aeca1803bd26a0efdae0ef34031e426001080fa9c6ac325008f130b1f17aa11238b11156405e8ee008cc80ceececf2300fab18c637f0a186446f057e43f4126005e4810776a0167361070e2d170f8d02468003282108deea890440e0d862095ac60602418b68a696feed3c88a1022a003d1e201a2b801fae20d578e2f87ee20a0344a08eef2660e2d758c500902dd73044a01ee1124c41d840a413acd00af1491def28b5ce0012a66fd8a4a613506445e0e6daceff060de06f6de4cf6de6060718a11874e4207604929040060c850b40e7ff4ee0529a441240010ee0e02217101024ec09324101aa001fe0001798310202e14bce43030d8e014a6017bc41981ce115f24d0710e7036840210ee064a02003b48175b2401554800e5400065e90bff8cbe46a8703528e30586e0020c89c16a09c60400004c09c8a605d6cc00238c0bcbaa11b3a65793a6015b6c11ef6611f66c1f76ee90b56e21d5bed79f2230b2740236a450a384a0ae4f0068c652db2e02bb26ea2bcc07be04216c2ee0460401624ee59c8017fd6612d7ca0c9fa821a0a931a682110d48074542147a20cef9c893178210616b1ef42601449b1a456a0a468c3171affc108106f03a0aaf132d1cc0e66004251144573cb4c31f314a63656b15d048d375700f42880cd0e2d1286b3f4542f013000da801165f2c0ea44220dc4c2ae048b6610e00a7e80e0de8318804f1ac9a80292800a55621c1debc376a2283e04264c81555aa2f9be40fa420cd62ea1b1a6f01d7d026ba40616600112a4ef0c508b412e2146ca0d095c81dc5a646d00d410061247e00692ec8fb570c01f7060477a8b0668c10418e326af0c102872b9960b1794e0439360264061703eb20a1440126a09172260e0b6abe0388d0194a00c5cb20432014df06d016da1102c8204eeeb00aca02278d40432937466a5ca2072224880766827efc885299b3206262182ccff49166a61116ae10737621ee6610542a008f04d138cf09d3cc51170861fec811fcc7216ceb2009e0068b6b1d55a85400ce02a66852da62eeaecf20be3472452202bb20e2cbc20e292c53087615b742c0686812ae8901c68010f4e4a7ed0c1199ec10f87611ca8410dd40019b2801320c90182404ecae522284211fbce0c4a1534bfcc3419cf355993353111368d6a3338201447b1a7eea114ad0acff20c1fee011f78151f8ea85d3e4f163f8f0736a01677201272010b76a3047820044c40041ce01d8200185b611104e006e2675816c74a74af0bc0b58b66e619b9733babf11ae5a807e0c8685e223d85a627fa883c3ba18f1eebf8d488c35ac5031aab4068ffcd28de1329b0ef1204f640f4556039cc03e2f31268400638014047a4404509465cc4612f60400714dbacadb57c44da44801d18629bb8800b5847ca94a4493eb4de12100e1670658780e732a10caa00109ec09656943dc688d332a04996e11c7661173441bc6432df8ca9103840058a9612d861493900b842a1caa2083c0c0323921423380003548e03028c30fa8e2326619c62a01652100696a0084861022c404be7610026600896e115c0b4041c019e34212c97d03dec611566c11efea1029e6006fcd5b1406c278a00030ce3a01a0aeaa64e0ed7822d086011be020dfd81ebb6255c0c9317d0615b04f32dec671c92811cd0010f9c2002f0c019c6a11dccff4e159ec1527d210264410078e191a2cd1dfce1539d89a6ae2c6be52c1465f30886eacb3806cd4ae860aea135460056316301e4453657835645f3566df514afca14ef011e5ee81e26a85dea611e386615038d573bc604620c0ca615189f280be82059907158e4c73c18e007c6e007ba007e056b1ab5933b1fe019ffc03e5ac27a44e5c3a6478e6c42d7646d7ab0afc306b83c09a040eee369c0268e9a8fc410363ef7098d60ad50165662678461656083e76b833d98622dd646d66f6ee2a64069a15020f202fe0f06a60b17e4ed439761069260061210148456c23ae015aaa00c5e610f0a400bb0c8666246b07a69b9caa01a7a761286001086201364d216aaff00c0540009b2c02250e00350800378d4be66250ff0b2a066252e55008b27e07616912310cc29af221a08a14e14a11006770222681ece36060a41c25800bcce049e748005ba33f82a40d4b6216ff56116fee0095882d640ec276ca04d684005a082a3bad00be4f0c444e206c4370d83000a08330fee871686411514155f48b9347801c96c40102a951c4803194e8016d0210502c107f04074ccc11c7881128ac11d6437082cf4506240e5725736897985e2211e42e0089c6136dba10ffee508aec1600e26f0dae01a42715645913695e81e94c80ca4f79bd72aa726689ce1e1623e6135d0b90f7854041e547cdf81122801655a41159085006e0cc752e00766ffe607e0d77d6d761ab973b0800f1ae1605458055f5b02fb7c82547882c3d4b1d874426047ac9f34a0a2f1033fd255d6203a4204f6f8884282f57527bc515f2d98be3678445e64be2c78a50bc5214f7a46061248dc6f621d9206b8a050160306bce010a02005b480b9161023e1e043f32d095ee109f2788795800170219f190067732fafe66d088e980baaa10c4a2068f3ad103e608ab320c06e90305000034c80178aa0a690a508c0637ba036773ac29c62601e56c60b8e01085ae130b8000338a29cd076028c5a09f2184d40c55398e00fc8353e826f09d5f40e0c79194c65a16fe2116c008e3f408ad6baa1f2b4296e2c0504a018642cebac80308152051cff350d62c07555c17579215c3e577e8445a4c6e13364010f78812e52c017900c06d8811d38d51d8a217d3e7522b2e0ca540e0566f3b8118c0c8f40839ea1b945233534c8199c6178eb211e46a8ef8e80037ee88744b379bb79cbba79ad6e5517720a1ecc3b1ee6011239002293744741870c3636a27e310b0ee0896000596cec39f5d93af9197eb54b03a311b1b9d3d4eac3c33ce40b38cca103f6c3bee01c3dc014240042046a280436d98442418e825f67cd43e0a8130c8000403c050840603f9c00b0d10304586844a1a53d18834d7a9b6c7add62bca56f92622da92006544069da82215222484005e4e4056a61109c204990ba9d24ec648bba6559008a4bff40127ec0aef08ad364a60034f001188049e0a00a76a10c9820135820dff24d0138e09105cc8c9d7402b4f89155819b8a5465144a5b1bea29f0d20752e0b4ab38effe4faf9ff26cf3c10294f8a833a179be129e1c61b0a2b1979e9a8cc4f26eeb760640008e8ec20026bb30626065227959bc707161a07c21ea2b8a81eb902559f8140ff09b304fe010544116ec3c59f00005526001f8857d78c50d64d951534015d8e11d8a61977ffb2bde210b2082b8b3785627a00f8e5dc08e600238c3b99dfd139e7b1aa641baa139cc8e5b297f489bbbbb9bbb9b9b75c10cbe7d14cdfbbccd7b00488017bc29ef18e30244a0187c0421e1d964b843009a422af8148baeffd33abb889f6b66b0d003b1cdb5029e110ef6a9c3a2e71216649f2ea1c161ad3d3da0c175cd25a4403fe5f10c38cc26f6091e1ffb402ee1b0a6401408600a4c9c0044e1e30176c48ce6115c7a6129b6a66f9a044296174236644b9ae55f3a83616483793c495f5ecaa4400e0ea016206110a2400d7e9ae7e40986976108748089911a6601010eac843d486d3aad7c8bd854122681875f2113988026175001a6e1190600053c134acfd8493980140aa5caae6c7bf2a008146156c003068a4015b2e0199254852d6211a1f46c01df02f2c1dea0e415e2499ee0896788618bb68b1844cd3d4cad672a4001d6754026bbabb555ada58200a04eb3c9624f6f801220ffd701a241c7bef004a0800bc38ed657bba2e4e7064277961687c7725d10f8d41a2a130cdc8111184176fde1d7e35948a4acd8b3fb87524ec05000da9ffb198480f99dbdf9c79eda292f149df99c8fa00fcc4014db60dbb99ffbe70c12e1211eca0905dc64ca30800b90e01678d947fc815ae1ca7c296a4f852502fe0d5cc1550b7ea066ce233d041c202a3c185861d58302701e4d11650082010397205c6af825a2812f1e0c10786880e14202041c72ec280a8249088f1e41387372a3a8472045812490f1a1c989124d1a90414386cf0b170c2131045486091224b870e1a59429531a3d7dcab82095aad49e509522457a9404863c87bc1c102007961e2f81d2ff2e79a5844507162c9e647a35c4d62b163aaa9419722205020407193c61d081f0c0020c10e3b20108ae0e1d74d92a98362ec8a220b5e204513160c084099e3f73c09094840a124631d03011a3880901a1d6f144cae1f38018932c5898b7dbc2a4244ada66cae44887a3e32c1c757820103183e7cf1fac5a3567faaa3fe20c80389312c28d2a455414b271e3848d13e5a5488171224d8af736dedf70e0cf5f3101044e7839c11f0f1e2f52f0a78a2afda991c27f7844a0861a3ea8e19f1a27f812887f81c8114431c5381044166014531f180e38b0082759a08002061ca478448a29a230cc33cf08216332c99063ce8db7e468ce3a323ee3cc1140aed8c7277dfff431401f6698d146924c36e9a4199d4139003c215019820a18a8a0250a5aaa86060ec5e0e04e316050b2e165591c92860f6918f85e043f74d1c5155dfc3086165a748140017cf299d86103ad32cb3eb35cf1c84b29bdc490480d1dfa90280c397aa82869406a2943369dc1924e2211a0124953cc90c6141739f4c5191e88b2d014dd49150a50ae00c50954ab21a515535b2565820ca1fce4eb55b4d0a09456b97e8501062f8c55cbb2d1e011450abea8b184022564f2045c2c0cf70a20cbb0604b350a2870c20f0824c667074f0c560022030596840e993091ed6343d49b843734707201278b2c9245113178765b679d8136018ba42595af0059f0742c0a13ff041c826e16c0330f3cbd4d3244bad826a78923c9393206318715904101043d404c41d23dd081381d2880524a364cf00129459077c30de7e9b79e1729b807df7b5978e84f1050e877020c30c8c2b47eaa1c62031efca5c5df090c3218480a3604e28b0f299c80470a8b14e3ce86aa1c00467df6f953e6885a7ec2220747c82d3709d3c8380e39b7e0e0370e8c042e7831b7f0f889333fae28f7117d1c6186e34f32892493032459f900ba8430f1005a6a39810a5caa268298ee8c79741007a089878154cbd2179c63d419e70f5afc70c51580f559c01e28a35c103fb33c30444a8fcca0ea4b8f3ed25147ca77048107932e04e9420f1daa3c0415453491072eff3504bd28c6cf40ea250488726aaad29bf44855405d80042747f1428209a471b1d527b62afc535156f9442b17c21216b148f315011ce0802fa88515ac00853858c26b54f04121ca5002b674e02d73818c12aa508549dc004e0c08cc600ad30194b58b019938c73934619cc764c21680a857196230010c2c250b0208416702563082f990609fe1840078f1b0ce4c6200b9d1cd3ce2318f26ce63122b080e5cdef2968f1da7043e984ebb54f6800c0c6465c4f8c32a0a70c197d9a23b0a28c407541003f2e8cc0652b8c17a60f09e3abe270d79f05086f673b51bc84216aa80c121c42636aa05220d3d0b44831a141f45b249168780c13ad696054ebc0343a6abff4f8690800401a0880372eb438ae406ca1809c11c7df31b23fee6b762088e11c560c7330ec7016770a0488e835ce4cc3039cb25e90804d39ce63e67a20914e133a791c12dc2e40e1cb80d0c1ba284bf5411831858803f29f0019c64a7053ff8a0761128570803d327e614643ab39044a2c03703e22d4f79908adef1a6203d56a9ca009f5209f6ced0894b64c452f67c94f48c47922f7cc121c8338928f64714245c800624c8c3697245d1ad005006b47855fba4c21319007058c4f28a570c7880561ca016b0b08217f0f0c0406cc00798f041153e800fc8b8255bafb0452686508d0fc4400de43a19190953ce2e1e44129ae8c6398c9309c8bcd016b648c20cff27702221f2309846cc6a088e189a2ca802051c40416726368989f1c6894db4400800f10425c86538c7398e262631091f10631515205960c6691095ade22d53ecc0237aa0900f14016736d0d9d24ea01ea6d9d18e52585b7df8b81f18a8021db418c720bdb0d2fca4c041782040d00e39a11404420d8248030c78c18b75e06014bc60477d18613a32b98d12efc3d2271176b719a1f216ab04132b57e98e578a8016b42465e31eb7cb2421e9b947badc0074781baaaae07311a32a09be84213d82c85f1bca427c7c1088f82c014e3ff8012ed2eb8c6750e36be5e253c998b3c5bbeea302494814f1acc72a7c722425c6a3a7f81a8292e94dc1243d3089416bc2ff90e371c452f884d4482ed10947e94414ede31f55b6d295d290007ff84b0a008fb2ab8d72d4275cf0a800edb7151598f48002a8851e20810727e4c00929c0c40604f18314b0a21af92801bc2ec8829c2ea30ca4f84036bb009d7399cb84cfb98223ac18b2c73c460149c07219a88a812c480189602e2b0fcb8a441d066c0226a006c4344731dd60cc624c4ceb244021896b35f56325a8a002be6657bc92ec645e04a37c0b80adb6b4b50c3d30402148610215f02c1f3c2bc21c99169fc772ad6cfe70c07e360d031598601dc838c121c252c8d5f567b4ee69e49a52a002d6d2e21d0258073b3039a64c16e31dd26c34064809ca4fc88d0b33ca112b87adcac0ff85090785a3e52d81c45c5d36d7485032d2585740010abc213434fc1c0d4480213139f3bb07a044166ad1a625842d0d118053edd2ab052e34e319c318061e0451ae92ede10a7bd8432af6c08055f0631f92e8eff5f69b127c9e447d900ab00112bc5f0257a453d573d448fc7b285219007aca835e4334b2d08d72c2279cb0288ba781948489b82924c81755567e1521f024c5c3d215066ed00a202430c67a8846142c61092704420c3f10841b62610034b0a20a41d60113def20a1df054c96b8ac09cd24554f93e8001754a8226345106c81ca7a94d0f570cd38866391462ab9a8b411616c18b1064aeac74ed0c0a8e3082096c156315b3403cf4bec4792c20ffad8090845be1122fbc94c1065a6000027e90810acc41205be4e2732a702d162801eccb18023d3ff0813c7ce006e3e1d9ce60b01e3988966ba7ff2c0cd6f68ea4f9d1b2aae0051d4f1035ce4eed04e5ed4bd7fcb0b5b145cb073e88c180d0c1095ad0621163a2b57d4c47064a700245bb06e528f1278471242395c115762a870d061dad830443a2db739ffb4be73af748669880918e001a7834600f7fe05303e0711b1a72e0027e6ba63fbeada12c6c480eee215a69b004daa40511a005dae40742900c42d00ed7b0000be00bbd300663900a05608104815705f10f0fa0002af1818305820e01013d50820c9712ac22330976120a51701ae14f2bc1601cf13cffefe45f0fe12917f72890c23f3ed12b0f15402b665178a31547c10526b0723c78621ea562469864279040cb825256d02c4ef040d62008dff0036ef00dc6d00ab780062450054276534a7064ac9058d92475575075e5a4781160031f30011c740e63382f3a600b58562f9350040270763a740359005b47e00753020fbaa056a17104f53000be91771813674d240ff32089f9000782677972212fafa0003f900a0311010c00465767320f3007579718826179c4d15477680b536058ace068a1b733715404450003633335759406879407674335a2561ee8a00a07620387400761e1045473207d615abc1836a6c52069100326c00bc6b70ee8c00eb06436a6533aff1e826b8b9007c7c222bef609bb2623aeb07dc89623da876cdd972322c00eae600ebc5037cb562492c34b4d025d45a27e13004cb9906fefc73bb9701b2110032ac05d1d820360d09021b276020034fe1134c0a74d3f1001dfb400c9300e30720defe50b46f0030cb0071b3006057057787592b3800050500b15b65f84159327d1108ac082dda1128a608210b0100a21135290113d80118fb2119ea22a1b010197b2118fd211e533051966151af5945971724a2140f343034868624ac813b4420a85100db54008cb62050a34080df4405440056210016ee00608100ba120022270011fd0754b972db6c00a6d14344ba005b8d005ea627557a705363009851003ff55500ddd500620331c2cc004390508b6502f85705d9300478be00c0300246d9077bae04331200637f0666e763171260f0bb002bc3104e8d2168e01174920925c249290e71c81f200b7431895371c8f610b90610b6bc40a7970031e741eb4c83445a07b78a08b4163206b971f02c20baa3036620303c6c75a611136cd485ad0785a0d427bacb50ee3400b64503aeeb07c81937c604006649005bb167dd38701d5874a0c790b607023229023ef700bf9690e22b023e3300eebe00af5084a8ca38f93838ff9582447d28f03500917b43b95f00614c00313534d09b9900db9a121e22f11894d69b026da549109980ccf7004c3700df5c003e10081bd5092fb0628ffabc0004e200012d00a2618932538582588121d412a2498a3269193207082893205526000162750f4444faa32054ad9603231a5127628eee350fb6215408104ae800668102b5c091557519532a02f4f391568ca5150c109a1500d37409684700c62590bce820771100781909698d00570c2853ef02a48800634a00b9a9009845705e3b18b0788004fa03bed820011a000f96003f99098d5d0428f696579562f430008936a0aa1400261f509cf6006f070aabe5130b260073610027b87aaa71a89f3a09af1e0074f40453705174fb00180f1780fa0277af51c27a9320c70057c2209707179c56165cb900948960779709885709872140373440089b59ca7a706ff879402fb31202ac01e2710034d530403a20a02400bebb00e87b08cef7148903436dcea0727a00297b591bc0006e6d95da5435be7896bec403fe3084adee015c0968e38c00eef600eec206b377223ec400eebca9102ba0ebc300c40b238bda48f1c5b241e5b24b734003b906fbcc327b9700ff7a01bd584014800060cb9a120f20e60b00863b11f7810a26d829104785e116004870381beb001bec003be50b463c03b07c11cc4100106640a6790604199a3390a82aa12a424a8012030825f90600bb7a3e0230a49e0a432a1a4a122504fba2a67ab2a3d894f6820025e8aa59c60a65b6a085f8a0643e10a5ceaa545e12b4fd9b7fa12b75990053450055ea007ff72aa077aa040770a0583e07354800962e0065d100bdf8000c67003acc005a14014a42064f252021f6003a9161fe8264e2674185d00074b806e5390981f601c49d50dddc042b650020a10434aa00006031a5c80045572aaa74a303160093600
UPDATETEXT [dbo].[Picture].[PictureContent] @pv NULL NULL 0x0ff160bcf190bcc9db44aa090f51842e7191ab71d1055e541d0ff01724e3275c54015790784f5067f3c29bbe69a8995005ac600245400213b0333760ada4c71ecbc93576243461130384c41f5ef07ab1e7554c730102b09c5bd317818002ec615a41b334f61aa09c0038e6596bfbea0e0ed07c8be015be364ad38001ceb080fc1904ec4006e2290499450b3032c2cfb037ae404d4072247483a02c4c7ef81009ff7bd00091700f7dc0030df0062330028df0068d400123709016100328b008324b2621420964e00094202202104840c38b03889124ea03e6f6470b200863f0032539061b900a239918c48000dc5052a690b55b0b0220b0b58926b53a4982670c021a700606655050fbb420403ce0432a4f3a03e2e3a4507ab64d1a60f6d493532097fc2902efd383659a6142e10a78ebc8584a1571cbc84f4914fbc20948f00e81cb0a1300056049967a700071a00c7160a7a56c0962a09693bb85c6100b3180012742038630b8855abe3c63030440358a70033ed0a8e334101980757c8a00b8900f379364dea04256541cb60b4333401725001a18b008316031a74a5db7310affaa200f16d377b22a89f3c056e0cb02cb20452c200e92c000818657d81b79ed623b05700584c78aac082f70f10ad5100a2a60082aa033ebb11ec989adef917a50cc35cb89bf57234896450b9cc00eec40226323bf36200bc3c03469615ae31a7be3300c65535cfb8a21feea0e20b2368b702c761362cef009e3600e6010b8aa507c30e20cedd05e256c7dae330cb21002d7904b2b0c39e4f75cf7109025c4277bf00658f006bc540f23700f6d700f546201b210037920022efbb294805b572d4dad2007a165c023ca26dab404e646a210280821498163806f0fb0075190050750a4db11945f00024e7b506c6c820b4782a6a0017c2dc72418a468fcb4467a93ff791c614dba2a0b1160e253717c4c4f5eca9e7289061fd72b5151c91b55141fa72f9cb4d97dbb2f48e00f67b3'
+N'08ac70038390b8cb7200b0609666a90c969002cab00590db0582100be5620c1110879fa11a34300125e0084896588c55048a40474c366881b1868ac700335008d5c00aa4b00b5520572de408b6a009d432044a000a80a0bb8b7008c06b88d4350102000317e344dd0cce2bc056ade99a8e90096fc104eadc2ec410c65dd02ea478185ab086c8aa8af0b2ac3ae0166f5106349007eb80023a43ae30400730e0059566696df21e4a831e7c7408c2177b718b4a8ba01fd4f922cea00a22dc8c78207ce4b0d18b10d20fecd1c917380ed015d0873fff1cf022e9c8d5f5baaee2990cebb091ea8a0e71e207299ac28ce33809ca4b1e8b0f0d50e4b970e446bed47d700d4bd2d49d190307e91aa333d26fb308ec204dfe220783746a15795e08e807e7955e08e0063f500008c06ffc86323f20008b20003519b55b6b0a724e07743cd7695c825b8b6041b91d117170806dc731d91d898694a4f205a0624fc7d3c701762933c0496f8b06e6e0a5b1a2952ce73fae72a56debb691dc3e347b402012045ce00550a00764590b5c0d05a81e0577aaea5b4005adbe05b1600c89600c19b0041fe043a44003ded0755560bf004207454007271001c63a68c1fc047bf21cb830058ac0793713dd71952dc551dd3084dd4a0008ff1f0003a79abc88180213c009d57cbcf8709a4d9400a0704195e716e2200ec4c1047070ba04817587f1275db45e8281ac72e142c461cfeb8e17ac2003aee0683b33dcb6280737606977d4adda79350cafbf0ecd0ee6f00edc200563a302cf401ef63a01c8a08b31b00ee4400bb24009ae445bdce88dfdfa4a675372bef6612e72047b63056e100831a0aed5c80b2a300c40c503d9b4024c7e0d93730428607ef8888f6f60e46f700f66b0d4288bf4cb750d4a325d411c1e2a80043810c194a0c959d00a5980048b80045920ae41e307beb0265187804ba04818e90bd43006f1e53b7b7008fd929c0786e73d80c6a64007b060e7769fc65b4bc73a491152fbe7ff456a823cea1084aca4c6d33c4e2a2a6aab3cf0e4949ce43e17f0a5ec209791eec856410b4a68a681eab664a0e991cc09bc40160b7400efc009850005a51085a68e0790300883a0ea3d1707bf10089620088f1b0bb1f01c19900611335d93f0012490cc65f0795210ec7290073040ecc25a324df61c70600385007a13400a1c601c8ef1184dc77525900443000a3b5502e37ecd479405265031e53d0ff8300ff9b00291e0164a005880051753c60492d0325bc4003f70420301100c1868e97205170b252c32e9c8d430932316e222b260a1a34c9509316edc8051a4081d3937528cb491a2e4c834294d9e608987a52c18aa4cf052a54ac4bb5b640e1d3a81c7ff8bac14b264c0907542d6301b2a68d1e2358c4c3177ee1845a5ea0e2a23ac59fd6521f10903864f28501cb9e6ec99b3408216a4c0e3c397af700b462ca877cd6edd3e64079839b2d74c9fbf7d005368d0a0d11bc166ee2d36c3d7d991bc66260c8811a3882a144568dc02e36011a5450254e5c9b228b4171b7852a45193c687eb0811b468f191fac4b367727d35ea35068120018bb264b49042410fe420907f3105e2cb17e78a9ef778fe05b981e510209c01a11cb9f61eddcf20ff0e41b90151a21e899a216aca9447100c3c9ae21e7e7c03da21ac4772c1ff054efe73851d34ccb94504735c71e502579018f0c1011d44028d092b4402892c6ad1e39863acfff0420e150a39819a41f4d0e38503e48004123c06894319659c70220e270471c3124bc47003810c3260208dc92609c182014821a58a6ae8f002063af250e1101fba788281021eb0b2008118e8b180586648c306300be182862a7470c4111dba3987215b2e520090214051021440f28187c8504c98041e78e6c1071e7ce2c1079027c4e980228a2472644d8a343987850a88b17252067ec8e0812a1fc8004b2daee8222125327985a14c583833227124d201101d7428a10c0e3c6a128690c01c2985136e4d21103f463a213502bc508117a2583a01061170c06191436090e2102f6228ca0418b890459615703dc1095f6000e3aaa9aa824aaaacb27ac70412c0ffe20085093820cb1978af21cb2e7aebbde61e7a016b6c2fbf04136c84481ac8858211cc98e613c01216ec08b1fae22084185450a1b2184ce0ec1d324c13400a10434142002f724dc187d7d42039021fb4f8a10b23d270a69967ecf2a5924a7ce125084ef26037063cfc98823ce87a80e03908becb0e02e9ac5b8e3af29aee0e040d343863bcee9a966fbe1966788fbe47ba16c500b01fc94fbfb1010c1040193859e782755c41c315734428b04004d1789b9d052fe86fef0bc9f09b842214f9c0b2183e28a2965ab829c544146b1964103ce2c063c6385edc620b313021c0891d8d31261104f219608010261192030caac9e38443e850810e2904f941202b89ff91144b2ab544200238d298e2cb0f4ea18183324ae8a69a424a784593125e2d4381245e0165996526b9218f5006b080cf3ee51954890e0e0d1f518a32d14413881cd18489072a98d44a042cd5f4d20232b8a25349405dc8a156511547872aec6217def0c607aa408acbd04115ae93424f6c7592348c440d26c1830d4e100355f0a42727f0424d78710b1c1ce01072e8882a60b00059a80006d2c2432070152d3ce4a118e30a97b8a2522eacb863115c489758263081c75c4330f41ac11bde3002245e238976196263f6d5188525a0013bc8c511ff723067204c309fe0c0ba261002b1446c6231b0400c264003345002098bc0100cbc4087d22829576940d9c9ff7cb00492adec071ba8076eda518f46f802199fc90206549091102cc00f7e485a789433b4a221a70c5fd04e7ea02301108c073aca194f72a296c94c468d6ae3e9e47ab2e69eaeed476ce949257784b61f03702240a1b8002d432183ffb44d410a7a9b2bdab636ff70a23f7aebdb537080045254c3481f60451e5421070d39010ab07841164c30b916e1210a7160431ca26009ccf9c01a718002151000ba5874a10b3108c100266101226180153420211d44e30535748a4a0f9094957ae4232ca933024b48890d3e800113a8e00685cb471200f10ae755a1784378c5102491844598000543ead3435ff18a0e88e3092c38d44398902816384a071481480156f1ffbe077421020cb892a61870bf2b4802210d31134f21a2aa5d18c210a718e0004991072729300fa8f995ae6e95862590c4824539c10d42169398e46111218c4993b2808ca2a840154a59c0028c0203150c030933245754c665951be29011fe5844bad6654614c0ab0f4acc45250ab3873de4c25efe02cc11dad0062706a60f008b0416121098694c830b9fa02c65bd51d975ad4b621483273c512003e164210b02888909b200834394c46411808d1f02e103942de107b2314b23463048d0980003ec221d3c17e003054c279342b38e7522d903ec68076a55338f779856caa2414d0394140f79ba765df598a707f111db7ae2a3caaecd609666c325277089cb75ffc80098eb581b3001f49f0b5d080c60f0c7b7c86002c3d54200e85005357e118d6858220eaaa84516d0810728406210518042202ae78440fc22079670c209a0203b7402c318367067088634890960e0634c12801c4e90065c5ca1005572dfa4ea675304c8d40d288be00d3c72820818d4060a7885f9ca503c5bd882a2af50422138303a78c8c3a3880a5fa8cc2491935aa41add582945ae9081164f4aa694f2d14d7f300638946f54a4fa694abb61083408751abbe846153e6002a4be2e0fa93d89ae2298825eb1a5822cb1eab18aa20a5e64811dcb928300f2c00b05ca2206c4c2205092c20b1bc8e216fea0610dab12d772b9030c9cb0eb00268082695ca3ff11346bc01ea6b88702ece10d4214cc33fc65d836e8021e4eec033e2241010a1cf11e7d882c177ccd05c97ae513de200109ba68c84356c6b7f3286b0868c0892ce401b54540aa2abca01a9265fbce78fc810f7e70854af4e119e858c43b90802e434e868c16282b1e0b419de20e8d685f384371a9639e33c81b04e0c90f739b668a4f9e4103a6e04ebeaf7b707c6bc703de3df8c19130cbb4fde7bd8660d00570e99f8b97576fc244c27ceb8b037fe0c01dfe4042116c10083c50230ae38cc6e36a812255486e10507011141a2c2370aa010f5688831bdcf00d7422c007a42b9d054a37815064a1d0595045ae08423b175f6a523e42408c6383b2815a30105dffb001296200089eda421312d54145e1848f7ce4031f43283b452afad1569989093a6042093e400a2eb04217a67a858adf77a9d9d2f401b963401766436451b5ca110fc98444c61e0a119001094325ea00aa40823cd041817480c10351f2f9947c293536f082176ec09325c18013b760073bde61684313cb28c352c50d801202a5c064866ccda15b7d4faeac48c51de722810ad8d5061e1426178d18c3182ab1801d003617e2c60d61db500f7cb4e11e7c3183141b108904148cd7d39081106420032e0881065de140578c8dba310e89dd0b5841fd57100f2e8cd6c4276812096dc01ad8720d9289aa14a08d1f400023788671703d4ea0818462972f923ffaf3ff850d980245288f78ab0ee7088fe7a083e2aaaeefe80e0df08ea7d18056680e14dcb7831305507804abc12eec9a0117ec1a8c91254eb8a55b92b8ffa0388cb33859aa25bda10491f30722c48162a82f0770004ac88304108470f8056bb0866888820fd1af6820a768388128689138500318090435b08441e0393788851df986aaeb020b10920f6b270ce00401c8825680815f910d04d8a72bb914a9b3128188050498b11fd0a33438011f408034c8832a189512b0051dd0846a28832110956520b21e633c5b980489ea3126100734391f5bc88749288442500152b08124f0812b10bc4db192081004a9ab9f34d402387088317b0844714424e00cb9112a43e0ff825df8001a70a6cda333a7c2b3910884347021d5e0b325f98943e085d6133432303413ba0155000a121887615001a0308a18f0822cd83d4cbb341a023ee07300192081095881e8db8146588111d8804648801858008199be67882c67c88b36900779a887ed6b0c2c908448888437c0075de0355f930143283f1a10021eea0a0c303614d82d444a2479b03f1ef0838d5c8109c80329b82a12da16d7c0a3940944dae895fffb8161100107608706eca11fea2d0b60b615f0031f808342a88e4a2a1aeb101be47a0e10300553501a78ab1a4f1ac1a7819ae6504aa9d92e63780269888029d00ff0728f13e81a639086e47a0430f09b8793011c3c3f8bebc1f30aff051a404b5bea381c98abf9a22f8f73802018852030010bf0034c10044c808252800458900358700235880348a0392880b030c4914088024890054110846f38c33100ac15903fa32ba309d08650080d29b88113d3025cb8c34ca99f17e33281b0ba1db9a91c13040680035628032628034d508057998049d00150188224b08512008457a982d1f9211da02853d18432c00705e89534f0035b21a8d9699ff961009431067eeab2185b028a4abc9e720445393311d0c5c93b05a25226198836a49ab33a3b46f5ccb35f71098ea809b1a2857578383814812cf0109650851840065e702619a8c76130245a7807b8e2bd70792baa083ea9c0812c40017f4c800dd8ff010ae0817a4824b9a887014081153022c2520c244222c6b88780b9b537d00533f006c9423f194886f33b3f604b3f1eeaa21f62270b88878ce48104e0011e30021e35023f8801d4eb08134b019381add920992e2019a8f20159a0847760870b70409dc908ed81279bbc4923f88125b8c0a01c9a0b940fa0e9817a0b8ffdf0c9a6490ef128c1a69c9aa9e9847430862e48821b2080ebcab7f9700f29800f519831fdf84a30780734401b19a0011a68d1421d54422554b494253230c2a9e80c07404207788720984bd3c8a822f0851fa08238888697ab054b50836011552800274bf8050a1b8443d08338c08408d0916fd88331f8060658029a8427cac0804508ff055590023a5cc929e1a72bd1127e9a83a9ebb22e38c0d38c2a4c68cd6a2801e3fcb132f8a17cf0289e02cee0fc0014988751319512a8021bd08281324971fd81d9a029dbc1944a89000498ba3bbc822560885a840844290156883c11000311102a19380519c0bb1b643a055aa11b500d9378aa5de91567302b3fb34601e0055ee08440b326d7b302635105127886d18809458309b5820a901dc74bbb21e0cb022300ac48f0830458d97ffca161f0b0363802af588cedbb870fbd59c492871db835c73251024a3f2168c8f363d15fe30217e5808ca0d105c8c815c8d11de5d10d3082a8b5a025c90339f082d5f03695798d14f08508e8155f88813fed0fb4dcffadc191bf3e99878c4c003fe0d13150802f85240e242eeba8b7fd408e54329ae440d3a7013880eb240f80867dd88755b89f08482553b80469e8114998a927c0040008830c100508f09bc8f31b0a312f8b33d442454b44e504340003236c4b48a584cea8d4035804d45d8451588403c8035f70839d538503b0026520ccca891c35a0022af0051af1022b88062a58033710831ff88654f8b95488000fbb933b69a722483a18e80818508d25e8023cd494d214d62ed39daacb921ff81241780083fa314dd00105988412809e65500238d0a91208ce76c1802a48821230151d5881ad958d258880645d993b14bcfa59d73d3ccd2b4882b21bb3c59b088b90013410ff817c1501240805f1ec5743c0106bb25a3ee3c693a8b3644c0121000a3ca82018988998a00555580438cc02110099d273a345e30415328a6138015e40024b03174bab8aa9c08a3cd881ef03047908015df0300fe30015f88ac7e0806970b5c540a2f0fbd080041809e58182e986619b86433d3f43303f5f2301c9f2356f40011ab5808c1c8115c0511d35020a30824ad800383602b1ca0301108013782dd9602d35480d2a10d7258001320003b245b7c970a7ed515b7facbf8d94da2b9802b0191ae7700e30758ee9101a17dcae33254151e20ea614a51e48873bf8877fd8064d7900197c0445c88130b803f761805520066380064498651fb80932c098afc4ffdcf88a2f8913a6d0155d6571071c90cb4a95cb51388003a8d4d63d00013800d12a022d88825a008203e00619f18241c00672b2041fc881db1d0448b0820bc3049f73834408c41f488458101278ba93351c001228b18f789213500337803a7f2a65612d803becde18eb82187b0dd664000538075b508032008483ae82422883505c022548821f3a360e40e8123893572008999a8dd948c3ef6dd73c6cc53da4ba2e50008a6a9557e04e963a8753a0103280e00969c80a7eb8681bad39fb950b1a06a0b8b35bf103217006b638819a702355382d0130ad38640766f1d562c983754806985880cab009df7babde23591e568582a480049887d1e1803e601714f8ff042e30015f333f219806c0908711606bb6aed90478030a30c80440c80140d13181482e46bf2f2e5a0c40da218987a5adbf1158591dc5b50d78e3e6db013f5001d2009991e15a0e3a967af60359200307a09041250152e02d788a8779505bfb735a38fe812a593106c0055c98015b089be4a2242eed1aa3594ae9e2e4a9899aa8d9aec8e5033e2006449883c2f51a0050871e5187f621860c4004680000683006bf79eee77e4be99eaf97966e1c10dd62103930a8d46296cb5a2084d4cd86663e80973b005ef00327689c9a3b040f394c27d8820870023c808468d00365205e69f0b93fd46f06b8018e6237a38b183a76923c2882eab56762cde70cb09d56c6ff1d185b99dc99ad5818bc4250802aa8df0362850ff8806aa8020548df4fe3005250810f585ff471848cae3a5c303c162fbc009e9215f391c05b7018d3821260bb1e43a94521058a4333b93905a10a85a142b3a46b056b22a11878891818065e9005643cc605480621b806a1a62ad5a30962192d555823d49283d140061980581858d86170064e1817046dab91bd214af003c79a07226917f8431d0ce0025ac86b30469801b80780a4d911c885c2986b2c90075d18803ef8d91665c82efe3512285a5250c710106c7f5cdba6e5814660630aa8841d18834d6f3e3fc80368b3b6a0b62037a2ec18085dc96b40dd82c077ea9ed166db35866304580551fe87c19dff850a608016ec9af9d00eeeb21a47ea0e801bb8f188ae7cdb0f54a881599e656250872e10eef690060630ee0c6006e5060760c004e8f61b7d856030e00c650166d11df77107391c0882644e66d50d825a28855a6066201080ef260442a8857c7082772704f98602f686821771024b48034ba06f3dc0034158031d710360488540844c06b001f903ed7858c3093001688b331528825cd9113ddc436298830ad894041fbcefe54394410062e8821ff3f032d8052e988cf5adcdf9e5807ce0cd2a401f1d18832c41802bb88231c085d3e4f92c11087efe0141685749a13a2d3069869808fc2d0352e01b3240030bf6d70ba090d092435e98bd245ff26178065ea0ff0694088166680621188661a0c31350014e8809122a6a01803612a263fd34016a9105971886181001724cd0e0ebe1aa888104580110fb2184fa8addaa735fbbf317556b7e690c7cc082c2f83ec74a0013fd000ec06b4265485718d4a2e502bc2bb68d2aab4987c795cdd14b47ec1de8f4e61b030bb0f8d30a49d49adeaa721655b8058ca925422ee4b465dad3d7d1a78d5004f01c63c80068e811638800f5e0f5efeaae578a2e126c050918c14ec25bfd780469308658c8fe58385c5f2780fa28fe4ab17666e8053addf6e8ced7e9be6e72fff6b71c666446e6751f855a00302b986679070242d0033a00887c046a1d381607caa043dce2584295c2891302d1fface8512666cd374c6e80d5702348d08f0c7e0658b000af64c90179162d3291e7a50a15306c444090e1c1cd9bc42a107bc0a0008307427132d0f9a04b1a1f0888c129934f41956aac26590054a68c8e011c306098a44347996e9a746c40c0e02c832b5770e14200f40ada2b4fba20e812214251a119ce6a51a063088bc0811de928c1ea0262246844d030e418cd2d118b902cca924780cc18307821b37122c6305ae354e10984a2999066a8879df06242952a3a45605bce226073165e5e60d012c08b16eb103070142be6ee38f2e38c182167ee8ef93b0bf9260d5081210f171a26b872a5c145860c21e1854cfbc4e1c8bd116f22ed8844010b8f042b740d98ffe0ed1389ef34643836e49d4b7600724102091884b0803c09cab3c20a23ac9040023c186104051bec70e118196a680127afc901030c02a8b2d988372c020619685ca01d06284c300155f9ccb3e08310f2c00320121a61e1188238b1052a418ae2c1234542f0080410f480e4233d24d903945f3869400f1a58a9c119503ad924938f7870a428611a09810106e4808b314f44b00638cc60220a044890c10e1a64d829c23b22a0780b187a82c1a79e7c82312818381cf0820007281a441007d4c20da4c7e8419015b5e85184024ed492852c51406185152738a14c207110000514903c4ac5266b88a1c61a6b20f0831b6e7cc340042495144f3c284d604228adbcffc40a2b79a810830d829855d44d0f10334705409d35144e4009856b1a8214358302507d404a115895e0d774034c62cb2b659ca3cb0a7efc60d3594f20f0845a6e5d31ef5908cc1ac10f11289b414f3e31d0970e9904c6040b8495500578a17022a708cd98730bc51493c1926579786103682af0c2cb30c8c8e24c32e48c33cc33aaa98c0c1e2a8c08036c79a8729900b95d9045165ea8600e2d793c234b3cb264e18e71cf25a7dc72ce19cd481613d43701093468b79fd4ff85379e37baf471043e14b84701d88024808f2e65d7e74d7edf8177812117c8f0df7e011218c30208ca338282f22c50a38e155ab8c3187b8c714586217092850a98f122401eb3c1ff50c42d0e9081c405a114c881d32198340f83103e78a38e3b6e90a11f90747286079778b07a924ab6fea4eb5082e0640f5f9862caec4a6649fb924a6ad97a91483a19a634d28499430ea220c90e1274a67827197a92d1278a7a4a1ffda03838e0e8a1022cc268165670530a14d1a0fac2448754e107148aa2aa87f8503811470a71e0118d1756c0120526aebe2a881b18f00d4188c11819d0420c34078f5ecd
UPDATETEXT [dbo].[Picture].[PictureContent] @pv NULL NULL 0xa3572150011d4624879790c2584538812062b1ac6655600e3e014ab386621404f8200d3f384b12bcc50a527c001085d1812d4a1043055c650085b0811a4e88961dfee42dcb624017b4f08358444029cddacbc014f00a162881098e489826aaa0ff1f1920a64e22a8d82d70708b7750867172b8410a4e10135a3c831666342339cc410e72a82635cd70c609400422cce48117b6c90327d6f1b04578411534401c2f52300c67bce368466bce720ef91c07c4440528e04a28102349b7f1073c42e0c20022d10040bc010b14805009de3036fa6885031cb84f7ea446c5b685426ad9a99a805050b705256805345a81842404b6bf014e431922dc006861023b220e6630b80112fac43c1998a0401fc8dc2464d4391b01020b46b0260576d4cb1bdcee769db80404cee0bb1eec2e4a5ad2d2ec4000822cb5ee774e521296ce70062cbd134949fa52f0ec69cfe6f1533175b21340032ad0774c0f0c8e9283a2123a8a03ff20637c51880236a211516e84a00c2990c5014803855a406210f28b031ba0903f2bc8e1105b104630a4b1852dfce01bb1a015156a608c58844073bbb2c03c2c108209c0400a37f04211e8a0823c90e25878508320ba30ad07404b60402940068ea81706fc20056aa00bb7ca5085157e6019997845baaa10952a4c420137b0810fb4d0850e30c0263e61eb59a46516b3d8e507fdc2845baf35b08265c2114f1c8b26aaf1361a4492138b9958c54430bdca5ca6083038c10954a18261f0e219e310022f4ab646d4a8ac19c990852cbc7008185c4615c3ec0d3b524b892c9c800e2610d130526083a111cd90c949dad298f6012e70253f9194a4215c6188641802ff3cd35881248c208f7bc0e31ef8c00773e5810f3354e19468f386805e49830bb8c26db004d07ff2702004d56d017ed0d106d2ab05c06188bdbd1c9c5ac610035ab08317b278dc318b4028342021145c6005075c348001c0031ef3c047e76e041f0a4d8842a31bc306a470893398429e158ee795e4b94e72d6ae07ea3cc317c8d44e7296739e1a0081952480a52739894806009e978c848419d3987974a20440d921508182811d72a80590e9a0a8171c6011c828c5434bc186f191afac71880643a130a968e0012278b8322c6a010b2fe00113981083182c610d8cc4c22398484406ae90409d9e241e39b5400c6220053c10e006305044118aa0820f5c300549ff358bb33a084210562b0350dd4b'
+N'177c90021f442009b650402148518d0f0c21135e0d4b15ba5186252c2129b8800b5a0ae0939b0c9a2e5da04b5dbaf0d208c4e28845b9822d32c104278ec511252045d5f6f3b02b26963217f3228850208bcf786c18a119c71acde15995b9f16772f48d69b3c0097698a34e94a8051ef0980518e021058700836d0d9934e730c21fd6d18e09b24345e07237b8ae90010a5610823e0cb80dba20db00cc40ca53669740005a9b2b28e74a550e3614aa88c1041288205cee880217c2902fdfebcbc011ee57b791450c4e804c1c281309dab99cd3cc65607940280162bba63579b04b8767680904787138af946209a8f80cebac30ff3bd7f93add55c94a1a96b90488a0819acbb39eed4cd22386f4084e3cec6134e627f3f86b63e651020d387e071880a08768d4e205563840365e508b45d4821a5150c62fc887e4059cc3066c80b247811c8d3838010f078906fc4065113780995482480502dc600d372c4ba76dd0294a1650928c5bd50636b801e4f3ac823e2f410b0810ca4e1e202d6b197a2ffad25704d2900635381a2a74f8400c4a3f04a894410195ffc1a741ddd6a204452fd63af5a9f3158b2eb8c1072111e15efb9a895a47516a26909ac390c0ebc8e0ec708b10c0877476023d4356052640076868418e6430bbb3cd18072f6023cc3a9a8013ae580725de4189d10a80130238440a52ff90051c88dbb689640e23de5184a811763f6b639b70b98208a081210801574c83371c0181c1c3804d00bd790304fe1b78a8dbda102062a81206ca808a0c538b84403c309c855402e034c018344003ec41035c01096a080912cee008ce042c8e4cdc800970dca0f0d7db80dc806d0e8245c81bc4878478d284f84d2f4dc193c8d3d0bdc0d011818ac91c964889cebd0e39a598cd0dddcc095d8af99c3cbd0e93ac4e8c5d001270026234ddd3f5538df1138e51821540024500d9a400c1d78d822ce081355883329c5d14e88202a88125e8c101c4c1a4d4c221448113a00a246c5d34c80137b40a3000831840440625821b504100414306dc80e664e249a0440cff801115a8411ac4dfe3455e11dc001e2cc1090905b480d04f4c4b5be94b5b75811a806212bcc2a33d9e142840123cc51068012ebccbb2685ebc2c95084155019c9a5ab5e2acb801ab15454fec0528948023644219180c5878837798c0f151919c500c239001e35c4616b4820078c10d780cc6a9001e700c17acc33a601d2db891f7a1062fc88c0964416f94df3ab00425f0911cdca32a9c001e1c4221d59fb8e156fea940d45c0027c84028ac4ddbb8c26210a00c148879a080020e58295957da808763709744a20101ce18dbac88434a0d7fb1080a0c8007e292c3b51709a2a0e0cce44c6688e0680802ec80f5a98263894031705c8a301d0d1008e60cd824ffc0033e90dc0a9480825993355108d860c81ec08122f400ce9918116425135a21eefcdc8a41893cd99c89694056aa58d04980126ac00bd09c166e2191b00e047c09d33124439261194e06653c1d3bbc43165499440c82a5c48115705d46cd613844c12f44c1099c433ec4c116e8012100e68fcddd2010401a1040640e821e44c11a00434b8981634a432218831808c237445506d8404d6de24de9d409644be8759ae8c9561c31debfa8a230cede4f189a6e265afcd5a22dd84052389e023c85114495e6191a549d45eed5de5018e30320c02fb6455b6910338604c07c101c7c45193081ac059677a40d618121256411710441cc30ce6dfc630c9000c6f142b7ff59003b10473180416ac8a31008c133a8c021049500985116e823652cc201788100dca31c5c59161887d22887222152d2508242d2801852d22a2d0612bccd7604d8794cc07968240492c23450a0bb85a4489ea821a04177514e43ae5b33b5084bc603c949c8c38d6009cae41ed064e050dc1eb8e0156c00061cdcfcd5270e2856e5b08829859c2ecc480fda087c3865361161e028008aed0e08b442d011c101306113aad314d25358a2d889698029d0dc596a2511a4255ba6a50638492724c91974c2977800d3d5699dd625d385e18c391d5e52023be88113a400016c1d10d4c22f4443340c02d8410a375c191e84c03908a432d402a890d4a3849113a4811cff5881664282205001307c83233a66228ce62422803118500ad494051c5e9bbd590c040215dc05adde450985d10d9c809fe5450554c05e3c41bec4d50ed9c5652ec110d84219a8c15db45eb72c815245555ce04204a0e25984d05e185a74e2c2a921c0bd9cda0ff8400049555394800eb04026e880140d48331d1f852a0618245231d4821414416979411ed0023a50162f809f2ca8021814477d7adf331c8166c8911ca8809d9a1f4b7c0fe3d8060cc8821c80db832e8d228ddb2261c7784ed2052c068b608023b9c804a00007f481294520787964709da808acac8a06973f2181441a826270020df0028c6ace8248c80688207b91a0cfe2684ca2e015f4688eff0eed1518c104e441a1f803c7e189c00d250614e524e80252d648843ce93545698554888628409650d8ed90a9290c1d5b9229988265967cd83acd1c59a229975ae15aa2a5067402899d4e9cc6a9c3c800d3159618f62d1992e164b0830024eaa7bc401408a23520eae16683f9a00a147c46159cc0d9516a2d701d0c40411c1c041428e2a60ec21688c137d08a1b40c116c442a9520115d8c45ea401ab2e503c9c046b22551131da5df48bada6c13ae65050ec4405042b5ae404734e6b0acc802d00c214f44b17dc40b79440092c01e1052b2e688116448052019a50484b2b7641bdc4a25d2c41044495a809051c94805739511964078160c08048cdc3a0c10dffb002fd818103a8c26e60c66e98002dac43fe9a8339e84931f8c34f92c37daac630fc949db90c699911d3ad033bac4310f4232de00c3b2c022fbc4371d05f83e29ffd258d3f3493d42046dba428126c87c78aac87be88c8de87c9fa1fdbc8ac448a40b5a9287f29468a8a64f4ac6ce514080aa0404d21c879e9ac08f2ec859860099ea01197e08e1aed1e20c01eac000de000d3dae0e430e4509242928adc81592d0ffce01b5008363958250c0e55a298297c81195f82229831087413ddee8e959618d99a299a06415966a11d5b098aa5a5125228cd3664c2ce65dfeae922ec113748192ca04f625ac31660c33128431c64993228031b78540c9c03b745c144ff1c03d771831738812534012c1cc2a470432058432396ea264001157c43aa7a592a18c368fa004bbaee3c34502d97c451cd62fca5c15d4c6f17d8ae0f20955b35150300eb0fedd0aca8410a18eba3d54504744b1900427006c20fd0455bfd80f4ea50a81500f67a1eb77e735b15115e086b013c41a5c9daad416d6fa55bf2b1830d28c124148a036c0fccc0c66fd0970d022c00bf031b75d633084711c8421160c0c7a882fe2eb02b4c703f0a003bdc8239307071fc49313042d1506c065b6c809a80de6a2c7744ad297168c96280787a640babec898aa4cca6ac4866d12d4c4e87b4c804d4948c32882eed6c10d7e80e34808dc6e40a06edd0722b0a884039ff64519fa448867e1c06bc8851c2c382e0838df00016585317830d83edc083f9411a5f4299940904801304849857ef5c38a1138a99e959ca71d95aa15a5bc95a96e50bac711f1316d3e9ad1f3b0c9e32dd2023411610a268d542292883355001267cca2f0482a236722044811794152c40813270dd44e8c1202a032a6003fc44832a40813530c40f8ca61840816966006962422ac4022b0b024b9a849bc9839b6da2a888a20da4c0e8f900b8da956df34bedad225a1c73b5224004a440121ceb24600203e0c2148c8b0e0002e4a5811b54ef2f2623f672f30eddc4bdcc55bed84500f51037e3c210bc02136802295464817007091c5ffbda8016804212f86410ff80818848d63830307d02b03fd03727c8236a7c02b13d83337c8c4bc8802bd002d3f1ef22bc43436b11c5188703b4f42d3428c5562c6eb5845c4bd24b8bb485738515972c765160499bf489061c7f85a408e040919281db10654c6bce0726c00f375c8554028c5f8810e33412fbd2d0e6a816a88022a08114f3d78a402de6640e522648c95d2d540b2155ef2ce05c810294c9144cc1cb6d3557bf98013c829427498829893a8969133aa158ce53d8e2715933a1d07df5f195df43f2311fdba9c324acd9954fe52ac34a6d82206c14620e82d745411c44011eb45e34c8f9444c84f84084666e5da5fcc22f60ae358ce62644035e0100346844e0992e02ad662dffcf48039d440c74db439c800dac63a0ce22ed3223f5164507e5e66eff10efa50133e3d009a590a35945aea6404dd4c50fc0855c0585749b85a17d5eb07681b42a4b5ee00428743778e760d47674d4b4af142c011cc041122041317c4f409e000d98c3a0d0b7b617c33bf0421b35c311c8829ded9f1090112f682339e8916199033ba41f1601ec3bdcc222dcc2c46af06de11627b4f924b5d27f64d7809000297883fa92a80b8be4009e34c2eb098983414a02f98b68cec27dce8dacdcd66e80c359bc92ef40186388cf26f1d06ac10cb082a0d8c98cbdcd8058b19232f50a38b5912f58ca810d11fea80d4c81284c8101bc9c076c75ce9349ce874999805358ffcbce87993187b58e387df557db1ced5cc217744288c925cd6a8750969fde52689bb7f9c3f0c20288149041c12604c32678d92f1cc32f60c226c4c1313c541ce4430948011bb08132e881dc4b36e67a5be51e422d0cc22f5802141c8213b84122280314105eaa2a4bad248223d65408b82e3e607aaf58406980a2a04216e543966cab016d577350745005e46606c0a2befcb21a2c812dd80218e5501238852e26816780d1bb2895733a151205e3e7fd906f335a22140522107b6154c38a7874b28b74d484826278011c383bb44bfb3b2c822a304ab66f7b7100f0013883ca38c3010f434c7001190d933bb62fbbc77bc590f8ff52db901e0dfe39f8732c0718ffe4c14683a1fb33e46061a02b09087f0060ca1e3cc21bfc882f3c0e02040d5e2430a04031204488780b16c85b3062050f89462850d850f162468b162b6dd851e9e38e1d63488ed973e50a2e03486e8101430609920b326810f43661c28049f0f0c95b912041098958881a294a81a2c7310da6101035e59101a9040c3c9d31a56ad5294da5768560e06b57b152c38ef5eae192070354bfd23011eaad5b1a9ce69aa0cb096f28bc9c161dc2134d4f2d2bbfa86cc2846993353d510ebb2815258a8d120a06c56133488e152bb5063981824d8f9c437aac0452f32b0e142f82dc3809d4cb588654df1020f816eb76420bf0e2cd93276f5e3e781642a450e3234204ff1f4b52d8b871e246f4132952a459f2a30b0362c4565578f0200383dae2bb7451be6488821b36aa2749a20010202d119cdf50f38341fe02c4bc7fff5e203f04187800812e04149001f3668880b60c1c644087123ea009030e3840e1c20a3120c12e4ed881618625e010310924c078078c6254f487c5168b6171c52c9269a69967648181836778d1910b2168f9d19c75d831c71c328c1c929d771829068c45d6e104071cdc99924a46ac7487112ca7b49291204808e5820b621a130957c23cf34c19d45c5306432e30c41534e49c734e11ec0423ca97c2748ba00b7342c882de7c7ae827897830a2118a2a5a74a38d3600c923a54a1ae38a93e060058c964420ff038d0be8e2a2cf3f75e1c927a012c082072c8c5a150ba42818690c2db01245aaa7a6b0358dab6625002b02a8e275ab47149842d7ad8cc54a2d519e12852a51d44aabab4b0c30c104b7ec728b13bbaebd6b2fbca250ad9603a030cc304c80b1261ac60efb2590142693839b289481a296d1ac8823053c0611cc8a68a0d8c28540f080448f2dc4f8e517045291cdb60c8cb1ad8b1b10e20d1edf2c26ee0435dcf8e187e4944bc3b918a4a32e85087e40e0810ae658658e070a08cf980463e93802f46c29030f1bd278cf164086c0e58734a4532316fdfc03ef6597c3cb80c058c613f08a8fb1cb2fbf12cea1d0c209389800431536e482930b44906389258c08ff71090590f0c701305c6cd19f15e32ee69d19697c66185e7a14621cbe9319871657d671854876447867117668c9c2ca03d0c9829d5baedc124b2ea9acd21d0148984b4c579040c3733991302426d2dd74934d19dea4937534ec8c120730d8a1cb042e302808859c124a68218656f8e9a7040c4dd488e28ddfc8088d22dde1d14929bd426d4d399589869a2ae4608089e7e9a950e18d42950255156d7e8cad0cc04aabad9c3aff29ad9248e3d65b6708718a246e756a7efa6995cad8b5a4f2400a06f0805aa4622d6a1db05ad9c28bb638a11724d4e22f81a98532d6b086c304c30d98a0c62fcc85096b2c214237380435a010053c68a616d160431ce26085ccff90060f54c881139ce0056e58e230546086311e900a8539c8183b8c410886130f41e1631ebc214e0a5863b2f2d0ac39d239017b7c801fa6ad6c15abf84e78c863321fcc600843b0c114a75802f70002170888401a08301dd630c041fe7150d2a8f680041908415dc0c51a97800b943c017aa4904185728713ad5968430924431eb40007472e018ca1708903fce13617bde892b720073968948c673c631c33126533fee60a570ce916e6788708d891056408e045875085876eb1887768a9725acad22eb1140414e4810632e0444c5a574cd08dee4d6f8a13a78c2902299dc8537cc2dd048e100284109137f1a8874320b2028808cf501349d5f12892148e7884ff7993aa94163e20824c6d4a2617a001a82a242a78fc061fa642d51b50852a23f0c0552221c95668452b8202ab585b9901fce2472cfa51652a21b25faf78e52ba95c020297c02801c1422d03668b16d4828b5eb6b5084e70c3095678412df4a08c4d006313dfe8602018030c370c4107f9c0033790c190147063335640292ad8008bcc44c30a29d80215da05052850010154e8452298c14500212203ea3006717663c479f8e637f008410cbca0b11f6c0c3bd881431ad2908213bc953a8210d07eb2b80a62d8d141b5714304a860331bfcf5040a102c7c0cd485a051470d11708380e2f8b20cbc4c3c704c506d1094a03526010eb8784282bc7101136ccd9086ff3448226920a62c68a1918f9c8124f144c9b6c1286e73cb5432364923db0ac1b6cdd8e42693610e34104904b770401604a00a55e0c0015098253bfa72884514e372bc8c2e1854e035ce11734e9c1281eb8c49273bd989997422030e18213b24546f20172ae4358918020b046a210e690844be09947026ea50c5438a3923854e755e6106a7901e1a644213db656d62f9f84df078f086a1bcc128e3b4c80696b284b100cb57c722e85a9675ab5c5d8500ce59cb5618aad0b46da51019fdc219ce00816719c08031ae565d16b8175538211a7208172cacb185c388011835a88135c2218808bc420731388413a2c08dc7842304c85005049da08c411835855ee871ff20f83aaf4aa4620fe1f801787a5880ef603503372062a080f39bdfccc30203b8011eb8ac58ec14c8b0115043146d8087349c8c0105505977b618a08ea9013d624c411b6d600b0524c1165a38500448c6e5c58687cc715c5a802a9b1fc3e66a3c0588803c31809301fc09271922c1e686b988461a01107098df295c8227e43a809297048339ece68adc7692469c340739864d2473a4d22502408700600086204001065930c722d0a18a665f2e97599a523104800215b05a4c9f939391d0a05dedb6eebbdf2da633cb8b84069a802005a1e604acb9bb10b4c1026d8847571bb24d3727e077f60da77e09eea8488d6124b042493ed00006f0cae453a1cadea8eeff19bc0400225518f7a7f85e45e1319401a35fe05f88a73205f8f98a575d5996283ebc0493d3af5869b0d50c4684151b88858008fca8ceab9505bc64c1a94da885000e500b1f976b132d4804267c41011d9441000228c52f9a8c876f514315c8900514d81085c058c1a85ac68420c4108b2e3881c20c4885cb52d1f6b60f280389980436e3e1667cce63eecfa17362cf7ae799fdc007635c8f0db82ca007cca1025afc4e80f6ea833480c2166908441bf3a1809e0d010e0842801a421c081fb8c10d91f5cf805c06c70c8c67d36a4c430404b4d934208104a0cd09aab9e6356a0d930c36908423e11009386823b8b5c60193c0f0dab8d94db7e630a52b926137ffe46fd2d8444a25724d9a8543806114cae5452db3a08a432041db579adc94161103ad554b75c4e49476bf4b86edbedf75dfbd45bab7bb7e763bc0ddd4ea93414ccd5e7b136738f46d1e8ca81e1a62be7ca2500cc57892677c262c9d3c8e24ae201248c19dec84c0e4699e48c01b2c247be08154f24922c0a99f86222960250914e11214410a426c589a852a6ce0576ae556544e14128a587041d61a4a7e1c091066c07ed8422d10a85a744e81b2602ef44215a2e01036e30004001bb60018d6400c40cf64b420426c201a80e018e2c01a0241162003c76a015e20c30b0483a50e210a708835dca00b7c203b0aa00052a117da6e0edb8e180a400d12a262ea01ffac7c028986e304da2a054cc3c8b0c369ba6066f6ecadc68889102003b6a33fc0433c3ac6075240096c610914b1d192c067ae806a10206808803a3e2f3b1c9169e428b2228b8b2c6b09580f013cd10642a120b287164fedd4108943f4820c60a09122410b40010ef2c0252ad02562e745da060c9201b784c01c864f4598447168440854401bb2402f8ced16b2f11d986b117801fb4ee010b2e01638011d0ec10bb200ba7489971881128a00274801dcc22dbb366553e28ffe820b1fe78ffef0841160225b4ce07654c04f6a3121ccc0dec4aabdda8062b269c1e4a1be12c00f0e8578f6ab5136009db4409d1060050c4153d8a153222ef6b067e22ace5486c2ff50544555306224b4e0e60c603d14808dc6425ac402a2324a801e41599cc229442102404157586ee55e8e7ec44208796e08158813b2c00bbce0106020ea5e201a0ce6a686c06700a104a6000ff0c01ae6250aa8c01af0a014e2e0846a4115f0c0094e480e32031660211002c11ad4a00b05413c52210ee7b017eef22ec7c0cc526002e0cbee1a321f426001cce338d420b158a340f04c399a638c74462e1f803bf863f1d468314161089463f26c6008dc630850e613298d3d4c63b118eb141fcb8e1820664c2f3ccc2339be2141aee0066800b46a317b72a26b38642ed88191784f4458a10235c59d5ac22598440466841c9cf119a1eb1db2c0048c4b0ef220ff0bb2000d52e9d8706095982b0b9ccd0a66a9968ccb29a5847270a918f260003e0005362498c284c0e4a4fedc0fbce8d14e5a423e5d42535a0276c02029f5ef7a72c71611227bace93fed6d771052df8cc8ee024e012732790c8e79d2a924ae4012dac9e1a667266aa24f44722748c5e2eccbc15225252d72245cee57206a2a68927f524ca32040450de01148b42a66a0c39c227eb24259cc4714bea22887d05ae4622f96ec469cd30a8ec11aacb20c8a4005e8c00a06e11794810d4a611394210aacc11ae2401902815e04230a7c811b6ac10cade05f9461105340ccf052ed7a211cc2011946611da861ed52c10f0600df06501e48320190c8bd0484300d13ff394e86b2cc83ad9c638a4a06651e8065bc233cf6688d9420095a91d29260082e6fcc56518d9aa33a3486b1b6c8cc1e8b8b1c243c0a2439a8a0688ce109a4800654e04f68f3d4460b031208094e6b4496a00785d19ddcd3e1887138892f39fd814afc410e60c0579f5300168112b2f1d818c13adf811378e11d82401578614868011d384115e4201d75a972160127ce9304b8203db1abdcea113eef4438e71307ec334a8ac14a10479a0889ff4ef53f51d53ffd530fe9ceeeeaeb240bee2292c223b480c220f00a8c40c06ec148e2a97a4005c11062547ec354eceb54fea955
UPDATETEXT [dbo].[Picture].[PictureContent] @pv NULL NULL 0x5472a0ba02a2a8e21108e857ccc70002884559142737ac4667202af64759fe27ff7dfc0702721465ed4200f2c50bb65330a0801bd2a0040a61ca6a811bb8810db6e017d8800d0cc32da9200e20030fa62c5e162006584a33f4200e2cc112682a10ce341cf0d217a8611db2317646c1fb7a6a00baca03e16105f00178f08138c6ccd328714f29eb07e6630940a63199088e08558bca363914d5ce02ef1586e06e7d60403eb16340c6385c313f3475f1a88653f30317120b390ea408b860365135d5bc8643f0020952000edc0392f2a002c9a056ef513891736e7495db7c5574a30d72b2d16a19e11d96d35983c0e7cc811d04601dd6e13ba32b4b1c6011f2806b38001eab4775c464dcec915633255360877861075dada449a8851702d2200e02ffd58ee0548fe0d4a4175e0700213d50501010e0c0e95078205128525f3f825fc7e0072250171aae1e0b2c0343f24f3c50c1c0d6e224c2c1204c51044a4449762dbee2c524d62bc042452fa17d92656409c8622120806c852bbe0081782165939213a8146649e3104a280a14a010f4201a066185944119a47413922e11a28083acce09e241006cd64a91e18552884a69e8177c016acd941ad8014f9ef1440c871da88177ea6ec180e26be7340404c18e00641293e3ceca0317e66339fe6a3d7c61b12053651ee00af22c022ab73c142413f016109620169886d3e6430dd8230d168b70b7687063e6419263062c210d10206654c0049cb77a733791ec821d0e61ff444664083077535ec2fd8cc43dd3ad189313ba82c00ba4a0297b550e04200b16c174b37149a84d00f882178e8d1dd6c11c68e1102841dbb68411fc211aa4e0766e675b8329fdc4ed8ffb783e6fa17889b772b8a41816012ef2000304b25da53727701997a7777a512d40e9aeeec0ea9beeeb9f10a59c26cc22f9d541c70001b48014e68fdcf6240309a97d3d109fb65778fac928207607d0472dbe598056d42cc8020434c0143ae12b302a63a9822b04e87fb64201ce077d0ce00b4c2147394408e74215c4605ea2410ce3e517f0603da240835da08393ee1b0000009821117ec11aa86e01a0ec844be810e44015fa4515a28185a220a2050186c36168df81ff955364f85e8212c8c01ca8610102a5e2e4017e016e05e621047c816a5e064028ab40a6f88ab5606dffeaafc698f420b300a8781996a04f930014ee36091af1b10224cf48a68a521169bc18018ae6b110550da6603411200f48e0206ad3716b6f55ed02095a4144e020d62474530099addbfabb86371d83c01c4f400a9c725af38025c88b4b9aa4169c75760a8748964d4aa06b978a210804c0f6406573aa274c4267dcde3af858394f5c99bc5ed91d28813947b9790b29970d097a0d6900a0f7d4e68d3675239bfc4d614b9298298078f4d522c7c05f018123ebb1530ccc76aee73f3d101f5e5ab51d2c255f8524'
+N'96208034ca00a4c5b86dd203fef7123a81ff002040119c7b262f410a349657fc002b6e20635fd4e48c25e5a6e580488081f50f81b2050aac8c346000834558356c400d30610d3e780ddce01bbe213632000094e11704010f1a610464a1e8b232062e7a096b010a982c0ace3415d4201ca861fb846fb033e51d501a1dea81887878055c5a1eeaf46bdf4b2ee10e690244a7753a8997833175063f8e2641dc003d8cda8d11c051c348013286f588e113415110578f4fe12869c2a3413a758f4c6eb11e86964dcd5d6b918ef1992f6c608b1d4905dafa77c3abdcd8fa4e6a98490e400ebcc057f34000169995b90475a94ddaa4cfd8d8c11b3b994a1ce000681903b8b57a78374c50599023dbd68ad71df4daff72c8205b48c06b9ab7ff42ebb3e7edb3a157d04b5bac14327b7b189c8447d1c329bf9039994ba27cd59a53c2c4c0562d6b72421788c8cd365478de0010be575214c0b82f4a11bee00b06e82b320a023a419ddb47625b1258ce280924167e14e0e602885792e09e73941ad4200e4ec085b861104a611094210e72cc0618e41bc21806c4f00402e1078c0161be321c4640150e00a5b82106904133acc02fb2921aa2f60a0281c103d9d696c42552971d866137ac199f7c22c363fabdf000130ccfccfe233f5002251213174284314f40104e7cf10ccb0786400bf0a80b1ecd67d483ce7ec0cc3e9130116b3403978e1c51b2f42802a6e03e12413cba1ab4e175fff6ce7355e70209bc40e1e1a09d5669fde644dcc44dbcecd1d65e84129a90915b410084d172447a488eedd8a8931394c4cc8be100a29394b9554dd2b373a25cfe22bb5c8d374aeadccbd17d114c8096d5cb207ab9975120d0b946ebb9e6cf4b5b17ba2a7b47407b79a024175d0191c2225f9bc2caf75f6500bc2e9026a6f960b756b7c17661157d9bfdcbc2be6026e9990e4ce10c963b2d20c0d40b9f7fa6c0061ecd3ddcc306eaa7e614e0621ddf0650702d084008b980ea95f7f604c0128c7d100e41f49dea18c2724bc5b0578b200b0e60e8a3531636c012ac81a946801ac2250ae2e0108641f4ad400fe2252b7b21e0d74815fe5873dd494a6247765a89ffddb1f7405dfa87f3c1028a6035ace8684a8f6aae004f93a3a7a7480d06d5650a040e0c1e01162b0214a072c56829f180f5eefd3305f13e10e4c34fef6d0d37024441639c26166840de5015400162c08409283060e0652214121549fc008253040c191164d05864870649468d485c21f908d2229989b770e02886c301a5458bb26401c328e62873b76e993327c0444d73ef8a15f3572c262377075a612061820b8da532645c78aa51a488a922c054bd05c6a4d6933884c62c060649160c2a38a020380085408147ce1e31db07050a0e4726f499d076c280bd47f68608010f70bc79f5e4195e910031621e0918376ecc838791c9463658d63266c3981f63aee4ff43738b229aa717967221e1cdacdebdbae0c19b270f7182c73cde18c14261c38e2b3b1418b844c0800d1b852e993a7ee9d297e5102e41083e65c61040d2e10c493225fb8c240aa44090628040f6344992d83080de84faf52690aecf62028a255471a2c19075084a143d7aa24039648515b50840e001026441a02a49a8118535bef837601c5e20038315dc58110d144e04e2c30f3f44e0031d688c44625527b903c63b2d0d130360b019260f3e2bc818db3cf958a0421e87382108020c3c40cc034216f00403465e8100025d68e1431a29d870420a3d3290010308fc30031cb824c9800f0acc00c8104ba4e1851781fc40e5030558a964046aa4a14604b11849ff25956bfa582503b1cc10a71bb1286902061c0cb457a121143a100a2a18a41e2759949704201f5034d288196d7401124f71421a699a7e24124926810506254131e24f102d2dc28e4b59b86293aa081e18040efe1c40491e492dc594a71e8d3811555861959556280d25943b38943a960a7211aa575f75b145105c28d495685a7719fa5760aec133983c2f1eb642b9899d3b1b649419b183659a8db15966a44c5591a69cc840c36924083a68a1f04c024f3e32ca36db1b3c605159259d2d714373e00d778322c79df105785228b25c27064407071c0f01625e78d1cda040218a5c825e70049037c50dc1b167022f4821b4de21d63831083656c8720237faa911ff8d157140014534871ca24a2d72c811a01c872810c82f542803051e07d412c5214c7b818d1e83e0e1841a3e04e20b1e3068c40eda238a705231b72cc2092f2ab418ee0a31c698008c365a10431e2a1481871a680a3964016b1ea9242e1f3a395c0a11f8c840173f2c014a17902fa14079806811410a27102078066a667027886a88ed069e0588fe40e45456894b04b26362f93781125a68ee7b9d351706ba9ac0c92236440a11a5155dda51a69d72c269f3a16caabc546064c548573139c0124be8b07313f76470cf0e2702c020472b8b041104094ad1d054a71d5964e954568181d5565c211b138a297292875c67e1b517bdac062f76b9d6b3e4529769ad66ff00876ae0b7e2110f7149f030b159c108ec86aec8687032eedac11830b3992bacc010f442832b2ed0141a90605fa9f9df5e00f61ad8a42b3208c38d6e3e6832940d07628a408f0d08309c2918c0648a2040123a6684e970e73c064803209eb8c4e0d8403b4b288f0d680033f7a887167950431c20a1072bdc270afe71821320518b526c280a29c003d1a04000280cc20b50f083137e81091744211aa3c80fd2b8318840120d0f3e880235a8a10a9028921d2369db3b1cc58b614c2004119c51deec661819cd031e16b0c009605004189c20103d221de1d464240420e90a5dc0052e7cf0a413d8a043928bc0126680241fa52173491802922240003a3e4e480cff585de498e40341a40e4fafa3539e62e7062a442075b10854bf16c8c0dc554b05244008279000039001a21023a1084636f211d2700a85280c850cdc79af75820a0df2c3813b84823d971ce8169ca849f8c2c73cf1a92247e83301af9c421a575caa22c1a24a558aa51565ddf32bd323c32248e02cdce98e5ad8bad6400848a8be186a00ba1880b72c108fd70c061fe09a874b610453c5cc86077e900c07b5a09b77c16b0c0328613af195af1562a085b9b3802e5e4ab0da1881021450d818b0a3001b44f53c04804e76cab384eb802c09598d8475aa38050528600a5ced98c7a2aab2e84c67098080995bb310382878c10a8798501c7ee1046bc46110028242ff1c0211352758420d4e189acf7e1887166c618f709505d3a821c741c4c109863c243268c10ee52972445901033b78819041b541868891470264840f71dd68121660dc096e20cb33f9e894862be691ac14bb34c0d6719253430a92c0ca24416a3a3eba820f08102537302048c44c52174014811f70a94a6bca8031ea848b58c4220298489d1b6880818fe6ee2f88aa16a34c9005f1557106932011193862c24e3dc59df43d280deee5298d4c647ad663443108342024b4aa2636c9022f66950555a0c00441a044426480df0b78242af0a3c8fca65792657165a231f187442cea37176e74002205a05a06b52d00eaa5810c6431605c6301d7a434c629fd966bc8ff259b9a468632eeda69bc3e488ad01cef2940d517bffaf5c218c7265d6f00c46d72e3c11d707506552c4f587d7855ed64090ea0f06a97b143d5292cc13ad40199021421052910e0961d1b825bd9438b5156151246e3c6217c41052a58e21750e0462dacd046fd58620b6a985a195760036b6c611383208400f080343dbcd1af4e08876569f191e605142464c0013b16c10b4e98402d21304cba668349d8e0c3027fd102e7d400a5134449107f2a26e10aa0a6351d6e49babd410a7ed0051f0ce70a3ff893136d018825d4b60bb01e25267e3424366d779acbac539510608c2afdc90dd3fcc695428181b968d42f01244841dc4303b10c6f096570af4514b9bcffa6e00ba8bca2af3cf56ba2641d6069aa482f3b6cc28e757c3a417e9b800928f14808e7177ec00a16b188653f650965592359c4a8cfa23b166b93c46b51cbb4d63252bffc25c6313ee9bf48fe17d6b61446e69a4d4d79dc2e10fa580124148da650681aa17260e7181f4027e12123dad806ca9d814312a433842c5dc73753144f55b34356b37a6c89c2d91895c37475b14a750646a00e1cdeac9e046f016772255a14ace08b0d08e266721d1035b466a62d88410c540884329c50821344610b9870422d6a71212b48d6b05038e421d1818480c29379994242a7031e3e12a8c5024b8e4cba66e4d24e86c002686a532c6db0a108580ed7157840e90b974a2de8ff7694d1952a9224d7cb5ee202d76afa411a6c908240c48275d7ee422c7ee00337580e72d74e0402f2648c5870dbbbe055817837fad19d1fa551c11b1e201480044a61249d27dc14be38418350f0eaa00a8fdedae8e7154fd40269bce0de2ddef1d9f4724215bc300b074890053964219def835f39e58761fcb515c7221460f15e486002ceb7620ca40b21a00b0d984d8522521c376286d2062d46522d161893f01787b2512ff622e592633b56191b100937042f9cf1031b302953f16e28546446b6730b14633234534db65414e04163c0566c551d20e3072573325fa0435384559012555aa73957777490d210625645e8f556268007ca3008870009730505bfffa00adc20081be00bbeb000b20003aa5057723059bf30586af00b7110845ed020d6000502102056200783c0068264480d92489c100ae0073cecf387dfc40e60c02a68c009186552f5201b3c0008e9222e9cd48168c226cf950297887b82d005d0465bb7662411900627103869b04b9b782533201d807005b4d5058c23083f62386bf25cdc364d49427c0cf00ddf906d56f203dce66d11006e833228d8b416e65610329310df74021d837d24824e377701f8356fec337e82885099022cf95680b3420b5920702a223eb5c00b79c00165e13b5e1007b5b059fed750f4e38e1a663fa7523da5f26909b8400e18026d50522160061e588123e66211385e02194073ff81719ba75221b81824981b96e1419ac119f0b202d9e7821941644b911442252884528341375307931b4e6574d9910262b65542781ca670068a301c494856b704297e70743039565c65655350925c150a6fc609b2407672e005276005786009922608caf00b29d06700424774043670e4046960097e7003d11007716085b560344c43349215054e400d66632ff7053c8d023ccfe37885c80e32306a3e675a3375792b7023ace673beb0897472254de23929103a425201cc854aa213399d837b4fa20057f089993304706024b4850b691038cae589b8b024c1e77b469201d7e66d5592086eb07c08e006d68471d8244078217d18a01e7f880687b09849e07823ffc111ddc72910368dd5c814d7a836646015fd753db5a00a722000bcb008ef109c02a00a64c10106a13e5970008b603e0cd750f2533ff1684ff6e41512113ef6682836c68fe4f68fe416901ae78f233510d2b742fdb27920e8522dd71894d190ed022f1be0216300071f404f36471abcc20546166e6a310093001b49651b36b41b63401c0690663e2456375004c7a101a6001e2b206621231e1b53653259450a201e61054422c35679e02861a71e3e19071e40675ea09461a30c518009bf10089435086f140704600597e05742090337500272c00da54005981007b000207fa71f856778aaf04d64e956b4b014df5415229059f567528731538f884993c0401cff78023ed00588d93aac243b9e1338d2056da7676bad73259d236b52500892b02646b7028b5927b4d73a5d70899a283a7fb06b1f82093fe06dcea427df706dcae799a0684dc38828b9e33fc9a93ec9880402c05680100ace884e9d725fd448034cba14a1400bf02461a0524ed4e315ff6505aa50aa598003a3200079601082b22f4ae17894a012faf57f57015103c815bce90f644009fce39f7e010f6de01ac2ea800c6406dc82ac1a3752c73a9eda247d4ac105e1160386c28128a5907ea02e93d1901099199c6103ac4015f5128d29641aa7611018d79188f1880793831bd00063e00745400774600a97a0088a7003f9500844b4af413456536003de71091eff201c53d5924c041d1b333ce5410020ba1ef36709ca40677a000b1aa2863940054eb0052e1aa35d19079670465ee04673540493500874180d54200671508761c40d78400dc8400dfe9105d1884506c593df343d502a0324c0010c040ff23002551a1976f32f2110039d94025c6a5b4a9224b6877b7e10013f223a73d03a0f90273e126cc87503362009ad231de5e10346a26b84c3005aa00681304cb7d6057966098f738b19a07c83ca6d3ed039c1285e3f2b810311178caa1ef72516b73404934a221ad1294ef14e988a9107158d8d172afce51532019c02a035ba290006b12847b19f34902955e100154515d3433fd489121217b961016a84d22dc22aacdeff320017d8816d7028b27b8117d88010a8acbaf351d1c7015cd014ed319af7c85ae1b2642bb0413ce62e3f004246900fa140152f8873bc9291e70ab4f3d0723b863044a705935004f75a313e24553b2444e1f1436746afcbf130e10b3126f30506b0845865464530887900056c0009b06005b0700081e4042a6b09a464095789074373959610c05f749581900465402075550a015c0b61642143490ddc3034ad90784aba1e5a6450105615ef9588670118a9f5968d01083cb002f360010390b493a00ab2e00390839846f25cb0b4b483637a43624aa9f45cc4910492c00057d04b1ec3987472a6adf3036a406ba7f40008e026bff00b7f5a27493227c6009a54ffa006dda506d63401c298a805699e4801b88be0071d03ae95c211cb8342f7629becb34e13968d901bb9aaea12e2081f64a19cead32b17404f60f0b93b8b61d46912d5634ff2c808a5c23f2b06182f6663aeb117fd080f8fcc6291ec62fd58811f55173b777f4e8104cdb7bbffa3c82845bc8881ad3685bcf2b9015af00349609fcf6b916c6c50376b10fd6201017ac2b38130edda197e5008e0911ce8213204e01bc2011e55a708f30a03f82a554918be62950f365065db511e56003ac8354a960009f96b055e200750500b50900362b00571a0061b604657595877e40465e20504800780500274f0025763c17c16465a792178c00dfe210086702f59a42b24ffa02b4dca09baf95e32507f7ad10611646a90816aac1602ac550402700282e021966325af078a36a0b6087038c49427a9048a0a3004a0303980000a7090068f13c48d693841c200c0f73880a9278465093dc24ca9940149f20d7012a6a730cba04c9ac2989ca8a914df243c1ea30294e08cc933aef7426ff3266f8debb88cb45fa2ea15412000708310e678149a7b9b4f61116c03061e6612b7aa2c5d519d1c962c60c00973a381c33aacf9d8ba2dd68f967c81916cacb95b5e7c2b179a4c027c7c0181e27cbda3c92216d1b5bc0076d3722f27194b90765fc8194b6000e0aa7df1057ee3d71ee79ab4d67b6a27bc54251865e77131c9e101c50ccc06703228ff131c375008aebdcc074b1c49c81d5025551be39b9010087c6903f9ab0741130d19f26772e70677640d3e60dc29709572b5cd90300862a508b0a00707e005e7bc1f7f16dcc820b32cab293b79b302bd4279808c7f8b04564106d1c805e87963549a00d89a00f3300949eb4930000384b4045cca4a18ad244b301c1de2a5c4849946323943c00443303c70a004439002c28724986938a6b726c0170b05a00e8493017a5668de0639546c2562e0066fb2d269209a88aab7ce7a6e5c909a9cc00e37003245e08c69934e4f8da9a2f64ee5f7a9f8b65fd619b99e9005ad5216997b147acc3e081515bab92c1e8612d32371ca52ba3a9e2c38b008453072c29a5229ffb5d00f0418b21b187f71ac7b51bbac71c9993c17c9797f3430223b899ca4d0aafbd29fcf87902f55418d51532fe703a98c191b60038a8004a1617348006158f4bbed518e3e574934d518d9bb543774051bf01bca41075fd009e0d14318631c44f8300a70033760005d0bb02dc91d622593992355686600cc692060c3cd02500b84a095d8204756f00b9b2006018cc582a0067b769590908585a5002570b27f570bb9170158c91f186205c8602171b07f6ca91e4225333223d0346302d93712d1b82fa446e50d0d9729bc79f1e007a1284ab3d6055d4a27c4767bb88726b457005c924ad6f10a99f310af60b7d5365babf3008820244edc23a7c4006270eb6affb04c55026c9d17276fb204116003e026287f4d9a03a0c98c2ac6cc830630b01d2e5eb8d038aeb5c914f7557ea07ad5c512b9a86260a7a99cbb32e450a150e7d736d8130a2f714f5dc1d6a83251eeb00893849032266329550fc1ea1a597e2894cc8f1ad7e51b5717635ed44761e69ddc1e2b8414241054d76e16cfd2622a57372288ad7ee0076a8753ca6b039740070e25aee0f77d58845167d1499edd753b4601898e8236f005a6a001adf002f5ba1c5ff0e876bf1c74a008af55759a2e4563158441c81d8520552b501c5fd09c07700051e005c6c935d1f0db83e002f5610d54e0069630083fea0682200698600da8b0215bb0053e5002f9700803a2ea50ff900201bc097a80ddc8fe1ffbc73c589407e06d10ac0aedeb51de506aed8202b4eb6d5a0493182a6c012bf0219e230527b0d2185dee9373894b80c3c470383e8200d6a104992056703003bdd88b5cb23aa29399ea20fdc1f68aa38300b190678160f9b5f65c6a902411e00411300569300357b42f9adcc502241077a1c900810103091334687062a76209a04268c83c44820609920b1764589421c3a0414e076570e27421a2c38722c080c1e18ed1ca95944c60e0a022a6401224365eac78018d4311646edd4289030ca5204128a554c928a9527f2a71648911c2429b78f0e2d58357af6a3cae55e185f80a76c057332106b4196076c05ab66c27a040c10126ff4d9b173a9ac04b43e3461335050ae40077c284b521a4c69b376f81bc158dfdf859b26183162d63361492724ac4e69e12edd2a0a5172f0615842dc46b6cc40820d5aa296cd8b163cc1523745a1dd060ead2a52f74befc5624a5908d1b8a6edc2020c580814b060818b0a1207a123f0a0a15526463453e4574f41c382000ca09398b6a4519a4271ab62d96a2fca242c552b42d540409faf1438c18376bd644284181134250a5162b6ad1039b5294d9440f03a351051d64b260e70283fa2201035e045241a00dfb2a08899e28a2e5251408032b1e7946582101175f4c60050b14eb02812e7cb0e1041bd4f801010618f011812b7059220d1b96e8f101250bf8b1ff0b5ce018e2890e0a21c5061b7afcd1c70c94dc724b251f60a08b08dcf092815822c064cc1a11b0318208d88c450d356c98428b1b42c910a6b808e360adc138e0600240072a082424049801101b9078880c8928aa88938c42096da3d0240d6922464b3a09a5625672c72581e2ea702082b8d02b279176e2c924306ec121561c1c4029a9a51829e624119e32cc02abb8d2eaaaace019b60d62db08012d64914d36adb3daf2f3084101958b26542f08c5a05032aa28231a4ce00243c0e23a11c5012691caaac41873cc0f1f26dbe0870d92b0a12193c810c1b38e38c22b8fd26298b1c5d628a0c008c924936d8c3d2669c594de765b4e11e0a02bc3cae314d92dff63e56e3080631b92c8e7ba42cab84181491481428f17e4f0e204276a11008f
UPDATETEXT [dbo].[Picture].[PictureContent] @pv NULL NULL 0x68ac586f8b5fa2b0840a4cd418c492fa3071a31704be012691081498c7063ca809e11055681e248e5fd488a6969991a9059d75ecc2aba60c3b043b0f12c4ce0b0930c8400224127809342dabea91471e18615c213141b2ec62891452e0d1c72b7e0412970852b0218d1f18f8924904228043812486288495226c7083810c9804fc012f97d47c713710c8204b20bb58d3c72ed478938108d250238d34700ce52598001d6cb03ef81c202e53c33de8d0259250209446d9d134276f41fbd6a35040b26b22761c7ac7551c18194af69850986b20540dc209094346c25704a0809235ffd662529a5e29961c60949d2c0cfb554579ee91a71efbdf26161e64bf0a8bd9b4902dcc11d822adb7e88e2e26c0c9f27222a90b81c82f73094cb950d42b0bf86a01175cc1021e6384776961324b58c1144881865bf4c451693b4841be6502154425602be0816a361009d8c4c68663188316b02385e648e139cbe998014e309c7add000674a0032c4cb1443a284211062844c9ea65a5e810e70656b38215bc80072778e13c90b05a34ac118840580313f581421ce290334cf0a7175a3042190ae1845f2c000ff1a0862cacc00d2b44c11ad68085816a01854320245b0f2c15d838b4b6b28de802251ad504e0a7a2048ce0453ca09b0663110b046cd20704e0a2ff1a04e1864dc2e9071190930fb0f4006214e04645b8403e9450883cd0e10477d35c014267b92f3d0073408a800f6271395d82c946f9f191ea229081c545600a2948c30c4e80a73c052a50b7abdd9f0435908d70020959f8dd1234f3909d5084220cdc085f3cc23c6f46e421ef00830828c1890c610f052a30a0f6b8871391b862279c7115acca773e46c4aaa02c71c73bd096870a76852bf593c755ea7795aeb4c158600941599c0540b3a86500b5b326073e61aaba68ca1515891d86c6564d990846826b89015be0779a785c508390918c07e19804e085a2849d99c85d52e8af09006c1e0233181c6a589984e1700f46b84173bcc01c29288738d021c0734effd0312948ac3b4d144ec9a453310594953bc1118000ac00055082f2106a8c06370e618d5fc0a78d9888c320a0008528482d104b2841198ae0044158230aa5e006d30eb1c72838c11ab538003ad0710801a4ad5f79020c6934db2110d14044c4038909367422b7c12d6e2d9a9b8b3228084e22c0189d5483259ca0062a903216c630462cdce0a66046a00b8803930fa8a48019d800064590422010c02530f1727305c01c02f283b83285e90735b21ce016c7ba29a4210252a0e7d7c8654d90fe492e24e05d28bef9bb2414c184947854b73eb297e471a25076692712d8414e24c84e262d8d49b56a72939cb8c29dad7a55ac8262501c10747a4901c33b90a00aff0b84a02b118528dcec3751ac5cd4c386298b47db222d01be65505e435544823a9abfe4e12f312960363f0aad8e4aa5823756cc4d23032f232c41015350041ae2d913e259082ffd6aa1548eba02d7c0660363682a0e7178857cd0a1135fd8cd174ca11ce500910053b041c48c739c281291ac748a8e759e280739bc558d7b8dc61a0731b3f8dcc70d98c06b34bc30086e40010fbfab421eb8f18bfbc4210a5088ab05b8d1e73fd6220b9215003beee29752cd64261a220841bc79b673f68534839964dce476494caaf6046a48a62e73'
+N'7ba635018e01b9956e04aecb4b0668210d7bb3410a08e0852d468097cdfd51e80ae0cb6103099919a82ee9b01bec1fe1ff620a5320401aa670890b781a3081f9d3076e472d0e7863c007b14b34e1508846a14dbff2bd5003b3d511437973bf69cb5004c72b1301a3977b399908ab36f32a7e97af7c4e61c94ad8a7820a5ff82aa6b55fc2b1128f0f270bc486598b19463c98b89cb826a80a858139118a70b918031e178c8c650a717419c62c161840857dc5150b5cd0061b7cd7067ca0852580d900ace0cc09b976647f01ace53094610da12ce53d5cc1a9e3a6036f78f31b1e66ec120410c5738ed355e8dc203a1ce3d872be0c3cee7c41cf5e50630ae00c0965ccd90af719e57e72a00c2b0ce21090c00320ca50852cd4020fbe28ac32d478683ce041afbfb0463480800e2b2c0209ff29c56cb534fb1753e125144246db67ac374178c46d04a37651a95b248f10a4e0077fb3dc6baf403a2d5cc1f4a133dd29b114b825144e0d3e50430a4e8007350057735bfa91921880b902d8c80dbf4ddce849c7265723c00d33803601be7b0182bcb8e2260e9479ad4583505c60115f4e8302364506e2a5cd2e955ae10a4db0bce5193ea87908305ce042adec5d7c9f05de49f8c4473e81fa9bc1ea534a1060d050159956d423d030add00a63f1b0b2408b8e1ab1b520b141d99d7b43a1d1a8a60f38910f28aac2a8a04950390caca01040170c4c971bbb310c82b9833182305b0e118927eea3882c38b27f9911c6f083184298a62a3a85a9c12b5882888180ff2f800008900208d88d4eb8040f608e4b080e03508ee7b012ecb804216c8e29001eeb28023d83022708042788035ee30627800442a8855f1083517283fe700239d0b31450802a60850358042bc0835e5083f6708138d82bbec283f75083ef40872c40820bf11ac62b159a18085e20888380bcb4b98bd1420167b10a76c9bc042835d592871848012d70ad57631249980dd3fb1163c8aec5c10fe2139c25f001de5a1d1b08846162255d62922e298054d8bdd0b982535a2edd1bbdfc683533599cd679a63480814362bcd901943d09a9f3b28983e0042978b624109e87e83ebbb008be38b223038976ca820dc1007219af6a513c7bd38b8fa808f0d98c127a15ff58a93f59391f8063897788815fd130cb8b9b7714c07a20c06531b9c298b88f3a91f51329f4da1e6f32848dfb963c9189b7188cb598040dc44078f0955f99078684485f9148966bb90b7a0c3f908c77799732483a29a003ce780789b80b1654812230aa058044d7a080a66a80316880a28349a3bb2a03c0188ce18d337042533883e0a82a8c598eab5384255aa2dd2000abbb0e4818043c508634c0c268d0ab141804c8f2236b483b31708243c0030598bb565884f0e08614a0ca5f500665408f3b4ca3b114836818055e90b4d8693e820c46c6eb2c4e20034efb0c1a2044151806ca5b91517b031e78833780c4179987093801614a044f2c8027b80249e044ff20212606f88125e0912b601365eb82fc38a514c0034b009d39a800d48bc502d883ddf3a530f93d5764802bd00259fbadcbb491d883b619a0836a638507623c6ad9c7f5a3098e4002294881dfc983729b08bbc8084e088d6934813cc802905884d1c02709dc4db9604081e082ebbcb78af0a7563109f259307f538a9408384a88016081a8fab9bc15b11f8aa2c763d99f8c4a8b101020059c0012abcf8a3bafed31448af0430ee1802238c842480b7451b90a8287c44050c4e08a79e08a883c8d0a12c1c7880c0ed2023f08b3325000cd381b15b4afe52c0d256b8c1822981aa2c12bd8831335d13130029bfc0d2432851710ca26e2c9afea48e85080e24822ff3a308526ba0ee38082a8710227d03b58c083348202c8428668f0b3518a002ab081b9b38d03c88203b0bbf7c0042a7002befad12a14d22d58036e408845b80b6b8bcbbfc8909ac80b9de034902891bec0a7134996461c351ec024c02c351e58017c88015970024c483506704ccb4c844bbc1cd521c51e619344bd2ed2639d1fc80062a8006073b5dc0393ccfcadddc39ceb42541fe12431c10302281c3ae82f70b9cd81f88b0e793ee9b337f5828134488234f80013323744dc179ecb035e300190881dff54bf69613fbaf0c76fac88ef89bf718c277e3b47f369b007638920284f897a47f554cf7ab807fb2140fd110b881b8023308b23b0cffafcd5015321ff9d489b6cb1369990c0da1980984a0b892416c4589779889b044d8cae08c1a459810de22083910c3800847fcd074328a113ead09e03d1947c0d1b928d975418854180a233ba1b9818ec688556d080868185e0b881ebf00ddf080e2a928ee5380ee82804035000354285200dd25af0823402a32cb00248882b1fc0841cc8be2aa0030178815ad8d93d9aad4d10835fd8bbbdb3c240d80228608777000983c8b43215c4b549af0bb897a5ed50f1228c9493a839fd4b2c00cc17a99b22808138c004d3eb803d604ccbeca45818d4418d13be71cd64b291e18b8025f81c568a5457f39261f3a5c5e911611b1dcd1c43c96493d6d1b53410553f7c8933bd36f2ca1dff40b1376f6ad55c5384edf30ce31c5310694e1624c8c0a016e8abb760d5087eda4e3400a89fe837fb7387f4491f467056068d4788babc004c38fd71cf665196b6200c023a027e34c6ed91017fa2088de89aaf89207545c8f86cc8c4580c793dad79655006a5a919b1c87c85390eda003880922118026fb817b4e10416e485a27ac116610d825949286bc9968c49141d8325c807349b821bc50e89f982245c4245b80e8eb15f22fa49e8800e35e2224b500328108f34c203c8d283c44a81c988801928032bc0862620045878012b3804befa85350006650884c68a026510d2200d043c50a88d3b32c52dd333059782900146c101efedd0aec94650038bcad35aff2378031cc682179187793801b88b00d05b4c411dd4d77aad5810835d8b0327d099db021cb45d9d37e9251b213e56fa925803be429d45371184d241003991b625c8833e2c884cc32cd2c0b66c3a31bd40023958461b6846472932c9fb165c5dda975001541d46fc64c08bd34f6ed1ce91e80993e8ce04231f5949dd834a8a45380d518b56d9ad566361388b320cffe9d68f122069418123e036ba30085a68e1ca35576bbb1e1963570e34505f61dec560971590870578de07458c9fcb57eaed31eb5d8821808357000443e8094ab02c178ba917a2532c209848888d06d88106485f1b84d8318003f64a82198012404802285a8e2e938e32130e8991821b3500ff0838c29fb481bcb2014b58232f4a2302880339a0d2685800e099842842cabcd203f558b434da849a1dcb2b1c5a27788f130003493361f4129b14de1d156ae1a965b723db107cbada46d6da62e6012cd8e118610c3cf0822329bdd2fc1bb51dd4e25b1d0298adda52db64ba1c0480bdcaf9122049d45e322659039de8ca4c990e922ea082198026313ebc06f29a788309413948f32ac40b10000300b32460858780afa0e29a0e6d4efb121b8f83097ae3b67ac3ceec0cc7ed94bf428695ef8c9544fe1446f00746961f78dc30fba9d60ed31f65c928119b4ffbdc64fcc4804fb83816d6897c39a7157a2052285ec23097f8d44075392d5776e51eae578944d0ff05688c5af6035fc065238012ec7d0552d88c798a9d3c408118988403959b18c2820da000644ee66576c93dd8c41ad40240809285a866e09118032042ffb518e7e8aaec40c2e6680e2554002eec2bbd6b02ab7182bd716703099950a83bb07382411884138886683881bd62103c730165f805807682bed36e2828e151fec360fc6982c06b117961442c08199e6114915348ace88ae6dabf54ad79480127b0123f28bd27e844587b022161802710935bf3ae647ab5dccaad0810e0c3696921019d5e62a6cc448062fb912b906997f63d544a03312603eaeb8b70d9dc9003ec8f3a3113408256680e03f003f7a204152cce316dce943a68cd1ac6eafc0b2e38c6ffd0e0a70b185dd2e58cf139dd7f63564670803c588c78b8bc2247cfaba856dafd3000c24769d9d6fa14144e069491b26bf4c26b5609de6c194882bca76cfa70b64017865c50793d6cc47e5e869c8796538c0c6aec8bdc571fd8e5487885c631043298270f258c49605e48c4022338661b6a49d3764985313d285b8221b0e6f8fdb1f8b581ee204a0328032002a28bc1180f00c212b79228b002957582e0860435728203a90555f8003a580420c0863412523ef3b33b24a33510831c18e12838342f902b6ef08228f002f85a5abec6cda73d158e1009942003aa9dc6b5110ce45d11d4e2da66074cc1c4681f68bd5cab8cecc22d63d86ffc6e12233935df9a54ff33d92dd479f061eb3d1bb13dddb3545ec29ce14b54360926d8f381564003fbfa162e78daf4be5a3fd9a670f95e2702b3c9858822ab467affdee10d46c5a3723fbe094036305629897d33dd432e9f834a9f772802563ecfd8ad9f84ab8a65290b89530bf97c726f9d6b290fd7acbe08d2ad5c060a1732dd63531e390d84d71ea6f97a85dee785e50c626cc676f377916c50d0de199881a566875010000c30c90a2273849da11d4066975466d36ec929cb217a898e27820e302b2b277a222b294208982a489782df3883dfc81893c50658080439b104304a4a27b0849491033af800522004488082406003108e02bc2fd20f661060c881ab8cab3db3e0b6eb3bff4a28fae51948d9613cbff09abc08656237ef13265ed2aae1b8c9bcf6b668aee5e115188319b050774180c47cb5fe5e4d2761cd1930925cf3ad4b059c4d0aa61e21f75b3c9ccd798066f291d31c9d2021be536a9d34c80232d0f2c40591d250d70fff136e0209aba2c97268144d09896f69ce63ff75334531df05e440dece7cd9f188971558b997c3cb82cc0e0151436b000cc0da6572b450c091dfddf1aab8bafee97001e50bc09772ea169fc64d8040c101c50482130e0e983060618886f02cc49b2771e2440bf3e2459cb740e38a8e7e3e1af161c4c8920d436c4d7964ab10924559f2a8503809de3c79091218c1428142a40d3b1afcfcd960ccd0317b8cff8ed960c3c0941b85145d3260634a92240a14d8503045810129101419f070a3eb974ea6ca7ef90281800d3dd1d4588a93028a1e2f50e2c48524e5c3073a7ae2dc8da32c10942876f14409e46213a61cbfbc58b112edd0e468dca078a1848453284e344c90004d020369d2244e9b30c18546e70b68c0e020c3ceb3e7d4a979615061d0a1bcde377934c292f30d96373757ccdb5040cbc7343edc243286804181020cae74c1a5450b9c08696c80f7d1a53a0306b1187471de85c1830757aefc88b0befd03eb5d7e20c8d0de3a03045d10000860176ef83055286470661b68b91dd4e000933cb850411c606002279c64a5c058079241091aec2071c185ac5da8a0ff68a7a1781a1724ac46838b325c10638cae2081868d688890231822dc02468f22a08184097914114308162cd09b3c2b24b08292f2d4032594f5c443651bf0b4d14608660cc0e542031cb1d011131c8182407d082410079f6040c2272a9a204328aee048868d218ef819170b96c6c1401c34e8600c5f8630c0910fd194914411c563513c1b71b480472085e4471233a8f4c8230a7426800a454c60244d4b26c083113c51b043243bb0fa1351ae8e31c61549f9d155569328a2c80d545555d55652187009b0c24a25c517971cdbc91706306b4334903861095b50c871481c701150085f79c8110d14964440855c50408107b9cafcf28b1a8288918361830c0249ff64d14483c72194cce6592834ecd9a6bf6da2089a092e5e50236cef0439e26da79166a6422160e45ba9c21187050f6ff070933c0b5c5180244b80e7841a98b8315d794f20200902b874d1051cdfd990c67a05549081c93ea4201e75d72110017e0510d31e7affb1a71fcf2d03d8df7d3ea491c6226420f1d967303938c9911658004fa1094de00d065c7416731259a940899d2022b1d9859c64f1596aa1c18d221773b748830c77cb78812137da98a3dfb788003527794c80a493232c3942474c32f9a43c23d4133995915fa9e5d65b87993999660ef4899fce50f8a6dc2fca8084df41a62da20c2eaa46022ba391c6816e07116490420a0d6a28d6596344d1ffa21759b480f08baf00d21223f9e2c71428a5f488362fc534e84c35dd9413051b44b26aab40b93ad40eb1d27ac30d57255146216329d02b560ad0610a2cc84665c053edc37fac540a78810701721170422131c4c1094e20c0074821805a58010a8388000307c10627942b0a7170811ad4b0854d88410c4e1804360641afc81c020f72d00c123ae3361300cc5fa381dbc068702183e1000c205a9b8270939bdd84001ef120550230f6869c58cc384d92871f0af0800e686109038cd60fbaf0849d0dad65d9695a1ae4c39e9a51a70b4bf04104c68000eb20203e257b40d00ae09ff318118cd8594f7fd0c340a6996d119d014d4c423589dd590d421092108548ff10b6252401902ce9906cd2c699b571664f7adad3dcf8e548bbdd0d4632a2119d6ee4b71c0949052158d2e296f438c58192718893d2e43052b910b4c10c5b0a1398320726149409966ac2c09a30203ad4ace66ea60b9c9d8214231978c645712b0d2d3957906322e461106ac8ee2292288d6884511491d4a48ef7114ba1a40c3d30001df2900755842a0477c407934a752a9eb46a7bae4ae718b46004e55d257df1cc870dc6b714a928a215a6788129dc27855c15212d67b8044121209532e4637f6cb9415fa290026510200b028005242408053588210e6c5006142018054b6cc2125bc8e01ac460890d42211a7a80851cac400d55686644a118188b4ee43affd490c0452ee4c405c8001b3008ee02ac134d1e4833bb42e5b037e5e481c52866b19b242039696440052da1860868613d4f7c027658e69f082ca1693ec0057bd4f180ebe08269e2e1cf1522a0861fb0476861cc4f7dc098b400b9c1ad6a48015037031a5019ea410d09ec1e13f2a70ab9f0048054de3c0e8406cda04d6d9c488d4e5ba8531ad00292789391212e50494be6080d935505473af9b815282e01bd492d28571ba5c961294b85e2122b8f30a6db92692047f0d3273cc7265bb2886e2fe2048e7264a7d48948a8ac5b11ec72331033d92e500bc95da12c70a41cf26e1e3481e63c2c82358948ca0fc5e381355700480370c5008a60850aa2274e7848ff8c073b49553a593586ef694f0bdfdbc006b6421540ac2f2b3628c30d72753f45b42fc1c22a84b1e04750a94c21140218600a084087452c020a811060b7b0810d3c3841196c08a055a38018c12843105400460e4896513cc04b0f083c8405ca66c860be0d85360d8d2243012324f8b418b149188e17a6020c18c45049e52153dff0432c14e7380bd8405c33108b08800b175a66c013aff39f276667065320400a22c000fd58e70a5a48812fcc0cc61f2c411071ad4f7fa6836635d61940de49c10d70e08012126eba566b88d57411025d7c29212820cdc038a1d829d82090da20e487d0b6084472460699bd6c24612449bdb986467c0b120d0867014e3609b5ff875335e25aedeade44a94af0c0122a07902543656e4cb0dcad2c79cbdb36dd926eaba1058c7004b85efa32463e76d19ef8444b150c2450d1e51a751b22ceab296a2290f2ee3c5620a9045cf3232b48c21452c21545c024260bc11a39abb7139fa4937badbaef0ef4eb4ef04c010e004e6fb3ca902b6071c5df8a0016b00a4c50075f82004978c701289c82563860141d8d8bb7a230883808860a96108413e260e2c48458a49b708318d6b0068e4201123246a02cd001b54bef6ba8cc4d91c05403cc82f914078c081c9e269b63a322592186d2617c79c054286301101953ed029670850c40dd180cbcaa96afc0e595fda7655756039923100bba5e470bdf49ff037eceaa0506ba2103413bab7f10509fb3f2acce6e4c810d8a109b50d4517ae2ccda4374a1b52f15442088e5842c92e08725cc600674b0936ca076639e02b3d39dbe802425e90abda1a19278328126a9492a568f20f4ab7592524709ebc855a9725d62482b6f0b4b0ef0da4f1c005d2d6dd9a615cd2db3c4fe318f7889ba1865fa840c33ea7391195d07b19e2184e6dd76372691dd4d8478e15e4156b682de6eb67750efedf64d84c31378d7b7befce5ef3bb3b204402481c1c052b8550a2115f4328be0cc2a021deaff053a5c02ff52b0c1220400d114a4002c04c12258012a9cd42090cb205081182803156c8132588313a48004c5c12f58832560022608ff82206082186c0160a8542d20901564c13b6cc61c0593f0890668ac8609b4060c31425fe1c90971411e8c869f100443105d39f590d13515c6dcc43cc4400cb88131e8470674c10c2c4104b04c973d8114c5422c880115ec8f2550811bc4427bc0c70cd05d0ac095193150d9c9157e9c199d01c815044817440078d0010e5002d54c00525917dfcddaac21da4208c491b9e0051cc2d88cd91428029079886c44d666e48d8c7c5a8c18822b2c2222d6860ac4c0a9114f47b496e989dee3c0dae9550946c0433da09296a8126d81c9e694c99facc99a780e70bdc927e01e176cdaeac4081afc48e0dc4988fc526585469f401b7405caed24daa0e0cee53013d6f4ffce4580577769dbe28897b865c523a4840178531de94e4d300953bd1b7d855fabf8c4f81941f5f58a5578e31270c554dc1354c08f14cc4ffdb58f2924dc0d1c402d045085c1c2011c801508501a8c181b8cd80585d416fc4220e0011e28830b288332602026ac01265041066e41ca59c10189e02298e066b850cca9864dade070e11c6c30823bf09c880c55eb14d5ec3c8c0eedd052fdd01b500094f550934c820908401488410698d5134440e231a11301c81318431402482ca8411a60a0999d95247441819c800fb81d0388dd73ccd9d050c70364409a05887f14481ab4020e9800a8e8dd4cd4213cf85d1d4a88e0b5890920c10d005212a4415570081940ff8de3a50d721d22a8ad0e0d8c064144a245741b2731c9083489e961a2943c49e44c89acb5413dc4163cd85aa2d91699c4d240800ee8f896e73883e8b0a28ae41e24f1942cee88ef21c1e5295b5db64e7315936ed44e327d49ee0c0030264408681f333d04464404a4d0a6465053f150df02308b4a9441ba01d6f4e043a930d539694f36eec0366e0049288f0d281c78a4a5af405aae444554000b8281850d14c253a0a3148c45b911821e884c1a10801cd0a33d4aa088152448494348a58b13988b13e4800362901830e4159a1424c0c20b88602d0481091e920b01a89ebc0d8f51969c14cc6b140323c4a0e3e589dbe0c60d9a890ec2974d940ac6205d4e64ff4c470c402864811550412c64400578cc4dca4776f0ccd74d0702e4151761427974cc15e002c85c5579e0825b39a5d0dc87c998e11a7dd50df0df221c84de61cd577ea5a1dda199309a597a011ce81b93c20129a001e3c9066421013bd04888
UPDATETEXT [dbo].[Picture].[PictureContent] @pv NULL NULL 0x80a65d12c4912449471cc771108fe23809e9290961424992c8c326c6830e6189d6684d1b041698b49263aa89649e222a6280339c46b0d18da645528cf0888f9c8e2f850830e1220ac5ce2e9ea674ad2643f8226a2ad9306e97b671d746789bb7d9006e72c523cc8002a49b328d4a350a474f18e771f6c4065ccf48f8810d28020118c0b2f800b9912301181c1dd80f7a0d58866808b3945baf4e811e70430a58ff82783ee40b580188458b466d81356c023088810bfc23404ad016a898180083306420156ce037ac0124d4c20b0800b852424c659a8fd5e522094c4dadce0be188ce752418f892c27c068adc104238c40e51a80f1e1d53dd043915411e2c422d40418bd6072ecc0017e5241a26427e94871a02e05b95c759b59558b111d3a881521a4d8e4e25dc6147dbfd408148014c0ca160f99ddfe1431de24358c203971c849fa8406a20c10930a911c0412480c224b865ceba658dd448b2d9e504741bf1a41a982e8e5faada6a0d669acaa6d2ea501b58401bc4c395e41052259a84944929ce9eec810e2db1099bec298b04972b4a5ec1f0080e00ce8e1c972de6496a30ff5769a080691e1fa14c5742c4402ffae2b57d97b66dc4b625e302642aa61ad41414c2a71acaf494931100024f5442bc859f1124e748bcd30dd80f54b085018c8541350b7a8185fbe19bf52d454a348f018802147043c709908ca9821e4441b404421410e42f6c41490982c7f902880582326cc2420a03b66aab2034eb3738c13cbee3018ceb0c7282a1a6e045d21c66f9588dbc83bb32c290a9adf01595ec24590e115dbe1607103999c658c00d5c5816d482cc54874d261ecbfc07029c47065047cff8c0bacc8c7d58eccf4c6c2098d954064879b8a87fa46fb8a4c0092842577a253ed4043ee0433c9c6c1ddee100bc6d8598a5cc3ae906c001a718d24c8dff644c1884e10c6d397170931c8727a196e3a4a9d2aee9ac558ed64c2d9c5e8ee63466ec7d8eecfd96d7061b6666e69fc688e980818fec4894c225f055d6db105fb421d3edd42deecc2dd748d7c3e88e5e4ac4a5f22d1387570a2c403e1800044000f621c4005804e318dd4890eaf7d4977ea12ae4bed30adc0008b0235304d85328c2b2a87156582e8459df6e6a0a04f48015c34b1c04c2fe6083151c8315acee86a14b14a80b26b0a77be241baa818152c64ef5a030702032600431cd0e32204c1b8221280e298dba4086ad80d4f918108808182ba430ca2cef1d686b399a6d0ddabc44c0cc5640c0f38c90278012c08804425e552a695cfa4ef5d9587fb46ff801bacc754aa19c5fe7258f9005cf5871b90a1fe1e4d187dc7105e9b57e683011b706fe0833cc043022be6001c5668c42ce28a5b47c0433eeca597fac14d8c336e6e30e3881225f6069ace039554c9457062094fed606dcd97e096ebbd9eaf9546d7da1e9fb6e23360d6e4dd708fcc222dcae5f1eecbc0ac489f40d7f139882f02a3ddde4e08c8c483e4ed6d56847721897861aa225831162b44d650234e781ff8851ff6909faa8a977a81850200021ccc80fab0ea17b46afaf44ab969ca4f43c023f48050f7405197c2c58d581c0c0237444600e105ba54a0355883033a4114f88213fc820b34b2426ea00f58c316642030acc1263441108c0225fc99da68fff20fa7eb0a85c68bd40819e04029977231a4ad43f38b09d8503165b19b2ad54d5828d26181c6c44c1c48811cb48200c8811364e103e0c25511cd9995c7d7758118042564b34701d428002aa575f84020a481207c917f08b3c9b4d1d0ace10dec1d3c00e735afc03567337ca56c3733b01e86421e142de3805ba908a7d195ca47a49a3bb7f3aad9843cd7c3a224ca9a9ed29bd65ad526c4986c8e9acc521f01979b7472d8aec833ac86411ff4ddacc38c'
+N'e0880e03955bd6a22d2e9b803697a21e93ed20f1dc3e2a4637aad57c97a5ca037741df7cdb80df96811db302d50c0a4470120f00c2a96ca371f6040540aeb8f98156540520cd00200c41849fc41494ff8154f4ca4d1bc02364b815ff74517b780f08461c182001705089a780c85882415ac34052813558e00432f20666e00606c2054a75071ab213bc005affd9a589880bbaa0d48c66698cc66a5cc84676643128796c20178e45349291e497e85036dbc4c50c272cbf760aa8c10041820010091e0842c6228d69ffb21a7a87fd7e2103c4a80da4c0783c407a68b932dfc7cfeccc74b48c0fdc400ccc8439cf4336bf360f0667360bba767d899fe4624aefb6d1297a171b9d1f648c4807375f368e522949efc8e6ac4d2d0a3784a1c5a98490c97347f70b830e8a880e2f74f2dc80ad7667e6b0fde977d38828ebb071a56ddec8c9ea0ce86828ea4453744234eaa05cff347c1bb1166f179a6edbee608ddf7adb3c14420f8000e16a714a2b1d7166e3f8a5aa11f08048834712a05f55d4b4b60302fadd74120c01b9f5ea237840158385861335b383400f94c28859425c0c42291c35b95c8b0589948b6fc21ab87820f8823568e0060a821af802ecbab8326c015853c12f40c101f8435ad3864e25af6810539b30af6bc8b53be04031f8030ef8435fa94e2a0f1f2f2a5ff6fec6d1590c201887b75d219679010c1441119c801ab8dd03b49d33ebaf807cb60f68017514405bd15d047c1103e08c0da8811b280d194ee52fffc00fd84024ce039f931395077abf2ac9c99e2ca24d080a0cc0029cbcd22dbaa988bdd281db247ad2d92bff494dd4c4466084a33884b5757ad5f63399d04e9d9a062fdcd2a99fc63304172f081b2db0ba0d7b160eff08daf6525c52def19eeb30415bae2faaa04808afd72d1263342b43441377db02ec4e08dcc07c0bcf24b85fb3e75dd6a01a4e9c4a242cae36b60a1c54021c40eeb523c754f0ca8557c54dfb2ab96b8a2830cbb27cc150ab3bbb8380066854b4c4451c44c35223a00021bc18e4ee2fec3bb45ae0bac8b820b8b815fe428839c157bb00c64503119820cca5e05031cc9151486950d646ce75c7fbc3c71f57720d1531394c5f77220f258070409910a9961f208031b80140e44823a588aa2278dc6428c0000102060f1f3a6c18214d0a1f0e1f14b89224ff8545041970a5b111e847c42eb1522d5cc8a04b841b31f2cd9b876f053e9a09f025d0b9139f3c79f8e6c1831762c080493275f230c2c30f0f1e809e324d1035c10aab5757c85b20d3e7027932e3850d2bd44208b31606102dbab6e88401138e4c400117050a0e1cecde7586e113060c247871e112980497c282b9d02a7c3831171ab4b8c8902ce3c2857595d1201101e616183022c884ce8ca43227199c68a4a66182046bbf18ecaaa83b77ee04dbb6dfb61d10e3addbdbb66bdf7e4bd442f1792b16ac9059f66cf1050b8a17820002830adc16e0c95ba1d308202314766cd8317ebcf80de08da437727581010353141858320350fc2933922499f268cafe47ff8f4479c400082050c4bd4720e841c11e4000a10736e288c312279c88a31428a219844227b6d8420c4c9471c21a175cf8858a13a9c04490142df9c589400289220e28a2f8c5852806d1631407d8418213d4383141c821f3f08b0315eec28003125a0b851324d000a39862fcf10c8c2ac9c8acb4d48424c1c8ba704b0b9e79ee9167a737dec082072c76d26a830c324804018a4e28a2881304612023861a72a80b8810f0c10935227068a12e4472c28d852238218542178ae54f881eeac207182c88e9a79a74cac9539e709247285d889a47bbed78d82929a89c9aca559db49b2739e5e6110b2c78e281c78236ca2aceacb480d52d2edb8ee040ae62ef4a162fff0e3ee1e02f26991c4c3013b8107230d61a838c161a224b4c065a2ea0acb20b5c81b2331c3c2303343446232ddc5064e0b25a685f4312cce07e2b8a376079e36d027f63f84d60b742b040d6e39e9ba7b85e17f6b5901ef2c8c3ba18b03375bba98c386f8348c81b2f928dcf536fbd156c98a70c03f89b2209fc0a71cf0695fb9b4294000914d0802f701e7041067986308e0de318849b52068950991631c921c45facf945995f365131ea4db698509910a1c81a8a08a1c08690771c4062910b9c1cb2cb7a954cd62f5e527b324a1c8ab1b24a2c91708513b2e335ec3530c3142a1eed76720a8b3700d909b992327820030470b1418a184eb8e881071802b421ff96224881804004c1a825356cc8b380464f48a324967e70a85204ba4881e2997cca09a7d941adcaa6a0cacac7a7ddaf3233a9542ff64327ab96abb556ec9067d82ca2429884adde04aeabd8bc92fdc4aeb45feb0bda68a955ecb16a05631b7c6e69a16532712b73855c76d40503dd5b44008d0c24e8bfe06e78575b6d5e268db47736b9f2b59bb5c48079c3e9576e7c33b0a24cc260b2a255710858b0858520068ae8011d24e616067e65054ff90e0538d631f3c0810214488f5468358f9ac147657e88cf0dfaa31f99cd0c410422d0171844a00535a8413dc85a209c40000244416b8318c4d69866224b3ccd1a22b2c6373021064188816abf0884d3d46009ffad1591100e0003257c841ab3b186177e99cd19ff62021ac8004aeeab9203e068a5f9d58f6cab714dda8cc516a1c0a3274949d39ad8b49305e0a173702a80a56c700347b981010560dc0fb4d0a72eb0ce071d5143493282a834a801010fb8421a6e10ba88a48e52577049086252938ba98a959ef2093c4865b1af8cc92759b14a029ae28712086f7859614ec19a9796e505eb7903bbcd19a987c7d778a92f7cf9c4f6a225ad6a41c604d4840cf91e63bef38dcb15e562d766de97ae2c8d665c3208059758c31a2f55c78ccb9a80b16ad39ba2306f79fd22cabefa15bddb1090810d5458f32c4031099665021fb860060b464b547d2712e0e9d8784ab801f530ffc52ad0894fcd52a632fd2461093294d97f6a68c31e3c62a43b5390836844a11450688b4674c2d19ab8c45fcc940a6270432f36e1064c6ca1891192d08c06110d6e44c30a84388003de413f310a891726c04091640340b9d4c5596a7c9266e20606386ed58b73ac4cbcb87547bc082704ba108a4f9232953401e20d86b3401e0e1108377c047327b8011e22b9901ffc609257b842437ee0031b8ce44f1989801a7cc048066881002708040216723989042a069388dd763ed5ca4dd5445416cbca2c0f76aa550eaf2a5951586fd4e296b51853aab5a10d5595e52cbf3c9349cfa42d34057398c0502bac6aa445357d5b3e6d6e337dec62d7b9d0c599d064a97effa639a7bc5ac3bfd71cc92e28900d6d84834f01de332d04ecae007d439b0fcc65811254d8049547141414e10bacc0c0bf06d0c0edf8e183e221cf18caa38512a607107e209ec26c902003f400658f58591214c0c29719401403b221041014e19df550415973c2842e5c8a2810f1881cdac22fe2f08b168d680dc2c8e91431e1222242611090884634f4508b5a1ce000a3080218de41891fa1260ffc73aa0a800c1ce05817036cfb5168d005474a3880124b7e4768e8889ab0ae132fe49d6776d0aa2aa700020b85abca07b290055510122288b2410a3ad7c82ef0b50b5df86b9b056b034e266e4e3ef0412c1c9906479d8e4f11b982eb66c2a9049460278456ff55ec5e791c58e54a2c7fb3e52d216d95590e80aac87ced545f5be92a6fda5949e20b34176398dc228631dc0aabb61e931a54c78bb8e973051a5e0d4e1c84337ef323e769e295ceed4dd748cbfa1f6e80bd2feeee462d11745e087ef3ebedf6b361bd0226b22780015344cc360cb418774af850f27c2c1227141e7264528887f16ca4fd99011cf46303f7b8c7866770f782486a52072d88467120001e2a140719b1180a1cda041bac118816fd620b98303826dcb00527646da856b0422de420631a6721084bf647527d24a43cf0220f3fbe2ebea6ea171a84e2024820836798dc6495ab5c4b95792eb57a6de5a29cd57781fb6302de00bc1bd021cc79400844ffb4d091ce154023b870b324b520128f64f2b0796240e64e70c98830c0af6d3ec151003768566abd534019133cb6531378a4a538f13015ef4e653bb18ffd9dbc56129290742465c15db64ab27bddbd046ac42026ac8dc99663b6e518c0a7da7cc3954c652e432e287d9333b3761f67e4474e4e9cb34bf46267753a5d5dd70a2c3706fc957729c8dd801d538146310bb37d25507fa10003ad28926d0a2693853a743cf81d8f16362051fefaf78137c02185336a8b24ac9bdd978080bb917f061d2668def3565087edfd330d6f98c54edbc2d39c20626b58e3448288001566c4e2a0cac10ae497832a644c7107f8e3e23eca820938ce242007f95fbf228a5c5480ff011338090d275772c5836011009012bceaabb884caeec2ca4240a1b40ce7a0c2cb12401e12890e0440cc086922d2c007488972f60a504c2905ce2c4f280717ecac241060091cc5071ee2af58a2256ec002684276704e270cedd0444557b4e306e5c2bcb6222cb8423b68e22782a22864cbf2d6e935903009d769099f05b7f60e9b52ed5bb6655b546d0aa790f0be250bc1057dd4e7d5be099c1eaf333683b948c33452637ffe220965eb2e3e8e6f384fd8886d80e8695f582b4c0226829a0d2dfc452efca2e354e0032620f600e73b36a012b42d3c42c608be6d2b1466120ae1f7e64d4040ca66d44d3a2ee10c7ae00c34a0138e2f414e0a0434a04130b107ff20606b7e66a52ce467704443acc8696aa443b66045a2886b18ce0b6441160e01170fe1e12a3008d88f0c1661f29a8a04e6af0850206096e797de82f5accae4b48a1282201a17611aa7b1e2c0c85dcc895ba4abca3a0f57c24e5508074d7820e786a7234e800e5ac1040480905a2203f94a4f308794fe2ae8e48c912827027c0052b4c006a20eb2f804ce0c26eb068d074aa0addea0066d221fca42566e3004ec8280b0035774654c92c354644257dec259424dd7d4895aa0c530402d24476d5aaa4535b645321ee37c54722557325c5c32f1148f5dd44504d005073a83333e437e94eab9f627ef784deeacabca7e4db586231003512d8045f4de62f438cf37ff1088d81ae657424eff42a13a34c802e2613b0831841e4af7bcad2a96e3062601871864de12641211c4000c0467cec0144c4102400013cfa0f934a02e41514120200e9421052c410d5e64fad80042b26fa640ac430481fbdcc00d2c2142560c0ff0206b8e881b5a0c166a81e2dee18b38e1fd4c4062822c06082882e609582620ff84e402286133982c0017e10016a11ca83100c9295c0e1001f3484c3c6bb4b66c700ac72af0d1718a200f2c500d32b0040de50a7e20024c42cfe4ac0b32e23805e14f100094f0e074de2c738e222708ad70728e20c7912760494c968728ee6212c2f397e02126c624579ca7ed984435dc538de0537fa88535ec685e3a127cff784b30ae698d5af2f028639b00d434fed332b8a99b64327e3cc3f1707233d6a547c2256fd4a98cf2cfee9484f5f2029914c85fee4f80909143d322d9b20bbc7e03221b2660a8ea2f42a12a8d85370ca6830081f63aa6123e463d9a02dc1486620ac1821844034cca861c0c02be80404ca12e25002e1d242e4fca2e91b41407c1129c7442ea6da6d8e06994a1446a24456aca0dc4e01768040a1cf331b7666b8aa6c5a2a116046014282118df6ffe6cc33305883c9bc72c6ea3aa9c44339e51351721cc5af30082c035a32cd768601b8d45b516d0ec62e74c720e0b06677836e0e944420a78ce04e4c051d2600934f00a1a8901de9175282204e1310240d521ffb4e004224722aea00bd4a0452fe629722e1c0fb2ebc68e819e87f586896086a33826522a35d23152c33f5103acdc337fe4458df0b35a78eb0c558d3ffff3f0c6a5599dd559290326c9a59b160f0de267333a235b71f216d405caca503e7d12096323018532809cd256bdeb29ff054401a8bcdae20dc90e984c54234d40069c0a3750c94cbe43db2a810212512afc6b398ae306c68ddc4caa476de80beab22e4faa2c17966149b1078ee86808402f7d8a4224a4455c60462c01e1042131a174c33096312d16c4804a0ff8140934934dff853796074e9707fff48f069e04e5a4b135b3e000c22c0b46214f17817eca10acc42a0109758f78e74cd684cb52451eff7e407150d50660800e42c10454e1ccd220023a90722605018c5324a4ee0102e52258620a622005fc917552c060724278c291add8044d3a051e8e0dda889004e26b195d0b05e60929dfc95978953f2bc35decc77e2623d5aa2958111771eb15409f959bd2a7592fa30b0d615abbc90b0f944171d24a708041230f0dc66536d5e908e3ae0d85238174435fd422f6c8024e174621b7830294a0011a201222210174e15d81ad39ee8ff55a830690c004c6ca288e8307b24ddb1aca84fce0db8807821cb12c0fb661f1d247cbb287e8f26143f1ddcea0c308208828e4c36ce46a5a441968a4a66cea07a8c009a280429ae66ab08f302dc105b6200e9ae0a8286165ff81ec0e89833c59f79e42ce047e841dbcc8015453677536cc0ea01c0e4002b220149acb9c20c3f296659ec8d36ffa08555cd5cb56e00732a00232c0941c270fb4410060c0067c01b10acb9126e5e940b07328470bf2d12150104f46a964ae220100e101db564d080d1fd86e508be599066028da0e36d850b5c28b03bce13052e3ab4ace0ba36c7027e341d74840532d58598d591b9772e9a75cbcf0d5b8d88b616df1d8c1b8aef51d36c333b4157e3e63b962738d2a4fba2e94aa4a6f2d86e957e26b1eb0003c8ed70868b78f43a801f60090f7a003f620906bf7768323f428c83696a4354a0e7855cb609402840ed12b73e9bf022a067294c20ed6f93c317aff77687aadd72e95b4c3a060a52c810ad4400da8e0fa422c0ed8606ba22816becf454484e06ca4446ed912b6806a9c00120ec033f214fe806c2e3c334e816982a087197d1709ee744f77b615b2a015688c355b818183d69c726bbac0848efd868f3825e7b8acad74620404211512e79032470a80330f46380d3ac7509ea0cc44220decf1e9b0967512c96c19220264822608adad16354d088727eecf4beee2136800058682d2302035d869d3fad62fb887d5c64526fb0f4a4a6e5cee86a3ef06d7e0c53fa3187dd0277dea06682dd7b8c6c9b8589aa5af5504ccd83344e026173427d7258cbf4a688fd059fc47aa88320e0b88792c200118aa848cba841a6a07ff6817a9fd58769dba906b97ed5cb62d783735e8c704706312c08ea176a0016aaf3c1aeadb786f2b2c601278a3107828147968149df76013e4937be06189609443516207210a34274494610bb2880aac4619f4cd1a12530cc4e07c99c6494d840aac01a6d4c01ab66063f5e005686c984d60fedcb43c87822cee4f6685040928e18ba07135c3ac1504409aa999b4abf9678316bafcc25e06f5ca287804101502abc20f44907254b808a4590552f06b01a59232b093d4d904d30006a69321d2e0382ee6016db8cbc2b1eb32526f30800b38a02c32920424e32faeabd3a025ac54c39c02d7155e3a7eda2570b398a399f8bc4dfaa45b1aa345c05ac95b04cc214bffaed51c5efa33f0db4a6e92733b978e643350efa83ace285f7e3aa817f096d2c35f5385021455513fa8c1d1a4c17361c29bba9067d77637fb7ad44806e6c73a8ac260d2633c1a00bf64973c96022b9637930b810e4619139dcf60e3fac5750814354002e65a026abc4817d6ae2f2c0554110a5c00b1262464a920168eb36a161b7e5bb9439481b095610d4ee41720a116ac20b2c38ce38af928cf6201914757a4920f3b9b0cc0461a09989aab99c65c8f9ab340b50957354032f3ee82280bb5276ace01550539d00cb232624e08a008c20c066e40165240832b20b22260095220100a850321c5256e8093ba808679a01097620718600c5cd5d0f0e176972435ff482050e9f02eeaf50258c33a58ef5904cf3dd1c710162f7e6e81118a61738d0b6869bd7e0457bdb9f8a4bda9a56772bce5fba5e1e75a3be332cf185bb7158dc1a05b57ba5c08f75bdeb89d86d229d5621e8c60070a19aa89fa3b8c404d004951c33155b62e4d1a3c8fb18076057976b1601e06805e29a3c3356805f8f8be6417bff04ba29c82f77acfac3f401b727c619b0f7a7748add5fa4871bcc673dcc6e77a61d940432cc1c76764c3e22007fc72427e061322a0b05b8497d7806a4e6413e0d705d6a0b0c597008c080a2a70332d3b82e27422c9a22c9c2706eaa2e37c970c522e1aa3b19a49bb15604100789ee773be342ec0cd772d6d3a4f4c680e1cff5f75782c0006e48a011287257c809d7bae0806fd0188416b7fa0224c071ed78c214e000606fd074c850752611b32c017c28118fe6115c2014d349d87a3ad5eb5256ffdb632bc443634b230547dd549c310bee916662df0e167a567fdd56abd5c4e9ad5113f33761da3e9dbd7677aa639e316283ff23337bf693a73839d4145835db638a767d348d2a6368ee079066001aee0012a60152a6072f6600726ea6dd5643bef7c7664470675a2c169b7ab2d3c1200011e26e0d32f000df2601256001036a6ab475c7625a12bd383f76ce0392ce0062868c58bb4e0edd2c58fb4f940b141ac772e6b9c080a5efc43f161e30012f0c01208606b20246b442c95d56010ff7e2102ba4031670a13ac610d361e450c0e20d67cc344254e9c8271a265c9924785c3091362849808cf02bc8b162b4e0c0111850a13349090a114a4649003075a099003ab961c3a2ff3a85c29200b920b9c2ed0d869820b090c3f39089d806280d10117e1e15b812f4182374fdff070ba62421e596a7e2060c03502013aa138e5811108418607051874f1912285a02e6811c86590468eac4082c68ce9958a58af6be1886d4b55efca15389112c8bb676602091a1774d2c0800283500e8f0dc930f1138367128f77ca886c28321257a5518b0083a3350e11ab63c32683a6b6eddb486ae7de7d9b766dda22d0cc864d1c8c885bc6c1dc5a9e1c36986238c02457ff4e1d3972e9c37dd7767513a78c9d343883f66c1985798803d08758b1e7418555c41ea06dc0830716238d9c424d3022c18a154e0508605309e063a0814e6181050514441249030decb107849150705f833bec10c90e10362049031986b841244694c8831f2b2c60c33c168450480c1f6820c18c4448a0c18d1af400c28e3ae608028e37ce68a3063bda4844901a9cb1e38d2028138d174e10e0841351c4510a
UPDATETEXT [dbo].[Picture].[PictureContent] @pv NULL NULL 0x95714c691015984843c52f6a6c41c516c26c2206979888014c0bc0aca14c1ccab8e0421c0298d0d043314814820516f5190f3cf1f019825144a98081099c20410949412c7240162909508b0079c861e94b94caa10a1d94861299643470219e67ff97a130c15103e8925453042650c21b2504384128261c1288565c75918614ad8492c50db732201f0311a491421a8208abd65611dc70c202a9f4930a60a98c00185fe15c93c159c424d0462f3ca040820c68907101679c5986010da399902e50a071211a69ae5c608821f55e80c62dae45478648b9951b9b71b391111c6dda69f75bb9e51a4cdcc3ab5927b17164d04649c5ef48179dc6d251271d72ce896070c5be2171d33a3871f25d783e91ca8179a64224f300f11871857c053c306123f53138d50823d4730f3cf2140d20808a31c5d481f23485b4820c72d8e1841382a861881a769861851b50b0818928ae60433c2ce6f9011d340a79e48d104000420fff3afef8a38c341261f79032de78c68d70e7fd0215d14001051e04c411c5e1821b64891396a8e1862081fcf2cb16048981c9e59bac014c3a76d4b0c9e4986c9203215908c08b432a4434400c82f2194fa07f5a30c95185926042288a36ba88048e2e92452b9c5e4a870a97be74691e9e7ab713173e8d67d965a70e1042524a8dd06a80b126304f1e2608a00a1e6ec8d5c50f0420af4d0c36f88040017f106bac0f3f9c8580565df4f2402fbd6cf3d735d72ce04c3be108c70286e18b05f8e20780210631e2c1054eac860c9ce005f3e2059e518126545cf8ce682e8084d2d84b38fcc20123a22302937190832613d87158131d9065476430248ec320c69c1a2eff673626cb2112d841b2d5e0a0181df3d8c73a269bd9dc861d37b9890c38410b9e80a6331c781ecc603600335ca3118da8442380660406198107239087d0a847c679c8e34ff2b8c83c94d2b4a63985076f5850831c24b50e596d430e02911e77d0200ac081022502048a16c0220b146200856085903450231b0d09028f681bdc76b4240934d26e77031225cf70061dddcd05d8f00214a0e404360c220e82834294e260098258c31254c881982ee7865aae610d35d85c3066193a361c200f774a5d9e06203b3e5d0476b19bc8ea0ae5ae44350a258b58442ba6990798c0040674b0a6f1366529e47d0a3ca1729e504c7504f4e82255f0b8073ee4c19f00b9d33fff278001f76080074188ef2b6129820dd2d0859c15802d298800021eb02cfb4deb1aa9f84b3bf8c781231ca10d0b689a2e50f08976f44281e110021244d01a76888a04cc0b4f7840239e50c94006a5b9972bd07013e1b86684af61e90542b1c49ce4b061116361bf5aa81ce2dc820c3d2de14cdd75a890e8c664894a6a0e9188868b658c3541ecd8c66e219b770ca75cec6029773e7501193451a41fed0ca954f0321470a00f7d30034447b001bd50803f42bb471bcc60862a1aa50d4609812ea6d786a44c8f68f9205a8200619f05d191431ff2d0d6f2c8581055c88b2532c27fe6c1a21b4c220674d006de1c99b71ce9a8076ef36c0f2c8949bb39e0487b03ff926a2de9801c0c621004200014e230083694a214a79c9217e2600d3558637239b0dce56829866fb8c1b8bcc4c42f26c58b3b15e1547af29305c8368f40c123049318d4040cf59845202108e57854391622009554530e8780811c54001339601398ed054b6454069ee605057ae53c8a5ed569bdebb92a402920803cf3a08a14b8e107c55244284291871bf09301052840b104f10361214010e148c541f9778d2358e43f09a80f610b840200e2ef1ace900147192102f1c80b3222c802bc9897c1930a0736ad09e14e8b213224c88056e059220a450243eaecd4354484cd05f2108379f8a18b157aac110031d9f4a0c0043fd6e10e4562b0e700716353252275ff2a2632ed203189295be2ca40e22ed0f00228e4892207a6d10788f26003580c5a1bf64cd7a31c6100e574280af29b578a140d1fba405a88a146815ccc7143105aac837211094ad3d14190fd628a2c60033edde003dac0d1661d79864e40c01467f8c28f7ad0494b92b6b412788126835437228861108193122a0d07852a39410db3ddc26fd54085cca50913b5342e30dcb0'
+N'862f6142206b180430ef149188ec894fd5251b75ab2ba8f46cf750b84382a3b2508e56fcae15f07d090c2e91de4ba8379becdd942a5e923c507d9414f71d67f48ca2aa74ae9355ae7a431c09eb0763790198058e005b14a10d4e84a20829d0c21522bc8414a8ef010808c7180073ff0d64b463182190c7d300810540f86729f92871b64c7c0111828106bc008dbe90832e1ab30b5f1c45ce917f384230a061a8e171179b856c32840d71883c5d0e194c70031e5c9ad2958844d4355489a847dd8b3c58413e62c0014f151da8acf9325437364488f9a664dc394d77227352af56309c9d3194593f318d4ff4e1086a6d433df0ead03ea0a00f9f10ca273e418269f864f00d95de5ee161c6342228010a2a398318e4a0a847b9d1959e34a5293df9c81a6190958d4121f2600a22e56d9136ea44aa51bdb756a8de14424a1b695d3d24105852469874031420e104c2a1f2b5a7549c942c21266b90c90da1b35c2d816187167c83729868410d5ca00701ff08c0214528824424325d8b54f7fbd9d608473c026e713fea77bf9309bab309132f48e1105e48ef7ab379de4b69c353f45d5ecb5c06bde8992104437320f8d01f71a42004e703c672037490078760035360038a803c0c660333d04f055071c99271a9b000fcf30913100fff012053311554810f49e10ce3b0507d310cb7c00860c0092125034840559c004e3ba12f2c741c3bd71a3e870441f744b6d34c3460535ce61cd7611c47d862f3600415727595d02095803519128557a32114b03580a43d93a00224808348066642841d14431b4c65325bb57639a166b4d04442e73c1860281c40565c300dcf5077d3c0018347777348789f8001d3d07642200342c0ff3c1c203d144134d6e3466f54808c662146b02080c02096f65893e7450a32657e300f0bc02793300145b023a945378bd40a1a408a36527a33827b3572248ee46a3592243f7224b647044140046ee205bee70483d06bb32538546009bf302654b00662408c9a030cc8e87c89000c54600dc8e6069b800d72707d2aa00a791203ab935d16413680b2466bd46d5606146181040b516ea5231394427f74500472e07e87700852f012c35329ea45600b18162bb33c4f14672f33017d802a17710fea8420af820571e4147eb004c5920627004c30600304200560b108e7c34f11160129f003a95040d7400dc3300116b00222771f58e04e4ca12ab333015c800e19d6ff0be8d08260d055df610217001b59d055ec7252ae104254c583d6a15322c00e4ef419794052a232842844661df3530f740b4870035dc4204f788552c82156b9475bb30355172278440184350f0380019c50312c54962043305655312c954327345f6ca732a15041200584e441566405143496972d334566154519d43c8157148454344f5198b0529258004791b7988f48798dc6208c16790437152b60013710039f660a20906a3f827ab1f7999f498b8d8437aa15246b23010ee00fb6a60c876010364025b8253878f06b6a406c54308cb7e406625003b9f40dcc970e04816cc0800971a00756406dd7985dd7b68daf435916815dda5519e09628d3746e0240ff07e846299b924d307008eed69dea854d72c08e30b1129be22927555ffbc87f445114fc1690031820b02215b1c2034be0033ea006360003e85604371081a1b008a1100369800b197081b7120ed4b05020a98909d0980ae214ffa60b1650578eb10eedb0a0b4600eaf612e2ba36264400b34251a8690532be442cac183103452e4d1a241b81336855324f40e64160a4b28471b60755599217a146956a3a35728757c747552e79560b92e1b8564cd413168804448d496489013de415f6cf8834549026fe6197078974261971e01332a701e3133011c90412420111111922b00085169902500476f4072f6c103801047f6d19816029915b2980a521f21b6029928ff2831106a9cd403b4968aa87737b1575a6bb35aa5893744e0000e4005caa0075922255030086f92a951c038966009d6607ccae79b6df20ddf408c94635cc1b009567008aa4060da374ccb591180c278b1d322da45a69e713be2667dd9b980c05a4dd9c48e520003c62a05f1570474209e9c924d9ac23d341597fa2856cf2314a8824e02d81f85f91423689ff8c99045005fe11aa0a140073650610fa00529400dd9820e20b90274da202417a1f2a02a7b951e98b10ee8f00ccf400de8600e157313306a309c0012a2b12fc9e142b0615565e983eff28610cb5d41485329d465fe523126b0028f58229357751b12223deaa35aa3958715854ff8584fc84752b6ff0261190a2034866a9942dd911334cb09704903b42074e281a526800131d7a25a1ab16f689761ea1144213310516328f02c84a4b151d8000e62908c18798a59a7892999791a7971ea1423f61f28320f37700313a048a4897b40a236ab38249884379d64a89d8924b4862376b3092e100d04900396b06bb41505b345056a004b4ea00c5b403902210662600c99e3065ba039c7a57bc6d910b1ba7dcbf93ab0c36d154128106128209128d7a98ec25a4dc0c45eebe86eca0a03c88a4decc84dc0ba9dc8938f70275697311447019ffce514d903156fb0b146b00469c090746002da004cf78704267002f654005a200bc8300cbc10020b000851b62006a818f070ff4ef88a010d84a1c8d00bbe8030424503eb502e3a61b034800648465564c0434a191d6850b0711787666528860214ee42035e4766c881b12258581dfbb15759475aa3355237c053470153f9582a5b895e890f2a893b2493553924a52a63b37059836c262a3dd166e291a59ec1c175d9a27118a6617ab4a6022f2480020b60045ff3201d5209b9c08893d7a702477252c1a70a2270faf14e21380f93500899a53669f38aa25637a9887b36f2367033497b6337abb58a74e30654800dac94b74e405bbd860771b0058df30b96a01596635c508c0039b00998000c62b07cbfc00d71b05e91cb3a93c027d3453616e08ddcd622de8602f8763b38815e56c07e7e2cff13c3ea5ed8b48ea6eb0584ccacc06429ca0a4c43585f3b0b45a5e27fa9d206fc753d87d9880ce2077e2005f7074cac803b5940165b9102b2a00abcb00258408992b91ff840287e0919eb400df8830c002b1ce6f229ed5b836d87b038f053e9fb1b06c38348100a5cf086e3e411712814189007f0b2b91c64b12f380ff00a7951196578b4357ba4359560353b900b24fb8405acc0063c7994c8205466015da72f32355f363ba2f928a2364803b6e36662f56674d9a26fe6102f53b431631e2f337e16600463b0cd5553698b09991622a702670476aab5db8a3d4ab302d25c5967f336b3b8b6657ba8884a37a295c43a327b4a7223980424501c0d9050382940ff5bd810050b309b6a10089f4a05b18000b1806ca7da02c49826c060aadf2008994a272a10b916c07dd8f67db65ac798bbab438804020009a2e405f2a8aceab88ecb0a03d9b78ef0780845f005566d2930c18ef5984df6ab9ef75cad1cb06fe8c45fdacaadb92b470a8c052bf0010b9607f717162a504f3f600331b0020e8269375ca7ff856864ca01202103ecc00eb4800ce8c00e3d4606b7f0732a532f2ab3cb0e0306ff72533e840310942ec73c45454b1eb603a3cfcc5164b0d76f84a750e8c221e2cd56192251980b54f884b08db298e6680a5cce9d771f5937091c001926e41ddf41c1368b136c97b36d4697e3f1136f16733f9bcf439bcc0ef1a55fbaff002bf03a23e07412d221b9900b7c0a992557720518470c4d58b15202aca234eb445994b5755ff05986bab638e2de95c448721bdf3c82c4aa088b22cdc438623990100d84a38b90c00d8383075110088c23265d100b39100cdfd00bdff003c3395cb5c4bdb3150d4c768d43ad8dc634c7df584876dc119e01a34c6dac4f2d91544dd5a54b07c54ac8c85aac4530c8602d0752a0acf3b6c8f93841eb2945667514667011084220715a807324ce585002b3e22bc36b023090022a0cb563b0a7d34b82da931edef01828c40eebb0e5e6d063c401d9fa522f27a5ce15f35351ca0959c551946013e161cce7f101a612e7c9fc19ee42b13c2402790062851595b74dff6957b3792e1ce8dbedc2e35ce8b82dce9518951babdb2b100218301a379555ba91323cd11340d8dc1d4c02575a9431f713d41ab45e1add2bf0354eb1011252350de0689199b57d5a72739a9826d93402980feacd6916a0089464d1afa63748dc239b79b6b797233e72b679935a8c2ad2c538089030c550700cbdb600b20005969006bfa60cc2806cc565aa6e60c6cff80363e00350500acac0c67912023730abdda8de75ac4c4411458f111659008fc81a5bee67d52acee274008fee27052fceef356eacd864ace359d5f69e07aebb8f4151ad64aa5ff7100f060234fad1988fb5a7e28ce4a7c00959803b26e0071ac2c27e6d9026e7144d330995e1db4dcaff0ee8800eaac00e962d30c6f1731cb4ceb470014c051b48b40e22811c36f001e71214623aa6326397746ebf8932ccd28c3477ead6884ee888def495c8f44e8fe8bafd88539172e4d26337e170959ec19ddef5587a282485a5a0c1e93e5bf6412bb4436b018d806714b0071de0f6056d214abf20546f90855992ee24eb8155bd17910f706c011f507a38a224afc6df163d37865a9a4c627aa2e86ab058f8af480435200d71b0ec96400083600504be00f0f7b7092e0c6b2008b5745cc6856c3ff003bde006ca30082e3008aaa002c9b99cde47598444598192abb5c30a36cbd45e4000018e072fbeac55ad08ebf67ec6ef05f5ceef45a008cb5a042d9e7d863cffac0b780a8eec8651f43ce8912ad3a34eec141507edddd2abc009d07518cfd775a404147fc3250896289041cfdcbed41005d4701c6556ffb6215432a92f1bc50ede051048c88800532849281a2630704031c1e1c3010f27a040a182030612264cd0907101498c79f2562448c003cb49933c28acc4b2d2654b976f4e5280e9d226855c376db6ac49d308969f3f79f030c22341be09246824d4989184d3a7504d408d4a82d7531379ac4e25a1d56a571218aef2c22056c584053c2aed61db816d8306b9b0c8e48905d0492c3c4a240044d2ef0a7cf8f2e982076f928549210e4f3a7c838e290d128810912099883f07932568d0d00304670d673e731e1d99f3e6ffc9a929733e13f9726a0d4412498b03094a9c38d8a241818227061e4b969c58c284c94d7141c0be7dc3f4a3d70f37627e41f96529dad918312cc40861c1bbf778f1e68d8f67417188100e5194551a8a1327017460105093060f81fb5214e997d2ff9097fe6080410a0061500406f91429a288030f1c108622e850818e08375aca042e9e62afac8518726880010ac367047c12d8eb0d93deb86b26bc5aa4090b7c48c967831d7668409206228984a5b90079a34479e61900052e9040020d32cc6187177438b9050c30c820030c11c84043842b6fb9050d572e58e702760462e73d246f31658a422e980a83863e9c00c437418c483df632a2811315c6c3672492ff86120a4514854209501e1a0114c5465e645127165de489259ff202ea8da28c5a61008ca48aaa295ea6f2ea2aad3acd88172e9ad2e85453459d6a2c36e7a1608f0260756b8f1ce552942615b1f06bd79100cbc7025d74514cce49409c44bb4220b32c33d588c80cb4337a30ad35d040abccb2c9fcd14c320d3e5b3635c9ec58230e2ba048218e68a219040a6e9071420d279cf805934d8afbc68d6f9eebc50d7eddd8020a27ac71429505b3ebee3b0bc65358bcf2cc1b20868954c080151342f1881556f228420a1b4e202005029c0090c013bc28904029183ca1bf0523a4908efe4c2e39e5978b109095a5b8c8900452c20aab431438887300c2f09167d704ff5024a945bcde709a692328b011ae1c997ee32f7ce01940051ad040920c4ed861671d7608baa54a82ac144804b38d34c46b8f9020130c4a6c50a01519c2a228ce376378f86fbfd5bb08a38d4c0841bc1512f7ebea928c328ad0a4235f3cf2371ae1a172ba4c6a4926cd1b69048bcf67a289a6cf533282d2a14a22699e105420a1d48c9aca08760c0b5fea760b693181131a68e144064e68b9b3f7533bbd8a04158c60ab8058d962012eb9989e8b57a3f7dc331f7c2c18203139bb7f98b13c28bb56b36625a016846863dbac33d24c8b4c326633ab2cb6d832d356b56f801904162f08886390dd44c10a8748817002e10341e86b0cbd18831b04619c6f88413aff51b0c616bca00a14184c3bde99870518469e78c0c33cc58ac87a304203f770e203856061216ef0c240a481001e93c27d080005fd006864236350cb2864338fe1c164295b901ce453049cd1007655f959873820341011e61e2542dad550c43413392d014ca300d522113da6ed451ed9c354289054252671020dbb380541a82482b3a9ed4a70c492d79070014e18891322c0011dd0148aa9b4c94ddedb9e9c1e62c28ce4693cf2385a0214873448ee6a04099824d21c4728a735e2749753dae58652a837ac8452923add2651f44992ac40481cb09ded6e27038e00cf77c0bb402de3868430b9c248787ccff034522a13f062013b8015f3f6302bb8e8e8453251ff5de2c60818c0cc8330c0d20588aa30a70f156b12132807b388f0beca90af5aa2018df8a055ad664d467dceca963fdce909cd88610d83b08217e2900600420180dc0844bc9ce00b4108e20782e0177330a11c37ac411971f805157e21071514813b8741d8c2e6219eefa0076213604fc5f2c88a42acb00c0a08e9096c501f90d9100f502080c95cea8595e90742076a1981bc20c4998d4c0a33cdc3467cb6330d39118a202a0c23ab5802156d51458c73dad3f062121b45a26957b38b518cb64d0c5c000d48601b7c3841826a74c3106c2b071242118a3a1e694a5bdd2a1e3d12a65b50c20053604528f4061139f92d04dbdbebdf261234d76120048b64a448ff26d9ab543a9292941cc1240b2b8f114076b190bc24a18c2239420105259fcc4b271d97003f38929103e002276c594b24ac23b5473a92d7d83610b6bd164b61e225ef386102dde98e173488c1183a60cc63b2855639e189d2fa9280c0186d8cf2184c6284d5bd377de86f37f800b6c4b71a6cbd607dd65ae776b9159bf271263598712766d82981358c4b0f5e00583e07c10d3c042238012bce71f885093118c7819bf88513b6b085410840a2db4118072f7ae0103a6ca326dc887b2e9007528874a46528433e48cac28e05110f4eb80f4cfb23851b7c583f0c8a59c90674d3190a51660480012b32d433aa84e5894f8c53080a33c55d59912e49d3952ef041ff1799d04574d3cb31e3e0a10b8e1a290bb4101b0d58d18db09ec210454882021440d72a79ed4a54b2a3918c44061c48c10006d84859a4eb3762a14731da8393432486011558201f2109c933459280c742f6687a2eec3de291e71544b6b1938d64a141f9a7c80dc5478efb6c2a45a28bacc696206c7b9296cef6c62a91214c727b0f2079c714549d2a06c4645e0166e5965a69518b7e914761e691b579146658de7bd30722626b874c820ee0a40cb8c66799cd94065a9e01ef37adfbcd339c017eec6467668220817bc5a116e5220000ff178d28c8573854a82fbe8eb306313810132e50c61680210639a8620231b84181c5a330107a67af0e195c46dc635656ff44788555086921aaf0816ae4fb0365288449f113b21982786521663888a5503228ac4c113065e97d52e08490a5e004147b5d8676c6a12736c458ba68033cc65849928492023bf24bd62629e4b958ad4454dc553ed2438223dd961374a8423576c1464314020e334843128cfe81d892414be5d0066cab04253acc80008ab02b9bfa96e6f31c063ddc2be1072e0212780729cf6367643de4710f78e0233cf1a8073cccce48413f769228afe4481ac9a79228ad4f7bbf6ca31de9ccd162208583e7042001a9919e62240f62e110e37991874e413e2b1ae9ed318dd9bce1ca8571bb9ab9ab75910fad1112d703b0b5d01c626b4528eb5ac7161fb6925dad6e8946ffd8d892ccfc4e3399ccd88f08cf3e0030dc10075858c13683c08632063188280c2738dc7e207324088c351c670be5ce41172c21001564a7c0097bf702108c98f44cc02265d9481e2921104a900109e737eb2930e6fe5398e003fc9e44216c707f8fbdd06327587888f9dfd29c3a81888b838bbb0f3c48814050030220051a789dd759938570a2a1b9b1e4da9595d8015d319a041880361891a4798916b99a0a2c91bec00724e3824c0b852f988247988232a8866a288429588225988219343a45288781408256f8822f30855040022aa1043a20802998019c81b3331b0035338f02430f38a108a1010f780bbbc20a8fb273bbc2d8c2c228b92d64bb1092072cff2cacc882bb3dfbbbc8c23b4bda3b36bcacc54a9c150892f4b0088aa84315a0083a54013dd4c3c5238b3e748aa9680ade2226b7601e64aa959310c11180263c8bb52d242139e1800f70883e98c4019044493cbd3c388df509276761164f8c3d10409f68190def728dd5d38cdb6b962028074a088235008638900339b0276cc086e3e30627888377510335e0b67b010660308ee2a002ff02b72d80853cd0be8331b02a240f79fb2bf2ab188f38232801031cc0c66b8c12243805f7dbb74220381bb881713480134801909921759c991083a9fec103fe83298f49a914b8019ce10217c34790e3006f18aa10902278b88746a21c2023097c380233d0058134899bff3809e4da93c2981e7cd8a62219080930000898ab2948021bb48129f0c825303a05183345f8028c84001030051f04011f1c330220b3b0f81028e41ef0fb0e118287be7a081518000eb20078180f9fa4b32bbca810f2c2b6e3421b8387922bb910fac23f2b2cb37bcab15bc4c42ab4424b9c452c43795800ad99000ea0c3af0ccbc169bc4c0995400c3513500138680be08a8bb8681a9220913d412e79d0059f7c2e3821bd3ea0b149c444af149a0fa8ae6b813deb5a1f750a0d10e8841f34056f214c55a4bd5fabbd700a0222104636a8855ad4a77559178079975fb0866e3b
UPDATETEXT [dbo].[Picture].[PictureContent] @pv NULL NULL 0xb7e210832df88540d88235c0042fc80255c88e76a3c279f03ed98446ed81988aff203f14fa324aa00437ba461cc0017fc8462e0b058123856ae080701c471b488340208019b20102e818986290132b99980a1010bb01fe4b813460c052d99927ea907e440139d9c229f2c0a4712a2c90aa04e0802318003330837a280997d0bc96c89a09e081bbc0337898005640032829872fc8481b2c508e2cd01498822b53804768d04780801ef0c11e50848c1c3303a00385689310e00e35e350ef8087f2280fae7b886614219ffcd03a0b89f0504a9c64d116ddab17c5491b9bd12d3c4aa734b93f934ab90bb438cc4a35fc0b92389a388cc3ad2c8ff5082a8c60bcad58d2abd008e309268da0813c509e420caeb8d03ca712c187140911220c431a807eff9c00af9bb1191b5386f8805d3b0dd84345ef5a0dcee8045350a7ef1ac5517c9ff7e9b5d5d8bdd51b1fe8bb4cfef91fcee40d27b8b81460befc49cd7b71032ab08479c1046538802c30988381b705580055a2cd9c7cb306cb2329319272702337cac66c2408e01401e27cbf15b2b0e83c01ed844e745c5502d0cefd0b901b70a15a75a1fb4b8125e8ce06cc1056280b3235bd280a48621d48215b399ad08569e0803e3882366883975394b99087017015bb70247c480a372a874b18508d2cd002f548706dd01ee801082d570880000a354903a098b3980028543328bc81ee085113cdc95cdb3e146598b593b51695d11021a4eee92b264cca36f0c99be4c210ff8a07b553aec7c233320cb4b80cb4c622d245dccaadeca0a4b890da31955003b5288d525ac8033ff82d59798bb77c83bda01e46b21e6d8ac40fd8cb27ea474ce4c731f5ba0f50043a750dd0288d6f729fd50b8d5608af682136db2b4cc80c27c990202780853f8d03362805ded8b034b0844010847078a0d18c0ed2fcafe288864568cd0d32b077c358efbb28c4d8a88be8a9dcf4b2b242824f8592a7bb4652650446881284c01891ba01ea5404179a218fe998e854c71b888142f0db16ba81327821be550180c3470d11cb198b082634cf80bc07bf88b99563b94f10022ef8041031837b1881cb49c40468830140b404a82652583f3220426f7d84316b5003ff90ddb9125703e88147d0dd72cddd08fd5d08f88250b0ba871916354b8cef78b704538cc0791884e98e83f9c985bd281015a13698d1e72258811d1a39e92bad1196186d83a6c4c2b7d3cab10b52d1325f8c45db10c0808ec0231988df0b90015a8025d3fa1dfc7d8f8ec0931d284453a395b79c8bc62a91c8524811018c6a6a337a9bd960ad590c20850756017212afc35cd3739a96d6f896f991007365d374aa8c039080033085566885ca28877073023d2817dcd0a7db009802520323d80062348e1c10042ad8023188056970822c10b0b14d1885a9d4d8c4d40dad0889698f3c0a857238ab202c2bdedccd29993430b05b77608462c8463210b870fc0008ff2b820f68991800311808b1328690c084b03ca08330fe0015a0b07fb38521803156080b8b98318a28cf2dc4877ac087d14dcf9650a6049800577085cf754fb74b4fc6bade04288ae911129c734532288733c8c8dd4d574cae500b35d772ed644f8e967475d70c2a5879455e2af4a09b84c288f01b534e582eac5e108d8719b53126a435ca550f41ba65819513f06dd1156518310c661d25bbb1fb3e0b4081aef11a2b59664dc3924c5b6624f90849f8adffcd3c2cd80b139ca27b3003f824aa310abd8788d9bff406a11a53602d8bc7e8966253c56af90c69e964d0e801d1984c50fca61ef896f211e1c908e103e8b520600e65d0835ac48d28180436608341ff88037349016b48204ce0b61cd8821ca682e3c8815a38001860b7ef28e290984db495b739595b6a5c042f835b43080543282b49a6843702832bb6621cc8e26240837c8b3005f8b781bbe9f90ba96a200556f800e3f46956a886c0dc8542b0b2321802252881814b8242c88a9f6108091c2a57339a7ac0b194c3825cd88148684f9eb9002120814f70d67a682c12b907d49d871da180122ca32676c57268854e06817495e73330c9bafe82722d5a4f36d774fd82c53b8b82350ff4704284619813ed50bf99a8660cca856dca2dbcdeeecdcb433a82bf0a39f7dc9b89c02b81458fc2b000a62c8cc7ced1b133b9b1ab0763de0e0ce0aad7dab492361265be0524ff48815313ae2b9d0b3f463b5de0e609d84b10a1a621e9cb05c6807e2c0b522053084e6e3a60054e6c16d873e7ce18456253e7e63eafed4a2770c1d3dc730066393765b0827ada45dee04c1b921781e23631a08289de82e38883031000edf30e225e014b2d62ef0b51f3a0130cd008f7c80209'
+N'0802295ebfb7453f82a0047f600477c00177b86277c8e252653f52a0301622380a2338801b6aa206b808f3b79f1e020f976305a8862a18f15f254b3c9e80f70491a4ac9ef94c39a7919a1d78036fa832b6718575a0856970d67b40eb67e5c91a614f7cc09453c80226ce82d795801fec0c79f68cbb0e5ebdf66408d85d737d508c5c6e0c7088b185dee7f5a0f0fff86855ee1b53366cd1fe6c1b0b215536a4cb6e6035275314e8833699134282d1a44ccab563d8580be6ea15e605f8a08641981850813c080522670a3843812230743d2c8225082e54cb0547cf851ff1e36ab26c37df4bf2241a3831bd05f6060826ee083c6e0e210156a003533c36f0729fe7661feabe53ca1c4c3cfd60d6a384ed8e8558b0042b1080438817e4db4c731140d0c4e11cde026be036e3a00248cde8d71c8f4a150938ac540b5880ad4b8fdbb4134e58845a788103388045d0f6450802002782dd740028f18706df460577706da49b37a6f016aa0245b8709f86c19e8641a0ae0605188265d0015bd001181c7152e8f44e0f9aa0f14ae9e2c229ff42b9a6da6a0a28012640ba3932875b186b3378d636308310e08131a81a3cc31413d0066dc80257dccd56680d53f0eb72fd0250de6bd92345790e5e0808ec37296c796bec86210f10458c5a5eb7e20d739cfcd039c749bca45c143802356fbc26025686c06c867073a1b1ecce6e51841d5f577bec9f6c3b31acf33ecfa8ec988022701d8e48085ed0c318c002e16a7447d79504b88704f64a9aa5b1429a1314b0357326854fe899e47e2215e8198c0181e9663dd4808d9fe58c779ebd757ef5ec2e9f0fc63d07408044a00258a8855c57e828186f1b82824050548896682a100360d8846838805ae08e8d2e62fa8e4322ee208d520f89e16f4e007d2bc87648ffcdf645e876009775ee0ece6c64e9dd849272a7db5018b89162a10c0f38790fb87807b87e57005b58fe2178c17febf40d59600eb8443dbeb1801c913778392cd8815c888412e888a5b800b65907f79cf88a5f813118831aa1096a15bcb36ae2f4a3842c808cd0c86b5348369587bdfbcfc84b0008532654a09810238485840a115a5890305e3c0b112386083120c6848b032655b4c0101e480bf03cc2ab38e064c6097d50a0e080e1e527123267d224f1f226060e3a75b26439e1c8808c274f560c5172e45190f1e02d6d0af1e952890b11de08112346c21b315490084583c3bc1d7bf674d8d3a0412e2c6fde8cc0776fe8040ede6eea1c7af20387b813e2baff7c496aee4d522458b1d206c21408101a404820e25842e3c68f35682042793165103d2e43ee4c248864220e1c3cf62cf974e7d43fc4e4d0530b461c2771064181421b8f172fbfa860a242658b6f31c0dc3839504b4e8c1b0ae7cd5b206fc58a79f21634f75874028a97794c98e094c5782d2bb50e2c0a32fafc684a0ec0f86bbf9e127cf860e6e3983f3fd4842a650a7da84698957f0156b30b29a45473e0071f54a1802d25e8604b1555f497475f189052505e280c50d70021e8d20648669871cf08232490c05a144412c91b5cd08001095cc8808439b41c7184196dd4d3c81863ecd000056fac300006a12c52ce91e58041c922a66860ca17107cd1c31997ff6956a5062f64499929672496471e2aecd511450b29f4d03c102564114a7b5d140247154da25049ba20d4e1504760c7924b7dc9c40517249810231783063ad32730d2b5534f28e8e9e65015d5394049458dd4864820690a51489876549172576184d53c7e44325607659985d65a25def3d68618002613062d653449507ce1b593ac815908e329592c9658668a85069963c93a56d965cd36ab1963c97ae6803fd23e764069c86a20016512b8e1c616d8c072486c71b03108ba50e4060914be09f2db16c2ad61492d40c070d5720b2c001dbffb32671d4671bdc45d285964f1422d085b01cb780eb8f3b03bfe8cc65e7bf6c577317c2280511f19a124a85f2155ff14524d820792f2df2e0022a85f090c96504284d5e4a402293761e7661f799d04922e038838223e25a2f8462e3b445282373ac578011ae608f1098ef58cd0cb1895189d003c449a100a924696534e2b72b4d2cab0c43abb2db75a76c92598053164e6db134d9450a517ed15834645c9f9294778c2851d072de904e39f85164a03e226d06042a131d684d34b8c160469a41d5a6494e5926a7e94a77a5b57d1410759b0021c0d90a5ea5968a595805bf7f4bc210731d210684e79a504fb5e7da9c041cd7eddc44a28dc5246a562da746b6d68cc2efb2c659669d0030489a5a6412ba21181acb4120491fd65c98ac1da207a1ce28432b345014534d1407208bbc0ff05d7db1a6e447380f85825445d74fceaef10c0d8a98001774c6030e31ce00008ab05025be18f87b9875a602886c596440932c007095f2b071228611f249c82151f280408cbb01f090de83f0522c52e48b6a006d9a24165f840ed5e221352d4252339cb889dcc70121d8ae81ef838d11bb0908b06b06870327285085c218469f4e11af568c3061a41010aac001e71a14139b2500e6d84421bda68051d1ab3bdb251064bdbda92932ed30a1288c97e735bd3991292268820c42421d84b46f07690cc5d8e4d6c0a4a508e20b80a114a71883b242d0e69c8d9312e508752d44e78c2924709c58e7eb31c1ff5d6a14ae92d7458f183e9c8329655a1050b09284102ffdaa28bd7e9444688ab1d1e215585bdec8a77bbc3005e607432534086799189ccf5ae5799603a4f78ccea562f35e0a56671cb14a678012c60d10aed496011c1dc5eb6d0460431b8810a50109f1364732e6c60030aecf2021476f3ae2d60021362508671a2110359dc405fcdd917bf12e087e9cc634d01fb5f1e0435c0f114b0a07ab0c2fca825b12030343ee5a0041128510e32481083180c054645501f30900109a13001298af0419145a8a431ab463748e6201db094a55578c9ff5e423bcab564006d785d1f54a2129b062d0158a0c08f22810f97908006ae40031a94f88c3ef4c10cd738c206847a470c04cb8b79f0a209f24087726caf978a79529584f9ff02639e41022f68451edca610fec551220b88c8994c12b0bb9d046f37c0d31f01d926c0b5e4263189d122132983c1d24006823d64e20075289b2c4a927bd1935d221b594b1205af91b2c03c786084538d722c67c9452eded0ba57bd4a177cf1060d2e40039be4e5039012ca4976f20115ec8e03b784112b98c94c600a5378c56c96f3ce0802b2354f78c67ad2939c7980694206348ed91e69aea72dc8b8d39be1c14320e2a05d6c0c8200e664d76eacc19bf86d211a2f38a82ceed79c79ac009f09e8d73c466211ffc1883bdf39c0280e6005edcec69c4d78c10182b0880308a01505bc6017bde8458b52020916b4e043b99641fb749413a160451e4e982005ff95b41b6560a926ce216218f6050535b34941ecc2819dadf224390bdc04e0510f9f0a311791c0c200622483a322d5153210c233a6f1897800290121889d09b471d5abb6421b74b8041d3ec32dc59c616d654de665aa640a30190421703d135cbf1c9192784423b1bc8a45f4a891804d2e9681e3959f1877481914961332b0f39d074b673ad320918b9b1da06895939cf424966e3af4ed241b59d85a200114309daa561509d599121f3d33c3875a0c3b120c9604816b3376aa6097b8eccac4b6cd252b0673dcce3053598d519e65265399292bb3075f202e64d2d84b27f1b21ca9112374a925ddec49c09d6b808215ace005d994820dd880441cbc00092f44c3ff1a82b8b61836918341bc20d987b0c0091ac25efde96f3af94848506eb91d012e22bf848042382d810a4b64f79b7a90c36b5491c04564616c60a2031d3e00f0c27cadc116c4e8294ec1450a6aac3e38d09808268806245c2014a4a84209425c855d18020968b800e4646a13d806a50f94d254cf76029410c863689588442e1210232118c2151e572d17807c0423ec000b43026056e9806125d3411172f082299c0782335ce20ccbdc5670cbd8033ab0d12073ba9f54d6ea90b7661d4ef335c8553a14ba5ca5e466786cd4e0886a13c0226eb09cb8c09d2fc089b75fa0ee70d773610db9584147eed33ed9cbe41cf5d85c5132239383c70a1e2d4a5282362d6aff619d2ecc708415c34527a85d9c98f48ac7c8c219868c7d092b309087af6ad3b8c3e45e6894a52c652ee60b5fe0a5b6aa2401e28e4d0207e86564d4135dd28c55f54410c4f7d890ec659bcb36cf96b6ba02716d4c7c4b19088cc621d2cb9ce690fbbdfc4a134772f73f126c8713c619441c2ce1024b58e2179650c316d4608938acef2a086b45165bc10a3a9842e08ab8fffd05ce0a0c3a986b09ef606160d44361d00491010591810888402854413778c32924a008dc0212dcc4e7c548ad08850ee1103ce0833ce4832e0c5246dc833c98c84f450205e88210ecd805dcdc8fc9c0340c000f6c0005e0438e99c0fc015c1ea0952248011dc000d2adcdda2c5dff0f7c95666c463385890a888eb885d9723cc442c489a15985998d0ade005e41f0494bf41521118e8b145628c880dd856118d29ddde9999f2d8ee37c1e4fbc59a3ecc9a3085e41bc618c258058441a5a54422e5000163c9ea5b1525cbcd85c784351bdc8ad6c044a70c007a8985f1055aad54cef9082f1744bf73ccf579d86244a467b240bd449c0574189623cc60b9cc1173486934c0f7349403988c6795ccf34f9de2688c11a28433458017639c12044c12090136d78c120380115589b1894572de881f8284743e00f74f881f5ad003fa1db04d056cd6c4716d44234408176b9c016a00270a8816f50811808420e38c109c8821cc082001c00d80c5cd1e1dffffd158222b8231d684339605417259c3678907ffc873e1606f08442c51902409e822184c2299800e1440e29144ae01045e4f90c3cb4dc0ad0e01a9ec4ab98c81b4c1105700018ae601972c111c44323f45c020cc0d6a88022d0c1c9145d21f0e0254881172c531a3d4f0fcce419108f1a858941ac553fb51566c1551d5dc7cd880aa2dd8d41985d160acea051a04c308e216d64dd511c47521c548ee1dde5dde23412df115a6db161a37425860c801184d2aa80d61b344223a4525bb88e0e71401ffc85377843a0c9d46aa980727044df4c4022e6c704bca560c0d4890506099002ae2dcfab0d61719d51ea394c7b540b31a5863385910448d3f4409d0648d3ff267e066964e601304b68bcc02b62822d2a5bf895826da00b244c9b1744c1bbb88118c4c130724334c802a950df0a28e30a2ca33cc49705e48a4b04d476a84234c40114a440f8a1df166cc1bb7c0f30fc006b46800f9c000114c1343919c0019cc07d00fe158201ec873b16c629d4e3779a10619c0c2b741079fe1f41fe5fc2d1806070014cb9847b72083cf40c48fcd0894c824cf0c4ceb481083a1a169400071842dd7de105d0020a58000f00d50c0e000d7002fe59a701dc8001f8201d48c1172893d3391d4d929e70b5020614c104308443f4135b61dd54988415765915ced5d959a16df54985c810172296dc45e5c44d1c12b08383ed2847d6a89dd999ff22a5a1a20c5a9fd44a2449ce42f21c0534425996c808d4c33df0e7abe810ecc845e1cc0ea0214e1e900a48e00aaee48e5c08a2e3f88e4dd44ce861002bf492ab9d9111728b26a61e112ca6c4648b742517fdb5c2f6749504c464aff196ea9d15eee5da16b80126c8a2685ac22d4201774182b2d586b561c216b8063644831718e302d8403e9d886dfe8b47689fe891800008c0219c001e849313580272fa0015b8412c200002248231b8aaab5ec118fc40204881295467d1ed2a76e29f024c411928800228c2076883c27191c201203f96a73e76907a3eeb9fa098d298c04e64c47c9a013c9c4809f04002682417e8e7007c888cf100b72680374c9c9e9100ff821a4125508011c84308d0c029b823b1de9f01280001e406c019404d9e0104d02467b0da93e0a4fdf04f3f7d591cfda4ddec090aa0d955a4c4c3de8c4f08ce6d41ce4c3025e2d0dd8eb2c3c471acc7a2818eea288fd6dddbe1dd55320e2f6465e4ac6c5fd8d6a02d00153d691b5c03531d0153d5ece44d83204ec39fb4dd6019029d0d0442fccb48e04a50cc05a128d6dac5140630edfe714bea9d1132c1296a88c662fade6338d32528022f45146960d958550f4449c0d8a6c6584186963493250887320c42a36a576d60831ea88f17b8a4b551c1200c23ba78410c849bbe40c77b052e33a689333e63d3828909c0c002a48013989f780902268c05031843ff062000038c0502a442e676412cb8410410c01758e71728c2e85aa722dceb14fcaaea96c11778677a7a91b21286b17ee7ff0d64c2d16340a55ad306ce90ea444618853cfc501061413e90c03890c027e80c88c8583dc843cb756bcd15280a2c4082ee0005f0000dca001d80503b16c214d80001842f1de48117fcebbf6e063211e69e868912ea8b546c9d99c4831d7d1d0ad096a8a459d9dd51e0f5c4cc24a5521652c6aea0c7a1011910b001177001732cc882ec8e4ee5dc19d65536ce620d294e38c3cae6043cec0b0f3ca9193803174c03cf4ec3072b5617fa2cd0f2d96a1541089c007384c4ebc485ec042963f50ee8bd446440ddea9d86ef414674254bffb5f430f658c6eb5d8229b4024445d72fed5a63405436714bf5cc9e9374c219c4cb3b6183159c406d44c1f90c42fa30ea215881256002140c23770dc209840075e0d36dae000ff04b6e162e6d891e06842a1e2c802fa8c1bb08c237c4020320c058686e2aec81e632002113b23130402cc4c2e7021cb18eaebdaaae02046bea4e41ea968122e8a3d0ed2361d02e41721141229c2118a4a0d56f8ce6040eb5dc1b00c24f19c1240c567c02854dc1431bf88cd4bcc124d49c0c4c6f2358cdf50e9509bca301b8a30224c1f71a0001dcc0d84841d32d93194dc6638449c3ae703c50c7439428dcdcd1d9bd44c3da95998d498b6661cbfa2fe1080a7734a8dc799cff01a6b33aaf733a1bb0c83af09d592577344e4dcc0406a4ac3d67848eb4411b1cc127c84032e89940ff2c9f059aa0cc0e061cc4f4658a9d6c8820766141abacee6280367846b27cede9b91a6f31669c7634b13513949d011d54cf6834a674ed29f52cf1491bd3ec918d2974020870e316b840291c942a048218584229c82d37580124c0821508c22f44033572171e60050bffed6d9ec87b51c73cdce52da900980800372c801ff8021508c20fc44222b8ea37acca18602e03a4022123c015fc4004786e0450c11418c03a6aa7b06ee73bde9f0831c814d882021880c0914c8204dc07ccdf5f2febec7e32ed2a25cbc64ea0acd806a24809ee4009ecd83a7041ffa2e4cc8d4cde274cc0889cc83d70c027b4010ff032d66080222880767aef0ccc405edf8014b4c22280d10950d9d2990d675c0fc19e491a37444320ac475421e0c55411bc490cf40d6fb7e89eb0a1382fe5e198b3831960028201c439f77c40dc3b88003b7bac83916c3c43b021290e2f040a3ecb44ca7ef727388333f4c1277c02cd452fd0022461f5ddc07047d5c9517c21054ac008e27805e2a41a63d9c4f6d9843c86460f0f5bf6584610636d30a1cd1985ae33e5aa3694c6b0fd524a731581a38df09c411610012c38936f1ca7dc46033758033388c1b9743124d0462044831e1c4334801f3d899b1ae326357f9d6d85491ef0022dda310f50c11e4b03ff0230275a9fc518646e1fbb411ad8000c1481546bc322f09b1cc8414bb623b16e1876968101dcf569cfc03264f9109c760b01ab0154413e6ab209f9350df31d071401061456adb01c8d4d91f55a802198c33ad002cfc6c42788b064abc43da0c80874f667eba13c10890da06e129c7612d880225c55838542851a8010feab972cd357d181fdaeb07a6116fc9e28e85ca1ee8cca9b5845f6e991a17925efca90a01cce9d2df773db07ab3b1cab473747a5333b842cc5bd5dc9062d2319cea030cea91fca27788390e51c180ae8dd614088a2040a1c74a01084fd4c1f3c4c4249c456427e217ed38460d844861924295c95f51838b294340e4b0636f9de260e93ff32bdde635a62815f0f2f9d22676c4b2b14f18015f12558436fd0f4a4a6d3377c8332c8ed20a0536e440131cead329cc03c6116f531357cc5c397eec5ff48751ec8c170e2410a0802ab8a8134b8c10f68758f344090774104a4c01424812d2801282c036a2b8292c0472b4841761a40954fc1690fc1328082cddffc32d0fc10d0fc326482960f812d58f2756267086d67b016c27ecf0e63a1c00714d540500a63ff5403ec000fec988fd102090b41a0256f1fe048942a291660ef0490820d8cfc0cc0c169df001d6891166d512bc080014c89eb49c9d265190810ac884e336e67ba3f2d6cfd7e6ac37e7a471c84148ebac4f644a95f6cdb71428e36dcc66c4cff31e0000e44be3b1483e54ffec66c14aca7738e36b0dce5992231a58bc8192f20e814857d02e4a69d58445ed4a63cc40376d873d386684fae57431fe2202e0e17e4815fb4e7621924cdc8a3d546d7b81393b011d34523bfea1d53197dc161bc9ef12c8b64ace2728d0d651097243e099e8e4d2b5c820f88d72fd8868747811308422c88714f43011e44016cce6d1c44010ca4d73102ae1be7e64ee60a6dd156c4dfb82f0084a01f087eb829f863cc1e857bc6084a916286920e4f0a8813d761a22d5394282d124020499219a0402d2b491294129425870cb1f55281ad12325f0e5906b38c814239cb9429a4c0401952243090a071c104060c139862a0b1149effbc046fb05088b483c20443ae6871e12243880c195ebd92f0f6a9cf91043b76
UPDATETEXT [dbo].[Picture].[PictureContent] @pv NULL NULL 0xf04890601e8718334c829a31a5482824e5b2686ba54d5b1e3a040c80e8d10344620d8b0d9fc9a322468810161650b610cf4266cd9943c418c074020a0e4a89c6f02c99b3e4ceab277c061d3a340ad91c549026c185060d4e48909001530c4731778c860f67741c797146c283e300f31c0c997764c8b0e3cd9bd3054e3238d1a241cb048df0df31f8d9d1600ffa060d7654a2e076853c790b060c104d9ba9e9499ae7cd93b7229f105c9bc09bf048c86334151224a528f148088f141548594402098870c01f2234b4d0010734d4b0c30f37bc50c4123f5c4cc3c54c69c5143a4cff5971430b49f4508215cf70518317175bac150d2a84c5af4b5210840a65a0c0239a41bcc0c397217f88831b2a9c98321a3d0651c60a5962b0609e05fe5b01ccf8fa9b8733d06853210f0160e1060f41c668608c317e1028a13d5261201641fc48a22505009184812718f883d00e58c844918eb280618a191c85039421564a4909259659a625974a5080d39e7aaa29d3247caa46910f0aa962a70f88324a2ca23e686d82075118009e11de7a2392482848800b3468a1e59369c41a762cafa62121042328c0620478da98008324504aa2885338caa2956cb3a083153ae880c1802f0c4b8c5c104c81808ea5229325b30516e8d232ce2c502d06d050a8ed41c83cffdb7232cd04fc97a901ed0d8d36146c3321bcddd8010307e3903bce1f7724f6a7188a292e06638989038ee1e744a08e8cebb4cb8e3bb1becb8d8610de18a19e11466804661e4690a78d36ea63ea081440434db301fa8567decf38e060282e922a62820f44fb40c106514eaab63cca2122880bc1a89a0819b1f690880c45ac1044af4d2c7131093468e50b3a5ab1f0000928d1f06daa256051dc6c5f34c5ec1c5574f10c08f008648b5fe2c0069b68b839040f6af0f04190407eb026106b92b4848d5ab6a42ccccce5e90fb3ce9852014d3405b0020a41dc7873bdf3d68bb38b08d2484289243ef84001380001048e2b0aa880f7272a050189568ab0610a9186ff1869a54a2bbd9479976452a027e81598c916932cb5a5906a5831b5a742186cf082a7260861920138e08284f1759167041eac5a3656afbc93c1106269184b0812e271ab1e5d26f8842870c0051c6ea00d24842214daf0562bf2d00a6f49a1108a90020414432e15a54d0513884c08dc5599ca5866322134cd6764832f13a42f0693205fbfe6352fc978e63531648a6c44539ba2204c37bd01c3c32436310c7508884104a23f28569ce63c673ad5119976b453b2ed984032f168c3119c71846b48e61a47884dce02f62f0ba8504037ab8ff9ec33010edc463c901198191f74945070e229a4e0001dbed08a0b01916a79f4900382c0c710c5086c17ca10d7c646ff0415998d8e97c05bdbaa46480bbde00c9df8c2174c91233a68401b7a539129ce90981304a248717001e154c18d25b1490dd6f045e3020185380c0216aa60d7bbc2940030cd874c419b21d3d074003938610b62f8c1302bb11ef48cc10d5d4809a60a110a564c6208b80085169e50cd02fc81774a18821214b1ad1b14c2060a68d40ce0202994a80414af28c9a59cf7125b94417aeeb449a59e30049fec640643f80006466314f18540179380d653ea038f7a24800209ddd53cec4302195cc015e6a89ffd26300f299a0f373288011c14f001046aa35b12348014bc4507457ce10684a164d958cac92264905f9479d7bbe235197ed9eb60fa5a0d0b5323a0d6ff7c06a8a0710d0d475314a37162373b248e3b88d8217f38c0135085aa27a85a55ab461543145b4e319ee31beaa0010dd659c7059ab89dee6060182198e2303ec105677c0203cea061c0f6553ecf0c9503de18da7d86e6141ae4418393b82b53ce488350903514e2518a0ae8d0093adc11886feb50dcb2b6354f7c2890243291d924c0b51cbd6892946cc50166c491ac65cd14a135d78b2ef9a233d8c8148931852ca2a00665dc960d50a80510ac800753feed10dc88c22fd400053d1ce0720b58c15b6eb9b97900cda7a1019de8ac10074b8821166e30c80fae3010ee2ae115b6a8c20758710a56e4a1769290c413fef0803f74e09abcebc04d1448076d14e1ff270a08493ecd59299b90a479cee39426caf04e78d664194aa8e63214101150140203b2c1006ed2473e0b988f0624e0406beab102f72dcb2d011a805364e00a34dccf1086a00507c2c881b6d2cf045328431e0263524500459c3618a92278ac0803d8400a3e4a918f2c0953167a904c348d69674888af07994083a7d9cf66fee533c9c87000f522a1748bf26419206161c77147c5a47a55ab66a3aa683633551d201c4638a7ab5f053312c85ae726f2621847188633b8400b19d0c02b70e5c05c63d857a3a24fc3fc741a0622f3c5319ad1af3248ec096f28003d9cc16d6f2b471028e1804ed3a84215fa348942bdd9bced4846867c1108c4652e51df11b315ffe2241d40e0a2d48a96939c04418e26495b4b58c312717042148e5b0b2b58a11687480114a2214b4138410e7960d73c6af91ff93cf78bd19d40d4042007ebe62016b1e8c20f628100048cfb0a4a100a2b42718a'
+N'3c1421090a28041caac980f8568050155805be3b600bb5916111a1a0437e43d292045b6a9b945adea570d2932a440fc1cb7802a66c216f0cbc6a34b9e1407dca172b19f0d3672d4b805bf0211f787c66c22576852b92418b088b0680f793810a6c50063a7c80c73f299ea3a6300502e8581111b40161d686d9b539d0c85b427265e0f542cf11b6363824410c0aa1419e7d715e60fcd70b5df3997acd50c237cc2119c45cb1a74e35cdd950fbffdad99e0d20b4dd13a3a0ea6f80e39c8f91010d60ce3b9de97c0124fcf919d378062d20ba0eb17485048987ab3794c2f843e306d089977c6e20c3a5cc0814d2b93921516ac30a5e64211b8330808b5ab1882c9483239d7e5b104aadfa20548df515dad1ec699feabce53ab576d4acec6b34b71691be45a14ded6abf700917e1c10981f8c52f02e1843844a316d18f861554810c3c584100c8488113bc601ae5bec596f2d91c6682f675d0e5210f7218441cb6e086709b3b110441c01314004d47f1f8060ad04207e000a80214a003da0b9b788700f1ad0066401bca813712a808e0a9c15a42799447e19420136ec2c0aae0e13c059e36b00cc68b15e468368aff42064860566e8603fe6cd006c0666a6600cca005eb2367260ca2c602030028f1328a0614c1060a018274629c1c859c96600a866e0775e2c708606d2ca46accc6141e438334c35d28a34b16e0045c88354ae88670033204c43336a385acd067b2ec334240836005ec0c060378216190e01d96aaa9d8cc13daceedd4eeedead00ee7b00eb341ee7e03cea2e3abacc31578c3ef90c015c6ea02c6cac478c3152ec064fe0c37c8026564e014c86a585026c32acff27c2ae3324c2930a0364881176ae11880c012d2800008800eb0651138edd338e2f55e8f425ef1154f8df6506d4736a46c562447ece88f38ab46cea645588db58a4f11ce60924cc103486a6a90ffcf122ce1179ce01907410fac201ae2000fb220080440150e401b550106940efcc0c43fde0533cac735680303d2440020c1094c271112c11818000118c0761a8cbd0865061a2c0970812226e2fffee09af2ad000b70be744211d8cdbc76a2e022500215ee2662a20331502225f203c6ab1a90607b48010d1d8a0b062d6054800b2e40c386e6135c8c044ab20f26a00ffa2937e00a8070f0284ee1060c6026c3a9785a8224e0000e784ec78690267f6c0abea0d48820b6e8c00943e006daa54b96d25f22e3eb6a28f1c2c3044c4383accc0bad5032c430ca60e83568c88472080c26c61fb08aaad60e08ec300fcf522dd1120fd56e0f7100ceee0e0d4206ac08ffd1efd8c1ef4c0c0d444004c00a0d2ec010c82a30ed6c3001d31090203003f3cf20e304e0c51c33cf041e03053e001df340158060148fe11844311a60810e508f151d000c268b08286411362d084ef3f502e9b2840c907244f6cac66c248917b386b33e8b0e6e04b48caff826e90c2ee11250f100500f0fd4e017ac01727c200aa060fd94810a4e60113c61116a410046211b956eb96c494ce20133a0eb66b60dfd5441006ac10bac4120be61bb9e001404e80a08c53d9f600670011786000ec6e009ae40bdaee91f07927706b002c40114a6c01692c000c86b7baa400124a55224614125f07a2a0e7aaaa01a307042abc1422f547b6ce32b4630c2600503c8ffea3684800bc2a258b8e013bc018d9ea206e587120333ff6e807844c25148429aa4c95184b0e7a6c000c4499c824c0376cd6c6e8414ac6e32dc25c936634b4ca35eeec584c2230fea6a00b02e3330231e54238cb4520c070b363612613881121ae6ecd02e0ee9302dd7f20ecdf42cdb7214f8100c44e01de4b22ef7cec402110d023132ef07a252ac30ff2c120593ace0c804202397e66586ce077d32c85e6a43156ac12dc91433ada0f4388dd326ebf55a210b0e60118613535991083a6d90400417eda6922a296f2e410abe4003a6c66c10031859cb5b14010614816f5e04382f616d36ed048049199cc0177c614a4409137c41005631fa6a611116011930ff87b9c40fdb1c6d40a246050ee1006aa138dd200208004671e11ffd139b00b29a9e001042020e94400bd62b20e3cb3ffbb30041e1018f077b66079ee6899e94804125f0213da5222514432df40387e2068f22c3362c3430a0c40c614327aa1273432c4ce0c586c5302fa0087ace065240468f879c18b44681b07842a2e752c0e710033112a3071e435ff8c383a230339c320650a008d01187a0ac10eaeaeafc4535ac705fb2940cc18e037801034c803bdec1ec3ae4ccce144d8bd668f3301b1c002edbd40fbfca2fc18a1dea140d38410516600456a04a350805ea658322035a322a7c1c44671acd041b046a6ef6732c53eec6d4518f0112564402ca01f528ff213535f53431f534e9966e1bc94388284c6db3553f8b932e415c2c64311083097fafa48a60454655926cad425ac102a624397dd51a7e810a04c10b0e605ab9410f5e20086ae1063c8c07e06305f0a13fe0418506040bf3c00bf4a0db16e70404400af2715006f201fa1320274212761277d64b50dc5320d37520edc216f86b19f2115e13f4e094c7777c67795cc22714a11a3ee04259417bb487418822a30c812844e336e867e5f4947e8865a2b84041bea230eb270fca807876ae9c1e458094001724618066200dc629477d3231ce20649b50055ea55f4ef683e645493fe75e26efaf46e834bc3084b0d24a772a2b61050b7b960690000cceeecce2502dddffee683fd84c3d381bdea163daf463e6126a9f366af34032ac2804ae885ef40c058641ec342f293c516784aa2970e36cc927cbccc832b3e01dca92edce523321e1375744350fe052cb2153cb6138659115b786449a0af6788f9328e912282893cae50c76516d04c35b7424478c4f0e48aa4734c00272f5387b3595a800135260516b61109c201ab2210b64211e46ce2d986b4ce0218c62c386f20006bca0165ae110a0400eb2400a6c81e67667df0ab05b01100003e50980970178175dbb5592f1ad3f67e078f34994a5170363e2152e8521154c951fd200aaa05430941514c1165465c2f07404bdc2610173e5f4d215526ce5fe8c7b0113310713e762140847ff622771815ee9f509e4f32e9e99639320050a8331640b74ac0e0ae105843a230690067448c304e0485f5288a72e83cab44e35c2d029735690d3309c17c61da22aed46012d41d89e3b384d3d6169dbf4abf00eef9ed61554e02469e1194cf41948c01948a0a0210f3c8c8667f360b13a71294063c24e08cf889484d251154601aada6e2d8f211a2ec103140916e0f65283c0894f731557ef5861af6b30a46bee28434aad465e4bb566af073ae94518c8811c68a74dc1b158c40b6e401733030f2c410d7c60037c018ed54016ac400f44691038971b2c20018cc00878e00d98eb74c9a43eee63905d371a5a813ce5401b0ac116f2800cd2a0bd24b95b090500e1ff0bbe281923268222de5a5df9b3029ee0786de17824a579140003cb200900c1260e0e7aedd502cba054726e9b1400f2cab77e64ce611fca30e7b4972ffb02ea321003330f82ce98b5809c560278bf15176640468190637bce0042b6d63cb12ab3b9e90c7849bf391dc7632a6fb69ce505ba26230cb3549dcb90cb12860cde908847010fd174b794fb683d782dd54e347140049ad69f5118ef90008ebcc3cfb6db8679810b7841f2c0bb13258f87c73b50a7eb0909f58c04e0f3a64aeef4904c35331a20a15681d3524f73b4b4a515a0381454f1f5ca2144fa36abb8460989a0a441c01827094881f16c5864a7b3c5c1e9c0be61015b2f4903bae49354690304ff81c3afafba02a7160ec00b4ec00f140a108c0010b85a1ef2a17c6c88284e480e20410f8c0d068a40118a8015caa108aea0933d19dffe401c3219bec4e1ffe6fa9ae04b7805920039f90f80b02ece09e104bb2263c2164ef9e0004ce17c879d703252aae014249b7cc50261f954e6c8ea284c8c2ffbd29f39411b704ee79260091c25020488414bbb9aec177f51db51d2007f7fc0def6200266c00058e19a796a0a51f6e9b62deada8813186d5f6a96856af6f27cb8cab292c9c02eea6801838b0143d2ce2cefb9b93f58edde212ec9402e9df6ba398117c0db67c74a06bc036112afcb6ec8048c46611f8acc55a0088681480915051e240f8418edd616b98dfff818b061102e01168013164aaf1c60e110e4400e2c55004a4a00f61ba565ba8abbe6a93ee4f53a4111101c024e4ab638cbc11dfc45e6a61580930e48ca14a44011467505bae46f94da178215066a010ab6800ab86114a815a128a01236000bb29a07c20475056a9f0e0461e8c00b60a116e400064c8a1590200fd2e009dcabc77fbc503a20938f5cae035278377e203be0bf54e2c9d72979e5ad220bccaf336519d4695eabc9bffe3a9faa8014524c30538c58241165b8e0cb6580140aa1104ee1140e0b09f89212ca81156c9ce8772e09f81c5294f95bbfb503e4f3b46700478b270d7ea00052e1ff0ae00aaed934dae55dc8a40ab9d9fc6a83d5c7435facffcc2abfd0c2e4c5d2753bba74e69bc319839fcad39dfba331d388413d84d3f4ed46180c6ec1d413ff9f4ff8ba6b5d7e02b1cebc43f32cf1d6c98a37f20e295480863668827b360bb2a0b8d78c838dbd146ab51314a91520c10bccd845e840da1f486d4c01c003fca509c947dee6d68a2f5c56eb6c7073a757ab464c81dd6975814c411c172005acc1de4fc04ab600139c0053493ca13640a18c000b523c0136e78beae5b62333da5f20e2e9c0c6e9200df45300dd5a778bdcc88b1c2045de93955cafff409a2a653d4d82cbd7c9253e80143e00e2000290ad21cb4029398810d48c2143e0d89a91c456a153860c5db850d1900c19a7366ea4218355a188b6a6ff942954a81a19245958d1f980d2868d293320ce80034a9212494f7afa7c822be80c50706ece48936a0f8302a90a6c50a162428c10162cccbbbae06a550b21624c400115030913266870321123edd40121da52e53aa92a55aa6cebd6753bc02b8aaf2ac6722253cc9f27079e3c8dca966d14906c401a3b7efcf85864c89421270683590419329a45a02183c6f36624ebd6b94283c69c67d4172fca707dd1101224a8d17082fa15c5b00913eaf29e40220ba777c508171e5c1831e3c6c78e9582e4e1d225020452103841c0460a1b52a41ca223e5c60d038a409473809e88060944dabff8f2858e845667be18b8f4459122531a4cd537e59f147498d24a7c035eff424781fb9922472b12b0b7c20af32c8047204618818715d1b8b0c52fb504218b1114ecb043241b5060041646f0904084f37035c004796040960072c0528b0002e421052e05fcf1c703401650419145fe5101904a1620ce134c76b0a4387ffc086492485699a495468a034a975e7e89d041cb0c51062ba790f2411565d82210415f82c2d03270c031c40c032d2311291a59240329d5a444ca2e677e90449d4924a1c049857c504e28dabca4482132cd54535170e092d34f3d75d0932492608a29511130d01403193ce0070645f01697552fbe68950569f106950a6491158a0c2aa435c9546d6df556b06e4d82575b31b0352bad2a60c08b5960a0779c72882dff06592d8e49068464da665b59b7cb6513c42d228c3b2e679c69b659b99d91cb6e6db4d586da6c67f1024357c3a0e0955e5f7d85010decbce30fb484419bdc72d936570a141e10a0460a696c67431a69d8708276e275379e7ef1b5d29f741ee347072c1edf279d01039ea1087cf021e8208203c200207803b6520e119e10314f842b2cb04038be58a1c7166b6c11cd2802f0b00189255280a2118000d2a23c2f4e32c10718e441162c5a0b40c714b83020e403498a8da491598eade4941d40590093054009a5925ace6d65d94f181466de612e836735a120110a9a659460cb400c3104d1e175d60987126396f1413530299004df8a8f3944490a28809222ac98ffd04a1e91a2a4800111277193973afdc4a9a63d2901141c3f14c0c018a93465431e51c5b0d53c362c6001f07225bb2c8d6585c249116a8540ec5b5bc9f5fcaf6ead756c57524d50c4b22670c20e188225779872d452866d65d896dfed638c8df2ce3b607476eebae68ab659fde7da5f1b27bac7708205fddb1b836184e02b1cf804093020164e20010cee70803f04e30f7720275ad362ce31b0010551d88000379002d7bc000339d0810e72c0181dbe200545186085d9f9c225acd31d9079cc0b06908201bc40809441400a2e73a1225ad10a9001480a5e5044821c1404223c4867395bc00a64a187386c421050c84616169034a5ed60032a52110f22848f17ffc5484679c88200ac20875a78a10bb4a39290b27425b35d296d6f53db1f3ad0367150298e6933dbdc8074104fc18e27b00b6442f064806a6843249b2b83026c1191cc1d0a758ba31343ba84b9386112147c83539d20c9b9937c201459c8031d227503056467264b401d1c74c2139faced099c6add4f7031832e306029a940000262c08155f1ae2a59e119b0bc32011564ef6a64318b09a442ace6458f2b6ea1e65cba82cda968139961d91e19024641698dcf7c90291ffad2a73e70bd8f5cf7d34c6836f399cfd80f7fa041431678b7b305c4231e2118863ff1a517b170c1230a744031dc511c4f3c1082c7f184f82ce81c27a4e0040272102c5a1184452431ff8847bc84222e21a91b14e2126980c80aa5101fe9d890870b23004a2f61b2115e8287324d99292ee185132c481b0e92c00188800f9dedec04568002153611050104010617ca228922812240f000101192da24c69887acaa228d04b8c2db7e24b60abc718e4a12d290f6a8a4b5e1714955e2231ccf16c702e8cd717c3b08dec2c4c9bae2494d8e8cc8e61eb99086d4692105f152415ed12582148421a0dc1c4a58110a5316213c06d8dc1458591350e0a2909bea00036809da27f024964bb0dded10908a2b64af37c3b44a56b41282bce8a59b64e1c46d783515ae44cf79d79c005ddc82cdbc48250645008b0968b14082854f9c069b0c73b8f55c74a2331beeff6327bbd6d599d0c8539ea0d90c3b5470029ee9b39fc370c63078c10b15ec060518e0020d2e800476c4d7a0ee68600403e3c0868af35a0883020170c8c34300b115b598cf8049d81df2ac8c004b50800daf43c3185ee2a63824004c519a5214ce343fd271290c46d8d3561c603e116a918b4e10084c04a216465b8011b238861dc0610317e2c1171310c679102b995955812ae870021f2d256c65059290da36a5244f494a4a7e1b1ed926b7baf5d18f7254022401b10cc7d982705c2edce1c654102570124e27298323370749c335640680580862c75c58c4821971882a5d193ce792222842a40a9809e56a52a9c6c532b43d61802d076d035ff4620f08d8c3ff187cc001157ce0585589c784b2b215e2a9200f24c09a3395d72bb9386f9ac035165b4cdd15b57c45152ae005f79e5598e58aafb9e42be7b5a45b19c404615cef905fbaea073f74996bbb79f0952c8ee0cf617c8217c7a5057a05fa9af822c17dc538a83b22f840e3e8b7829141581cb0434497e2d0064510318147081ef2d00104274ca10bb3e3d2ee9c10401ec08e4b3f8ae14b9ca086f731c07f3f3cc2723c68c4f36951025814a105f822105658c4010ee107a7c618aa4e9baa89e7118fab4e800359d59117b4b014b6fda86d603deb93dde6e43aa64d6d715bb9dcb0e4c73916a00c55a842121ab78c44d17ce77cedebe5f8668b9d9f59015378c8426aff42499c641993709013e6ec94842938b608ac2842210c50061b94ee06539802ea2aa559d8c9925383d6540770e18705f8211563f8c10ffc400adee4a577ae8a475584cb17ace14a7f69a94a5c5a0bac60f98a7ad84cf5f5a4c25eac71e259c69196e3696dad5a3f97d6b8764c361cc0aef8fdfa7ea0a11f3cc9f05d14e8c619cef80417b8c00b5aa0bed526d8087ce34b09e254fba0015ba860b4edd05977fb188380821770ea5239106062e51e702b4ca1b20199820e1fbb0e0f678aa02fdcb43b04b8cfca9edf1d1bce3485202e47129348e2042440aa5fdcd9210e70805ae0a111306e808c2940fe155c1c1e16885111b23a9d255cc1b34e7adb52468e64ff6f434b4fa6564eb2362e27256ba56454164772a42464626643f0045aa6735590269253736a42399464399cc3577f05497662130d1167a0805843e0498652679ce31285a000a9447444e7755eb7105db213633780aee3131190063e2008bdf003b6b30179c01bb96501768769cf834ccb842b66516cd3f43cba654dc6826ab3722cc9525cadf637b0967b8ff75095f718788007024079e9c318d4655df3b3799c374fa0810426c00b5c400baf210373f811aac76cf1c50eec4006b18703fe606dd7f6400ad550c9d185b4a62dce010552b03002521d14950740b408c70720a6a00dcb275337b46f2f657dd281435e4044d6e742d9c77c243353209605ec017effa6207f3ce0344ed322312000b570082b40015924090d300691702152e50755052b93f0019b260529e003b870058506149dc52905105a57e02992008d4fb0079e524b6ca3476bd57258523647723646926405302611916513a8658563665550
UPDATETEXT [dbo].[Picture].[PictureContent] @pv NULL NULL 0x0deb88816676282888278b52086686662348496fe6254a873885f3572841072e58595ad77593f475386110b29483d7584ba0b504be20081be0836e972ac2f4165a614c7737407cb169dbc30959201537501537306a51085cbe951703942fc2854c310016b6f217e094188eb718cc058640100d82a005b220009451868f310aeff33ee6a286f0932edbd55dec803c65f15ea7811aece00a48e00af22595944006ff60307bd7565f8c505f12847b052393fce51cbd471dbf975352700223a40ac737201a40892023072a151ed7c74352e05fd547442fc543a0480767107d30e0320e227006d60ae227554c732146b00237600578e007b7b80363d000ee476358606351035b03b469363003117029577005b820095a808c9ed9299ea20573421470f00a5a509a9e928cd1d80192a05627b772e0f88d43a2244f00744370102cf03a74c58f069012ac203969b23985421077a6816876280f91748535679f14758e258f7d665952772880963a9a5576a0b536e2309b6a850bc6e80be5f99082600151d11bad721513022b16d02b5e415b49190320296ac44492b2926a31722cbf912fff4bd892b5f50e84216bd32293067a86baa73e5130061b7002077086e9946b68283fc12694f3c45d68b008f2f21aecf019eae25d684095ef509508457b5b89a2dfa35f5e394edc823083f08904e05f30206f30007000727c088220008220a0389735740930609704e097d2f1518a4053462a42cbb77c91686024c62280c0349140a546e00715f36249d30057b08bf067635023215a7155c3980736b00453505244b1043731276ddaa60cf13449f0340c11095df20a70100943000891f00a7baa04782a5a92e08cb4a4726df5724a3625e6c89b3a28267862128af001ac409c69e28265300599a308cb799c93d4668763498ba33989229c1f1029964539333849ff81769062979003a856e0f9040f23083e609e3ee00331101585304c768715efd92bd803159db63da1b02b51b8150bd03f81874d52817745e8acc904168a4709b0f678d4b23e5e386b06ea189e500b54b0010b800c8a21a1110a1941000655196c150a6cc27694682095b42195ec4009eeda87f563955869a282787b9e706d85e85087686bcd119638646fa4280746a47c95788a6d2905d4610335f47c39c497a088422ef405220409082242919820227444a690071240982212094ac38b2b6001ae58b290d900bc287ee2e70757616955e1155773033690045a87b388722894f35725a000407b668333a74f03082500b448cb65463b047c2a9bc918a80a2865ff4bb647e6688ebd69b54a800b8b35038f5a0d92ca0a94fa4899b32866660bccf9758b73380bd1b37d264a1f603a31389dd9b910a899136177830af9aa0578032910083e589eb48a3d9456159716a6b032402dc94c26803cca630120e93cc2a35bdab4acbff11b7b911b60914cac371c848118b23693877188d84a9388510bdc1008d4500b0693a02dea18bb4694168a2eee346cf583042b011a1e0a7aa027a2f5d33ef73a7bd6064ee8517b83182d008b8807a3881e20054ec01d368a6e23141f95c87c15357dd981a431c4432b331dcfe75124147c411a1f5fa09638ba7cade007e3c7344a23095be40729fb629100995a007fe2277f116215f447351360b3ffe2d167929275653009f95006049c8e1998813ba70b66467355700e0ccc65490b0843f00a3b71a7af10099ee27267158e1d80396a461061820b73a29d33a000906a26613b8f45c739c6799c6956136b5b139024758df401ff6803a924755e171147e7253b014b99c23ab3099e4d020a748007be9002bee00381a0c4c2d45a57a133af557fb4723563b13d4f68ac51c83bd39391fb92b9a2971bb59255af46a05f3993d960183129ba05ca5c6aec0940800727800e8761ad69cc6d8d81864379a1c2c6aef114a27d28a2bd6bafee83035b1941f5557bf935300e34883159adb79688034b079f9852d2d16ef1710600e25209c2a35220079f2c20280520ef6600ff7ec943330a7ddbeb422344bd74307e3c400125bb0391b98b4690b22762b2882954ed6977b2523557a367568712f248a916f80191e327a4e027c96c81ea5873d580c00e6c662530388433a7afa0a7138cc10a9836de3c2541478f637b499f32c2259c5785339cc4e982679b12f3f8571bb838813504d3297577460a8aa075719baa3651b75a7b37929013a305b5ae5ac49f9504725021e5190881200829500437c02b93d09e4ec4445c415c08c40b58434a2af0b8c7446a5d3146c83401f712c62d592bc6331c82113e76ac3ea36088fffaafd5ea78b1268627a00adf52baacdb6bb33b944409c880cc87de354f24ea3e5579c85a596d8a0c4e10547b0ae5c8ff338dbcbb8730a53008193b53d507b19d68000b46009e6c0a9d30426750bd3d041f74401dd4a108427a96a068442bf3613b6a0a7e690009e007245bb291b0a50d00074e748b794d015f240f2b2035afa2bf31c20124a00d79f00179c00a925604c9cccca4c00a5c700aa7400360cbccbbe00decf801de90ccd29c263537090f4c8f40cbb4673ba7b289567944253f3204f318498ab5aa4231034bb0a68ac53740f7b667f6cee3dcc346279d9a0339a46a9d323190a80349056983d1285a3f918c868647b0fa04dc41000b579e0e496e31a0ab71711583cd4453239f9c565b2650045591acd284d1229d928797b92a0016a2572b9cdb3d678c1807904e8911d3ff30adc6fc8dad305d18b5500b68e4c65ea8c7bdb64eb22b94ecda869b41959b41a2e78a1956c9084a5d5f8121410b45880c45bc82'
+N'01c768eca202eb1ca510072f95d62705010690e229431d298052ccf7bd70296ff8a1081e90069c691dc3570422a353398aa4df8b7cdbe70780a022b3fc98915922848d2286690409203552033d72c11b1cf039ace0d8602ba9a1700a920a13c5cc39b67010a2b48ece9c81a39d819360669a3038d75c0247cb26aff00aac8d9b50b6644f808277f5dc3e013bb8e4cf300c669c84a9d590288ab00b1f30ce309c666d0b39aca008a883285c47908eeee8a9b3599b154b0b294be0c929b830050ddbd078d0c4be200ba0c63cff521c21e92b21721123da33acc5669fc043155dccde72e7aca267eb911669ec553cccc6098b60950eb05f8e01a1001e6b0dc5df335dd3705c18043aba6ffc18b00ba216aa8646d9e06410e1134ee15a99a24e3d184fbdafc59b7b5da8c7545dd5d5a7d5fef6b02bb44210f051d911432e157d599dd6395c1d531001576a030d9320cc6744a6907d3c94bdd9eb07ae28a52552b29210632b100f8d708b519570aaee5bfa2b8c1c170a156ff116cf0a37800be02c0e1dff071ddf244f50280a5005c23809a42dc06a820f0c7ccd5b16b42540c138c1137ba4725fd50186c459af33819d82298c55388563279fc482867e6792c3c06846390f71b634f701a74028ff1151c35e47745a979d499006a98a9aacea9db6344b703005d9810729e0b70b7703bd0192392354bdac63033000da833cc46a9fd1e32bb1c5f6d7834c620c16918601c5834024c06cc20118dfe3d296a7dffe6a182baac65e5888da46bafbf59312cec7175aed452d0260e03e98510c15aeed176e7b1dbee184681c0e540ccdde5c935c0a23ae0c9bd9b533b8c353603a35547dfb461d14558a5faf99f4ee0706a00669d04166491d2e836ed95704a598420d3b55ae68e4484ea52b1002b23ccb157715b1b5712a4015f4e715541e0a8bd02880130a45900406f8551f7f807ff4f1e220112851c08932099b63c02b8fb4671bb46c42c12698c17ba4476e334bff773381b0b4f300a1440928814f9e085cb66c862d050d6d31b435a5da295685149429c4ea43198e651a36ecf8a15a2856536c25518032c9ca245314d8b0e112e60d1b2993c011284992c10e3d3b187c52e009ae1969d210b011084f0a412962c4b01075de0aaa2b1254a56a21448c091c3098c882240b540b27a29e0d6121c6d60113dcbe9d8042ae0aaf18ea62e06542af094e94de15f3e7c9533620850f64cb366a94604f41043b76cc98f1e26c832d4b965c793062c4a312730642388808d222de8920835a3599d4ab59bf3e0de61d18dab571146394db9d3b46bbfdf97300fcb7a7c0c5891f071e3c3067c2840b173e06e4d8f452d54b5199316349762d2e70b4cf6899c406d2f145c7c74c11330d9c4206d2c48c90a650912274e8102060dfbe29395260d887411101910a08003b
')
EXEC(N'INSERT INTO [dbo].[Picture] ([PictureId], [PictureName], [PictureContent], [PictureDescription], [PictureLink], [PictureTypeId]) VALUES (''94746da4-31e6-49c8-bf18-746b0b288ce9'', N''qua-song-bang-capPoko1'', 0xffd8ffe000104a46494600010200006400640000ffec00114475636b79000100040000004d0000ffee000e41646f62650064c000000001ffdb008400030202020202030202030403020304050403030405060505050505060706060606060607070809090908070b0b0c0c0b0b0d0c0c0c0d0e0e0e0e0e0e0e0e0e0e010303030605060b07070b100d0a0d10130e0e0e0e13110e0e0e0e0e11110e0e0e0e0e0e110e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0effc0001108015e01ea03011100021101031101ffc400b400000201050101000000000000000000000304020001050607080901000301010101000000000000000000000001020304050610000201020403050604030506050304030102031104002112053113064151612207718191321408a1b14223c15215d162723309e18292532416f0f1a24354b2c26373a33417d2835511000202010304010301070303040300000001110221311203415161047122130581f091a1b1c13214d14252e1f12362331506728224ffda000c03010002110311003f00f68c76af70dccdb37115392895e48dcf850f971aee7d0f461760da7758888b70133055f232ac656a3b3516c2dcc6b4216a660c68d244fc191a87ca78d573c2de281b864dc6c79977b61492d1be78b4e40f024296cb09da3a0e13c13377b824ccb10822e62111349132292dc7cc09a57db852a740f91390f52238b97580c350a74286439d3303f3c4bb7882d24cc9c979769242896ac08219add4550d47656845317bf1d88551db3dce38b4b25bf2cddb145151f3d695a1e1f1c154b5068726fa78922b599a492e54e732b10c09ee228698a8ea670c4ee6d5ac88979b230a6a1a94b2d3daa2b9614f91c16846d52cc2e6f96271a4d4a862ad5e06b81acc0d487986d36d6fceb59658a3f98323965f650d4d2b8127dc352d25fab244d1c72bd8b11cdba0ac3cdfee5704a2923306d925801b3b87d120aa48d991e06a060dcccd54563dbae6ddf993c893447fb94a7b083967886ca0a6578c9a55569404024fbbb715a0782d14d044345c4da4d73d6684d7bab8490e1b1f57808ffa70a241c0935afb3b33c0e7b13005a1e648cccc558f15cc2fb299e2b7328988956b19d4808a0233cf09b624ca8d348a0a10383114c26b20cb244bcde6100532182402a0456d55f31e2140c3f022c249e762558695cbcf5cbf2c109e47a058268509122ea6a52a32a1f0ae08c8ba0b98e569f9b6eee8adf3a57503f1c0ac381cb49eeedead294d0326720aff001230fe097046e656ba24428421afc8467ef381d871060976cb469e48e33716e4d5a8cc28a7b803a4fe78556e06d98e97ea6d77148a1592e6edd9540685cc7435a96968500ff78fb3136b772d2c11dbb62dcf6b96e2fa36b28ef6e2669662542e907e545edd2077f6e78545d44dc8aee7b85e8be8e2bb96de44951d23995d42a49fa4934229c78e1bbb1d6b893cff00d472fa85d33d628f7777633ec6c0f22f911dde5506bfb8a0b00c3b48ca98f3ddec9c59283d2a56b6ae13364dff00d496b23249baadd5e45cb431ccb68fccd750da1974ad280d55aa41c6b6f668964cabeb37a60ab2f5d642f05d5b59dec96ce5d22596340a5940d21b3664c8d6a4ad3b4612f728f3fd06bd29c366507aa7732df26e5b8d9badab178646b29629bcd969d68a5b35edd3c3bf15fe5d7c8bfc37104374ebeb8def6d92d3fa4b4a267e5396965959a3d428e45b9120a8a7cb5a77e2397d94eb84e429eaa4e5b34edeb69ebb6daae36eb7dc1adec54948f6cb959e7b736c5b23aee96e2449076156d34cb1c7c8f96c75f1df8d3984d99ae9be974296e6fd1af2575205d2bca80050395a3cad5614a5415e1c298de949cb9932bf33e86e167d3efb3c36eea65ba689736e48593d80a685ce82b4031bd38f6e7a9c76e5dc4aefacba9b79be6e93e8e822b9bcb208db85ccc0cb0d9b39f2b5dcaba14955cc41193349da517cd8ee49a87658fe2ffd0e571d3536ee9ae89daba7566dd0dd9dcba9afd47d7ef17c02dd4a066b0a8a0e54087e4893cabc7ccd56357b37f02a2836e81c58daa4524fcd66a3538853ddc2b8523f25a7babb9c88d660ae720a6364a7b0b30c296106326feab6259e5ba3704f0b792688d7d8182fe7872e323d4b5b5fee9241cc30c56cf4348124e639a640b15a0cfc3e38956712d0a109ddddbc3308279e34dc27f2a0a799476d1135b9238d32c2dcfe0b8fdc3c905b595c06524a05258ca16aec454305075654ece3812ee40358afa5311b6b61e7ce52eba7cadfaaa5fcb41d84612be7253f2124b18e128f1c28a14008e09f33d493ac7c3318a5814c8cbaca2d3932c914649f3664a0ff00c871ae130c4879adc5ba2b9b866214b7ed474d08c33258d72a71c29c8004733b158aa15728ddc15e60afcc4d7207d98af2104e6d2e34dbd75a8150bf28afb47c461b40b02a90888132247abca683253ecaf0c3a8a460cd6906858919f5fccd9d2a72cb88a61a50100ee9a21f3d22951aaa54572e04d3b4e6307910bcd68b2b72da789dd412a92008eb5a572752a70a3c018e79afa4b96896e046a99461548c876659629586330de09e56d4ed2494553aa3140476ea38587d0321e48e179f5ccc8b15415d61053e0a70e02585fa84ee5f80e1fcdf2e2768a19aad82b3d649e27b466ab46c1c347ef0687f0c6726b03d1b5f1adac7125d57ccdcbd0c00f1c85306f8d4982f7504d77ff4f12a223a05701f435471d2ea0d3db8730056d76f1edf6d7104d652ea06b01d5cdcff00bcff003612d4766d829defa35792de1b969a301a5332ae8a13969a8381d902581888de8b52d711491467cda28a43d470a9a118374b068762fa192d639045716afc39806a707bf554d570db143d05ef2c61bb852e279238e68dc05b94aa07f68e15efc34fa2122e96f35acaa9b9732e2dc8ac3711f9994f891d9825b13320a2fa5809b4b86d2568a5d73e3c4e29b0453c90a05e64802573045078f670c67123272c91c8fa6e61819187edc88c003d94355181a1e85edade486e9614056d24f912b903f1c11022f757276dbb643318853e5963664f732e04d1490dc37724c1752a14719babe63fddc2240c5159dc97686e2e20910f135a1ff88530f21d084a935e4bf4d34c044a2a1d452bed1c30440742d08b8b252d1b995295558ca532efe14c527dc581b8a58ef543ba3a643e65d26beec4c6008c9696f700b4645789292b23547b0e2b290d956f64e8086925507b4cdac7e2313229941dbc8153583dc5ea462e7001544617f718163d8a3f2cb1391c94ee116acca507f37fe586223ccb70068009feee7f96124c659c738688414ad353b1d3f867879e822b94eaa637b8aa770a9fe03132f41fc0096caf225335bdcd22391575a9f828c1b87288a191507d5b45242722552507ff0050385f20c5459ede6426d2d98b1cf52c8cbf8100617509149fa561bbb9775796334a95ca420f81638227a97bb01ad7a46c2342971f51296c89911141f803895c7e49ddd85dbd35e9c904a238d9438a12a457f21887c152972d80c7e9bed22dcda90cb10af9e47f3377d7c3c30df1282bef3d448fa5569cae55a5df9730c1d39aa78d2aac4838cffc729fb2e441bd25bf495963bbdbe3b79086d11eddcb6cb80d4928ceb9f0c4af5e1e88a5ec29ebfbc707a65b8a056b8dc52255a0530466390e9eff003303e3518d3ed39ec47de4ba13b7e845b667927bbbabb247ee1f9bff00ba80780cb15f69f564be69d1190b6dbacece2924bb0d15a40a659ae6531a448a8336762d45503d80635af1ce110efd59af0feafea5c421d80c9b3f41b968e5deca94bddc54e54db15c56188906b3b8d4dffb6bfaf1b36a9e6dfc3fea653bbe0d82c765b6e95da97a6f67d9b91b0db82116db4ac64b9ab312cda8b96cd9892c4f138cb7a9cc9a24886e29b9c11b5b46cf26dd351eae866923ef45d01bf3c4dadd0a4900b75bafa4312c779670aad62b9158eb5e1cc45d4695e383738c306a350bb7584cd0b477176259aba958c8cfe635e05f303c316938f226c8ee5616d135b5e5f5c88e4a156654aa9a6752021a1c43a8d3f03b1d85a5dcd0deab09214505246c989a7ea000cbc3170e45d208cf2edb0ee68afcb5b89d0812e835c876b134a1ecae16d861d086d57fb6b5b5dbdb46f25cd754b70d532b15a8a2e90694ec032eec1092ee373d462d2eeee8638488dde404c772de7e52e59220622b9915cb16ad89815921a9ee4bb31b372d295d28b9501ad6a4f114af762661931dc359a470b2f2f992172ace85d8862a0d684f11e187fc4642e629a5b896791b92f7210c5102166cb261a69d8057bb131d83a128512270c1dccb4344906640a02d90a52bdf8a5339c8cb5cad40e5c81236050b2a2d41241273238e14b1153c7a635491caa96f2eb3e6eca904fcc2a7b00c34e5898392dae132597f650670851500f88eff0001872c304238133e58f39c86b399ff008a98a05e49aabcac15d19d470901a0af6e589c4868542b5d6c17389f2ab71a71f761b68182bcb98e3b8a9899aa28c29ab2f003854e5855685b640cb2c576e826b768a202881869e07f51507f3c109bc0d20da76ffee71d3c4f1ff8b158ee4c335b8f6c92de78e49a11246c68f1957eeae5e63c318cca34a849ad36b13bb41132329ab189cd29c48a6a0714d35d425823676577fb9693e962781f2907e2706504e42c96b38b7e5b496f2b29a2991992403b7cc08afc304b5a80f29dcaded52d6e6d5658750935a4e7537700cd9fbb0939ee2480c1785ef0911cf6ecea51a096279232a7b295a8f68c0ec8a689b08b6d992dec1b977129cd8cac2150788657efc373a82237077048d2c2d12d6dedc9acce26120d47b541200f61c26e3a64206ced932dec222943ccca06bf2aa37851187e584acd224720bc7b6696ca781e0ba66022c9b96c3bf59069efc1bb3238315b86e02cdae2169c35cd2b1c28619399dfa75329a8c11dca807b341d413a97e6471281aa35a00c18f10534b0f8e27737d056da87ace4de66045da453cb1b13a189848cf260c869f862be4951381a8af0ee51b5a5dd9968d4f9cbc8258fc3ce6870618fca12bedbf6d4448d609a0d468c602c687d8091875c4e452d8ccf636e6358a7463128a07567a8f165522b87f225a81b6d995754db75ebc0d5cd1816434f03523df84db1cf41c58b716510ee08b7284fce945d23d80827dd84f23580caf35b4bca63124438ebd75a76509cb0e4490e45cb76d6ae9e25595bf1c37907254b74b19f332151901a957f32309a6f41416faa89bca68a69c4b2d3de6b85b4701e255a821d5d69d998fedc3924a5950bd1cb507729ecf1c166ca8245555b528255b219fe55c2913452a296143a478f13e188c8c87d75ac72373268a3719052e953f1c5c36c20849ba6df1beb377154e55320ccfbb0f6b0c92d10dc233a4ecc8686b1c84a9f70e38500d96516e8e480e0d284924fe19e0f816422388f5088824f86927c6b4070550fa13f2155aab194e75249afe38a12231da988968d8ad47994675f79070d0491a5bb556e6257edae5ffdd89dad8e4343c9d0190a888f019767b32c0a50a426b4d3fb6c4a9e1e34eecf13a0496649648ca9a462b939a1cbd870e1be806b9d5fd51d31d3164b3ef357b99cf276d820577b9bdb920e9b7b4812a6598d3e5032e2682a7174e36fc03b41acda7476e7d713aee1ea1c30c7b75abc6fb7f47a3acb04322d1d67dd1d752dc5c29ffdb07e9a3ee76f362b7c28afefee2db3a9bcc9acb4e934d2b4ec43736a8ce299548d272f763352869085c5c6e6f269db596580903ea2468c2923b0a05d407b6985235002f05fdcde44b0c6b6cd15799346f99ef0833535e198c1a6834e06a3899e260a890dd920a310ac4af6eb5068a6bc6b8513a081dcdb5c43073ae1e3879c464232002bda7493efa530921a48c3dcebb5b98dfe9a4dc15c6998c48ce2833a5249341af80c3761a6310cd6135b3da184c36c15835b48ad0b05e14557a0edeccb02862dad17b1db6d111be92521a9a555642fa52b40486a8ae16d0b31db4b1b38a149092e4b509426945ad0e5dd8b4ba206c9c9b6421c4c218a550f52ce6ac72a5721c7b33c2d024946b0cb134260e5b201a757c800e22a3b7c30f0494f203722081556565f2f9db50d59ab376004e06f0090e479cb187501d4ea62630d403262a72edc129e061649e372639918b28d4189288c6be55ed35e39530a32085a2b3b63702f2550c9a348502b42725cd85465961a1c829d9dd8068e33331c8ce79a5428f2fca0914ec0060ebfb21680e41756316a0aa75d35b46c05476d55f4f1ae2e4224234d04cb1abd490ada1400598f83034a607e0016a133ac56c19953fcd4d347048a6649a529dd84994f05c42884e904a3514508619815639568380ae1c92035d26ccb46cf903467a77573229e187bbb031e8e191e25d32ac8ec0b31234d48cb87677d303ef02817faa8ff009e0fe6f9bf577f1e1e187f48f26971bdec0e5a19e4881cce97523c72048c6766c6e06229e6862602e1248d8ea7e66ad55ef24532f7e04f3e44596d142f30725eac34cb09ae47b08af1c2636ca92d849385174f5639a001597d95a03eec3cb415630cb259ae89b729fe9cf0e6c4a40aff00e388c2cf81b637630dccc8a60bf86626ba6acc180ec2086cbd94c2c830974db8ca161ba861bad140245259b578834afc714c50302d2d2ca24b9540824a878c06a2bf61a82c57e0710982108a5b2b99859dd2992e0b125d5c928bde02d093e14c36f038277bb6c77b6cd1dcca97b0c632ab3a3691d872ae5e230a6469f616dbed76fd9a547b0b2b5879ab4170a42c95ec0eca0d7db84ab51bb36b51ab8805c5dc6929163721830bbd206b3ddad32f7e29ce84ce0a976adf0cf24b7cab710e7cb984c41cfbc05a60dee41c332104af2db0b28e055650010ac4a9f027bf0d5a098052bee164ca22856045fd068fafd86a08c2c0037fae948782f84739f37264514ffd4c0e2a70349490b7ea2be8e408d3db5dbd7498e20a5abdc34b93f8622515b079afd2f5a34b980c284d06bd400f1d5e420fbb0d3ec440e8d0a44719692203350e1bf039e07940e48ddc34a3c36093961f3d1401e14a61620622d1df06006d5185fd46a86beed38135037a0e24173151a3b68621d8a149a7e186ec2d4387b9a54a3228a55542807e27153d0482bcb2246644d24ff7cd29ef030bc20862f1ee51ab72279a34b827201b5afbbca30dbec38932301393bc80d731414af7d33c43f22809711da48a504209afcc42f1f0efc2490640a5ac09479208c3d380403f861e019258b58a80ab1a939039d3be8061ab212241888eaccaab5e2450e5efc399780640e9914e83a9b8834047b2b5c1e4722df591a38e7fed0392bb90a2a32c112c0bb5cdc3652269b302a6449388f10a2b860d1c2bee5bee77a73d087d93a5a3b3febfd67bf069a2b1699a1b7b5b246a3dddcba02f4c88445cd88e2a33c6dc7c2aca5b832e4e5da691e847ded74a7aafea827a6977b08d956fb9c9b06e0b76d28b89a205c41246cb446955495218e7e5edc2d89e8d97ba753d5492bd7991c5ccd392e860c4538115a65df8caca30ca835cea1f50ae5373ff00b43a2f6f6debae688d7162ee60b6dba39012b73b9ceaafca8c80742a86925392afea14aab57a19bb74429d3be9b4b61baa753751ee237deb6911e3b8de26574586276d5f4d656e18a410a9e0055df8c8ed89bf237d308b4a3e4dd6decd2dd9a4ca49ca51db2d4c01a804d457c061618e48b490c970a8fa9a46257984103fc274e5e19e1202ccf3133b32561002aa29f3494198343f0c18060d649cb73a22ab398c06d63811c134d7e6a7861e10a0b5b4ef223cdcd5665d3cd431e920115ab7139f71cf0389068c7cbb3595eee4fb85d43cfa006115d3e75cc3215a675f6e21d7392d59a58003a4ecd6e5672b335d4b526577a104f0e04548efc1b63a86f0f2d8dc79d7eb5a8294aa82d90ec60456b4ed1879044d96481c722d59ca80ee635d01815c8b13dbdf9609485124a2be49d55e5343231a0034d07b89ae18208f13424c92693af3d62a4b006a015a760c50a01b5d3c72468c5b4c872088ccb99c8e5520f61cb0261122b1b5bdc5d6859447788ec2e62a11211c2806915d3c7bf0b5ca2a1a1e75576fa0bae6c0c6a23768d996414191a13a4d4e59e16e0824932a954d0f2aac8623200aa548fd62ae4d3b0d3b70e7009752d22c9cc3f40565577fdd6626a845086504674a78604d84648949e489e6959e1650ac751d45482410c3b43771c00943253a4af109609f5cb92bb351569da554a900629262485e592589b4cb1c73ce8bfb6b40e403953f4803b6b51834e8000ee82d2ee1b38a07d67500aecba4134a90559e801ecc356456c90d652dba168e37568d99991a1d60b8ad1b32c6a41e398a605a0a094b15949334537d4230f333bb2a839fcb529c69e35c2f801912db22858ad27d1a8aba061a5401993a80cbba98000fd6edbdebf3eae3f8f1e3e185f6c326a8af6cf234408685bb4ad295fef569f1c4b5d4120725ba43a4dade2f6a9398ece0698a49f5126c942b7213e9c1b6a529cc00020f7572ae1a6904ce4a9249ec6402f122b8b59051c6b66f7f9aa0530ad3a8f104905949286b7458ed0ad0ab0d62a3c0659f8613f90c8c5fdbec9f4ea6d67b7b6bca81525821cbc0820fb7056ad21309b7a5dac452dc5b4c8c3f7c45217d44706a535023b303d320d875b9a330957ce739b9a8e435386ac87c78e10d85b892c2f820e6c5cd1fe54cae0b2f83e609f767894b3212d0381638653009678e573512281323ff00c40b8f8e2a3a8c9df5aee3000628e59a65351730a82a14f634649afbb0a504a60e6b9befda125bcb228075388c475efc98e0648ebef0d691229b49da265f9b4d69eda138a948a485609ae25905c2c126ae2452887bbb2bf1188991686524dcee4279ad0914cab565a7b547f0c3c092139eeef67ff336de7c2d96a47a103b86b5a8c0dc8f1d190b6dab68b86129b5b8b16ad2ab21049efaab50e2557b0d599906b4be84f26c2f5795d82742ec3dfa862907c950c1bc419dcdc45213dab1e54f0cc678249c0d4b7374a3991c123a914600aa95f1a353f038a940422669c147865f6b8040f61a9c24c2202c51b46cda247515ae975ad3c012304830e5d5db5312481ddc7e3842821312233246684506923f80c3dc36a01730494591321fdc247baa306006609d34e90085a1eeafe78148a08c6111f523f909cd453f8606e464e5bc56a464509141dbe1961750122d7d64c5dc6b8ce61843216f886230dea391c4b88e75ac8ac8a33d44003c7e6c2825604a4bd36cd249185ba8c2eaa2e95a91fa455a95386c702977bd3ca1164b3bcb40c408d8c293a54f7f2d9a94f1c4c950a0b5acd7ef388c5e2f2528de686355a134f3056a818a2663a1f15bd76f567d4aeb7f593a8377f55eca5db7abdacdec21b39ed9ac0dadb248eb6e5216a10a515486fd7f376e3a57357fdba1c1c9c6ddb3839b74af5ef59cfd49b5d974a493dbee96cd15bed4d660acdf50c742ba14a31919dcf9b8e7dd88a723594b25398d4fabff0069fd45d67d53f6f1d31d15b45dcdb4dcf4dade6d3d65d5970f1cf711df5bddcc6e6d36d4ac8b34da581370e79681815d6d961f25e2db9e5b3a2b2f077fe91b3d97a636a7b2e97b496cec5d9e598bbbcb3cb335034f7134c4bcb2b819b3b57dd9631df39d4d1560cabee36eea0c0ccf11af3108a0a53321cf603dc70b41a41e1dce59a1a0859e5cd94212f4a00410471186989a0d6e7f65562a0908059997b4f7134a124614a1c078e6b98d5835b69885396026972e723970cf8e589c31d81fd38b55593ccd3eafdae66724608a91ac2b5387138702592e2ea1dc3976cdcd5b8916b2c61751014e479ba6991f1c4381440268248d2451cc695f28e52aa5d581f99b51a7b28298bcb1c90dd203f4a82ce72b3c6caeb712fcda80e04a80ba4d3870c0a564004f797d3c1a9e3469001cd897fcb61fa8a919927b2a70a61e80855773ba987245acf670695659658dc034f2e9028780c2dd25ed85dc6902db208a72d331f949d233ed39018b5a12c32de43200d22b08d9543c6c497435ef1527bb03080578e5eaac64b748bcdcc074914ed2d5a8ae55c1ba01a1b8ae5d4c72214966c8a12bcd65a8a6a040ff006e1e3b12cb5cdc4f2877bdb869208eba94820d0e598415a1f6624a4bb00adef3208e4516eb2e48d2b0340a3f4b65c476533c3d58e495d490dbcdaa285e61a0f9e32796350ed06a6b5c29814978374dc9acd4b72fe9a54a3ca8e15500041a8914906bdb4c0fc840441235a8530cf345a7968cf9c6fa8f12ce029cf15806f25e10f1bf205a21420ea914a2a30a50a902a78f70c3504c77155864b5b8e4a6dc9042ca4c576595f4376a96f9b3ece3858ec5bd3518823898340d1cb1cae2af3a28ed3c095a83efc5a6ba1166d80bd7d8a39d24ba5e448d96ae5a105d721c54e79f0c4c792aad85823b6bdb726165e62bea9e390a1240c864540af76586d7ee1190fe956bff00c78b8f33e4edfedc2fb68379ce62b5b655ac72046a548d5407bfb0e129438143146598ab057ad2bc453b0f007df86d8430b0dd1b6768e5660e282aba9811eca621b81ed91a1cdb8591ad62768d8671d00cfb4827f2a6284912b394c28f4e7dbba8a107cfeccf21816b026c8b4ab3dc157be8d2574a1e6ae47baa33cfd984e18d126b74e5ac539d3720e57117941a766a00fe38128f91a65d374bab694c565b8b4d283fe4dc34641f00c687f1c0a7a8d25ac0e95fa82f75750ada23ad180d2e8cc3b4d0e5ed0709214885e8b69e35a5e496731340cb2caaa0f630aea1f8e1e882a995b7aee715dcd0cdd46f4f2888355d1c53ff00d3520fbf093b2c9566a3432f1cbbb40cd6f7af14d0350c73732847fe9c519c0e4d7172a8249b408978b90cc7f0185d60188c6b7577234f677a22619852a6ad4ee048c35e0a882e9bbef36c5e396ce4dc9064dc88c29f78723f3c2c02aa6122dfa75a9fa4164d4ab25c3e9afb80a7e384a0564390dc5eee7187b79e38852a291d57fe2639fc30e606fe085b5eefd6d215b9b65ba4ad35c6c169eda80303824796f6e9817b8b7e52f612e0e5e38409035bb81e7d3ce8d5cf60929f115a6115b602cb33c401884ae2952d11047b3238aa93d01a6ebe7ac9a9109c848a6bf11518121c2191248fe75a3aae7902491eec24, N''qua-song-bang-capPoko1'', NULL, ''077b972f-1a51-415e-b48a-19f39219d165'')')
EXEC(N'DECLARE @pv binary(16)
'+N'SELECT @pv=TEXTPTR([PictureContent]) FROM [dbo].[Picture] WHERE [PictureId]=''94746da4-31e6-49c8-bf18-746b0b288ce9''
UPDATETEXT [dbo].[Picture].[PictureContent] @pv NULL NULL 0xb226c1cf7e91a80616ab77a31ad3bb2c3802c9b85acb1d1c985bf95d8667c3b70d20824a11b388452b3718cb508a76939e13c024464d7c4472f33b4444301ef385209e49470c92c60ea9148398987e4062944083c533b332c86270bd8b51f9d7093402f34e920648640ac7e6cc32e7d86bd98a863481a4176aaed135b6b22948542d3b6a78d713a3d0341333492cf459119d468aea0b4efc89069eec1f01002dae46df23325aadbcd31a3b464ca5e9c0d06903093ee541f2ff00fd563a47e97d73e97ebcda0adcde6fdb0245ba5bc646b57b09da28cba1624178a45032f369cb04359e8737241c4ba6fd09eaff004cfd4fe9ae99f55f65bad89379dcac6e2085a68d6e5aca7ba4825657b795ca303a86641ae0a59cca2abc79867d7bf4c7d3bdbfd30b2dc76dd825bbdc7fac5f1bebfdc370951ae6e2711a5ba16689522a2a44a802a2f0cea703b37a9bed506f5fd2a4378ed72b2a46b46561f296a798d721db82658968406cf1c0e5adacbea848344ae582955ad7510e40edae58878654a63306d70595e5bdcc6f327edb444c402ea0c6a75533a78e2a604dc87bab6beb8b889ed4496ecba855bf702f654156f2d700aae07905c6989f5e9963d48e8ac48714fe7a0607d830489b0b1496cb1307939728a12092587833371c3940c40111b7ed18a46594baa534b231cc9caa09c24c1792336e526dbca1ba46f244e4eab8453a5178d48cf2f661eec8b6ce8307fa6aab6e36d71aa264f3a96063d3dfa48a8c3dd1d470cc6dc72e6432d80d2ce28aaac021073ad003dbe187b405beb1d9505e24b1b479189fcda8778a1a531361c0949be6df0069e759228e69512ae4ac648c80415a061da2830bf52aaa4cc46c5e6313c7a34006a1aa45330015cabefc381740b6f05c48ee01545715476525c1e2788a53df80406fed648e1e5c3a0a7162de555eea509e3eca612ee35826b1958c4d9542e6358ac95000e34a81edc54f8127252bc92ac89322ccd972949262a8a67a9a99fb304b1b489c6b7d71388e791234068b01c9e8be3ac920035cb14a589a4b427716f7af29319816207e71f29cbe5d34ad712fb022664bb81234552d7235120a10ab97123cb99ecec3df8add1a09644afe2df2578e78e181e38e350b23318a60c733e42c456b5c89c19ec344bfa76fcd1ab39458d48d0918d4e16b53ab59d1f0ae0dcf4685286adb699e649c49535a86918d683b069ad3152c529016da249d9ae11b43c6c015397318641aa49a6134c24b5fee26d156de76b6e6a150e92ccb981c4d6869efcf02f8190fea7ffe7b3f96bfe69f97ff00f1f1e38a8b041a119a7b7e5958ee9236c833c19283c4eb527878e31dc8691918b953c4c7ea20774a12f4d2eb5ef1ddeec19ec0c24f6934302b473c8d11a55a3f3ad7e185aea1280366181122c8dffb87c8077114233c09c144a9756b01909b630a8ab4934c01f6b6aa0ae18a058cb6f78564fa495b47eb82452a2bdc41edf6e13bd5e853ac64a0bb6c7308e582e616d40f9a62450f833570273d584332a76fb202b6f3432ab0cc3b29a9f6100e085a92c4ae1eeedae75fd55bdbdbae4d1c2ce325fe64d60fc060c8e704acb7adcaea6996d6eed2f2d941709ca995d69d94cc11e2304e7a0dd60c92a5d315bb4884d1b535fd3cd42be056403f3c104b858246f8495b7944b1ccc3c865549548f686a0c54835d84756e96a643b65dae915d6ae8b1c69e209245704b1a8ea2d6707524a8d776f751de44f52f24f248e83be9a742803c0621598db5d494767bb0ba8ae4884c6a2ad7312ca6324f1f2bcc41ff87132e4ac44199b8924bba2b5a1964a51648b97a4f71d2d9fbb16e085942a8f7d6f731c13c3770c23b39519d47dbaf2f70c26ca846645cce633244ccaca0155963346f6b286c54999617b35e858da31a1b2e6a32b508ef575070e6408cb632a463e922b59857333a509f7aa91897581c9326d6de256b82b66f5a52262a95f80c3485390abc9684ced3adc46bc3569a679508c1d41b256a2d632ae81431ad0a83fc30c412e4dd38fdb8d25527ce8c74e5ef14c204420d0a9a24b61148dc1540208f680304261219a18ddd0440aa9f988390f760020f6cb2034ce319329ad49f0c3e834cb42f1a5633a87616ab7f1c09c8828b34281d1d821e35614fc89c2dcc1085cdb6d2807f503690abb52390b72d98f75580c1f052abe834bb4d944a3e9e30e180352c6a4761041c39862c9aff567517446c9710ec1b8ced73d4d74035b74f5940d7fb94a2b4d496d1d5952bc64934c63b5862971b6a745dc5bcd6a4e90f51babcbcbb95fcdd01d3ad458ac76f961bdde648f30c26b80ad6b6c4f1a42266fefa9c357ad74cfcff4426dd8f31fdfefdb39b9e84e91de3d2de9e79ef368dcaf0f536ed6d1c9737d25bdcdb272ee6f6795a59e6d32434d4ec4216fd2b88dedea47228ca386f481f57bef73d5dda3a862478ee3a465b7b7deefa4a43b36c7b7c125bc96f147211cc7b99a48e772b4667343f28aadf25d636afdbe428e5c9f57daeccd1b358a41472cf1f070a09afe8c66d41a2422659e724dcdc864cfff00e3a3155edcea40c248a6b1802fb8a4a745a9b863fce12aac33cc104664e09103e6f291e7bb9da19348ac4e1c9a13db9b291ecc0d8c95a5cedef134b61753a1a9e60426745ecae96d4c07e58684d0f09668f4476eeacba856462de724700c72f6018203a853cd259dd63efa9248f6e797e184c9291e76a891e2e5102b4e23b88cb3c3c00accd7d696e65b77339a9d30c614547666c40f8e136d7428c65b5c5eded5e5736d3709213ca351d99a83f9e15594d22173ba25aca2de432b3d0d2832a8f1c56f4ba13b4849b94b9048834da6881dea5abdb403565db84c36c8686c66dc6d9a4bc8d55736750a4f308ec20d0834edc37a0270f04ede2b4b7874432312ab4465032d3db4272f1c03986646ddcc303ea79662546ae6f957c280604899ce08ace96ed58205e6104ea77e3da476e055c0db629cd0f71f53f4f5a9140cdae34038945e03043686f05b9314c8d1c4284312ee75156ceb9814e3dd8696053d40b5a6d56cf592389646d4ff005056875ff2e79fbc61aee3dcc623dce436e96d671c73eb34d4a0aafc4e804fbf03d44946a1da499189b911481813ca02552683b28cd5af71c02169ef36bdc0adbb44d3ac5c235621119a9938198cfc30e1494a5135dcadf5c36ef14d1ccac1160b79df954e3e72c780c3eba8829964bd6945c3490415c955d664d03f51cc1afc7130fb869a0a43d3db5cd32cbb6ee33a468f49410da5f3a9f9aa09fc30ebbbb953dd0edf6d36492412c768f793293a94f2ca20e1acc6174b1f75709a53dc94db17e6ef5fff00c9b7f9b4ff00903fcbeff9b8e267c0f1dcd32280a8fd997f6c52b1b1d4bf88c0fb0de42471482421150ab9ab2ae96f6d35548c1698193d30ae958e4e4bd68633553edfe53c6998c2aa704c978c5ec6e54dc24f1f0d192b2f8f6fe782cd8600f2d5873669323c0076ca878d1aa7e070ad36d4b45732c52e3ea04d2acdfcc8d2b31f0d0cc401ecc4aa8dcb433fd4d2e55236b19ae9c54289addd50f8970091f0c0ac9ea4c400e55c2c33acb0c71eaca2804874807bc90a4f862aa129938f769eca257ba4012b40cf20d390e219813f8e1af20eb9c007eacb199c3dbc700b90d93248bacf8d053df4c4ab25a0fedb236dbe8ba0cd121528d490f996bdb501805c3dd20e90c24dbfee17aa56d2c9414c944b1d75572aa9c87e1895c9d8a544b5626b6db84f035beedad40903c6ada813c050144a04f01c70d36d641c2ca3618ed2dcdb22076588104c12ad11bb2aa35ad00f661f433981a69e20f1f26e0855cb965b4f6674a8351efc3087d48da5f5c4378515a416d27974aaa32d7dc4119675a606f22e864619255d728d7342c295aa820af671edf1c35963b2c03712c8d1dd5b34e818feec3aa8411dea430f861c8b51a9d44f492cd98cadc14b692ddf91aae14125e096294185a3d33e7af3506a3d94c3d07a601fd2dd94216411d3f4ab54fb6872fc312ac24c5e6fea01da0789ee01f97ce91123c05413ef380a8446382f4d5ae9d8282291304509e3aa8c4fc709260e076c9ec914c07992495a924b3507815006283518fa0867b8324019641957dd954138429ee5a1b5bcb5255e53aa950be5d23c05071c0090ca9506a5814ae721a8603dd876908065d3f71a29418d012542ab65df9fe39e006a0e61d5bf70de9df40ee326ddbd6f168d7504a229a248e48f4eb52cbaa43fb647886a572c656e44b567557d4bb53108e7fbbfdd840f7f6d3dced1652f4af9a4b931dd457737294e6d1b44c0540a1a15c66f99755074af4d2af593a6ed31f58fa83b35bee7b96ec7a5ba43728a3b8db6cf686326e93dacc04919b8dc2489560e646c2b1c11f313fe7571dab9125f4ff13cab51cc3378e97e92e9de99b36b1e97dbe1b189b3b895754934edc4bdc5c485e699eb9ea95d8f8e33b4ccb1c419048ca82242ee00f99d4015ef206430751a66364ea2e98b6ea14e963b9d9c5d5f259b6e31ed3cf55ba7b357e535ca45ab518c3f949038e2971b6a7a09e59c3ba6a283a0bef7fabb6cb485a3dafd56e89dbfa88e81543b9f4f5cff004eb975501402f6f32337c7b70554282561c1e8453144cad23a245526bf2d7b380c4b68650b55b7779d34d2460c542d16838119f13df84d14d83b91216490031440f9d7204d4e5e6343f0c34a00651d7368dd442ca7cce4915ec04e74c0d324c7dc2db35a36a5d1700e7340429046752ca17b302508a583149b719109173792da96056de721c6aad41564a1a78d7021b704aef7c9ad58c97119748c69748d5c80477e9539e13b20559269ba5ddd411dc2f2a288e695560fe0a54906b862da9609c736e734697091d61905450e97280f165272f762b41681a58209591a6590392140ae7523f510320310f23ab820fb3d95eb3892d943c2d4e651b23414a125750cfb30a10d36016c62db99c5bc63cdf3485f4ab11de5c96fe1875c0a649dcd97d5c063b689d39a34cb15450533ad5aa33f6e17c0c55a0921842c7033ba9d0584aca73ec4d5da3bb04b81a6a724ed2cefec95a47b756d4f57569256715ed21aaa0f7d0d30d09b4c62384b3894b412471d4ab24a4e93fee0c58889de36f17f1da48d3ab2b02c5616688541f99c56a33e1899ecc6931d9ef6deda459202d3c4e099248e260aa385480b87e1909321229be532595b9ba6d3e6695c28f0f252b869229600410cf09126f3ba258b124a4119855453b2acb5fc30f21f0120bbd8e799b9dbac53cc29a47edb569c325009c369751b9ec46eaeee6d9c7f4a1a1b8481e192346af124953f9e255a1c0a1b276b3dac8e44f1db2c4c9577326860684794655cf14f2368a448446c4c8d2c6284491c81001e3a30438c8a4a49e10dda6dc9206b757eccc9a9a9c1b408489cc2852772b12d0470c7e515e15259b064447ea6fbfe5cbc29f38e3fcbf2f1c3c95834c511dbd4373509e390cfe2318a1ac93b79edd183198e46aa193b7c30a323189a44762c93c6ead4d75095a8f78a62dbc09968b941c497319d1dad100081de454e25f8138829c58ca6849a2fc84d057e182710096324e776bc9c7eaa00068d43df96584de0ae80a449edc9cd9189a2a060d53da0548c3560d484371bb43317bc8585935285645925a7f84914fc713b8ada9fc93bdbcb45701ad84d2b0f99a30ca0f1ab69634f8607a84118af6da48c2c90eb8dc7ee451c24e971c082bd9efc25864c07b68ac1f44f6d50b1b02000d08d43235248249f1c3806c34d25d4932b4ab208ab50c0c847c503103142e83a9fd3ee4346b282ba734a23357c55915b0241a135b6925b6fa6b696ba4f078a3a0f0a612424cb1fad82258c488d22d68a2880d7d80e1ad061ec5eedd032a461d450c6ac091e2481813c931216093f7dda65d2d405853cb51df4343edc099430b2dbc4333146ef90a35401e0788ae1a7925a8036f2c7cc654765615a050349f6d704964d516fb2914bbc6d4d55d2d9703514cb09325a8d08c8d7b05d25af90f90b2160eca40ef61957c389c45ac182d2492c8c89408e4e6046eb4f61a1186d95a8c07dcd994c72ad545680823dea7034c52984126e3cbd5cc89933a809a587bc8fe18a925c166bda2ea9c9565f98eae23bf2030e5eac02bdc47711eab4592663f2e9f2affc4d4c34e450613a8fa976ee91dadf76ea3dc2d366b115065beba8e007bc032690c7b80cf175adada21ee4789bee13ef6b66b7ea3dc3a776b8efb7ce908234b1bbdb60430ac924659e6964d410904950013521780ae39f99aaeaff0071dde9f252afea5fa9c1fa97ee036beb6e80dc16db674b5e992795776574e6ea48607601656492b9a93e565cd1f491db8e394b43baf7ad94887dbf5b59efbd45d1377d59b7427a123dd21b3bab6b60636bd80ba234770c84332e75ef7cd4e58c77cb53a0955da98ec7d7a8eed663cb4866558fca2368f968ba72000ecf6018f5941e296960faa72cb75322a9ce24a201dc38570a450356d3c918e44ca5621f2b31d65bdb961ee9160f1fff00a9e6f171d37e8ff47755f4ec8fb5f57eddd636cbb4efb68e61beb357b2bc69d6de78caba0956301c568c0678ba6328e6f73936564e1ff6bff71bd79eaefdcc7a63ba7a8d7efb9dfc161bcec166eb1c50f2e2b9b3692498988233bbb5ba172e5ab4ad3193e56db4727adcb7b3ad9bd67f81f4bda48da2d12012c5401894d5abde071c54773d6982adaeade2436e248ceaaf28534814ec65c28079270b2cc5c4eab0c8ada5eb46d63882a6a72c2610466916456b7585f93a82b942b514e24eaa0fe3872d0a3a8a5e5cecfb6c4d3afedc11d417500d08e20d4835f019e1c824c585cb5fdbc72d9bb2a4942ba18475a7f74a9ae5835610277cf66a795712df2891bcc1d5826ae14d616a060b0f227b93cca2236b77a2c2d9ca4bcb1a9dc11900e4d401df5c26e01419cb29639a3a3e878dc13c8d6a5d9694ad2a30db4c5103097c93857b78ca5b9143ad805602a0152a4f0e070902522573bb489673ac6b194462dcc320a2a7122a33d54edc2d0ada1619e51045a5c39993505631b7949e25a95391a8c34c98c8c4435a4d04059471129cd4b1fd449cc8ef1f0c36d888c367b8b4ab14b36a21093245ad509edcc643d8700e4422b1dead5dae1515a456a24725d349ac1ed2ba428f662537036d19532eec90720d8c6559092f1cd1c610f71cbf2386d782610b5c9dde78c42596c90e4c61717048a77140b5f7e1e81822165b2b72da79846425ba91621c3b028507bf0d36c24c5ff4bdf26492fec1adaf34b0c9a790a8cf30aaaca9978e0dcd1780b2ed9b76ee156e368589e3ff003343843231fef47acd3db8509a9c8e63a8e5a2ee16ee2db6ddbed76b551a749504b2d68087aa12c7d981597442b4752aef6eea5b8d3199d2149b290ea7d48d5c8a804a9cbbf16acdea25b4623b2b7842c2ee6e4546a34494d7b78b57e185653a84c03812de1999a18e3709c55ed796e9dbc7204605d87aa2d1f38cc66578e587894450e4e7520d684605e4964cc1f54123994476ac6a00152013524f6e2d21ca23fd3369ff00e547fe6e9ff671e1851616e673b378c0d526929c74e4413fef5698cf52b523cd4605e712b37cd1e84aa83dc72ad302f21002ee59af34fd2372e5191ac5c471340e067e388b371834583256f0448a252a6365c8a4919195295a50e1d480b0b5bd7cf1a872411a352934f02314d64992f70c4387b250cafe57f3bad2bd95edf66131a1a6db5258d0c94190a00430a8f6814c2c895a080dba588af9dd38e71315e3dfd9f0184b05480b8da659e8fcc6420d44a188353c7cb402be34c4bac8eb781ab0823840ac9ae7192e4fe6ff00d4298aaaee0f23d36d515dc1cc59dedab9f2453413ed19e06de82ae066df69b29e15fa8874cc8b42eae56a3bfcb4c35a0e608b456103946e65c69074a69d600f6d33f8e02062d444b1a4d125101a191ea0d3ba84f6604bb03686c45089495566722ba9aadee15e18182643e810ce238269623a6a425071f120e06fb0d6404bb4dc3373d89c8f975172c7da350c249bd449c13892ed288d0d48fd4a695f66ad586d8324d14ac034b2c54a6a649168477d1908fcb0049355b381c3a22b305ae9521aa7b7327b70e6341b503105ca4e3fca68aa78505387bf0b513411952de558cc8ca65af29684a9a0cf3032f8e14835d81f2a59c1401848bf2c88da457c789c5583e4c675175674ef45598bceb1de6c767b519ab5e4c91b494ec4563adcf82ae2e946fa06e48d793d4cdefa8ed646f4ff00a4774dd12a393b86ea06c3b7c8a783a49788d7522f6d52ddabdf83e94f2ff7124e3e9cf53f7db6921ea9eac4d92394f96d3a560e4baae55537f7cb71293e291c585be1fd2bf7e420ca74ff00a6dd07d3d7ab7bb76d30cbbc17d6dba5f4926e37c5c7eafabbd69a507b7cac00eec4d9b7ab63553e7a7df174cedbe9efdc95deed7c82f364ebbb2837a911d7498ae10fd25c229a0073855c1e3e7cf1cbcda9dbeb5be98ec719eb2d97a7b68e8ddf77ada4c6db16e162d0c74a078e672044920ec3ae871c92a4edb552ab8358f46bd53dd3a42ef6a76482ee2db373b5bf86d671aa0692d64e6aac8011e4623cd4c5249b30addc4743ec97a61ea9749faa3d316fd47d3d72af24c81ee6c49acd04a40d4920ee0c726191c7a75739383978dd3e0d9de1582669a663e615d04065cfbfb7148cf3a10fa7b1b9818070b21527587273eca2034c4b4e07993c5bfea9b68a9f6f3b25cc4d356d3ab2d1e547565501ec2f92a09af69ecc54bd19c5efd7e8fd4f37ff00a776d1fd63ee4ba3e468c3c7b3ed7bbeeaea54367f48f021a1cbe698639b8336b3d4c78690e95f0ff89f595ac62d5ae36753a7572c795569c485000c6d547a6df4006cb6abc52cd6864b85234cd3ab0ad7ba841fc3040f2834169b522491bdba7edd2b2aa9199ed56f0c3f81658a8b8dba19654372f3b91a56360a8ebdb92f9757b78e1c771b4da2106dc2e94188b8d79c8258d509a703f2b57db894913259367b4495a2598b3be65142e95ff795548f76082b749917dbf6e821513ba6a6195589f6d35938a9165b211edf6a741b5811a202ab2ab20a9f701894c44a68a1e6b082dc3851f3a941a4d3b2b46cfc304040a47ae20acc939209d30569cc3d952c49f81c0c6c8cdb5497722c9750aab509312cd4e3d84a8afc70758091c92c12484c235974a5215934e5fe23a7f3c3121ae5c4ec81d6540a83ca1bbbb09070a7b022af626480ac1a551c105093a9b5659907f8e06869c18d799e2804096eb7cab412736650a29900079d8d3143fd41bdf56236b6f6f0c170055a3d44a31ee3a92872cebd98699212c20b2657d17dce99554e88123d69fcc28ab522be184aa36df60f2de0b8bb36dc87b95033578534e91965ac81f860791681ede4b4111845a7d3a4619822690b9710554807149206e48c52431a36e41161b4507549a741eeab0a701836ed0f05d777dbef21325bc892b0a8d1a46b247f28343ecc53af52728c5ff4cbdb89dae05cdec2ab9c28ede519d735cc9c269cea5c87b9b78b452e0c5cf22b558928e3b4b0a549af70c3da85b85668ecaf62f34d3dac683423a0214d07ead43f8613af904f00a396fae6686ced03ccb1956371a632a50647810787660434f06499e012b417065a2d0894039b56a549ce9dd4187024d82d30ff00ca7f9abf21e1fcbc7048a0d05eddd01630a8818f056074fbc50e3293465a3b7b639488e056bad5abf8035c034883db20c83dd69eccc53f1c1008675df187908d2cb6cbff00b721197ba99e12c03210f3a8cc418d1079e91d7da72a9c4b60c34966d2dba2c5224baceaa8d6aca3b995c29c15bf50782cb1cf046d1a3699178e6d5a78004838a917c93b5bb9a288c57137364d46b2529c4e40a92465de30a92b5653486a0dc658d889151e3ad0922bc7871ae2ba92c28bc919aa0db041c011a7e34c2493140df3b7108154db0439a00c73edc81a609196faebe955e09681866680d7dd5ae1c924219d66730cd2322ae4d42509a7601a40c105410b8876f8622eb24cc070d52950b9f88c13d052291c84ce24d22e2014e6c5cf90bd3b68d402be18cb9377429197e7cd6ecc6d9426de48a191833a8f13ac62eb6142188f76848a25ead72053e73ee356c3791341e4bbdcda8b6a1196999948504605812f25473dd3be9e4c21e9462250572e3c06091b418c2c18bb958e439121bbf0e4968c0750f55742f48209faa37bb1b19c8d4b0cd3ea9dc1e023b642d33ffba8714b8ed6c83b987b5f507aa7a821e67427495e490150d6fbaf50cc364b3707f52c0eb35f30f6dbae1fd2b573f0296147497a85bdc2c3af3ade5b7826001db7a5e01b5c71f7a9bf94cf76e3b2aa61f6612e48d147f10daccb74e741f41f4734b73d3bb3595a5fcc3f7f7793feaafe761db35ddc1927724e79be26d676feec95b60d923bcb1b8f33b317af9c8a9f7f0c2d01263025b494555c81c038343ffa80187a84b06f0c1a4ccd2cc6402a0ab538780a570bc826cf067fa9808379dd7a0b6f951629edf6fdca74bb70caefcd9a05e5a9e145e5d48eca8c63ce9591d5ead653397fd8e7416c1d7fd73bc745fa89043ba745ee9d3fb8da5dd8b923534861d0e8c082b2280cc8c3356008c63c5c6a726bec59fdbc1e5cf527a0f78f46bd52ea4f4df7621aef61dc65b54b8152b3440ebb798569fe644cadefc63c956ac2adb12775fb79f59f76e8adcecefac2f9e09622a28b5a1cc555c706523220e34e3bbe8689ab2daf43ea6fa79ea06d3ea274a59f505948959d74dcdb83fe54e806b439f0cc11fdd38eeab95279fcbc6e8cd979ab25ba9d080d28ba453d8411864ee84789ff00d53faaf603e8bedbd0505ec32f50cdd41697377621d5e58a186d6e0876d20e925a55c89ad0e26d6393de9d9e251c27fd30c3dcfdc56e5246baa3b3e90bd4a90485d53d9c62a7b336388f5eb1573dce7e37bb9dc74507d459acafcaea8ee9a0888f3ad4bfe6011f1c687a688dc6dd75780137d226a03c8a05011ed15180728696c67e4ac52dc160051988a161dc73a1c3c88596dec6dae45c72d64914512344c8d7c14d2a3c7095472646de795dc992172878a90a0a8f89fcf0fa0990b8ba0a0c11e801b258dd89f6e62b4f8e05416a22c635159a252872628ac580eda173f96068705e1b9b0d623b12f25b1aab2106aa7c46446001916e91c8162b78dcf106462bedcf3c25
UPDATETEXT [dbo].[Picture].[PictureContent] @pv NULL NULL 0x8273a8736892aeb9eb1bd4e901b52fbaa3f862a472632f6ccdb1e64708926ad4b1908a78f95707c0f235135d45002f347ad803c95f31cfbc900fe1853926042e5ae65946a1188c0a11'
+N'ce3c7b09e186c6d0749e2d22dd5143e9cc16c89f8e09e8021cb36d20226942ab12a9a9fcb53c7cd5cbc300e24c8b4b1328b9894738d7535070a533ae1b621437102c41ae0c71c84d0c51b0a2d467e622a5a9810da917976ab492cd9a26baa960dae1a094d3b2b9035181af209909639265f2595f4f0d02b433bf2d0f7328d75070edfa8d07db34975b8876a9ad6786a4079bcb5e06849607063c834fb8b1df6fd2e9e61b0dc44416a4aacaed971600d3b3095921ec4fa931bf5c6e611ac2f1ad6f1357320b9b721a4a762391a6be187ba7425563a129adf7dbcb6096f7930cc334ab022e93c6818383976d30f7b40a3a87b4dbaeda458dafae03479cdcb944911eff002b8273f6e069836bb1237bb5edd722d6da089eb5d6c90b8627d9a3f8e0ac75086d0796cf6d4b93797a638926a49129aa935003135e186a050c3f3b65fe78bbbffe4fe9eff6e2e070ce5c2fef5818ae5454f050002bfe2560847bb1cf4668d263514d1dc42d22221a0a06400914e25876e19247ea1d6810bb2902aab1b647e385236839bb56a0152801ac742bf9d3074c92444c920d25ce638872a7d8403853232c396236939664d399632660f86aa1c3c8e43dbdcc2d16b91f964102a58d6bdf91c24d8298233a9e655a40c9c5658f3353de389c2914e04a6ba9d0958692c91fe935504ff8a840c1665baf72e774bc48390b14315dbd34b970f1e633caab5389521b56a336970d23c714eae59010cf1a92bc388551903c38e0dcd09d73266537955430b4332b64aaed1cb9d3c4838bd0ced504fbdb87291c2199b314a8a0ef3a88e1edc3d3a15042df75b8d320ba4372a73468d631a699509d45b19a4d3cb29a5a021b845704c2f67701d1479811a08e240073f8e1b70c7b60c6b7526ca0bcf1edf2c0f19a36b072a70a004fe589fb88aaf1b270f5849302b676af23a1ff00db56526bc32095cf09f32e81f63b984dc3d61e94daaebfa66f5ba0b5ddc93a769024b9bd7006656da08e4948cfb171ad1bb2ff00522f5dbe442dfd49eb0ea5bc361d29d25776764c088f76ea4e6edf113deb65124b764768d4b18f1186af44e1b9f825d6cd0c0e97ea0dd2dccfd6fd59bd5fdbb5629369e9cb5fe9368849f979c1a4bd7a0caa665af70c16e68d31fc44b8df5323d1dd39d03d2d72d6fd33d2b77b64d21226dc39079f29ad499eed99e57cff009dce33fbbb9e65b2df142c41bf41b6c0e43c13bc721ec255cfb38e3448ce433edfbaab3017a1958502b42a6a7dd4a6104848ec2f218b39e8ff00dc01687baa7560405470df2be892e1f50e398fec030e5360cbc9692487f79a5a0399574cc788a625088bd820432bbba5b460bbb4ad1680ab992ccd4a000667b061c1499f3abef9bd73f4bfd54ea2e9de96f4e7798f79bae8cb8dce0df8c09208239ae3e99556295d424ab48581284ae588e75b524747af64db8d4d17edc3afa4f4bfd4fda7a8346adb9650b70a384904a0c72a7b74b1a78e39a8e1c9d36a6e4d1ce7efbbd40e90eabfba2eaade3a426375b385b1b692f4ae98ee6e6d2d52dee258490352068f483dba6a32231a7353739470d7936b87d0e57d2fd4cf653472c04e924556be3c71cc93a9d0ad393dc5f691f73d0f41ef96bd35d44d24fd2dbc4b1c775120426dee2678a0b6bacc574a962aca08d55fee8c6fc3787067ced34bba3e85ee4f3d9c3717815561b58a599c4828b4894b9e34eeedcb1d96839fc1f253abba9b6bea7deb70b9eb995f774df2e1ee374b67225904eedab9a24041048a104529c06596386f33a9def8697ac5b43aefd8fc1d39e8575cf50f50cb38dcf60eaa8ad76eb6be8c0fabdb61e7b4a165898d5c33940ec838283970c6dc7cd8867070fe2d71dacd3d5fec8fa38f3cb1a1401cbab50929ab87650637990c8192ea51196164e4b1000765049eca124e090a946e6f151755905edab4aa41f7624302f25e5d0d4fa2de3506baf58272ec00618cab4bf82e1f45d5dab3f0d014a37c6b9e1ab20751a26d62982a41271f9d50927da708411d9620ceea0a310143351d7c6a703ec098acfb9595b12ab3c4b357e546009f70cf0930db24d2f2aa260495cceb25a9f1c5c89648dc6ebccfd92ce2361990a73f65062303551117f69613f20078ddc5589d4e32ed273030d2086c2ddee1cf5558a41cc61e594509d1e03b70d57b0128444c91c334824651490a210cd4cf8f0180056ef545725a168623dcfe6f1a83c70390826af2493085e4573226ad4469ad4fca6a41fc30d046033c421744779e5d43492992c74fd42b87390006f9a3928b6d757c9fa3598ea69c4aa9604115eec1323489ac7b9cef4fa1b88a1d259565685806f69a907f0c2081a5feb302467e863932fde77974900701fe5e9f861b13481dc5bc5b8ac82416fcc4a33465b9ba49cf4bd08a1c1909831f7516f02dc8b3b3b678d4810a33906bfcd546a0c397d87893256037ab78b56e1631bb39019a19cd070c8ab923e070e7a41368e834eb0b6889ac6e1581a8d07c8a7fc4af960842720565dbda7d17b1722e15a8ba6ec572cc6a0181cfba870e64a72397cb21d2f04e602f455291f32a3c70f240a5f35f998224665b45f23b4caa8ac48a12ae5bf8612d468c5fd3dc7ff0cfcfa7e687fe2e3c3c70fe92a59a549215502a51893e6029ee23b7dd8c5b468abd8bb4c8cdaa23196340c28054d29e1812132eb24a956950553849967e19530361059e412059a399164e0d937c4e79e0812ec496fd51bcf310c7f5aa3104f8e584f42954a4b94e6f3082f5ad4726b51ef030ba83a878e7b7727956acc694c902f0f1a61b4859ea48dc5eb446095238c39346152df05a60f2248ab4b5e446eb15cc2f3357fcf1a453dd9e25206fb8d28914c7a6d61691c057656520d3b503015f78c3681420f358edb14bae58a45561c0a3713dc51a98702965a3b6d9255312f3e9c02967cfb6a351c3559ea0db20fb7ed3180237a5081e61e61ef385009b32761b70e5d2d64d4c4649407e34c352299d4d3fa8fd46e86e9dde06c97fbb41375230a2ed5b6f32faf98815a35a5a2cd22ffbc00c5ae26b2f1f22dcba183ffbb3d44de1dd3a73a41766db5ce93b9f544e20726952ebb7da09a661dc24922c26a8bc8dcb2f6de9fefbbace67eb6ea9bfdd4e9cb6bdac9d9f6e087f43476acd7120ff001ce47f7712ed3a24870fa9b7f4a6c3b0748599b0e98d92c76db67f9c5b4223790f699662badcff008d8e25d46ccf24f72d26a78e2d4b98391a83ec186891a58e312b48192276f9a80904770cb14c185113460b412d19b8a9f2ad7b38624046eedb7571ce85cac8872245457de309b6394637abbafacba0ba62f7ac7ad9fe8364da62e75ddec65198ad68a8909235bb1a05506ac71755bb02708f14f50ffa88fa85bfeff34dd3363b774cf44a3116697b1b5ddfdd05268f2b2f922d429e5553a7f99b8e3a571d528307cdd8d8ba4ffd4037d9266feb496bb86de9a52578e0685a363901aea50e7950ad7bb11c9c681732675fe98fbc6e8eea26d3287b19541e6a4d1f395428a9fdc84919f8ae5df8c6306edd59e6ff00bc9fbddbab7e96b9e98d91c6dd35f42d1dbedb037fd45c87a813dd50f96114a84fd47bf0eaf063c9c91a1f3fbd2bbcb99ef376bcb8919e494c6f339e2cec58924f79c72fb509237fc7372d9db3a7f79fa7689655ac41b22c71cee19e9d9984fb88d8b69923dbfae1636921dc8fd2ee2aa3fcab989018e5af0a4918f8af8e2b8ad0e0e1f73854ab1c72def2de2e58b699d23141f28240ae34ba9d51ccb91ad0ed1e967556d7b0c9657b733c7672c37493fd64f2285ac0e1e27f31249522b4a5060ad7a993bb67d97f4c3ab2dfd5df49765eabbe96deea0ea3db5c5dbdb1636f32c9ccb795e31c407009a7e93963a4dea7c7ff00503a4aefa0bd40ea2e86dc2649f77e9edcee76eba92235566b772a1c7f896871c37c3c9ddc7c8acbc1be7a4bb804ddac45d5d18e38ee212d4fe4575272f7617536aa93eb1ff4e37ca2e2cefa4b9b69c0921955c98da3906a561461910476e3bf760f35bc96876436ce649144f203e572c4693ef76187560db0a6def2f99919c141910a683ff49cfe38729e49580f6db4430205b87aca33c89197752a46247b883dac225e6c309d6335632529eccce08c8e48cd78814219396e067a5aa47bc0387a898b4b05bdd46049348eb5aa92c4ff000a616d0d01fd2d98a855ac83cc4e8153efa0fc303a84b017896972a81daac943535069e04914f860b0d14bc8d2155022aa9d2953534e3db82045da3b7700c1080f264c3cab5efcf3270871dc956c56245082494540964a002bc6953961a69e036c972cb30fa58d9f9629af4c8b503bb314c2dd90f90ee2c6d12b2dcd240084506a0023864298a6e449360084450d2c1118ea1f9f1b23c841ec552a0e12f82ac32db9da0b74e6a49202de4519cb4ed0e3bb152a494a4b59dd41cc0c21923591fc8ceb1a8a7703a81a614489ac02bcb7db1ee755ccd0dbddead3cb371a894ec34aad3d98baa2e5996b3b510d1a294b42732b5017c69a72c3dc4364e4b4b59e423495b861412000e4386641c11d82592b98a558ca433b13a725caa481c3b00ae14c0918ab7bfbe964e47d25c50104ea95013d9c35114c36d97b510de2d616985e5ccd716eeb908d642569fe10687096ba8a45ed6e20bc636e7972462a1259235d669dc4f9bdf5c1b5494a47a5531b46924934e91a926b2e941da48d254d470ceb8b7821a108e08a541348f3dd2b6713b33304534a00af4cfc70a0b909fd1adff9c7fc4fc7bf0a09dc8d056eee51428b890a03f24881c7c48c648d368569d654a3471377b6903b7b73a610b6925784a9d31a479509571f8f860523cf5251a292da258d071a6aad48ecca9870c618076a6b9d03d280a70cfe38704b7d89ad85534c526b6e2be600d4fb7f861680c5e7dbe55a11133ba93a9aa4ff001c025690af6374f6c64b78eb9e616bfecc00a08431ceebca92a8789e66438e7e18556110316fb63e869629d15878f0f6578e1c0f7761a86eefa11467aa70a815a0efa67962a6702c1aeee1eae7456cfba4db60dda3ddf748680ed5b4c326e97cae7b0c169cc65d4786aa0c1b1a79c13bb18167ea6f553aaad9e0daba56d7a72220b457dd4d37325656e0576edbcb302067492743d84629ba2eeff8109b076fe910ddecb4f5f754ef1bf2cfa4cfb7da4a767dbc77a2c160c933257b2599f2e384b95f4c15b7b9ba74c74cec1d2162bb5f476df61b46dfc1adecade3b757a76c9cb40cc7c58938cf572f20666b30357024ae551c69e3c30e0721a2016958cf8534e5843d4bc90076a29d247eaad3f2c531202d6f266ca9981c41cbf860ea28c145ae9401a32ad0b03fc3097f01c032d74e4b1892b5ed207bf048ca0f7e1b253a57866a47f03872d0923c33f7ff00ea2ee5bc752da7a63f5115becdb1da45b95c42ee23fa9bcba4628eccd96948e8aa09e258e3a38abf4cf739b9ad983c2477488dd98e495a652fa449ac1524e45b2ec1d9418a4e11cfb974327b8757490fd26d1b5208cc068a899f99a956635d45fdb84da92a6306fd73d692fa6bd0736e5449b7e9404b6b76a94e73ff0096187684a9623b71cce2ccdaace75d1bd2d61d557179bff5d2c9bdef37ee5a49649195ea7b050fca3b00e18696259ddc3eaa7a93defa3f64f4ee48ed7680e21bd8da795e566672798da57f9404190a0cfb71c1ec376c1ad38d7059ae8c15a6fd6ab10d532a914d21980edc6555834b7b1537edafa97a4fa8b631b0f50c09b96def34724f0323d072893a95d4ae920122a0f6e35af1ce64e7f63d94ebb51e7cfe97697fbc5c2edd095b292e2536d116e11973cb42dc6ba6831b3b42938123b3fa35e94ed7d47d4d16d37733db6e5ca33c4122494e88e9cc044c1854020f0c3a59d72c57e29c1ee6e88f5424fb52f4fef249f79bfea3d825667b0d9e728cd6f77a59d8c056289638a415328cfcd4651a89ae9cbedbb659d1ea70a7f4b67897a96ffa93d4aebaddbd65ea8b59369b0dff007cb8ddf7748b4c52186721996d61b870cf451404e5e38e7b66cdb30e3e2bbb6ea614ff0004296bd7bb66d2d15f0ba8e70c2b10801d458369d35200afb70beddada23d57ec528a5b47b6fed47ee6374b059f65f55e7fa6e9d9a08a2e93db2e159b72628eeef3adbc6a644b7117cef2796a17456a71e857d775a7d4ce1e5f7e9cb7c285dcf656c3d4fb5f536d916f3b5c705c6cf78a25b5bc8e459a2963351a919411c4114c650d38669fa99d3b8c31a0608740192aad2b4ece186891693788de62d15bd5a94d2cf98af0f2f6613681545ee2eee1ab5b42e00ad75827c28a309d86316cefcb144e5bb004a945a81dd965878260b3519c98e46d5da47c694cc7e1833a0c8f28ccb494d5d6ba5a8699f1cbd98201a31c9b65f8b89250c6688a80a1a9a4779a9a1f8e260a7a0e47b549a4ad4b8a1024a6a209eca370c508a3b372c47cea4d3a2ea557d345f1555edc4f9631a8a03120d2916a3992aaaa7d87b73c00c1129c96962049350c80962a3c0354fe187548260129b7b84d4e596a0860aaa47b68c2a08f0c54e4592c6dad276596f15659e000a128ac481f91c0d64324a48ae9f9896d1ea12799a41a38d3866df1c180551ab389e2012e1010b4a4acaa00ede0314412bcfe951013ccd6c93122924816b5eca573c4e24a012457f7b209ecefd628e940040190f8d75571590c751fb4b5ba800177782791b205502fe02b81483c96bb28f55941d6a3cba09539f79186281750f2c7a6e230f6e80165d4353d33cca91f8e1aee3f80171bb5b3a4b16a64762288594b0f8a95182d6ce01a6474850b24916b958d168b4d208a1a95fecc31cbe84e4920166b0bf2b4213e53f90391181b816a291c32df126d5a5862535570eba401e3424fb30a5ea55a10cf353ff00987f97f57cddfc304841cd25dc6d163e65c3aa286d1acba85d5dd5ad31917121629ad1d75a0aab76ad1bc3b0e09913592ef1c0b4a6aad4d748a11f103f3c02cb44841111542fc3bb0485462186173a75381c0552a3f0cc626cdc6069cf527f4ee29c921915b27a508cfc3b3dd8724a27aae227659d4046c99d0e5e1c0609fdc0e18cc71cd18d6b3b0402aceb9281de6a47e38733a09b34cbef577a063bb9766dbafdfa977d86a1b6cd8609371b8435a51cc158a3f12f228c68b8dafeec09597414b7dcfd55ea1d6bb56c1b7f49d9c8094b9de66fea17da49c8fd058b8890d33a35cfbb03b51777fc109ee7e0343e945aeeb6ad6fd7dbe6edd58ce28d697537d06dc0f13a36fb1e4a91dc25793db85f75f4c2f00a9d59b56c9b2ed7d3b611ed5b0d841b5ed50d3976b650456d1797816110009f139e328ee5fc1968a0b99195f53061c2a6befe3873224c8f2b7449d473e3e5a9cf52312478508c30c318d1baab97fa84a13900b97e27040268289af4a6963a8f1d4180f7f0c1224cb896f241a16554a7ea241fc32ae131855fac0558ddabd4e4428000f761d435d43738a8fdd914484f1197e35c5040526191433bd5b80656a78f7e178164b1b1b63e47d67581452c73f8e10b4163b66d36f2198b180202ceed2b00aaa2a4b67c0015c34a4a9c1f20fef5fd58db3d45f5a374ea5dbed5a0dadededecac9656533496f64ad1c73baa92034a4960b5f2a69073c6b6c61339396d2e0f391dcccef1b5b3146ad351a8a31341f0c4cb59661091b2f49234fd431cb39e798434b233675d1c0b13fde23136b0e95c994f50b73b9bf5dbd243a939cf2509caa140cb19368ece1acb2b64ea5876831c8aeed397a470a1a1278e66868319d2d1967a7f7b6a82dd6777baef223dcef4adc05f244f1921557e62818fcd427334c472da5aec72fb2ece1b350b5ddd2193fea220da4fce2869edc46d838e726fbd2178fba4a2db6973f532ac9a100a79c231500533cf0d59a5929296683b1dacb39ff00a173336a150548646af69ae5e38767060d39c19ab0f58faeba06e9af3a0f717dbfa8248dad6eaf5122b97113387280cc9204a941c33c6dc5c5d59aba5acbe93ad74a7aa1ea86f7d1477af503a8ef7767dca4e658a4e231f4f0445959a345400348d5a9a7ca062396dd0ebf578b6a966bfd51b841bb5ab5c30d6b28356b8b8792434e2ceaa683c32c6499d5c910681b6eef7bb2cc27b68d2de5133463718e20672c28d449252fcba835c941c777172db69e2f371a56f06cfb1fa817db7df4891c3108a6a3dcccd23bdc4ffde9a76ac8581351e6007762d702b66cdb667571d0f647da27dc65ded5d4db774cdc6f2965d1f7175cbdd2daf5b459c09312cd72f45d11c85b848940ed9483cda809597d36cf637e3b39f07d150629e049639d6482401924535054e6a548e208cc6234d4e840da0b24f3bcf53fcbaaa4fbab823a814afb738a07d4054122802fb5b0dc8d30918b3f944cbca03245078fb4e13f02251dbd8060cac2adc06ac032f49165a464824d016a357e184a4033fd64684cd1c6d08e247978fbf0f08191799c2158e373fdc552c6985009008d5a440658db9a0d08968b5eeceb5c0d8de34226379a4d545d2a750af9a8787969e181c02982be9228c8948288ada8173e54f771f8e25281cc93fe9d0f9835c6a46219974f67702065f1c53c8023b7471e992205d4311cb6141a7c49c378090dfb48ac1db94eb92ac6fabf0a604d6a0d151406e8878e57311073350d5ed1420531499304d2cca4ab2490eb23e4726a7f1e182548a641cda677fdc8d650c404f3e633a0190ed389df5ee349838aeb6f895b931acd2024688daa410731a8ff006e29b40d362934a97326b6b168e874d44956047b4d30a646946a1a2962755926b7657552a1d98023bb8138a5d842cf2af334caece41c9b550d3b80ae075ee5046998283a5d351e241153f8e06d08564dd2c86ab695e26693ff006e41f95453f1c2703498683e9ecace48ed23d3123ab345180454f6935afc30d61059c95f551f870e6703f3ff00261fd24ee673b3670d3518116b9174e0471390cb193aa35dcfa32e8904409458e30d9ff96173ef2476e12800a03e9d2d124c295a8d55fc0e1b42782e24b71533433c2d90ac2da97c4904d713a607f02b79711d9abce6295add0173705d630a00a92e5c0000f13869b7a67c06353478fd6de99b8b8936cd816e77fdda3665683658cdec751c51ae233f4f19cb3e648b4c29ff009457e4767d564137587aabbece13fa7edfd15b4af1b8bf2dbbee047e92b6f6fa6d949ee695e9dd876e7a5744dfce105786cd4e02d8f427476f768f71d6dbdeebd5f3176328de6e2682c9093904dbad8436b41c3cc8d84bd86f471f1817d8757946f5b5edfb4ed5b68da362b582cf6d41fb36d6d1882105969544894253d984abd4436b24501555968d1a92c47941af78ad6be380612daf2eae9dd4cf1a15a5016a904f0ad461d5b610a464493336995a99664b69a9ede07075140505a361599972a9a6a6cbdcd83412f24dee7ca745dc8d45a808a5853c438afc0e04d82ac108af772209611b8ec70c1411ed1c0fbb06ec0e1064bdbd8e4d33c6d1db9158dcc81b33ececc12c50ba0d46cf9134595b806514ff008a83f3c391342d70d2348d6d2168df201854af7f119e0981a4045ddc5a48c23114c41158e65ca9db490d3f1c26c7038979633d2b1c76f31f996360e2a7d94c39c910c225ccf1ea0f72ed02b0e5d554b20eea50e5efc3686ea89cd77f571c96976893d9cf1bc332852ac63914a3806a6848384ad04ed3e507ac1fe9ddf70fb0ef7be6e9d1d671f587495b4b2cbb5cb05e4477392cc55a356b390abb4aabe56542da88aaf1c0ef9317c679766867d9b9f67771496db95b3bc1756b2a6878a58c90f1c88e0323ab02083420e0997063b5c9b97435b98b6d79e51fb9734553da00ad4f8d49382ab234a0c275f6eba378b3b006bc988b65c2ae7fd98393c1bf0da183da2fade29c49330c8e618020f8678e46df43d24a4da77dea88770d923b78220d15b93511009a4b0142683865876beec197b6f08d362dce39e435581c9e1a80515f68c0eacf39a374e87fea30ee91b5b08e3b86212211d4f99b2041f0e38cda8655141a5da3eefd37d4379e470f34d342f09e2b71a9a83bb8e75e14c74d12bc0f8a936d306c7e9474f59dc751c77bbc5a9bbb6b349243696d32c723b7c8393a8697954b73006f9b4118ef6eb452e60ecf739bedd76ac5bb2d12ff005367df2f37686d5be84c3b86d56748a336d58a68d070596d242258cf7e4457b71cd7f5a7eaabc1c1c5ef34b6b473edd7ab375b60f6369035a4f709adb98be620675a9cfb31cf5e075cb2efedcafa496ddba8bcd86eedee4d0bdc46e5ce4752a13a811e269ecc7a94aadb079f5e5b5b2236db8ba368604dc83c49c8d3b2b9e324e1cc970744f4dfaaa6d9f749af248c97110f2c4fa5e35d42ad19cd6bde1832919118abd5f2a84f23a3c9f50bed0fd6eb3ebfe9c8fa3a7922badc36cb4d7673f2c432476b0958fe9ee2352eba9032957034b2e43e5c72cb4e2da9df4b4a3d1c9632bb288618c6aceaada470fe6a0c549686576896859d02b28e1afca7c68333efc27e0521536f84a8d4407ed310a57de6b81b0c977dbe281798006ec0283567df84b23525944c813ccb1873a6878e7dc071c0ec90448c3af292acf2123263aa83bf3c4ab2b680e7460832aad64702a6a097a8a76702317b588199d158f9a20bc7595e1ecae7830133d099bc393f3ea9c350a05fc0601a091dd5b49a42c81dcf10386290b6c0037da2665a90b986a123f8625e0755280bdd4350ce85d48a925ea69da687b302f2105a6bd48c168865d9c49f80c54844ea056f3700d52c86b9ae939fc001899c8e207124bb68cc8f1bad0664b9607c687fb3149307816ba99c369d42dd9bb4702299fcb4c0eb22a9682a815609eb20151c0a9f6f760881d9f70ad25e6b04a06aa90ce8010081de7315c3f0c8c0b477a9cc789268e360695675a9ef3434e1edc2b2c6194bc9696e2de495e4053943fcc642a5541ed35cf0e60219612a2b8d52442df4b0e52c9adce7e5341967887339d0a63315ac8ea9247148d19e248a647b972c5a522928d9e97fa79579685869466cdbb7820232f6e07a8887f449ff00961e35e1fa7bbe5c1927f53cef6fea35ddb53ea215238b50153f9d0e38ed769606df7d4249eb36c9
UPDATETEXT [dbo].[Picture].[PictureContent] @pv NULL NULL 0x6e48bfa430d7cdae8065da6b965895ccc7f71038fd72e88bd98daec105fef5bad3ff00e3ed90eb4534cb5cd23471463daf8d173517f73827ee4bc6476d1bd5deab7d7249b3f46ed0481fb65b7adce4523893582d236af84b8e95cd46b09bf9ff0041e5eac347e8cf4e3dc25f755dcee1d5bba4521643bedc99adf865cbb1884768b4ff00f4cfb70edcb76b585e3035448d9d36c8ec6d63b5b5b38ad2d636a2dbc48b1c4a29c0220d20fb318c2344c722b49963f3d98309cf5d148a7be9836a14f920fb7d94f09125b831b115a70a8efc27c75615bbe8c17f47b356ff00a73346e7e52b2b663bb3247bb0'
+N'6c5d24b777d40cb6135a24b3daa198cbe59a095d9751a64c0904023d94c4ed687b9310b3dd6c36f6d57d14714ecb4e4c9067541c030aad0f7d00c4abd56a5be376583203a92c24897544e14f9bf723d3504d28196a32c52e5af421f134316fd4bb3dd5eb6dd61b846f72a099a2a10c8a283f50ecae1d792b304db8ec94b4646cf77b6b8064b7be12422abae3e5d7cb91ca9c41c3dc4392497fb627ee497e446dc3ce283fc5a532c548a1c8fa5ddae88f9370ac8d5d35756535f1ad315a83452ded994279a22507833557e15c24c1a6827d7d8230592642dc482750af783dd84c21935bcb6914b144911cf9b20694ef35c11dc185325b8520db034cc10abc3beb8200bacd672052d08048c89eefc7031e850bdb751ca2a405f9f2e03c30c9050db6d7ce7bc0a5e590f10da8fb00ad07b30a3a8e59ca3d77fb56f427d7eb5697aaf661b7754b8a45d53b6c6b6bb829ce82570bcb9d6bc56556af632e13826f44d64f96fd51d0f75e9bf566f3d052ddadf4bd3db85d6dad7ea86349fe96568f9a1096d3aa95a54d30686165b5c1c837fbbb0dc776bdb8d7596390228a56a140191f762390df8222447ea218a9a98678cb6b6766e506c5656177059adeab9892e94346c0f9699f1eead709283879af3a682377b66fd2315d32329cc344aa57dd418d652306663a5edf7fdb6eadee60dc66b5bb825536aa880b070722788e3df88b430acea6477db1bcdd2fef05cb11b95cccd3486a2291a5ab1d4828aaeac4e601ae1d1ba3947470733a373a331fb1dbef5b0d97d1dcda4acf2c85e34b700b28eca0d55a0a54d463d2af32db2737b17dcf1a07dffa816f5f9d228b99630915bbdd46cc74c6b4724b0ae67c71c3c75dd6c6865783526ba179bbc13490c5139203244ba5341c86553c71a5f8e2ace77655b2f246fab6d69736cb93a49a97dde231b70de6a67c38b3af6315637b249298e43aaa3ca0f6538d30ba9d7566c7b2eed2edb789706af1e6b22f695228462a97c8d23d4ff673bcefd37ae3d111f4acb29bb6dd224bfb788b037160e1bea564a718c4635357214ae3a2d74d64d38e771f5d5e1b304b45a505280866272ee35a6380eb4c1b491a518cea69c016ccf7d7b30d48d95f5c646d6ae5fb34820a8efa703f8e0f322925f512b29921711e7faf31827a8a014cf3dcc6567e5cca3e4d2bf1cc9c2db3aa1a70251492c6c5a389626ad154717a0a1a804d3042d520080c8cf48a38c1191a90493da68070c3929c7503309a662a8500ae75ff00caa3022742723c8a02b487493fe5a8cbdd42303791ea4aaf20d3168514ed047e582594d9058e6f302cad2f165a93eca54e081620337d53a8d2c812943e424923c4e5818d10d65242af08a953fb801a1f783849132c2899872e29147269a4ba8ae9ae6091c4e2bc22aac792e6d21468c5db897481a8a9282bdc08230493a9737564d0f9a78e6414d674d09f681fc303410c5e23b75cb86b5898431f0e58edf60cf097610cdb1542d1722454635ab29cfe3c316b20d609259edaf26b6b342e86a18aaeaaf777e0490a5c07d31a02b1db80cd9151a457dbdf86fc8e18b417f1c170579104417366d681b8f6819e07087690b2eefb62bea69c1248e05a95fcb0c4a49c3b925eea8ed424d43e61ab853b706050cafa35ff00989f36af947fc3c386140f71e583d3beaaf59ca1b739364e8bb29003f4b628375dc8f835c4c23b58c9a7e9493116dbfedafeaffd115b6cf5781493edefa1de47b9bb6bedc376268f75b95cb5c3eafeea51624f62a0c656e29d42bc4918cfff00a5eeb687e76c73b84cf4a03d9ecc65c9c33d01f1ae8673617eadd9aea3b6b80da148153fc7135e26b426b53a725f4d750c535c23acab9eaa1a7bb1d15b3656d25653ccb78258a40cb9d55aa3dda70e5b2dac0ddceed72ee20b8f22474aa2a9515f1efc5492aa8226f6f34896c230b028f34aa332470e22807b8e13718435448caf3766bbb70b22aaca73cf23abbc1181128195b28a34abb050b42736af81a62a1a404b46d7268122c6f1b8aa31009a7b7db88da24c049b2ecd71272a35547a548190a9c1b514ecc5a4e96b0994c73ac722b9aebd3a5aa321a5d6872f6e21f1d64a5cad038ba54db234691cb223ae9320946a2a38024d0fe38171c7c0df236413673b74748d27828079880e08f1a86c38484ed390177793c31b3c112b15f9241054312299942a41af78c0dc22ab0d8b7f55ea0956336efb6bdb8a73a39a33a9bb08c8b67efc67bac5edaf591eb1bdbf597feaedad9ad1d0181e12574eaec62d4af870c69b9ce7433b25d0cb41736d70220539570a0975d15a771a56bd9dd8a5a12e50c7d5aa28595d580cd08040a9eca9a530e6498ec160dd90350c60a819839d470ae74a530b038197b9b0650d32a0001f3d6b97e0706410a2c568f3b18db4026baaacbd9c6b4cfdb82a0b0866dadf9d2a2a30688b5240ac1871cf8e62b809793e6b6d5f6ebd75ebf7ad7d4735ad95d6cfd1377d477f2eedd457103471c36cf752bb2db2c9a4cd3320d2816aaac417a2e2ed7ec63f6db6757fba1fb02f4beefd1209e876c4fb6f5df465bcd756104759aeb7a809e65d417734946966a02f1357261cb51a58010d49ad2bb51f2bd6de5b89162894bbb9015471cff2c45514edd59bd6d6979b459c76b711f3edb40041a10241c509f0ec38cdf7399b97e058ee62de5d36f613ac80d591250453c54e79e2526256321d3fbdef4bbad90db769698a5c2308a4a0121d40856248e3c30dd3e03723a0f516d37f653d96e9d47b64106d53dcb88c480a2238aeb83ea1414d4b5cb501519e633c3abc646d11dc76459ac9efb6777b988ae56a8e924a1588f2c5244cc18123e52712b2e3a156868e7bd4fb5de6df34d3ee6b732c8b92c326a444a0e0ca464070c7770f255a8471f251d726996cd21dc39b29acf2461d88cb81ca9eec4d5b73270fbadaad5994ea4b55e66b51e5b8896400779e3f9633f52df4b5d8bbb4b953ff009235b5d9eeda40625a83db8df6b3b1619b2ec1d3925d4ea97c582282405273a03efc2dbd8b565d4fb05f6b7e88fa4be8bf4b59756f4a596e5ff716fbb3d8ff0052dcef1cdc4844c91ccf1428815638cc841a05ab50549c63ba0f42bc71a1de22ea1b39cc9135c411943558e7a44c699641f33815a41d20621dd6d249b931dd5a34e803189054d0f69fedc56ee80eae24745fc4a19ddd168323191a87e0704892ee012fe32552699280f94312091f018160209096d6e357d3bab383a4aeb7623e34a629313c009a00c052491747f7e849f1af1c10d8a49431c7029d7234b193539d4e126318132cf1e88f5449fcf4072f1e270f120f0c134d6f6c753ba485450550d7c6b96131c04b7bd82404452c495391191a771070d0350c2b2dc160408c0ad4cb5c88f01dfe3891492990990eaa32827485ad7f1c36e43402d55476058228a2861a6a7b7cdc3021b6cbc2a5103212108cc7135ed1da30c1c8f9b58d823302102f01971f670c56096e045e0920d72464a06275b024eaa70e3896921c848b739e15aa222a3000330a1f7f61c086ab216e37b92350d1c45d0804b870b9fb314de44146eb14a8253194aad454d6a3dc0d30bca1242d25fce544b092ddf424100e59569827a94f22ff00593c4cb2cce1a414f2bb7f661271a8e038dca69d74bc8047c72a65efc5a864bd08fd74fe61aaab4a06a100fb48c398064bebaefbbf4578f67c70b78f69cb5a179919a1880122e4c3cacbeccb8e3248d7105e3692250b2beaa71672c58fbc0c0909e193e74449ad74823500198a96cc034c12c5a96d10cbabcf5a766920fe389627878271aab8e5fd414ae410f0c5250c26006e379716c89f4c24b9917cac9a43003c00218fb8626cdacea5d52632c08789a572e245d4acaa4532ed04023d870d327e0945385ca4573e5a8f29fe187d4351e1751b4258c1313d944f2d7debc304a254a0306e3728796b0344065523f1cf0a64a75184b8bb794bbe850cb9a91ddc4823f1c30da1560764d6b268206610e79f8776025e081bbb9b67525c32af00cc0015eec0094e83237a8da8aee1413c6bc3de300d54cd6dd7f1cd1539a92af0cce7f8e021b01742ce2b81c87d249cd695afc308752771b66d3711a9b8b74d12515dc02a40efae081ee66225d886d771318da6169251a0956ae801ad51c0cc0ceb51960490f748564d0ab2cb19723259d02370efa0a9f860624c3c6a27403e959dc8f369a0af89155cf0e04ec01a38500e6452c2e4696206a1ef15c24c6d42c0b5c5cc9014d28b2b8240084834a703965ef184d8e01c7ba40faade561048f4091bb97ad0e6035067f962664adad0f4276eb83cc52ea588d45010352f69a76e2e0869a1e925b62046f254b651d49ad38d01ad7036850e0e79ebff0057eddd19e8975d7505e457571f4bb2dcc30c705c3c123bddafd2c604c9464a3cc2a479a98a4d572c968f8c7b774c5a6dd7cd70ac663020a16c82b1ca94ef031ceecd239dd4a96ea78432432159242d32af1539d2841c88e184edd45263ee2fee19d5e7b38c951446818a11da733ab024a5c0f7ce4cc58efa9ca82e8096b09325e851e68e242330c6a2a6bc7b310d3ea176b53a559fa97b9a6cd6f75b4c91cef186b4b9719ac8a48d02eed5b500d1d0f9d7e6181bee297062f7ad8367deeedfa836f58d7aa670b249652fec584e54056313c1a4c6c40054e5e6f9abc715ba3e0a4849faaae776dae7e8deb759a7dce1a8b637a9aefad587ca04d91b8888c881460bd871365d5039b28b1cc77fdb3fa1eff044508b79900b7726b55ceb4238d0e58e9e072a7a9e57b9c2e1ae89193bc8cdced769311e68d9a07f6715fc311c78e46bf539ef69e2a5fb603d85ac46558a832cbdf8eeaa6d9e85619b26df6d15bdc445851750cc768edc6aa88aab3ec1fa1bd5d7dbe7a2fd15bab6d2ce8db3dac0d346c1831b5536a582d3b4c55c715f0da3d4e38b2d4dc24df6cef352cfb63b057a1d7107a9ef0286a3c6b8cd594e85ba34f0c3da0dbee1d99ac4a92005252869ddc2b8a496a439436bb7d1c1843c2bff002c7cb4afbf0d3122f71661183ba8994d072a461c7c2b5f860791a641f6c49433881a30466a080540ee273c00de442df65b88419e19ee751355e6d1853c6a6a7dd894a0a77e8c6d659add795765a791aadaa35a003866bc7df8ad191035693db5c864645591683cc73a76771c521b1a8639890ac10c54d20283a7e073c090b716305c16028a230722a8b90f1c09771a6910962bc668c16530f1258afe19134c214a071c693c8556e4a4c4ff00ed354003c482a30d58a0d2fd5a45c9745963246a0cde602bc720706593a121696ece2e2a15d7e4f29a7f0c1b437325259c5713731ff73cba5d44922a9f1a6aa60751c951aedd130848544cce85735a9e3c78e0806d8596d76e48f9cc495a7968cdc3d80d30a20522816c66144b89e26ed4c8291dc4153961a450c476f6091d15e452683544cebc7d8298a6a304cb90df4d6100e5a452cc4e61df53d4fb7004b40e392cd15e1bb8d964045068600659509c122c82858956a2f97e5051e95eec9a984994d0cc4d148ac2f209081faa84807b8654c34c98c8a7f50dabff00c9fcbf249f0f978e1cd4adace66acc61495d8a4ac3e539103c45719a7d59a4fee05793b328b4b331b5f3aeaab8aac4a72e6483b4770fd5f1c260992b3da2cec2d5608a4595ab592e580e64cedf348e5400493895581cc9392c961194ce456854475fc6b9618f707836cb046a313229398724904e74a31a7e3850913b9918ac6cede57102ac6598bf949506bda01c25540ecd86d1223aaab29a8c8369fc0e9c5099297cba8bc4acc801a7034efaa9181d81ac005bdb5af944812a2a8aef99f61382607b60706e6b0e931348ca490cad534af0cc8eec36d06d18fab8e522568429a51aa4aa93f0a626450316b7ae48852189b8e7ac31a7771186d89aec15939aba1a089641c09cfe386895e0c5dfed48240632aab902a2a687b7dd85a16ad01ed2d9ecd0bab129d84548afb304404c928af19a46e7b4c85012152300fc68708210cdaee11fcd14ac5c020eb2cc083de298adc21c82f04c472d00a515951ca0efe07cb81409790a6599c912a4457f4b3798d0f69190c2da24a018b347ce210ebeda4654f7f10d81a1ee81a8d678c69941e1d858ff00f55702258bc8b7598223b885c661e884572eec2db05268c49dac452b4b2ba84a1ac287554f854e16d1bb0a342eb2c69fd3574beaac8f4d614768094ad2bda313e20a4fc8e9d8d58e98e731861fb900661a8e44100d462da13b1e5bff00501ea7b9e9df4d763e938aea4583a8f71796fc48cc355bed8a92ac4a0f1d53c91b1f05c3c47c99ded8847cf6dc2feda08963b6234b280ce3f98d49fcf1cf66a3065a1a9dfdc7ee86535d3400781c3ad9b59271ab1577843332492a915564d3af8f661a53a99b946436abdb8b4b6b88ac95da7bb89adf4b8f99640574041c6b5c2b6a4a32b66b3fd68beb02d6bbc59e88ef2d9d743555425594e441a52b88b2845c7ef36ddab76165344f7b169b573aa489295427b52bc3d9dd886fb9699b46e9b06c7d4364905f43ceb153fb3731e72404f03a85481f86126f4655abdcd1baefa3f714d9a2b2b99d6face17e76d1bbf168db83473919e8232afe920635e3e5dac8e4e3df5866b3616d2cbb65e594aa52789566d07882b9353e38d79215eb647cff00128e3e5e37aa7b86b6e11aba0fd6de6a9f8e3d2e3677faf69aaf833701e65c22f02bff009e2d1bf53e8e7fa7f75c5c6fbe966edd2b73573d31ba85b296463941b84467112767925490fb1b1c9cf872777066b93d4f14b75215a0e34a9f9a9df929c6299b40c89988d4cace06469e515f018484f4136ddf9e40b092392868116b9e79815233c56e1c40b4db85f1b8d724442e610e932464f6025402a7dd896ca6866daf56e10960f6d7541aaba9d6be15a65864345af259c214e607655ab39cb8f750e091f515b5fa809f32c9257b2ba69d80d49383a14c6248e6651328449d4ae990549d27e61ef38110866d6e2e7481329a8e001cc8e1db4c506d2c2ee49d43c1048c8c7b485e1c6b5c09822c64bde5bc691698c67f3124af728a1ae14f460902b6960571ff004ee19df48a82a6bdbeef761d58f265aa9047a88a409f3281a8907d94c26c98295d6fe220232c20557b3578679d70e246940086d0c3132346cd183e58e9534ad49ad78d70e3b8db80d44963e614091a36aa3f948a70cc8c1b6099685889e707e9244d4e490c242ca7c29414c1036bb93ffabd2bcc564f2d35b69cfc56a3f8e1c8a208ede6e99de0969cb8b30f50c7e03fb7026c1f71d1f570cba51f50a120e9cabdc6878fbb0c251225dc6ab8e5a228f30d34f79ae1db238317711a07154a8624ac8a4e9f03c786253e8325343756cabcce5ca8ff00232d4f77757f1c2ce812986e78ff00931f0d3c07cff1c38428672092ee4bd5a6d639309e17d38aa83df1c274b3d3b09d2bedc43846b03fb7edf1d8d9aac337d44b236b9e56a6a924340cedc40f60c80e196129d64521c0b671ca61a5c0e15191af661b0614242ae1645074a905b865c454e25b294f4227e9dd44918606a16a5a953c684827b3c309b1e49911a05729adeb9a90437c6b4230125e0b980b689e1040272534343ef386c5a0881c979259e79248dd89891f4a045e140500afbf13b61ea5cca188342c26048468614259aa483d80e1c244cf51900456e228498dc00d1eaf30a034ed3991edc025e43c73ea6c896241a68a2f1a76571481a0c2582aa396a480493c0e7f0c258256160ba95235485891c1958d3f1c1b81b2225258397910ad431051b8f023c3041414ddc5a4c72b29a7cb2e8d07b3895cbf0c0f1a8ac83472da33503171c4491c85bf0c36c965e58ac18e99249403d94033f6e08c0d0b1dbacd18b73ee445c0e9604777b460da1b8bada6d68a0c779edd4f9d3de7084e7b0702d23f2ff509d6832a51853da01c0d06814151e717f2c847f29d27da72c5207a84fea56c28245e6903e6d7fecc2992421b9b5993f7555011f39a1a7c33c1238808b6c9a0ab324a884b2b2d350af71c2802f1dba5e298d9b989c49256a47e63dd8a844cc1adf59fa5bd11ea2ed4360ebcda6d3a87648a4e65bda6e28246864a50b4520a3a311912a413db85b64adc71cf54fec1fd09f507a41f63e8dda60e8dea7875bed7bc6df1b544cca004bc42c4cf09205464c38ab77e6f8946053dcf933d43b1deecdb8dc6d7727937b6f23c4f9546b898a302a73e23db8c13dae1995b22761b6c5752849e768666cc8e01bc41c17bb5a1a71f156fd4e9bd0969b4ec77b15c2c61e742089643a8fbabc318d6f32d9d14e0ad5c9b075b6df63b85c2eff61a21dd02b572a89d48f346ff00e21c0e3656950c5cbc4ad2cd312546a480511c55357100f61f11c312e11c2bc9b26c3bacd048b123d245f900aea23b68071f661c968dbd12db78db8c48e8448c4213946f230a68607e52d5a50e4719bc6a5a691a25c74c359df9e5a3506a85e26c9e28dc69e5b03990a7e53dd97762fee7d3071f2faa9dd59754d3fd4d62d2016575a6eaab12b2ab9ed003696fc31ec52f2a4f3bd1c523b332b15b4f617b7b0dcd1a4b762a48e0c09a2b2f8104118ae3beeacf53b6b2d9f41ffd3d6eada7f4afa876d8e44b7bfb2ea0e65cd35079a3b9b588c45e86842f2d80cb2c63cfac9dfc0fe93d5334174591e1ba1130e0cac5a3cbbf3c608de41a6ea9797a6c2ee369a504564b5b85254919131ad5e87bc625d8221499582df6cb788ac1652315a9a90450f6d090333e186928137216deed42f2d6295031d3460481db98afe784aa93941339217b1de050d186923152f180a1878f1a003bb14085e268d82892a078000d4f78a53e186dc8412d56ab701cc91ab0a80abdbe048270884ca5b95606ac108f9554804b78d40fc7032dac951481855f9b515150d5a78541fe3804c24b7a2140b116d7fa54b026bdd91edc027521677b7803f39031715a2fcc0f6e67f80c087b50c7d4dca806180863fa9b4bd7db4a61e05b4909b73f35c029250651b6a00d3b80a8c1e461adf7371512db88e320ea20655f7d30db486d0a8dc035cf2d2469d68488880003de09eec12c4d60943307975165c8d5e222b970efa0f8604ba8825f319e30a06888549552ca1bc0b28a7e3810200812eb499df540ab4f33d5053803a4f653bb048da682442de021e246799d8117118d6aa699572a014c3f8140ec7b90337d3cfe590f172be4e1d8ca48ae2d390da0ee5a50cd2bb168f8d00fe2712d80a486588a90c003915d3a49ae7d873c26382e6199646912596252a08a30a80788d0411f0c0c08d2efff0090ff002d7e58fe3f2f1c5ef618398bc36d2907450b0edf36446633cc6399553526dbda0b6765b40353147139142552872cb3efc0aa90dd9f42f75b55a5ee9559627588ea449010a7e1c70dd5326b682d1c17b1abcb6f6badc00116de4d29a7fc0f89751b6895ac9b94d1309d123949a7d3b83a969da68086f71c34d838430654400388e8bf300594fe2714991b432c2ce069426bf2bd0134f6d30812c9748b739207486259847998cb007e14381a725429210d2642cd18120e28ae41f85304260f01161752ac032e63ca581a77f6838204d9535a8493402028355a1feccb03a8a5868e20455e415fd27813eca76e1c48dac05571102ef73a73a024507b2a49ecc0dc12f3d0b1bb59a6fda92aff00a0a9009a788e38732308af771b6909e634350aae08a769ecc36268236b775912d912991c80d5eca1384f500dcfd48c8f6c243424a96fc28701304a1bab3aaa490bc2f404546934f7f1c09a0869076b2b1ba5aace4d0d03045ae7eec0b50982d2ec7049e68642ad4ff302794fb40a61343dc5a2d937040034cace3f95757e74381380ddd20bff004dbe5ae68748a9a8a6586292e6c18a0ae93ab221788ef19e1b1495fd36484f313507141e414a8ef34afe184306c2150c5b5f307060287df41f98c2d432484cdac12858d06a67a53f2387231b49de060b238515f29d14c3924f2efdcdfd947a7deaed95ef54742416bd37ea79796ebeaa142967b9c8e4bbc7771af951ddb84ca323f306072c2fc73a0247cc1eb0e91ea2e8cdf2efa73a9b6f9b6ddf36f90c779b7dca949617a0398f119820d08cc658c95e0cef5810b0ea4bdb100735c2a9caaa1cd3db553856a5595f76e919c5f500bc3a2459266a7f285a1f6ea38a547dc3fc97d856c7785bc33100c2a25ae8635a6be2411c0573c2b5220e7bdba9b0c338b5961759759c8a3ab5331dabdb85a39409e4d9769ea4364f2a5e406ef6db81a6e631e59907f3a9e048ee3f1c45bead0d6ba1b0adc9be44bd33ade5a46745bef11af9e207e586f23e20761247c710997a9a3f576cf716d3c978d0f2a19dc97d275223b8a82ac3264635208f663d5f579256d5a9e6bf5df1bb766e44e4bab6bce9afea093137f094b6b98dc8d7cb56fda90019e903cb9f7634e2bed6d149e0fa0dfe9ebb65f45e99f52f50a252d6fb76b7811cc8a8b5b2b725ab5ae7fbe3b307b0ceee04b69ea0b89b72b8525258d4d78c325569fde5539fb31cce59d09175876e58d3ea2e2049783a480231606a5b5ad181f7e14291332d1b49f4c29306406a195cbb1f7d06289ea48ccd24611ae59594f006ad4eed218938206c596dac6d8999daf250c7e70b25465fcb5230a6007e3482e550aeb408095d49a5b31c749c34052582bc42491f89cf545a29fde04e74ee3835d059026deda33a56f62321ad06a624d0644004606511d11f2894ba8e7d24318f49a8f1353813026a966123713c65ab980065824482f35594a279949a17a8cc7b4f7e1b68200179108150cb4f916be5ce999ad3042081ae769d4031232155ecf86064e82c61f233ea988afeda8cab5f6d7b70ca4546ac112667
UPDATETEXT [dbo].[Picture].[PictureContent] @pv NULL NULL 0x646ad0d0663bc1ae58620cf12c4ffb8038615d7419776a230903704d1e478bfcb4018d5a8a295ae40d4e1bc083228a6956c8f9991500cc65a7234c081aea4edd242ccdcb68f4f05635151d9913f96286c999b7566d4f0c2c8c4d34484328f615cfd9825be80e0b4dae799566f29d3f21700d3b3b29f8e126d825d85af2c6e5e4263542694a30d647b78613613d404915fbc7cb4b836ac9428ea886a07650eafc7036e7009a23f47bcfff003e4e15ff002938fc306d656e5d8e78d22a1d47207bf105b4cb2caae3bc1edc0f00d3283965a0f32f1ae012aa90905e988d49d24659354fe184dc0f68db5fd8ceb4750c49aebe06bf018a921d59749ec2406369182fcad53ac11fef06c26879d4141690d9dc996daee331c8c03a32e82bee4f2fe0312ab9d476b4ea3b73b7c77e0986781647a03226a0c29fe123bb05a5e84cc6a639764bbb5924335e3fd30ce26e648e13b4e4ce58d4f8e156ad16eeba2c854fab8154c93b490545278417cbfbc8cd5fc31498617c8d24914d0bcd6f750920d590a15233ed51fc30d09a65ada5'
+N'b574925995164008281c98e4a568572cb0d2c89cad020b789ed95da226a6ae8c013183c0d0ad483df81d5486419b08b5acf03ad54792808034d4e5c3bf3c4ba94db271dcdcc5347238667f91b4c79fbce7f9606c5030bbb451b1596193583da8572ecc801869cb16d1a8b72dbae816d2524a51839c88edceb83514344cdd5b480c08564029a6072030ff00037038643502e370922fd98d641a58eb42a3521ecca95c08a892ff00d5efd1c3042e18135d20643c71339813a8ddbeff0075ab43c54046a1ab88f70afc70d8b6a0d25fdcc89485d44873a14d4077d6b4ecc0c0889b7264054c2594020b82756af67761b97a0f120626df412acd1c6012056b4a7783427e389965380e53702eb3491c52b014d7192d978a9230fc93805aa68d1915110371660cba4f7302471ef187f00d966bcbd9818cdd2c7fcbc94249f1d4fa857dd859082f01bb008baba918034525829f61e5aae040724fb80fb56e88fb86da4aee3cbdafada1458b6dea640f2cd1ad6a22994ba896135e07ccbfa08c4df8d582670cf8e5bf6d836addef76c49a2ba4b3ba9ed8ddc2498653048d1978cb0074b69a8a8e071844619cf8b68638974a0a0515ccf0c526989ac13b5b868a07743a4b4b91ff0008ff006e0b2259b3db5e9bfdad24e32db64cbda54f776f1e1887879149b26df7dce8a39346a99000ceb4aba766a1de319b70689e326c5b65b5c4730dd7a52f560dd17fcdb7d540c3f5028d911de312d169c686646f16bbb59cdb37546d32d84d71557b8b588bc0c4e7a8c5914607305081e071546eae50dfd4a19a175174fcbd2b7d716924bf5365756c7933aa955995cd064730cac06a1d871e8f1dfee1c76e3dacfa1ffe9fdb5f53edfe835dcd7360d3d8eedbc4d36dfce529548a08629258f58a32b382b5029e538ae673a1dbc15fa727a6ed0eef6ea857618d282958a48c330ef00818c17c1b34bb8fcb3cade5b9b768d58e4aec80788a1068716d9097626bf4ea849b729953c8e807bc2d30848bc7ca8f367198a92c46ae15c8e1b845103757729096575285150e54237b284663002f28084ba8ff006e5ba98bb66e1d788edcc0c2ce85316b8985b249142d3acab4e4eb1214aff88654f7e14c6106a63f72de2fed6485ad772b7b5b8000911218a40cdc72246a1f0c45afe4aa57c0e6d57dbb4a90dccb7316e11906aeb6a2942781752411ed18bab26d5498f6e51bdcc206dae20bbad62578e80e9f990e4323876ce10aaf39256693f2dbeae2ff00aad54620851a7c08a60e816f012da79a0b8fa73109ed5c13ce6947908fd253227dd827f703d3c93c848d1c4ed0b1351adab1d7bb3383516a1628650598dc29771e5a006b9fbc0c506814dbc510d2ce3980d429edd5de300b6f62efca4ca470030cdc38f281e14afbb08705e29ad8c84a18f95dad9e66bc49a8c269b08091430b0602525f513a4370cfb38e2e1c09848f963335d668721523db5a0c3af801a9678a1804a24d0833249038f8015c04a463c5f990cbad583a903581915f6e78164b411f788c88e0861959cd58baae90a07f8bc70e4981390c73bc8b1c3235ca7eaa8cfb49a31e1ecc4e0a1cfadb8fe56f974f14e38251072b8e555c8c6aea78161c0e25a372c0a0274c480f1a01fedc1b42092bb806800af860b0a511764206a2c181241c87ba832c4b1c484026705e2cd145582e74f1a6786904a2f16b953547aa51daa1aa7e029810ac4e3b17b805a38cf30710736f865816a3dc9217bb8af76fbbe6c92bada691fb4d1283abbf99ab31eec4b4e4a59e9932105dc2613ce0d2a38a50507f0c34c869a17730ebff00a243424168d988033cc034c0f1a0dd42bc6fa9e4b88533a7d3ba15a8a1cf5f8f6612f21a0cadbd94f098255601cea5aa8c88e3420838a6258722f7b6b7164eb756b74d1c7a68aa1d5aa3b2aa549a785709a82925390b6d7f7b730176b8b79850792879b976d0134c4d5b0b55124bf467fdc255b83280c3876a934e38b925a1955b99291d9cc65283585a1d43d99ff1c290c6a2935c19245929a278f26324657b7b6a3860dc86d4064de278d916e638a48a9daa3b7dfdd83712d071b85c5c4ecf68a9a08aaea228001f2d6a4d30c5b6097f51b8d6a5ee22040d2631524578d38e14c6a102f71bfdbc137eefee95a0aad55857e3f0c4db912652e37d09aeedb45d45cdd735b48bc680e43b0918172261f6da16b8deac6dcd12e24b8462b5d07b1b813c08cf07dc48152498dfe3b79424d70f096f956415a91dc460fba8151bd097fdcd688c5bea4b38e2741c8f679b867f8e05cb51be16330f5123ab490c6d75d85f4e9d278e750060dfd89fb6e724ae7a9c5b3c6b70154b79568baab5efd381de350af1482e7dcde4a244b59c432e542a4a5070cb02b06d34af5e3af772f4a7d1ceafeb7b2fdbdc36eda674da8b2fcb7b754b5b6ad2bc25955bdd8d2bac9cfec726ca3b1f19ae6f369b29adb66d6b7118f2dd5cab03491f8b573d441cb10b81d93b33cbe1bda964ba7f36cc7eff0066769bd36e8c255755785c0f995b865dfd98cab593d26252698a358b8b27cc47f31e38799234666f61b9fa760f25392e34ca9dea72e3e0719db4808866d1b7caa9190320a6828332a4f678e33b2943ab46cf611c17451f98609ce4938f2eaa0e0c061245c366cdb649d5b6cea2cef90c7400ac803ad078b765303293878365b9b5d8af2d60dc7ae63dba7165233da9ba9a5b4b5662003cd36ead23265f2a0ab10317eb2b3b6dab8f2473afa65ea7b8fd3bf56ba3ba7fd19e9bea2ea5dc8ec7b6311b4ec3636d657f6d25fcf18d51c1b6edf299279c32b0d01436ae3963bfec6613934e2e47b54ac98d4fba7dfef7a926e96e9ef4dfa8778dc2c6455dc76fb5bcb33b8d8a1cc3df5bc46686d188e10cf70b31ff0096303ad56ac72ceb5e9efaafe9e7aa7b54db874befb7334967208371dba78cc37765367fb571030055bca7bc65c705f8f68eb6565e4da59a4d1ad6e19a3e19c2e49eef9710dc148a59a27528f75e5fd48d6edf8d785309314174b7b2968cf3a89070d31ae7ee20e286b01d23801d3cc0de3a287f0c0d09909ed202ca6290a8ad5d8678320a45ae3a76c6f583ce8d2305c981efeecb12e8996aed028ba5aced5da6b08c5bcf4a1985519bbea14807de302aa44bbb7a89dcecdb8ab9aee5cb341e652ead41c01a975cbd98367934dcbb0fc86fe387502d70a485d31328a53f52d5549f65702c10b2c04f16ec23924b7b9895b554cb346ce0aafe9215850f88f86069838231956b44512b471924d68592a4d48f30e1edc24b181c190532c689c88d640451fce01208ef507f3c689b8270c2986091ea60415a503392437bf0a41945d0ca4fc924745d229a6be34a1fc7000579d20cd12ba88a93967c73ae54187e04bb0586eed5ff007642a5d727514201f6e1a703816b8be58a733a31550a484d407947f87557e18567010062bd9afed566b4b9adbbd08d4181a0e345201a7b861269e83758d43c97b1ae933c0cc74d01e5b6a1e0594e6314da16d91486eec2ed16211333b9e051c0d43880d41f961483ab41edd394c4b5ba82b902ef4f81a038a4f02f0179d37fc9ff00f73b7fe1e184107340cf5d34534efcb2fc713fccb826249d41aa026a295615a77611491617320cca68ce9e6a13fc460125fb837d5bdca2c0c57550f9bcaa48f6e5c305b02d1e0b476f2afeedb5d042a69c731d9d982da8322f6b739bbbc264e2480c08f1f2e140e48083701a297d2232ff0097440e3c4666b8986563b0edd2eef731fd3cf30745a318f90a465d9427861d9304d2d0b4379b69244f018a52687920a8aff875103dd812481c8758761762b24b70bab89a69fc40c34672c17f4ab249b4c57b7661cce90ffc08c283497d51436fb420c6b7170e0004233675f038a483730f6f18825a473111f1fdfa91ecc972c225cb0cafb8444ba3c6f10346088a4d09eca815c3c8b05d44fcd620891594d1c0d2081e01b23eec24806114c89a79c59f3a07a53c33c0dc001933944771348a380d332a8ad7bc1029ed181818cdd36a49d9ad5ccf22b11acb2ac8401c349ad29ecc45eb2a0d6b68c83b3d963b4b54b48cce2104b292c115a9c5481fd9895c692ea3b5e7264e1db76e9181b8d4ce002af9b15ec00f8018d21193b3e80a4dbec796e1e252c0ea40eba94b54662a3b476613aa1d5b0905ac3cc5fa311c531a9ae6723d8a3303e3836c680fb491936bbb4ba136e76f6e4b1a19212c580ec2c1957bf315c4acea1bbb0c4fb75ade5ba42627d449e5b28402a380ad47e78ab24c1369c8aaf4f569f50b2c4010dcc51dab4e2b5656af0cc6236414b918e9d9e3d46eac6e24d2fa40aa82a94f9bca73c52267b8386c659a5e6dc44bcd8850b664915e3a5684604bb8d978665e64890be8bb89c99162f287af6d07761d6c2b23c49fea7bea8ddda74bf4afa3f6734e977bb4cfbe6fca8c6312da5b9682d2394d413fbdadc0a53ca0d6a31d5ebd672707bae5247ce5bb728ba514228e007678e3aac704f8376ea2dcfa7df68dbbe9505c6f7c88f9d330c958a0d54efcf1e4dd659e871a6eb93559226d0b41566edf6e26b6c95b60cbedacd681437ca574b03c3f1c676c9374ccc6dfb9c71cc59d872c91a8ad4a81df9e789685ba0dbf6edce0b3d25979f6d3718ca96a13c0d5781eec5460a5e4d936cea24e70b4b78cc6588564142c077e740310d497047aa7adad5ef2d763b581e4b78a390cb21459526903681185ad1581caa3b71d5ea70269b665c9cd0d247af3d12e93eb5f5b62b6ea9b3df2f799fd3a2dbba9bd468e1486eaccc51aa3f4a74a46de5b448929f597e835c9212a953c3adfd2a0dab6dc7acba37a2362e80e9bb7e98e97d8936dd96daa52d2df954690fcd34aed57965739bc92167739b138c26753483ce1e99dc0d97eeffabad2dac1a3dbb7ebfea3b5bcb75500336dd16df748582e5549277e1c359efc75f2669fb8cb8f0ff79ea47ffb666514ac527600e573eecce3919b29188366b49c91677d708c07f35548f6d73c2413dc9b6cd3a7946e0e58f616009f66296a00ff00a7dec398b9e60fe57e3f11801151ab93a0950c721534fe387d0524961dcd2a100a57235ca9f861484643c0fbc23f9de3643fa733f8e7861089ccacc693aa508ec047fb312c2448b35bb15112ca2b5342572ef19609c04078e7503cb584371006a15f1c36a430102f274bc4c850d048ba40a9f1e18016352f23a282c9092e0f145535f8e1b045c73a522b10d75f3890035a0ef07020d0592195641235b1e629218a39d143db418505c90991f2103d5eb52927f6e0b080496cf7522494759d574318e5f2e9e34d1aa9853201e2b69d5435b9d605287cdab2ec3438a5e4248177e7f32b10208ce4562dec0411f8e08ec13dc35d9dd441ff004c96eec72547a8a0ef181bec08c707ea659a9f476208a12dcc9413eca21cf132d741b4bb8e477dbabc7aa6892223e71a99878e7a7f862b730da4b9c3fe5a7cb5f99bfb3862a49fd4e6c6589680b21a6592d7dd8c9da726db0225cc4b52236724534856ad7d83129c8f6826dd2c04e6da582e239299965755f716184eea6189d1ea1952090031b510d685bc7c698d177420e22854ea257c68491826052cb9786304035241a925b861a1640816bcde69d41d6943e6e238533e188705398322bb9ea7e7b96320140c169c076e2884b04bebc353c9cc73c6a50123db8725350497728590466dc8a663e5232efa531339d05b4b8bf88d0042a057335a0eec8d72c03da8bc97ab172ccaf6ecaddcac1a83b7b30c36c976bcb1743cce632eaa6a43a72f78e1efc122556462fa02eda490e54e962c58e5c0569fc70ad03b05fa28b3d2034a28595b222bc694c11916e226d230cccb93ff002b21cfc414382015a5168e395b52fcaa383283d9e240c1e42701a35dc1c850ca4f61621683c0e1825821769badbc22e648e39222681bea32f78031320a0b013a959ae25b6881cce6c5a9dc284e1bb4229d53d05de248e55ba9278ae2300d048ccb41d94e38ceccaf02edb8ed922b88a32ed27ea0847b83984d313bd3782a1c0cda5c2c60032c9e51e58164476ef269e46afbb0ea4396656de4255be9dee417cca8889153de156a31a321a217b69b88026b7e73bf16584b231eff00d230a0160c0de4dd671dc036b6ef25a292185c48b1b69619004af1ae31b2bf446c953abc8f35c6ecb1c51ba4f966c15d164ad3b0e8e18d324421fb6de4ca8f2ee2925a430231b896504d1235ab3bb045d2a00249ad00c15b4e09b560f8e7f76bea7ed5ea9faebd59d5db16e1fd4fa724b94b3d9ae86ad2f65651a4113461b308c559c642bab576e3d3e25158678bcf66eedf4383dd4da98d4678a6ccd05db37416d3ac7739da1c8d4574d7b478638b978d5be4e8e2e6da6d676f691d668c2bc54aab2b7973ed031c4db4764e3255dc62048ea72cf5501c2ab2522f6218833b2130a9cc1cb2c5b64d91b7ed715ddd428d1abc3011e690d40a78633559652881bb6deac45db6d7b4bf38286375720712a2b40dedc7570faee7267f733821124976ad0d9c945b68e4792741531092a19aa47cccd92f70ab63d0aac1859ce11eeefb0aeb1ea4b88f74f4d4dcc76fd1bb75b49b859b47459619da486264cfe657ad6a7b73c727228677703c1ec9b6db4b4b08faeb8b8d642b01a09ccf85311a1a3b1e60f45a2b6ddbd7ab7eb18f9f2477b3fa83bb31d5a9840fbcdbed16ec40ec616a4789c76f2a4ab8f0674cfea7aa64b4d9ee56af0518f12eb427f118e3893542cbb2d8ac9aed99e3901c91490b4f1cc8c226461ace55075ab32815aab03960022af0a300c66407221949fc46029790e8d6ea8581461df4a1f89cc60d48820f73105216654a7cb424d7e39607a0d8b4b7834154ba457232d4387c0e0d0a50f5091dec2456495585294cb0c6d46806411cf2acab2d69f28d5edcbbb04750d021bc86143acae87a02c58295f678610aca742e775db2da320b07d22a46ad6c6bfe1cff000c5384b23dac4a1eafe9fb894c3134bcdad1979138aff875200719abc956e2b17b6ea5b0e62a7d05f5330657b5711e5d95f1c0af3880b71f91b4ea9863899d60940193a72db58ce80e8e247b31524edc824dd6c1e4fab1248cedf2c522d083c08e5c9a7f3c3581bab931d16e578257d0ed12335512e2d4000127e5951a9c3b31354e4a70666d2fd0e88ee68d11246b0aca350f1c6aa119b1b3731a64f6d23203c4ad7ff1c7040aae40b5d5baf30881f5019298c9f79f0c26382115fc6403cb9750e2c10815f0c2c8742135d4ca19b94c1788c80afb4e087d42110fae3ffc76f935ff00e32c50b073f37719035a81e04000fc71941a3924b769918c9d34fd35fe184d148b34d1ca7cce4f6904ff0003833d42111314208d5190c7bc1fcf0e30345f92841a23071c01539fbf08520d9c2e4c0871c54823f3c13d07e0b099b5050554f68229f1cb12db81a4156395879e3528284b815afbeb4c5740ea1e2db2296e0b06d1a568454d29c6ba73cf0b6cb1481976ebf8a6ff00a4b947b76edd2d5a7b309a61baad06449012b20d795687865e18a436c7a39eea14e5a31e59ff00da68f50a53b0d30f24240d5e6572cd4d2cb5cabf87970647a9748266ce39b58e1a4d6a071ca8b816450185642ce241cd40358200d34f6b7e63090035bf9125469ae072a5e0aac81fd9e54fe381bf252525de58e42591da45ed1521878d4e9c29144e0229dc63459e3b17960151af5460d6998f316c0e75418ee59ef3ea2cf425b3c5766bfb4e1595803d8c07f0c4ab20756be0c8c237b8a04e588de12aa7cc803a13950851d98acf5160c45ded978f235fdcdc4823e1245968cf8d687576633b533268af185a83b46b288c777b6471dcf2d882dcd3551db5d6cd5c15aae8166de18e4b751dc305936d8a406943cc9038edec4029efc69fa11a7525041d3b5637365244fd9a599ff26c2da984dba06976be99ba20249736b283e465d49c7bb5291836a127624db1ca268cd8ee12bdba9a8e6c8b5cb8d7bf0f637912b78189adf71823ac774029140a5a32b53c322413f1c364ab2679a3efb7ade1e97fb70ea7d8b7bb858377dfd6db6fdbad6d2fa3b5bb9524b85669f94c4bc900e5e9955450a9a5471c5f0ab4e4cfdab5557e4f914f26940b4000c77d6dd0f1ecb02b236aad0e26cc2b80fb3ecbbc751eed69b16c1653ee3bd5f4ab05958dac6d34d34ae68a91a202cc49e000c62d96aadb846dbb14f75b14d79d3bd51677165b8edd2345716d346d15c40ea685248e400820e4411518e7e4e3dc7471d9d70d04beddb6a9e60f35cc8900f95444c5a9f88c73d786c6cee80cbd5d616c02edd66f395fd739d20d3c054e345c33a91bfb211bcea9dff748f94d2182d4907956c3429a66357127df8d69c69742373667ba7772bbbbb3925b8627e9e918d2349776f95481415a63a78e665e845a11b16d77c20864b56942bdda88e635a29d46872ee55e18a569c0938477afb7cf5727f4bfaca2ea2db596eade30f06e1b66b553756b2e4ea19b20ca42ba9fe65eec4727937e17b727d1ce9bebadabaafa29faeba7af5ced6b6b7139e0b24325aa334b14aa09d2e856847bc65438e74b28ebe92703fb0e96ff0079d8b74eaebfd72c165b66d9d3bb7ca3e520bdc6f37fa58fea6b8bf52d4f0c74fb0f090b8b2a4f554728151199686b50cc0d3d95271cbe4a246f235043c658ff0077ca7dfd981c82405efad8f9921029c75151ff00dc308ad422b891437d4695fe55cc7e3862920cb692beb46d6f514643978f03f9e0804d8b4f1cfacf28c3a2a40d55d407b78547b30431a6ba80b8837e65536b2db2d082c1d09a8f6a8188b6ee852549c8edb86e4ffd75bc26e483a9d01095af766714b4c90f5045602e01811684519731f0c348be8124e6029cb89563046a7082aa38e55fecc39225750faed892dcd504b6614004f777e7849306217fb7874132ee73420365470e05785548a71efc4da8f54cbadba0a4fd13b8df1e647b9ba96cf508636ae5dcb4a625f136b52972a5d0145d337fb600b7bf597b1ae7ae362721df19273f1c0a8d6b216e456d140d07b3257e9ae648a80831dd465a9dff0035298b8253199ae4288e28e448d09cca2d540a1eca5316d8921afeaa96b6fcd6996655a06d0ba88f1d233fc309b26148edb6ec97506b8d9465550633abbe9438a0da2abbcd95d335bc92f2665cea0b2306af0cc67ecc1b931ed6425be9603e4979fad6a191865e2ca4807dd84b20d78276f791ca046246e61ef190238819d3b7bf06ee82682eab9ff989ddf29e1dd89dac0e231ee1d45c8a4ab62265cf9a257cc78811e3993ba5983b1d28f4919b5dd2e42ab5e4d68467af973331f60aa8c0b91f50b523a11b8ea0b112698ae50328358c9663eefdbfe3856e49614e32f6f752deac4d05faa435265508da87c53112de85baa5d0cf5b4ce9195177248a78c62ac3dc32c6cbe4cad1d86d6ed2e102cd25641f3472c654d070d3230a1f6571a2b11b485d8b5e5f39644009a85903569fdd34229e184c4964561b8b56859b56946240068013ece3837a29d4941791bdc3431bcbcf8d435190d29d8030a6056cc09d216423fd4ad1ea800cf32c3f8d317bfa06084b7d5560d7cb095a50aa02d91af68f7622470fb03b9ba8e5d735bde5dbb4b93ac4acd1ea038850b51ee381beb23557d608594b1bc5a5a4bb594654a48c181e3c56a07bb11565344f5dabd2d964b932d7f6e58db4c8b4ecf369a8f6e0dcb4925cea16696ed57573e66229469604d5dd9b2c80e2b2181cb79f78962d322f31d47c9ca443ff00a9b0f289b557426b1c72c65dee54693e788471d41f7b7bb03ee2307bb5af4f94964b8b8bf458e8d711da5c38500ff76224fc3185ab5ead9b57774831dfd1763b88ede5b7b5ddbe9de8606e74d5d27b7ccc4e3374abd132d3b2d5a32b6fd337f6f2078ef3708602498f9923320cbf50d409c5d78df925f2d5eb06736bb749545bdd48ccf53a896741abc35376e37a2fde657664b6cb98ed9a58c41238e1cb71965d95191c34b532b48486fcab4937d385997844ee4023b34aa96cf1689b25dc87f5090e965b368e56140240547b38e7855654125b9be7d2bca43abf4240ff00fd4ed4c018d0848d2b39692c8860b46000d4be20663e181e46a3b9c73ee93ee5b62fb6be848f76b9da5772eaede0bdbf4f6d12b95866911353dc5c02dab911123569f33310a08ad46bc7c7bbe0c3979b629d59f1fbd47f513a9bd4feb1dcfae7aba75b9ea0dd6769ee2450424618f9628109223890648a32518ea50b4479766ece59aa3b93954e13704902d5ad38633903eb57d957d976d5e8ced9b0faabbdc0db8fab7bb6d8255339516db425fc61b970c5e5633f29f43bb134ab050389e7b5db67a9c3c15ae7a9e0bfbbcf5b64f567ee0fa8fa96d52d5b64db646d976c96da2117d55ad8c8e8b712b66d23c8da98331a852abc14635db8471f2f24d9b39541716b3c44a31580d58822a55bbb09e1955698a12031ad349e19e16ec0449789433ac712bf3188550873249c861d5f6d497e4caeef71f4cb6db44521d165e69dd4ff00993120935fee9f28c6bc9785b484a5c96b7dcee19f5bb6a7272af015e34188568416aa66d5b1ee53c12473a1a37691f8e13d428a0ee7d3feb875574afa75d41b1ec97f245ff7058bed7730ea254a5d2185e555a8a48b192038c1c754eca3
UPDATETEXT [dbo].[Picture].[PictureContent] @pv NULL NULL 0x435b5ded6bb9efcfb4eb0e97db7d09e98d93a72fedee2e2ced75ef10c6343437d724cd3ac88684d350507830514c2e5b4da4ede38848eb2526429464901ec58dc1a119f038c8a90864bd50135a728ae41aba81f88c12d841549e5451111aaa2ab4eced15ae0f054a22ede60046a0834f33ff00661c02485db70d0c42247a94f982a35483dd418521b4ab8dec222960545333a1b25fe6274f6613e41aa31cdbf7a86e60d48f0cb6c07ce240a4d3beb4c0ac9937a34396bbeecf71ab5cc808fd248a57db5cf06f4d89d1a1b17f6454e9d0c49a50538767bb1500d1069edd17502538f1197b8e016a2e7e8eee85851b33dc48f0030e4ad0a0965090e57485a8e2181af1041e383525b0b6371696333adacaeb131d4d01cd73eeed030d0ec8765bd8ae3cd1962c72235328cfb72c2db2206b61685f991ea125284b92c3e0c4e1aa84952ecdb44c46a560dc2aa695cb3ae0841b9844daac9168929118ec655272f1230e3b09d80c9b2c266125b4cd03119e8e048e1553fc302a8d3c09dd6cd7c49fa810dd475aea65f37b6a713b7b8e4ab7dbada3fda16dca6515555cc1ff00662a186a06ef698649285103020e680ab8af1a52b51e0709a1ab609fd1dbf741f3771f97bf0413b8e70b67ba06d425b74f10b97e0319b4e4df7217bada6e6f942dc4f1c814f045d39f7d548c2b52752abc90c2d9d8b599067852e5294d3255e9d9515cc1f7e12e3813bce470dbd84b22b5bcf2594b4cd580615f0233fc30dc12aee0a31ee54a25e5a4e832aba50d7c'
+N'4e91814f71b4b58644c3be1f9176d704ff003303ff00d406073e06b6f92eb69d42b5076cb57e15e55c11efa1070a1f804ebd1b2263bc06b77b2b9702a0c771193978b28c349f543565dcbbc925048bb7ddc4c40a1692123dc71319d0267aa209b8ef16e55e1d8eee70c7cb2ea4d14f1a0c12fb15b1770d0dff0053735c9d9514b660c93d00ff0086b826d3a09aae9b89eaea251ce436969acf04766a1f11a4e2e2de09fa58bdc4dd432921f758b50040e5a9397b941c43762be930d2d9750c770d35beecfcba66ba56a49eed6f4a7bb193adba1a2b56340d145b90d0677b89c30a92027e54a7c302dda859a4350c1b8c72978eceea5d47ccc5d52bee0bfc71493ec2b3502577d39757770651b44f1d73902b713de75127136e39cc154e58c48d41b1dcc51684dba78978b4ab4d7e346a5694c5578e1684dafe47adb66dcae6d0c16379731a2d1952b568d97b56832c354e9921f224e5a1b8f6aea531b97ba91da34279d12857603b1940a123bc0c524f416eaf6088f7535256d73c67493f36447114eec3ca106952cae5795343a8a8a12752b8a9e01d70f5273d0b4125945544824761912493953b6a95c30c854bb8e1511ac77090ae628b5153d809c096495565d2eb5b066d4b5ed9588cbe270db08662fabbac7a77a0fa4f75eb0ea9dde1dbfa6f65b67bcbf9a3476658d382a81f33bb10aabfa988187552e10acd554bd0f8b7ebefadbd4febbfa8b7fd77d48da39a05bed962bfe5da58c4cc60817c40625cfea72cd8ec5f4a83c7e4e4767273266ecf1c4b72496a1e384d8a0ef3f6b9f693d6ff00721befd4c55d9bd37b09906f5d43300ba94b79a0b157149a7201caba538b91906cef748e9e1e176f83e8bfdd17a8c9f6e1f6cd7d0ec371225f9dbedfa53a65a597992bbcd01b71339ae6f15b46efa8717032c65c72ede0ede7baad4f8decb4ecc7541e496491e33aa3241c440d36b41a82ed0b52e2a2bfa80fcc621d0d6bcbdccfecdcbb7b79777aab2c758ed54f16948cdc57f947e38b4f6a9655af2e040c850991890c78e4318eec8e310316b35beb52ea7577920e2ddd6a10e306cbb75fdb4793517b83646bf1c250630cce586e6933c75ca28e4515272d4787e18d78b156cb9ca47a17d2df53f7de97bbb6ddfa76eded77582855d7ccac06456443e56523220e39d1d3bf69ecff004c3ee33a7bd48d3b26f293ed1d4e554ac48fcc8ae1d01e608281594d016d2c4e5c0e58ceed44c9d5c56dda1d497a8adf6b816262f3c82ba2469220486e1a849229a8c4fdd46ceaec50ea3b7ba5596431f24f0a4f107a1c8e92ae6b9e1fdd927ed343f6779b6db5b95633ca7e6d6c5a422a7b08ecc5cc09d5b0e9be6c0cac6b29907106394923b8e5815d03e365e3dc3a62e196456a85cc865614af61a8047b30286255b169e2e99914c4814464f9d57811c7b2b8ada81bb204b0ed11c816d2355041ef4351dc294384d0dc868a58f98a1535213e61535141dc40c8f860428295eedb52e94a6a2550547b733db869c0e0909aee0a168cf2ce4dc2801f1cb089488f22299c491bb6b00f94330041f03e5ae7dd86c6d818afd226914b178e1a0732791d7beb50011dd813c0f6c8cb6ef14442330a3508350453b08a1c1b97513ab1cb6dca3951846ca6878664fc2b8a4f226bb9337402ea2c5569c07cd4ae094282d0ee118635795a31d841ad7d986c6ea3506e50eb628ce40c8290569ededc29814309fd4adf51773572294cc9186812c0359eda461a410c78115a53dd4c3942f01424657547a68389afeaf0c1d05962dadff95fbbdff0c4c95072413dc444665c1fe6a7e58c93365590a9ba5fa648da54e4453b30c36068b70ba391a950385298a570da914f32b0a376769cf098aa88161955bcbc48a6140eaba92fdb22ba4953e180724a28d506a029dc3f861c2019846db293f55ad63041346a7b69809cad037f46e9c987322dc9a115a0591815c2c0d5dae854560b6edcbb7de9113b46a6031355039ee8b49b7ea7abee31b1efd797e58b25b4ba04876bb534125ec4077d6bfc70f025664e3b6d9e256696e15d81c82e55f7e1e2026c4feaba7e2cda367e1c7129a80db60e37dd8c574c0d4005325afe3c304a05c6df52e3a96d9502c71329a65e07c684613b0fedb6447565ca9a20ad389a67f8d706f0fb6117abae99744d1ea8ebd94ae04e05f685a4dd1266335bb1864a66465f9606fa15b4b1ddf7346d626320a7103f3c2dc5aaa270ee29279e5b67495be66420ab53bd72a7b41c3d096a3418faf57af36dd9cafca75b29f11df82ae05b7b16e75bc947fa4d42950ad2193dd99c049286e6c50932da488f4a65c3d991c09a9d03f52d3eedb55adbcb77722182d608da69ae64d30726241a9de467f2e95504924e292964da4f943f7c1f74d75eb675a49d27d15bcb4fe906cad18b14862fa74bfbc541ceba94515a401eab16ac828d4002c49ebe3ac23ccf639773c687959db3381b727390a62581eaafb42fb20ea3f5d6f2dfadbaea39f65f492070cb2b6a86e77822bfb565553fb551479780e0956f972b5bb1d7c1ebce6da1f57760d8d7a6366b2e9ce9cb2dbec3a7f6e856dac36eb5b748a18624145555007b4939b1cce6719659e83883e737faa7fa95b8ee1d71d2fe901e4c561b0589de6f9225505ef371aa441e82a345bc40a8ff00f21c7570d7079fedde5a48f08b666bd986d9c647c30964637b56dcdbaee56fb7248909b890219a4ae88c7ea76d209a28a93418512348fa29f683f683d31ea0fa13d43ba75ced91fd575944db7747deceadccb2b6b76aa6e312ae6ad2de007557cd1c657e5635cb99f43d2e0e255ae5659e11ea2e97bfd837adc760dc5346e9b55dcf637f0835d33db48d14a14f680ea718abc38616e1ec62443a4e8a1a8e231a3660d130ca8ca5aa181cab5c3484cd8c486d36ab66d404933f334d7334e071bdd7d08c25b73d0ddba37aae6b272892e82788af1078e39d1d14b1d12cbafefb6abcb3def6e629b8595c43731c9dcf11d40fe1438cdd4e8e27f5267d49e93b9e9ceb0e94da3a8ece3866b0ddac60bd890519473a30ecb9d7e56241eec2d8b43a2d769b1bb8e8ce9a991696b1a77854141f0184f86a5ae7b7732716c2904023b7789600b4d3ca029dd4c5ed21de58bc9b38b776944b124ad917108d5c3235183686fe82bff6e4d70dac5f0472751d31839f8d2bc713b06afe01c3d3bbf40d21fea1cc89b808916265f11e5653ef188546ba95f72b1a07dbf65bddb4bf324b89cb508497944023b400abc7175ac7515ae981de66dcd123659278155855e258ea47f2e608cf1376e0aa2af52f67b95cdb6a596669dde8424e394457c480a4f857055b5a89a9f06660dd58aa99a1201cb8d538f6902b8d53240dc6e08858451468c410b521aa4f0c8903f1c26dc09541ea570b2cd6c927968c0e9d2476f69c8f8e059d4713a151a5a48874d9c0a2a046326d2a3bc8a7e1871226c67fe82d63730442077c8bd32d5db5a7e1834272c8430dabbb480d666f9c926872cc675a1f1c35053b30f0c32c7098cbaa8435895465a3b35127e6c340c6563b75d4e64cc1ad695ae5983c70490591e1753aa5432546919293dc001810d20b1dc5bc2ccb33a6a15655073f7f0c3914124bb542590011b00c0500353c287026d815f5c9ddff00d3ff008ae164707230a40032241eff00e3885a79364d12323280b4a77f8e0db8122ea41ca841f6d2b84d0d32941d2326afeaf0f8e1d57404d493d0d1a8257223c8c4d6bf0c381495f4db811cd8623cba00594823de0e785108728a482fa4aac6a4b0e206470448e5107b7ba042981cb0e2b427dd84d601bf250b7b95a31b26704fca683f33806df90c90cc6a16c95586409381c82f92416e0015b540a7869af11df9e1a92595aa802bc6cac38d0507b0e01b5d822c8cb45e486a9c80535fcb0402c6a1e1bb58f37833a53cd4cbd9864c3ee351c96d2f94c4b5cf3c81cf0036cb9b381097b7a0cab4715cc775313b497696252cfbcb2e9876c47406bade4862072e029a9bf0c19e881390f6b6d72b1acb796d1198f18e36d6057b8d109f861437a9538195106b039608ad0a31a30f11ab0de01933484f940119a82ae7f8f0ae1a916e24860317967033ce322bc7d8306829f05453edb4a48e5255190a1cfb32c306da24b7d69157402e38d02d456becc27052908376b76a2889fc4115e3edc34c9da79cbefd364ebbea9f4077387a2b748b6bdb2c6459fa8ac24d3149b959af0b749c9a821e8dca1fe6f0ae543a715a198fb1c76b284cf91370ac92346ea55c541539114f038e8ddd4f25d5a792114124f2243023492bb058e350599998d028033249c4cf71c1ef9fb41ff4fd92f8da7a99f7016124360025c6cfd193a6979c32868e7dc3cd545ed1011a9bf5e91e56c2d79c23bb83d68cd8fa1d6d61b7ac31dbd9fec451a2c7122e98911545155542aaa800500140319a476bb770122c166f35dee9bac165b5db46f35cc93bff0097146a5e491a4f968aa09385b5cea3b5925a1f0dfd6ff506e3d53f55faabafa69a49d379dd2e27b5792b55b40fcbb54a135016054503b298f42aa2b07897b4d9b34420f6633d0823f9e0ea076af473d05eacea8f52fa73d3cddad6e36ade7aa0da384921267b6db2e905c1bc68f22a1ad81917552a943c18606e149d1c5c2dda19f673a6b66daf60b1db3a7b67b76b6dab6c82dec6c21660856dedd5628d751007cab9d0639b71eab47c57f5665697d5febb9ca9a3f53ef2c413a8e77d37123f3c63cfab33e146b56b696f7d71a2e14888e4d2a8351e38857845daaada99b9fd1feacbeb3b9dd3a56d26df76cb2884f7cf6919926b784d754b244b56d0b4f330145fd54c74d2d2ce7e7f5f6aee8c06fec2ddad214a68d0c57fc2adcb523fe0ae3a79de52470715210d6c178cf3ac6b4ec25cf86308c1a75937f3b8346b6da6312c7a7f7d5bc0d05071a630e49a9dfeba8fa8f6afda3fafd61b7ed169e9eef2c4ed509236e9d9f3835b57959f15d4c69edc3ae8743a6ec9ec16ba72018c165e21813983efc53b193505cde5d305ccac66b57e3a694e39d706e1ed4caadc220662244ad4d2b5f8d4e189a232dadfc882b3c51233540619904d78ab023123ab4111258880f7c4a2d41a3123c284b123df8690dfc06a5ef30986ec7248a0f36a229efc34d89c074d2a073a4e630a02f95287c2b96081072d633298e63148adf323915fc70c493031da6daaedf4b2344e322aad5ffd2683025012e0bdcd959dca00f2ca589a9d0429cb81e1c709a1d5c08bd925b9fd8b899148cc346ac69c29c07671c03562291b21d42f50db814e5340410c721421a94f0a61a940c8b5bdfce349bf8d0b7cc0db0911a94c879850fbb1364ca4921bb6b0bfe6022ee2957bf97a08f7023f1c524d0b7226b05fa4ef1c6e4c26a5eaa6829da0d70c5f24decc888485db980fcc0d3e201fe183e452c1b44be7f22bba8ad0e4c3c461b00f1b44caba9541a79755750a77530448b24a28ac82ac6d2d46acc568478766007286745b7776e9f9cf0efc280938cda4c597cec0c99eaaad2bf9633593a6ea06c48154288891c4302587b0a9afe18128212245a378989408c7b3323da031afc0e1a48690436b7021475412474f24e859a87f95c663d95c26a44405cdc46594af9b81502bf002b4f8604da1c4928ee2ef56ab669515b8a507f60382025123b8dd6aa4921e6264a48d2ca7da057e386e449227f5f7d31d6f2891cf06145607c4e5807b422ee1ba06d2b3d5ce5c2bf1ae0961b532df5dba0e329cf320d2b5f86063d88a17f7a884f349cf8530959930890be70e799a5bc1b3f761b6c369333c6f998d2a7b41607f3c1661b59646878312ac7b2b5f876604c14845b44a0911aa1891535e23bf0b5429091da5e9158f590386935fcb0243c7520a972ae758f2f68735cf0d0420c24ba82839e86206b40476e2720d0611cb347a83472851e562d490785315927407ca90a9fdd2ac78ab6601f60c0932a576222de41466963a1fd4ae01af67970404a41006629aea5c0aeb2c29f1c1e496f04d42aab4bce8d6252737216b5ec2491f8e060da935cea9f50ba43a3ed9ae3a97778ada509fb7046449332f10046ba8e7d95a614f70aea7853ee2bd70debd4bbf9b6db796687a6a076fa5b463a46907caeea322e40a927d832c2bdbf71ac1c6fd1ff4213d76f5476ee9390cb65d3abaae77fdde2405adad22049a31f28795a91c7ab2d46b9d0e278f91a7099cf7e1af23c9ee5f42bec73d27f443ae9bafec3759ba8f77b60a7615dd9221fd36406ad70822a2bcbc023903471035508d9f24a238fd65572933d266f75b1e61134a4d4ba97ad4f6d6b9e17c1bc0633cc45794e1a940c5d453f1c124b527993eff00bd67ff00fae7d0cb8e9ab28f5eff00d70f2ecb03b1d42ded0207be9477b142235ff1d7b31a71d537939bdae4755f27c9891b53138e97693cb8807d990c46801ec2d24bfbb8ed6304bc840f60ed3f0c291a527d52fb0ff4fef2d2cb74f5f7af2e1eefa9baa90d8eca24fdb64dbe128925c0240ca530a47185f28863ee6c63cb79c1eb70f1b89eacf5b9ddec65997f7b34a32a905e99e5f2f0cf18a68d955c687c72fb95e9493a43ee0bafb64725a26deeeaf6de4652bae1bf6fac8da840e2b3626ef390a2355d825861969322f2b831f038c4d56a758e84eb3bbf4fac77bdcb6e91be9ef366dcac404399fadb692140dfe17707d98e9e150d11ec7f63f83d6ff6cbf6f5e93dc7dbe74a6ebea47466dbbf6efb8a4db87d7ddd87d44ab1493b0822e628d6142460e9ad3cde38d7d8e4facc3838dec5a1e42fbc2fb7d8bd2debfbdea5e89b72de976f52b5cedeb0c13226d52c84732c66e6280a03d4c59d0a51788c72fdcc9afdb755a1c2ecb70bab570eb21a0a5431ae5efc28409c1bdf4bf5749b6dc25cdb3b23a91500f6d4674f6e04f6ea5d6c7d2dfb51f5f2d7d43e984e99dee689ba836e89120727f7a6880e2471256999c6d4bc8f96b3f523bcdc4b1950ca50549ad6ba4d3baa0e198a62b3eddb55c825a59d58839f35a9ff000a9a1f7e236e4bdf0541b6ed31c6628b56aca87536aa7b492702a2077612df6fd2e50ea3131a996a3501ec20d70ea9c89d86bfa30554fddd79ea0c5427e54c5e8292c2c1906a546752482ac0d69eec0853d0a8a38124e5b0d328cc57bab8ac8b24ee046a34cca03b91fbc816a078820e130908b7f69131428350190e38a410146ee8f4d30b90452a46553ecc4834105edab444346a2a471cabefedc5598aa9848dec5d48312894662b5c2078242d6da650a32973ae8e03df8a412e40cd6b029d0a65a9391a91edae7c30b4194f6569a47988edaea3434e39610f7109ad2c5606b8a36955ab5189fcf038424fa018aeb6e29cd4964555f99496040ef20ff660dc36984816d661a9253229fd448069e200cf155b0309c9b6ee3c69fab0bf4260e422f248c5278e8bfcf41403df8cb734748583708261a50943439616e16d0dcdbb8bfcb62f1ff2d462e58f05d6e9cf18b2273578f23fef290709a9d44921a3b8732b1ce0f2ce611656207b9f5604282d1496ad5a4a43927cb2440d3bb35230f704b8d0a691c96124d1c8b5f29a1af852b9e2770d206406ca880e47334fcf0e1f51e84f9924a02c854b8f94a683f1e15c4e449a2cef39a090d40e072cbe1961f41ca2cd2c6ea412e5bf4834a7e030d08322a4b11445476ae435946f650e58050d30a6c24554678a68ddb8ae906bd993296070986ee8092cd8332b33020f94b2533ff7b090dd974080cf18d2a558819e80c0fc2b4c19128202ea7a1018e62bf3115c0bc96d1759c5753ab3123b4d461cad450105f80a2b08651c0681c3c4d306e236e49a5ea2d088d63ae7acb5387b8e090863f15caca402ca75702a5a9e15c86787b84eacb72a60c182091471a283f11961c761386735f58bd74e91f48859d9eef35845bedffee5bdbde4f25b2140480498e299ea4a9002a9efc7a1e9fa6b97eabd956a717b7ee3e28aa4db671ceadf5a375dcf68b6de6c3a9a0998ca2f22936ae49b754d4696f2fcfcc2a471211bf9971f69f89fc4facb6f2a86d3f99f9e9fa9f2bf91fca73fd5c6e527fa34cf3975af54ddbdcdc5f5acdce333972b2bf9d59c92da351cd6bef1c31e37e6ff00fafaadddf81e1ffb7afe87b1f88fcd6faaaf2acaebd0c1f457a71eaafacb7ad6bd03b0cfb8451c823bcdc5cac36b0eb34acb3484281c7854f863e3b938eeb0d33df5ccaebe967d13f403edf36ff453a1a3e9fb2bd8dfa8ef889fa8b78823d1f5732962880bf9b950862a80d3b5a956c5d38e0adc91d496d6facd497dc8cc9d8080c29dc716941133906d7cc8d451113c353a0ff6e1a59048223cd707cc6d48a7131d30049f2f3fd4d7d4697a8bd6cb0f4f219223b67466d91a3ac20006fb720b733b353b445ca5f0a637e3a9e77b57dd683c73957172721456872c10107a87ed4bed8ec7d5feb3dae24dd7ea3a560b1b7dc7ad6fa38dedfe816679346d70c8f5325c4ea82aea02a296615d39c59c1d9ebf1279d4facf6db6d9dad9c165b77d043616b14705b5aa22aa450c4a1238d174e4aaaa00c73e19e84942d22462ed0d939273a501f7500c11e072cf227fa807a050f56f49a7ad3d2d6a8bd49d3908877b82d94335e6dba85256a51b55b124d687f6c9fe5188e4a8a4f9e42e1c0d519f0a03c7df8c1af06af48ea6d7b1eeb2dd6cb7564e41a852aa7c1813f80c6deaa8ba31e77f4347d74f4bba55368f4e7a52cb6bde191ecf64b084189411e58135e9d55142d53c315c949b36996af0a20c8efbd0b61d4d6b71b7ef9b8cf7f6376863bbb3b88a19a0950f1578e446523c319db87cb2d72c744795fd59ff004d5e8aea39ae378f49ba8874e6e4eacebb1de44f35833815d314aac658549ec21c2fb30df1f9326f278ebd51fb6bf5b3d142f7dd65d3f347b0a48b1aef964c2eec199b351ce8eba49a7070b886a350b2c8bfa5bea8ef5d07d436bbd6d73bc175038224426b41c7878614edd0d38eed6a7b7ba47ef56db73b14e745693dfb7cf0cd2f25c9029c0a907da315f70df651b946d11fddff004d2b84bcdb8c739043224a08069915a28ae7c41386aede057e0aaea699b87df7ed92c7730d9edaf06e90c92c304da83db9d2c42492445759ad2ba758f6e3bb8fd5b594c9e4f27b8aadd6038fbecdcdc8b5daba7ece59a3014dc4b3c91966a0ab72b3d209390d4717c5eaee53265cfeeedb44186ea5fbf4f52b6ce9cbeea78366e9f7dbe058e0b589cccecf72d200ce744c0850a68011427b71cf7495f6a365c965c4eecb7daafddbfac7ea57ad163b0757dcdb5f6c3d42658176e82dd208ecc470c93096029e7a2f2f3d6cd518b74841c1cb6bea7b9ae6dae27aa4ad1d187f98549207b318bc9d4a04fe9ee79f24724d1496ba57924290ea7fbd52750c249952a246562d0451e22dfc83cbf9e293220654c8ca00190a57bbf1c341289b345182ccc04469fa01cbbcf76068451302bfcfcc5cf553334ec3415c39090f14a0441e00e41c869ec1e20e14016bd8e49c0925c820f9bb687c3b7db815643a0a218a1d24b64335a7b3870c0f03f02b2ee31075447723502c023514789e19f1c4ccb29558c318a663a25f2bad00008c8f8e2a241b15cedd805bae5434cd4a29cc7893d987a065f409ad3ff97dbdc9f1f9b0132ce60fae68c2c9157b0d787e78ccd942d1908c082a4c79119120643bab84a90f05b41566b77ca9a58f8915f014c537dc21a0c848006bd4b4ed3c312dc12b24bf6914962a1ea40a67ece185ba723dacafa8439d78e55a6787323262e15482175e9ef1c70a4853d4834d113fb8a428398a7671c548e037d65b3950ab414a0f660438296ee1268bc785081c7bf862773130915c851492dc383c353107f0c537d41a2ed3d9392b2db81f13c3baa704892ea58359ae7119101e0b5a0fc0e25b40c973c00402e69dbad8d0f86787b90da908b78e472de707f9438a91ef3c30484053caa0d62373da6bc47883518538c8ba038d6c9c942cface4299fc33c3436da0cb05a46743bab83c3556b5eeeec11029609ace0f955d578d41f2fe7961aac02b6480b53a098d0ba839b21e1e0699e158a4ca412236905d01f97ce457f1c2891619ca3ee23edd2dfd6ad9feb2195a0eaeb1802594930a452f2dcc9186942b3c6c84b6975078d195870eae1e7da9d625339b9b8559a730cf16dc7a57eaf740ddcfb26f3d2dbfdff51ee0e228ae21865bb8272cdfb4ea600f0065e1506a7b71ebfe33f20bd6dce5c35fc4f2ff0025e8db9d566b99cbf076af4c7ecbfa83a823b5df3d63b9976f90ba39e9bb0e4c8ecaa5581b8b86122296e0c8aa72fd58e3f7ff002dc9ec6ba47f1ee747a7f8aa70e4f63ed9b10d8f6b4db3a7f69836cdb2351cab5b58a1863503869118418f326ccf4934b044a6ea01801635e2accb957df849345c541e9bc452d230cbb35d78601a8292eae23ad5158771a9c2c8
UPDATETEXT [dbo].[Picture].[PictureContent] @pv NULL NULL 0xac911beea18769b1baddb7368e0daec2096eaf656f2ac70408649189f0452716a5bd09b2507c3cf513ac2fbd41ebdea1eb8dc199eef7ddcaeafdcb9a9027959d573ec552147b31db4c23c2be5c9ad7eacbbf1048f6df6eb2ca669549822f330fe6a67a7f0cf03692965d54b83edafdb5f4a6d9e98fa17d1fd2abb4dbc3b8cbb6dbee1bdcfa02bdcdfdec6b3cb2cc40a9701c20afcaaa14643185addcf629c7b7099d145d584bfb91c6a8ff00cb434c4a69b1a4e49064242bc08c0f0d350700a084db4da5dc52c33daa5c59cc8c9340cc0aba38a323af682090704c8db67c9ffbaaf4066f41fd4bb8daf6db79c742ef01af3a6ae65f30111a19ad4b76b5bbb69cf329a5bb71cf7a34fc1ad21a3996c30ca9318c506ba53dd8e8f4dfd7fa1c9ee62a7d5df45ef17abbd24e9bdd24bd11da9b0b786e426aac5f4555940c8524674153d8bc2a698ced572fb1d16d11bb58dd4888d7d219647df184db7edf715864855555594815d034d1a84d751a1f31a626bae7a92cc9497fb6c28256bd92052c551e627492a6872601aa29d98b6c526afd716179bd74aef5b449cdba977fb2b8db6c66ba6586d6292f616895a389e87204b92d990280e74c4b5812727c7fea1e98dffa13a82ffa67798391bbedb335bdcc24d41d0681d1864c8e3ccac3265208c60e34ea6d09680feb8dc0426d99140a73148ad7c2986da615ee654f57de6c760643706434a470c84935eccc678d3893b5a09e6e6d959356b4deee05d35e3c8753c9cc9002732d99a8f1c7b35bd5283e72f5b5ad26724ebcb8b7b768ac4e846159242a0b569d8d99a65855bed5069cb377db061db73dc7ab2e36ed9ad2ddee2e3594b5b3b3819ee2ea673e55d31825cf60a0ae30b2faa56a7456d6b2553e97fd957daf6f1e905b4fea3fa968b0fa83badb9b4b2d991a375daacdf4b36b65affd44b4a3053444f2e64b531e4b620f43878b62f27ab05c87608eb20506a083a7ff0019631993581a711f2c328a8606'
+N'99eaa7b7b715a13d60c786569402486a54824d38f78a614a184082534594b23661410083c695ae630c157b85960999a81855869614ece3e381b9103685b3542d45c940523877e194b23114123290a589e20d48f7d70e304b9448dadd65a0827b1351d5f0399c025621c9bb3428155f850711db98c3c8c97d1dec824974c25e94a50063efa626ca0120dfd3ae654569a288051403881df5230d306c84967a1494312f780a482477e7c304e02487d3cfff00361e15ff002b0e7c81c915af8d2a2bed18c523a5d512d72eaabc2287b4e42a30f21826439a7900edecf8570a2461a36801d4e3da0f0c0d212b0426d39218baae7c3327094064195b06f9276d59d748a7bb150821c491fa48c0d66472a3bce13f01bba0548edf22656a1ece396292502965e3483b0eb507238502ca2e4ea24463cde238610d60b880d0976f31e06a69f8604a44d92e493daa41c89eef1c219111c6a0a9706873e3d9edc181947429f2935e3a8e74c100993599cb1d6a8c387cbc698498460bea5cb501ec197c70751446a5c3c553a8115a68a1a8fc71436144b6c168c858d322682982604aadb086e6373a57cafdee6a3db87842882618c8f4658ddc706881524788c39e82594573618c9440c8d5ad189cfdd43896fb94d0c457b708d55ab2d323a58fc01a6068cdd5123bc5dc7f2a6b1c195a3a7f1ae2ab663d928347beee2843c6abcb00fe91f020e7852274184ddef641a74857ae5a40a50fbf14df512a909659ae10b3da07cc8d433e1e35c21fea0567b4ce39ad4464659f8765706e1d9b08b36d2c0b3c469ef23f0c384287070efbdcea98fa57ed7fadee76a11a5d5fdb5bed35a1d412fee62865cce75311618ba39661ecb6a8cf8e469538e8c1e494a0b1017e6268078e14091d0fd2ae82ea0ebfebee9df4ff00a5ed85cef7bade45a918811a411b09279256392a2c68ccd5fd2319d9a67570d1b6923ede7d65b9760a8a56b451f2ad3b283c3d98c1b3d3b54beb80307017491c3ff2cf0285a0e09a5fac6c4ae9a8e1524918242246a0dce190057604ff00376d70e509a3957dd1fa511facfe92ee7d36b6f1cfd4f600ee3d3531a2b25ec2a4f2c3f10268f546470351dd88ba9c215624f957b7c7cb9d18ab239a02ad910750a820f68eec5fa29ab331f73447b47ed2bd61b2e9ddb27e99ea591cedf6faee76cb767090fd5c8114194e93c40f29ad14e7a4b118c6f872cea7c7bab2b547a1ba97a877696ea0b9dc88b2ba44fa35b6b54796696794432a48aac084449e916a3a879aa68d92e56b36e4c556df03bd490edbb3a35e492cb77baec57b6935ff00eecad23a72ce92ac0aa2556a48a692d952a462da8d350948d1fd4dfb86f4c7a2ecbe97abb7fb4badaeea7551716e93cd75009c4ab24b1471a36978e12a1731e62c726c6cf86fd519579f8d753c83f767f719e8efa9f77d3f79e99dacf7326dd1c96fba26e163f4fcd8e248e3b368e42ccec1143ae934e38d69475731839f9b9d5f4670483a8373dfa30363e9492e5ab441696934d99ae5fb6a71bae4af6460a976b0d9b26cff006cdf715ea45d456fb37a7bbbdbc522f33ea2eeddac200a7f5196ecc6a38f6678cf09ca506eb8392ca19bbedffe9e1f739346c1f6edaec15722f71ba446a7b808d1ff001c66ed2e4bff0012ddceafe99ffa626e37524577eb0f580b582a4dc6d5b0c7ce974d3ca4ddcea1067c691365db837f72d7ab5ea7b23d1efb7bf45bd0eb509e9e74fc70ee8542dc6fb744ddee32e92736b861551e6e11845a76613bce0dd561423a4dcdc5ac485a660b19cc83929f79e1887086b502f7db7c2fa39a57c9554ad6a0f754e09452432374b4911f4b88ca2862596a42f7d30db1553222582676781e266a50b6b0436acf21df84a0701a3d4ebcb4d1ce4a1242ff001ae193fc89ea90b3332d1881550054788ad060790917740809965714193ab2d4807b80c2d3239e8cbdbce2363cb7678dbb49cf8e29680d0e7d448cccd10c82d6b99f80c39252158af9e781a48eab2c4c44b190564f72b69270ba0dd5019f75b6b78d0dc492a452ea50e237211876395ad0fb703b25a94aae7047fee3db6de18e41746684f131f9c91e000a9383792eae74c9393aaf664b5e73bcba6991786551a6be2b9e13e44b51d78db16ffbb365ff00f2ff0093ccf90ff97fcdc3878e0fbbe07f6ac73e7785734240388fd4d9d4125cc06a24a91db535ae29b1345c5cc4cbe50580a0cf2c1234835bf225f3382100cc93fdb89b04344d56d15b5a852bda38e084536c9d6cc2b151a5a9965c3df82609ea4440255256e01233d3ff009e090ea58db1a13ac71cbb7fdb87b903444c6c1f48ad7be94a6277041549c12687470e1872382cd2cc0548200ed382ac202a484d0d169c3bab84d841272242589a0ed078e0f91441491835d269e1ff00960912c162a73351519570d3ec048860a55d72ec3db85904cb54d349a8ad3fb303c15e491046591cb88e271427dcb510350e4c3ff19e14b1261353a81a4fbcd4601b28125ab9b57891fc313a8358082e245f2099d47682c47c33c531c261959e44a89222471d673f8e126fa9245a5a124bab1ee57e38a80592eb342d5023abfb493ed0304c0345d49890cab1304fe6cf2c4a91a445aecb2d0914398cfb7df8a968491712dcaa968e5a578d32ae13b3ee108f1eff00a977a94db6fa5fb07a6b0ab0bdea4dc3fa85e3920a8b4db4515476f9e6994ffb98e8e1f270fbce2a91f366b963668f2cc8ed36eba9af67ca08ab4f16189b3c1a71aea7beff00d34fd29b6b9b0ea5f5cb73b679b726b97d8b6225091142a892de4d1f1a962e91d69900ddf8c791bd0f47d4affb9ebd0f74471b48950856bc0f03f0cb18a67630d1448d5353ae9c09073efecc12227209400b1a6b5a57ca2a7e0298a12a91051d4331d14ca94d27e180661badbae368f4e7a6e7eabea0b948f6db52a123c9a6b8998fedc302f1791ce400f69cb12ed1939b9b9abc6b758f933d5b769b8759eedb9456c6ce3bbdd6f275b33c60e74cf208b80cd2ba7876635f4f2db32f6391da95b7719d87a8773db678e58e43190a55ebc194e44107238c539507a29b3a96c5ebaf5c74f4519da7769d582e9502562428cc26672009a8ee3c313b12d18dde70cd5371f5ce1dc779bab5ea9bedd19b5074bf4be9a495252a013247233472e9ecd6a72cb1ea7ad6fa7fa9f3fedc2bb8d0c3ef1ea16ca6d1ae6791a69a457e5b43558a446d495d3968665aea5cc0f118dbeea6a19cfb5d54aea71ebdb9d88ded2c43c50302743e7a452b4ad319ef48aaab3699f4e7fd3dba03d4de84f4bf75baebd86fac36adfee61bbe9dd8ee95c4b15b88c97bbe59ce313971a572242eaa798638ae7b5c74b56b0de4f51b493dbc88f240e509a8a10077703e18ccd139246640c4aa054fd4b5a65f8e2a4448dcd96b1e74f32f0e232ed14a1e182050ca26cf3911088e94d4a0b0af7f78c057c97494c71909aa4001a1614207b0827e23098b5149ae2e0b9d3652491b8003563515ed14d54a5319b6e4baa5dc5254bc1fb90c37108434d4acb26953c7c88e2bf0c4babd4758d04ae5e5b8b1648ef6c85d2b791c6ab5714ad3556abdb9e58566dac32ebae53819b3b902d9af2f6e16ef96023cf08562847125a0a35078e2d5b1962b6b8197ddc085195ae6489e863b8890ce006caba96a453c4607712a886e5d530edab15ac9b8cf3ddce74c1711c21733fa1a26a86e34e18cafccab8cc9a5389db2123ea8daa064b4beb9bb7b9404384b59066dfa5951298b5ca93cc93f69bcf40f15cd9eeb6cc76adca48e442006113230fe5ff323a8ae2b72b2c326c9d7542e66de1a56856ea1b8a2055d53132ea61c78281ec18599891e12270db7533ed9fd3008207435fa84f349ab8e7a89cc7661ecb351a09baa72633fec3ea6e602bd437f42ccf4892dd23524d68c0ab139e327eb3eecd7efaec8d85767ea116096af78b70a005659a08ea7da50007dc31d1b1bea63354e49ff0046dc7fe55b7cba7e43c3f97d9e187f6ec3fba8e768ae4d349efc62f08da096960338c15e2282b8136382c91bb0d416a01eec53900df4ecf15467edc296c8b345d2da83c8749ed1d9f1c3dbdc732196d1699c943c32cfe38412c93c1047c6421bb69c0f8e1b722dc402c7990c7571f6608099419ae228968b5d7da4fb3087d0b0908c8655efc1644b705b556b5274f66781a9d0724f95103aa36a9eecc7c7bb0eaa502640ae8a6bc878ff00b3034345731506a2bef183226f244b00c1d4d2a33edc389117cd3363c781c0d04e0c7f52dffd06c5757fcc1a2d95262c322047229607c29c718f2da2adf633e6bedac9953351d80760bd82831aa728d25117959fccd53e27b70260ca0cf515143df5c1a032e15c0a834030e1022c0252ad5d47090b24e32ab9e90c7b6a6b860f2329719d134452fe96d34fc461b6c22021bdb990d5cc07bda814fc4678324ed44e32f1993ccc6193e68eb5e3ededc0904026fa694988865a1a0634ad70d15b591d1cb252a648bb96953e233c0d033e4b7dea7aab6feab7ae5badd6d17cb7dd2bb0a26cdb1cd1e51bc56f533cab9e7aee1a420f6ae9c767171b4b2789ecf2efbc9c26c6ca5bfba5b68b8b66cd4c9547163ecc378304a599b96d2e77adcec3a4fa7606b9bdb89a2b3b6b78e9aa6b895c4688380ab33019f6e3387a9ac676a3ecf7a05e9b4fe8efa41d27e9fc6608f72da6c17fabf21f5a497f39335db860457f71c807b4018c1bce0f5f8e90a3b1bbcb19793519f4d4e5a94a8cfbaa0e25e4d16088b472b5e609083f296009f6530b40dc15602b4a0640735ccd7f3c540b7488ee3b959ed9730d8085eeb7cbb467b6b08dc176453e695d8f9638d6b9bb1f05ab65897d8ced77a7531317a6db56e1d6563d71d5370772de36e509b4d948246dbb6e918d249ed6df4d4cccb40659096fe509c309521ee643e35bb75b2cf953d5768db5f5a6e96171219e7b4de2ed2794558485279159c31e3522b8d3d26d5dc91ed5d5aaa3b986de77e92d959ec2db33c35f8f7e1d78af6f088e4f7ab5c2cb39fee3d4bd473dc55ae0c11700b151453df86bd7aad7262fdbbd8e91d15f6bbf71bea158c7bd74d742ee736db76bcc8371bbd36914aa4fcc86e5a2d43c462de04bd7b33b1749ff00a6dfae3b8c3f57d6bbaedbd3db722196582dd9b70baa0009558e2d31d69ffe4c43b464d6beaf46cf4a7a2df64fe8c7a6d3587583d8df753f5088639edaeb794530c6ceba84896255630f4208d65ca1e19e23eeb893b29c15a7c9e9a1b8efde62d149247fa6424a3d7c55d48f81c46e653aa26bbe6f718f3dace42f14e50619f7306e387b986d4fa8c0dd2e1a824b47590f113200349c88199c09b276c326b7d6910d3246a9956aab423e35eceec53b75134fa16facdba622385dd80ec7a81f0a1c294c61d2eed135aab248a73d214f13ded41805b45a4faa901023b5ccd43b2b161e1c709f692932303bdbb026384b0f9994b827e069870c1b4c5f768a2dc00e552293b48851ebe075106988e4a48eaf681dbf6a7b612bcba9a4750a9225bc71e9f1aaf1c15e36ba9a5ef25a7e9c4b88ea58a39cf5f250e673fd40e15b867a92b9608c1d1cad26b70260450f9621427b724c25c09752df3f41e9fa7606b75b5b878d44753a98abbe791f997176e151933fbcd685f6be9be99b1d6635898b760406b5e278530e9c555a05f96cd19686df6d4aa41185048392aaf0e1c31aa339637f4b14b92ca1453b4675c3277382dfd39538de85fe1849a4089470aa1a9dc2a0f014e18b43b76809cb83ff009cddf89da467b1c9e08f741035cc82ddd2322aa8cdacd7b007515f7607ebdb4945af6ab305beb8162a54834a1522841fcf195a91d0e8574d608b4b291a631a41a71edc4b91e00e9b8cfe6209c88c0f254a2261b8a902a7bfc71290e51750e9950d4f114ae1ba64372d02525e25481c7571180440ebd542ebdd97f1c0e073d8b0ae9d40f0c28624c9895e9539ae5df801a091c8a4f9aa0ff37f6e0e84c25a842d51ac12481424605e41b0692395341f29cabdb86d4041246ab10d953e5af677e183705f49272e3dfdde181e4260983972996b5ca8076e1609397f5d7585a6efd0dbf59ed37b6f713ddc5ba4702a8274c1636cf24ac185016d4b4eec61ecb4f8acd3e8cf98e6fc97272725b8ebfda63775fb84b2b1eace9fe85d87699778de772876e375224823585ef5237d34d2da99637d6dd8386382bf925575a252e17f13d2ff00e52392bc75526f5ea67558e8ee97937840595a78e02ca40235d731e3963d5e4bed5257e679edc7c2dd5c334ae8bf50b77debfad9d9dbeaf7786d7ead6cef1db48a6ae5448ab5a33139d3c31c17e76b76ccde343c3fc67b5ecdf76d731dcdd3d32f5053afba74ee2d0fd26e36d29b7dc2d81255650010c95cf4b03957b6b8cbf11f92ff002f8e5a8b27947d17a1edae7e39d1f536c798eb0388c7abaa3b8801e6a3667f8f860454146f61506391d10f89008f138730637e7a535b222b710ccdfb52a3d3f94d48f86126694e4adb4c8e5bc81908a90c3e573c31416245f9536b9534e75c89218f78384e4708c2fa83b5754750f456f7b5f41dfc161d517f6135b6df75748ed0dbcb32e8d6c1056a149d240346a1c6b56a6591c89b507c60eb4e81dffa377abedaef916ee3b0b892d8ee167aa5b594c4c50b452695aa9232240ae3a95d33c6e4e0b57e0c7c5ab68b135aadfdcf61fd2bd988dd2e3a129423d77fe9f1f6eb7fbd756597af5d5f6ed1f496cd2cc7a71080cd79b94748c4c63233861d4c4357394003e56c45ed88e8767abc0ffbd9f488088bd0318a165a8320a0a9f0cc639f076b9088658c816b22cfdac88ae4fba81a9807aea1795b95016460c7335047ff005019e1a944b66b5bceedbc5e5e4fd3dd2af049bb45a4ee1ba49a1adb6e0c69a5f496e65cd3cc9081e32145a6a8767d193be7151ad9761fe813cc21672f7adcfbedcae199a7b99c0a06999540c864a155551725006049a65d6b548cfe47cccd048dc43125b8770230db17483c29f771f6d1b7f433df7abdd21b8c56fd377fb940776e9e915dda2bbbe94d66b49331cb672498dbe4fd248c8767ab77312717b3c2b546a5d27fe9e9ead759cd6d7fd6dd4db4ecdd3d3a24c836fd77b70d0caa1d0aa15863ae961c5f2c4dee14f452cd99e9ef4bfec97d03f4b6f2d37cb3dbae77aeabb408d0ee9be4c27559978cb15ba04851bbaa1a9edcf1959ce983b29c75ae88ef51cd2c6d598abd3f5bbb1e1da4d49c421bc8d25e4922e947b775eed47b3fbc29864c109116e1007b6b692bfce58d33f6d309d4a4cb24371111f4f0c694a9d284f7e5993820264a126f34af29091dac013f8e0ea4a4a6090b9ba2409e18c50e74cbdb863648bc4097e5c60f6d5751fc707c080bdc9502458da54e05238e9f000613d07b46247d7185366d1861460c0d6878f0c0f285d414764514344929099052c0e5e3c09c3486ec587d7467c96e08072241cb0c4d93336e853cb6ab407ba9fc30870bb9351be103951691fab0f6b14a908b6dbfba970c281be4a8ad30409c106b0919f4de6b07f9eb423e187086ac525959a7cf338a1cc7cd9e0487b822c56a99004ad69d83170c8965110a316d3d99904d7fb3093292818485645aa5387f350fc30d0820b276142a3dbaf0e2750dc5bfa74a40d047c4626245243fa65eff00e3bb0e00e436db85cb40ab7169ceb7a8d61e456a57b480a31b26fe4e5754cdb36f96caeecbe9e4b5d7a4101656f3aff85aa4d3bb3c5d7b19b4d39217fd3514d017b2bc9ed89155d4a8fa4fb4d0e337eba7e0debed596b9306b65bb59e8e7df457a4b6924a88788a81c08e1e38cff00c4b7736ff32af44125bc82d852e58269e3e6534f81c43e2b26695e6ab65417f65228e5c83cd4cfb3e38cb3069b907e52bf9945436550750fcf0a19640db9a9f2804776589436ca1111e62013de01a8fe1850c1323455c991581ed1dde22b8370cb15889ac678f153d8716d89c852aa5b40e1dffd988df808928c3269145aa93c47e78a4c51d8852404295343c58f8f0c10c1f706e58a9d40e95f98d3fb30fe020c4f54a6ed7db5b6cbb1cad697fb9836c770523fe8a07149ae141e2caa6883f9c8ec0718736e6a2bab31e7abb2daba9e6ebbb8e92e9fdb3abf69b06fa3b3dbf69ea0836a8a796ad4332d8e8ab66ceccbff00ab1873aad386d4d124ff0091f21555af25d2c61a07f697b34fd47d7bbef5a6f2e67b9da6da18ad9c81a79f72a622787e9890aa81c31e1fe1a9f7391dadd0eefc270efbbbbd50dfdc1fa9477aeab93a6b6e747da3a7a458d7436a171b8c8b490b7152211e5f06d5df8f6bd8e7cc2e872fe6bdcfb9c9b13fa57f3367fb59daee0b6ffd43382c81a0b486439d64019de87c2a3e38c7d0aeee4b5fc41dff0080e3fa6d6fd0d8fa0219ba6fd66eb0e9cd3a2cf71886e56c807948322b0200eee6918e0f438df0fbdcb4e965b8e8f468f8bd8e4a74793add07126bde4f663e9343da785279ff00d49f583a83a8ba913a2fd3282eaf618d8c733d8d44b772528daa5234c36e878bd416e350b8c2f67a23e67ddfc85f9adf6f874fdbf81b7fa6d637f796aa9737316ea6171f5dbcc1231dbd5c7cd6563e6adc3a1149263fb60e42a720e969d0eaf43f17c6b365b9f7e87476d9f6c9d967822304e82a2684e971ef1c478114c6ad1eaaf52957f4a8f831db1f512cdd41b97476e54ffb8f6b821b990e8648ee6d2e2bcab88867c0828e07cae3b88c634e5fab63d47c7ca9d9d1ea8cf6a07ca010bddc4571d0d9bad4c275c75558f4774b5fef1753c693ac4f1584524a23fa8bb756e54095fd4c4643bb1d1ea7aef9eea95ea737b5ec2e2a3b368f9afea05d5eedb226cdb6abdc5edfea8ec6dd5473a8a06a2c14b2e59f9ab4e38f6ff25ffd7efebdeb5a3dcedfedff0077ea78fea7e66bcd472a23af43a97da07a09d01d65ba752c7ea56c116f5c8dbedd205bb12a88e596625de3d2c843695a035e18f179b8b9385c5aad7ca3d3e0af1dd7d2d58f7674d6cbd3dd25b0edfd2bd3d64963b16d5025ad8db40582c51475a0f3549e24924d49cce30dd3a9d8b0a0ca5b4f6d129a891941e04d14e7de3bf0a42d90b15ecd251232f00190535d2c3b891db813ea1b4d7b73eab92f6fd7a6b69acb23b68babf85ceb011a92c76ec09d2cbc2498a9488f946a968a31bd9b78c9cb7e49715365d8eded76fb08b6cdba1b5b2b388b1090a1550cc6ac4b1ab331399672598e6c6b8d689a46b5a6d50c7a78ae1806178aea3b2b5c5855f5120e22ce5933fd34008c2d0d3e0e2ff77d147b8fdbf750a283ccb3b8dbaf2a45328ef62523e0f8d7d6b7d6737b54fa64df3d20de2d777f4afa43726919ccfb3590735ed8e1546fc5711c8d2b346f54da4cdc6b6206a52d9f1cea31081b6c92358b1c99d5c8a61a164918e253ae3615ad7b38e1c40b3d42c7336404b4a7015edf6604164329713d343ce694c89f0ecc216248f39d6a4c85c7b6996060b045af02d6411ea24e60fe7849c0f6974deae2101a18c2d32cc7e78adc1b175188f77bf323316552d4ad16952386250a14046de2f64ce47258f781f90c522555165ddae54d54a8f60c098d2413fabddfcc3491ece182701b522e77bbaad2a1694a0a71c04ba078afefe453a4923b82f7e1c77190326e058692e2a7ba83fb30d760c137b7b9923d73ca5a35f9d08a903be95cf0f1d4524d36fb270179fa6439ad41008c12390725bc1135199992b4d40547c6a29878fd4440c7164173078d6b9fb08c3581b6c8aa15f22b0f018322d499d6a40d6481d9c30b4009117242f30e9eda70af1c3106d2dff3c70c392f73390c234a86b7f9b8103227da3bb1d09239206961be8603736e149046b8d98814ed299541f0e18a8c7912cea0adb7c7323c6d0de865f9b3063f8ea3f9621373a0b6ca32515f6dd7f29b09ad995cad6a7234ef53e1e18b5cb0e199fda7a9a7f574dbb6c4fcab7492eeda4f9658c5582f7106998eda634e49894147dcc0d8cdb602d27d2cb6f7130fdc70ee8ded3a5876e395d146564daad939372badb575d96f32824d424af1353c3ccb5f8e32fb557d4d69c8d6a12dfd4dea0b19512e25b3b98d08241828581ec2437e43193a3e8e4aded82df3d4bdeeeee21bcb3b84daad2dcd6648228f952d4ffee99c3f97d8462df126b512e6687f6bf5736bb98dd2f36f92fe44a2fd459a945af6d491a0ff00ba7192e3b7ca0ff32161332d0fa9de9e4f224774f736
UPDATETEXT [dbo].[Picture].[PictureContent] @pv NULL NULL 0x52b0348a48f51a8e3420e0d9dccb8ff29c767b747e47edba8fa6af3ffe0de160720594ae5d95e3886bb1df5e65dcc8c37b6f23010ccb281c14370af86135dcb575a8ca4b0801648d88247981f1c039ec509ace5370b6ceacd1b69750cac54d01a350e46841a1c299d0377706f1a2b6919e55a8197e18ac86a7cfff005f6ee093adf7ab0b10c7e9f73dc0642835cd3b4800f61a938f9bfcb7b7bb93edad166c7c37bed3e6b1dbbedd045d05e8df5475c5d0d11a219626ad0bc96f012a07ff00ec940f6e1fe0dc539393a4ff0023d6fc759f17af7e438d6d1b24979d39d41d4fb83c85362fa489980244bb86e12eb70ee78948918b7895c5a6dd2d67d3fa9e0ae176e3777d3f99ea7fb6ddae387d25db6eda4027bf9eeaf25ae556690a0a7b1500c7a5f8daafb49f567d77e26aabc0bc997ddb6c6b0f57367df6561159dc6c57f6f3dc310aaad6d247282cc682815fb7197370ff00fd54bf868d2d555f615de9b4d7b78ebdd8bacb6cddae9b736dafd2edb4fd36e5be80637dd2739b5ad81a162829476505989d2b954e3bfee757a239b9fd9af2d5b98e35d7fe5f060ba17a76ebd4980cdb76ddff006a7a280911edd08d17fbee9346fac941d62dce7501bcdc33e38c2b5b72f8a7f323d3e0fb8a52dbc7dbadbe4edd6896f616b0edf6b1450595bc6b0db408a1638e341458d14640002831d894687b4ab0b0135e92344619f3e3901f8626da601b39a751c77a9ebd74c5c6d73ac7b85e6c17f0dd96f34696f049cc0cf1d41359180535198c7172e39e8fac33cce5adbfc9aed6b28ca758afa92fb74fb5dad9daeef65380d771d848f6b76d6caebcd8d0bb10ad22d52a0eaa134c757371ef5b649e77ec44426bc619e58f5b7d548ac3ab673b826ebb2f4cc11c4ebd3d20d022b90163ccad58aa79e9c2b5cce3defc27b7c7eb4d9a7b9688f0b93d6fbd66ab84f54fa1c77a4378d9fa977fbfdfeecbbf505ec4efb55984d462b28abff4f167433301ad876f05273c7d3fe27f294f639ed7bcfdce9f1e0e6fc87a17e1e2ad2bfdbfd7c9ea9fb41e9abcde66de3ac64bdb9b6e9e49d21b78ed67a5bdfc99b1e6171cd5110a6a8c506b3424814c7cff00ff0063e75cbccb2e1749c7ede0f77f0beb3af1cbc7c6bfa9dcfd49ea19bd3cb0b0ea68226b8e9f17a96bbde925cdbc573e58ee0d4e4ab25158f66a18f09a4767b9cd7e15beaa575465b61ea8da7a9ec5ee76b9448b6f2182e230'
+N'7cf0caa2a51c77d0d7c4604d1d7ea7b35e7a6ea9adf57f5aef5b8ef8fe9d7a7cad77d4fa436eb768eeb6db744c015371320631b35780f3f62f98d5792d76deda98f372bb3d94d7a9b374b749274ad80b6b52f2df4aaa2f2f9d15249ca574a80a28b1ad48441928ef3563b52b06fc5c55a2833715ace642c5da26e3da3d95ecc524cd9b1b104b42cf2206edf1f6118a224bdbcb603f6ee2a6bc18643df8ac683cc60d0fee26c2ceff00d09ebab748cb3aecd3cc84d0906064981aff00b98d3857d49a30e653572617ed782dff00a01d1b23872f15b4f06a03f92ea6033af75317ecafad87037b11d5459e91a02b84a65aaa3fb71cd1d4d9b9211c32239d750470caa30da29b9d03b469291ffb73771f90fc309e84271a151c6d4a98c549f3508ecf6e0626197995f2a1af1a64709a14a61a39812448855c761c5483ec3093da151cd888c89aae04c52c9fd4edf1f90a162dda40c0d8a19535c5aaa82b102a7bf8fbb0c6ea412e63d3e5880047135c3961324a331492564a2d72a8cebdd91c29135d50710c1507cb229e23253fd9802033bf20650d57b180073f68c54b2564a5bfb8d411291d72ad2a3021c1796fae0caa81806fd601d2ade385d4122bea00aa96646a1a9a06ce986f5082092c65826a214660e5418018c4625150aeba38d3bf14b400abf4628b2e4e3b6a461605d0347f404655d473f36786984b82eff45aa8b2020711c29ecc3590804ed6a8451687b09ff61c00e48f3ad7c3bfdf89c8a19c2f6edf1ee5da458e69618fe678d54a53dd9e34af2b6609a791e6dc679982886644c8a8a101aa32cf1bbb48e201c9bb5c58c6ba6c2e897049091ea19659fbf0256ed927a17d87a912f592e2eadaeed258bfc873154329f981f0cb139b6a98a216a35d5d77b7eed3dac37172f05b683c91cba3b4bfa829f9892bd831a3e4889ea675ae7273dbde8fb3dcb9d345737b259c07cdce49d9013d9aa365615f6e39efc69e219d1495d8c5ee5e95746dd22ddc2b731cc8a4b235dce9193e0b217614f69c0b828d4b43776605a3db3a5ecd9e19a10af54525cca410736a13c3dd9e21dab4ca1c5998597acba5609124bde6ee13c454abcc068a8ceab1fc8a6bda057c718be44de3227c703517a99b2ee2e6d52ce511914f29a53e0786345c966f40840afa1b1dcd4b03344d180e9a9ab4af023b41cb14d2886b273df8abc8bea5281edfbaeedd2289b86d370bb8ecd28ffaddbe80cc8333ae062787863174ff008ea713fb9ebb95f553f8a365db7ae6ef7d9276d9e0fa7b48088c5f5c543492150c7971f1216b4249e3c0612bd9b6a307571f3ae5534fde65ad7a8baa6ced4abf50f26e5d80128b78de95a67a64aae7e2319f32719706dc7f72b976fe043a5fab370e91ebdbf5b9b81badc753590bf66548ed8c97161a607d31afedeb3132d48035051dd8e654fb7cab332bf905792f5bb5ace4db25f5ff00a16d36bdd2ee7678378da6d64ba936d98982e49452446636a1a3350540a634e5e65c69bb7444dbf2d452ac9d6c9753c6d70c773e8eea8f54377b90dbd5fee51ed9676e00ac93ee2cf35e4e09a9a054e58a7631c7cc528dd2fcb6feeb1f3955ba96e46f2d9d67d56dee6e85f44fa2ba06502196e2d06e5bcc600e631e6732188f6e6ed535fe518eb9fb3ebd29df2cedf7adf6f869c4be58f757748df7467da9ed7b1de858b7ddef73b4bedcc9075ebbb769c8635e29122a9f663aefc71eab9d59bfb5ebbe2f5157abfea776e8cb6db3a23d37d9e0bf9d2d36cdb36c8a4bab893caa9a939aec6bfde73e271dfeb51538d2e907b7c0971f0a9d123cc5ea77aa5ba7aa5b8cb3ee5713d87a6563712c5651dbc74babd61a6b0c619b39a44a1724f2e15e39d0361c9cdb9f83e73daf6befdb75b145fc4dafd2cf4df78f592eb6fdf7ab618f6bf4bf611c8d8f618d9e380c5524c36e49d6cbab396663addab9f75528ece6dfa1bfa9e9dbd96af7c71ad11dfefba9edb6dea8b1e83d96c0df5efd09bbb910bac36f636719e5c5aea332c46945518ab7b71cd5e2aa99d5f448f6797d974b6ca565c497e8beb6e9eeb49ef6c2c58c3bbededff5160d9c9a2ba7983bd75647b8f1c75eecc327d1f7ebec27886b546d236b321e0aa1789670bf1ad30f43bdda164e4fe974577d73d67d53eac184ff004294aec3d34cf9d6d2cdc99e55ec024973fc3b31e5fa56b73725b97fdbfdb5feaff79e67a6df2f25b95e9a54e9f1dacd0b9d0a8996552003ef38f51a93d4dc7817ef0ba8f69f51fd7ab4e8bda63e7d974adba5bf53cb10ca6bb49798f0065ccf295c2311faabfcb89f62ce95dc94b3c2fc8f25697deb5d0e996ff691e8e6e3d569b9f4df5936db6ea125b2b06b9b39eea27945797113229a22b53ce8c751f0c76fabeedf89ee5a9d57f5b8f994378f93d0dd3db7f42fa65d376bd33b452cf6b81659133d45dd8979e69243916772598f0f60c617e477b3b3c9b737b3c5eb572e141ad752df6ed79b24ab332cfd39d4ef259d92dd46f28996e91922b58e28232c3505243b90093954d319f2595728e0af27b3ec7d58ad1ad1f5398fa597bbd6f73ef5d19b540366bd9cac125c4b24af15a5f6deba0959bca5a69635a20af9685c82ab43e5fa7efbf63755adaeae19cbf877c937ac4293a2f4b747595becb1ecdb0c3756dbad94af27516cd7c645b8dc56e1d945dadf2157e6e927f751b49714205063d0ad1250b1fd4fa1a52b450b43a574e748c5b0f356db77de37067ad46e172d3533f2d1480a0814151f37139e36ad52d0d12f06752db76443a632d4ec22a3db9e1649fa64b182f4b0578d413dc303c84245d2dc484860a928c98ad78f65546009835ef54f6c7baf4afac6d010cb2ec3b9a8ccf1fa590d298be36ead419f2394687f6817e27fb7be9a7405f9725ec64f1008b973ff00dd8dbd99df247066a8ecff0053132867aa91910a34fc318366bb5068ee1750196923cacd9fe596094c9dacb3b48a688941fca0647c4609e809483529c7411e3fecc265412e6102a071f0a1a0c8530264b4143bc9e5705803e5396a1efe3872292e230ec1d0b21a79812699e0991e84b90adf3e93dc6b96042653c04e946cb41a29d550300e705c6b5f2b15d3d87c0e11288eb68d735197ca4104fb70c68224a547985477530e06f25ccc7592011abfbc7f2c314124945417002f6e148a06659add9119b5007e5cb31efc53720b3a164b940682acd5a7fe781486d1c5b881bc9247e622ba853f86025d48bbc446a83c847114e3870cac9523195006f2bf6100d707ea10043ba48aada949e1534e1dd5c102c308524399ad2bf29a629204bb112a18d7565d8313236c9688ff0097b7b8fc38e0de1b8f057a7deac4fb7dec70dd4a5a063e6058807db8e5af2f6d4f2b83921c33d01b0ee3737b7624db2fcc7617b0c72450e6c227841e667fa55d48ff007878e3aeb64da7fa7fd4ebae27b1b85aef16a841b821e75429aa8cdf03518e94f693b67411d923de63d89adaf6ee39e4825650f6ea605e593545a3bb9240201cf135d5e757253aa503d67fd3ade6840485af031792760d3c8a064aaa4fca4f8613b403ac83de2c2ce276bf837492d0cea5668195823d7b749cab8a7653b9a86154f4356b8e981b944ef697565712464f2e39a631161c6a281bf1c0f92b6ea56d6b5345bde967bbb66d9f7fe9ddb6e2d519b977319786f1351ae5711b156f0aaf0c616e2b39d1afdba9b56eaa625bd2ae9c560d6d14e251c11deb4eee0b9fc310b863a156bc98bea0e82dfacedccd61b7c0f6aa46a962768e651de2b91f6637a52c61748d5aeec67da069df2e8ab28221767a37785cbc7137aaaeaccd39d0c36f5d4fb3edb65288e3e4bdc23c70b665f98ea46a52a5876d72c79feefb94e2afd5d4e7f739ebc75ceacc5edbd4dbb6cb1599dbd2ea48160413dcb2d62959466ec03330f6d2b8cb8ad6daa137e7fd4f1b8df2f1356a55ed328feb2d8bb0dbf7fb792c0b2d12ed0f361756e0d514c73fb7f90554e974f2b0ceb7f95a5ead350cc9ef1bd9927e9eea84bd412ecf7f1acc81c332c57804326a1c40cc1f6632a7b74e6e2a5d3faaad4ff266eb99722a5d31af52edac7af2ff0060e90b610ff54b899ee6fefe30bcdb6dbe11a64d2ed98e6330503b4e3bbdce3fb91c7aa6f3f08d3dee25cad517cbf8357dda0da777ebdd9fa11fe9ec361da6f61b854082b7a6d1028d542006a9150467f8639fdae1a5aea9a41e47d9ad39555bfa5310f54b7a8faa7d4d113dcacdb75914f3852e94885235551c416d47c71e3fb7c9f7799d568b088f67977f34a3a1ef3d6fb8f5cdf74a7467546e23726b5dc9af7799c044882aa9d30174c8b2a3156a64a4e91c31d6eced45c76b4b9cf65e0ede6f6ad674a723eb9ec6edeb1fa83d29d716126cd2acfb4f42ec07ea37fb8b3904cfb85ea0ff00a6da6d755155aa41773a847507492b8f4f96ca1e30baff0043b3dee75c9586fe85af9f073ff4db63e8feaedd61ea3f55774b3d8ba6ed2175d8fa65642a5ad918bf2e2006be42b575b9f3ccd524e30e1756e2cd29d11e7fad5a725b7f2b8af4a9eb0e9adefa5378d9acef3a52eed27d9248c2d99b645589523aa054514a014a5298eea4594a67d570f252f59a680765e9fb14deb7cea0858c9ba6e771144f285a9586ce248e3854f600fadbdad88a716db3b756571f1aad9d96acf3dfa8f7777e8afaf36bd490a341b46e0b1dddd545164b6b96e55ea76fcacbac771c3f63fe47ccf3bff17dbdcbfb6c757f58fd485e8fe9db6b1d8e13b9f5475286b5d82de227f704ca17ea0100d40e60d207ccc7db8f37f23ef2e2aaad54dada23d9fc87b9f6e8ab5536b683fd291ef7e9af4ded7b7eec36eb4e9cb1820b568a067d114b20018bc9201a8995b36e0c4f8e3d1f578571f1aae90733b72fab54ed1b3ac6a8d2fee1bee67a6bd26e9eb9db76bba4bbf50afa175dbac2df4bbd997040ba9c3060a108aaa91566a654c75d38babd0edbfbb4759a39947987a9fd143d15e9cf4bf54758bc92f54754497fb8eed6cf332bc5a9627861974beb9250599a576ccc8e572d38f2bf2ff9174a274719e8789f93bbe3ad5d5e59bf7a83d09f6c7b574fc369d2fd1df5dd593dadb5d49358dedddb436a654460d34e24745d4c4a85d25d9aa16a787b1eb5e68b92d10f43b79bdde1a5310677a4b72bdb85daedbaa5ceed7970561fe8ea1a47b96ccc5669003511a0fd35f16e188b7223e5afcb6e5e694b73ec36dd7dd59bd7d77a25d0bd3d7fb841b7178b768ede5138b1412f3792f7ac68a626011554860469d5515c713bee6eb552bf81eff15fdbe7fa145575606efa1a5f4ddac370bcea29362e87dd2113437f696ad131bd85837d2cc933cccb288b5956653e71a7b71cceab8af0ab09f6efe4c9fe397af6ff00c9c8d55f6ee6cdd21d49d4bd5d70ebe9aec5bb6f1b6a13147d4fd4b766386a0e6521b68e215a8cd75b1ef031daad67fdab02a71be5ff00daad9aff00936ceafb1ec5eb56d69cfb89f6ede538bd9319ad99548a911ccc25cebc3565ecc6895bf53d3f5383d8e37f55935d99b4ed7b91dcaf26daa799ecb798103dcedb70d49915b830a1a3a1ec65257028d1ea7a35e6ab71d4c93eda53f705c167ec099114f7e2b6a35dc0a6ad07359de6ec72c6a30e0625b8d94bbbedb79b4124dbee16f35a483fbb3c6d137b726c4299c93b264e37f6691df6d7e87d9ed974a524b4ddf7281908e0d148b1b8ff00894e3abda7f5474830f5ebf49ddfeb431e5e9a91fc7c71cf06e0f5c0a4aa2ff0f8530da8080a2728ab4078f6e265a26d5965c5cc8ae0e835efff0068c1f22d9e490b9d648d3a4d6ba787e7824a82493d6a5c32b71ffc530db2219313b00195eab4c94ff6e0dc86d772ed705428743435f30cc60d58a091968ba906acfe18adc1062b7cdd77eb6489f62dbe0be3e733c734c61620528b1f948a9cf8e38fd9e4e6ab9e349a31e6775fda8e1d75f717d49d23d67b96d1d5db037f4f98c7736b109f952da253972a02c94914b2ea15f949e2470e27f90bd215ab967053dfba4ddd686ffb17dc27a59be431326eed67732a6bfa3b9826e657f94322b2135c851b3c77d7d9abd3536e3fc9715bae7b1d1c897489140653420839e7e18ea7a9db05c32d0eb5a0ef35edc125359292768d472a403bc54107dc7f86282218cb0625644a11da07104606f22d42472b9a16e1d841cb03427827abb0120f7e29f80c9612c8ac033529810b5d493333f9c9aa8edafe18163012194a328f2b771a507e58aea2c92d4a328d694a5380c128705566fe75ff008871c1819f286d2596294052450f11e18f9dbf3bad8f1ef53bd7a35ea426d04aee328620280ae35643b063ae9ec2593b78afbab0cebdbc7ad1d38b6fff004cbe72384744a1f61e38eeff00e413c06e484fa53d46d9b7bbc36d7297122bb51a053c6a3b71b57977650ebc89e0e91b39d821dcbe82100f39bf6626ce419558367953c31bbe449170d998b9d820be62d3bc88382a57988477814c8e295a449c18e9b62dbac5584f6f35c21e12574e7d80018b759d148f7335cbdb46b7968bb75d88c8d4b21a1523c7b47bc6165688786b2c4af229e54a5a5b3c448d32f9fcea7bd4f1189cbf0c6aa91ae4fd3bbdddabc571bade185f82c8ca081dd514c62f8df768d7755a347eaad8fa3763b16bbdfefcdd4cadcb8a38145c4d2484d16255274d49efe18e0f73dae3f5abbace7c75673f3f3d78eb95ff007391a9da26eb6b2b6ddb6e43650c4279a3512036ec6ac0145081d851412469eec789c9cd7e6f628af558531dbfd4f13969c9cfec2aff006b48cfee375b7da0e56c3a91c9ab5a3874d5ac9a72d8d454d3215c7b9fe46cd110f9f97d6b6ce45b9773589b6abcbd492f6ced5ae36f91b44ca233218e4a6a205078f997df84f8ebcd9da9c742afc0adff00978d26bb189ea9d9e3fa21be5bb496db9c30aa99606d3528720e99ab0f020e3e7ab4a71db9291959a9c545c6f7258ea84475eeebb2f524dbcecd6ebb9594d3db5bbdccc0413c96b08f322221d09a98b35476d31b71fe5ebbf0f25d3dde4ab6e65869166eb7eafb9df6d00b158657be8edcc8ccd15b42c65ab4c066c5a8053b4f70c4ded7e7bbbac3598f0445f966d12c0ed5ba59ed115ef585d25c5cee57377c8430be836e8f1b0d5a995812c95198ed3db8dbd0a6da3bc4dbf913ead971cb6b26c7d3d756fd51b7ada5acdfd3f748ed2286c2dc20e5f25647792495f4d0554280479aab8d294add44c597ed93a5ece65d988759eedf4720e90dbef05dec765389a36553569dd28c01fd5424d3fbc4e39fddf63655aab9aff53879ef8fb7573546f9e9df4e6d5d2f6b3ef5d55cbb9eaadc2dcc11db48c1fe8ad9d748420d7f7187cdfcabe5efc767e2bd1fb1557e4cddff000f07a7eb71f17152792cb73fde8d93d02bdb81d3f7db1eb68dec2fe658416d242bd1ca8e1da71dfeaeb65e4d7f1feef1f1f1edb388675cb5ddb7ddb691879a10dfb81492352b1a6bf104f6e3a5ac9ecf1f32b29ab939bfdc45c4bd45d256db85f10d75b75c8557615220b8fdb9454e74ae93eec63cc96c68f37f31c6edc72fa0a7a2dd5dd3f1da5a75c75e6ef12eedd376ebb1ed62e43086c6dade325a4401aa649031ab5321c31e5fa7e92bdbee65d961780fc57256cbee5f2d63e0d8badbd649bd42e8fdda1d9a18f68f4c4da48378eb0dc60e63dd4268395b458ca144aecde512cb48d7e65a918f66d5fb4b75f2ff00e28f4fd8f613a371f4ff0033ce9f6f3d3dd27bd7a831fa8dea14aedb06c0eb736514e8d2cdb8cead2490cf76ee087452078310a00080566dec2b56273d4f0787dce2e3b45f405d63bcda6f178eb05dcb3ec569733c5b4dac84ebe4cb31914533d3a988d58f03f17f88ada5dfff006eadc793cda555dbb3fec42abd43bfb6df75b66dd37d36d90113dfdea462379e6cd621186cc5012a95cd52be38f53daf6a14bfed5dba1cfc97dd93b7f49ed5d53d39d4d6be9c7a530416bd76969653f55f585ca0bc9ece2bb812e2631992ab122acab1a2a9d72bea27203115e56dc53f567d27adea6d8a71ebfeeb1d9b7eeaee8afb6ce8444b789125b99247b6b289105c6e9b832d66b89bb06a22b239f2a0c8760c573fb55e14975e9fb7f33d4f639b8fd5a67fee72ee94e83ebafb86df60f523d5c91ed3a382b36cdb1db96855a1725bf614669131cda56fdd97fc38c78b86dc8f7f21e6f07a57f6defe6c57a23befa7975beecfd1d67d313ca8cfb134db6aba46a8af1db48c227d0a0282d1146341c4e3abd5dea91696d1ebfabc5b690fa33644bdde4d499980a76d69f81c74c9d10a60c3f50ecb73bc469b842889d4567e6b0be53a5f2219a0663ffb727023b38f6633bd64cf938d3cad46ec16e65823b82f2445ab4120a1e3421a99541041a658aace8cb4f1932289707cad2445380d46a41f1edc54e350fd03410b2ca8ce23f2b02744bdc7b0612623887da0ef47a8fd2adc6e645ac8bd4dbcb9ceb417330b903ffdcc74fb38b2f832e06da3b872a2fe5a11953c318b668940516a29ad34b7691500e16a4c9636ec45640ca40f765ecc21a23a52a00914a9a644d0fbb0e1022e2d5d75105b97e3d87c30b68a7b9011660ae79e743fc0e140f7130aa7341a4f71ccfbb0d30d184aad056953d845315813c9231c6da7501c6b5191cb092146753942748fae9bf6ff00bcaf51f53c7b374e9b895b65936748a426dc96e52cab2c6ae1c2d3554d38d0e31fb0dacd99c2fd7e4b373785e0e67eb37a7db8ecbb5c97fd67bddd5e6df1e9fa5ea4790aa40c5808a19c4e4c6bcc7cb4a3660f6638b9fd7c4bc9e47bbc1cbc76dcdee473bf4abd41e87b6eb58c74fd8c7baf502451cdb74131690c772149716b042c448541399af0d40655c791cffe5faef770ade9f8ca39bd5bdeb79db2ceff00b97dc06f1b3b092f3a6d7e994287479a58a604f13468a99fb29e38e9e2fcdf23fefa3abeccf4aff95bd5fd553acf4cef7b5f566c165d47b2c8c6c2f63d6a9fa9581a3a38ec646041c7bdc5c8af5565d4f5f8b917255596864c840de53ab3f03d9ecc6c6b9261582d0ad6992d388f7e062550d1aeb19135e22a33f1e18a481492e5332d28d50699f01e02b82322ea59e065199d27e3edc5601b2515b3819034388891a48bb5a5c0341a857b8d30e416742e216a51aa4f0a934fcb048e09f24778e14c1b8507cabb9110ba7111d4751a1cc63e47da9de78adbea6476b17151c82dabb74d6b8c6eef1845d660d82c60824947f53b8922a7cb5590d4fb81c4f12b4fd435a7d46e3d170da26ea0d84f3cae1850441d49ff00d38fa7e155da8cb8a7760f40f4f4d6af72a97504a9bd0a7d14858190c94eee3f1c76f1d9ff00b960f654ed366d9ef7ad22dc664dc76e79867aa412420e9f005c65856dcaca3406aad7907b89eb47be22dc4a9b42461a3234eb9257a92ad42c42c632ab52adc3219ece5f8473ad72606e64ea6b78e696286eeeafc574c0ece952780d4f450078639fd9e4b52adf1d775bb4c7f32ef7b554d54bfd0e577abea149d7db4ee1ba3dec50c72851b65ba9fa39617f2ceccf117459117cc39b26a3c063e7b82feedf955b9d6ded559fe2a4f36afd9774eca3c1d12e1ac5283973c91d322cc14fbea31f533e327ae8d05c6c9375da5cef660b7644783a6ed07995e8aad73732320282535d28ac430404d33c7917557ec27cbffe8bf9bf93994fde4efaff00b7f6ee60f601b00f54fac26dc1a133ac36a96501c8b4015753a12348a9d3956b8c7d755ff36f3ac28393d49ff2391ffb81f58bb4ccedb5c7676f484556521dd9398349c8e91e6e19f7e3d6e6d71d8e8f6ab4daf7b34cdbe2eacfa8bb5d8e79ff00a9a28323daaf91ff00bb2823487d3983f3538e3cd9b2e4fa32cf07d7ada9c93c0f757b7fde0d7778feadfd3f74fea14fea3473fb9a685b4e61f4e5c71c1f90cf2256c3831f6f6fddc6bd7b1a25a2eda36dba7dcd89be92074b48d75848cd3fccf2020f7000f1e38e5f52bc1b5cbfaa3ce05c4b8e1ee7927d2cb7436edc
UPDATETEXT [dbo].[Picture].[PictureContent] @pv NULL NULL 0x05a3964993fea48ad208f5156d596634d5869af771c75a4b63dbac64a878dafa64637886c22e9cde27dbae39df4f7d12d95bb248ab756a7ca5c9c95299328620e2ff0014b8d2e48789c1a71ae3dae5f5fde2bb9a4f2f4ec5fd11e7848962fa9e4f319dacf94336d009a6af9b18dd5555cc3b18b545471afea663a5a1d9df71824ddae163916455b488890ea989c99caa9a007b2b5ae31e354774ecfe3b4997aca8edf560ec5d3d36f106e11aec5045757f565858b47183fccdfb8757c4571f45c7e7f43dbf5df0a7f4253fb7723d2c97326edbfbdb491444df2b5c4712eba4fa06b546c852bdc31a535b0fd759b4351265ba82f7ac6d52d9b61b19ef379d63e9522e58929db5696e22013bea0ae075a3eb03b27b96c6a7c7fd3fa9a5758df7addbbed7b936fbb6ed9b16d6911faa5b9996e2478ea335e5995295a65e5f6e3a3e84bbb3a7d84f63fb86a1d2706d0b3a2f53dc46fbf3de58c9b53de2b2ede8f1ca0dc453aa8315245c81949a65c3192b725aba25a7f69c1ea72dd4fd2a3a651b4fafb7bd7fbba86dff006e8762f4bb6cb8839097529986ed3b8a29ba36467e4dba01e40fa41ae7dc23dbacd1c387fa97f90bf26d51514df2e2e6eec94ec969058ed4bb3c7fd416de48e5778b5d5bcd5c8eaa05d4ba80cc0390c73705789d1434abd7f6d7f79e1d94d96f708d0acffee2fae88f4c851732464c2a854bc4b5a1039aaa0b903b351a57b75007e42fcbb12e1afd1dd46a74fb0fe951fd874085bd6182d60164b25c5a6956ba6dc3e9161d64d1500ba2ab500135f1c79bc56f67ece53ddd67feb83cdfa4eb5e97cfeb16e76dbd0e9cb5dab67bd8ae697ef049692c92de3468226bb8db9b20458e8540902b2fc94c747a8b91d3ea697ff89f49f8eff2551ecc9a56f0fb8cfeb5da6e1f71090417b0436dfd3f6c3e4b4b98c4852dc9781ae22488c80bc80c94d468f96382b2fd9ffcb88fed9ebfd0c79afcabd84f9ab9edd3fd3f7b3d856b2492a2c90c5242282913f2f8532a189dd69dd438f7d3ee7d5d2d3aa823686eb9d79ca02865f369a64dcb5ad7c7861d64d30313df6ef0dc4300dbe6b881d496b947815232320adaa557a9e228a4616e7311fafed939f96eeba55bf88feac945717d2421e4b5314858fedb321208f15638bc9a51ca96a1fedd8d637abeeb3daac7a86f3a3f6d3bdee0f24676fb09658e0892f0a049eb24cd18310015ce939b965ad6b4e1e6bf2553fb6b73fd3fa9cfcf6bd53d8a5f4350f4b25fb82bddee41ea6c316dfb722ebaaf26432392408a2103c88aa3892dd9c2a71bf1ee8c9e3fab4f66dcb3cb66978ebfba4dff00699face3877cb2ea0b68269ed6694ecbb8c06141796b2465e21246ae744b1b791ea02b64cbdb48e2df2d5f49c33dee17686adfa1c2fec41aff00ff00ea7dd8686d1fd6dcb303facdbc3a865dd963bfdc595f04faff00d87a6435e84ae9'
+N'af7ab7776660e31c9aa826924f46ac6347782bc7de7096a180cad714c92a69fa0d0d3f118a7243827291a41940af6ac94ad3dab5c3524f500bc9663c8122376d092bf88c4e24565dcad52023cb514ec39e347232897f2d41a7e8f65712fc063a9797569f3d34f8d2b8684bc164e684062a15ee3ddefc263468feaaef9ead6d9b1a5b7a53d389bc751dd332bde5c5c5b436d67181f3949e788c8e49f28a681c4ff2e397d8b73351c6bf5393dbbf225ff8eb2cf395f5e7ad96bb0ee11fdd358595efa2d2cf6ffd4dfa81e148a3ba0edf482dcd8c8b38264399547007e9c737a1f795feacaffd51fd60e1e17cd1ff00957d2603d2d9bd3cdf3aa3a8ad7d34b7e9be9adeae3749dfa1af2f8db5edcdbbc496f48b6711b19caca09abb23e92a7426a2c07a1cd5e5747b5c7c43fd97c1bb872a909f46756e8fdd3d74dbad2e20f5af656dd7a1e7478ee6e6f66b08afad973066b71249148e00cf495a9ca943963c9e0b72ec6b9963bfed93855f9955ae6535ef89ff0053b0fa396fd3967d136b074bddbee1b799e769ae846f1817048322e89429000a0140463d2f51d5512ae51dff008d545c4951ca37b8f431fe53d95ccfe18e8967a2c2a0b8d44c673eeecc302ee5f58d228fde3f1c34c9c12acd4f387af8d7f8e01a827ac15a3250d78d78fe3862f80c82e322a5865981dde34c272382445c52b534af0cf09b0224c9a4d465dfdb5c0ca500eaff00ca31433fffd9
')
EXEC(N'INSERT INTO [dbo].[Picture] ([PictureId], [PictureName], [PictureContent], [PictureDescription], [PictureLink], [PictureTypeId]) VALUES (''bbdfb6f7-6aea-46c7-9dbe-9c0b8d676265'', N''VinaPhone cung cấp iPhone 4_small'', 0xffd8ffe000104a46494600010200006400640000ffec00114475636b79000100040000003c0000ffee000e41646f62650064c000000001ffdb0084000604040405040605050609060506090b080606080b0c0a0a0b0a0a0c100c0c0c0c0c0c100c0e0f100f0e0c1313141413131c1b1b1b1c1f1f1f1f1f1f1f1f1f1f010707070d0c0d181010181a1511151a1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1fffc00011080064008203011100021101031101ffc400970000000701010000000000000000000000000204050607080103010002030101000000000000000000000000020103040506100001020403040606060a0203000000000102030011040521120631411307516122323314718191b15272a14262241516d182a223435363b3d308c1344435361100020202020105010101010000000000000111022103310412415171223213611405ffda000c03010002110311003f00cb8f3cf7197fbc5778ef3d30004e33dfcc57b4c000e33dfcc57b4c000e33dfcc57b4c00750ba85ad284a94a5288094826649c00800b19da6d13a4ad868eae9dcd43ad5dca1d61f538cd050123b685201438f3c9561daec6f8155b701307ae9bd17557d2ebcba45b4e3ae2574a965591843789525608991d06709bbb8b5e2ae4bf575ddf2f08b72d3caf729eda9a2a85d32da715c6536db412a2e04c920ac0dc36486f8e6dbb77b726b5d6aa3dea394d5de503f44a683a04f80b13044b64c88b35f62c2db422aabf6807e99ca861697a86a1466a696b2b42942642c1563f4c74b576dfae4c77d50cafee14571b7bdc1a9ce951c50a99caa1d2931d2a6c56528a1a12f15df8d5ed30f000e33df1abda608039c577e357b4c1000e2bbf1abda62001c57be357b4c1002ae2bbf1abc09ed3100333de339f31f7c72c70900020004007a53ba5aa869d139b6b4a84b03819c0058fcaeb2bfabf5427cdd3b259a59bf595a504bab09c0033564cca276e58cddadfe15c7268eb69f3b64d31a534cb06a4ab206d80723694890001e88e5d179396742f68582495f614b0fa0b0b25030f545ef59556e75c4adb001186f89551e48d6b1d3cd5dedca7d0d8f394e92a6cca6549de9fd11a35e0cfb54954df344d0dd2d6ba575296de13e039b54854a6652f462236ebbbab946368a42ef68acb4dc5eb7d62426a185495233041c4281e82318ea52ead59454d408e50e072500022001280815cbfb11048ccf78ce7cc7df1ca1c240008001000200344ffaf348d5369fabac201554389ccaea138e4775cdce974d454bc682eac3490112c71c3a6135975d0e0bbb296dc80c7774c69452cf15d4d4b82494e00f7a5160ad1c4d414a48730514c8a86ec250c9896457b7f643550a7129c13da4a93d9db8032f4c5b5667ba291e6d36e3b70a2ab520255c22ca941320a09512854f799191e894747a6f94537f7200446e814e4a1400440072200572fec4400caf78ce7cc7df1ca1c240008001000200344f299c4d2e8fb6ba8524b75885f1024e29719754833f4a651c9ee2fb1d1ea3c416ad92de54a0a75734af16f194fd314eb34dc91a134f4a919ca02653e98d48a19c72f76a4cce742100e2b51007b61d5456e0469d4ba5de7149158d2ccfb452a0443702c8cbab6d6cb96f72b290f11a23bc9e88b6bc94dd4a23953a4ec77db6937cb71afa6a701da165874b0f3b50b4c94de712927d7b61afbed4cd792356956fd7067bd676162cf7b5334a9751435084d451a1f20ba86d64a4b6b2009a9b5a5492658ca3add3ec7f5d6acf92aed68fe5b1d66461946968a012886802ca209164bfb10a031bde339f31f7c72870900020004000800b979755b75b369bb58bed3b96fb13d586a296e150852587185a0e608500731ce9c3a6718b7d15dc2e4d3a6de197c124be73df4f36df97a262ab320f633b65a025b0e26662bd7d36b92eb7717a11e4f3cc3ebe1d6b2f9a651332c1095a4120cc663f5489c6a5a0abfeaff053abf4a6bcbb3acd4d03c9afb2d536dd4d155170308c8f0cc3336b382b1c76c2a490cf24874072c35d2119ae17945134950086996997f3240de569eb89842a94f25d767b5aa9a8154958b156dad395c39020107ec8988840f233555b2b8b4d22c6e30c16dde170ea904a5494ef494f7558ed9425d379459ada5c941ffb00d38354db1c702438edbd2a7328902b0f38147d7b63adff0099f87f264ecfe8aba51d1339c856072508c9157f8214918def19cf98fbe396384800100020004004eea7505f6e1a0dba65d529cb4b2e2126954490cbcc4824a27390282308c95d6abb1bf736ecdbe7a563f24554a7eb1f1c45e659c013209036e00603d51acc279bad169c5367129800d7bcb5769dde56e9ca87db4ada346969c04674c90a537dac30eec66b2c9b6994890d1d1d05224aa810db4542632f727d58ca500f02555e6b3cd70953999cf1c364290d0a6916e2fee885005795599448c419edc6531136582babc99db9f3a818bb6b834f4e52a6ad6c26916512292f0254e488db22acbea8ed7435b5ae5fa9937b9b15b911b0a4e110ad0c14c56c915ff821424617bc673e63ef8e5960480010002000400681e496b2e5550e904d8af36f65faea8794e5cd354df183a66436a4857672a512c0631937bb2726bd355650b92c3b9722792da8da370b717ec6e3c3321544ee5682ba432e8581e81282bbc5b6928ce63f24b5568fcf5ed1fc66c1398ba53a4cdb1bbcc358a9bf9b14f5c68574ca2d468b8791b74af7b946dd152d410fa5750868a42545212e12000703b4ed8aacfecd1ab5fe13175cb52d92dcdb75346e2d9cd24bed1054ccce04a92314e3b4a7d910ea4ad9ee3adbea9bae0dbe9ed34a4711b560a2933914cc6dea88488b31af9862a0e88bc1656a65c4d32d60a661432c8e04744b7468d0beea7dca2cf0ccb4664cc99938ce3d0190e44112708856010ed8a98c2bff0004280c0f78ce7cc7df1cb2d0900020004003b51e92d535b6c72eb4767ada9b6353e256b54ee2d94cb6cd69494e1bfa223c9130cb9b925cd2d3da634a1b79b64eb43ae2eaea9094adc7164cd054259f2a502425b318c7bfcbcbfc3668aa752e6b0f31b4ceb3b765a9e1290ac0252a199b50d85276cc44f8e08969e074a717bb69c07e216d5786e36264a0fd55a31c7a771885281c33dedfa674c96d6f58d866d352e28b8eb0ca784d2dc3b4a9b124a547a4011312e48f2851e841af7cb4b23f77aa72eaed43ccd54dd6a854ae1b2de6ef65e1e52a2158f6898b380e45d61a2551b4d5127bac8294ec39d38813de308058137317ff0095ba52b00a9d5d1bc4a76ec4f6be8c62ed2e2ebe4aecb0cca928f426239280029108c90a4452c6154bfb108047def19cf98fbe3985a1200040059bc88e5ee9dd61a82b51a878eab750b01c0cd39292eb8b5e54a54a48528002670c62adbb1d782cd74935cd82db43a7ad14966b1bc84d15bdbe1b546f93992924ab15192a649c4ca31b6db934a4915ceb0e65689d35abe9ebd9b4d337735a174f72b8b2cb655909072f113967d676c351b7f035a89291aee3a6741eadac45df495c98b35f2a26e29899e0d404919b3368c4284fbc2517a525130492c972d57a45484dd925da4984baf266b6e5d39b742b432cf04b6eb76b7d7d3b570a0589a482e81f5927ac6f110c8f93c2e6f53d4d0a50e83c4a7ed32e6f293bbae1b9216061acafa5a54214e14a1d9607648741d9e987823c86d62e94152e5455d738136f69b5079d70c93c220f109f48315bbfdb058a915c9996e94f4c8a871ca325548a5a83455b4099cb3f488f41d6dde4a1f273acb221223540a70884608218a6c8742aff0004560479ef19cf98fbe3985a120004006ab6b9c978b6e8eb68d3168a665a0cb2da1b69012005a404e56d2015e384c4ccf6c6269f2cdbad270887d4f336aae75b58edddbaaa4bcb693361b9a0cd224a4ad0a91237cb6c478a792ecd71e8305b99a5bdea166d6e553219b924979f7a6a4b6b48253facbc00eb8b255511e83d697e526a9a2bccac95a1e0da8f129dd470d631d998138186f24cc90d32ee7afb7cb1d1a2dba86890ba77d19788950790998914a8ed109c0f0991db7b3f976e01da6529eb05760b9a8ac32a51c247e1c615b279c1295513f5b40fb4c280aa692a436adc49492d910d5c8aca5f835743486e9ae2e0db2fa4902992a3b46c0b977c89601221ad76f082b455cb2bcd55af2bef6154548554f684af370f629d29eea9cea1b9316ead5e255b76bb7c0d74752027219141ef03b0c68ada0ced05798a72a390947d23f4c6ba771ae45f13c9546e7d529503b0ce516aedd587880db2be59b824a7a663f4c43df4f7260f7fc3eb3f92af065ba13fad7dc219167bc673e63ef8e7968480010017cf295fa2b868a62def90ed530f2d6c2147ba50a9cba65223d719efcb9e0bf5bc0a75c699b95faa69eb509e1d6d30e19a97011340c539d436c8e021552382efe983c2c1cb25b15ceadf753534ced31cede5578840ed094bb2956221a057710516a2e60e9fb93f6aa071cab7920ada7500ac943609c147a13f562b6aab91e254a24ba779ad6ed5091437d0ed2d67743e85c92a574c8f74f5435aa52ac49eda9acb638aa1ab58aab355021a7fe12771945658897582adda7525b0e710212101c1fc46beaabd29d860ab86165267dff60b48dc2d7ab4de8971eb35dbb748a512a4b2f01fbd6003ddc7b49ea3d51ab5b4ccdb132b14a54a18f653d11722a14b524cb1ca06f8920f70e3586255d5ba20054c292f2d0820e51b6580c22192877cc0a6440c3608ac614e6475783d036c00564f78ce7cc7df0e0120004003e691d495762bc53d5b2b290db815b709ef9f5118185b5650d5706c4b73547aaac8d5ca9d496eb42028efcc65b1519d1791f7699da57f80e30a614a56549c4b5dac3b2adc0f4189ab8068f0be5aabecfa6eb1da4496965d53f50d1332732405291b7e199119f7d3c9ca2dd378e4a5f53791a6a2a0d43432e354ad69ac6e5d851448e7974e38c6ba2faa466d8f324b347f312dd5a86a8aa33258324bc954d481d052add155e90595b16fda282929db4bf48e38f5339da4267992827783d062a81e471bcda2c9a9acefd9af4c71e91f9488c16dac775c41dca4ee8b296816ca4cb1cc1e5cddf455e0d2d6fde281e2556fb824761d40dc7e1713f593ff0011b2964ccb7ac1173d30e201b33513000f744d84d3a2624ada4c56d8c8f67dec892a3b120a8faa212258978955f1ff00e371bd7d113029127bca7157e2778fc3d312305fb9ff0053f660007dcffa9fb30003ee7fd4fd9800d27febd7e68f2433e7f2121938bb72eefa228b44e0ba925b95fc7e1af872c933ded91560b7241f54fe35e515c5eeefcbb7d7ea87a40969299bef03f0d6a59bc971dfc9b32ce633e5fb316fa94b23b68fc178ac793e34e6bf35b724b3763f5a5b776cdf389b704539348f2b7caf903e5fccf0328971e7967f627ba33624d4e6099feeb8c324f363397475c40218799df963f2257fe69ffd665fdd64cbc7f3523c2e04ff00893f54a73c22cd733816f1193239f29970e24bf563598f02fa4fc2b869cb9e73ed4f2ce711901c879598efcf777614712dc783e5dd9713b9d5d302e419ebf72fb7ff0053ecec8520ffd9, N''VinaPhone cung cấp iPhone 4_small'', NULL, ''077b972f-1a51-415e-b48a-19f39219d165'')')
EXEC(N'INSERT INTO [dbo].[Picture] ([PictureId], [PictureName], [PictureContent], [PictureDescription], [PictureLink], [PictureTypeId]) VALUES (''60723f81-d465-462c-8265-deb007f48dfd'', N''ATR_small'', 0xffd8ffe000104a46494600010101006000600000ffdb00430006040506050406060506070706080a100a0a09090a140e0f0c1017141818171416161a1d251f1a1b231c1616202c20232627292a29191f2d302d283025282928ffdb0043010707070a080a130a0a13281a161a2828282828282828282828282828282828282828282828282828282828282828282828282828282828282828282828282828ffc00011080075009603012200021101031101ffc4001f0000010501010101010100000000000000000102030405060708090a0bffc400b5100002010303020403050504040000017d01020300041105122131410613516107227114328191a1082342b1c11552d1f02433627282090a161718191a25262728292a3435363738393a434445464748494a535455565758595a636465666768696a737475767778797a838485868788898a92939495969798999aa2a3a4a5a6a7a8a9aab2b3b4b5b6b7b8b9bac2c3c4c5c6c7c8c9cad2d3d4d5d6d7d8d9dae1e2e3e4e5e6e7e8e9eaf1f2f3f4f5f6f7f8f9faffc4001f0100030101010101010101010000000000000102030405060708090a0bffc400b51100020102040403040705040400010277000102031104052131061241510761711322328108144291a1b1c109233352f0156272d10a162434e125f11718191a262728292a35363738393a434445464748494a535455565758595a636465666768696a737475767778797a82838485868788898a92939495969798999aa2a3a4a5a6a7a8a9aab2b3b4b5b6b7b8b9bac2c3c4c5c6c7c8c9cad2d3d4d5d6d7d8d9dae2e3e4e5e6e7e8e9eaf2f3f4f5f6f7f8f9faffda000c03010002110311003f00fa301f9ba7e952e48fee9f6c5575393c548334012123d87e14ddff004fca93934ab0b35003958fb7e54f049f4fca9c907ad48140a0044cfb7e54fcfd3f2a4c71498a007827fc8a76e3d38fca9809a70c9eb400849f6fca819f6fca9f8a705268023e4fff00aa9caa7dbf2a9557da9e0628018a9d33fca9fb47b7e54b450014628a2801acb914538d1401cd863b8d4c8c315010431c0a7807140165580a944d81802ab29f515221f4140130958f6a70de4f434c0ec3b53d598d003d636efc54c1100f5aa17daa5969ca0df5c2464f2149cb1fa0ac797c6da621c451cb27bf02b48d29cb548ce55611dd9d3edf414edb5cac7e3ab366c1b6907fc0855d87c59a74e87633a3f6c8cd3742a2dd0957a6fa9bc16abea97a9a6e9f3de4b1bc91c2bb996319623d852daea36d70abe54e8e71eb834b37917f6f716e4ac88418a45edc8e47eb596ceccd13bad06e91a8db6ada7c379632092094654e307e84763576bca3c297b2f847c4936957cc469f7526158f48e43d1be8dd0fbe0f7af56078ad2a4391f90a32b8b451456650514cf314360f069f907a50031c9028a24e94500628ba888381934ad7698c2c78f7ac3dedb8900d5988c8cbf74f3480d613c5b4155e7deac42893aee0f83e95931c4e7daa66b98ec1375c4cb18f73cfe54d2bec17b6e69140ad82d5cff8b3c49168b1adb5a28b8d5251fbb8473b73d19bdbdbbd67ea9e2e456db685546082f275cf6207f8d79c5edb33ea6d78bad5cc61fe69381bddbd7775fc2ba69e1672d6c72d5c5423a264d7d1ddcb3cd35fb4ef7058892463c06f4f6fa540114afcace5ba0f9ab365d322662cfadeaf264e4fef5541fd29d6fb2ce52f1cf7536060095f781f862bae186a8b791c73af07b44dadc91c5811a118ea4726a1b79fe6565df8ce0e0d63de497779a85acc27f2eda20de640aa00973d093db1ed5ab05ca189a3589b3d883dfb50a9564d83ad45d95bf036e2bc960dbf31643d0fa574ba16a93b652191c3fdec6783f5ae2e29d55196452c08e727156adaed6203e7c11ce7349d29d4a6e32567dcb55614ea2945dd763a1f10c09ab45b2fd5e295989590ae47d38ede95d3f84f5368f4e8ecf53b98a4b987e412a9fbea3a13e871d6b845d50c9b848776eea73cfe75a16baaf97fc6cc7fdb018fd33d6b0542a2872cce8fac45cb9a27a8c72248328eac3d8e69251f2923835c458ea96d231e1a36c6721b0062b4a1d5f2a516e8a374f9c67f9d612a4d1baaa99acec41cf7aaba95d6a9018c699a62de96077349722154f63c127f01587abea9a859db3cab3890019f94802bc77c7df14757b3df6b6534a2e319c86202fa7d4d694f0b2a9b332a98a8d3d1a3dc626f18ceec5e2d0ace3c7037cb3b13efc28a2be5376f88fad379b3dfea30ed030b129c73c8c9268ae7946cec99bc64dabb3e9837cf8c8b69071e87fc2992eb096f03348761c6464f15e356d609a5df5cc8baa6a42357669633332aaca303e5cfde079cd56d4fc4535dbe1e62553e550cdc003f9d6d87c33adabd118627131a3a6ecf4cd63c7a12331d8803fdb35c75f788a7b8f9de662cc4ee1dc7e35c54da8ee6c99863d1462a07d462419ddfae49af62961a10d91e2d6c554a9b9d59bf76eaf8a635ce7a1cd73d6d7d1cf22a095118f791801f9d4526b0a18ed071daba12e88e56ddb53b1d2ed2e354bfb6b3b6e659df62e4e067dcd7a55b6b127816ca0d2b52b086e0105e2b8b79000e09e7391d41e2bc122f10dcc32c725abb452c6db9197a83eb56754f17ea9a95cadc6a778d732aaed05c7007a57356a13a8d465f09dd42bc29c5ca3f13b1dbdfdcc37ba9dd5dac69024ce5c44a78507b533ed5146386fcabcf24d7ee641cca80760ab8a862d4ae3e6267233eb5d10a2ed667356aea2f4d4efa6d463cf5183e879aac356849c8906d071eb5c635fbf5698938ed51c370db8ec9085f6e39ad3d958e6f6f27d0f408f5e89061773e3aed43fe155dfc5f1c12e4c531848e32b820fb7b5712d712e46e9a4fc0d06e5c9cb4aec31819a8f670ea6bedaabd8efecbc6f6cb731b6c9114303eb9f6aebaf7c476cd2bfd8ed1e6daca4859470b901871e99e9ed5e222e01c0326d2391c56dea3acc771e57d86e26b7249790b3a8f98e3206074e3bf3cd7256a11934e27661ebd449a96a775aa36b3a88588eeb68431055186090d8393e9820d63daf8265bdb98a5b99a1410c81b6bfcc473db1ee0fe55cb47a85dc6370d59c05ebfbc0453ecf56d5ee2e9e1b3bcb9924c8185427249e307bd73cb9a0aca47545467252944f60b7d2648a2c473db95e3f8b14571b6da7f8f04606401c616455dd4579ee0fb9e92979195f156c356d42c6cae2c236778d8a18236e58119cfbe315e64744f118c6fd1b52fc22639fcabdeeeef6d965b3c483e49416c76f94fff005aa96b3a38d514c9a66a1a869f73fde8d9846df55edf85551c6d4a31e54ae455c242acb99e878b47a1f8858e068ba99ffb777ff0ab91785fc51272ba06a647fd706ae9b54b5f1ae96e47dbefaea21fc704cc78fa75ac39bc53ae4236cf7da8a3e790f2b0adbfb5aa2fb28cff00b2e0fa962c3c25e348df7db691aac2d8e311819f6e6aca7c3ef194edb8e87740939259d17fad525f17ddb5b3235c5d198b0224372d803d3151ff00c24774fcb5ece7eb2b7f8d4ff6b544ee921bcae9b566d9b71fc33f189ff986ac7ebbee631fd69e7e17f8a31fbd1a5c23b97bf406b08eb929e5a776fab134dfedb7c72f9fc297f6bd7ec83fb228f99d07fc2b4d517fe3e358d022fadf06fe4297fe15f6cff5de2ad063ff0075e47fe4b5cdbeb52004e578ebc542daeb8e8c0fe149e6d88fe90d653873ac5f02e9fd24f1759b1f486d256fe78ab29e13f0e403e7f125f487bf95618fe6d5c75aeaba95eb6cb1b79a56e988e324d6cc1e1af18dea86fb1c9021ef29031f875a896658997da2d65b868f4367fb2fc2907deb8d6ee00ffae510feb514b2f84add7e5d36ea427b4d7e7f92ad4d69f0d3509a191aff00578d25519f2955867fe058c566b7812d2327cefb6dd303c8f3b603ff008ed62f155e4ece4cd5612845691127d7fc31680f93a4586474df24b2ff0036c5664de36b5c9163a469b91fdcb4538fcf35c5f8c348bdd3f539adacf6c31f050bbfcd8f4ce3b57a7e87e21f095bf82b4ab4d7f40b4bdb88a1092b6c66676cf2c5b6f7ebd6a7da4def2657b3a6b68a38d9fc7d73e688ccd0db2f46f2a38d71f90eb5662f8957b6da9411da34874c51995ccc7cc738e071c0e6b56e26f8617372ab1e851c6cc70a91cb32e4fe58ad25d3bc1fa68f3c7844b22f3ba7134abfcf145df71fc88c7c62d7653e569f62f395018805a438f538a2b4eebc6da559da4696da6cd6299c05b6b4da318f7a28b9495ceb56de28e58044823dac46e6c65b8ea6afac51220533b91e9bab31dd9a61b8e573c0ab31baa0e062b2bb1bb16ca298ced2467d4d2369d0dd28374639874c38071fa53525c8f5156126c28e314c0ce9fc21a04cacf3e9b6870092546d3fa5794789bc3d690e9924d6d049e7b911c28aa725d8f0a3d6bdb1661e95e29fb437895daef4dd12d25746894dcca51883b9be541edc64fe34345d3694b9a5aa45cb3f06dbc566ab77733a4e3a84c01f86456678a743b5d3f42bbbb82791e584060ac011d40ac1f0edd7896e74e6874ed41563b650cc5913b9e0671c93834fd67c5b77ab699e4ccb198241b6444fd7b700919eb45acc9bdd320f87913eb9e33d160bc310d3af6e1e378a32a5900527073ce3a724735f45c5e128b4ac3d869fa5dcc6391e6422393f06f981fc857827817576b2d674b6590c3691b360471004654ae49032457a9dcf886dda48906a175b9fa611881f5a2f1159b3a497c44961008aef4ed4a22921036c2aca463900a71daac69fafc1a95d3c71c13450ac61bccb81b3713d80cfd6b8db99834f0bcf7eb2dbab12db89e01523383f5152c1a58b9b7fb447e57978c972c00a1cd2d8145f53abd5dd5e16114c124ea8ca7233efcf4ae5751bbb8b68e60db5d80c8d87a823eb54a75489b62dc331f4424d54f30b398e42e463e563dab19d649dcd153b9e73e3286e350bd521e472136e4f247b673cd57b6b5bd86d228c09360181f20ff1aeeaf34a85e4f3446724f200e9ef519d3a32a000d8fa564f10d9aaa48e462b399f99433b67ee941823f3ab96f63221c081a253de362b8fc338adff00ecb4cfcaac0e7d2ac269bb645511bf3df1c54fb4657223217478dd4b16566cf3b9883fccd15d747a36220ee83e6edc668ab4e647ba743f6af2d8f232686d41ff00bc0562b2b1277c8c7f0a72c649e0b1fad6ee4cc923696ee438fde139fd29925e3eeff5b20f6cd5001b1c939e9e94470c658176933ed53cf60e5468fdae5da7ca95d64fef3f23f2af28f1a69d77ab6962daeed6d4ea86e9e792ec139e71d0fa60018e8315e98ca8179948fc6b99d562579c95cb8cf5cf5a99d571d8d211be9d0f3dd2740d56db7c7f6fd914836cab112a5d7fbb9cd7a1a695a7dc410ecb558e3450151188031ebeb55e388673b4fe75a7010b12aa8c103d6b1f6f27b9a3a515b09a7dacba7af97a74d15bc3da37855f07d89e6ac4bfda327fcc4403ed0ad355c0fbc4ae69d148d821b391d4f6a9759b12a686b59df490b799a839054e46c5ae01fc53ae48a162d5a4545e13f72b90074c9efc57a34cbe7412465e401d4ae5782323b1af297b56b69a4b79402f1318dbf03c1adf0f2526d332acb952b135c7897c488bf2eaf2b74ff96683fa541ff0986b8857ccbd91994e436c1f9f4a568372923354e5b59727e650bef5d2e11ec61ccfb9a87c6fafdc2b472ea170db8f60a38fca922d5755662cf737ee73d378c63dab323b173cef5f7e6b46ced51b8790861d29a847b0393ee5f8efaeda36666bb054e300e49a517da86f6c4b7c31d77371f8511e9b919f3e507d41a91b4c0c9b64b89d8763bb14fd9c7b0b9e5dcb3baf0409236a33ee7e762c8d903de8aaf0698b1261279bf16a29f2aec2e6676a173cb127f1ab49185c7268a2b90e906639ea7f3a0b3004ee271cd145448a5b959e62e818e7a6464f4aa339049ce7031de8a2b099b408d42aaeec1ebeb56d4828a71d79eb451591a0e214e0eda57705e20472c761e68a290172d89653bb0421c0af39d7add22f10ea654b61e40f8273824514575617e239f11f09599060609a85d4303bb914515e89c445244a19402464f6ad3b1b74182d963ea68a29a11b302a96da475f4a99d02f4268a2802274041e4f5a28a2981fffd9, N''ATR_small'', NULL, ''077b972f-1a51-415e-b48a-19f39219d165'')')
EXEC(N'INSERT INTO [dbo].[Picture] ([PictureId], [PictureName], [PictureContent], [PictureDescription], [PictureLink], [PictureTypeId]) VALUES (''491355ab-3cce-4534-9ec0-f055ede24d9a'', N''USB3G'', 0xffd8ffe000104a46494600010200006400640000ffec00574475636b790001000400000049000200420000001f00200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200000ffee000e41646f62650064c000000001ffdb008400040202020302040303040503030305060404040406070505060505070907080707080709090a0b0b0b0a090c0c0c0c0c0c0f0f0f0f0f11111111111111111111010404040706070d09090d130e0d0e1314111111111411111111111111111111111111111111111111111111111111111111111111111111111111111111111111ffc0001108014001e003011100021101031101ffc400c80000020203010101000000000000000000050604070203080100090100020301010101000000000000000000000102030405060708100002010303020306030505050505040b0102031104050012062107314113516171221408819132a142522315b1c1623316d172829224e1a2b24353f0d22517097393344426f183a3b3c37435657518110002020103020403050604040601050000011102032112043105415161067122138191a1b132c1d142523314f0e12315627292a2f182b253340743c273832416ffda000c03010002110311003f008cf770c05edd1088a73b9c91b8a8a780d79fc754b5f33075d00d7598b68e65b26256c96ad5514356f0d5d86ae3e2c6d87b0f6bc521a3c4d25f5ea2541427d28c9f78f3d5792d7b75d111b351a7525c995fa3b6592462a1c9de5fe603d9e3aaab5922ee2b5c4f3dde4a6ba90acb01f977d76aecf68d6dd1a497816d2da1f4b47b936eb37a90c68ad139615ad3a83a95ad090b720ef0e58f1d7f15c4cbbc7a8ae5d7a81d7ddacf6b4b1e3ba5646ce6bf6e58ee4bcaeef3ab9fb6b24c8309444e16abd00f12c35db5c8764a11a152abc40aff0069f84ddf372ab40c0d368095affcda37e4f22715f31ffb79c0d388f1b9f0f167b1d7714cccf1492322b465fc7a06eba86cbbb6eda5f5e456b5db238e17e9a7cb99eda44991e111896321958a2d2a08e9a7d115757253bf7196571776f72d040b07f47f426379712954a89376d414a0ad0d75a6b65b23c4a9a7ba44acf771c63f8d5864da259e4bbdec12376542883a90de3d6baa31f592ebf42b2c8f25e3b915b996cf16b879801be58e6925590bf4a10fe1ede9ab2f0fa11a3686aec359245dc4c0caca2306fe1284f421492054fbf5cfcfaa37d2b08e8dfbb5e11ca39376c7e970abf512c1711cb25b2ad5a45aed054f9509aeba58f22ad5af33977ab6d31af0984c9e33b4898ebe945d5f5a629a199d4501758694007b3c354f1d6aa7cc9e4d138294ec8f69337c87b6e730b3cf8fcf5ade5c451fd4068f7471b7c83a80474f3d65cd813c96da7a4e07b82f4c6a9996fafaf507f3ccff0023bfb986cb2d209ae3140db0db46fd2686a4743f1d67cd7b46d7e07a8ed983052b6c98f456d4d58ab1b548623736ed731cbd668d4313b01a9f0f86a2a634ea7ceb979ddf3dafd53657fdfcc66260e4d25d62edcc7617e8b2c6ac3a2b0501d47c0f5d5dc557d8b7bd46af5b4ed18fed56187fa3e75a50150cb0d7dd58de87f66a19ea9dd7c0ef769b354b479a257731e287152db9a30de1d5bc851c57f66b3bd0f5554ed56fd09f77939d2ed638b649041468e4f163d2b53a95bac1f3ee5f01d69f593953d3c8c399e4ee6cb1514f017686f650646a9a2141d00f8eaca71d4ee45fdbac9bd40170a972beb37cee7a96f335f3d4eda1ebb8f5ac246882dd84eca18d3a1f6ea0de87430d5a64c489c0f1aeab6742a98efda4ba9e35c942837afa70dcba0fde4864ab7ec3a7e0ce77268bebd25c3b56f54fd5ad0beac27b3bdb04961db2c13202a54820823c35d150d49f34cb4b63bbad9434c54c9f07e358eccbcd8e8dc65323511da46e7d20e4106564068295f3d57751d3c7c0eaf0af6b464c9fa29e3e6fc2a9ff00880661aeaf22e392f1552cb7d692dc433c88b4a5b6d2c5bdc5bc06b3636eb474f13d672ab4ff0070a735eaafb1d3fe6713ff00492e26897b4f8ab38d8c22fe782da6917f819ea47e34f3d3abdb8547896e0baff7ae4e66b73c75bd92f58236461b2fea5071cb363751c97d1cd7731a6f95e105d949f0343b7e1a57aa5f279c1a707233d7065e7654eb6fa5b2958854dee2b1f152ccaef91a1bccb642dd423df4b1e26cb75142ac15def5f6d6ba7bfe66d7c11472382b1e0c386ea560c6f35d79daff00a6bf912f8bdfd8bf737e8ac50c9159d9012ccc41324b236e6604d4375f1d148fa892d4a7bbf0b2e3ec94cb95fcf932bb47969d1ff2e8593125eedf93681e5bbaff0066b79f393d36972df3168d1ff890303fdba62355843935132faab28499c529b1ba9af8f5f6e80242ab57f9bb97fde0cc3f61a6901b6116c3c1d01f8053fb74c0aafeeaec47f49c4dd0ab6d9a688926bfa9437f76b2f317c9f69ebfd9d65fdc5aafc6bfb4a838edd9b6cf5a5c7fe94c8df91d7324fa072f16fc56af9a2dce4bde7cb66a3fe9f0c11d9585c158e60dfcc91d2a2a093d07e035aefcb9d123c4f1fdbd4c09e4b59bb2fb8aa3ba96d6369cef2d0d946a96d1dd308238c6d50a4f4006a8cb59c8d1e9bb6df670696aad60a8f8cf193c879ae65a291112096aceed4a92c4507c29af41c3b571d54f91f29ef57b64e4e4b2fe663fe138b728c5a2a5b64e25889a88e56571d7d9bbafe5abad6c2fc19cbabccba345e3d89bd95f8a4f65785af25b694f4b60a51038dc368f1f1ebae472b363c56d745e06e58fea5578bf11d1cdc9b5119b299c8a9f518a2d0f974a9d65ff0070c13fabf025fdb5a21908dddb08962bb8a66662762c7b76eea57e520d4fbfaea6b9985ea98adc6b35aa34dc5e4861090d9cd1814757da197af9aed3e7a3fbac33fa83e859ad51a9ee27980f56dae1de2fd3546da0fc00a685cac5e16416e3d9ae864d7d3ac8196dae177d03afa4f4f0f1f0f2d4bfb8c4ff008902c365e027f7ab27729db4ca2c70cc951032332150ac2e2320d48f6ea4b2d1e8ac9b274c51652b490665b33cbef6ee5124f712c8afb9fd3a8a350863f20f674d556cd77e27d0f0f178d4aa70bed03e7f8c67ef30af3243712ba7afd195a8638616ded56e9f2edebd751b2b353a9a7172b063bc36968bef7d0e57cd29fa84a1a566a7fdc3ad9c7e878aefcbfd4468caab0bd98d452a2809f76b41e7d9238b0dd7f702be167727c3a7f96740a01b1db1666a49b59de8ab4a82092093eca698cea6bebabfb72377ff00884604aa9a82befd70ddd7874313d3a10afa1b9c85c925046ae2a17c3c3562c8929089648e1d938f196d908ae188142d183e5d351ba56ba7e02b441a329c825b8c04d323197d15a9a9e95f66a58ebf3c1055d41fc1730f94c734132909155495f1ea6bad19716db686974d035613e1a0ddebc3ea42836ab134663fecd57931f93d48644aa168790926211c6b6d6ccc2883a923da4ea8d9a494393572829702586125e4917e56ad0063ed3a78db4c16a553c871597b3c8a348ce3ea159772b1a1603ad3aebb98332b2d0d58d281099af1ae65ac8fd1cfef1ff6eae76658aabc8ee0fb68c6cabd9fc0dc115ad8f89fc758ebacfc4bde9006ee1631e693236934f4b7be40c62da082aa0ee5ebed0756ab0a0e6de6383fe89135bde48d7987912718e8771596166614a9a1e95d29f21c798a9c620b7c95e4d04a86386cd43c71a0255e42db7e63e27a6965bc2d0bb8f44eda8f1c621fa5bab32ae525867420d4ee0c0f4f1ebac765a33a7852796a9f99d05c03ee1ad61b65b0e481b745444bb8c6ea8ff1aff78d4b172574b1bb9feddbceec3aa7e038c1ddbeddee6b939543094a7a5b1a95af8d295aeb47d4abf1471bfdab929c6c7225771fbff6d2d9c961c6d191660564bb61b0ed3d3e41fdfa85f915a2f9756767b7fb7acecad9f45e455715cc325facb34a07a4caee685c96ad7587f56acbfbdf74a61c6f0e37abd1fa20a5fc99fc767addd24630dc133c3220aaec6ea50d3c46ac7f2ea8f1d85298608ef4e1c5f71b6bcb785b7db48f34af5fdc6f1d8bec1a9acd5ddb7c59d7af6cb5b8cf9558db31f6827edcef248ad3331f80924b7ea7fdc71d755721c591d6ec58f7d2fe904aeea4570f6725cd0842429afbc81f974d6676967aec3455c6d7a1bf8ddda4912db5c3012c63d2dac0f5007cbd7c3ddab2fa433cdf27b7e4c9f52b8d6e4d74fdc4fe2b2dbf20c06478fcea63b8b2766855ff005004d54fe07a6b7d220f379b05f89922ea2cbaa1731e5eda592cee415961628ca7ca9aab223d370b24a24ac616e3e23545ba1dde339b12157ff63aaa4e8a503c760e48873f8ede4ea97904b0953d41e9ba9fb35760fd48f39ee5acf1a7c532d197b55770dd31c5652e71b6b231636f190c8b5353b6be1ad3f49afd2e0f2bfef16b25f5295bb5e365afdfe231719e1b8dc406742f71752ff9b73331795bf13ab298d2d7ab3172799933bf99e9e4b44be08f5f8963a09ae6e635fe764a64333f9ed236507e7a16352df98edcfcaf64bfe9fe920bf6930478ff00f4a0f2ac1bd650c1be70e87a107557f6eb6ed93a78bdc9cba72ffba4d6f88e9a4794195af6a38e41f462357538d0c6020d08693f531f6934d0b8eb4259bdd1cecb5c8ad79595a77d3ac745e897921779d711e2983c6aab5b4b2a48d25c45b642acf743c16bed604eaac98a945a9e93b1f71ee5dc72d9d7324e152d35515a7556fb1a3ce33ca7b7b6b92866b8416b7322a5bc130dc69b1406a91e1f31a68a5b14cf428e6f61eef7c0f1cbbd2bf35ab3fc56d7ff0033f10c5c776b111adc35b3484c4035b0910913a9152de5451e15d5ef935d4e7af68e79aeeb554e96d53db696957d6de889169de8e34e87d5dcbe9ad6460ac103509da0f5a9e9a92cf4f332dbda7dc164d9b17deba79fc0d971dc645e3f7994c5dbbdc482e123114e0c6433001aa3c7a7b078e87956d95a95f1bb2aaf2fe8f22d092dd3469a7a69f37e953e6f4468c3f79229ae634bdb568639a342b2c756532b394228684004798d42bc94fa9bf99ed574a3b63bcb4ed357a34946be4faf83f818cddf3c19c844238246c69dc93dc3a8e9200a42a8ad7cfaf4d37c848d38fd9596d8ecb7d7eb288a7fc3aeaf4f18d3f115bbdbcb707c878124d6b135b4b6977148125db568665601c6d2475a786a19aeaf4703edbdaaddbf9d457b2b2b2b2953faabd6bac7429f8e428e1c1eaa411ede9d75ce3dc5955aeb087be2f00becc5888fe75b99a223d841615d14acdd1c2ee19562e3ddbf04c5fef2a22f743384fca16f25e8a3a0a6adcffd465dd9e89f0b1b9e88a4b8b66971d35edcce5227ba9cbfcbd0ec04f56a7c75dfe3dab547c9b9b4b5f237eac277bcfb1724b23433a472dc32025ab2a955f22b26e5fca9a4f5666fa4d2d0b7bb0bdc5ba8385f30cae1d8cf7d6ef60228140655925530a9a1f2e95d73f97c7a66cb4567a335619ad6cd16261f15673476f7399feabfd6fd1dd706192ee9f501012768f9451bc874fc35affb7c69424a3ec22ece7d4cedf2bcab3bc371f792c262c824d2e3af088c925607aee000342f4a374d79fe4e1c7833daa9e9d51d5e1e44e8ddba9961f99f21c73cf14d839eb7322fa468cdb6d951563426940403d754db0e3bff0011af262ab4a2cba7e27dff00cd6cb5ec56b358632e28650cca82a9328f94a0623c371a1234ff00b5c7594ec45f16347641cbde5125cf1082f24b496de5bd6216dbe6ab3231263dc07ef814f7ea858d2bb49e88a563f9b6ca2b3ee667ef20e137b869ede477b9bdb3595d3a430bc371196a57a90c4529eed6ec34adaead23cf826adae85b56b65bb2374ea7799d203bd5426e668e8c597c8743d35d855d4792ff00225e522ef3ab08c707bf4f51775b0c8ca82b42564f58120f98f9c6a3751466de1646f915d3aedfd870ae5a156b9801151eb9ff00c1a871fa14fb87fa88d193836dfcbb454063e34aeb4a3cdc93787c63eaee8ecf1b1b923e3b3409b17e7dab3b1da0f53515e9e3a2424ea54b7459e93c84cd71fa49ebd35e72d937f4e88c8d26c376b64aa8115516651432311551eda68b4d442d5fe35cc926e6fe63d483e4687c4eb557a12aa026471b96871062b66f521964ab041f354f88a6afc56accb1aa92385f1ecc584ad34b12db4130eacedf39f82eacc9915969d4b2d74940473bea4a230894881a007a569aad58a7d4fac72a92e5d2162aa0a01b478065d5774e01d460b2c6cb7d7ed1452aa22293216200a0f66b3e5ceb124d92c38b73f809bcbd565ba4b246594dbc8581007414a1ebaea716fe3e64b1da59554966e9797008a52561e1efd74df52e5d0eeffb778522fb79e3d311ff00e47aff00cc75931f8fc596bf0f809ddc9b5ca1ce09ede30e027cb534aee14fc86a4eca0696a547dc9e29265719040fb45d6f70ccbd06e26a6829d7c35056827b644fe31dafbbc6de09eef704322ab988d011e20fb751bda4b31adac2b93c5d8a65ade501944532b9d9fbc01a1aeaab4c345cece2575339f2e1a5964da022c9b54576fca7c3aea8fa528e9f0fdcb970d55722dcbf10d61b177591c4adf5b93e88b83685453fcc0bbbafe07515899dcafb871b5fa5ea0abec8d9c12dd4578d246b664a5211d5c8f1ea7c3577d169a4bc4f37dcfdc59aedd71ada89786c8599c54175f4dd2e57e50ffabd829acb971b566a7a1e62dbace5bd43305ee5fe840671188d88b75615dbe7b2becd34d594136f444fb1b5bac862a4b7bc28ea22649948a801c11d4fc359ef329aea5d5cb928a274153b2bc6aee08f904006c7b1b8803d7c9007f9a87f0d6ce42dd0d791eb3b0f26b8e53fe22477925b6878f2daaf592524b1e9e46bfb2baab4847a8c1b9bb37a2808f0db8e0d79c4ac32f752411cb2c2a260ec0159a2011c6df8aeb6d30a6b53c15b9d9d5a2b67a3d20c62ee0f6cf1d9195aca4f52e251591a08c92db7da7a6ad58d229cf7cd96ced76db7e629f21e4b87cc7207bec62491a041eb8906d25874a8a68c95946fedfc978e13305e478a8e455b89446ea3cc13d0eb23c6cf55c6e7515a59321cf62244dd1cc1c52bd01f01aade1b1d05ddf8dfcdf8073b77ce38fe279963efee67f4eda194195c2b74460413d3e3a9528d5918fbbdebc8e35ab5d5be85dcff00725da18854653d41e63d292bfd9ae84af347827dbf3afe067a7ee7bb3c91acd2642454913d553e83f54a915fd9a9ed9f131d935d51a2f7eeb3b29f4a48c84c6b42a45b49424107c746df544777a309637ee3fb5f91b679ace7b89e388d1c881850fe2749a8f11c82ee3ef03b2504de93dd5dfa80942a2d8fea0694f1f6e9ecf509f431cc77ebb539fb54dd6598bdb7b4996e16682c2478c491798606875564ad2ca1d91bf85cfcfc5ddf4e56fababf831721ee4f656f9e3b78b1f989aed679244821b43eab348db8a6c0d53eda5354db8d8baee3aabdcddc1eef9a77249f4f050a3c9c10b35dd9eca63ae2517b6799b69240aa2364f4de34ebf2ed67056bd7a69ae2d1f4b162f7573d34fe5d3fe1af5fe6ff009bd42377cfbb590f1c79e2c75f7a172a264725090c41dac416ff001692e3e3889214f73737ebd725dcc42f29aaf002f18fb81e016385b9b1c959642f92e65de5c140dbd0d2a3e6e87c34e9856ddb6643b877acb9795f5f0d7e9e8ab0a3a793d21fdc667ee23b30eb1db8c3649de2ac51aef40c4b357c41ea6bd753fedf1c7528a77de752eeeafab73e1e51d23cbc0fafbbefdaab2cb8b01c4afe79ad5429f4dd5c024023dc4d3cf51583135d5965fdc3dcb55f56dafaf9ff00e269e5dde1e3592e2b738dc5f19b9c64b7d2472fab23a507a477780f7695b1e355693ea3c1deb956e4d32e6b3becd35f52b43ceadc31ff00a5727fde1fecd62fa3ea7beaf747d76fe25bff0069592c467f3f911905f453110c12da177f09a79765053c6b4d5dc7c5173cb7b9f9af263aa8897afa88fdf5cd5d2f777915a2421b65dcb590353f51a0e94fefd5b978a9de64a387ee7be2e32c2a8b451325392e1327776ae6d2d26b9df551e9c6cc3757c3a0d5a9a4f5389935ab8046670195c6cd1c77d672594b2289112e10c6c52a40600d3a56bad15699ceb4a2f4fb16cb61edcf3083312416f66f6b673ca6e1d510c71bcaac49623c376b9bdd2b6754e932996e0b24dcf42e3182ed9dd6421b9b6e632aadcee920823cac454a81560ac4eea7e3aaebdcf9aa90e8a7ce097d2c33d7f118c736e256586438ac962dadeda5fa7767bc88287ea482dbaa5c922b5f1ad75870f11e6c8de7dca54ca5e23cd99d6abe9c3f8b3dcb72bb1b9b9970b35dd90ba9cecf412f221722ddd455d56a4d4127a11d46ada70b1aaab2ddd3cbc7f70967bab7875f3f02362b905b5a086ca05b48aca3710dbc9f5318dd18dc03015ea4903c3dba9df818dd776e7ba2636bebe40f9396d7d5289eb3e04f8b397ef2fa53409198d834804c85a346150e457c3cb50cdc2c55acd6f2e3c9eac58f3e46f5ac7da25fdc3f23169c0e785502c97712cb1c85914864b98402075dd4dd5e9a8f0b8d337dd0ebe05d6c8de4ad62537fb40773c9f91ce0c935fceef26f9646f50aee35245694f6eb5fd6bf99f45af070574545f70bd9c9a692040eed2110b92598b75207b755bb37d59d0c18eb5dd08e6ac9a03750035a7acfe1ff00d9eb771ba1f3ff0071ff005511b30505fcc7a8527a78f8eb4a3cd13b84aab5cde1f9a82c6e7a7bf68d31317e741eb38a1fd47fb7401d157f908febd9a49046ca4051e3d7ddae2e2c0e14196b50c612f9fe83d7593796254963d6bed35d43251ee864ad4491a4bcb3dd860e3f9408dc3a834f2d4ece341d2b243c866ed921961b29635bce9bd41ab9a9a506a78e9699b2d022421672dc34714932f52bb1e953b07b3af9ea567a1075d08596ca456ecb1cadb615f066e951a962ab65bb558116e3277776ed8c54789850dc31e8adeea6b5d695e8fa93ad095716394b6b6671348d284a3b8240ebe3d34ad54dc411baf0407b6bf5d84313f50fe67cebe75d569433335ae86e32b59da87912290ccc5456304ffc5a9fd6725bf5acb4475d7634a1ec1e1094d81ad5fe5f21f3374d5dc77356fd59ae663e02cf39beb6882ee3fcc094f813a705855dc8ad12e24dcfd054ed34f3f753516c9a024b0dcd5d2427640bb147bcf50746a4901729672c688d2c88cec2b5414a107c350b22fa29702cc72c911315c37aa92b55631d1a95f33a8d9ca29e4e09cdb2a7417db13418ce1179957b5b7bbb6fad9a2482ed4483798632695e9503c34f1a577af80a6f8a9b5f590ae630dd8bc9650df5fe1225573be7b73f551c5293d7f98a8c056be4a46acb62ab732d1435b9cb524bcbb767e5b4483198582d2008b1b4303dc22ed5607a070c6a4798208d2fa18e208ecf42345c57b6b7564f5c7ec3ea12237babb20807a105541f0d57fdb57d7f0fdc0f1d7c8dd2f06ede496e52d60960661f3d1eedd5d478021a87c747f6d5ea3754fc0df8fe21dbd8219d930c914d7bb3ea6e23faf592531f4151ea15fd9a97d0afa9ab0726f87f469f61a327db1ed9e62d4c37b827929e624bd47a1f7ef1a8ae253d4dbfef5ca5fc5f802f1bf6e7d89b6ff2f0371424b3452dd5f9524f43fa5bfbf56ac7eaff00c7d873d67b273e21cb4ed4f656d2d4c363c331504cff002fd4cf0dfdd4a01e87e692534a8d0b12f5fbc56cd6b3d4117bd9fecdd834ad0d858d8fd5c6527548ef9801514a0797a75d49d3fc48a995d5e800b8ed6763e4ccda4111c5dcde4eca9f42e9706494035da804b5a91e269d35078b4ebf89a573b2f9fe0589c7f8af6e707104b0e0984403e5125c584f7aff001dd712c874fe8d3c537f6b287c8c8fc4f6f78bf6f6ec169786e20bb78ecc57a7d7fe165d1f429e5f8b2caf3b3ae9760d6ed970095aa788e3803e4b64cbff00f3747d0aff0086c97fb867fe764eb0e1bc6ac990d9712c4c6615f4e36971d693155f60f5f7ea7f4abe5f9fef32bc967e2310cfe6fe816cdb1f00813f4c11d8639211ff00084a7ecd358a9fca88ee7e64483ea2394c8b89b6566a8729638e8eb5f6ed8c68fa54f20dcfccf556f19c3b63ad6154ea08b6b2471f029157f6e8fa55f241bdf984ecf96f38562219eea2b708238625baf495569e423141a92a25d17e026c1f98bdc9ac4f793091ae9583bdd35dc9bd501f9946c556f9bc0f5f0d1b3513bc239cbbe179c7b9173c0f797bf577792b713c570e4a40c52478b6092a7732ed3451e0b4eba775a9571b92b226ebd0d59ee49ccaf380d9f1b964b7fe958132c9024112abd65a6e323d37b0afb4903e1ac75e252992d912d6dd4d8b2b886265ae065dd4b895630493b56a482df96ad64f7a0f6078ee2e0ba49235df27f1b78f5f67b3517304774b21f31e4395b6e557515bc9b22494205a0340001a58e8b693c9669b08f1cbfbcc93fa13d0ec4770e3c49a5350cbf2ea89f1deeb40aef8a712374f33aced9f44ae2d0b77ed3afb1984b9e437d7d134f1c56f66e8b180ceacb39f9c0a8f01abb05a2daf91c0efdc6b5d52abac8bfcfbd1cc775392642dc334135c991370a36d3256bad977279454756d3ea7bdbfbe9944d359110db16924559103354b004b53599dcec71f895b5526b510fee85e6bce6f6323396231c80b22ed52125916b4f2f0d6ac769a9cae6e254caea56a10c4a76486927ca7af423dfedd4cca621983ede87cea053480fad18faafec3e5efd2634686b89bea4cbbdb78350f53b87e3e3a628255adedcd52b23911fe8058fcbf0ebd35108417b7e4196dcedf533ef997648dea3d5d7f85baf51f1d0349137fafe6725798bb5b8b89ae61c7bec856691a45412c8a76a06345141e5aa32284cd583fa95f8afcceb59fb3b9a7c57d509e3d8f89391440a777c942623ef20d6bacab8d689f493dbaefb8964db0ff005edff310333185dd4f01030fcc0d6783d1e1d6afe27375d2335ec201007aae4d457f706b7f17a1f3df727f551a73714ad3b741b8392c69d3dd4d6a3cc9338542e2e2f7ff00f5f724f4a792e822c5f944deb352940c7cbdfa605bbcd2789e7b696d27f537c424968369473e5aa38b570f728d495a8abd19f71ee5d2c70fd14af447e953eff3d4b2f19372576a492afb97c5690490c0bbf72950e4f813e63505c697a8511bf84e28e3ed64cd65ad77fa83746f3375a135145d19aaeee2af444af89edd076e176990cbc08c9134b2, N''USB3G'', NULL, ''077b972f-1a51-415e-b48a-19f39219d165'')')
EXEC(N'DECLARE @pv binary(16)
'+N'SELECT @pv=TEXTPTR([PictureContent]) FROM [dbo].[Picture] WHERE [PictureId]=''491355ab-3cce-4534-9ec0-f055ede24d9a''
UPDATETEXT [dbo].[Picture].[PictureContent] @pv NULL NULL 0x5c06940f055463d0b6b1df1dace2a57585a33572ded965ed22932574c278158845db54091901ba1ebe275b160b5547915bc9e40ee36b15ad95edadba2857b82aae3a28a28248d5fb61ea6ac72ea493299f0f710b15df1d177035241d577ac4b1deba38131ac1e3ca99186f485fd38fcbc7ddaa7d0cdb4272f16bcbfbc36eb2adb02a241ea0f127d9d750ac48f1d14ea7597662192dfb03868a43fcc8ade45623da246ebad3c65157f16697e02e73cb7b07b186595089596bbc7b01f3d32cf12aee50c91b39aed0b5a28af81f66a304d00e1c9c51a082747592ea40c809dd50a3c3f6e89d092ea04cfa4edea321f9626350474a78ea2fa96d1b5aa0664388ac384b6ca4f70693047a11d03115a74d4aa936e7442c5bfeaeeaa9b1787dbc7d3dc7656734574feaf709f30e955823ebd755e0a6dbd97c0d1dd2fbeead10dad47dcb714b5cd7165b16a46b70a859854114eb514a6b4baca3995b4393747825b0c5c5148cb2240c8a18a8aed0de674569086ed2c8fcbbb85c7b0180fea558f228b2246d15b4b1b4803fef01535a69decab56df81d0e076bcdcacab1a5b5bf169c089c9fee6916eed1b8f5a7a90004dda5eaed6663e0aa509a53dbac7939d551b549eaf85ecab3adbebda1ff000edfda438bbe9dcccaf26b79b138c66b24f91b1d146f289777896936d41f61f2d556e7d9b508d0fdafc1c186cb2e4f9bf9a623ec32b6fb97e411f270d92b248b190892396ca0ff003b7f802647f3046a4f9ed5a1a85f889fb370df8f38ef3670d59f48f80d1c3bee178d65aeee86504581b6b754303cf29924959890400169d00d68c5cba5df97c4e2770f6a7238eabb27237d76ae83b617358acc63a3bfc6cc2eecee0911cc80856d8c54d2a0798d69ab4fa1e672e2b63b3ad94344a9eda2607728607a75f66a5055220cbdc4e3191ee64dc570d8afebf9be3d0b5fdcdc3491c51db38a2fa6923862642580e941ed3abafc5ad6a9ddc37d08d725ad31d017c93ee7b1181e136fc832784bf80df5d5e63e2b5ac558ee6c646431cec5be5621777452357578a9b7f36888bbbd342cac7dcadde3adee80d9f550c73edf1a7aa81a95f757588b4dc50574c0fb68d0042e4198b4c4612e7257219e2b38cc852352d248de0b1c6a3a966621540f12753c75dce08d9c220706e5f1f21c12de3dacd89bf898c37f8dbb1b2e2d6e1454c7203ee20ab0e8c3a8d17aa4f4d50d7a8669a80cf086f11a042477bb9ab60b8ec56f08ff00aacbce96aa7cd226601e4fc2a00f8ea530a4cdca974691cd3dd18ade2c362d121a9c15e5ba45427fcb4dcacb4f78f3d66762cc18a28daf0b05387e5ede1c7647173bbacb64aff4e24ea1edae376c04ff008482bf0a6856935fd37f702ad2e64dc2d5d5a47b59028228498c8aa39fc3a7e1a50098c18d92d63b859e560823a54b1e8003a83ac9356815f945f595c67aeee7d784c6f70c54ef1e15e9a9528d20b59318f8222adf8e9e3137879f4d539ff496f1277a343e3c6f269e67585b3eaf5c3a21e3b1f8fbe96fb2305b4465f56188b851d68ae69f86b5711adc796f75d1d71523c59aa0c7249c9b3ccebb774fb496e941bcd6badb74789a13f81e1f8908a5099382c519a5458ddd4ed0af5ad598135a79ea958a7a1d3c7ce744b7229dfbb7b98edfb916b163ef12f6138d8cb4b6eca6372f248c47ca48f3d6aad36ad4e772737d4c8ec8abe3964d952b4a7b7a8d3283d89ea85cf89a0d2607d6ce048e7516491162977c8df1d36a0524a8351192edd598193c76a92a0fb69e3a18d1bb896424b8cb5b8900dc278294e8286451a8665f297716dfead7e2bf33f44eee09acecad84c6b1a92816b5a4471e7e5f86e5269a7d123a29abe4b479fe3b8a03321584a4787a4df87cbae43ea7d330e9439b2ede25bc87774fe6b7c7f48d6fe37467cf7dc9fd544fee05b622c7902d9db2b242f6e2e37c8e598c8e7a8f0029ecd6a4cf396ac237e1acac6d3925fd8445a2418a95f74cf562ce12a2b403a9f0d1b84e9a0ad3594693492349b610c68c4f5620fee8f669a914169f34c1ff004d024f53d524eda3788d5945a0ac2ec7340ec14f46f1a7fb34e013936da44f2642086bb964914007af9ea2dc20aad478e6965988b0115c5d49b8472a95897a26d03a03aae88b2cc95dbfe476f3c114b2e4cd9fa0a525843b4721eb5006de9b47979eb35b1e74dec847b3e0bf6dbe0d6bc8ae5faffc56af4fb3d025ca39471fb9b6fa5feb128146661248d560c6b41d294a8d471ae5eef99a8335717b72b8af3f59e4d76744bd24056f6f9fbce3971361cff312f0924fca1a32a057aeb7dad0d9e4eab419786f1fbf82ceebebdd2e1a40aca6305402a3a8ebefd54dc96349213b93ded945988ace28cdccf2977aa31aab57cc0f66a14a36db666a2963a271fba925b49a30ec7d15ad7c2a05687543aea0eb16d0e8ced4c92c9d99c5c7b49731ccbb478d7d46e9ad387f4bf896d96a85de6b693a590790328315190f4f06f31a4585599f677bbdbb7d4209040f0a8f3d22485cca3ddc99887d18d59a0704103a212a741602f90dc5c0b795651b243b8487de3dda8bea595e817e476d6e3b778b690054db6ccdbbc36902b5f76a2bc4b7873f534f22c5edf4d650f6581c622ca926766056043274fa64dcc147f0fb753c7136fb0a397bf72ddd4b5b07f3622d8f8831a75fc357d7a18d8abde8e6f7381c4a263af6c62c8106536176ad24d3c63a8f4c0341d475ddd0e9e4b6dac9d2ed5c35c8ca93ab759d61c41ced3dc99ee9e62ab1995d9ca4636a02c6b451e43af41af3b7c8ed66d9f6bc1c758b1aa2f051af5308dd9195949565ea0834208f66a2997da8aca1ea8e8ffb77b8b99fb6568f3334ae279d373925b6ac9d054ebb1c0b3b525f99f1ef7561a62e6dab450a17e4503cb2278f93e41594ad2ee61d411e1236b9dcd5feadbe27d3fb334f878bfe55f9034f5e8478eb323a4cb6bedcf9b66eeb3cd8bbebcbdbab5b2b755b5b386257b58900da0cae06e5ff000814d75b8796cf47d0f987baf83870da71aa29f0d77175cc0fa448fd40123e34d752bd4f116e872e7d9bdf5ddc77df92c974c5ae6e6ceea494b7ea2ff5684d7f3d6dee1ab5f11615f28c7f7d78ab4b4edd63a485767d56664b990797ab25b10c47c76d4fbf4b86e55bec15bf5236623bc5dd08fbe58de0cf71676d8a9b131bc29141eaed66c7faf1b3bb90cccac3ad280e878e8b1d5a5d7f786b2f517ad3ee8fbbd276ab3dc9ccb61f5d89cb5ae3238be97f92b0dc45212546faeedc9fbc4eacfa14dfb63a2fda2d616bd427ccfbcddd9c0f2ce0f25c6580e35cced71b7376c2dadc488f3945b9447d9d00dfb97d80ea1554b636d554a91ed8b7564ceec775fb8dc1381da1bbc9fd7e6394656e63b3bcb8821d9618cb598aa491a2a006528436e6afb869d294bbb5a142e8bcdfa8b5d113f94667bc5818793f22c55fff00fa216f8d59f133e6d524c8cb790c6ac4c48e81cc4df31fe653a75514d2c6a97b2509bf18e81650bac15e5ff7c7bca3b69c433b267583e7b39770dd7a512248c96d3c602338e9b28c46c55029edd4e2af77cab4fdc3dbaad4bb38cf1ce696ddf7e4594bdcec37981bab3896cb0893979a0dc576bbc07a4606d6a30fd5bb5972ddbc7551082a926f5d45cef7dc4591fabbaf187197b698c89bfc719fa89a9ff100bff0eb3b5e1e855c87fe9d995473c7b5b5b09e19e30c65b88e5527c886607fb7592cf535d2b0be3fb0099cc8da5c725b66b5a2acf8d97798cfcac63280787b3afe7a8e26e35f33a17aedb35e68dd6d1fa765637bed89629c9eb546ea09f837f6ea5e6647a6a2f73de50a989716b2ab48d214a026bb53c6beed5b8ea2cb29159dfe52e66a991a84d3a2f4007b357148dbd99ee9e5315c96cf157927d462eee5f414c9d5e1697e5055bc76d7c46b367c69a6fc4d7c4bbfa955ea5c6f0d58f4eb53ae3c9f69ad2122cefb63c15d5f66330b6f726c8a5a444baa076eb2f4a575ab8b3b9c1e47ddb7ad298db53abfc85bee064ce279fe72d1b7cf35c5cc89b914752ae7aedf7eb667cab1f53cbf6bed2f995b645654557e2521de0cae1f191c6363ccf7aad58f76da807a92475f1d2c0d5f55a0fbc712dc36b1bb2b36a4ad8f270e2a6d6248c7ca87ad40fc49d6a384651e6239a3a05da41ea07fdba1113c9e57655119d83af89a56ba680f566290331ea4802befd2803559b1de743044f84f51a8b244a67923b562940c07b3cb4866fe19688b93b3957a192f218c8f848a41d4337e92fe229cb5f8afccfd1276b8c871b8279036e0b1cec48ebb7e83a9f8558e9ccd4e934b1e76bd5aff00b8a072e84413b7b227ff00c275c883e9785ca48e77b6b68a6ca58a4ce21825bd114d2b74d9190b57af5f004eb7f17a33e7bee5feb21f79771ae0961c89eeb330499692283e9e08ece467819596a927c85486f0e85a9d7a8f2d5eac8e22c3ba9b9b841ac0f6ebb6d9bb24cbdcc17b6991bdb358eea3175b220211ea150bb090768dde3e3a85ada9d4e3f6cadf156edbf9bfc7e66777d83ed24f146d24578c83f95d2ec55163da189fe5d28370a7c74bea32f5d931cb5b9caff0bf6817bb9c59b146261732dfadc02dbdfa0523e1ae861bef52797cb474b40800bac81bc0a9f13a9320829ea324914ebd0a1571f106baa4b479e43999b338786d37aa7cc921918eda80b4db4d4289a5d095a05fc25a2dae65e2342b229da7db4f668b08219ce2579757c971114542a050f8d4694e810387169a3b5c2b2329eae16882a6a06a2594ac862d32f6c606823421a50c09f781e3a24b5e1f95951c2597b8efd68c6774a8f61075764e865a974e19e4ff004fc6cb36e95168454790e8754551365cdd9cbfb88fb4d8a75f9e6ac842b0a9eb2907a68a74b7c44faa23f76e17311066f4ebd6817cfc4e9be8497529bcf25c4139304bf3354d42fb7fdba8364d0224fab86f4bb5dac71491b108c8080d51d4902b5ae8ab64c5cc92b15914b896635352a7e6dc7506f52da9217955c652c2c7097b0c6b6b1a04a9f95c88c74527caba34e86fae0fa55fa957a970fdbfbc36dc065b5b475165f5f3911febdb706340df3798a0d3c6a2ecc7ccc9f52a9dbf54fe0599837271707b428f70d69473809dd0e057dca70a2ced6e6dac64a9f527b9b55b96d9fc286aa53af98eba57aeeac789a789c858722bbaab478339e4f1eb95cb182549dad6de7114f782da682068c3ed328322d1453da75c5cbc76acfd0fab707bee3c98d5772791afd2bcfc82a717c32daf2d639655205a6f966867048bb120ebf2120d01341d3c34be955352cb9f2397931d9a5fc5d1afe180f5b65b8743018c720bf444562ab1dc4ca3755985145054823c3cc6b5d32c68ae70efdbb359cff6f57f140d697b75751c92df5f4b2ce934bb5eee499d7d024ed6e87f5507b7c69aa6db723d6d2cdf5c3cbe37f4f1aaa853092d7f703b27c4edf31750c7c2acee32c12377b95848775a3d0336f65a0ebd29aaed813d29d4bd778b7128edcbf17a422deec476d9f03834c84ed92b2c8dff004bcb0bd312a068c9028b1ad286b5535aeba1c5c3b54f467cf3bd774bf2f2eb6dd55fa7449961b82dd07979eb61c42aac6761f31c4bbd375cdb897d2dce3b3904d15fe2aee57b668a59dd5d9e19152405772d7691edd68be657aa56ea88d6b1d0f3be9d8be65dc1e396d8d5c8d958c9f58d91b99261348aae63f45218140e88a9e2c6859aa68352c5c9544f416cd7a902d7ede39ba778719ce65c8e34ff004bb6b7b192cd127fe64705afd2b30723a3104b0e9eed279d6d558e9fbe47b7afa80ac7ecdb922702cd6025e430447359287211a47017b744b62e15a4268e5cabf802147bf563e5fcedc780b628467de0e2fc272184e29da8e43965b2e518ab78a6b4c8db407d19218a3308846f605649f68da3a8dc3461dd5abb783ff12270ed03a776fedeb1dcdfb7b8de3f2df496f92e3c88963929515ea56311b099136821828aeda7515d538b33a7da49a9608e3bf6dbc9d382dee1390f2ab8ccde5c59be32c24911e4b4c7dacb41218637705a4651b4331f947403567f76d5ba69fe3a89e3a9025fb3c826e1988e373f23945971dbdb8c8dacb15922cc65ba2acc1cb4ac08057a74d45725eba2d46d2991bb05d9fb4c2775b2fdc49f252de5d64ec56de6b63188a2568d50c925431e87d31b57f77af53a8db2bba55f04284a447e6484f0ee2f697132acdc872d2dfcf16dac92b32cb70581a8a050687a798d50dca6fcd946552eb4fb7ee107bab3c12e4adf16902cf35d3cf3127c556dc49d47bf76dd5164a4d39a56295d56a28723bab38f92d84b656e5524b29d4a2d0564640ed41f86a345a1a9d9ccf9a0ddba06e356cac95f5a144dbef71e1a083d442e6981bac872ec6612ce231c970aa8e2315da818ef6fc003a93becab6c78e8f2dd220e6bb31927e431c568c60c7cf1bcccd237a8d108db6952452a4f88d535e5fcbaf537e4edbfea457f492785f6fb14bc921705e7871b711c8cedf297756a85a1a74a8d377764c55c35c792b1e68b8b68de7df5d7299f654b445c1f68815790666be06d21ff00f8dad7c2d6efe0787f7aaff4b1fc587f358abd6ccddc9638f86f2692f6e9ccaf6a9378dc383b9d94f90e835a73f5e9279ded6b0fd27f52d1f6c1ce3ffd41bb7f9519cb2ce5ada88ace0b736f324712c0100988470aa0541ad09d4f15d27b7a18f9b8b7257ab951aeb272eba4aac410411e20eb4c9cb827da636fa08d269d4c71cea7d3af8900d09a6956c992be37549bf10cf16e299be47c8ec3038785ef72b98b88ecacadd3c5e699b6a8f70eb527c875d3b59554959d753fd9276878a71c4c7e5609f92672155fafc8c93c90db198a82cb6f1445408d58900b1666a57a786b066cb75d199b367757a14f773bedd709676af7bc64bc5769b8b63779991916a6b197f98311d42d4fb34f1725bfd44f1e59ea54b0821a9e14f1afbb5b0d24b27fe99fe1a4818538321f56da528088afed769f13b9a6407a7c35567e86ae0aff0056bf15f99d9d77ddece1b236a96d14510c6ff4b5dac4fcc683d6f8d2bd3597fbbd212f083db2ec18b7ee766defddfe4579975736771ed689c8fc8eb2b3d1e239b32729530475f94dc4ac40e9fa5169adfc5fd27cff00dccffd64865ef13de59f238b10cc92c3158db5dee8c157324d1027a93e143ad296a79fc991ba2af805f2dc9b98e373d7f83b34b56b4c3db5a4ed37a44bfa93a201bc96155206c23d9a85b6aea8d587979b66dadb45fb1cfe62f5ff007cfba360f24a6dec584e364abf4c59169d4ed1bfa6ea02dd7f7469afa6f4824f9dca5f36f7ac79784c787ab2d6ef8d834180823de87d21d4f8b1f86ade328a98f996dd792999aa5c507527c07bf5a0ca16bab6912c5372ec3407af8eaa45830dc5a64b25616fb218e3223077834ad06a3b9f42c58ebd488923dbcf6bea8fe6248616fecd2688b1eda25f450feed07bb504324629e48ed2545daa8c4166afcc14f98d3278daf10b60723c5e08267c94e58c40858e31f375f363efd28724ef6428f21b2e2725fc375651ac57c6e1648d6315660c69f311e3a937a3928825f7232fc838fe3f0f7366a8b8d9b77d79923dc0b015543e62ba31c6d9f1275aeebc37083ff6d5dd9391ee4430c125d058d58c568d297b71174dd54ad2a09e8752cd650a0ae958b32e0eebcd925ca3305ad83c65e87f58727fb355d9962453fc9b2e04b5dae375779515a107a0d4209a03672d635c645791ce256955da78cd43c4e6b4e87c7f0d34b4249ea2fce1dde3d859a36d83703526be3d35065d509e7382653fa69cbcd4b6b0859773cc4ab321f12b4049d112ce861e4a5455f182ccec252d7864d67621ee2137d35c7a8f4ebbe35151d7c3451a591af431f26ade1567e6cb638bef385b70dfac20ddf1d6839a1451d352110b91f1fc5e6f14f8ec9219ece62acf1abb47bb61dc2a50834a8d26b42cc792d47baae189fc9fedff0081e4a1b482d211818eda52d2c9608ab2cd1b0eb1bb35686be0dd7545f8d4b2883a7c4ef9cae3bb3addfccbc7506e7bedaf801beb496def24c3d843417d6ef2ef69d57ad56495aa8c4fea3ecf0a1d42fc2a38836f1bdc9cfad2d45676dde3d5af812acfb3fd98b7e4d6d93b2b88145a92c71af751dc5a48db48059252cdd09ad2b4ae9be2e394fc8aafdc7b83c2f159ddd5f9a7f98e182e27c4b1f7b25fe2f1f69632cebe934b671247bd09ad0ec001ea357aa29938d7bde36b6e3c82f5af41e27fb3532a32e807f6e9c01aaeaf2cadd435ccb1db86f032b84fcaa468255a5add1360797b93dbe46dad99b152b514f5d0f87c0ea0ef55e28dd5ed3cb7d315bee6686ee976e0375cdd8fff007c349e5a79afbc97fb3733ff006adf718b775bb6c295cdd953dd257fbb47d5a79afbc7fec9cdff00dab7dc06c9f25fb7fbee4969c86faeb17759bc5a94b3be90179a25a93f29a53a54d09f0f2d37c8ac46e51f126bb0f3bc30dbee0d597747b7377204833564ccde01a5087fefd34965a3e8d15e4ecdccc6a6d8adf706adee6dae23f52091278fc9e260eb4f8a923561cfb51d5c350cc8e82005e7f7c6db895e153496e9459434f1325d308569ff00369ad35132b5e736905c723c4b2a030e12fa3c4dbbfb1c63ee669b6fe2d1a9ff0077518d20a69f35ddbecfde569cc11877232ad3c6c23b3b68e0b57a740d747d69187e4a354dda4cd98a8ec988bc8f256f1dfe1673f2ac4648e5622952f1bad74aba8b0ff4eadf916370de01c833fc6edeeed6316f8e8218da5bfb8ac76c869e1bbf78ff00856a75760c17cb68aa928e47229894d984afb39c66c3137b698db48ae9f1ecf17f5031a8b972c8ae496a569b9980f7535a79ddaa71cd75b57a91ed5dd632edba857e9e9ff895d2f20e419bb595ad2d25992dd961924b6467a33d76ab6df027dfaf3ff4e0f55f5ea9c361687873e130f6ab7b0b265eeae37c8188da89fc229d09f3aeb5529156ce75b93f532d52e89a0f15018eb947daaab445a1f6cd99b4c5e4b37737018c4967113b284d164af991adbc27f3bf81e2bde98ddb163f8bfc8b02ee59efb8ddbdf585dfd1457771772a48ee62dc64919901a7c0d75af34be8e0f21dadd2b66ad5ddf88239ef6d932f27f58ca94bec5cf1b46a9239910c12a292021a820b283ee3acb9b1d9bdd26e5c9c4e9f49562cbae872ff007ef846225bb73618f8523b56de0431046d8a3fc20575561c8eae247970d6d4e8b4294cd5cb4f760292d15ba8893d829d48fccebad8ab153cf72b26fbfa21a3b7dca394701bc8394e1dbe872f3c4f0595eb2afaf6e24e924d6fbaa0314053791d371a6a2ee9b8eb0556c0dd537d1961defdc9fdc3f35b7bcccdccd638ac462d0ca2583f92cc7728d885cb991988eb514f1ea06a2ad49db1a91af6d7b77780b169f71d997b911e66cc472b9deb7b6352dbc9a87d9e23afb0e93c51d08aa3aa811f27711cd96b9993f4cb33c808e950cc4d756a5a133d0f485a9e245001d7c742018782a4a6e2c605fe597c842ce5fe50006434f0f3a506a9cfd0d7c1feb53fe65f99d310e36e6e2d2eae576fa762a8f26e6a1fe6b8450a3ccd4eb955ab69bf23ea9933569655f1b7ec07e5a20637503c63229f81d4992c2f42b1ed3718c3642d72cd92b182fa6b7bb291b5cc6242955ebb6be1adfc65f29e0bdc4d3cebe01bb8c061f25df7ca437d6b0de416d89b311c73207553445e80f874d6a83ce3e848e5583c7272bba9e381237bb4486e19569ea4694daaded02829a8dab218aed0072dc171b34041850a0a90a40a0af8eaada917bb780f7f731261ef2d9f258c8a386c6ed8b4281833ad7af80f0d74b6d7ad7a185dacf4b14c71ac5adc64493049702252cbe9f82bf91727cb54d996d2ba85b90d9da5be3dee16279a55fd4ac6b1827c4f4d578f26eb433a1cbedef163de9ca33e29771dee0a56bb475922a884a555405ea3c352b65dae118f1f19dabb8837ab20b7dcec0387f500f31f1d0dcea556d061cb3642782d24b7904b08891f6134259fa500f13aad5d20756dca08ff005d86ce181668d9a49a912aaf935687f2d3502602e419e1f572410ee08640af20fd2cc3cb565588e8ff00b3cbbecf71ae1bfea9e4ab6d3e7b2b74d6d6ad72048d0c6876811a9ad093e27543c2b259bbfe9a96d6ceb0abd581beff00b9ff00189ec30b0e10d8de8ba9a49326628c9d8918aa23950054eadc3555ab7e6f4f80f34cad0ab7ed5ae38a2f7612e31deaacef1482389c0d8118296f0f7f869678d0852659d0bdc9b9328915c18d88053774603dfa83248abe38e59b26b1409bae137b46b40df3c6a58120f4a74aea8cb3b743a1dbeb5b67a2b746d0b4bdd2bd9e7f43398db0c8993e5f564b7fa7902f99df06cf2f33ae7d79774e0fabf3bda7c0756e36bf898da65fb65716c6de086f702a59b6496cc9760a93e6242af4ff008b56ff007b5938797d8b7db34c9af931e0e4f8e64b8ac78bb3cde2ef23b7d89f497f07d202a0f8ee94953ff36b5539558f03cd727da9dc30b94a7e03af0ee1590c57036cbacd8f9616b83147678a78255d854525262626bd2845352e3dd5acdc41c3cf83914ff4ef5b69e1031f1665fe8b057e524548f31d7c35ad6a646a02aaeb4d3103794f2fc071ec6b5f656e16da21d117c649187eea2f893a5669297a235f0b839b957d98ab2ff2f8949739fb8ae579477b7c47ff0007b16aa831fcd70cbfe27f2f82eb979bb83e94d0fa476cf67e0c295b37cf6ffb445bbc85e5f932cd2bcd73e2fea3b397f78a93d7da358af92d7d5bd4f4f8b0530689255f874228a6aa4cd5013c0f30e4f879f7e2efa7b335f08dced3f153507575335e9d198797db78fc851928ac3c613bfbcee4911afeee24b6b706ac90a09666f207a53f2a6b6539b67d4f35c9f6a71527b2adb7eba21f7b5bdecc77219171b9368ed72e49f469f2c773b454fa75fde03f77cfc46b660e4ac9a789e47bef62b705ab575a3fc1f932b8ef5f25e431731bf86f0344c5d92dab500db528a54fb08f67bf5939995ab3fc0f65edae161bf1e8ebaf9fc4aeaaecdef3ae5cc9ecb448f25e9d3d9d3e3a909331a9af5f0d4649781f54d7c74484189d032760f9367b0d78b738bbb9ac664fde85ca83ee61e047c46a74cd7a7e9664e57030f26bb72d5597a973f69fee160cbce98ae4a62b2be6f960be148e099bf85c1e88c7cbc8fbb5d6e37355dc5b467cdbbf7b51f193cb826d4f1af8afde863eea6463b7930e65eb6f6f733e4a651fbcb636
UPDATETEXT [dbo].[Picture].[PictureContent] @pv NULL NULL 0xeee07fccc35d0f0f89e1af7da9dbc90b3c97173d8e1b89c3702b773649eeaf0f99b9b9b2ba9a5ffbcc4692729bf3238a9b524207762596d3903fa71faa2ead924f0ea0a82bfddaaed6'
+N'835e2c4ac9b9881278df1dc364333c723ccdbb4f8f8f236ab78abfa5e296744656208207ce3c3e1ab78f8f7da3c0e6d6cf171d39ea9c172f763b9f081271bc6ac76589c784b316d12048a2d829b140e9eed7aec78e98abb6a8f36ef7c96dd62981c931f89bc99ef9e48ecdd58ca213bd99e1ad147bdbc358699153259370a0def13bd5346ffb59cba45de095a09e2b5b2e431ccb25ace4b2b6c5de91a796f53e15f7eb8fc9c54daed55e2762992d2958b87b93c4ec6f16de4a3130bbba807cc2f87ecd731ad19bf8ee2f5f8a109fd4048d83a13e2dff0066b90d1f76a5aed2d3f11bfb4ad7125c642c624679efa18e18a28c7a8d2397e894fefd69e1fea6d791e3fde168c54dcb46dfe414e53de9b9c371c83056a176637721929d5e525abe3e42a75665ceeda1e27063fa7aa6547c8fbefcd62bef56d6fae2c988a6e86465e83c3a5694d18ed65d192bd53d59a21fb87e6f2c7e9dd4d6993045375ed9c4d20ff8d769d4dde7aa4c4ab1d1b42cf35e456dcaae6ddb2704311c7d4db8b0863b7505c82c5940f9eb4eb5d3fab64b48441e1abea02ca701c9f26cbcf7f757d15b632089c5bd1833908bd1760a6df66a35ccb1a492d49db8ef2bd5c20aff00af78e5d703b6c6428a1ac225b7bb520237a9174662a69d0d3a6a0f1595e7ccd98b3d1e38f2d18a78fb8b3bcc9b5eda422148ea61955981478c78c743d29e1ad4aceb099cebd6b91b696816e01656b2731c7ac912b2c9380eae3703507c41f1d5d3a947d24ab259f7388c4086e0fd341f2212a3d25f23f0d49a284c5a9b1f656fc8f02cd0858aef276f1cab18083699e307a8a75a1e9aa2f592fc166b255aeb28eb5bded7e02392e2de03709034966ae9ead436fc8c96e6bd3c917a7b0f5d55fdb25d24f50bbce570dc4adde1ff000c8a3de4e2789e3d6d6af65ea03771ddbcbea36fe90485529d053e5d53c8c4b1b50757b173f27295f7c691f8a2a3ecb4b713e33297323b4cd35fc8373b1268aabe67e3ad5c77353cd7b871d699e2aa340577233f9dc1f7233593c5cb145288ec6d9fd55572cb222d022b78907ab7bb5a11e76fd106f945cf23b6beca64e430df59da7f9304254c81ff0095457dbf354ee6fd9a922130a46c1c0e54c50bbbe7713de058d314d0ed6b6da2b219d8f52c49a6df01f1d16c6b6cb2dad9c813b93c4b2edc756e9e092da1b9a2c10b46c19d4f832823c0ea3c77f2872b22b5f40470ded2f370b73259e26e6ef15b164949046ea0eaa587868b6453a063a363c63784c09c2636cb5b259e41cb2c36ae95013fc64f8ea994db71a1d4c38ece913fb85f830588c44c7ea4c2e5cb7c8abb546ef76a392bb8d14f9143d457e49c466b8ca8bc7b5f4ed23abc8a8de989507805af99d3b664aa71fe94e5d5684fe2992b99a292cfe8a1850522125c1ab451d7a283e5d3591a8b68fa96ac16bf4e9f910b98417171c94c8ab1dbdae35400203fcb07f8aa7cceaedeaae3c599ad47f70172b8eb67bb8d604924bb91d4b2007602ff00a7f3d6aade16a4127d0b379bf607bc1c378461393a59a458f578eee606556705e846e406a06b163e4aca9f93e874157e9b493d57501735e5991e637f69859ec61b3b39a42f77939c931d6315d91d29d756e16b1d656acc9dff009d6e3e1791d5b4bcbc491f6bd82e2163df448ac6e5ee5e213451c653e46400316afb88d68cfaa5f13370f37d5a2bc352a752faee7453cd7a5810004dc683aeda6865e8af78e64f1f8be52d777b6d35c42d6d756f1adbafce26b885a28dfe6a5402d5d41d754df4935f0ef196ad79afccaa192fa4bbf4966780c84c72c806e61193b4ad3cfa57a6bcf3b35667e85e7f1de4c0dd2aad64b7567f9bc0ba6cfed3b835f6220bbc65edddc417712cb15ca4ca0b2b0e84ab253f0d725f332d6d0d23e4cfdd3cfa59a76e9e0d2143b81f6ddc8f8de367c8d9dd7f51b4b3569a5865411cab1a0ab3020ed3403ddad38394b2595621b3b5c0f7a6a9722b0bf9abe1f608fc673fca96e05be2d6eae04ebeaadb598662631425ced0481d454eb7acd6c7e308f51dc72f0f6d7266692b7e9633d87783b9983989ba5bd9942d196e22912289478752b4afc757539cd6b270b370fb47252ad6d597ebfbc61c37dd2e552463918d0da9a189a34ac84fb1a840ebeed6aa771730cc9c9f656075dd57abf500f2fe438ce579937b91cb4b6b7370a5a0b69622f14118a6d5aa1e80fb85750cf9beabd5c2f04747b7706dc0a6cc78e578bf1605978a5f1bb16d69716d7f2ec0e5619402bbba8560e17e6f76b3bc2fc0e857b9e34be64ebac6abc81f9cc5e7f136ef34f8ebc9442e236fa589a6a3f9754a8d4a9c7b59c74f899f99df78f831efd6e9f8554fdfe44cb1e39cfef2d84f73c5f3167130dcb746dcb2907c0c88bf3f5f685d687c36d7547070fbc302b43ad957ec704596192de631dca3c2e87e647055be041ebac77c6eae19ebb8dcbc7c9a6fc76564cc5ae5a46ebfa47801d050796a326855491ab2194bbb3b46c85b318afac697766cbd364d01dea7f31ad1c7b45d1c6ef9c659b8992be4a7ed5a9d0f9ac4f18ee376aec3915dc54b9931872169346c55e291e1dcc9ef5dc2854ebb17c6b25619f2bed3cecbc4e4d6d47d5a4d79a65116d8f096c64905140abb1f2f60d712b8e3a9f61c99f75a103a77dd2920517c86a9b337d290813cba4bb5c4aadb48d6f2cf3c307a8a684091c29d69e2553beaa4f3feeae464c3c276c76757294a2f283ecc3136d6e3e9f94651ae828afd4c70cf016f3aa515a9f06aeba76e2d2cb548f9b717dc7cce3de55db5e5672995df3fe0598e279e6c5dfed92aa258678abe9cb19e8196bd475e84796b919f03c4e19f57ed1dd71f3f0ac95d1f8af2602607541d53c3e60f51e1a04ea585db5e6994ce9b3e31959c5cc96a3d1c697ab4ef6924f07ac8e7c088d4514f8ed34f2d773899dde9af81f12f7976da71392ab4e991a71e5aebf9164775d499f00f4a85caf88ff1d9dcaff7eb6cfcace17895b775de28b31673971e9ada325ca2ff009de9338a4b1827e629e6bfbcb5a75035558955b49b8d00781c6cb6bc113353947916796fadc47d7f9562f0dcd1bdf488ebabc0c69e376f56717365dca955fca80fdc0ca4b2f1e9f288773dd5fb5d163e6a64247ecd77725be56ce6e1a7cc931115a49ad4453b6e701490dfc4ebb8fedd726ffd453e475a9d3420e12e6ef0b908321672186f2d2e126b4a79346dbba8f61f0d537c530bc0d2afa33aaed791c1c878c63b330aec4be884c5075d8ec9465fc0d46b8f969b5b46ee3da6d57ea853e416dc522c7587f4f9dee2f5c335f02080ac69402a00e9e1d35c8cb4aa4a1ea7d97b665e5dad7fab54abfc0357dbbbdbdbf35fa924511a28e1df40dbdd89341ee507577097ccce17bced38b1a7d65fe40eeeb765b92e73ba59a7c63416b88a473c524ed4513dc328955556a4d081e5e7abf2e16eda1e1b1658aea22727fb5fcdbdccabfd5edc3db83f2fa2fb7a120f5aea55c4d12791316e2fb6ce7c4bfd2dc595c88cff00ea3c67f265d3db6f20dc85ce51dadee363206926c7b4d120afa96ae93529e6029ddfb342ac75137216e0bc54e4fb737ad2c6f1e5272d71093f2b916f50001e5ba8dd343a49653242d4a7792e12e21cd3193e4170ec0af83865f1a8d68c731060ce96e94e64976d9fb8b38fd18225f4a21b29d7a7fdbefd4fe9af12bfab65d02b87e5591c4e72d2f24b402781a3b84824aaef575dc87db460c08d3842dee224b438a737ce721c54d71158db5b9329b6352ed4a28635074310bdcc6f32e9cbb89da5e1156ccdbcaaaa1402ab3c40500eb4ebd2ba9e7da97cbe459c356796bb9f89df399b34872d346a49de2ce735a789be795874f66ed54d4336d2edd7feafca0ad7ee7f6fd15932fe9fa4bb6ff9b6b7f7eb1f3baa3d3fb4bf4e4f8a28fec3c25b8ade1eb43909bc3dc91ea7c5fd072fdcda727ecfdac0dddbc6e52fb9466131d60f91ba17164434648f451605dcc474aee1f2fbb5a91e6aeb42d1edb63209fb8022b8b036f8efea02faee7909944df46b1c88aab4fdf650bf86aec71e25764fc0b0394dd0fa2b87780ac97323cd4a7cccd249beac4f800356da1d49556a25e77bd975c93b776390c8cff5b77616c9676fe9c614a246280b01e7efd64c4e2bb3c10ad4d777996d706ee65c4fc32d307140b12b5a47233aa81bf70ea4fbf547172a49a8d4dfc8c310fc204bef6ce0dcc6d1aec10a8520785757e45a23470aee1949f36be94dd44df3329750db7ab501f2d57e05f91ea19b8ee462b31c56df8ecf1186f7172318195540951fc379f10c3c35cdc1c4b62cf6cadcd2cbee2abbc795a4dc342d4790b140e0cf1c2d13979609159a476f2069e2069bab766d19f17276a72d75fbc1d99cbc579f5b04bb96da45592278d683d43d083e74d58a9b5a7e253c8c892db324ce2b90b08f2963181bd83c202cadf33480800d4f957c34ef30e4a31e68b283a8bbd7ca395daf6cafb1991905ec31db210194551768236fb86b1f113d17a1d8cb8a96aef5d64ae3b27da5e29dcce372c3717e6d9ad8f5b68e8a439150493e35f76ba34cab1b87e25fc8afd5c5b63434f687b358ae15dc78b2404a3236f35c59bc6c47a606ea74f881a9e5bee6bca4e45b12a3845b1ca23f50dacc58fd3dc41324aea006dc09209ea3cb57575450fa88bc5ecec86677b06be43756b6f1c8cea18195c0f0dcdd07b34f32e84b03d67d4a7f309e95f5d941d52e24dbff000b9d79ecea325be27e99c391578d5b3f0a4ffda760f06c2ae3b84626c1d46eb6b2815ebfc65016fda4ebcf647bacdf99f9eb91937e4b5bcd94a7dd8e4daeb945ae01659571f6f67f51756d1c8d1c72cb3b90bbc29150157c0ebb9c05f4b0ef5d5bebe88f41ed3ecd8bb8726ff554d68969eacaff0084e43fa3f21b4bab2dd0ceef1da322a86496295d54c4e3d87a78786a3928af57b8f79ee8edb4c9c36de9f4d4d7d3d0ba7bb9cb389703e1d36563b4feab75712a59dbda3305124d31340ec41a2800d7a6b9dc5e12cd7eb092967c7a95c996f5c74536b384511dbeecdf2be7d91bccc4ad062318d712bc86d90bc69239ddf4f6c8c4542022acde1efd6ce572298b4aa6ff00c7567b9cbddf2f6bc35e3d9abe5af57e0bc97ac0f38cfb6ae37692fab90c9dc5a2a380d77792c30c7ec555dca147bbaeb9ab9f9af68ad7f093977f75f2d2b4d943f41617b19dc4b4ccdcdc604dbdfd926fb881ef18bbdc2d2a13a2d371a50357aeb661ee95dca667a7a1befee5a64e2d715eae57569ff8fb803c4797735b89ae26b0b5bd9949092ad842c5633e220422a149a79f86baf6e5aab6aed237f26fc1c75a5b74d9d6759f9a7a37b7f21a20eecf73b0a1aff31235a4302bfa56171b8481141da83d41b0f53d49248f1d4f1771defe56a11463ed5dbf3e38a595b23d5ff0aebf7a804643ba167cbad5173890fd482d247770a2c57655454a803e52a2b5ebd68bedd4efc85974674f85da17066f8add7c266aff00cc82703849e1f571f99b793ad0457aad6b253dff00ad7f6eb3fd34fa33b34cb9616ec6f5f2d481cb387731b2e397178b6135f41242de9cd64bf548c1c5370f4ea69f86a7869375271bbc778c14e3e4aa7f3c35b7c6597df67f1d7f8bfb75c559dfa34571161a479237f959165579029af810ac35daa393e55c7aff00ad45ea8a2b23946b85114744810f45f69f69d70b2dfc11f6ee371f6397ab2111ace74102b97fff00daa33fc3756c7ffdeaeb670bfa9f633cbfbc3ff816f8d7f33b7568541f68075dd5d0f8eb2acfba8c1c73715b1ca05fe758dc980b79fa73a934ff009946b173e938e7c99edbd8fc975e4db1f8594fda8a1d879f96b887d50c4e9f80404786f2e8b8de7a3cd1504da5de36c8b115a437d7404dff007175d4e0ad3ec3e4def77bf3d63c2df953f7d8e85ee344a5315b88063c9c4457cc98a6141f81d74faa678c6529df79a1872905c346244b5b13248ccdb42a9671b893ec3e1a8594c16d726da5b589407b9b9b9c4f6beca7fa949f0f90b1bc95d4fcd25b5cdd5b4d1328a0ea9212ad43fa0d7c8f4eb716ce9855bc25fd879c8abc8aabaa4813c89abdacb232b05692d449f31a55b603e7aeb4ce24fd0a28bfd67f114edf369686433dbfd46cd8528455814a0049f66b9f92e9594a3a15c6dad1832e26dd7b16c52005de37f88dde474a7e6505b108bb3edcf997adc76e78e5e759ed3d5bab43e46375f9d47fbadd75879f85febf334f0b22deabea8d8e0990fc4ebca58fd0787f4af80d76d87bcb1c260325879e17c8c73c9919da3259e26aec58dc03e1b07514a8dde7ae9716a9527ccf9a7bab3df2f29a69a5550bf6b1c3b6fceffd5d73979bd16b79f1b34704e1882ac59d086422bd0d35a5bd4f308d9ca6210f24b856fd064653f07d0c9ae82fc64dade4884d14e9127d2456e5170516543ff94587fc27a8d4593a953e2b39cc73d7498ec52cd616efb9a5bb8c6e9e55ab54a8a80a86be2c4574d248836ec852e5fc6f3786e492d85c90a6876484067092ad410de551e63e1ad09ca39974e8da0cc1d8a65c559dccdb9d7268ac9f4e4cc2ac01ebb41a78f9ea96ec6ca2c6d203de704bd1cde3e3a51d2f24891acf7b852e8a9d06ef0a80bd357514f56537f97a2918b8fe1b9861237b3b4b84b78cca43ab6d957d53d0d4d0fb3dbad7fda3899d0c2f9d556daeae4db2f0fcc65799f1bba37b6d7d262b29691b25b952c15ae2327795f307c3593355d743a5c4caad92b6e9a9ddf732d9fd6cb13d5aeae25ac0d427e58ef64693af80e87559bf6d9eaba2ebf6ad0ab7ee3e52f80b2727aad9dca9fc238b58f97ac1ea3db4a164f8afda533d83dcdc52e940f0bf98d7c7f723ff0066ace2fe8391ee6ffe4fd9fb59265e3984ccf73b3099188ce3193da5ec00310164f4545580e8c283c0f4d697d0f3cbaa1efb7b738ec372ff00ead660a5f2cb348af212cbba74546aa9e9e0a29abb15a0a9a91ef92f26972f3c3777e52496de331c7b168b435ea47b457a6ad79049415976a3edfb2b8ccb1b4cce72c6cf16d214db700833257f76a6953acd5c76c9aa2768c6e1b2ff00c6f6ca5b5b26bfc21facb61b611564f916314aad0f51a55e363a4edb4b2fcd9b25a159415bf7931d716d137d4b2ef90eea03e35d17f33670ab09b299ca6465c664a3bb8d56692dc92a8fe06a0815fcf5973e15971ba371268b59d5c8a51f3dc0418fb9b3bdb1619d9ee8482f108dab091d569e35a9d68a6155ac7a687072b76b1f62ef6da5e491dba03f51700aab115a9a13aab263f97d054c4ed6801f26cb646db2b736457e78d8046f0f883f1d4e9853861929162776f2d2ff003fdcce3d65e9d1aeb216d108d4f8859012c7f00751e5254c367e84b053e74774f7970f8ababc9b16f2a39bcb436e00f0f956835c8c6f6bafa1d9e33dcad5f3391788f71f29db4e6cff00485a536b33c1776e0d0b46ac6869ed1ae9e6c2ae8d74c9154ba97de139ec3cc27c5f27b7885bc573290e9b684b47504b7bcd35424d68fcce7f252defe017ee224b3e0e17b395a3965fe5c613e50377465248206ba38de8ce6d96a2976e3037771dc7b2492568d2d67492589f690c6152c00da00ad7aeabbd9b85ea5b8d24caa6ed226e4be9cbfe4c99002427c0219c06fd9ae0f2ff005de3d4fd0dca6d76db35d7e9ff00fa4ed245410a05fd3b4014f60f0d79baf447c15f53987ee045d8eee65cce08056d843ec30888508fc6baf4546be8512f2fda7d2bff00afa8be9e6b78ee5f903bb4184feabdcac35ad0958ee3eae4e95012d54cbd7f1035467b463676bde5c9fa7c0b2f1b34bf687fef36fa312f1ec40f4d9e59ee32126ca86db02045a8f8be8edea31dedf047cdfdab83eb772c7e544ec14fb66cce3a6e08d8a4212fb1b73334c80d19a3b87322494f61a95f88d7379d47bf77832ef7471af8b9d776e96f997c06eee976c71dcc387c98db999ad8c0df530c814489eaaab28de8dfa851b55713956c3795e271b8bc8fa196b936ab478594a2aee15cbf98f69f1ffd3392d8cf98c0c6c4636eb1f49363015f486f2b453e4add57caa3c35bc18f94f756c93f193afc9c18b9b6ddc5a45df5c5fb69e6bcd75407fb73c56532dcf8c6627b5832135e5e5ed987dd101217913a0f074aaaee1e5d35afb8d2992ae3c2219b7ba76c7c3edf85e5d32f4fb3ac3f8178f3be1dc7ac787df5e5dc2c171b6f2ddfcff32b1854b806b5f31ae371f8aef91565a970792b666949cc5dc3b38b3bc5a3e4d3c31e36686fa1b294dbd764a26a2b3814aee527f66baf868b1f22d8aae56d9d4f59c1cd9b859f1e1b5a5647594bc372d3ee0071ec3fd56563b192f2585af2510dbcc1566504b6d02446dade75e875a25599f4bbd7271f1dadba76a9d7c91d1fc5b8e642d7036f8d96e2066b2558d24815d55828a548624d4eba36ededa84cf8a67ee0f265b64b2fd4db2465ec7935a632e1e393d6b6586433287dca630a4b02af4e846aa5c6e463fd2e57c43167c792e9445a74f89cf8f2ac92332a84566242a8a000f90f76b2d99f67c3575a24dcb8313a897027988ffe09bbd93db9fca55d6be17f511e67dddaf6fb7c57e676ec26b0a1ff000a9fd9aeed7a1f1bb7511fee2e156ed55e93e293db30ff00ef00fefd51ca5fe958f4bed1b4770a7c1fe4736bd7e3af3c7d951850534240c0dca0c838ce48475f504f657029e3fca900afe1bb5d5e1bd63d0f947ba935377ffbb6afdf5ac7e4753771219ae22e3f490c4d1e4a1b8929425847693b15ebedd74aafe53c5bea50bf7099db9ccdc4d84c4b46d2e2be9fea246457d92ca5cb0620166da94f94fcb53f1d2b38d0a555666d782062656d319c02db176cb2e5f242100c30c4d246d3df7a8a0171f255fd6e8371d74b8d755c3e6e4e263c0feb59ca4a63ee34725e13797bc461b7ba82782f208a38ad23bd7a0862029b1f69a1614da4f9f8eb7aab7455b28f215322ae46d3942b496ecaa4c8b4f46332bfb57602801f89aea9b6b7f823655e842c5e232b92cb259e3e09721793504105ba34b33b6d2db5550124d0796a2ac96acb5a90f7067cddb66a1b9c76f7bab56ddb412829e0c1cd3f491d0d7472f352989ee64f8582f932ad9e0fa96643ea4d199a342ca00772a090b5f69f2ebaf0f65a9fa0f8b9a96a55cad5684fc664321678ebfb9b2664b98624742a377ef75a8ebabb03b2968f3feea5478f1eef16ff0021cfed8a7e5393bfe457f940c96f3258c36abe918518acccd23834f9882403ecd6fc1776ea7cf3974ad5adac3fdc061fea2baf68723f23abd9453a0b9953b824e3d801f88d226bc857e5d0b9b76b88c6e6285187bff749fc75068954a717b9dc8f13859a0e3f8b8e096cc52fee997d53112c54b15141e23c4d74a96aeed433d6f5a4d452932bc833b7ed717d70f777b74553d594fb4d001e400af80d6a392dcbd4b933d99c1f0be2b6d18c9fd7de5945b6ded266044ac1153a1527d3414aea392b1d59d3e361764d25f6cf42a9ccf7032f97c9c77cf19c864d4158270852de15507a451af5e9fc4dd7f0d54db7e86dc6b0e05fccfcdf4fb867eeb765fb93db5e0f86cef299c4f71cca6964b7c3d948498d238d1c4b232fcb560e28aa3c3cf57e3b5ab589d0e672f35335f746be601e2f9692cb2788bbb7b7b8c55d64f376042dc142c238a50eac80508ab0af51a8e57f2b689f6fa2b72295b2d1d97e6751c5dcee7114c928be77921f50a33a46d4329ab78af99d72572ae7d36fd938ae56cebeafc007cf794e732d82956fe5132db432fa54555a07515fd2057f48d46d96d7ea5fc7e0e1e3a6e8a260e749f3d91b393196b697135b24b7772f2ac323461cee880aed235b786fe53c2fba135c8d7cbf68ebccf3cd6bde2924591e28659e189e8ec8a5dad82217da4542b90687a6b4da61c1e7d426a4c39066f30bcbaee48aeae2284dd3845591850a2a9f0068075d5796cd2d197f1aa9f52d7ed3f21cfdaf6a2fe7bf2d777793ba0f692ddb06945b46a12a81aa426eddd478eb5606f64b29e4c6e8406bded3f31bfcdc56191b8bdeaadf49307631fabe46a7c352adace2a9e850aaa65f52ddecc719eed708b5bc4bacb1c9c53414582f0134a0f188d7563edea96dd5277e5db228b39801f759eeb2364b3c8e52645fd07f49f6eb334de8cd14e4bc7d0a7b2a1274dee6856aadf10750da4adcb6c52e5387b192e16f63a7add11d09eae07811efd5a9ca31d9eb3e612e318a77ee1615501df2bd48ff0008424eb3e7718d97e153911bfb95c56e13985cc70db7ab2cebea23509da14f53400d75a38b5dea0ab92f6b22f6a795d8f0deede1b92656092e2d71337ab2c70a92ac0a903693d2b53a39dc376a3a495e0ce9392fdc5f777b9dde1ee34392e2580030b8b96b7124cde9ed80f4237781723ad06b999f0528b6cfcc747857beedd1a78883f73fc131bc5f9c4994c85b4a96996024531a86025fde04f96b4f1e6f55e8746f9f1e19dca67a1647dbc6352fbb5d6173631b344259de30de202b1ad69a85aa959fc4e6f233ac96dcb41af925b5a4fc6ac5afa616a58cc01e8885909a124902becd68c69c3325da942ef686109dc1de2432a2433dc9ddd29b617a10054797b743afcf5f89662d5947e4a5f572d375aee91d8ffc4c75e7b3b9c96f8b3f4c71f1a7c7557d1d52fc0e84ed1fdc7e06e70d6d8ae5332e3afed51208efa4a8b7b8551405dbf71fa75af43edd72f2f0add69afa1f1af70fb73370323bd53b627d1f97a5bf78e1cc7b69c039e4115d5c9171246bb61bdb09577ec3d76965dcac2bed1aae99f262d3f0671bb7776cfc2b3b61bc4f5f27f61078df6c3b71dbbb4bacc198c52fa6cb2dfe4a5506387c4aa745001a75a0a9d3df9390d5529f444bba77be47321e6b4c7d9f81cd3ddce756fcdfb893662dd9d30b6b1ae371cec0ab3c3beb2cf43e1b8fe9f70d763e9fd1c6b1f8f57f1f23d27b5fb7e5c5c6cdcc886ead53e1e658bdc6e037fc62e2cb95f048fe83fa7a082fa1b54dc8d0d052574fde534a49f83788aeb9bc5e4572d5d326be471f81c8af22ff00439367b2dd2cfad2de7af83f1436f6cbbcd8fe638abbb196dfe8333611ac971121df049139da2489bc695f156ea3dfe3ac7c8e2fd2729ca667eebda7370722ade1a7fa6cba346de5787b4c8f6fb316b7
UPDATETEXT [dbo].[Picture].[PictureContent] @pv NULL NULL 0x0018cda4d2aee1fa5e242e8e3e045755711b5917c4c78f3df05eb92ae2d572bec15becf2e31b2c990cadbdb33dd476f044cf291b04973f39db4eb40a83f3d7539b758d6df5fc8f51ef0e65b3db12f07556ff00a8b67ba7c9b8b59f6f7252731922b4c14d0fd3dd4877ad1663b0005016a927cb59f88f2db22d8b55a9e26c9239a7b97c7f09176c2c462cb3e27fa88bc81d98b9759048636763d4d4b03d7dda8f133ddf22edfea69a3d9f6054e4f70a3e45b55aa9f1b2e884ee23159a646deeee494b6c6c86f6791412424343d00f69a0d7530577591f4aefb91d78b755fd565b57c596d76f7bcbc67359'
+N'338f6dd8e99d82db1b9650b31268141f263fc3aede2e4d6ee11f20ee9d8b37131ac9669af18f01f336ae38edf91e5673f4ff00f66dad47138bfd6a7fccbf339862240fcb5e719f79a7436742348b019cccff00fa3f29fe1785bf29175a786ffd5479cf75d67b7dfecfccedbb4606d213ed8d0ffdd1aefd7a23e316ea579f73b958edbb7a96648f53237712a8f3db082ec7fb359b9b68c4fd4f59ecbc0efcddde15abfc7439e5bc75c03ebc60d4f01e5a6205a457f90e6f88c0582adc4f9abe8ad9e19095468980ddbf682428ad49f76ba7c4a7f17a1f2bf77e54eb6c2babc9bfeeaa82f6ee7f3cbab84b6652f82871b713c770edb5ef0df45633136f021057a9608ae412c482a3cf5d45a23e7cf23ba7fc3e1eb2549dc3e3705af1bc659de101ae63f56f7757d49eec9669249181058ee6028750f52fc7454aaaf91a9249f1596c4e161575b56fa6b89d190ac65e0a1511378508e8d4f065a6ba5c7c8eaab4f372706b8d3b64c93e667cc39cdee73945c5b5b938eb3b7212d924a3c9244050d7702bd4feef5d59ddb9b971e8aba799d2ecdc0c1954dadaf90b79cc2dcc78abc788bdc997aca4f57a1a02453c801f86b9fc2e7ee9adbab3adceed4a917c6b45e0347da68e4d69dce9f916160b5bab9e3f6b7126cbf91a28c1bb8dad81465a1de03315d68e4e455497a99f83c3b67b34bc1160775eeb851b1b6e458ac0bf119a174b0c9451346f653d6bb670e817e7dc486247b35cbcff00ea2f193ad8f8b978bfa92dbe68178ee437d6b859ad2d997fa75fb7a93d157702074ab52a47bbcb5875869789e87b5e5c5f5e96c9315e8e612fb09fdbebe8e7c8dec4a8de92408c66a800d5e9b57cf5a789c7b51cb23ee8ef38796ab8e9315b4cf997bf6931b31e358f07a802e5d81eb406efa7ed1ad28f299525671d053e691b4b9bba95bc1a4723e00e864aba217272af015f1a78691202de8a230f1a7953a7c748914f635f1bc73b8d95b6b99d041968c3ff0032810bb39665ebd3c49d64e451be86ee3e4ad7abea68e4bda85fe65e6048649aa5ecd881b7779c47c08f71fc352c1cbd22c64e5f6d73bb1fddfb82d88fb6bc1a5b43fd732bfd408a19a3b665b744af53f3b6e6200f70d6f581bd4ceb910a02d8f9781767329777194e3f7f1dc722c33c18196e90fa1f4d93736ef72924c4900c3bf6baa31f678d43b56aba39d0cfbed9215bcc11c93ee0f1b98ba8ac97172c5fd06c462ade5bf2cc6cecc6d056352596876281e7acf557b75728db95e2a270a1c957e0f2d25ff736c256669d6e33505d8926f9a43ba65a82474a6accdfd36bd05db5cf2b1bff00897e6759e3b8bcf2f2d83077ae2c9ee258e2964aab08d2550fbeb5a1f94d7c75c6a637b9559f52cfcd4b8f6cb4f9924c19dcabc6b83959dd1626db32ec4fd204485001f82ea6dcd991e3536e0aa9f2fc4e76b2831b7bcaf09657d31b4b46bbba32caa2add7d3214501eac5428e9e7ad9c45f29e17dd0e793f67ed2c5e4b87e3b2f26cadd65b1b74f3fcb22c31ddc023b799546df995b73ee03a2951e3ad68f39697d487798fb2b9b49f249bfd69a56b8687e46589e4500c6ccac4d453cc5750cb55125dc7b3982c4e1fc966ca713b6f923133d8c768d550aaa90b3ad169fa4d75aeb7dd54539145987ed3ba792b6b03ea5ca5c4a17780a3704a75f1d18ebf3a159e819c1fddedba5aff44cce25b226e01fa696c549b94603c76f5a8f6eb67338f677ae4a5a23aaf3238f3d76badab3f0366731995cdf197cb438cbd861452ebea005981ff0ad4eb367aeeb4a12708a72cb13717371788e0a08e4f99482187e7acadea5a92db2814dc6f1f2dc96b9794344c4aec02b5f79d576bc17e2c1bd04b0662c7f24b6cb2ab4ad6419635a5055852a755657bab069c5c754b4b659ddb5b3e2dc81f259bccdd3636fb1b1ff00d3c2088d6549050d6a0eeebd29ab78a9bbc7819f9a956b282d99e2bcb3098f4418d86e7112c7ea47fc88e7802b0ad0b28343d75b56d7a9cd4df462f76b3bfcdc3af25e230591b74bdb877805a2ef94c931f0da3a9ebe1ac3cae3c59e4475387c950a8d0d7f71f9de1edda5b8b3e4844976f1aca930a7ab14be2011edaf96b370ddb749bf9aabf4dc867ed0578d45f6fc3d5be31dc4a2f3e8e5d9b524590b5051bccf869ddce47e52727271f2ec56dae3e048e5b64abdbcc75bcb2c681bd76da4316a2b13b94807c07b75b304c37ea5792344c0fdab847ad92bd867fab36588baa4752cd1c8ca1140269fab71d1bbe74de894b35712a9e4aa7e6bf32bbb7ec73b64063e7cf63adf925c47ebae2652cad46150a64fd218fb35e46dc8b59efdaf6b7d4fb42f79e14e2b8eef1d74775d1012e787f218b8fcd95f43ff0086d9dd1b096e03295fa8fe114353f11d357ab7cdb7c4f418bbb7172deb4574ed916eaaf344ec3718c98e2cf9c87230e32142eab089e682e2468ff750462849f2a9d594cf76e16a798eef83b4ff0074b065c137b78d6be7e7b4037f25cdefcd7f3cf7e57f48bb9a49c03ee12330d59fdc5fa271f0d0e960f6a76dc36dd5c49bf597f983664424a91d0d548f7786b3b7a9d7be351b6342d0edf7dc96431167163f3f62f94b5811628ef2d481742351b40911c85734f30413ecd65c9c1a5dcd5ed7f81f32eedecee452cefc78bd7f97f897ef1a1fbffd83b2c6cd3da4831524ff0035c2ae3a586567ff0017a719a9fc7547fb6721f93ffcc793cdc5e4d1edbe3ba8ff008595ff003bfb8c4cef1bbfc2f12b6b88adaf62686eb2b7b1fa1fc893e575811be6ab0e9b9874d6de1f6fae07bb234ecba25e7ea6fe1760e5f2dcda8e98d6b66f46d2f048b6bb11dbdbee1dc3d6de1b98eea7c93ade5c4b08ac2a0c6a8891d4750aa07cde7ae472792f25e7a14775e77f779b7c6d492497925d019f76b88e439aed4ff4fb05fa99cdf5a4f3c7b952b042f56237103a1a1d6aedfc858dd9dbc9a32f06d5a7231dadd2ae44eee54b89c57642f52e76ed6b0fa3b743e2d74fb5610befdc011f0d65ed1476e4d7e2dbf816f2725ad776afea6f4f8c959e12d4a76ef905dc82b2470dada83fe29e505a9ff26bd2f1eaa6ed7823ea5de335ddf8b8edd5b97f657f7b12792deb5ae01da3252e1d904054d184aac1815f78a575670e9393e0723dcf9eb8f8564fada123ac73bc8462bb55f5998758f21738c48da36203c9773c015940f33b89aebaaefb69b9f91f3eed5c4bf23954ad54eaa7d1239d40f0d79e6cfb85541901a09490b92d8cf7982b88211ba6650c8be156460d4fd9abb8f754ba6ce4f7de25f93c3be3a7ea6b4fb0eabffe7276d2cf076f3cd97b77616f1930c24cb36ed82abb5478d7a75d772b9a8ab2da3e4b8fdbfcec97dab1597c74451bddaee75d732cf2ce10db63ac818ace063560ac6acef4e9b9a9f86b93cce4fd570ba23ea3edfec95edd89a6e6f6fd4ff62149b58cf4069bbb882dadde7998470c40b331f20352a55d9c2ea67e4f229871bbddc55751c3ed178b63f907389f9add46d1be220960c7c6c08567958c7ea8af43b5372f4f33eed7770e2d8957c8f87776e7ff0079c8be588ddd3e038f78e1e376fdd6e32b32a4195ce3ddc705c4d1ef81a5b7847a624f9968c6bb430ea357d94a3916c6b76e5a382aceeddb5f66aff177ae93478e97d4b787e91814902c806f0c68eaaede076548a751e3a248bdefc90cdcefb4b85c3e6ec32c1efd640512e229e6668097da18a0a5147b003aef53834aaa5e5ce879dae58dd44946a22f3e992eaea45b0892d2ca063e95cb8dacc57c197cff001d6ae4515d446859c4bbc6d39d41bc5b9a436f76b6b96904c05025e42b4ebe14917c0fc46bca72fb76d734727b2e0f757651917dbfbcb13b6f91e2dc73fa8ceb0cb0c39022491a23b8948c125557a52b53f0d655c8778567d0eff0f1e3c0ecd28dc0eef0779ae337838adb15651478fb491647824a3acb6ea0a94703a106bd46afa3521dda8ed83e5f301712e7b07d45b5bc5602cac1d446c3d77b81b9bc3f5f503ca9e5aaf2d1755d4e671f0e54b5d50fbc3eff008e6072f7992bdb89e6b2c9431db7a56f1ab9b731b162d42413efd15e4b886536e12995afa1d47d979f057ddbe87218d9d2fada4868248e8bb7d37795830eb46f98541d5f4d518f3cab34d415d72e56374f2786ef518ffc4da193af413e32c55bcc026ba4580fc8a0eb5f0614d008e7bfb80b54879b8653b927b746f0a50fccbfdda74467e55b4481580ee5e730b9116b24ed2e315d16489fe6658fa57613d46a1978f5b7c47c4e75f1c26e50e5dc1bbe1b93681ad885ce28044b1f48c46056931e808a78798d66c17bd347d0e9f2b0d32295d4d679b72f3955bee4b929a68ae2ce5925bcbe8c5dbdcc56cb4f4e0f5f7d41a80af4daa7c3aeba33ba0e334a9d05fe0f241986b882381ae6db2134aa6275334cd2312c9d57af4f70d3aa4910b59bea34f62fb1dc82e7be5866bac45f59e3319791df4d34b6f2243bada456446675a7ccd4e9ecd42ed32dc52ac99d818cb2c2e6b2125d5ed95b4ad3f209ad9c346adfc98e4144a915a6d5a5359eb5addcb5e27a4cd972f1eaab5bb5fe9a7d7c5897deae2b81b0ecd499182d6386ee5568da7504311bae8379d3a855fcb5564c55ad252d4e9f6de766c9cad8ecdaf2ff00a4e34c88b74cb58c9231a99a50a07ff6a9d49f66a7c5fd271bdcff00fcafb3f6b1b39c6671573cf6f6e2d6e52e6d25c8211244dd1a144405ba78d083ad291e7323927cb90b06b2e4977653abb3cd25c42c9505639a740add40fd42ba7b656a45e48e8cb37b43c4463bb5b8b966335d5e646d864268d6aedea5e3b4c8093e0046c84fc75a2958a84c8b5c8790471dd1b0b51e951035d15002b3fbbddad1c5c3b5cbea42f7903f6ab999b6ee937a803c52c7f4d1961d4313fbbf1d6879d2caa7a212acd5fa961d977bfba586e59758e823924b7b662557a8fe5fbc30a6a5c9e652b6889447163b35ea31c7ce705ca2d677bac58b0cf3c676cf0a05129a7ef81d0fc758b3df0e453d197e376ab01e03b7996b9eb72cb6f1926ad407c75cc6f534ab3095c76bb1b1d76de1141d4d05069ea2dc22770b376183cba636c58de2a2096f5cf5ad410b12d3cc9f1d68a5214b29bda5c13fb4591fb8a8627bbc24b2c38899895b4b89035b05af80f5aa0fe1a9bca9be9a15ac6ebaa70cb038cdbe5ac6e6fb93f28c7da5be690fa56b710a2eea30ab302bd3593997576ab5e8743818dd3764b3d595977d787f75f94ba5dc56d2dc6103069842a5dc027f5b003a803d9ab302ad57a94e7cd6cb68f01ef86f3b8b070e178f59c74592e21b6484f450a053c3fb75e76995fd4b2f13eafcecb55c5b2545b6b485f71727354b29787c4e2248b62cd1aab9229ebd140dd5f0a9d7a1c6e133e496ea2771397fd3ddb7e619ab7a130c36f1c5b80ff33712454788a8d55653ba7f959d5ecdc65c8e563c7e16b0b380ee3f6a64cedd727ba79249b230a8bec1dcd9a5cfa93c6bb57d2998108b5f1ebaf26b064b456524bc67f61eeb9bda7b871f17f6d8f1b7f3375bd5e8e7f9bfcc256d8bc7725e05c738cd94f6f66d9ac95e65f250c6ebff004b6f116e8457a51480b5d5b6b3a3c9749eb15afa997eb64e0f3feae7f99e0c7131a3b350becd467e476781cc76e73588c15d63eeb0d88b4866c55b58c9be78dad4932bcc280d5abe3a861abc77aa69cb996fcce3f17b8e6af329c9c8edbad79729a5b594f76c787c1c8f9bd9e365645b76632dc2bb9469218cd59129d4b11ecf7ea7c9caf1d1b5d4facf7bee0f87c4b645d7c3e2fcfd066cf76cfb7d92e4598c0e2eda6c36671513dcdbedb81756b3c4be1bba9284d47ca4d46aafa96aaabb3956f483c2f0fdcbcda61ae7caeb7c7bb6b8fd485eed476f93356792bcbcb44b8b3b74d903c93bdb3bdd20327a30955604b28f9aabe1e1a9e6c9b6eaa76fdc3dfdf1698de2b256b6b0d4adafc5f88af61c3f93e7d274c3d84b75e9b92e23fd11835a297720787b7aeacc996b4d1b3bb9fb9e1e363a5b3dd26d2fb7e0885271acee1a796d7276b2d94fb41db30a556be2a7c08f868a59594ae869e2f370f26aad8ecacbd0dd85becf63db7e3f237f8f55ea16d6ea78a31ee0aae17f66acdefa349fc52397cbf6c76dcd676b624acfc9b5f9335731eeaf749ed96ce3cfdf4e927cbe8ccb15c9353e037c65bf6e9bc78acb5a2fc8e0f2bd9dc5c6e71dad5fb657e22fde725e6b99365067b297193b6b56f5a2b591238a14954150fb6345ab007a57c350aba63518eaab2747b57b4b8fc7cab35acf259749884fcf419331796789ec35f5f5c9283239ab7b552054910c464a01f13ae970b13b63bc7a1cdf72772c7c7ee189e47a568fef642ec076a72dcf399db6772d6af6dc4f0922cd1acca53eae753b9516be2b500b91d29d3cf5b30e1545b5757d4f09de3bb5b9d915a22b5fd2bf6b0d774e4e4479d64132cd23cd1cee220f5da2024fa7b0786ddb4a53583996b3bb4fa781f4af6fd30ff6947892e9afc7c645e507590ef990069fecd007d46f66819f51bfedd02678c29e3d00f33a01b8d58372dcaf058f43eb4eb2483c228487727f0e83f1d68c5c5c993a2387dc3dc5c3e2273756b7f2d7563276abedfb9d7727210e439043371de171309407063b9bc00f4588350d08f1908a0fdda9d753060ae3fd3abf33e69debdc19b9ee2df2d174afed6745bf1ec3f197c6ae2acc5a626c6d9b1c20b642c228aa1d0ed1563f35771ea6a6bad51079d6e4acfee43b799ee7bfd25718131f063a695dee6f7746efbd030558c55b6d53f7875d3dda0b6b614e396387bbc6db59e51617ba68e3640374511f4c0255003d056941aaacda25b64aa39dfdc5e7ef731796192b185e3c65c995bd0768fd45b6969b68c1a9b879ebd064e77ca94791c4af6e55b37255dcdfbab86cc5fbc896d258239256227d40953e15143d3e1a5979b4b2882ec5c3b51b722fdaf27c525f4524b2eeb65915e5500ee28a6a547bceb05f227d0db4ac3525bbc839563ee6392fb008e70f71b4da4f70be9b3c6f50bf29f78a6b85931458f518794aea4f78e730edfd8585b4190c35f9cd564496e209963864864fd348e40d42b5a1a0d6ac75512cc3cbe6e46f628da3c706c1f6d86683adbdce2f26d20112dfc31b28629b82c74223de475a95fc352b567a15e1e7da95dafa7a75f80d6fdbfe372e566bdcbda3df4b7207577689a323f7a3316da13e67ad747d0465fef6e9e9a177f6338d5ae03b4860b79e6b95be96eae15e66dce11df6229a002aaa806a54aed0c991e472c4fe7d1c76d8bf58926b58ea057ad6bd00f1d0595113167d679850ec6242fb69e1a458c1997263571278a93e3e1a18d145fdc15a2b666d2e2a48301dc3c41d8e7fb8ea7431f2dea8adb3a53eb5d97c24da47c08d4ccb4e85a6bc93b7363c2f1f7bc930b3f21ce5f09f647603e999e0806d5691d06d0000013b49a6a9ae2adb56742d9ad4d115873beec722e5f984bbb9115a45676cb61656966823b7b7b38c7489147b492cc7cc9aeaf4925a199eae4b2fecaf974fc3bb9f67c872a9f4fc7a412db4d3b8a6cf5d0a1913ce83cc8d294dc035e277c17b1bbb782fad644bab7b9f4e58a6898323216146047420e86a02ae58a1c524418fba707fc9e497c57dbf241249fddacb8ba3ff00999ea3b82f9abffed5409f72dfc9ec5cf08e9e8cf227e07ea4ff007e9723fa65bd81eee77c57ee38b7fa5dbde646c925a86f52700834ea654d1c5fd063f73fff0029fc3f6b275d718c6c52c8eacc7e7614ad7ccd7c35a8f2fba091842471fe42a54b521b75048f23374fecd3133a8785cd88c8f02e3f7b027a4f7580c5b2d46c23d288c07a03d7ac7e3ad955a0e59cf79ebafa7b7720979b6fcc5bf56ed6cb5d2522f13576cb037f91e536171fe5dc2cf1ba322fe9286b5a7e1ae366b4a668a2d4e96eebc76c7e8f3112449f5b6ff4f7326d1d64514ea0751523456bba8bcd03bed6e3c44ab8e379b871d0e5d2f22782d86e489142b0a9ea2a0f5d4575881be81bb4b7c95e63a3b84b8f463906e01549d41bd742700f6b28de464ca5f4922464ed4b6056a3d8d4eb5d0e45088d8becfe739466d72e984bb3c6ec0b2fae96eecb2b47d769603a93a92b27a2642ce3a8dbc7f87f39ce5da9307f4cc4d9ca913c4d58d88f058d57a52ba4dce8892f3616ee971bbabe482cfe9cc36ee1e3582370d1a045fd458528d5f2d431a8b7a9b33b6e8a169021f02fb98b9e238db7833764322d6974d62b12831b108768de4f4208d6e744a60e5abda17899e5783dcdf77af0f9fb08c0c4dce4e19e6b78cd1e149186e5a74e82be235e772e5a5ed2b4727b3e2fb9ab93856e3e4fd5b6116bf71f077d27174b69a4f4ace39e69286a432ab5155879f43aeba6d4c1e5613815394dac969f6f17b6f6e84dd67b2715ac30c62ad21428aaaa3f03aa72da315dbf81ea7da34aff00b863b3d1555acfd21151e6fb4fdc4e3b8f17d95c6bdb5a332a1995d255466f057d84ed27dfae2db8f92ab735a1f65e17b8383ccbfd3c5913b2f0e9f7116f71f94b558e49a29edf78a06923640411e4481a8c383756f833a75f96cbcb4649c46732f8e59058dccb67f531b413985cc66489fc51a94a83a49f89979ddb7072eaa996aad55d179412388f2dc9f1ae430666c1637bbb4de116605d08914ab74a83e0755e5c6b228647b976ea7338d6c2ded4fc5784052ffbc57bf4b7b1e1f118fc15e64d592f2fed55ccceaf5ddb7792149af8f5d2ae1aee56b3768e92788b7b3723db8f2679c55fe14a3f6fe234f13ee471eb3c6e159308f1717c25c456872f3cc6378efa78e93c8f147b83f427c7ad3d9ac97c2deef9a6cf56bf2391cfec7c9c99f26ebd55da7b31f56e8bf97cbe1d410d359e7fb5d75c738d6421b2be872d7174d0c92fd23de5a33b18f6b1da48a15e9eeebab7fa796d66a657c6039181e3e471f3f328fe9ec49a6ba34a355f8c08995b2cf58dcbd865ee4dddddaa24607d47d508d08de11581603c7c357d6d3598847b8ed36e16456cbc54926e1c28e9e85e6b88c2458fb4e34a96f75770e077ff004a92cc0335c3c5bc482ecad1083e235cfc3670acfa3b759fd87ccb95cfe4bcf97352d6516eb3f2ad7c7cca56eb8ce386070970b6d1cf96bdb9b99d99ae0da6e8a0a46aa25a8da371ad75a33646ad65d1285d27f03d1771eeb9326674deb62a567ca5c6a69e3788e0f99b6cadfe605ee3a7c63bddcf756b38bf4f4a59c4291a893e67209ead5ebe5a2fbd5eb5ac6be7a7435ffb872fb761c5b3664a64d2a94ad5fc4b0384f1ec2cbdbdc2c725baddc125e5e5fc06ee3466a094c51c854ee0adb57dbd35e8b8548c5f1678ff007172b266e65ad92bb6c925b7ac7da5858ab8b08225579a285545006755007e246b6ad0f3ae97b744dfd80dee1707edaf33b08edf2b7b15b5cc1fe45ed9dd4705d475f20d520aff0085811a1aad96b068c16e660d71efafc37211ed7eceb83cf213feafcadc293d1639edfc3e201d4561a7825f716dfb8f3ff8af93efb04a0fb28edca81eb65f3b3934a1fab44fc7a47a97d2af92fb8ccfb9f27ff72fff005588b7bf6b9d84b394c773c8f216d2a1a34726562561ee20ad4695b1d1758fc0d18b3770c8a68f235e8ec453f6dff6eed2044e5b7c09f940feab09a93f14d2db8fd3f02f8ee913197fef0c597d98766650b34b7596ca42d4237dfee8dbf18d0547e3a9aa25d0e5e5e5666e2f6b3f8b63671bec7765388a0bcb1c263ecdadfe737b7a04f2291e7ea5c16a7e14d4b6af129a2b59c554b7e44bbbef176c2090a3e6ed495e87d32d27ed55235079f1af1474e9d839f752b158d36fdd4edce5efe2c6586560b9bfb9afa56e03abbed153b4328ad342cb5b747253c9ed5c9e3a9cb4dabd63f79f64ec43353c7cc69984a13ee0393e5b8f7f4ab9b299a252d399220c555ca9422b4f31e475bb8d8ab7ada4cd9335a965054593cd60b3097b95b36956ea74717703ed65123b29dc1850f5ebe54d41ca7b5ea4db4d48839a08b725452b415fc751bf5040d908df4f66a0c91d5bf6e5c720e4bf6de9650315bb91aead9e6986e11344cc10c5d3a001fa9f2d799e777a5c5e4ba594ad3a7a95db2b4e035d8eedd61a7bcb63ca6d1b2c05da597a973599239c92164ab1ab29341d7c35dcc592b916e5d19a1dbe5474f5a76e302b6be98c745b3da912821a94a82056b4e95d6849154b17f27db59f111c82c10e5312d5f53177469345fe2b594fcca47f09a8d28817514b35df5e51c7317363b130d85ed8630c10476f91b778ae4199c064731b8048dd52d4ebab70d15d5bfe153f849b71f19bb61acc7d471f8c14df70feea79d5fc9258ff0047c6c4b6aedb6589e72b4af86d2c29f9eb90b9e9ae87b0bfb51e3b3f9e57c0afafbee37b956409b46b3824e80116e1c0affbec756533b6fa18f93da71e35d5c91e4ef9f73ae50c977790cbea7561f4d1281f0da06a16e4392fc7d9f16d973f784784da3f71e5b9b7e49762dce36306ccdba4510db3121f7122ade03cf5a30e56db387de3815c75ad978b602ee776162c2629ef6c72e97e2d4006195023b015a519588ad35a13389b20b1b91e26f30dda1e39898ee2c2e2d33b8eb8c86fb1a99bd6bd85408e762abd554d028a8ea7463a46a4b25e5e873ef69bb756dca730d8fb8be1890aa584c54b92ebe094f8ea6ab246ce06cb4b5e5bc7b32b8cbf9ae2781164488b88da16d80915356342a3c344431cca2e6fb5eef6f25c172cc77169e7fabe339cbe8ad45accc5be81e66ff362727a475f15f0d49f40a272a3a97a76e3376e963717a47ad1419bbfbed8080593e8988f1f6eed60e3dbabf567b1eef81eead7a378eabfee207dd3861dabc9407a7a5708c41e9fae3ba3fdda7cafd0cafdb9a72aafd3f6a38da04b85bfc7324723869e60cd1a9603f9a9e34f769f1dfc88cdee24adca72fc3f
UPDATETEXT [dbo].[Picture].[PictureContent] @pv NULL NULL 0x7923297d7bf5122c9652988b30122ab7857a74a6af4cf317a41338a63b277f88cc59d95bcd25cdd9b0b6823dadf3cb2cc555474f3246a48acebd93b776bc7f0fc738a4333bff00a67091d94d74c056494486b5a53e50e1a9adf5ae902dc55965f691ccafaceea5c9930c90026de3504b48ca2b53f1d64b721db4f02f548d4d98bed567f834d8cce64e131452381246a09317b013edd53b5d93f426dc31f79776f32fc9384c92348d1891d6e6058054c71d4545478f4d4b1e4eb046d5f30472ae2d87e2dc152c2263777b7e523b60df34a77f89a6951349d98ed1a2436f1ee0592b3e35691924cbe9a97520d431152355535524ec7b2f0fbdddbbd21bbdbb6874da12631f06ee5f37e333271fb465f4846f751452a82a7afcc16bd6be7a9d147da42dab194fdc34a06dce60a2bc0b46668d2ac29e7421a9a9ca23b5958772b2bc26ff0092c793e3b7f37121331b8bf5c81925b6696b51407a28f869df6dd7a8f1daf4953a11fbbdc638df30e3d8f8acb2f83cc5fdbb249eadb4d1405d810492ae1493eeae8dad5190b5e585'
+N'70ddbbe596d97c7dd4d657291a4d13b13048142822a49a529af2db7e75f13352ad644c6ee738d198e36f63677f8eb7b8919c15b8bb8d25143ffa752c0fc75e95559bf7210fb9f814b7e3fc3f87cf938b12f3dccd7f71915942aa7a7ba4dd1b9205496017af8eb3721358b6f8dac7aff6cdd6259b3ba6f55a6ddbe7b9fe449c3477d6fc8f13c6ecac9eef0195ca45737f9fbcba8ef5efa7b58ccaabf231a57d31e3e43c34b24d6b1ad9da13b3e888555325326777ad2d4abd98aa9a6a7497f7fa8739f647905c60f99decf25ae4709681ec863af9248dad5a14da2580ec2acce5837f7eb55b5b3509a4ba7d9265ed75ad3271d5775325ad3b96b29bd144f81cf9c3384e43925ccd6f69756766f6f1096b90b85b657a9da1119fa16f76bcfd31bbda11f6beebddf176fa2b645669b8f95492393f6979de0ac1aff2565b71e1953eb609639edcb37800f1b30eba7938b92bab5a14f03dc9c1e5d9531649b3fe17a3fc4910767720fdb8b9e65fd4ac8da5b01bada3669260cc40d8f41457ea3e53e5ab30f0ed7a3be9a2397c9f7362a73abc4d96dcdc4c69f679af517f23dbde6b69c522e437567241839dd443348c143b482aaca84d4823c0d3542c191d5da3e53a34ee9c1c9ca5895aaf3567c355e6a40fc878e720b1c7473ded85d5a413106392e2178d1811504160075d43659298d0d55e660cd774adeb67e2a53fc0c315084b34db415a9000f33a8a965b5ad6ba25086297b95dc518992c4e66f7e8dd0c52c665a9d94a150c417029ec3a298eb573b54af43cf67f6bf6ecb6dce8e5eba370fec1365e7f7df550c1751dadd5a622d4da59d9dc5b99a2937ca1e8fb597af9eef76a39312b6baa972dc98b97d912caed8653b3aad23e54b4d3d0df89cfdc59f1cc8582c0921cd08124901f4d625826f58ec500f8d280574925bd5bca7f13adceecf7e42c1f3cbc564db6bf547c06eefb5f4f8ac2f10c4c524b6b1438949a6d9bd10b4db5e8e57a57a9e84ebb16a5960a6d3c476fe5f1df37917cd6aa6eda6ef412f8e64f83499688f22964bdc6ad7d58acef05b4a49f062c0d481fc351aa30eeabd6ad9d8ee6f1f270edc39eb4b2f2b249fc60b027b1fb48b8b0df6997bdc15cd2aacb712cec0fbe398ca8dadeeb8aeb55f81e431ffb9f1eff002e54ff00fe4ab5f8b11deeb1a3212438eba3938d1cac32dbc4dea4aa3c1bd38f79048f2d73af82db9ed4e0f7787bdf1ab86af3e4a2bc7cc93952591d8e97bd23955925a59e4938f9957ebdf28af6f682dff78c6b3fce5bf8762fecd6ce3d32d5eaf43c8fb83ba76dcf8dac749bff00325b63f7997dc5e53b4315e98f130dac3ca1ee98e4ee63468a5daa082b21340c4b75fc35773a9bab094b929f68e4af1f2daf97256b5888765afd824f0fe273727b87831d92b4b7bcaac76d697314c45cc8c09da2740523f67cc0eb0e1e26e4f74a67a3eebee7fedef5785d32523e6f9be6fb0216cdde0e139236f1dae5f137448022b6824bab798f96c3089227afe7a9ac39f13d3a14e4ef7da39d8e73253e4d7cdf63413e55c5bbd397c11e47ccae27c6d82505b59490c97d7d2330aa836d6e5521069d49258798d68786f7afced9c7e377ee360cca9c5c75c749d6d7ead0902db22ffa6cef9fdcb67727fb23d73bfb5c9e47b07ee5e02fff002afc7f71657dbbe52cf1b90b9b2bdc1e45721939231064a4c7cca9146808d8d2c88360a9af4fc75d0e263b514591e1bdd5cce3f32f5c98b2270a221fee2e19e0a9ebd3ddada78f3967ef2ac327736b858ed4ec87d6bc13b7828a7a7b6bfb75ab02b34d228c8d269b2a1e256ad8a4bdb9b7747b986d892b3aacb138de808647aa9143e7ab2f8a1af891591b066753057eaf72b1ff0049bd2455236dd69213fc2ae7721f8330f86a17c7ea5aae98bf7363736f27f354a86f06f153f03aa5d5a25275576973575c33edff001d7ac8fb61b09f25f4eec41b89ee19a445511d485208ab1d78ae563af2b9ad2d21a4d9464acb24f63bbd3c8ee7925c652710db6f984ad8789e8d1ccbd3d545b824484790af4f2d7afc78d52aaaba22dd60ea8e11df5c7defa505fec32c8a0ff2c7a770053c5a16a13ff0ead92323fe3f2b84ca5bee8248ae853e65fdf5f8a9ea34124ce75fb9fc363ac79265a784aafd4363c84d9528ec17f49af9edaf86afe351c64ff95bfc0ec716fbb2f15795e3fee93973396f20bab95672e558866236d49ebaf1d567d872d3a8859c9b764a38475a7cc69aea625f2c9e279f79ccaa822b18fa315e8586d1fdfacf3a9d554ff4cf61e69c838d99a5c42c4eef0859bd652df20606ab423c35bb87e2cf2fee34e2b55e00e9bbb7cf3371cb6725bc77b1856924582272ca8b4dcc4a93400799e9adeda479249b1bb01c8ae60e0d613e5ae64796f2ed61c1db3b0a25b5b02246a743426807c3525d0840b9c7120c27772e6d5e64b4b696637114926edbe9cdf3ad36827ce9a750b2945a7c9f1d84c8dac722df40f38dac9b564a960453e62a07e7a9d94a214b6d14b8eacf8be7965693fca63bd862af8031492000fc003acf9bf43f81d1edb6dbc9c6ff00e245ef9d82dacf2d3c16370d736d0c8c91dc2829ea2ff153cabaf3f91edb4267d6b8d91e5c6ad7ac37e007e7dc8320dc2efd6eeee59201097613c8cc80aab00c6a4f86e3ab31def7f9664cf9eb8702fa9b528f2452763756f25d62c5bca970cb3dc317818943ba68e82bd3d9aebe2a3ad1267cdbbcf2e9c8ceef4e9049bfba9feaa4f9dc21634f988d4d1c62cffb48b48721dccb5826928b0dd5b5c80edfadadc4d2aa0a9f12ca357615362363a339bdadca64db237ac6ddd608e08f73d6a03bb13f8ee03f3d6e456de85b02d64f3b63f98d7360d9240e4fc371dc83093e32fedab05caed2411b94f930f78d3ab8645a92b7b6ecff007b308b2d8e0b256f3635aab10bafd6aa7c8f43a252729043f32576e7edd7276b9d5cf730ba5cadfdbfff0085b74358223fc5d7c48d577dd7d1e889552aebe259dfd16d48ea800d4a024f0e0ac3f791744048b3dc6edf7d7d9437d87923b6cd62dfd6b52c4057f6c6dee3a92888642de684d97bb3c62ca196db3f87bdb2cba8d93c70c3eac2c7da8ebd28746c53ab0dfe857fc8b8d729ef0f2286d3196cfc6b8c4148ee6f2e5823491a9f246a55bd9d34ad9125b69ab1a4ece6da22c2e3df6edd99e1115a65ee4be6a6c44b1ca8b2c836ef5228c117a788aeb367abd8e58b2e454525ab1fdc1f02bd5fa48da4f5ae418506de9b9c5057f3d60a72a92b428ae7dda475390f9d706eeaf0de797b75163939458e76f5e682e6dae1edeee2899c7ca284508dde40f4d7572da5bb1af1d744837f7316394ca771313c67170c97d77618d8e25b68ff0098e5f6ee6f89dab5275839ededa57c60fae7b15e3e37132e7c8d56aedd5fa157c479060335e8eeb8c6642c250db0334724532f9d052846b9b6b5e8e1ca3dddb0f13998f76dadeb65130b55f11ab31de9ee664b01738ac8e565beb1bf0a2749c2bb111d080188a8ea3ad35a573b2ed69beaa0e2f1fda1dbf0e7ae5c746ad472b57046e0fdc5e51c55a67c53c212f42adc4573045731c823aed0448a7da7c35562ccf1b946cef1d93077055591d93af47571d497ccbbab2f22c4ad9c988c6e36e16512c9758d89ad9e40011b5d0314f1eb5a6afc9ccdf475db1273bb57b5d70b91f57eadaea1a8b253ff0057509df72ee356df6ef6d81b5b846cd5ee4a4b9beb752dbd2305b69714a5080bab7064ad38d7d7e6b338d97839f37b8165b55fd3a574b469d3c1fc58592c2d1fb5fdbbe3865f524cfe58decf19656023335003e63e534a1d4aa9ae247f35a0e65eebfddb979aabfa58df4f388183bcf95bd9386f3392e0492c5717f0e2f1b6f2062aa2258d4b44a7dadb8d47b35d2ccd2add7856bf8ff86794ec78e397c6dae2cdbb59fa4bebf6202f6278871c87804592c862edf2b91cd6660c3dbadfc65d120247aa545450d371afbb5cbe060aba5af6531a23d47bafba723fbb58b16474ad6aecf6fdac9b99ecbf6c637b9b99a0ba68b359b970f8d86da7f4d608e2dc1a4ea0ee01918d0f96b65f818d5acfc147dece653ddfcf74a56aeb35a6eb36ba94d647b25052f24b0b996f2fd6e82594255424914b746da30c6a3e66209af86b0e5e16ddd0fa1e8783eecdd929f52a955af99f9389fb83997ec2e570fc224cbe46f238ae6dae61b13648a24dd2ce40dab246ec2a2be606ab7dbed5a3b3710a4dbc6f7962e472561c746d5a7e69f2f182dcbfb68c72796de81e3b48e1b6008a8a448175d54a125e491f28cb7dcdbf36c296dc538c4ea3d7c6d94e4f8992da273fb54ea69191b25c5c2788210d1e26c108ebf2da4209a787509a96d4424256b8fb6846d8234b641fbb0aac7e3fee81a36a09252a80a078d07893d75248460f6d6cc6ad1a31f6b2827f68d0d203e48a2563b542d3a0a00344049950f80e9f03a047c0906bd47c34401e33bd7f51a7c4e8034dc6e2bd49a686042962eba433993eedc04b2c6960c57eaaea33b7e0a7afe5abb1722b8a67c483e35b2f4f0292fa6fa6b4be76a2c66d6858ab2d374a87ad47bbcb537cdc578860f85929fa90ab7b79692b6c40645520d7a81b8798af5d17c8991ad5a32b2bb5befaa17720545898460d36a9dcb57ebe74ad29aa6d76cb123a2bb2f94b9cef6e6c639b210cb636904d637766e238a5b7c7c24a0792a433168bc4a803c75e679f81e3bbb56bacfcbeac85d46a573dc27c4e3b9024bc62e46471f12abc57d6c644241fdc657f12be150687ddaedf12f92f44f2576d869b7d46fedcf7e269556caf65faa89283d198fccac3cd09a107e075a06ea5c9c4bbc73db94971b9465b84202dadfb3357dd1ccbfcc5ff008b70d32102afdc3e5391e733d6fcce59a7b3bf58a1b116dea896ddbd00c448a17e524eea548aeb2f23917ab84e135a9e83b4df6c5d25baae515062e4e659ece5d58e371b3e6ef52396f674b5a34de94740ee14f8d2a3a2f5f60d73d70d5ba33d5af753ae996b3eabf713fb95d91cc717e3381cb64e136996c9bdc25e5996591d223b64b6760a4eddc848a1f31ad2e8eb4d4e662e663e4f25b4f4485a91ad61807aadb5a31d450d47ecd6254b37a23d0db9dc6a575b74fb4818db0e47c9b36985e3b0fa97b701e47b990fa31c36e83f992cb21e8912a9f9d8fc075206ba7c7c2e9ab3c6777eed5e47cb45a4fea7d7ec3a17eddb37c27b739db3c3f18e378ee6026221cddfe4acc5de4f28585245b52e0fa118ebe9468bef9371d5fa789e7f51cbefa3ed938b6578441cd7865ba5a4b636832d8930c7e8096d13f9b25a4918a00cbd4a74dc0fca756a5a0a64e54e4dc3f95e75f0f98c162afb217250413c16f6d2c922fefaef016a00a91d74b70a01d9fb2eeb71610ddf23b0bac52deb30843b297223153fca5662154789229a96e6281ef8ef16cee52f38b642f898af6e72364b0aba347be19255d824a8e87fbb50c8b7559a389754cb56fc19d1dceb81f319b974a5ac57ea32b74eb1436f22c8a653bd8aa93b7ff4d8f86b919f05ddba753e87db7ba71eb812dfa5578a2abee9739edce378ae5b8ce5ae8af20c822470c36d0bddcd04403faad22c6401d4af463ab789c6759765073bbdf78c768a63b6e50e63f02b5e05db786e70d164b8c649391dbd84ecd7b0885ad2fadd59d49668199f720ebf32b1f86ba2cf0ed1af201cde49b7e65dc41a0f61a68290d616fe4c0e01b2513b5b646e25496ddd09568fd135461ec3bbaeaca4d750892c64fbe8c65ed84239b62eeee2fed55221362e48a381d63400cac927efbb559bcbad06b4ae457c48bc6fc0ef0f4d69e5ac6683cf4e3f76803ef4d3da3401f7a49eed2803cf412be5a60786da23e43480c5f1f6ade2aa7e23401032b67828a326e238c0fe22a0d0fe3a8da103b409393e59c660b99628a3592147da1e3515ea3aeb15f955ab82afa803e4591832185b816f6cc14ed78dc21f00687a8d536cfbd348ab2bdd515b0380bc8b356770cb4559e37f115a0607c35cb53b97c48e1ab56437dd3c17dcb31f61705545c5ea1556a1276316207c40d7a3b7e674e956f5f210f0f9fe3b7fdeae459286fe0b7e53737bfd270cb748ed1c7000237923daa4190d08504d3dbaa72dabfdc36dfe95097a9ee79b83938fb5e1c4a8fe935bef65f906ff00d2b82e3dce79165a286d669311858445717652e1feb6e1db7cf73bab462c016afeefbb57bc09e5adaca7e56dfaff008f0391fee597270a9815ac93c9d2be1585a2f3fde277dcbe2a3b5c5e024bac65ae3b397313b5ddde3da3fa7bb5555fe62aa014049a8a8d62e6517d2566b56fc0f69ec6e5e4c99f3515ddb1d636ab4ee5a89f87ecff007232bc721cc63718f91b0b90cc8d6ac92480292bf3461b70ea3cc6b0d305eca52d0f55c8f71f0306778726455bd7acfef04daf0be4b2723870725ab58e4ee5b6c705f116be44fcc65da0034e84eab78ecacab1ab36e5eebc7a71de7dc9d2bd5d75fc89fcbfb41cd70bca2db012c0b7994c844b3c36f62debb156af8ed1ee3ab72f1af8e257eae872b85ee3e1f2b15f2d6d15a386eda01390718e4fc7b2696d93b6b8c65e2d2489245647041e8c87e3e63555e992909ca36f1b95c5e5d2d7c6eb64f4b3d35f8ff99b5fbafdc7933763737396b8be9713289ed96ec89912550541656146201fded687cecb0937a1c65ed5edeab7d94daeca2537a2f4eb037f13fb86e4d88b5315d63ecf31e9de4b95b47b80f134179386dcebe99a11f31a03ad18fb8c37bab32e7c8e4f3bd918f2ed78b2ba4576395ba57e06c7fb8ac141c5ac23cd58dd4d96c14d75776b25a3a0b79ee2ec4956995fe65a7a87c2bad18fb8d2dfae56bbb4393cdf65f26991ff006f6aba5aaabf33869693f90afc37bcfc3a2bcc63dda5d2c9f5166f7ffcb0c914769bdcb210c4bee91ab4a786ab7ccc6f57d5fef2bb7b5b99f32aa4d24e35fd5a4251fbc6ecff003be1596e3d6f8ac55ffd7dee5f95c59196330c90110c92fcbfac75a0da3c756f233e3b52d164f73455db3b572f066df971ba571e2beafce1fef1dacdc5ce7af273d77cee7f00d4d68f13c53e833592500d4d14364e4f01a644d8a3a6981ee981f061d34847a1811a607de7a407c69a6062f435d2034caa4af5ea7ce9a1811a40475f2d219ccbf7993416784b0b970485c95c29a5682b193f31f2f0d55968ecb434f172568dc940dde6ae323c6ef160fe6c8ef0c6402079b31a6ea7805d55870edb6a5bcbceaeaa97809ed2b86f4d149763b40009624f4e8079eb633017345f6d9c7f03c6f0f3739bfbab4cae4a07bb7c262d236b95599a90faf3bab2c74515640aed5e9f2f5d2aebabd09aace889586fb74ee810ff00e97b88efad2146956d7284d84e547822330d8e5874fd4befd098ad483dede62f0777dc5b3e1bdc5b597884173215bc9af239ed9e28c293557841346202865561d74dfa1144893ed3b9cf2feed66711daab1b7bdc2e02f858c99686ea518c8cbc6241bee2e8ee723c2aabf3742106a177b5c125aa3a53b3bffd3f63c6584337703923e56e98256c70a9e8c2858d286e2605de9ee45d4757e80e0b55fedd7b3d6b8f86d862064618b6bafd7cd35c1dc4ec3e2e0751a85b1d6dabd4b71e7bd1455c11b17daaedb602edef30dc7f1d8dbc28cad736f6c892b28907ca5c7520f98ae8554ba0ad92d6eae4df94e23c6afee649ef3196579388a4b7f56e2de395fd18d848a956527686f2f0d36a7a8ab66ba0272bc2fb470b95c861b0aa5b72b2bd9db336d65af86c27a1f0d2589791279ede6c45e698eecae36caeedf15c4ae6e26c82c7f549c6f1bf4e641182c1649818a30a18ee50cde3d69ab1627e657f5114e719e5bc978767e5cee3f8ee431d7d6aecb8c456b4bdba51202a5d8b3ac6ac01a7e86f6d7562a55106db1d307cdfb9b90c841366ac6de5b28924916d2faf27c8dd6f7059364710102d646ab05af9ea69c908833b8fbb2ed863ae64c018e5e65ccefa4fa7b3c561fe5c5dbb374addce8c1084f1709be807b745924154d91b0392bfc619af26bbf572b7fd6eee62508bb7ff004611d4a44be016bd7c5aa7518f326799fe7d7f34056e6f67b94a86d924aec80a9a834268083e074e01314791f7232691132e46f2dd5b705713c80d5d4a921b7541218f51edd26a49d72349a4f4608c4f28eda2f66b2fc430b8d487946524327f5052d3dde44ec750924b293203b9be540761f60d5392acddc3cd4a6e4f49428f69fb57dd7c5646dee9223849e1b92e5e49912408cca4d554b74a56a0eaefa76eb0739dd4f50c66f11759dc965390e1e28ce1ee6faecda2a1d85e286428ce8b4a152c188a1d4551be8472c48bbcb3237491c714c761551b6307a2aede9d08041d3646a26e4f6dc2153d07b46a24cfd75b281abff5534b5a74d88b4d449984cf78b26d88174f22fd0fecd31186fca7b15468d00c4cd95dd52c068d0353c92e2ed6ad249b00ea744a08647b3cdb5dde496d6adea35bd37b3304ea7d80f8ea2ee896d6498eeb2c165d907acf1d400b22fea02b4274b76a1b447ee10e5d7603cf0cb65046819d16b210de742bd0eb9dcab5edd3a10cb8fd4476b6bb31b2430cb331a9f951886047981ae76c7e443e9c7427d9fdc077470b3dbe1dae238e2115218eead901d918a002aa2bd35d5c3976e39dba21b71d4ddfff00d33ca9ee62b7bdb4b0992e268ad9a4fa640e3d7711ee07ca95d4e99eb7f043aa5664af56cec6faf3905c056ff4fd85de455c787abb1a353f1abeb5521dd4f9cfdc743878ad9322c75fe36abf7b398ededf91cd2be66186e96b2b4e6f224902ab925891228e86befd706f6b5eeecbccfd06bfb7ad160bbaf48dadafc82380ee9736c1e52eaf6d6f0cf364e3115eadeaadd24cabfa7d45943548f23a9d795756dcdcbe9a98799edae1f271571edd8aae6bb348f326f723bab9fe6d2595ce55218a4c741f4c82d8145615aee2a49ebf0d4b3f2de5ad6b1102ec3eddc7dade4d9676ded75f40c714ef463f1986b6b2bbe3b617a2ca35856eed9e6b0bd60bfbcf2c2d52def2353c3cb58eb0d7e2727ba7b43272b35b257346e73b6d5565f603329c8ac398f746c266f5ac6c2e27b4b7232774d74d142aea1b74d2d0ed1d695f0d55cacdf5aca27c8dfc3edd6ed5db7227b5da2d6f91427a69a7996fda65ad2f7ee039465ece9911c7b09e959436cdbda66d8836c5b2b5f3155f6ebb1a3e4d2be14a9f31cb8ed8fb3513d1e6cadbfb34d49797b587112e4b2edb9a4e3bc72236b6f76df55f47777a5dca46f282c7f4afeaaeb42aefb56d6f27686726991bc7f468e37e449bae8ac97a7da547f7156568bccb130471469937c740d7d2448b1fab3ca69b9954015d72bb8a5b28e3568fa0fb272e478f3cd9ba56df2cf80f1c83b1bdba8f0d96c5d9dbcf06538f58da4ed9369d9c4b77760d2368a9b40e83c3dbad15edf8f6a4ff0056ddd270f0fbc39ab2ac9669e3b5dd764782f5fb4aff00b97f6f38fb68ef2c31d9696eb2f875b4faa49a054b5792f4d15237562d51e26a3545fb7457f56b1275307be2d92cb7e28c766d269eba7a08f3f6433f697d67062e519d7bf92e2002de275647b460b292a6a4a83e6359b2f0aca235d60ed76ff7571f256cf2278f6a9d7c53e91ea33e27b599be37c9f8ccf919a07193bb8e68e28cb895442439deb22a914d1fd95e9b6cfa37055c8f7360e6f1b914c6ac9d68faaf3d0b2701cbb8a5b63bfa9dde4ecedec6599e21732cf1ac265526a81c9a6e14351aed2ab6d9f20c964355a72fe29fd464c70c95ab642da037735a8954cc96e143faac95a85da41afb353547a7a943b22771be53c733d626f70b7d0656d12430b4f68e258c48a012b51e6011a1a870c139237ff3238189f2707f56b51371d432e5a3dff35a20342d30a74eba9fd3731e2c8ee5124493bcddae4b7c75c366ed7d0cf48d06324f9f6dcc88e23658cedeb4721746d713e087bbc048e75f72b8ec5f386b3b2cd6120c5e2668edf236b7bf526fa671215b808c919588c407cb50dbcfb352b5217a914c777ef176da0e4f65c725cac699acb2432d95aba481a54bb5df110db768dc3c2a750dad29f0253ac12b8ef72f85e7792e4b018bbcfa9cae0095c85bfa7227a443fa7fa99429f9ba743a2f5dba304e43dd348662de3a00c1eb4d2022cdb869023993ef9ae5adb88d94817728cbb46f515a878643e07c7c34d746073ef0ee0dc8399b41c7b8ada35ee5f35918e0b5b1f523844924703bd15a5755f024804fc351981b659367f6a5dcded2f23e3dcafb8763630dac97c9f4b8bfae8e59de58c821e5f4b72aa21209f9abfdba71b90d38193b8bf775c50f256b9b0c3419a915828bbba6da14c2768f423a3054007c95d5929750aa611c3fdd770bcaa27d6c8f8d9c8048994ba03e7475f61f0d495931b44bee7e6ffd5dc02f2c71164fcaf2535b96c51b38cdd4914ecca15e37404a91f11d3c74ed1e2418f1f605c63bb3db8c5f257e751c967619d92d2e71f8a324534bf5318904d7126c66f4c95d8b426a7d9d3546d6d83b245f57dddb105b996d71ff0051e805251e611b10b5269443a97d323bc54b9fbae920fe536221254a8f9ee18fe924f920f1d1b07208bcfb96c8dcaec8edad2dcd29d03c87f56ef36a68d88259026eea66b22499ae1c231276467d34f98d4f45a6a49242d4d0393c31b6e03e6f69e95fc4e98a05de6bdf
UPDATETEXT [dbo].[Picture].[PictureContent] @pv NULL NULL 0x1e3f8889a3bebe48a403a5ba1dd21ff856adfb34e020a9f93778acef6c9b292bff0040c3b97486ee68c4f7b74ebd0ad95b823730f0323b08d3f78d7a688195ddff0074bb85cd5e3e13c2e3b8c561dc3078927796ea4809f9a5c85d80a4a0ff00d38d523f20a4f5d576bc22dc789e4708b6bb57db9ecb700c206c85c57312205bcc9642ee2c7a487c4a431327a8a95f20493e7aaeb693564e36c896305f73fec8de71bcb5c595d7a898480b5cdd591bb9364f27cb0c5ea4fb232ccc681429e95f8e9d6ce6191cbc7aaa6fabd260a0f33dd8bf9d0aef201f1a1eb4f66ae6cc702ce4f9b5ecec033bb20e80331200f7693b0d2201e5773138915cc6d1fcc1c1a10475ad75191975721ee2e7725c56d38e4572b6f9abdc5c3779cc9ccaf18b28664afa5b69b8cd20e8053fc5e1ad144efa1459aaeac1b8cee162cf1d8316b6cf159e2d0410207f463db1fef513e725bc5b73f53ad9871a466cd918a598b89b212bdc247b20676f4d4548541d3f2ad7583931bdc1ab0ced5204b88dc82107b86d1e7ace5a7ec35d35bc0b560093e006912214d72cfe00201e14f1d311adfd461d4e901a245e9f3127ad74a07247bf8e1914a3740e29d3ce9a8b449317327864493d481de29548a3a920f4d54eb05aad22c4fca79741c91a04b936914cc659188f95a9d1753915d6881dddaeecf71ecb151e3f137464967211a68943128475143fdbab25252550db34f6f79172dc3e1d623913717521f5ee669429732378aafb8786aaaebaf8927a68577df9e7196b'
+N'9e756b34ccd3dcda460868bc0a935351efd68b515b1c3286a6c2fbf3eb03c831b8fbd06de5beb9b76858d76bff00354815f235d735719d25ae85b4a458b23babc98627b3b788cfbaf7945c0c4c143d45b4044b331fc4aaeaec97d98ed6fb17dbfe47b1f67701f239d5bf863f99fec1ebb7f8d6c65960f05be59a4c76264ba923890263ae14a840b331ddd413514f8e9f129b71d2be6ffc7e672bba6779b3e6cc944dbc5eab5f016b07c078ab71ac64f271ab5cbde728b9b9bdbd8ea04f1d9ee66a5b16641550c814023a5742c147badb7ada0eb67ef5ca599d567b5563aa4bcad6d3afc7d4a5b9771fb68f9c5ee1b056f70d1fd5b5b59da4abbae6a4d04640ad581e9ae672b1d6991d6bd0faaf66e75f2f0a99f3b49ed9b3f0f890b25c5b92e2d4ae471f7762c09afaf0bc7fda29aa6d8ecbaa3761ee1c7cefe4bd6df0689dc27b5fcf7945bdc5de0b1ef7d6d68de9cb286441ea115d8bbc8ab53c868c586d76f6a932f73ef9c3e0d9533dd55dba112e713ce78fe43ea52deff137366ed11b889658591d3a32ef503c3cfaea51931b9d5344325f83cec7b2ce97abd61c1b705ddce7b86c8dddd417a6ee4c9802f532005dc73ecfd264592b523c8eacaf3b22b6e6e7e27339bed5e0e7c55a56bb155fcae9a353f992e1eee672f46427cad8d9e5323959a0996fe78e92db0b52a563840e8aa40a11efd58f9eef3baa9e90bd0c34f69d30ecae1cb6a554ee5fcf3e638e73ee5b13710dcb458596dee7337967779691ae44a852c8c7f24036290084a7cc7cf5b3fdca90dc3dcd47a2479da7b1b92ac93c95d94ddb7acb6fcc1fcafbe7db897392dd5b5cdd4ffd7729697b7beadb9885adbdaa2a843d4efa15fddf69d5d7e66272e7aa48e4d3db3dc36ecb638fa6ade2be66fc8d1c5b9ef091919ac2db336a6683119258afa466b7b56bdbf9849b55dc0350a3d9f0d3a66a6f5aa6e5b29cfdb395f45e4b63b2acd2b11ac2eba1279be7b1d3738e330d95e459287038892592e20944c85e38242c4b027afc80f5eba8e4d5e2ab72e64d5c1a3a7079991d5d55a2a944789ce0bc8eedbb2f7d84bcf944993833b8fdc7f5c57027866dbf07415d6d5d6cfccf14fc0b2393f3fb5e23dfab9cacf673e4a3ca716b6b3f46d29ea56f2c2250fd7c969d74eba2a3f222ff00891647d89b96ed0deaff0006627fdb0c2755b7f3325e0533df3e6190c1f753b8588b7f913935cc36f71357aa430bace401e7b8d06b45dc5a7c60ad295f68f5f71183c4e06c3b4d698a93d6c7d83c2904c3ff00350c96d27a9d3f8892df8eaa5fd07f1fd84bf8c54b7cd71bc477eb9b0ccf107e7f1cb7f72b15ac686436cdf54c4ca4047e8c0edd3cb1bb57e02acc04fee52c3229f70f8e9b071086eb1b87b3cb5adb8aaed5c5c4f71e92d3cc245b46a4d4d2abcc557ab1b3ed6391d866fee139d656c8d6cf316e2fa1ff00725b857fd85a9aaf2b9b2f812aad0e873a480c1bcfa529a4c662f5a74eba606893c3f66a20513f73fdbf8795e04e39eeff00a7fa39117225f4ccd5a46ebb6808f1dde3a92f1114ad9fdbe5a436f1d82e724b7962b91905bb8202922ba28450bf382083f306074b6ea32d9ee060323dcde31c7f13cb392dd5ccdc66036c2fa289127bb15e924db8b0dfb400587eaa54f5d49285029823f17fb39ec445b65bf92ff28de244f72514fe1104d2da3de58bc73b3bd84c12ab5871dc7ab47d449340b70f51e7ba6dc74f6216f631ff00aaf07616fe8d9c515bc4be09085451f0550069a4401b77ceae263b2dd1a463e1b7aea4102f725e78b6101faab80677e82de16a91fefb7f70d3862d043bae446fae19c2aa027a006ba1a25249b6c8416d16f92951d74a024139eeff00e071513c303adccea36ecb7018861fc4dfa47e7a2104959f32fb8ae4f788cb04c6c61350440c7d423df21ea3fe103448e05ebac9c78dc7c595e46bebcf905171618612159678dbc27bc753ba389bc557fcc9075f9568c54f981af15c17ba5dc2c82e46e156c6c260162bcbc22dad5604e8a96c9e2c8a3a288d6835196c70916171fc4f03ede622eb1d6f7b75cb3377ebba6b6b266b3b65da3c643136f2a3fc6ca34fe92f12cae6b57f4e828f1ae2fccfb8dcd2dedb17045616734e2ccdfc094b68893d444c7a3b01fbd5fc7555eeaba22dc58de47367a7f8e831fdcbf04e53dbfe3bc7f022dd71bc62647b8b75269737b7c4032dd5c5685ba1a21f003463502cd7dcd4745e052b71910075fdba9949894bd97e60be8467afa935517f01fa8fe0348035c46e3158dbdfae96d97237b1806cae2f5b658c128ffcefa7019a62be2aa582d7f503e1a955491b31aacf9ed9e3b0f2c16ca67babe91ae2f72378775c4f349fa9cf8d3ddad946aa8cd752c010e472398ca456165d1ae1a951f2aa800b339f62aa824e95f3c2d09571798564cde216d92da2bb6921894220ebb283ccf4d616db34422c3fb75e0b6198cc3723baa498fc6c812d50a9d92dd2f5ddd47554ff00c5f0d15467cf936a847e9434101ebbc9f88d464d4786d6d58f566fcb40188b5b71e6cc0fc06901e982d765086fcc69811ee2c6ddd06ddc0835ab75e9a40469f1025e848ebeed263442bce1b613d3d40a7af9ad74a02486ddb7c5fa9ea00a5e9404a0f0f7693ac9256822cbd9ee3ce49da55cf52cbd2a4e96d0dc2cf2bfb54e0f9cba59ee649e29a3e81a26a547b0ea52d2892308e7dfb85edc4dc1bbabc6ac2d924b8b3b8bcb56b6ba73b88acaa19694a546a592b18db0ab9bc133bed7f3dc727b3e3f0969e2e396d49f6827feaaed8cf316a7850b04ff00875cbe6d9bdb55f17f6ff91f64f65f1f1f1789f52ed2b657a4b8d10271ddccee163f10d8ab6cc5e458f64317d3fa84a84614da09ea07b86a8c7cacb8d4559dacfedaedfc8bfd4b624edd7c527f15d061e25f721cbb090e36dee6cacb2f16095a3b3927464b848dd76955914fb3a576eacc5cd75493530723b8fb230f26f7be3c8f1bbf55a3afef1671fcb147326e437907d596ba7bc7b6f51e1ab392d41246430a13d08d53933fd4caeefccf436ed6d705716964be5dbba27f02c9b2fb92c1ff00499e103398f98c6eb147f5b164ed779521432de46580afb0eba18f9d4f195f89e0b2fb1b975ba75fa7653e1ba8ff000d025d8de3598b1eda272358eff9399ef9b2165c731d2469025c404aadc5c7ef56a3f48f7743a383576adacdb86fa2f1337bb3958b2f3d71eaab475aaabc979e9e5fe7126ce29dc7e6d0e1391f70b935d4b06292e64b6b0e3ebb45b4d7e7e42183062150800d0f5209d5d8735af7bdadf2d2bd57ec32773ecfc6adb8fc3e37cf9ac937925f47acc4c446bf026f1ae33c7f2d6dc76d2f307657d77cb6ceef379b9be9eb30dfb597d260418c0690014f21a74ad32555dd54ddfe060e673b95c7c992b8f35b6e08a575ebe1afe255ddb3edae3392770af7117266c7e231c975792b2002616f0351141604026a3a9d7397195f3fd35d259f40ee7df3270fb7533c2b64b2afc25ad425c9bb0163777b8a7e3f7cf6d8ecd584b9493faa2832db5bc210d5bd2e8d5de29abefdbd5a1d1e8dc6a71f8def7b63a645c8a7cf4697cbd1c8839dec4f22fea90478fbcb4c8d8df5a36452fcb1b7812d5280bc9ea0aaf88a6a8b706e9a4b593a187de3c6b63b5f256d47571b7abd45f93b73caf1fc95b0725bac97e423a7a4ea626497f4307240a1f2aeb3e4e3deb6db07738ddf7897e3fd7df1598d7acf940c183e35c8f0b93cb585ddabc79583117fb2d92923b3cd01440bb09049ddd35ab878ad8f3d7728f1383ee8ee18795daed7c36dc9d920066fb0dcf727d91e2cf6586b993906365bdb3bbb30804eb6d34ad2c6cc091d01affcdaec52ca1fc4f90d9742d0e33db5e75177ef179d9b193c78a1c522c6dcdd36dd89762c044623d6b50e29e1a92b28a7a7ef20d3f9bd462fb45e07cbf89f02c963f90d8c98bb99f28f7304529525a168a350df216f353a5769d9b435d10a9cc3edcf91f23eeaf3ebfbcc6036199c757037cef1d3fa827a2cbb46edcb5d8ca491e1ab2d74ecbca0824d221726ecc77ab39dafe098c9b121731c3aee586e91ee60a7d146f1b43206de413b576d3c7a6a2acb63afa8e3e693dc8711efe70cef8722e45c56df128396dc4b1da2e56eedd1a785e5120f4a26951f76ed4acd3d63a0aba68345ef693b9798ef9f16e6398b3b616b06212cf90fa53200b732413c532471d4965ac8294d45de6b5f34ff006825abf531fb6dec4770b81770f2f719430cbc7a6b596cf1922ceb2cbb45c2bc754a6e50507515a57464876d3a0d742eb27cb4901e36880316a53dfa00d328e94d2802a9eee64e0b09ae669c8112dc2292de037af4d3aad41bd048b4e4fc7a5cb967f4cc6b6cb42481f37a86bf1e9a9edd486e09a722e0a16b22c4a7dbb829d4b631ef3747cdbb770aff009ad5f624a7fb8e96c62dc46bcee870d4afa22693e32b534f68481eebbc38c8a4fe5c0a7afef12df9d4e8d81209cff7e3206dcc56ceb12b0a523017fb34e1216a24df734bcbb769ee66f4e34ead239a281f13a24700bbfef0c169188f1ca6e641faa592a91d47b3ccea2ec87b457e43dcbe4993056eae5bd2229e8c7fcb8a87da01ebf89d45d9b1aa8b7779d908a56a3c80f0d464940d3c03b49dcdca08f91ae323b6c1d89331c86647a3601803b588715968d421555b71e9a75d44dc1178ef687bb7cfb914e6c2cee72d753485ae6f18158c127f5cb3494551f135f76861a24742e13edd2cb8df0a371cff00934b05ad840a2618f905b5b43144b40866752ef402800dbee1ab2a9c15bb7915a5a478ce5798921c358dde2fb6f697115bdcb16486f2fa46751b6696836a90c1b6d6b4f3a9e94e4c91a54d18b1a7ad9c17262b238ac0476f262ed22c24588579add98c4d1450c4ac5cb22965a1507f57b7552ac13f09399bbb3dc8e5fdc2e5f2e7f96e44cd3ed105b5a41575b7b64e890c65be5000f13d6a7aeaedd25502d2b5b447fe9625858f84b29f525fc09e83f01a6931366abdb191e14b99ccbe8cac556521b6c8cbe2149e869e7a12531226d9f405c2110a00100eadd4807d9a96e4851262f2c8c6a496f8e8766090dbdadc75f4335f658c2e512ca6b5b59190b4667b9a44df9465f555f5275d08b370bcc7508f527a0f94ae9488ea7ed7f108f09c4ec7196e008ede25dc7ad5a471b9dcd7ccb127569cec8dbb1dac2be35d52748f98b11d3c7401f55e9ecd0063463e27401f6d7a75d03316ae803c2c08ea34a00c19c1522b4a8a57cf401a2d8fd3c011a579e84d5e535735f6d00d28030b9cd4117ea3fb34015ef7c9782e63011dee5a3267e3920c9da4e14fcb25b9de149f63114d36d6d69f434f0b8b6e467a52bd5b48acfedf1ee65e37cdb9b5f012dc4eae0bc9420baa34add0ff0089c6b1f6f7f5333bb3da7bd1aa65c5c6a74a552fbc2b7bdb9c2cfd8ee2f8c1696e9c87945edbc62fda25f5d16e9da676dc3a90b1f96adae3adb0decd6afa7dace561ef39b8fce77ad9edace92e1c28526ee43d81ecedcdae5b038592eadf93f1cb35bc9a595dd91c329652db86c21a9d76d29a3fdbf1b8abead1af8bef3ee58f22cb77bb1b710d28f58f1d055e27f6abc973fc2ac33d6391b58e5ca426716772af1ed0490b475dc0d40af86b15382eca64f4f97ffb06b873da96c5354f469ebf732bae4fc6331c7b397788ca47f4f7d62fb2540415ad2a0823c411d41d63cf82d8edb59eefb7773c5cec15cd89fcafef5e86bf4f96e0da1b82b7b886b9512c12ff0036dbd446008646f96a0823c3455e4a43528cb67dbb9fb93fa7936f5986d7ed31c9734e533f1e5c0cf7d2cb888a66ba8ed58828267a9670695a92c6bd74df2726d759d1f50a766e2573ae452895d2db3af4e9d3a741870bf717cff1f868ec214b46b9b5b238bb6c9346df571da9a7c80860a6941d4af96b460ee2f1a4a138e8797e77b27067cd6bac96ad6d6dd6ae913f118b8877a38258dc5c34f8e97130e4711fd1ee67b573737225ebbae0093686dd5fd35e9ad183978eb7568871abf5397dcfdb7dc32e1dbbd64db7dd5af4f97cbe24c97be7dbfc965f216705d3622d530630d8abbc82148cb9ddbd9f66edbfbb4afb35ab1f2f16ead6afa27f79e7b93edbe762c5f572525daf36ad7e6697d80d8f97f0dcd4798c462f256c5e2c5da61ac9a6905bc72440933bc6d25010011f968adebfa6ad36aafef664cbc3cf876e6cb4b56b6bbb74f2e92306072d89bcbccb4d87b982e99b318db39248591c7d25bc71993a9a82bfa874f3f0d4f4d52ea92466b56d554fa929595eca74d5f413b177897ddd9e4b911d638d9e256f134f592203f24d66b3ddc97e88f49cfaac5d8f057f9adbbf32cfe239ec25dcd359da5d43737961b45d4113abc9096f01228eaa4fbf5b528ea782b39632c2fd7a0d3206f535d30325a7c74203d34d3101b91f6ff876772f8fca65f1f15f5fe0dc4d8e9e42c1e093707dc9b580ad541eba1eaa03d4320d5bfbf42032dd4d0079baba00f0b75a6860cc58546d22b5f2d006a954d7c08f8e80280fbc2b892df8466254aab437562e187f8980fefd15fd5f60781cd12725b84c05acfea3869279d0907ad10211fdba376a28d4c20e584b559cb1ff0011aea72104a5e6cc8451c0f8685616d31939c5e374f50edfe11a370e0d6dc8eeca7ab3398a26f02dd2bf0f33f868dc1043bce60d42b6a9434a7a92f5fc97fdba5b8200f91ce5c4e775c4a642be018f41f003a0d4647068c7419bcb5fc7638ab59b2179390b1416f1b4d2331f2554049d12382efed57ff4f6ef2f2954bfe51247c3b1048dcd7851ee9abfba91060037b98d7dda126c1b48bc7827db6762f87ba47c7b07fea8cbda9db266333fcd55957c4aa300a083e4aa356571af1d4add98d1ce27edee0309fd4fb9196b5b1c76d062c7cac2147dbe016351ea39f746ba9a5a112a3e5bf755969b1ab65db5c0c381c0d7d2b6cc6663f42361e064b5b18fe77a78ee73f11a85b225d3524b1b7d4a8f99720b8cbdefd5f21bfbae577683f96f93a0b78dfccc1691110a0f65431f6ea9776cb555210e5bfc862320f2606e27c64972a639618a4263911850874350475fde1f0d0b506c257fcfbb83c92ce0e318e80ac73002fd31a924b35eba1a8de016608b41f22d149ea7ca91c97a625baed5579b1d775f4aea1487b03c8ad6da0bee4b7967c57172b7f3a5be991ae95295aa408496627a6ddf5d712fee4c16b3a71eb6cb75fcabe5ff00a8d8bb7dd2dd91aaafc49b0e67b2181956d78b60ae79e677aecbaca8636db947ea5b7400301e342bf8eaaa71bb9f29ce6c8b0d3f971feafb6dfb86f271f1fe8aef7e76e9f70bf93ff53f24b95cbe781bb9d94456366ccb6f6d14553b408e30ab1c55e8aaa06e3e27dbd9e2f1b171abb31a85f7b7eadbd5b28b6fc9f358039a871b601697292dd4c18cd0db28f4d0d480a1bcba78eb5494daa055c9491dc24891abfa6e1f638dcac14d76b0e9d0f9e89225ab1f2183318586f6dd16d6395368b788ec48caf42800f2074116991f0787b8bccafca4b476ca6792a7a6d4f0afc4f4d026e11d35c5626fa18d88a9d882b5ff0008d58cc163b08ba9a6a83a863b8e80321523c093a00f95263e0b4d0064b6b735249a0f21ecd2903c3049d49206891c183423c4b8a7edd290834cd1a79b8f775d010699123f320d7cf408d135b40c68403a00a13eedbb89895c6c1c57133c73dc5ccbea647d060db123e8b1311e65ba91eed65e764fa74dbe36fc8fa1fb0bb4bcb96dc9b2f969a57e3e3f71ef12c45d5afdab7d363a26b9bce4573e837a0a5987af722225a9e4153ae8e0a55c367e30ff0071c8ef9c8fa9ddad6b68ab6ffd283fde0c7f2e9b92f19c1f11885c6478cda9cbac5b95102c0c90a03b881d40229efd68c94b2c35aaeadfe473bb566e32c995f2262d5da9a530db99fc085dddbb3c97b5afcf78d4d36232d6886c731141218dde2526392de6da68fb1dbe53fc2752b5af6a38d2f5ff000d16f6aa60c5ca58b935df8edd3afc6b65f11d30dc4acd22e231b5e1b79789d97d50c743d65b90d6cb09206e04aa93ec353a58aade3aae92ce466cab7ddc4cfe1a9cd3de0e4f2f20e7f98cabc4f6c9732b08e19452448e31b1430f2345ebae6f72bab6685e0a0fb6fb3b88f8fdb693d6d36fbce80c5e1a1cb72be050dc46b3db60f8e3e464490064f5268e1b78ea0d47893f96ba18e93871fc7f247c73272dd1e7aaeb76bff5362b728e25c1ad71bdc1e5594c5da5cc76f7925ae36378d5551ed6158c7a41694dd33f5a7b356fd0a3cadd928497e5269c7ddb95f4f0e2c592d56a568df5767f9200dff60785be5f86e0e21359de666ca5bacbcf1c859985bdb239655937052646d65b70b15b1d5c436cea71bdd9cfc7f51bbee55e9b94f8813b83f6e50e2eef1f0617370649f377c31d0c32a8568db63c8ceed1b3f45086bf2eabc9dae2ada7f79d5e1fff0060dfa65c49e9d6aff795273de3591e3dc86eb0b7cf1497564c1246818bc75650c284807c0fb35cde471ed86d0cf71dafbbe3ee183ead13aa96a1fa1a93b7dcc8e03fad362aece2b67abf56613e97a7fc7feeff008bc34d71f235b92d0cdfefdc1797e97d45ba63edf8f42263b197971b9adade59bd2a173023bedf6162a3a6a15dff00c326dcf93894b2599d27c3747ed2c3ed54398fe89906c722bdf1bbc6c2dead282dccccd37eaf3080d3dfaddc05f359beb078bf7d5aaa986b48dbaf4e9e001e2bdeae6b88e05cd32f8c4b1b1c963f3568a658ad12b2fd53cc9234d5aee6f90509f0d76d556fb7a23e5edb85f1192ebee6b9d5cf0ee0992b0ba861bbcce464c567c082360f241344bf2820ecdd1c95e9edd47a52cfc530fe24168bbdbdc239eee9d94990445e1d6d34b841e944a6268e62a3c57e7f97f8ababb6afa894691fb084bdb33e2587f6e7cc33dca7b3f8acde6a7fabc95e1b959a6dab1eef4ae1d17e54000a281e5acf32d963037ddb739e5bc4fb5d1e578edec98bbefaf86069a20acc63749095f9c30ea40d5d8d68d90b75436def279ecfb44fc82792b71060c641e53404cdf4a24ddf12c750c2b73523c9a2653df6a5dd5ee4e5b9b5de1f96e527ca0c961132f8d17057e41bc755a01e2add7e1a266cbc8221310f17dcaefb4bc1f39cd61e67751a718c8c163fd3ae0893d71704d08ddf290be6a57565b5b35e44574431f7d390f7661b4e33cc2c393de632c39e4764898bb479618ed2592de2323f46a10ccc4d06a2aff24f90e14c057b876ddccb4e69c23b47272bbe5fea8259b239eb62e9773b4934a52a4bee21117685dd4d2dcd527c5b084dfc04e4ee8f7221ecef36c2cf9abdbab9e2f96b186c7246675bc1149712c4e9ea03bb69f4c1a127c4eac4b6d9fc03aa411ede722e65c7fba9dbf860e577bc92db9adac17195b0b9b837096e6e43068994bbf55fd4a480c29aa6cded9649252337deb467ff0096b9d7db5da6c9c507989a31a4bafd81e07214f7ac78c5b251aab79714143e0638b49750f1200b9929fa5bf23a06671de75ea1bf23a606dfea532ff971b29fe222adfb7a0d29035cd7974c77c818b53f539a9fcce8900af18edd770b934a170f8f9ae22634372c3d2b75f8caf45fcb4d6a0dc16976e3ed36c1afd9b97de99da0dac6cec98a46c0d6bba52371a53f740f8ea6b1b22ee751f61bb5d81c4f1bbe938361b1ed35ab2b5d5fcf5b6b38e270d44695be798222348fbd953fdff9469c24c8eac8bde4eef76a783d94efc8f3b2f37e4290cf6f6b8fc4a471e2edef7e51198fd4204aabf3748e364e9f32f9196be3a21a4be25211fdc7f7c72eb752d94567c2edee218ad1324d019b251d9c1570b6f136d40eecc59e4289b8d3f4850355fd58e84dd6441cbe6208b213e4721eae7b33725bd5cb65e61797a56bd0233d563e9fc0bd3c8eab7676ea34921772fdc497d4236004d149dfb8851e15a7b34a01b16725cc72131655a256b423c69f8e9806f85f26edf99f136399c2b649c34a27b8495a1926b89dc18d252ad4741d02eeda454d491e197994cd7c4d62b6cb79c49760b52b69ba943cf30ee0e478cbcb8fc7c78de0f2b2fa7716d8c8d6e72610750924a156353d7c8353f8b5e7b8fd9beb39ceef961ff1fcb59ff97a9a393cfb53e5c554be1fbff7156724e473652f3d5679ee180a7af792bcf70f5f6b31341ee5d7a7e3e0ae2ac5524bc928473e6ef5b3964ae079ccbd8e67d0c64714b7f90536f12cb22c4b56047ccccc828057a16a13e35a0d5b62557030f25ed5f79c40d24f6d1df060bd60b88e42283a6d4aa8af5f10350504ad66fa88393c365ec2ecc191b79ad2e7cd2e51a37fc9875d4889a3d3d300bf10cd5f59dd491ed792c36efb8da0b2c4090a243ec1520574a420bd384e3ac62edbdfcf1aabcd73343ba6001250c6e4283ecf769a28c8f52e3e3151631fb957fb06ac662b753ad4dc01edd50754fbeb9c7e934f8e803c37771fc74f6e803037371b7f
UPDATETEXT [dbo].[Picture].[PictureContent] @pv NULL NULL 0x5f5fdba200f85ddc0150e47b7ae88093c6ba94d6ac5bf1e9a2024d5eb9f33e3e1a00c2571e2d4e9e1a00c77a902b4ea7cb401ae69d2247909a2229663ec0a2a740253a1c83c8adf0b7fca2fefe3b316ab777524b1c42a142bb1a5074a7b75c4e5595f2599f7fed582dc5e163c49e95a968718b3ee5700c6d863acef6c54f2053756b89bb70644de2a5c17d8a95f617ea7dfad9c7a5f1d15b48b7447cebbb5f87dc33dedf355d3f55d29af96a6ac2e5f9ff0015ee14fca3935b5e4df5f11b3bd4ba84c31fa3505042c018c6d23a0af5d4efc8c9bd5aca120bf68e267e22c5c6bab5d3999d6df1f2f424f38e7180bae350718e3183b9c5e2f2d7d0dd652e4c751f4feb2bcac8919766242f53ec1d357be4d156db75b5bf69c8c7d8f9566ef95a4a8b4d536dae890d977cd3b55172b3cd8f22b3963c66364b08ec448a25159048c4212242cd40bb76ead5b6db54a4aa729f1b9154f1fd3b4d9afe172fe0730f24cc3e53277f9061437d24b7047b3d462d4fc2bae1f2f2ac996d65d24fbcf69e25b8bc1c78edd6b5d7e307536427b6c561f8b3834bce40d84c320f0220801b893f02075d76f069827c97fea83f3ee64ed9ad1e6dfdc217dc9abdbe2f07c2ed9c35df26cd497f74aa7a959ee8edafbb749ff774f979231b7e36697f8fc0eb760e3eebdf2be98a96b7fe67a2fcc6bb5487ff009ef7b79712466d38a71e8e3673fe5c6d792990927ca91c75f86ae75d71d7d1bfd8722630d9ff0035bf25fe6567c638bf07b5fb82b6bae3d9419db41637996b99d5a390473dc318950346075f9c9a115d66c98abf5159396db9477795dcf364e0ac3931aaecdaaaf6c59a48a5f9fe6932bcf72992204b1dcdf4d2056f068d642029f7151ae5f70bce77e9a7dc7d1bdbbc575ed54a270ed56ffea92e4e3bdc2e5594e3395e659a821c270f871325ad8e3e3905c2cd7113ba3381b158568235075d7e364deaad2848f9573b81fdb667855b7df74686189e4e7b7ddb9e1304'
+N'11c56bfd76686e32f2cb1b49fc89544b3c948fe6a80ea01eb403c350a4531ee4bab2db2c9cde45dd9cb49bf8c42844a8339c572dcff2f7780923b8b2ba931eed340a55249bd29379a103ad7c7a78e9ddd5df4eb1afde4b3d33538b45913495adb67ecfda73f45153b7bdcc8bff00472f8f7f852eee175b17ebb7c0e17f0af898738c2dd60733c45220b1e233b0e233f0281402e9e38619e9f168ea7553738e7cff00612fe218b9676eb0fc93bb7dd29ef259e09b8ddbdd65ad16dd9555e60e3a4b506ab43e029ab9eb7aaf35fb0ad6956cb4bed8fb8fc3f01d99e2b8acbddfd25fe7aeaf6db1d118e47f565fab65db555207561e246b3ed70df849637ac123ef7e32fd906a0aecc8da9fcc4835763e96f810b75408ee5f7a382643ed8ef31d84cac37d9383158eb0bb822de1e232fa71b86dca074dac3a69605b7af9064d7ef2bfedfe679560fbd9c02e73b897e390cd8db7c0dbb3934bbb478da159faf86e6916a3cb51fe151e0ff68e3a92bed9bb11c0b9ecfc8ae791fd54cf86c92c31dbdbcfe8c2c926f6224016a7aaf911a333f9da1d636a1d7ef4ed6d6c78d70e8ade3482d6c72ab0c31a8a222471a05551ec016834d24b1b447f891e7dc56420e39f719c1398e5b7db71db3061b9be08cf1c6caf2120ed04d68e0d3c69a1eb4435d5953476f717ddaeee567edd24387c865f1e6d2e5d4aac9ff5933d16a3ad15d6becaea6ec9dadf01250917c7dba7677b6b8be1b80e5d638c419fbfc6c33cb7b2bc92b09278ff0098d1abb1542dd7f48d67aebd4b1bf003fde342cfdace44769da96d6d26ef789e3d4975fb05e071a5fa94e3b8f6a9acb25cb9fc1917fbb519d43c482257a789a6981b2ded6ea63f203b7cd8f403f1d001de2dc133b9a93ff87421e05349b25747d2b1840f125cf4623f856a7dda6ab20d8e789e25c2307731c76cbfeade432902292e804b28dbf8c455fd23dae753545e241d8beb8360792e7eeacb136b0235f5dc642a54430a7a31992562ce42aa2202cc4f80d5b2922b86d93f237dc2fb73c92d72590cb61f996e861b89b0d6fbae62967954b185a78d8aff002eab5dab2b3787a607cda4f55ae858925ea577cf3bf7cd73f3be2c645f1565737725d456f706379d66b850b4b7b41448536a054131214001546abb654bf48d55bea55373cc31b637ff005b6f6f7d0e4eacb777792bd0976a51e9ba8417da4114118a796aa72fa9350885c97b972dc58a4d0121e79a6b801a5691922ea91ab751d58f5dbe434a0057b49390e6af56d2d806964a903708d4002a49672001f13a56b2aa964f1e3b5dc554b095a76cb2372a105dc7f50e2a215479189ff87a9fc06b07fb8a768ad5b3a77ed5f4eb37bd6afc885ca387e7b0220b4cc42968ce0cb1d195a42a7f88024afc1803ae85755272582042ca7740e430eaa41a3023cc7bf4c0316197832cab8accc86210a6db1c8cc4c9341b47f972b015788fb3c57c57d85003f2f8fbdc7ce6de684c2f405598865753e0f1b2fca54f9115d123821fd342ebfcc143edd1221bb83f72b93f1f6b7b69e6972383825591ad59b73c6078fa45bc3a7eef8684c20bede0e19cd7880980832f8bb88d983b8f9a1902f5afef46ebe7e07514b5253a1ce7ca388ad8dd48d60ed7b631b327a941b834676b6e0b514af81f66ac6a0827240c0de5c58e59268a416feaabdb4aecbbd0c170a51d5d4f88a1d45a91cc0fbdbee5797c1dbcbc6f21b9ac2fe4536d3282637900211a37f02083e1a68aeea51d33c5eed458c458d2a8be3d3c86ac673ec75bb6cf657551d5312e80d29d3408c0b796803c69635f31a00d46ea3f02c0690188b888f48d8bd3c69a24707a67b60d466007b4fb7d9a8ee43da08cde66fe289cdb8560074a2ef35f6f5a0d2de4b60160cee525dac6ea4241a9a280b4f61006ab77658a881bcf793f293c6aeedf1914b777b71134712c20000bf4249240f03a1ddc1bfb62c2b9347974aa72ca266e4193c35ea2e7f1724023652cb731b46adb48246f036f5f0e875c9b52cbaa3ebcb9bc7e551d71655a8ebc8bbabc0797f7031199b895acac2dfe9967b7954bac2b0b6e64052bb949f303f0d6bcf9eb96b45d123caf07b472f81c7cf5dbbad6986bf8bc873b1e4d8ee67dee8922bf173c6a082b1d9c8c7e9ae25850942617a0621d891515e9ad99732bdeb4abf96353cdd7836e1706d96d475caeda3f1ad7a7e249cfcb98c8f6ff002d7ef1361af5b266c305f421ad2628cc2045916bd4355bc00e9abaed3df1a2af4ff1f132f0953167c4adfea2b29c89f4f3fc1093cb3ed884f72d88b3ccc37dcaa0b517ef6f2c4d0978c9a53d425958d7c2bd75cfbf02cd297f333daf03def4a39789d7127b66663fc229d8b8ee6a4ca7f488ad64b8c83168d20887a8f2100d766dad7c0f86b96f1dab6dad6a7d0edcbc2f0fd5764a8d75f4633643baddddb2cae126ce879a5e292fab8f87216de8ad767a7493688cb5145075aeb6ff007796b555b2d133c7d7da1db732c8f0647f3a8d1ab46b3a12b29ccf9ef21e6b8eee4e530735c62307243bc58a482d82db12485924dc012ed535e9e5ab32726d99d5ed7b6a73d7b7f170f8d97894cd579b2c75d345e1e2147efb715b9c1f3bbd63716798e5463871b6d2c65ffe992058402f1ee40412e4d4eb7d3b8627676988ac2ff1f13ccdbda3cfc77c54b639aeef99a69a5f37ee15bb0fcb38de04f23c9e46fadec6e56c921b48a69163925a09246f4c1a57a851d3cf58fb6c6e6db3adefcadef97152a9b497979899db4c36232fcfb138fcd36db1c85cfa771f3988b16462abb875059e83592ad64cdaf8b3d0779be5e0f6e9c3a3aaaaf816967389ddf0ded8f37b3bb2f6d86bd9be970505c4deb7f2e601032f53b4b3b569d3c2baedd31aa3b47e948f9765e65f959697ff00f278b4a25ccce9e83bc76595b7ee8f1ab5b5b16bac44189bab5b9bb652d1c3511edea3e50c7d255a1f1074d694aaff001d0c6ab5b2bd9da1e90bcfcfee13f137f0dd7767930882a4697e811500551f4e1e1e8074f2d5176967b25e48eff3303af6ce3d9ff13bbfc460c5f62bb586c7276cf8b578791c91cf9346965226922769549f9fa51989f969ad2ace64f30d2e817caf66fb6794b5c5db6431305dc1c76258318b217ffa789482154860481b478d74bc23c0275925a76c781264f299118c83eb791c4f6f959fe62d731494dc9275a50d3cb539733e285e00ac9f637844f271f4b1b68b1565c4ef4e46d60b68eac5cb7a9e9abb3128acf467a025a9e5a53f2b5e62f1919f9071bc06771e6c335670652c59d6536f748248cba568c54f98ae9a9181e2ecd76962b79208f8e63121b8dbeac62d936bfa66abb853ad09e9a41214c8710e297f35a4d7d8db4bc971614593cf0a48d6e10823d22c2ab42a294f668f0811b30dc6f8ee204a317636d8cfab6f527fa48921f51fafccfb00a9ea7a9d00cd991c4623208897f696f7c90b6f8d6e624982b786e50e08074023dc8e3b1b7d6c6daf6de1bdb762098ae6359a324781dae08d00611e2f17158ad9476b0259a7e9b65891611d6bd100dbe3eed090499aa471a044558d17a2aa80aa07b001d34d099527ddd43bfb4dc907ff00e3d5c0f7acaa7fbb42ebf60fc0e28c90693078a863058ac77121f76f9d80ff00c3aad205d4facf17045b5ee0ef66fd318f32752818c588b3c145125ce551af4835871b19315a803f7ae241f33ffb89d3dade5a924032612f6f795e64584b90b5c162eda37964b9b9221b2b689051408d29fa98aaaaa0af5f0d4a67a11d1168e3f1fda4e27c79e4b0b45b8be78123c8f22cc9219d90ef636b6ec4ac20f80ad5a83c8ea5585ea46d22ff0038fbc8cc5df1bb3e358cb84b4c361e092d239acadc433dc472c9ea383b8b33976eae6465427afa67a6a3be3a1289ea54597ee8e5af2e64fa773898e607d5ba52d717d20fe1694d08aff0aed5d56dc92e82d9cdac33fa966ae9386dff005529df3ee06bb81f0535f675f7e8025e539ae6f296ed15f2c37334a02bdcb44bf5240a52aff878e9124a41c906d78d656f95dc6fda41da0f89ea40ad3da74a6495b1edea3c662d30f611417903fab8e8a28e4792d769501d4020bc71451eeaf43b4c8dfe2d576a2b68c9e3cb6c7ad5c3074fdd9ceaa1b0e391262a39885372a00b97f8c8e4d3e3fb7565295af8155acece5b9628de3dc4b7323cf399e7724bc9b8c859bceac7c7e3a9b6c8c195b9ac06427f4756f80f3d4531c1be91caa377891d1c7f7e802d7ecf5de0b90e2ecf8c3a0b1c8597cad6f132b8bdb6446669e1175ea442514f9e2a01256ab46aea0d134c83ce3b578e8e4ba9ad22f4eced4ad7296b1ba59866ebe9dc404b346cb51bda3aa293d69a241a122ef157f8db910dca6d2407520864743e0c8c3a303ed1a08c0738772dcce122b9b7b1bb6b4c7e6408efd54160bb7f4cc00eb55f3a78af4d49380890cb70fe4d6f69124b6e6f5e767916e6dcfad1491c8d5560ebe4c3af5d45644c76c56438f71bece7290e0e2bee3929bdca246ad798e70231236d059ad89a75afeeb78f91f2d3921244fb61e5fc32db3afc1fb81651b4125cc6f8f6be0d1fa37d6ed41039e8509f004ffba7c74da134756c3c2fb752c5581a7c7301d04322cc83ddb1c5749d8a1e1ab2e993376db7e46f50f80a7857e3a24d50699f337053f931ee3ed2694d291c03ee73174847ace2167e8b53e3f0d26c92a9126bd05433dc9ea6ab461427e0751dc1b4916f0ddc8a2550044de2ce69f881a37790d54986fed6083647d17f89bf7be14d46470449ae2591d5daabd0802953f80d4491a26bcba03d35452a3c1a4ea7f66948e01ee2de189f7104b12e5541a0f690068891f420b5f47216119923651f2d508427f2ae88020de7d24ce21bcdd731cc369468c9427e0c29a1a1d5b4f416797764786646ca7971f6431d9528de849093047ead3e52eab514af8fcba83c547d51d4e377ce671ff45dc793d5154772b8fe67814b0c9f5ed7cad1095dfd2313a383425284d403e74d54f86e26acf4983de18aff0027271e8fc57ee35607ee33945d496862cb4d9418e74b8885cccd3451ba7831462d4a787cc350c97cd5516e86fe2f1bb372b73c4eb56d4793d7e23ddff7ef88f24b8b89efb062ef915c42b1adfc17322c10b46bb4488000cbef01baeaff00ef29669d93948c75f6b72f02db4c95789b9d54cfd9aa61afb73b3e3173cf05f64a5b6b5fe990bb5ac971308a4fa897e401031a31da4d46a8e3537e54dfc4bbdd3cac98b86b1a7a59c3d3c1161f21c10c9710beb1ccc7713b725cd25be3a3c8ec7960824742c6323f4a854764a796ba79126aedf4e8bf23c5f0792f8f9b1db1b875acda1bd7abd7f044696e7897d472dc31b1b6b0e1dc671f14292d8a986e048f134b2ab48186f0683e523c752c75aab2c555a46bf68ed972ce3e55aced96f77ff6c25f89cd9c4bb73272ce5171616372b65631c2d786e2552ccb012001b3a75a9a78eb814c1f532edaf43ebfddbbf57b7f12b96f5dd67a47a8279576db0b61c7a3cfe33310e5ad5e76b668255105dac8accb5f4f7312095e9eed5f9787b6aec9cc1c8eddee77c9ceb0e5c6e966a578a889fc8919fecbf2ec2f1d6cdde35ab43124334d1c5356e22f5a9b03250106baaffb3c8abbbd24bb07ba385c8cbf4356db75d568c8efdbdef4f22c34592bbb5cae53151a192dbea259274094a6f8d1dc9f0f303562b723253c5a3251f66e2721c6cadfa7c3d3c90538ff00773bc38a6b5953233bdbe3ab6d12dd408f092abb764a4a02eca3c3735469d39b96aa1ae84327b3fb7666dd6d6abb6a926b4f82f209768f2b2bf27c95dddbef7954de4ee052adbd9dcd07c4f4d4f8d99e4cd6b3eacc5eecedf5e3f0f8f8a9aaab75459984ef0f00b9c5de5e4178d2438a48e5ba02270eb1cafb158290091bba74d742b9aad369f43c4e4ecbcaa65ae3758b5fa6a48baef776eadb056d966bc792d6f9e58e054898ca5addb6c95534a053d2a743cf455dc3c1d8f959b25b1d6bad3f56ba2fb4ced7bdbdbe9f8edc6662ba924b7b178d2e22119fa84f58ed4631d7f493e60d345791475769e83bf60e5d73ac0eab7594ad747f69a5fbfbdba418f633dc7a599a7d338b76da0998dbd1fad4524523c34febd74f521fecbc8d992f0a31b8b6a44bcfb94edb5acd2c529bc0d6ecc8ff00c814aa120d3e7ebe1a83e5d138d4dcbdabccdaadf2c353fa86dc8f2bc5da7146e42fea3e396d92f86c5ac86191430a2923ad1874aeafdcb6c9c2e3f1ad9f2ac55eb6702d277fb82bf199b391addc96d6974963344235132c92a1910d0b536900f5aeaa5c9a3aeef03acbdbdc97c97c7d15a3775d20c6d7ee0b84dce66d31b1457864c9c29716d218d02112db9b9507e7a83b453c3c74febd776df12ab764ccb8eb3cadaedb7d6660cf09df6e2594e3997cc5bc17491f1e589ae2195515dc5c1213d3218824907c7453915b55dbc8966ec39b172a9c76d6ebf47e07dc0fbe1c5f944f7d0c10cf60d8bb6fae98dcec6536e0ed665284fe93e234b0f22b93a0bb9f63cdc2bd2b66adbfa40062fba8e1ed94785ec6ed2c22203dd8daeca0d48668c7b40ad3757ddaadf36b3d1c799d1b7b4f32ab8bd5dd2974f12cab5bbb6bab48aead9c4b6f751acd0c8bd43472286561f1075ad393ca350f52affb9fb0171db7e48d56a1c4b82a09a1da6be1a17ea0f038bafe368fe92d604f5675b58db68e8abea1692ac7c07ead2406b8ec62864135dc8269875da3f40ff6ea4324e2e0cfe7b242c307657599be90ed5b7b0824b997aff863048d1205ebd8ff00fe9d7f721caf250657270d870ec7c2e2449b332acf701879a5ac1bc961ec764eba8c817a37ff0049fc05f428dc97b8396c888fe768ed2ca18220c7c48f56498fe274fe662d003c87ff00a747da960432e439665e5913c50ddd9a3ffcb1c05b4f6798b708b9ff00b4cfb54b62cb677dc82e88f02b3c74fcda05d45ed5e24b52a2eeaf6f3b01c7657b3c4cd98bccaaff00e44971018a2ffed9962a83fe11d7e1a3419596462c25bbb7a6ce6bd76d6a7e1a1a04d90e196369c2c51b8ddd4100c8e48ebfa7c3498168f26c75fdff0000c4666e8642745b592cd7259b296b630942408ec2d17abb79023a54f80d4468ad6132b80acce6bfaaa3d9edd4a4466d6b1b9140a49eb52bb4fecd203cb1c5c7f56b6f2cc2d20ba758a49e405d2147203390809200ebd057440c60e21dbcb6c825d39be1b2d55d2111c64898a1e8e0920a823af515d0d8240e824bbc5651844e4cd612d55e33b644646a0743e34d1d43a160e6b9cdd49c4e1bfb748e5c39021bab5b71e927acfe2270841dae7c7cbdb5d420948a98fbbb1be6930d76c228653ea59c9fbb6b712790f3f4dab461e5d0e9802445758dc9c96d72a639227314d19f22a6874e08978fdbccf7d9ac14d83811ae7fa5c819405f985a4fe1f31341460c003aaad4965cb2b4a0bc931bc96c6dd4c7919cdb850163bb45b98c00294048afbbc7532868adfbd9f6fd2f3c8ce52c2deced392c7402f2d58c2b73b4744b88cd68d4fd2e3a8f3a8f069c0043b35dcee55676078b77031f7b8ecee1e3db0e424819edaeed63a2866957e5debe647ea1d7c6ba6e191753aac4f6295036aedf0da69aade85e94911396637d630c35771d093d457dba8fd4864be9c81f35c82d62224ba91633e0a5a85aa4f801efd26e492846c89a0bcb7636ed1a3d28db8568750247b6b99b9b7962b5b80d321628b2ab0f497a7983d74a5a1c486a0102833cec00fdddc6a07c06a4b52b66bb8bab99cff23fe9a32686471ba561fe11e02befd4a420832e39239da92ce56421fe772c050780f60d26347c2d2c033305dcc4104ee3e07c478e84e01a9200b7782570682d80dc86b5a0ff00b34868ccac322ab03bd7c54915d319ae6611ad656ddd68081d07c744049567dd360fea78ac1791804465ede4af4ff30557afc46aec4fe568a72ad4e60ed46762e3bdd3b592e7e4b5bc67c75c1929d12e3a024fb0385d4ade640b4fba796c0f15e282e7e8ddf21ea9b31244e6dda69482ea59929f22a50f8549d45f1e9696d1d1e2f7be5f1da54bb8f27aa1538072eb7ce64acd6e2e63c6a5e24b12dcdf3b35b5bdc85aed622846ea10acdeeaeb15b88d39ab3d6f1bdeb35db9f1ab7aaf1fbc71b2e5fcaaeb0d6ab815c8cd656f4bc193495a67d9e4f6f10a14af91f66a37ae54b6f536f1f9bda72cda2b4dea1a887a8579f7dcb673378b6c0d87ad8dc6cf1a25fc5731c02fae255e84cb2471c750683f76befd3c9cd75ac55436b562ed1ed5c6b22cb92eacaae68aafe5fb45fedd77460e2b7f7c8f68f7ab99b71048f032a4b0d09355ddd0f8f9d359f8b9163bee6757dcddaf273b1d294693ab9f4612c1667b392e770c27c7cd8ec7e2dbd6bdc84d189eeaee48ff0042347096014b7563abdbc5685ebab38b6e3776c78f259c395b6b5ac38f59f443a65bb83daecf70ce587d46b3c8e4c87b7b6c9c91c6d27a08a10dbaad0eda2fe93f354eb77d5a5f724fc20f3b8bb6f2b859b05ad4f14f4d7c7a5bc987ad6e21bee4dc532567770cdc7303633c935d452a2c29298444a8e2a08a01e63a69634dd295af9ebf718f25e95fee3ea2ff0052cfe54fafea96c58c25dadff6cfb839c706e2cefb209f48a4168519e5149501e80d1c751d4eaa4d5af95ff0c1e8d2be2cdc0a2d2f0a5f8c37d1fd82b76a4eee417f17eec96320f7ff00edd758383fd4fb0f47ef5fe8617e571330b9dbcb16bdb7890bc37d6c2cee3c86d91c488df1568bc3dfa2add55bd742dcd8ab9f3e38fd58e2df63504cba9d538c619e58fea6282f2eb7c14ddea28bd5764a79ee069ab574a1c9bd269ccacc4dbafdc30646fb89ddcdc927c6c57d6171756feb0b29c422de28d6f212ca3600c0ab101453a0aeacb5aaeb6850caf061e462e571d64bd6ea1aabafc3cfc45f932376f65854922315b584e12da62ac3d61fd40cae4134076bb15e9ecd52ad66eb28d7c9c386bc6e57d3b6e6db76f47e41fe3593bdb0e79996b0e3b1f31bc226436735b1b911471dc37ceb453b4b13b6a756e2b595ed0a7539fdf30f1af8715b364747b3e5494ce85e7dc4abf68f27fc9fa4dd8cdc6dc0a088ec53e9d001fa7c35d0baf91fc0f19d9dc73717fcc8e65b6bfcac78db8b7dbb6c7232a8627c1a4b2276b2fc3d46075c56dd691e0cfabe3a533729e45fab1cd1fdb0d0492eb2716738ecd8d8cdc644e3b1e2d62001dd23597a6410c54536ee3e3abefbbea2dbd60e271560ff006e5f5e76ac8fa79eed095c5b29f4bdbce5700ad6f26c4443e01ae1cffe0d46968c362de461ddde31bf2a37f9997692e20c6e6e5b569bd56cb602fad998794f2dafd5188fbd5a32bab38ed2c8e354d193ba62c96c1c7be4abadab9235f564aedc276f25e1d988f973ddc56872568d6f258544a25368e083407a1507c469f1dd3e9fcfd24a7bb53996ee365c5716d8a7a74fb4bff873e14713c62e1dda5c4ad9c0b632495ded6cb181196a806bb40af4d74e911a1f3cc89ee73d458ef8e1eff29c1b378eb189eeaf6ff1b3416f045432492ba90aab520549f69d4938b0bc0e75c6fdadf2bc9d926532397c6714c44b146b13dc937376c90a08c931a6c41d54d2afa8d7a0a9d0d2d6ff00669c1e6a652e2ffb979888d1a20c56ccc9ec1140634f1f2677d38f3648e9eec77d4ddf19b7ba6c25bf07c44ea24870d66b1c52088f55fa8f45514311e2bd48f026ba55d44c74cc77c2eb1aa6d7051acd3c436095c7fd3c74f628a6ea7e5a76ba425592bae4bce79c65ae25972998bdbbf5bc6169dd2051fc2b12158c0f82eab77649550ad7f29d8fb0ec72a68c456869e26becd449943f74bbfa71d6b2f1ee337b2646fcb30bdcc31dd1c4cdfaa2b52492d4fe327a796a70299298b8cbde3160647777a977624b12dd4924f52752911a635af53d58f99d2026e3b1d7724a93223fa6add5d58447d94563e7a520585858ed138625ccd698fc74b6731519acf6505ede03e49658f8886247933291ef1a20100978be055cbdc5d642db79ddea4d675521bad490456ba8c92372f6f5ae6312e1f276b93907ff0097eb04c07b83d47edd121009bbc75f59dc35b5fc0d6d3ad37248a54d3dbd7c47bc698893c6f397d85bf5b88ab2dbbd56584f832114247b0d0f4d3ea1d08dc87eb1b30d77648f25b5c309236542c048e06e42057ad7cb480b0b85703e73618efeab91c2dc6331b79194b817b15609e07e87d4809f5369fdd936f4fc0e891a4d1605
UPDATETEXT [dbo].[Picture].[PictureContent] @pv NULL NULL 0x876bbb3390eddddcf0da478fc94760c91dd099a566b8a556691cb51c6e145550001e209f08b925a148f38845cd9586529ff51711b5a5c9f6cd6b45563ef642bf969a20c7bfb52e5831bdc7b68e524c77f6b3d8c9b3a9ac6beba374f3aa11f8e95912ab3a6872ab655f4d91da2a1da196bbb775351403f6ea04e0d325f62bd70d6f7371652c808f97e64a81e7e14e9a698a11ab2179726a897114eeac1991eaadd40ffda9a159323b5975db4c8d5b79516429d416a0257dba8bd0b01d9dc3cb129b9b4db185eaca075dbeed42c913ad809716315e1897e995e52433bc9fa4256b51f96a28930ac2912d216a44a47c951d09f674d4848c6e2cdb7f5902ec218a84af86a30324597a4b731bcb2b36e14853caa7409a084b790facd1ee0193a10bd4d7caa7532061756f753c05587a6a684b1e8453d834003e2bb8bea5adc8da13e50c48a31f701a5d091be48a331ed6a147f1561514f7e988133dd5cdbdf3446064b31402403a54fb29e5a1826483711f429f3a37e9702a34f68e403dc1e3a73bc52ff1af21dd711ee84edfd12c7f32fed14d4f1e8c85d4a3887b8f81bbb4cc4cf22956f50ab8dbb4acaa68474f86ade9a14961f19bdb4eeaf6e64c15fc821e4987546121ea64118da93d3ceb5dae3fecd14b468c565e2558f6b95e319db8c3e6615850d56e229c314651e0e8541ad7c88d3b204cb93b19dde82f79c6230c6449b1d258b623d4f4d60650b5308600f523f4eea75e9aabf447c49bf98779381a4d07d25e44974c970d0933a090d15a9d0b0a8d3cb44db3471b99970eb4b3afc190731d96c239dd0dbbd9bf505ad1ca035f6ab6e1f96b35f8b47e1077b89eeae661d1d95d7fc4859b0e0d6b71773da2cb90c6cd69b816c8d81f41829a5639626a357dc3543e1a9ea77abef475fd58d35ff0b7fb51226eccf249c8304f677c7cb65c184ffcb2a8fedd45f0efe10cdd87de3c3b7ea56afd93f918dc766b9ec0a5ce1eee643d498156e14fc7d266afe5a5f432af066ec7ddfb66669efc6dff00c4a1fe28c72f94e7d160e2c0ddbde5a626dcfa9f40d6e6d62328f069288ace479172749def5a6c5a27d742ee3f07897e57f733befe1f3ee4be082bd968e46e4772955759adc80c082ca6b4a7b686ba970d45d9c7f7ae44f163eaa2dd0dfc77b0bcda4c2e762bab58e1b991ad65c61334644ad6ed3075aa93b43238a6ea6b42e2b7569f89c57ee6c55e5532d53daabb6c892b'
+N'f6fbcf8f09b73e8c4b97c7df4f70965eb4677c32989d18495d808743504f868fedadb56baa2ba7b8b8ef2e657ab78f2fdfd0dd1763fbb17995cae47251d925ce66c66de63b85dbf5734f14de9d02f403d3237786a5fdbd9ee6df515bdc5c756c1b6964b14e9a7431c87dbd771ee389e12d116cd6f71b25c9b98dae3e5459aecdc21560843743d47b74df19b5553d0a3fff00438a390b6bff0059e9d34f89393b35de7c4f2fc965b8edd5959ff50925559fea0ac8f6f249ea0565685c0a1d2fedb22b36ad125d97dc3c2cd8a94cd81d9d14752ccb9c1e7f23db87c3e52689b33798e36b753a57d1374c94671403a6ef76b5c37586798e3f2161cf5c89695b4c7ec2b68fedcb92bf6fe2c64b71651e6edb237179130691addadee52356467f4c3020a57f4eb2db87ba8ab3d0f47c6f74fd2e564cca935c91f2cf483761feddf94daf20e399092fac9e1c2436d15ea8f577b35bab467d2aa508208a6e2ba9ae34595a7a18efdfa78af06ceb6dd33eb20c6fb62e691e2f2108cb5844b70f14c9449dba5b2cd466a01d6927402bf1d43fb39ac4f8c9b5fba9db3fd458fe6dbb3afe3d0c78476e386f23e43637fc3afd618f8c9b55ccda5f453192591959646462ed4f59438209f97d9a58f0d1db757482be7774e4e0c0f8f9a2edbdcadba63c89d9bfb59c9497725b62f3696784b8944af1cd0b49728402a0a85608ccaa485634f869be125e3a7912b7bbb23ab7f4ebf51adbbfd0b5b0386b3c460ecf1369bbe971b6f15a43bcd58a42a10163ed34ebadb5508f2366db962e774321736188bdbb819d64b6b29275688032031866aad7a57a695ba8781cc5dc6edffdc2f35b84c6717e319ab8c242aa8d77244f6e974e56a4fa931451129e8a01a1f1f66921ae8317dbb7da88e3fc85735cd56193238f61e8584549edade61521a494551a41b4ed0a68284f523a36a40e829f3173789f4b6f586d1450edfd4e074fc069b62803673298fc75b933491db2a8f195d631ff00788d56c90999bee7701b507eab378e84fb0dd444fe418ea30c6507de8fb8b9f9134f80e34ed6d87354b8bfea935d28f1541e2b19fcdbdc3534a01b92b2b7b2661b625f558f40a9d4e9883388ed45ede2a9390b6b6692951286e84f91a5749b1c0c38bfb7cce54c897f8dbb653f2a34ae887e35435f869480770bf6f59cbc2d367f25059daa10b0c58ddb752353e2515411f13a4d8d2308f8c43c6b219268ad2cb0b62aaa60cce47177595cb12a3aada22fa96f1b13e0ec5683cfcb524458379bf39cedec567899a5b9b6b4c4c2ae3ea484b8f99681a611d02b6d3fa47b7514893629bf2480312b02ce4303ea35524014528aca4534e0523462795da64ec063734bfd46d5002ee056eac839a2b2cb4a353cff0023a8b182b95711bcc25cc6ace2ef1f78a65b4bb8fa24abe3f832f98d342346073792c5e4a39ed266b79a365911e2254ab0fd2c08eb5f7e9f50e85fdd82ee1e3392e764b3cece0722ba5516d717d1a5d5bca105044aac01463d7a86f9893e67ac2c4ea59f91ec2f269eedb9370f1fd2f216ee05cbc16eff004374c3aec78d1db69ebd5907c41d4ab2d7407a3ea72d77321c425a5edac28f6d7d0645e49ece4a3a46f478e5f46400064dd4a56847bfc74c8b3cfb78f93bb18051d14dfa067f03465604501ad349854ec4971f60f19ab0dde5d597502d34ff0046b0dc568001e059a95af903a4231385b650768af4da29ff00eb1a020b46ea91ca2e46e53103b9011d47bf4ecb40a9f5f19ee2d8988fc8cbe03cc6a92d0344ad14d491c8f1a29f0f80d2244b7918afca03b2d18061d0fc34c89e4d34cd12c8a5013fa9695604f9574041f1bc116cad5496daa57f6e901b6e395e171f24625de2797a890a965e869434f6ea7e1241f50945787276caeac1634a9da95eba7321d08b790c65bd586306645214d3a507bf4421cb22c772effac82e0d3627cc47c7a6a206c30bbeede51529e0edd47e02ba6220dc636d617f5209097a5190034a7b813a6099a5a5876025d9b77913d7d9e034c6515f74dd9cb5bc824e4d8a859dfa1c94110624003a4ea17d9fbdab6ae57a955ab0e7c0e70c6e532dc773b15f63277b7bab76dd0cca080c3cd581e8411e20e9c4912d5c7f35ed87737191e3b98c4988ce423643788de92313e68e7f4d4fee374f66a4acd6845a035dfdadf36c6723b3bee3392b7b88619e39e19e66314910460c1ced04353dde3a568681753a4eca58eeee2095a8652cab330140d2a9a16a7bfc751241f6c5a383b97dc352822459f8ddac848641a209260ebbe0d6ac4b2a953e4474d2da357232e1790583efb2ba9232bd40a9234926872993a2e7fce6d23f4eea28efe20286a28d4fc6a35259182aa5d1c0b5cd3b97696f3db5d2e21ad9e32df5335b5a2331069b771880623c75466b389aad4d55bdeea2f66d786ac9dc6bbf5c46e008a49155c742236f9c7c51f6b0d555e547ea446dc69e8c76c072ac1e62167c75c2dc08a9ea280432eef0dc0804569ad58f2d6fd199b263b53a84c1e9ab4acfbafc7dfa1019015f0eb4f66811e00c49e9e1e3d3401f2ab7b3dda607a54eea53ae8118b557c7a1d0334dbd9d942cc6086381a53573122a163ed6da054fc742066c341d34c462d4d202bcef86556da1681adda6f56c66944cac544663ddd4fb475f0d42fe03e899ce197fbd2ee45cd9263a292578eda34b648e472b0ec88041508c3a5068498d440232df755dd39486b718fc518e3fa789eded84930883160bbe62d5a124f86980af94ef3f75f2cc56ef9064a557ff00ca8a76853e1b21da3f669c8400f2d737a9199b2323bbbf5513bb3cac7e0c49fcf4a0004c66bb97aad17c95748063e3780b58a3335d47ba4624221f60f0274d004a6b5cabff002e1686de31fbb19d9f99a03a607d160f3fb44893c640a83ff50a08fdbd34a0099027388632619d9d81002ace8f5ff99b401ba3cdf7420a1f424980f02220e3f38e9a003183ee2737c6ceff00d5b7189c25208df695f53c9ff5d0ed1fa586868242b92e71dbeca235ae4121707f5fd6d92c80b78d3d58486143a5b4720eb8ecdf18cc5ab4d819238a7605945bdc7ab0d69d03472ff3141f8f4d458cafaced2fb11c904179bb1b736ce639d255268a47ccaca3c55868802c9c1c56398c34bc7cb896c320ad71899dea4c572950003e3e20a9ff00b751e83ea57b756f2c523c322ec9a0665743fa9594d194fc0ea48413e279b9ac790d85daccb135a5d4328a36c7a248a450d41af4d0c11dc795ee5e56d31c5eeb90ff0049b38636f4618ee83cc005345deff2a9f7053f1d42b9afd1163a238db9f5ecd2619dee1bd4b8c85fbccce6819f6ab12c6800ad5c5752456c25f6df651fff0035b0b25c494b7b5792f775372a88a1722b415fd440d2b32545a9d3f94e7dc3acc0f5ef1199e84188163d3dbb47f6eabdc5d04393ba1c2981f4ee6591bd8b148bd4fb0f4d322da35c7ce31b2a168e2bd6756aa21611d7dfd5ba688922da2ea96581b706d8e4f4a1af5d4808b697b2c5be165f4d63345a548dbaa9a865aba11b2d7436acbb43943bb70d45924790720859e93d640a768f4d7e41d3c4b7e3a8ab0dd4dd04e93ca40089075008f3af81d4c8c99fa6f00511d421001dfd68de7e1e5a4d02664b945b6986f8bd58dc5188000f7753e5a1032648f4540196381bab245d09afbf5392106134db5aaab5e9e09e43dfa500991278998192202228b4dde44b1af5f69d100c8c977404ab023a569e74e9a008b7f9fb3b3982dc4e9135c7f951b5159bda00f13a18037339e5b5656f54a3cfe11c69bd8a8f1f1ae9a17407dc72059637f4b7c951b5d256e9461e0453c0e9a4328aef276056fe69329c56dd6292425ee31e4fc8c7c774153f29afeef86addc995bab28ccae3b238dbd7b6bb8a482e223b5e09d4c72ad3dc478699108f1fee6f32c2c623c6652e2c9075f48b6e8c1f7060cbf96988e97fb74e579ae41c12cb25969feb2f24bc9a26968ab558e401451401d06ab9d58e0b851187c356913d4886e246803d30823db5f1d006996c92b5a680281eedf7239c61f9d64ecec6fe48aded66ac10ed464daaa1f6d0a9e9ae7f232dab9213d343dff6fecfc6cdc057755bdd5ebea8072f72793e4397c2d0df4a2cae7216eab090bb45bdc4eabb0823f80d355acd6793ae85dcbed3c7c5c16d516fad56a02cde1f2796bbca4d737751853bd44cc7d57f56731058c8f652a74acdbdce7a173e1e0593163fa4a2f599f20ff11b3ee15b71bb1c8e22e67c3e0ee048990c87d46d884f6d24884b55c392db00541d2a7562a3894e11cae33e363cb6c5f4feae4df10d4fca5cbf6e9ce390f22e317dfd5e63792e32ec5b4770e06f646851f6b10054a93e3e3d75a38b7b5aba9c6f71f170e0e5bae2d2b0b45e0cb0aa4eb51c12a6fba7c9e42c6c7133dadc4b6bd6e43986468f705546a1da4575939adaaa8f33da7b3e98ed6caef5564927aa92a39fb87c9eeacaced26beba26d1a5b78a4333d5e3958ccb535ebb41da3e1ac17cd675493e87ade1f6fc18b25dbaa7beda68bf9642993cc65ef578badce4ee2da3beb3b586eeeda466291fd5c90bcad5615da82bd7d9abb2397597a3472b83478f8b9ad8e8ad7ae470a27c43dc1bb919d8f8df2dc45cdfcb7765698cf56c6595c978e596e05baed63f300e1ab4af974d4f0646ab6d652933773edf89f70e3b555576d6cbc340afdb1f723273e4ffd3972cd7b164d6eb2715ccd2bbc91087622c4a1891b5946ff0089d5dc7c8d3dace17b838b57ff00f62ba2bd9a4bc21747f6976822bada8f2e7cc4786988c1c8eba88cabfee3e5b88b16d24476838eba8a4a8246c7e8750b3e82be9567136370992ba98fa50bc9bd89aa83e27dfa9224ba05a4e1f8db21eae76ec4229516d07cf291ecf77e3a70120bc9725b2b7057156cb8f84740ec7d49dfe2c7c3f0d1238012adc5e5c7a92b16663e66be3a4016b4b1168a8ee851a40195dc6d041f35af88f7e80242676da373ba6514e9e209afe1a00ca4e5563d07a8189e9d2bd0fe3a00c27e4165d76b8a1f21a240c5791d905a2f43e1ba9d74480470f94c7bc2cef3bc4e87e5f45cab7ecd4900562e590c4a7d1cc5d2efa1659419012053aeead7480833476d7570664bb89e496acd55f4c023cc81d3f21a6234b7f578087b79e2dc3a868dc57f6d348689dc8adf91f26b0b5ba8e1fadcad9eeb79c978a27787a3467e665dc4751d3aea030df6e6cf925ad932e46c26c71c75cc52db34b1b2ab0941de1588a1ea80f4f6ea362488bddcc74767cde596200264162baf97a759968dd47b5949d004ff00b7bededbf23ee359dde462a61f052add5fdc75089203ff004f1b10411be41e3ee3a1f41d56a5f5df6e4cd88e2878f958e6973a1a38ee5422388108322ca800f988340cbd08af407c60913bb839abb91789264e1c7c3f37d1a6c6a7819643b987e0368d588a9b2ddfb33e24ff005592e417918922b78571b6c0f809252249695f62aa0fc755df52dc7a17f490e2593e6863a0e9428a755ed2d923498bc34ace0db42e3a74312135f6d7ae8e844c05863a192b144b193e71c682ba7222cd9a3b4da761dbb4741e7ab080bf7b9cb4b5c946667f48392a55ba0ebe7d350bad09d1ea4fc8cb6ad8f6990970a2b404053f89d56b527d0505e5063768e0aad58d51da8807bc0d26483d89e458e6c7a339f48b36dddd033b7b17dda75642c8242f212a0c71b303ff00980507bcd4ea4c48d4b76bd502fa8cf5eac6b407d9e5a89225e32688563b9014a0f90bf41b7da34d1164c5cac773101671a88e2f95ee1c1db5ff000f9b1f874f7ea7240837f9509208d7a853e2695af9934e83e1a18d036e2e5d56b14618bf52c3a74ff6e90c8ad04521124e456848f3a0fc74319aefec2ce5b62e48f5101f4a5a7e93fdfa27c042e2ad959de19678d9d883ea0500063e4457cb48688d94bcb6134777b258e24aaa451bc6a097a0ab0f3d37a848bbccb8b613905b15c862ad726a5488ccc07aca0fb180dc3f03a6ad046d52a1e49f6b9757529970929c62b357d2b8669d141fdd50406fcdb5359110742e4ecaf14b7e35c27178785c5c3da4ac6e6e07ca24b9793748c0790a9a0f7684a045b5b49534207bf56959e6f51e7b49e87a7b3401906f1e9f0a68030fd46b43d34c0e71ef1625af7bbf928907cc9eadc003ad7d1b42e47e435cee4d77646bd0fa4f6ae47d3e171dbe8ed1f7c8a98dc6bc535964dba2dde5228907905b496053fb49d515ac6d668e6e657c7caaafe18fc870edf76e311cbfb899ac764a7b8b682c44b709f46c91bb39b9286a5d1ba01ecd5d8f156f92d3e673fbe773cfc4c187e95a37575fb90d3dc7bfc17135c6f06971717fa365855d666697ea23914b96943a9f99c3f535ea6bad19ad5a455af959c9ecdc2c99e8f918aefeb56dd256abc493f69f91bc7c2e6e0ddbec6daf21307f089a48ab280479f452750e1cc15fbb367f77f2c4ed531e61f7ecb13cf97932676f6254bc5bff00a0551e9920ee3116dd5d87ad453c357bc49db74b939b93bc64bf1d6075aed5e31f369ea2f7dde32ffa5b1b213b42cb72bb8f855a2141fb355f2d7cabe2767da7755799371342a49f8c18f33716fe0987c7ff005103fc32081109f7526d64787f51e970f73adffb596b599fb141365860b9b1e230cc4982ec25abec62a5e3395951d559483fa5a951a76a4ba4a31d795f4b8bca74b4595db5aebe1d0b939f761b0adc1aeb0dc3ece0b2b9bdb98a6b9f5e79775c471065d8f33976a0dd503c3f1d6ebe19a45743c8f6feedf4f3bc99f7649abaf5d75f52bfedb62f94e2fbf7638d93d18b276cd3477db29e8fd224359163a201d54285a01e1ac98b1deb95c9e87be7338d97b763545d7f4a9d6bf13a19586ba67833e2fa00c59fae901517dd66496df1b688dd16ea19a10a3cfe65a83f1074afd1075d0e49bde6396949581d71d0d2812d7ac94f617e94fc344928074f3daac5ea3012b90cd2b4e3d42287a5198f5afc0689009f69bb6589e5fc911f3d7a70782abb4b743e553b14b7a48cc18063f03d2ba5232cfcaf29fb3be0caf6fc7b0039ce72d87cb719296492cc48bee6f95bafb174f423a953f71bb83c8b9cf2993399b68cdc4aab0c30c11ac56f6d6f18a47041120a2a20e8aaa343634803359184ed602a406a1a5687c3c348660c883c547e5a00c4b5b06a1da3401b4246be2a08f6e811e947037c43dc40f668036451cce9bfc857ab1a7f6e9819473cbfe5a1a96e95f11a00f24ba51f28eb4e8d551fb34806fed6e439163d8de5b612e33d6b7ee2cd7d18a6244a06fdb0491ab28929d684374f11a449168dcd9e45f1d049718e9f1ab2b215facb57c75d0650d51244bfca93c7fcc04ffc3e1a85992484def94318ce63d57e675b18b71f3afa8c069a10dff6979fc3e1acb93dde4e658e1b87b5b68a16affd449b663e927eeb330fddf3d0c9d7402f3be71773fa995be95e5757921c65bcee642911626342cdd48407a93e4068822d95a5a477b90cbaac05e7bb99c0083abcb248d4a0af896269a6c8a3b1bb5dc2e2e23c1acf0e515eec0f5ef644a00d753fcd21afb14fca3dc06ab2f431c6cac0914143e05ab4f86803df4ee6bbf69653d68286a3e23404a317b99d416f4cd09a7cc0f4a7b34408b08dc42ad5406ac6a4b13a6448193b4b7b88dd6528d1382bb5802057cfdba4d8c56c84cf61945c6c97664b49d2b1c657e51b7f741d56ea9134db2367f1186c7d82e4a25698b7c8de97cc5589f161e34a7b353b556d92b795a7a92aceef0c30a2f71f1c9288a4292dddca8487a8a0f4cb74247b3c750a43ea3dfae86fb0e6d8fb5c7a985db22f23056dee03ee6343d0f801eca68e9d49cf90f9c3b88dce696596e678ac2da1da1ca1590ee22b41d40f0d3aadcc7e0344784e1b6b0fa76702dd21204f2dc02ece074e953400fbb5a15125ea57b88798b0e1df4f1c6fbec9fc145991d3afe9da4ff66874ac0d6a0fe43c36f315611ce6d9de29d0caa6946507c9c75a1f3d57b3491788b02de458cdcca49f58d13c9457c947fd9aafd49305cdea2c8c62042a9a1f0fefd263225cc63786667663e55f94574a420f9ed526458db76c1fa5940e8479d4e891c10ae6cad6d8ac1b37495fde06847915a8353a4f4036c36261996688bdbcf110eafe055bdd4a693d462e77372c983c15ce4a794bdc5c3330762c58c8c2a58575762acb929bb5550803d92cfdbde70f4bd925ab3dece5b70f0fe68f0f76a4dcb643c11691e418e634f5d4d7c369f2f6506ac9226c19ab675a465989f008ac7fbb4481b06517c7649b6be3b0ff007e9c841b21bb92426914a7d836f969488813701e3d779f398930c92e5763466e9907a851d0c6c0d5a86aa4af51e1a1c3725ab36449577385ea790f6838ba62ed6ddb8f5a4705948d3db5bc8b1bfa5348db9997a9ea48a935d285e40f36473f33d7aea13c5f6d63b5be9f25658cb5b2bdbf15b99e211a4b254d7e765ea7af5d3d08bb59f57248cb76da5cada8b5c9595a642dc9dde95c859941f6d194d0e98ab6757a383761bb65363ade3b3c745638db352691db8f4a2527c7e5441d4fc34909b6cd93f1bbf89d87af6f26dfe02fe3eceaa34c447b9e2b7573094b84b79d07cc23947a8a48f73291a240f1b8ad2ac56d37ba089aa054a7f09257aa8f669c81a9b010449d3e8d0422a806d0a3af82f4e9f86901848675507d4b700f89328007c7a69b604597236a92ff00f88b1dd4f137081bfb2ba24506997905a442af798f5a7f15e46346e08343735c12f593278b41e55bd8bff7b46e08215d773b8cc52157cae236a824b7f5087cbcbf56891c15ff0071f9df10e419fb3b792f71d25959595f4b24df5114b1191d163080eea6e00934aea2edd08a5f37d871935ea6f211852a40d364ccd2da4bc8994b10a7a74d0d811c4b98c3cfff004f23c2ad52190f435143fb3475022c6ca8c0d7c7401296e0ed3434245030f115d006ebace642ecc46ed84cb6f125ba5142523885147403afbf4a00d37b302aa63eab27ef7b3dda6068856349d1dd048be6a4d3c74012cc96a59cdb96106ea28948dd4f2ad280e840cc44db7a03e3efd311ada63f1fc7480c56720f868185388715cff27cfc186c341f517b77534276c691a0abcb231e8a8a3ab31d26e0123ac3b61c36db8ef088ada332b3f1e99a4b520bc65df70965b89233e0d344db47b1283c4b6a96dc97556847ee86620caf2bb6b2b67f522b341b8eedc3d493af4a7ba9a688dba947f7472897fcc6e0ee0d15aecb646e94a5b8ab11ff001575611823f1abab3c6718facc94a561b89cdc436a8419269221b14aa9f000d7e723a6904807399ebdca5f096561b8fcb1c6bfa234f2515fda4f8ea422effb58ed01b709cc3370b248772e1e13b95daa28d754f650ed8ff16f66abb32cad60bc567893a052c6be12125a9f0075149961ec92a1058c6c0d6a050fe7a50c0d325cc618955d8cdfc4c2bf9574430335c802082a00a7eb66e9f0e874e1911e2ff3f676fb565ab22806a809fcf4a41202e539862da4682367eb50c5232c003f1d1238913b156187b7e4af7937a92da484d219a47645909a168c313b6ba86453a92a683bc173c752e2358dcc2ef41e949520fb813a9d2d046e807ccf8764ef32a23e3f1c96f2fcb705812b0c8d5f08a9450c3d8753c8a7a2ea6652991a1b26db22cf6cd2e56c486b88c26d92307a6e9828f6f853c749a6f47d4b2b6486aed5dcdc5ae0ee6d0cecd1dc5cfaa2373b76cac005017c7a8f6ea356d5997a87543d63722ea9e8cc361af4a8a54fb2be1ab8a9927057564390a5f4d18b830315b7894866793c036df60f2d0f51a70860e71c9ee5309eb194a4eecaa235504827c47e1ab3c028b510f298acc5ed8cb7912074b78fd46006d52a3a91eed50d6e2fb5521705948f6aee17711f3353c36fb46a9488335c56721f05321f22054fbb440a4f6559a34afa726ea508a313f1ad34e052444b26babe0e61769630763386f96becae8184cdb5fac0127f4e43e019ebb857c7a8d090b4
UPDATETEXT [dbo].[Picture].[PictureContent] @pv NULL NULL 0x39f3eeeb975e2e4adf0ed3b3476b012cbb99947a86b4153ec035a28a2a516d595cf6b394f3eb7c5deaf1e7575b79448d1ba2c8159969b806f0ad3cb555dc58d1871ab2d4b238b77613e996f32fcbb1f1c663567b586d8a5d2ca3f529dd1d075e87a1f76a55d4a6ca18179efdc872dba885a7019ee249ad4992f2ff00d246568fc02a23a7415fde2353d08c32b6bffb96fb8492fe3863cfddbcb772a456f6d0a45ea3c8c4288d42c7525988034744038f757b87f719c27271e13359a9ecf31f4d0de4d1da5ca4cf099857d398814575f02079f9d35149c27e636d7808398fb90efb2bac11f2cca89e4219ca5c32903c874a78f89d4909a25623befdf5bebf82de4e57999bd49123205dc80b126a40a11e4349b048b3b23cdfbbaf776b0c57b9201981f4e49e52d230ea514ab935f01f9ea33a1381821b2ee65a7039f94727e41362c1b85b7c66326b875695447eac84cbb87cdb4d429f67974d349b91384513ca7b9fcda7ce5e38cce41606958246b773aa051d0517774d4888b97dcdf93480a9c95ed0f5a9b997ff007b4d0883feabe41baa721780ff00fd44bffbda606d8b9967c0eb7b70dfef4ac7fb74a00f1b96e6ba9fab9413e62420feca69c011ae33f7f37f9d7124bfefbb37fe22740115efa43fbc4fecd00687bb51d0d3fb74c467636f777f790dada45eadc5d48b0c29d06e77340349b1a438dc7dbef716df1d35f5e2d95bc3691bcf2209d5df6c6371002822b41edd477224e8d220c56f17fa77d20a0ac70492b7fbf312d5f71da146aab3d516e1a4ab362c5b46598c8cbb053a7fb757940cdc5b8772ac8c6b3d859cd736c4d0155db1914ebf33517506d124984331c173ea0457989bc5dc42ab2aab2ef3e146562344840b194c55ad9dd1b2b98ded6e6027d54b90d1b820540a53c4f969c8a0193fa6bfe5835f67b06a4236e371394bf327d327a9e8aef75f511081ed01d96bf8689030b375a189e851bd87a83a00926c03a46e922332bb06880208402a1c93d3afb078681119c340c0b74592a406f023dda066514a8c078027401eb236ea7869c81f28a49d3c57ad0e94840e1db1e617bc6f2125ddaac13c773e98ba8ae8948ee2389b788598104296a161e74a7857507a93a96b71cefd734c866aeae21c6d8c36778b0a4ec92492a47244ac098c2b0ab3a90287a0db5d4607b8fb31978b05c76e3273b04bcb9568ecd0f8b4ae3a301ec03f66a48894d64ef4ba333312d2550357a915ab37e274c19076dcbaa3056dadf2a31ebf86988ba3b23f6e390b878337ca6d8c36b1525b5c74807ab393f3069d2a0ac7fe06eade629e306c955178bed60a2480a6c144054a536f86d0afe1f86a2592456b3e3866ff00a8b22f3b350c823914283e75029fb7480231e2702c9fcb863217c194d4fe249afe7a6235cf698b826dde82468dd030507e63f86901f4d8dc6bdb94f490873bba014f89'
+N'a75d031ea7961321deaabfbb57143ee343a5034c5be478fb9da655025dad5a46c779a7c052834c520ab4b7ba8a3dd7906d8f7577d4d36f9135d44921e38dc38a9f1ad3ddcac233d2158e312b6f03a924914d2a44eac7693d4ccd3758bbb413375b773d457c8fbb57d6c93f429bd58078876ebb9b63c8e6e44f7a67bab8630fa15122cf0d6a03b31a003c694f8693c76b5a67a742aa7cba3265b72781b929b9cb3456b3b5c0458a352aaee8c05694e94d559a675f03563885039e6f34f04e7e63274fe5af99247b35a0adf50d718c96331387566eb94947a8cf4f066fdda9f668af9b1dbc902aff003d364f91438d80b4d2487d6bc9035228e38fad49f8fe7a8dec4f175d060c8739e2d61c3ef30b6d38b9cacc8f1c51c4376c1279bd2a0003c2ba2ad55ea4f2a1063c95c8d96502996eae182aaafe9507c77378fbceaa5a153721a5c15e6c58e25924d94a9a52a4f89f769c09b3d4c26423218c6ede42a7cbf0d3da45b24c56574b0b05b6259412083d4fbb4e01b20c98fbf2774d0146af406b5a7bfc46940e4e2efbacca4f2f767280b954593d309e5fcb1b7cfc3c35a2de0bd0a578b35fdad5c493f21cd5ad6a9f4b1ba06ea091275fedd64cba591bb8af465e3c63ede3814785b7c8418bb7b89aed16791ee4bca4bbf53d1c951d7ca9a9ad5155a130177538bf1dc1ddcf961630e32ea5b51f532db8d8b22435da3d3534a83d01a54ea691537a8b3c43b6d82ecd5baf743b8a915cf35bb8ccbc2b89f4792de595770c85eaf82b2eef914fe9f13f3528aab7eaff004fe7fe445b8d175fc8a4f9a730cae4723799bcc4ed7994ca4ad34b2486a5e5635ff946a4dee7234a101ffd3398b3b68b219189e1932518b8b612a952d0bf84bd7c8f97bb408d9c76fa2b4cd595cceef142930791e1a7a8aa0804a57a5403d2ba4c68e91e1b9ec1e1b1326438f63e6cae42ea18be9eff0022f188e2532b34ea1f7100b45450ca01ad7e1a8a5aea36c43ee9f793151bd32774b9dbdb69a4bac6e2ad189c759493bb39de4feb20b53e1ab3afc0895ff10e01ccb9824d928a24b4b276765b896aa8ef5a9541e240af8e90e09971f6fbdc322b125b4c3c05260a4ffcc0698a0117bd9ee7b6ec4496d06f5fdc1756e1ff00052e0fecd391410dbb65cf893b313732d3c7d25120ff00b84e948e0d3276ef9da121f1178b4f1ac474e4219ad7837316ad31f3ad3a1de0253fe6234a5041864384f29b4b369eead5ede11fbe597cfd9426ba250a0d52709cd451ef95a38810080d2a5483f02746e1c12b01659f5c85bcb8993d0bbc7a89566141b19ea2a2a08d271e20a7c062bfe4bdd4fe937105e64cc96ceae260515dd95850aee2bd053d9a4a06db34f1eb769f0172180ea117a78806303a7e5aaaeb546be3eb8ec478f8d5aa5bbc46d04acc2bea492d1853af4a103f66ad932404ecb2bca2d6d22b5b52c96f6ea228915d880abe006968396637795e5f3b0de6590a10cbb98b0561e0403e7a210a4157b8acbdece25bc57b8baa759dcd4b7b8d7d9e5a61d4d171c6ef13d359513f9ede9ad0d7a9f86803cb9e017aaa5eb180a2b42e0ffdba720d03b25829b1f0c72dcaafa73f45643be8479353c3a69a6236570debbbd8cb24a61da15a4409ea29e84952c69f9e988ca6c75acf5e85e86a76d28a4f5a061e3a8b63836dbe0304c6859c11e20903ae891a446cce2b19026eb799d5ff00f4dc6e53f023a83a72268d58fb3ba9246575ddb42aefe9b7a9a7ead2601ac361e5b86117a8a910729208c55c807c9bc003edd202cac7261b8fe2229ef36d959c5d62b74ff3243e3b557c7af993e3a4311f9af37bfcf645aeae7f936f17c9144a6ab1a7b079163e7a62015aabdcdd893e58d4745f52bb028f0e8012740cb0bb6790e0d80b84bb9ada4ca6456a5679148488935ac280514ff8ba9f8693249168d8775e0b87df124c54801576fed27489c072c39b433b282a449e418f51a04138b34efd454d7da74866c7c8a6dfe6a98faf435f3f6d4680335bf9f77460140a6d60ade3f115fdba2047b712c7347b1faa95a1a90457e1a2007795eca09646b89186ff0004ddbc923ceb5d2046b8b31c7a2be8c3b06a36e6b72f469101a95dc7c2a351bad06999cd6f65c933725961961b082466f92e2e2912051e0b230ea74bd3c47595d4971612eb15035b4732dd32aef2d1306029d0f51d0e96c864b718168670ab750198f886a787e23c3486d132cf2df42a191d923888622562549af8788a6ad5920aed8ca5792f0ce49cb7bd8d1636fefb10d90135d5835c50d842f00f51cbfcb5dbb4123aea5c8bd6fe1d742382b698f22f7b896cecada29efd92ea48114339a84765142cbee3a7495549f817e55ac8a9c97b8f90691a0b1458e9d214507a0fc752762886cfac391de595a7d2ac8ffd5324bb848280281d599cb78d2b41aaa63534af9113f1d0bdbc1eac9413cbfe6381b6b4f36f334d2aa28bda58d7c3b196b696a72f79b607653e8abfeea7b48f69d496ac83d024f9fb7d81d656d8c2bf2291a722822cfc9b64644504d712815f4d83203ff11523f6681c1b6c791ccd686492d5a39075a170e3afb0855fecd098a0fa5cd4f24650a0d8fe4c4f4f86891c1c2bf7676935977c3351ce0a7ab22dc42afe0639577823f3d5f93587e8555f2357da84f4ee15f464d0cb66c003e068e0eb267ea8ddc4f13acf817703b75363c6125bd8e4cb6155a2bab488b09942b1a555875f1f11d353a7914e6fd4ce7cef8f7cad6fbb8c90626da3c9d9e22e9659a395bfe9de5b7358a172bfa911806929fa8f4d5d9128829ab6dc955f7139fe73359cb9cf724bf932d99bd62cf2c86bf048c782a8f203a6a2db63492197edc7edc737dc4c98e539c31d8f18b0901863b9562b7f2466a618c0a7f2c11491bcfc079d20dce8869789737dcd7604726e1f6b92c00b2b6cde1e3286d2295214b987f8137b01b969f28af5f0d4e911042ef5938f72465b69dade65314d03323a3746041a1047b88d3809349cddeac3e824d208cffe586207e5a6013e1987b9b8cb45713630e5e046a8b5924314723790908ea47b40f1d45b1a2e77ee57712df1c92c9618cc75a4002c7129dc100e814228f2f66a2e10dd81d6bdece7390ca2d95ac1692dd4a0954f45632028a920b91aafea4f423b9be815398ee15d5984b9b6b2b9751d61ba855989f61651b49f86a69bf126a4d30dc73e886c8313616a7cda14d9f81e9a728353727faee7afaab6d0d7c6a0bfe1d29a52323cd616d1dea4793bab28aee5f9963352483d01da49ff00668036371bc0e52e52c96e71f7375b4cb1c2cbea36d5f16095ad3407506f3aedd3e2b8ddde51a3b30b0c7b47a68436e95822d012456ada957a8acc48e3f88cd62b197190bfb0b8b681e736ad3346e515e025190b291421aa083e7a2dd4489f9182f2f704ff00c892213151bd830a213e3e27d9a5d0694b488fc32d5a3c1dd28dc40959236a753b4034e9f1d57772cdb82bb6b62664317cc4ce5ad60b99052aa5898c569e6bb756686272416e3bcf5eacd6ed527f8c9afe674e50a191a4e27cf8b53e99fe6ff115fc7c744a08307e0fce88eb67229a9ab97a823f03a250a01993866c41fa3ca064b895e399516a4fa6b51e27da74e402b8ac35b4f537111b55f232af4607dfe54f7e948c3b1f6aa1bfb5296f25a95203312cd500f810145749b249212b9df6d73bc6670f37fd4584c76c579102118915dac3c54fc7c7534e4835006c75f5cdacbea427fde56eaa47b08d001a8b3385bb1ff551b5ac94e8d17ceb5f878e94049b61b7c5c87e5c822a8fe3a83fb748726d5838fa1acf9012007f4c6a589fedd0124fb7e7586c645b313665e70282e6e88241f6aa8f0d10009c9f20c8dfdcfd45f4cf2cce68a0f56353fa5147869c083980edce6af963babf8fe9e106b1da10771f7c9ecf869492550e41da65f5f72c66207a903a81f0074a47b603361db3b48cd591e4e95f1da07f66800e6338d25a4612283d351f378927afe3a404c5c465236062a0a9dd4dad5afc430d00993e093376d186f4f7b56a4d3ad7f13a20249033bc9157a45b09f02511c8f8d5c0d3092745c8898c35c193d7028e760153ff000d47e474a00c973d632c7b7f92fb7aed67ab0a7b40f0d01a966e7b2d8d4bc5c6ec699e652c1594af541d68ded3a8f444d6ac118ae0f8dc85f7af776d2c4b19fe4b2c9bd874f025bdfa859ce84aa863b18e7b5bc4b458a3fa7dc104bea0dde7d4ad06a2eb04b7485ae4dd477b1d031b6552a4f40403ee26b43a9ed82b6e4f6296d262d1b782aee2769000f8d34e3509309b136f730158a43b58eef94871d34a092b11f0577371fce264aeed57370425b6c22aa46f14f0f03a8ba6b2595b2f131e63dc6e3d9372b62821913e6f4671e938f68da7c69eed5aec5aa1ad182f0f7fc756e0cb716897572544892cb232aa83fe15a0f86ab5993ea4be8401327c8f157bdc9b1b60c1cac4eeaa7a6dd8c095a74a81a95de883357491d54a34bbdfe5853e723f8a9d767b87b7528939ef409e1b96c9f5eb254491fa61ca1a536c86bd2be1e1d34c10c76b2d95e5947771290b36e2ab5dc3a3115fc695d1d40c6416e6731d06e209da7c683cf40180580920d0103aedd0331960b7602a015008a100e811cf7f7b5d94b8cd59c3cdf190b5c5c63a1fa6c8c31a976fa704959801d7e5268deed5d5f9ab1e28aeda39f3289fb6294c1ddc109e86485d3e6f1a1e9d759791e1f136711c366fefb739cae0bb9b9ac6db5c4d66b71b18c96e7d3731cd1ab15dc28695d5fb61265395fcccac5f9498d4c76a86ae7c58f524fb878e882b92d5ece7dace6f3d756f99e72d2e1ac6492292df1d32ecbabb87f5b6e562a634a529fbc7ddaaaf93c89d68d9d8b8be2ddb8c4e3eddb1b8a8da1a35b40ec8a60408a0fa6916e2000a47eee8ad911b558339471fc7dedb98be92d28c295fa68da8a3a80adb053e1a968476a282ee2fdace0323939afe38a4b79246a848a30149f82f86a498e05cc17dbf63ec6e55e6c4c77083a1fa914ad3a7515d29638458bc6b178fc3dbfa098eb5b7aafcc891a7f6815d01a04f2b7d6d7362b0470c76ee3c5f6934f6500207e7a8d9b8d01216b39c3f13792c33b44572168098ee630049f3f423ad050f98ae9225041c3f2336b706c7251286b57d8ef4f9ea074209f1047869890cf6d0e22783d657dd19ebe1d47c4e90e48f7792e2301026910d7da68fa001f75c93b64a4b4ab07a8c02b492421dd80f004b035a68d40d12737edcd87f9623b47701a890fa4cca7c0d428a83a3509420f7ebb9182c8f118b1f8a25a596e92493d81630684fbb711ab2888d823da8ee9b2f1783118dc7ae5171d1fa77682746bc92524b4b2fa0ebd433b123aea0f4249491f9b737c1dcc135b595a3417cc8e258254fa6f91855988dbd187c34c2b573a0afc3729692624db042a2d2e9e491dff59f5761a1a74e817cb50b9b38adb5692d6c872eedf25cc90c7750b4f17ea8b7160a0f4eac053f6ea5062075fdf34bfccb62a220430f4e0337c846e0490d4f0eba49a1c11ad390e0f7ec92749a46345112d189f66d15d312373f2ee390ca639a5f49d4ed6470010475ea29e3a0726a9795f06751eabc0d4f00f1d7fbb401f0e57c05d0869a101ba6ddbe3fb3408d33663b7e6862b88a035059a3502b4f2355229a350d08b73ca7010c7245eb5be5ece60cb2dbdcff000d3a00a450fe3a4931957732c370b92e8cb85f5ac246a96b623d4841ff00012770fccead4c83485e18fc9aaf581980fde1a7a08f0c17494dd0ca2be1d0f5d0232782ed7c6de6153fbc0a8fecd0309e0f8efd5b83757b062e2afccac1a49caf99550295a7b4ea2d92552d4ed5712ed38533d9caf7994b7356b8bf2a1c788ac34f93a7b4751e7a83b324aa3cc6bc7d58246d1c8c4d37160c74b70f693e2b3b5d950075a90052a746e16d93d67b58dd8340e88a3a48fb157dd5ab81a721049b3b7b79faa7a40803c0fab43e60d29a01a08c18d81635f52440cdd06d1404f90153a245065f4166a76bbaf534f6574e41a325c4db48c14140a7a9627c3f3d02834cb698759427d442ec7a51590d7f6e891c19b6371c07caca3cc7502b4f868141670c699024e64f55e36f90b20a7edf1d0ea9a82411b38d4ed21217de6ae94d94a79a01d06ab882526ac9e3aede297d3b5f5226a06581a939a9a128de034de813a10edb318d8e76b3862f5190ec576666ab0fdd63d6ba0489d8ebb9da190885cb40015a2b1f50f5aec007403dfa925226cc6c391e352358ae6196c66663f24a84824f52777853e3a43092dbda5cc61a365da7aab29af5d3ea1302cf2ae2067ba795ed925888ea553e7ddedf6e84317adb8ce38ddb178990a22c5ebef23703e0284fe7d34e11656d220f3ee37ca309ccadb2bc7acee259e085e4f922698ca9b86e45e87a9a74d1749a2792e9282e4965b9b8b64ba40543c3b12261b4abedf0707a835f1ae8a3948c9616f84e5ef2f499ae9916e45a471dc4494a2cd13b2b28f81ae8f11780e7c6397adacc96526c6b756ab31f263e6349e8496a388b7578c4ab5dae0357dc740cd525b3a9341507dbd340235fa74405c6d03d9a5204fc1770319c7acee62ba8bd78ae06e6f4e2592562053d3259968a7f1f86adc5655724325651cbf370dc4c1de3cee7f1d89189b6ca4d6f736d1bb23fa663957d53195036eede6a83a74d3e65eb92d289f153a286567f71bda0cbe7bbad2dedacb1c16f35adbab16156de80834fc29a5bfe543cb4f9990f83f6132b82c94595b4c82adf41d6395e08e4f4dbf89048ac01f61a57506e48aac0ed7bc679edfa13799ababb91fa8f54d577f936da01d0ea3a0f543070acbf7170f97582da5912f2f10c3bee905f411951579096f4c2090806800fc7c7556c6ad259be5416df1de4179678a11e5ef6d6f6e89def716e82d949ff0072ac07e675622b833bdcf62ee011eb47b4f8d587e7d752914026ee6e3fb0ab4f09dfe219c0fd9d0686c12408ba9f890219a48baf9ab29fefd12307dde4b88ee252542c01a0dde34f869002f2395e32a377afd450ec46503e1d6a748629f31e47c62f61557b75a44c489229046e3e2446e4815ad34d31342f373bb4def696d74bf530afa9b7aa0da474ad69d5b4440491b0380bfe4f90db7f76d8fb5735f5ade1926918f4e81506d1d3ccb0f868b5a015460c5f682d6d3928c9593cf79676f3466d05cc125c4c248d96a648c2a8dcc6bb41145f3d0ad20d4067bbddba8b90e22daf25c84f05c5b5cb5b0b3ba8d15fd5f4eb310c87a80d4ebf869ad0456794ec0e6ae2068ad9e37f0dad2c8d1d4d413b808dbc29d2874d5e05b58a79cec5f70313901736d68f2aa9dc2e6d6505813e7d28cb4f869ee4c2350b5f643b890e3960cbc11f28b158f61982edc842be6a2503d414ff001061a8c22cdcd1e62e1e3196822b1c0dcc18cb96aacd6f97912da62ce7ad25e89253f74541d45a73a96d2f09c788eb63d88e5f680ba9c75fb5ca8f567950c665e8454fa60f5a1f1a93a9bb192d8ed3d472c1f11cbe0f17025d59c7909a28f623e3d364516d2361752c589f1f9ff3d5562da4a20f1dece7191c866927bfb9b8ce64e4691d56278e0816526425a911520114eae353dc88c314739da8cfe4391dddc22484dcdc4927f31195c9663fbb4d4d3144982f6372752aca55c5413e3a370f691eefb01cba41482e2de223c54c6ec7a7b3c746e08342fdb7f31f4abfd4903923e5f418a8fc49d12283e9bedbb9cac60c57f6f23f9fa91145a7c7ae9c86d235e7db9773c7cd0363eefa7802c8457fde1a24209385ec773f176b0e4f1d05bdba537dc432823c7f552b5e9a4c20678bb35c7a358a1b986ea59dba9787688485eb50e57a7c09aea2d924b408cff6edc4af615f5629a40a6a949d97afbe9e3a698a09761f6e7808880d690ec1fa5b6d64f8966353f8e948c298fec1717b752bf4492338f9dc8dac7fe5a01f868919aaefb2bc6ed28b1c525a173b502cdb413ec1bb71d26126565db4fa5f92daea2dc7e62279833d074346e829e5e1a009f170abf88ff3ab2279140ac3e20ee3d3f0d34236cb0e26c540b8b9101615556a21feed02207fa82ea7695b198d9f2505bb7a6b71bd6256603aec0dd4807a57431a44cc7a727b8b549a6b04b4320ab4724d47527c8d2a0e84268da984e5d2c20cbf450935dd115927e9fef6e407a7f874c73044bae0d8b0034d1e3e07fd5238b6553ef23e7e9a4c5203cbe23b792dd88ee720f2dcc11ee61632330095a559137d3ae802f0c8a66ad6c235b508f0407f971c7d0907dfeef66a4abd48c9a6ca4ce053281248aff36c4a10ac7d9d6be7a8b64d681f8a1c8cb6a8bf3a568beac646e15eb520f5fd9a8a24d18cf6cb6716d42c59ba10b45353d4b57dba4327e0b2220b22ceaa2252f101b8b48c7c41fdba75822c9e6781a3daf0b491102a182c8a6beed4a44d1aa5c271a9adf7cd18b7a74e9ba020790aa91a62213e1b1d0bfa8992ba8e20b4282e37a81e540c18ea3a0c55cee12317e93585f5c958db79132c6518fb2bb03535314844672618f74cd75b04883473d992b2c65475a0af5f8534ea85648d18b5c7dc5ac97988b5b81882bba4b89e4526ac4fcec858b29af91f0d1f0121461b4b7c1f338ec625090e4ed679212cd5732ab2b9fcea75171298fcd15076b7bc792c0f71aeb8ff0023b8dd86bfbd996de698d7e9e7793e50589ff2c9fc8e8ceb6d9b5d031b95074df10e5ed692fd35cca5ede4f96307c169d6a0eab6e3544c703731cb197ddea29f0707a69c8411e5d80f55a8f8f5fc7ae94810ef2cade46592a152843a11d49f235074363408cb60ac218c5ebc60ac07731db5f95850d2a3dfa7d4168ca6fbb7c7716b9cc6645a66b869cbc25638dbd40168c3753c4574e66a3b6ac2d8be3f66d0a15565dd435623af4d4645010fe9389501de58ea3a50b28f1f2eba052652e2709f4eef2fa7e928218b11b40f3a9f0d08626dfe1f06992f4ec6eedd51c8090c2e0eddde55a11e75a5752644969c451e864bb0abe64cab4e9e5a523830b9e2382450f25f2907cfd5ddfd9a020f17b7b802c3e704015422be07afcbe1a40683c2b8d432979e6241a85591a354a7b001427f13a721065fe9de20a85d962050d0d5c103f115f2d121a1a9ed381c5d5cc29191504b5411edfd3a240d72c5dbb5028b68c49a5180a9af90a8f7e90484a3e41658cc2afd0dabdbe36402b37a22584b29aab2900b281e4469c0b710e5cacb1c0f22640c11151bfd59655a86f6926a6ba35130063171c3255b0b28e6761fe7892478941ebd77f41f80d3620edaff00a9e4bb53bad0dbf87cb2b33d3dcbb29fb751d064975c94971b9e60e59f69f4e3a81b4781f21a6aa90910f23c5a1be6acc9143283f299d11dbe2bb4eeae9809dccbeddd724cb363ad1de67dc6e26126c55a0a8daac9d6a7dfa9261a903b7988ee7f18cddbd8adf48f8789c8b8c7ce6aa88ca7e640d5e80d0fca749a458ac5bb86e436884c733aabbfce923bfa49b69d45491e7a8344ac30d95f2cd12ed98304057f97216515e84743d344115636417567617ab736ead0de2d5524b4159d5581a9aa750a474d0126a391c085726378b69353716f2aaef3d7ab1535ea7ae8426cd0796616384c934f690dbc29bddd2393a9f327f963f00054e9888965dc0e3996bc8ad7071b5e3bc844b25c225b4491a0a97ac9d4f520529a002ab7750f1ac30996220393b655afb2b186f2d45b6868c9ae2aa13e85e4a91fccb7f523a7c7e5a01a69b0707d258e64f58aca21ba9f34cec428f3000f134f69d3962337e350dc
UPDATETEXT [dbo].[Picture].[PictureContent] @pv NULL NULL 0x066bd860822905264a09030f00a7e5f0f86926c08f25a4e88b6f89b1b7586dcd3d608c0903a00a8453f23a072d90e6b5e712de37a538823500ec16f45a9f2048353f8e890da6db6b1e5a19166ba1bfce35d8a1bcfa90370d2066c6e3570d7bebb5bfaf704aafacf28a28153b8024d7c694f7e98684d93885a5cdbac772565742183941d08f03f86988ced78e63ed40219e4d82837852a3de282bfb74d311aa6c6584e5d25856ea31d28e954afb3af4d0068b9c6132a2c56ae4c7d524499540af91526b4fc340e4f8e372951bb6eda0f9582b7cc3de08fecd02934cf89ca2c9b9654956bf354ed3fb280fe5a10f423b612252582c7f37ea797e7afbaa6bd3516d9284695c3cc2f19a086d12304812c088acf4f03d56b43f1d4ab695e445d527d64b0aef2168ebb257aac753403a83eda7bb52dc460191491586485ca48f35b375087c3713e201f3d2b6bd075d060c6e66d2e12478e45f4a3eae8a0ee523c0115d26c92318ae0e616486dad56c6e612216946e9d59c834661b45091e201d4568f50960cbac0f2cb3c4c91dbdfc3f5feb55e2895414047ef07dd56d155ab076916f29dcce79885656101311f47d1657f54b134ad36d0fe1aaa98ef56dbb4a093cc4f7e321365df1195b04b1bb82bfce93d431eea741b56ac4d356cb5f005af437d9732b1c85e30b7ba96cf2054ee4b665df51d77fa6db5b6fecd129e816a684db2ee1cf1e47d3b8b54bf52be906b8b3685a565152cbb0d1ba7bb4ad46bc5a20a93d09f6dcdb1463b8298d4511a3231725e012c943e0e0b569e4bab2aade64569d4abbbb7dcae7d72f0dad80b9e2f87995e20f6f06d9677e80348412147b8fbab4d595ad9575d47669bd1411f87771f117f9ec7dbde5cfa979696af62f3cfe2f704ab7a6869b492013d355c3503ea50bdceb5b55e51910a4b01753024f5f073abafd590af42c6fb6eef6dfdc5c47c4f3d71ea4912a8c45c49d5d956b581d8f8903f457e1ac96aecf83fc0baae7e2743e3f9b263ed16397d5724d1420dc020f98b375f01a64868c1c19bc9402f2e2e531f6d2aef89516b210de05b7020506a29c812ce1da320be50b823e62b10afe143fdda948a015ca70627c6ccd6d7533cd1ad638b61a3b7b0ee35fca9a69f8074d4a9393f0ce65c832b0db5c629edacf1f233c574c3689375054a6ea8f0d3e8a10dbdcc3d69d9d9ded9566b9f4ca01b5000003a5284c2961dbf6b64f4d9e29957c58a2ef27dd45e9a521009e5bc325091892b91b7998b3c339768a33d005daacab4f657529d0512c8b8ae29244777f4cb4859ba55542b951e1babe3a8cb0825dcf1d6917e7b088ff0008150a3f2d3908071e1b6523d25c7c2f1a3094c4ea423329a8a9a9f03d74a420dcf612ab0a59c31a9f15476f97e1edd120aa60d8af59497b772e3c14b061d3cc541034483a9a26e34279595ad6068cd06d9630c3a8ea0d29a7b85b4cd381f1af4945cdb89b6782edf96bfb7490e0ce6c171385513e8848a4803785001fc47875a7869c81325864b8895615863a740cd21a2af8741403a0d3914106fb8c61d9c49746072a406dca0ef1ff0067bf40c8eb89e3a1d77a4424208458aa5427b00017c7cf49b1419e3f8ee2e20638a286d62662ff002d63258d0d6953e3f1d128096b85b5de5bd73f31eaab2517e1e27401f4b0d9d80aa49e8bb9a5625f'
+N'524ad3e049d480d92e7af20b3012daef20f18a80b0946635e9d4ed1a2001bc9718d7f07ac2c244ba60082c149048ea0d0d7e3a130605e29889ec72979797cf359c775e9ab25e556dd3d3141e906aa8dc4d4d3cf49b2513a0ecb1e161b5133cb1ca080d50a09f774f1d24c4d108e438b4f3a32dfcf10560422b491c2c6be06a287e1a6460226e30943eb5dc12d3e6a4850103c740883073de1d31922b79fead223b1c430493a920f80da8437e1a7a9209e3aeed2e9d05bd84fe928dc25681614ebfbb490a9aff00c3a8b0908b2910b116f244e012a42a3548f203ae8020ae4b276f1fcee67f3266568e5f1f20945e9f0d27605508dadecf3405c42ee4fb078ffcda13913506e861792a5ad9853af5dbe7fee9d4c507ad668d40caf0edf0ebb475f81d26334fd0dba54094a151d016dc4fe60e90cd721bf509f4f089839a1a831d07b7401919321e3f4b40075ab006bee1a00c86d641eac6dba9fa4f5a7e23448189852a446926f3d682bb7fef74d48463f4f90a1eaa3dcc07f768035b2ccb5f51a1fc8fedeba2008d2dc6348202c6d22f90e82bf88f66803509f79dcb1a051fbc2ac3f1f0d007d22dcf8892209e26a84ff78d3064591d0103d5b623c5976915f850e8123fffd9
')

-- Add 19 rows to [dbo].[PortletInstance]
INSERT INTO [dbo].[PortletInstance] ([PortletInstanceId], [PortletInstanceName], [PortletId]) VALUES ('d790506b-5920-464c-b71d-15220c0fe659', N'Topic2', 'a224d65d-d2a0-4f4d-9c30-c8030c995e64')
INSERT INTO [dbo].[PortletInstance] ([PortletInstanceId], [PortletInstanceName], [PortletId]) VALUES ('d58d18f9-472e-4cd5-b019-1f2e3dd74841', N'CongNghe', 'd224d65d-d2a0-4f4d-9c30-c8030c995e63')
INSERT INTO [dbo].[PortletInstance] ([PortletInstanceId], [PortletInstanceName], [PortletId]) VALUES ('cc8d6e32-32c1-4e21-82b9-258de36632c0', N'TinTuc', 'd224d65d-d2a0-4f4d-9c30-c8030c995e63')
INSERT INTO [dbo].[PortletInstance] ([PortletInstanceId], [PortletInstanceName], [PortletId]) VALUES ('ae6c0e43-3597-4391-a634-29e57932350e', N'Banner', 'd224d65d-d2a0-4f4d-9c30-c8030c995e64')
INSERT INTO [dbo].[PortletInstance] ([PortletInstanceId], [PortletInstanceName], [PortletId]) VALUES ('c8f7c369-91db-4dc9-bcc0-2a4d31993efd', N'DoiTac', 'd224d65d-d2a0-4f4d-9c30-c8030c995e64')
INSERT INTO [dbo].[PortletInstance] ([PortletInstanceId], [PortletInstanceName], [PortletId]) VALUES ('111c3e11-8de9-42fb-b24d-49ec22d9af1e', N'GioiThieu', 'a224d65d-d2a0-4f4d-9c30-c8030c995e64')
INSERT INTO [dbo].[PortletInstance] ([PortletInstanceId], [PortletInstanceName], [PortletId]) VALUES ('8356270e-3df5-48b0-80b0-57287f9cebee', N'TinTuc', 'd224d65d-d2a0-4f4d-9c30-c8030c995e64')
INSERT INTO [dbo].[PortletInstance] ([PortletInstanceId], [PortletInstanceName], [PortletId]) VALUES ('a65ed994-c6ae-45e3-a6a3-5ef273c70479', N'MenuMain', 'd224d65d-d2a0-4f4d-9c30-c8030c995e62')
INSERT INTO [dbo].[PortletInstance] ([PortletInstanceId], [PortletInstanceName], [PortletId]) VALUES ('43715f24-e36e-4ba0-950c-5ff17136a709', N'Search', '0bc0168f-c7e9-40b1-b427-ec904103b250')
INSERT INTO [dbo].[PortletInstance] ([PortletInstanceId], [PortletInstanceName], [PortletId]) VALUES ('db20c526-f3ec-4dd4-a46b-6c1628547703', N'QuangCao', 'd224d65d-d2a0-4f4d-9c30-c8030c995e64')
INSERT INTO [dbo].[PortletInstance] ([PortletInstanceId], [PortletInstanceName], [PortletId]) VALUES ('be532c1b-c36d-4d33-9f2e-7292c5320891', N'DoiTac', 'a224d65d-d2a0-4f4d-9c30-c8030c995e64')
INSERT INTO [dbo].[PortletInstance] ([PortletInstanceId], [PortletInstanceName], [PortletId]) VALUES ('ccd004f0-2022-4cfe-a251-76f0fec8493c', N'Footer', 'd224d65d-d2a0-4f4d-9c30-c8030c995e64')
INSERT INTO [dbo].[PortletInstance] ([PortletInstanceId], [PortletInstanceName], [PortletId]) VALUES ('e2f9873d-cbf3-4b06-9744-990056b457e7', N'Tin tức', 'd224d65d-d2a0-4f4d-9c30-c8030c995e64')
INSERT INTO [dbo].[PortletInstance] ([PortletInstanceId], [PortletInstanceName], [PortletId]) VALUES ('3c53d043-232d-4898-9075-aee1c2636c00', N'test', 'd224d65d-d2a0-4f4d-9c30-c8030c995e64')
INSERT INTO [dbo].[PortletInstance] ([PortletInstanceId], [PortletInstanceName], [PortletId]) VALUES ('792f994e-7841-4b56-9094-e884b468f072', N'LienKet', 'd224d65d-d2a0-4f4d-9c30-c8030c995e64')
INSERT INTO [dbo].[PortletInstance] ([PortletInstanceId], [PortletInstanceName], [PortletId]) VALUES ('9cd461b7-259b-4413-9061-efabba2f32dc', N'Đối tác', 'd224d65d-d2a0-4f4d-9c30-c8030c995e64')
INSERT INTO [dbo].[PortletInstance] ([PortletInstanceId], [PortletInstanceName], [PortletId]) VALUES ('e2f50000-da44-4789-b629-f1986c8b9a18', N'MenuSub', 'd224d65d-d2a0-4f4d-9c30-c8030c995e62')
INSERT INTO [dbo].[PortletInstance] ([PortletInstanceId], [PortletInstanceName], [PortletId]) VALUES ('777beb0f-6476-48db-b8fd-f98d3b2429b4', N'banner', 'd224d65d-d2a0-4f4d-9c30-c8030c995e64')
INSERT INTO [dbo].[PortletInstance] ([PortletInstanceId], [PortletInstanceName], [PortletId]) VALUES ('0b2a5866-070b-4439-bea1-fc694cc1e064', N'SuKien', 'd224d65d-d2a0-4f4d-9c30-c8030c995e63')

-- Add 1 row to [dbo].[Role]
INSERT INTO [dbo].[Role] ([RoleId], [RoleName], [RoleDescription]) VALUES ('a6cea14b-adef-4312-b43d-37a9cd1e647a', N'Administrators', N'Toàn Quyền')

-- Add 2 rows to [dbo].[Topic]
INSERT INTO [dbo].[Topic] ([TopicId], [TopicName], [TopicDescription], [TopicParent], [PageId]) VALUES ('00000000-0000-0000-0000-000000000000', N'Root', N'root', NULL, NULL)
INSERT INTO [dbo].[Topic] ([TopicId], [TopicName], [TopicDescription], [TopicParent], [PageId]) VALUES ('7b71ff41-1520-4be7-88aa-1f01b7c30e25', N'Tin Tức', N'', '00000000-0000-0000-0000-000000000000', '00000000-0000-0000-0000-000000000000')

-- Add 1 row to [dbo].[User]
INSERT INTO [dbo].[User] ([UserId], [UserName], [Password], [Email], [PasswordQuestion], [PasswordAnswer], [CreationDate], [LastActivityDate], [LastLoginDate], [LastPasswordChangeDate], [IsApproved], [IsOnline]) VALUES ('696d4ac3-9a21-455c-a5d2-c70873dedd6b', N'admin', N'D033E22AE348AEB5660FC2140AEC35850C4DA997', N'admin@gmail.com', N'admin', N'admin', '2010-06-18 16:59:58.620', '2010-06-18 16:59:58.620', '2010-06-18 16:59:58.620', '2010-06-18 16:59:58.620', 1, 0)

-- Add 1 row to [dbo].[UserInRole]
INSERT INTO [dbo].[UserInRole] ([UserId], [RoleId]) VALUES ('696d4ac3-9a21-455c-a5d2-c70873dedd6b', 'a6cea14b-adef-4312-b43d-37a9cd1e647a')

-- Add constraints to [dbo].[UserInRole]
ALTER TABLE [dbo].[UserInRole] ADD CONSTRAINT [FK_UserInRole_Role] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[Role] ([RoleId]) ON DELETE CASCADE
ALTER TABLE [dbo].[UserInRole] ADD CONSTRAINT [FK_UserInRole_User] FOREIGN KEY ([UserId]) REFERENCES [dbo].[User] ([UserId]) ON DELETE CASCADE

-- Add constraints to [dbo].[User]
ALTER TABLE [dbo].[User] ADD CONSTRAINT [FK_User_Authentication] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Authentication] ([AuthenticationId])

-- Add constraints to [dbo].[Topic]
ALTER TABLE [dbo].[Topic] ADD CONSTRAINT [FK_Topic_Page] FOREIGN KEY ([PageId]) REFERENCES [dbo].[Page] ([PageId]) ON DELETE SET NULL
ALTER TABLE [dbo].[Topic] ADD CONSTRAINT [FK_Topic_Topic] FOREIGN KEY ([TopicParent]) REFERENCES [dbo].[Topic] ([TopicId])

-- Add constraint FK_ArticleBelongTopic_Topic to [dbo].[ArticleBelongTopic]
ALTER TABLE [dbo].[ArticleBelongTopic] WITH NOCHECK ADD CONSTRAINT [FK_ArticleBelongTopic_Topic] FOREIGN KEY ([TopicId]) REFERENCES [dbo].[Topic] ([TopicId]) ON DELETE CASCADE

-- Add constraint FK_TopicAuthentication_Topic to [dbo].[TopicAuthentication]
ALTER TABLE [dbo].[TopicAuthentication] WITH NOCHECK ADD CONSTRAINT [FK_TopicAuthentication_Topic] FOREIGN KEY ([TopicId]) REFERENCES [dbo].[Topic] ([TopicId]) ON DELETE CASCADE

-- Add constraint FK_TopicTemplate_Topic to [dbo].[TopicTemplate]
ALTER TABLE [dbo].[TopicTemplate] WITH NOCHECK ADD CONSTRAINT [FK_TopicTemplate_Topic] FOREIGN KEY ([TopicId]) REFERENCES [dbo].[Topic] ([TopicId]) ON DELETE CASCADE

-- Add constraints to [dbo].[Role]
ALTER TABLE [dbo].[Role] ADD CONSTRAINT [FK_Role_Authentication] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[Authentication] ([AuthenticationId]) ON DELETE CASCADE ON UPDATE CASCADE

-- Add constraint FK_DocumentTypeAuthentication_Role to [dbo].[DocumentTypeAuthentication]
ALTER TABLE [dbo].[DocumentTypeAuthentication] WITH NOCHECK ADD CONSTRAINT [FK_DocumentTypeAuthentication_Role] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[Role] ([RoleId]) ON DELETE CASCADE

-- Add constraint FK_TopicAuthentication_Role to [dbo].[TopicAuthentication]
ALTER TABLE [dbo].[TopicAuthentication] WITH NOCHECK ADD CONSTRAINT [FK_TopicAuthentication_Role] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[Role] ([RoleId]) ON DELETE CASCADE

-- Add constraints to [dbo].[PortletInstance]
ALTER TABLE [dbo].[PortletInstance] ADD CONSTRAINT [FK_PortletInstance_Portlet] FOREIGN KEY ([PortletId]) REFERENCES [dbo].[Portlet] ([PortletId]) ON DELETE CASCADE

-- Add constraint FK_PortletInstanceInPanel_PortletInstance to [dbo].[PortletInstanceInPanel]
ALTER TABLE [dbo].[PortletInstanceInPanel] WITH NOCHECK ADD CONSTRAINT [FK_PortletInstanceInPanel_PortletInstance] FOREIGN KEY ([PortletInstanceId]) REFERENCES [dbo].[PortletInstance] ([PortletInstanceId]) ON DELETE CASCADE

-- Add constraints to [dbo].[Picture]
ALTER TABLE [dbo].[Picture] ADD CONSTRAINT [FK_Picture_PictureType] FOREIGN KEY ([PictureTypeId]) REFERENCES [dbo].[PictureType] ([PictureTypeId]) ON DELETE CASCADE

-- Add constraints to [dbo].[PanelInPage]
ALTER TABLE [dbo].[PanelInPage] ADD CONSTRAINT [FK_PanelInPage_Page] FOREIGN KEY ([PageId]) REFERENCES [dbo].[Page] ([PageId]) ON DELETE CASCADE
ALTER TABLE [dbo].[PanelInPage] ADD CONSTRAINT [FK_PanelInPage_Panel] FOREIGN KEY ([PanelId]) REFERENCES [dbo].[Panel] ([PanelId]) ON DELETE CASCADE

-- Add constraint FK_PortletInstanceInPanel_PanelInPage to [dbo].[PortletInstanceInPanel]
ALTER TABLE [dbo].[PortletInstanceInPanel] WITH NOCHECK ADD CONSTRAINT [FK_PortletInstanceInPanel_PanelInPage] FOREIGN KEY ([PageId], [PanelId]) REFERENCES [dbo].[PanelInPage] ([PageId], [PanelId]) ON DELETE CASCADE

-- Add constraints to [dbo].[DocumentType]
ALTER TABLE [dbo].[DocumentType] ADD CONSTRAINT [FK_DocumentType_DocumentType] FOREIGN KEY ([DocumentTypeParent]) REFERENCES [dbo].[DocumentType] ([DocumentTypeId])
ALTER TABLE [dbo].[DocumentType] ADD CONSTRAINT [FK_DocumentType_Page] FOREIGN KEY ([PageId]) REFERENCES [dbo].[Page] ([PageId]) ON DELETE SET NULL

-- Add constraint FK_DocumentBelongDocumentType_DocumentType to [dbo].[DocumentBelongDocumentType]
ALTER TABLE [dbo].[DocumentBelongDocumentType] WITH NOCHECK ADD CONSTRAINT [FK_DocumentBelongDocumentType_DocumentType] FOREIGN KEY ([DocumentTypeId]) REFERENCES [dbo].[DocumentType] ([DocumentTypeId]) ON DELETE CASCADE

-- Add constraint FK_DocumentTypeAuthentication_DocumentType to [dbo].[DocumentTypeAuthentication]
ALTER TABLE [dbo].[DocumentTypeAuthentication] WITH NOCHECK ADD CONSTRAINT [FK_DocumentTypeAuthentication_DocumentType] FOREIGN KEY ([DocumentTypeId]) REFERENCES [dbo].[DocumentType] ([DocumentTypeId]) ON DELETE CASCADE

-- Add constraint FK_TopicAuthentication_TopicPermission to [dbo].[TopicAuthentication]
ALTER TABLE [dbo].[TopicAuthentication] WITH NOCHECK ADD CONSTRAINT [FK_TopicAuthentication_TopicPermission] FOREIGN KEY ([TopicPermissionId]) REFERENCES [dbo].[TopicPermission] ([TopicPermissionId]) ON DELETE CASCADE

-- Add constraints to [dbo].[PictureType]
ALTER TABLE [dbo].[PictureType] ADD CONSTRAINT [FK_PictureType_PictureType] FOREIGN KEY ([PictureTypeParent]) REFERENCES [dbo].[PictureType] ([PictureTypeId])

-- Add constraint FK_Article_Page to [dbo].[Article]
ALTER TABLE [dbo].[Article] WITH NOCHECK ADD CONSTRAINT [FK_Article_Page] FOREIGN KEY ([PageId]) REFERENCES [dbo].[Page] ([PageId]) ON DELETE SET NULL

-- Add constraint FK_Document_Page to [dbo].[Document]
ALTER TABLE [dbo].[Document] WITH NOCHECK ADD CONSTRAINT [FK_Document_Page] FOREIGN KEY ([PageId]) REFERENCES [dbo].[Page] ([PageId]) ON DELETE SET NULL

-- Add constraints to [dbo].[Menu]
ALTER TABLE [dbo].[Menu] ADD CONSTRAINT [FK_Menu_Menu] FOREIGN KEY ([MenuParent]) REFERENCES [dbo].[Menu] ([MenuId])

-- Add constraint FK_MenuMaster_Menu to [dbo].[MenuMaster]
ALTER TABLE [dbo].[MenuMaster] WITH NOCHECK ADD CONSTRAINT [FK_MenuMaster_Menu] FOREIGN KEY ([MenuId]) REFERENCES [dbo].[Menu] ([MenuId]) ON DELETE CASCADE

-- Add constraint FK_DocumentTypeAuthentication_DocumentTypePermission to [dbo].[DocumentTypeAuthentication]
ALTER TABLE [dbo].[DocumentTypeAuthentication] WITH NOCHECK ADD CONSTRAINT [FK_DocumentTypeAuthentication_DocumentTypePermission] FOREIGN KEY ([DocumentTypePermissionId]) REFERENCES [dbo].[DocumentTypePermission] ([DocumentTypePermissionId]) ON DELETE CASCADE

COMMIT TRANSACTION
GO
