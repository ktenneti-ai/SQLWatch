﻿CREATE VIEW [dbo].[vw_sqlwatch_report_fact_perf_file_stats] WITH SCHEMABINDING
AS

select [sqlwatch_database_id], [sqlwatch_master_file_id], [num_of_reads], [num_of_bytes_read], [io_stall_read_ms], [num_of_writes], [num_of_bytes_written]
, [io_stall_write_ms], [size_on_disk_bytes], report_time, fs.[sql_instance], [num_of_reads_delta], [num_of_bytes_read_delta]
, [io_stall_read_ms_delta], [num_of_writes_delta], [num_of_bytes_written_delta], [io_stall_write_ms_delta], [size_on_disk_bytes_delta], [delta_seconds]
	  FROM [dbo].[sqlwatch_logger_perf_file_stats] fs
    inner join dbo.sqlwatch_logger_snapshot_header sh
		on sh.sql_instance = fs.sql_instance
		and sh.snapshot_time = fs.[snapshot_time]
		and sh.snapshot_type_id = fs.snapshot_type_id
