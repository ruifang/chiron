/****** Object:  Table [auth].[ClientRedirectUris]    Script Date: 5/3/2017 10:36:17 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'auth' AND TABLE_NAME = 'ClientRedirectUris')
CREATE TABLE [auth].[ClientRedirectUris](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ClientId] [int] NOT NULL,
	[RedirectUri] [nvarchar](2000) NOT NULL,
 CONSTRAINT [PK_ClientRedirectUris] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

if not exists (select * from dbo.sysobjects where id = object_id(N'[FK_ClientRedirectUris_Clients_ClientId]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [auth].[ClientRedirectUris]  WITH CHECK ADD  CONSTRAINT [FK_ClientRedirectUris_Clients_ClientId] FOREIGN KEY([ClientId])
REFERENCES [auth].[Clients] ([Id])
ON DELETE CASCADE
GO

ALTER TABLE [auth].[ClientRedirectUris] CHECK CONSTRAINT [FK_ClientRedirectUris_Clients_ClientId]
GO


