SET IDENTITY_INSERT [AUTH].[ClientScopes] ON 

INSERT [AUTH].[ClientScopes] ([Id], [ClientId], [Scope]) VALUES (1, 3, N'openid')
INSERT [AUTH].[ClientScopes] ([Id], [ClientId], [Scope]) VALUES (2, 2, N'api1')
INSERT [AUTH].[ClientScopes] ([Id], [ClientId], [Scope]) VALUES (3, 1, N'api1')
INSERT [AUTH].[ClientScopes] ([Id], [ClientId], [Scope]) VALUES (4, 4, N'openid')
INSERT [AUTH].[ClientScopes] ([Id], [ClientId], [Scope]) VALUES (5, 4, N'profile')
INSERT [AUTH].[ClientScopes] ([Id], [ClientId], [Scope]) VALUES (6, 4, N'api1')
INSERT [AUTH].[ClientScopes] ([Id], [ClientId], [Scope]) VALUES (7, 3, N'profile')
INSERT [AUTH].[ClientScopes] ([Id], [ClientId], [Scope]) VALUES (8, 3, N'api1')
SET IDENTITY_INSERT [AUTH].[ClientScopes] OFF
