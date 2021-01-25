CREATE TABLE [dbo].[Nestle_Ams_DSP_New] (
    [dt_created]                         DATETIME        NULL,
    [dt_updated]                         DATETIME        NULL,
    [dt_filename]                        NVARCHAR (255)  NULL,
    [advertiser]                         NVARCHAR (100)  NULL,
    [advertiser_id]                      BIGINT          NULL,
    [order]                              NVARCHAR (400)  NULL,
    [order_id]                           NVARCHAR (100)  NULL,
    [line_item]                          NVARCHAR (400)  NULL,
    [line_item_id]                       NVARCHAR (100)  NULL,
    [creative]                           NVARCHAR (400)  NULL,
    [creative_id]                        NVARCHAR (100)  NULL,
    [creative_type]                      NVARCHAR (100)  NULL,
    [creative_size]                      NVARCHAR (50)   NULL,
    [supply_cost]                        NUMERIC (13, 4) NULL,
    [total_cost]                         NUMERIC (13, 4) NULL,
    [impressions]                        BIGINT          NULL,
    [ecpm]                               NUMERIC (13, 4) NULL,
    [clickthroughs]                      NUMERIC (13, 4) NULL,
    [ctr]                                NUMERIC (13, 4) NULL,
    [ecpc]                               NUMERIC (13, 4) NULL,
    [survey_start]                       NUMERIC (13, 4) NULL,
    [survey_start_views]                 NUMERIC (13, 4) NULL,
    [mashup_click_to_page_clicks]        NUMERIC (13, 4) NULL,
    [mashup_atc]                         NUMERIC (13, 4) NULL,
    [mashup_atc_views]                   NUMERIC (13, 4) NULL,
    [mashup_cc_click]                    NUMERIC (13, 4) NULL,
    [mashup_cc_click_views]              NUMERIC (13, 4) NULL,
    [mashup_cc_click_clicks]             NUMERIC (13, 4) NULL,
    [dpv]                                NUMERIC (13, 4) NULL,
    [dpvr]                               NUMERIC (13, 4) NULL,
    [atl]                                NUMERIC (13, 4) NULL,
    [atl_views]                          NUMERIC (13, 4) NULL,
    [atl_clicks]                         NUMERIC (13, 4) NULL,
    [purchases]                          NUMERIC (13, 4) NULL,
    [purchase_rate]                      NUMERIC (13, 4) NULL,
    [newtobrand_purchases]               NUMERIC (13, 4) NULL,
    [units_sold]                         NUMERIC (13, 4) NULL,
    [sales_cad]                          NUMERIC (13, 4) NULL,
    [roas]                               NUMERIC (13, 4) NULL,
    [newtobrand_product_sales_cad]       NUMERIC (13, 4) NULL,
    [total_dpv]                          NUMERIC (13, 4) NULL,
    [total_purchases]                    NUMERIC (13, 4) NULL,
    [total_purchase_rate]                NUMERIC (13, 4) NULL,
    [total_newtobrand_purchases]         NUMERIC (13, 4) NULL,
    [total_units_sold]                   NUMERIC (13, 4) NULL,
    [total_sales_cad]                    NUMERIC (13, 4) NULL,
    [total_roas]                         NUMERIC (13, 4) NULL,
    [total_newtobrand_product_sales_cad] NUMERIC (13, 4) NULL,
    [day_of_week]                        NVARCHAR (MAX)  NULL,
    [total_fee]                          NUMERIC (13, 4) NULL,
    [mashup_cc_click_cvr]                NUMERIC (13, 4) NULL,
    [total_atl]                          NUMERIC (13, 4) NULL,
    [total_atl_views]                    NUMERIC (13, 4) NULL,
    [total_atl_clicks]                   NUMERIC (13, 4) NULL,
    [date]                               DATE            NULL,
    [mashup_click_to_page]               NUMERIC (13, 4) NULL,
    [mashup_atc_clicks]                  NUMERIC (13, 4) NULL,
    [total_dpvr]                         NUMERIC (13, 4) NULL,
    [total_newtobrand_units_sold]        NUMERIC (13, 4) NULL,
    [mashup_click_to_page_views]         NUMERIC (13, 4) NULL
);


GO
CREATE NONCLUSTERED INDEX [ix_Nestle_Ams_DSP_New_dt_filename]
    ON [dbo].[Nestle_Ams_DSP_New]([dt_filename] ASC);


GO
CREATE NONCLUSTERED INDEX [idx_AMS_DSP]
    ON [dbo].[Nestle_Ams_DSP_New]([date] ASC)
    INCLUDE([order], [creative], [line_item]);

