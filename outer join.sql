/*
ted_t1	
101	null
102	null
106	null
	
ted_t2	
101	A
101	B
102	A
102	B
103	A
	
ted_t3	
101	A
101	B
102	A
102	B
105	A
*/
  SELECT * FROM ted_t1;
  SELECT * FROM ted_t2;
  SELECT * FROM ted_t3;

  SELECT a.col1
       , b.col1
       , b.col2
    FROM ted_t1 a
       , ted_t2 b
   WHERE a.col1 = b.col1(+)
;
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
   