SELECT COUNT(somecol) OVER ( PARTITION BY somecol ) AS freq FROM sometable;
