CREATE TABLE t_files (
filename varchar unique not null,
workspace varchar,
create_date TIMESTAMP not null default now(),
change_date TIMESTAMP,
file bytea );

postgres://postgres:postgres@172.27.112.1:5432/itlingo