CREATE FUNCTION [dbo].[ufn_sqlwatch_get_clr_collector_status]
()
RETURNS bit 
AS
BEGIN
	RETURN (select 
		case 
			when dbo.ufn_sqlwatch_get_config_value (21, null) = 1
			and dbo.ufn_sqlwatch_get_clr_status() = 1 
			then 1 
		else 0 
		end)
END
