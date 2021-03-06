USE [chiron]
GO
/****** Object:  Table [AUTH].[Role]    Script Date: 1/24/2018 9:29:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [AUTH].[Role](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Description] [varchar](4000) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[CreateUserId] [int] NOT NULL,
	[LastModifiedDate] [datetime] NOT NULL,
	[LastModifiedUserId] [int] NOT NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UN_Role]    Script Date: 1/24/2018 9:29:48 AM ******/
ALTER TABLE [AUTH].[Role] ADD  CONSTRAINT [UN_Role] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [AUTH].[Role]  WITH CHECK ADD  CONSTRAINT [FK_Role_CreatedUser] FOREIGN KEY([CreateUserId])
REFERENCES [AUTH].[user] ([UserId])
GO
ALTER TABLE [AUTH].[Role] CHECK CONSTRAINT [FK_Role_CreatedUser]
GO
ALTER TABLE [AUTH].[Role]  WITH CHECK ADD  CONSTRAINT [FK_Role_LastModifiedUser] FOREIGN KEY([LastModifiedUserId])
REFERENCES [AUTH].[user] ([UserId])
GO
ALTER TABLE [AUTH].[Role] CHECK CONSTRAINT [FK_Role_LastModifiedUser]
GO
