  SELECT * FROM ted_t1;
  SELECT * FROM ted_t2;
  SELECT * FROM ted_t3;

--¡Ú
  SELECT a.col1
       , b.col1
       , b.col2
    FROM ted_t1 a
       , ted_t2 b
   WHERE a.col1 = b.col1(+)
     AND b.col2(+) = 'A'
;
  SELECT a.col1
       , b.col1
       , b.col2
    FROM ted_t1 a
       , ted_t2 b
   WHERE a.col1 = b.col1(+)
     AND b.col2 = 'A'
;
  SELECT a.col1
       , b.col1
       , b.col2
    FROM ted_t1 a
       , ted_t2 b
   WHERE a.col1 = b.col1
     AND b.col2 = 'A'
;

  SELECT a.col1
       , b.col1
       , b.col2
       , c.col1
       , c.col2
    FROM ted_t1 a
       , ted_t2 b
       , ted_t3 c
   WHERE a.col1 = b.col1(+)
     AND b.col1 = c.col1(+)
;
  SELECT a.col1
       , b.col1
       , b.col2
       , c.col1
       , c.col2
    FROM ted_t1 a
       , ted_t2 b
       , ted_t3 c
   WHERE a.col1 = b.col1(+)
     AND b.col1 = c.col1
;
  SELECT a.col1
       , b.col1
       , b.col2
       , c.col1
       , c.col2
    FROM ted_t1 a
       , ted_t2 b
       , ted_t3 c
   WHERE a.col1 = b.col1
     AND b.col1 = c.col1
;

--¡Ú
  SELECT a.col1
       , b.col1
       , b.col2
    FROM ted_t1 a
       , ted_t2 b
   WHERE a.col1 = b.col1(+)
     AND b.col2(+) = 'C'
;

--¡Ú
  SELECT a.col1
       , b.col1
       , b.col2
       , c.col1
       , c.col2
    FROM ted_t1 a
       , ted_t2 b
       , ted_t3 c
   WHERE a.col1 = b.col1(+)
     AND b.col1 = c.col1(+)
     AND c.col2(+)= 'A'
;
--¡Ú
  SELECT a.col1
       , b.col1
       , b.col2
       , c.col1
       , c.col2
    FROM ted_t1 a
       , ted_t2 b
       , ted_t3 c
   WHERE a.col1 = b.col1(+)
     AND b.col1 = c.col1(+)
     AND c.col2(+)= 'C'
;

--¡Ú
  SELECT a.col1
       , b.col1
       , b.col2
    FROM ted_t1 a
       , ted_t2 b
   WHERE a.col1 = b.col1(+)
     AND b.col2 = 'C'
;
   