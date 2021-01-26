CREATE TABLE [dbo].[CD_Mapping] (
    [Channel]         NVARCHAR (50)  NOT NULL,
    [Campaign_Name]   NVARCHAR (100) NOT NULL,
    [Campaign_Status] NVARCHAR (50)  NOT NULL,
    [Profile_Name]    NVARCHAR (50)  NOT NULL,
    [Campaign_Type]   NVARCHAR (50)  NOT NULL,
    [Campaign_Name1]  NVARCHAR (50)  NOT NULL,
    [Brand]           NVARCHAR (50)  NOT NULL,
    [Ad_Type]         NVARCHAR (50)  NOT NULL,
    [Language]        NVARCHAR (50)  NOT NULL,
    [Targeting]       NVARCHAR (50)  NOT NULL,
    [Match]           NVARCHAR (50)  NULL
);

