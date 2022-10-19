create table tab (x Nullable(UInt8)) engine = MergeTree order by x settings allow_nullable_key = 1, index_granularity = 2;
insert into tab select number from numbers(4);

set allow_suspicious_low_cardinality_types=1;
set max_rows_to_read = 2;

SELECT x + 1 FROM tab where plus(x, 1) <= 2 order by x;
SELECT x + 1 FROM tab where plus(x, 1::Nullable(UInt8)) <= 2 order by x;
SELECT x + 1 FROM tab where plus(x, 1::LowCardinality(UInt8)) <= 2 order by x;
SELECT x + 1 FROM tab where plus(x, 1::LowCardinality(Nullable(UInt8))) <= 2 order by x;
SELECT 1 + x FROM tab where plus(1, x) <= 2 order by x;
SELECT 1 + x FROM tab where plus(1::Nullable(UInt8), x) <= 2 order by x;
SELECT 1 + x FROM tab where plus(1::LowCardinality(UInt8), x) <= 2 order by x;
SELECT 1 + x FROM tab where plus(1::LowCardinality(Nullable(UInt8)), x) <= 2 order by x;

drop table tab;

set max_rows_to_read = 100;

create table tab (x LowCardinality(UInt8)) engine = MergeTree order by x settings allow_nullable_key = 1, index_granularity = 2;
insert into tab select number from numbers(4);

set max_rows_to_read = 2;
SELECT x + 1 FROM tab where plus(x, 1) <= 2 order by x;
SELECT x + 1 FROM tab where plus(x, 1::Nullable(UInt8)) <= 2 order by x;
SELECT x + 1 FROM tab where plus(x, 1::LowCardinality(UInt8)) <= 2 order by x;
SELECT x + 1 FROM tab where plus(x, 1::LowCardinality(Nullable(UInt8))) <= 2 order by x;
SELECT 1 + x FROM tab where plus(1, x) <= 2 order by x;
SELECT 1 + x FROM tab where plus(1::Nullable(UInt8), x) <= 2 order by x;
SELECT 1 + x FROM tab where plus(1::LowCardinality(UInt8), x) <= 2 order by x;
SELECT 1 + x FROM tab where plus(1::LowCardinality(Nullable(UInt8)), x) <= 2 order by x;

drop table tab;

set max_rows_to_read = 100;

create table tab (x UInt128) engine = MergeTree order by x settings allow_nullable_key = 1, index_granularity = 2;
insert into tab select number from numbers(4);

SELECT x + 1 FROM tab WHERE (x + 1::LowCardinality(UInt8)) <= -9223372036854775808 order by x;
