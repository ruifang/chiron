SET IDENTITY_INSERT [AUTH].[IdentityResources] ON 

INSERT [AUTH].[IdentityResources] ([Id], [Description], [DisplayName], [Emphasize], [Enabled], [Name], [Required], [ShowInDiscoveryDocument]) VALUES (1, NULL, N'Your user identifier', 0, 1, N'openid', 1, 1)
INSERT [AUTH].[IdentityResources] ([Id], [Description], [DisplayName], [Emphasize], [Enabled], [Name], [Required], [ShowInDiscoveryDocument]) VALUES (2, N'Your user profile information (first name, last name, etc.)', N'User profile', 1, 1, N'profile', 0, 1)
SET IDENTITY_INSERT [AUTH].[IdentityResources] OFF
