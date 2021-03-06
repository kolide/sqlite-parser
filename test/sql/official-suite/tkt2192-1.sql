-- original: tkt2192.test
-- credit:   http://www.sqlite.org/src/tree?ci=trunk&name=test

-- Raw data (RBS) --------
    
    create table records (
      date          real,
      type          text,
      description   text,
      value         integer,
      acc_name      text,
      acc_no        text
    );
    
    -- Direct Debits ----------------
    create view direct_debits as
      select * from records where type = 'D/D';
    
    create view monthly_direct_debits as
      select strftime('%Y-%m', date) as date, (-1 * sum(value)) as value
        from direct_debits
       group by strftime('%Y-%m', date);
    
    -- Expense Categories ---------------create view energy as
      select strftime('%Y-%m', date) as date, (-1 * sum(value)) as value
        from direct_debits
       where description like '%NPOWER%'
       group by strftime('%Y-%m', date);
    
    create view phone_internet as
      select strftime('%Y-%m', date) as date, (-1 * sum(value)) as value
        from direct_debits
       where description like '%BT DIRECT%'
          or description like '%SUPANET%'
          or description like '%ORANGE%'
       group by strftime('%Y-%m', date);
    
    create view credit_cards as
      select strftime('%Y-%m', date) as date, (-1 * sum(value)) as value
        from direct_debits where description like '%VISA%'
       group by strftime('%Y-%m', date);
    
    -- Overview ---------------------create view expense_overview as
      select 'Energy' as expense, date, value from energy
      union
      select 'Phone/Internet' as expense, date, value from phone_internet
      union
      select 'Credit Card' as expense, date, value from credit_cards;
    
    create view jan as
      select 'jan', expense, value from expense_overview
       where date like '%-01';
    
    create view nov as
      select 'nov', expense, value from expense_overview
       where date like '%-11';
    
    create view summary as
      select * from jan join nov on (jan.expense = nov.expense)
;select * from summary
;CREATE TABLE t1(a,b);
    CREATE VIEW v1 AS
      SELECT * FROM t1 WHERE b%7=0 UNION SELECT * FROM t1 WHERE b%5=0;
    INSERT INTO t1 VALUES(1,7);
    INSERT INTO t1 VALUES(2,10);
    INSERT INTO t1 VALUES(3,14);
    INSERT INTO t1 VALUES(4,15);
    INSERT INTO t1 VALUES(1,16);
    INSERT INTO t1 VALUES(2,17);
    INSERT INTO t1 VALUES(3,20);
    INSERT INTO t1 VALUES(4,21);
    INSERT INTO t1 VALUES(1,22);
    INSERT INTO t1 VALUES(2,24);
    INSERT INTO t1 VALUES(3,25);
    INSERT INTO t1 VALUES(4,26);
    INSERT INTO t1 VALUES(1,27);
 
    SELECT b FROM v1 ORDER BY b
;SELECT * FROM v1 ORDER BY a, b
;SELECT x.a || '/' || x.b || '/' || y.b
      FROM v1 AS x JOIN v1 AS y ON x.a=y.a AND x.b<y.b
     ORDER BY x.a, x.b, y.b
;CREATE VIEW v2 AS
    SELECT x.a || '/' || x.b || '/' || y.b AS z
      FROM v1 AS x JOIN v1 AS y ON x.a=y.a AND x.b<y.b
     ORDER BY x.a, x.b, y.b;
    SELECT * FROM v2;