SELECT COUNT(somecol)
         OVER ( winname PARTITION BY somecol ORDER BY ordercol1, ordercol2 )
         AS freq FROM sometable;
