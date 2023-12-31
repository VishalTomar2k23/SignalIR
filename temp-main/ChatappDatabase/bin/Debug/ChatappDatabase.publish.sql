﻿/*
Deployment script for ArgusoftChat

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "ArgusoftChat"
:setvar DefaultFilePrefix "ArgusoftChat"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL16.SQL2022\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL16.SQL2022\MSSQL\DATA\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET PAGE_VERIFY NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = ALL, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE = OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
PRINT N'Creating Table [dbo].[Connections]...';


GO
CREATE TABLE [dbo].[Connections] (
    [Id]        INT           IDENTITY (1, 1) NOT NULL,
    [ProfileId] INT           NOT NULL,
    [SignalId]  NVARCHAR (22) NULL,
    [DateTime]  DATETIME2 (7) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    UNIQUE NONCLUSTERED ([ProfileId] ASC)
);


GO
PRINT N'Creating Table [dbo].[GroupMembers]...';


GO
CREATE TABLE [dbo].[GroupMembers] (
    [Id]        INT           IDENTITY (1, 1) NOT NULL,
    [ProfileId] INT           NOT NULL,
    [GroupId]   INT           NOT NULL,
    [JoinedAt]  DATETIME2 (7) NOT NULL,
    [Admin]     INT           NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating Table [dbo].[GroupMessages]...';


GO
CREATE TABLE [dbo].[GroupMessages] (
    [Id]             INT             IDENTITY (1, 1) NOT NULL,
    [GroupId]        INT             NOT NULL,
    [Content]        NVARCHAR (1000) NOT NULL,
    [SenderId]       INT             NOT NULL,
    [CreatedAt]      DATETIME2 (7)   NOT NULL,
    [RepliedToId]    INT             NOT NULL,
    [RepliedContent] NVARCHAR (1000) NULL,
    [IsReply]        INT             NOT NULL,
    [Type]           NVARCHAR (30)   NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating Table [dbo].[Groups]...';


GO
CREATE TABLE [dbo].[Groups] (
    [Id]          INT             IDENTITY (1, 1) NOT NULL,
    [GroupName]   NVARCHAR (50)   NOT NULL,
    [CreatedAt]   DATETIME2 (7)   NULL,
    [CreatedBy]   INT             NULL,
    [ImagePath]   NVARCHAR (1000) NULL,
    [Description] NVARCHAR (200)  NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating Table [dbo].[Messages]...';


GO
CREATE TABLE [dbo].[Messages] (
    [Id]             INT             IDENTITY (1, 1) NOT NULL,
    [Content]        NVARCHAR (1000) NOT NULL,
    [SenderId]       INT             NOT NULL,
    [ReceiverId]     INT             NOT NULL,
    [DateTime]       DATETIME2 (7)   NOT NULL,
    [RepliedToId]    INT             NOT NULL,
    [RepliedContent] NVARCHAR (1000) NULL,
    [IsReply]        INT             NOT NULL,
    [IsSeen]         INT             NOT NULL,
    [Type]           NVARCHAR (30)   NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating Table [dbo].[Notifications]...';


GO
CREATE TABLE [dbo].[Notifications] (
    [Id]         INT           IDENTITY (1, 1) NOT NULL,
    [SenderId]   INT           NOT NULL,
    [ReceiverId] INT           NOT NULL,
    [GroupId]    INT           NULL,
    [Content]    NVARCHAR (50) NOT NULL,
    [DateTime]   DATETIME2 (7) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating Table [dbo].[Profiles]...';


GO
CREATE TABLE [dbo].[Profiles] (
    [Id]            INT             IDENTITY (1, 1) NOT NULL,
    [FirstName]     NVARCHAR (1000) NOT NULL,
    [LastName]      NVARCHAR (1000) NULL,
    [UserName]      NVARCHAR (1000) NOT NULL,
    [Email ]        NVARCHAR (1000) NOT NULL,
    [Password]      NVARCHAR (MAX)  NOT NULL,
    [ProfileType]   INT             NOT NULL,
    [CreatedAt]     DATETIME2 (7)   NULL,
    [CreatedBy]     INT             NULL,
    [LastUpdatedAt] DATETIME2 (7)   NULL,
    [LastUpdatedBy] INT             NULL,
    [ImagePath]     NVARCHAR (1000) NULL,
    [Designation]   INT             NOT NULL,
    [Status]        NVARCHAR (40)   NOT NULL,
    [IsDeleted]     INT             NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating Default Constraint unnamed constraint on [dbo].[Connections]...';


GO
ALTER TABLE [dbo].[Connections]
    ADD DEFAULT GETDATE() FOR [DateTime];


GO
PRINT N'Creating Default Constraint unnamed constraint on [dbo].[GroupMembers]...';


GO
ALTER TABLE [dbo].[GroupMembers]
    ADD DEFAULT 0 FOR [Admin];


GO
PRINT N'Creating Default Constraint unnamed constraint on [dbo].[GroupMessages]...';


GO
ALTER TABLE [dbo].[GroupMessages]
    ADD DEFAULT 0 FOR [RepliedToId];


GO
PRINT N'Creating Default Constraint unnamed constraint on [dbo].[GroupMessages]...';


GO
ALTER TABLE [dbo].[GroupMessages]
    ADD DEFAULT 0 FOR [IsReply];


GO
PRINT N'Creating Default Constraint unnamed constraint on [dbo].[Messages]...';


GO
ALTER TABLE [dbo].[Messages]
    ADD DEFAULT 0 FOR [RepliedToId];


GO
PRINT N'Creating Default Constraint unnamed constraint on [dbo].[Messages]...';


GO
ALTER TABLE [dbo].[Messages]
    ADD DEFAULT 0 FOR [IsReply];


GO
PRINT N'Creating Default Constraint unnamed constraint on [dbo].[Messages]...';


GO
ALTER TABLE [dbo].[Messages]
    ADD DEFAULT 0 FOR [IsSeen];


GO
PRINT N'Creating Default Constraint unnamed constraint on [dbo].[Profiles]...';


GO
ALTER TABLE [dbo].[Profiles]
    ADD DEFAULT GETDATE() FOR [CreatedAt];


GO
PRINT N'Creating Foreign Key [dbo].[FK_Messages_ProfileId_To_Profiles]...';


GO
ALTER TABLE [dbo].[Connections] WITH NOCHECK
    ADD CONSTRAINT [FK_Messages_ProfileId_To_Profiles] FOREIGN KEY ([ProfileId]) REFERENCES [dbo].[Profiles] ([Id]);


GO
PRINT N'Creating Foreign Key [dbo].[FK_GroupMembers_GrpId_To_Groups]...';


GO
ALTER TABLE [dbo].[GroupMembers] WITH NOCHECK
    ADD CONSTRAINT [FK_GroupMembers_GrpId_To_Groups] FOREIGN KEY ([GroupId]) REFERENCES [dbo].[Groups] ([Id]);


GO
PRINT N'Creating Foreign Key [dbo].[FK_GroupMembers_ProfileId_To_Profiles]...';


GO
ALTER TABLE [dbo].[GroupMembers] WITH NOCHECK
    ADD CONSTRAINT [FK_GroupMembers_ProfileId_To_Profiles] FOREIGN KEY ([ProfileId]) REFERENCES [dbo].[Profiles] ([Id]);


GO
PRINT N'Creating Foreign Key [dbo].[FK_GroupMessages_GrpId_To_Groups]...';


GO
ALTER TABLE [dbo].[GroupMessages] WITH NOCHECK
    ADD CONSTRAINT [FK_GroupMessages_GrpId_To_Groups] FOREIGN KEY ([GroupId]) REFERENCES [dbo].[Groups] ([Id]);


GO
PRINT N'Creating Foreign Key [dbo].[FK_Groups_CreatedBy_To_Profiles]...';


GO
ALTER TABLE [dbo].[Groups] WITH NOCHECK
    ADD CONSTRAINT [FK_Groups_CreatedBy_To_Profiles] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[Profiles] ([Id]);


GO
PRINT N'Creating Foreign Key [dbo].[FK_Notifications_FromId_To_Profiles]...';


GO
ALTER TABLE [dbo].[Notifications] WITH NOCHECK
    ADD CONSTRAINT [FK_Notifications_FromId_To_Profiles] FOREIGN KEY ([SenderId]) REFERENCES [dbo].[Profiles] ([Id]);


GO
PRINT N'Creating Foreign Key [dbo].[FK_Notifications_ToId_To_Profiles]...';


GO
ALTER TABLE [dbo].[Notifications] WITH NOCHECK
    ADD CONSTRAINT [FK_Notifications_ToId_To_Profiles] FOREIGN KEY ([ReceiverId]) REFERENCES [dbo].[Profiles] ([Id]);


GO
PRINT N'Creating Foreign Key [dbo].[FK_Notifications_GroupID_To_Groups]...';


GO
ALTER TABLE [dbo].[Notifications] WITH NOCHECK
    ADD CONSTRAINT [FK_Notifications_GroupID_To_Groups] FOREIGN KEY ([GroupId]) REFERENCES [dbo].[Groups] ([Id]);


GO
PRINT N'Checking existing data against newly created constraints';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[Connections] WITH CHECK CHECK CONSTRAINT [FK_Messages_ProfileId_To_Profiles];

ALTER TABLE [dbo].[GroupMembers] WITH CHECK CHECK CONSTRAINT [FK_GroupMembers_GrpId_To_Groups];

ALTER TABLE [dbo].[GroupMembers] WITH CHECK CHECK CONSTRAINT [FK_GroupMembers_ProfileId_To_Profiles];

ALTER TABLE [dbo].[GroupMessages] WITH CHECK CHECK CONSTRAINT [FK_GroupMessages_GrpId_To_Groups];

ALTER TABLE [dbo].[Groups] WITH CHECK CHECK CONSTRAINT [FK_Groups_CreatedBy_To_Profiles];

ALTER TABLE [dbo].[Notifications] WITH CHECK CHECK CONSTRAINT [FK_Notifications_FromId_To_Profiles];

ALTER TABLE [dbo].[Notifications] WITH CHECK CHECK CONSTRAINT [FK_Notifications_ToId_To_Profiles];

ALTER TABLE [dbo].[Notifications] WITH CHECK CHECK CONSTRAINT [FK_Notifications_GroupID_To_Groups];


GO
PRINT N'Update complete.';


GO
