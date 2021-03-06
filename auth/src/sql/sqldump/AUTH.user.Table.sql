USE [chiron]
GO
/****** Object:  Table [AUTH].[user]    Script Date: 1/24/2018 9:29:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [AUTH].[user](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[UserStatus] [varchar](10) NULL,
	[Username] [varchar](100) NOT NULL,
	[Password] [varchar](100) NOT NULL,
	[Salt] [varchar](50) NOT NULL,
	[LoginCount] [int] NULL,
	[LastLogin] [datetime] NULL,
	[LastLoginIPAddress] [varchar](50) NULL,
	[EffectiveDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NULL,
	[SecurityToken] [varchar](50) NULL,
	[TokenExpiration] [datetime] NULL,
	[TermsOfUseAcceptanceDate] [datetime] NULL,
	[CreateDate] [datetime] NOT NULL,
	[CreateUserId] [int] NOT NULL,
	[LastModifiedDate] [datetime] NOT NULL,
	[LastModifiedUserId] [int] NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UN_User]    Script Date: 1/24/2018 9:29:48 AM ******/
ALTER TABLE [AUTH].[user] ADD  CONSTRAINT [UN_User] UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [AUTH].[user] ADD  CONSTRAINT [DF_User_LoginCount]  DEFAULT ((0)) FOR [LoginCount]
GO
ALTER TABLE [AUTH].[user]  WITH CHECK ADD  CONSTRAINT [FK_User_CreatedUser] FOREIGN KEY([CreateUserId])
REFERENCES [AUTH].[user] ([UserId])
GO
ALTER TABLE [AUTH].[user] CHECK CONSTRAINT [FK_User_CreatedUser]
GO
ALTER TABLE [AUTH].[user]  WITH CHECK ADD  CONSTRAINT [FK_User_LastModifiedUser] FOREIGN KEY([LastModifiedUserId])
REFERENCES [AUTH].[user] ([UserId])
GO
ALTER TABLE [AUTH].[user] CHECK CONSTRAINT [FK_User_LastModifiedUser]
GO
