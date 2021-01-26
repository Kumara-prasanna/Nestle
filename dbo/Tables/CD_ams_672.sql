CREATE TABLE [dbo].[CD_ams_672] (
    [dt_created]                      DATETIME        NULL,
    [dt_updated]                      DATETIME        NULL,
    [dt_filename]                     NVARCHAR (255)  NULL,
    [profilebrandname]                NVARCHAR (MAX)  NULL,
    [clicks]                          BIGINT          NULL,
    [attributedsales14dsamesku]       NUMERIC (13, 4) NULL,
    [targetid]                        BIGINT          NULL,
    [attributedsales14d]              NUMERIC (13, 4) NULL,
    [targetingexpression]             NVARCHAR (MAX)  NULL,
    [currency]                        NVARCHAR (MAX)  NULL,
    [attributedconversions14dsamesku] BIGINT          NULL,
    [cost]                            NUMERIC (13, 4) NULL,
    [attributedconversions14d]        BIGINT          NULL,
    [campaignname]                    NVARCHAR (MAX)  NULL,
    [targetingtype]                   NVARCHAR (MAX)  NULL,
    [profileid]                       BIGINT          NULL,
    [campaignid]                      BIGINT          NULL,
    [attributedunitsordered14d]       BIGINT          NULL,
    [targetingtext]                   NVARCHAR (MAX)  NULL
);


GO
CREATE NONCLUSTERED INDEX [ix_CD_ams_672_dt_filename]
    ON [dbo].[CD_ams_672]([dt_filename] ASC);

