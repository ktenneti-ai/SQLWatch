﻿CREATE TABLE [dbo].[sqlwatch_logger_xes_wait_event]
(
	event_time datetime not null,
	wait_type_id smallint not null,
	duration bigint not null,
	signal_duration bigint null,
	session_id int,
	username nvarchar(255),
	client_hostname nvarchar(255),
	client_app_name nvarchar(255),
	--plan_handle varbinary(64) null,
	--statement_start_offset int not null,
	--statement_end_offset int not null,
	sql_instance varchar(32) not null,
	snapshot_time datetime2(0) not null,
	snapshot_type_id tinyint not null,
	activity_id varchar(40), 
	event_data xml,
	--sql_text varchar(max),
	--sql_handle varbinary(64),
	query_hash varbinary(8),
	query_plan_hash varbinary(8),
	[sqlwatch_database_id] smallint,
	[database_create_date] datetime2(3),
	[sqlwatch_procedure_id] int,
	
	constraint pk_sqlwatch_logger_xes_wait_stat_event primary key clustered (
		event_time, wait_type_id, session_id, [sql_instance], [snapshot_time], [snapshot_type_id] , activity_id
	),

	constraint fk_sqlwatch_logger_xes_wait_stat_event_snapshot_header foreign key ([snapshot_time],[sql_instance],[snapshot_type_id]) 
		references [dbo].[sqlwatch_logger_snapshot_header]([snapshot_time],[sql_instance],[snapshot_type_id]) on delete cascade on update cascade,

	constraint fk_sqlwatch_logger_xes_wait_stat_event_server foreign key ([sql_instance])
		references [dbo].[sqlwatch_meta_server] ([servername]) on delete cascade,

	/*	we're not doing FK to query plan as we want to be able to delete plans if the table gets too big
		arguably, this will mean that we have a bunch of waits without knowing the queries but when it comes to worst,
		I'd rather save the storage and the prod sytem from falling over than retain exec plans */


);
