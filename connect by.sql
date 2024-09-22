 select *
   from ted_dept
;

 select a.dept_id
      , lpad(' ', 2 * (level-1)) || a.dept_nm as dept_nm
      , substr(sys_connect_by_path(a.dept_nm, '>'), 2) as dept_nm_pass --sys_connect_by_path: 계층형 쿼리에서 각 행의 전체 경로를 문자열로 반환. substr(..., 2): 생성된 경로의 첫 번째 > 기호를 제거하여 깔끔한 경로를 출력.
      , a.up_dept_id
      , connect_by_root a.dept_id as root_dept_id --현재 노드의 최상위(root) 부서 ID를 반환. 계층 구조의 최상위 노드에서 시작된 루트 부서의 ID를 표시.
      , level --현재 행의 계층 레벨. 1부터 시작.
      , connect_by_isleaf as isleaf --값이 1이면 리프 노드이고, 0이면 자식이 있는 노드.
   from ted_dept a
  start with a.dept_id = 1 --계층 구조의 시작점(루트)을 지정
connect by prior a.dept_id = a.up_dept_id --재귀적인 계층 구조를 정의. prior 기준으로 순서가 중요함. prior a.dept_id는 부모를 뜻함. 부모 a.dept_id가 a.up_dept_id에 의해 참조됨. PRIOR 키워드는 부모 노드를 정의하는 데 사용.
  order siblings by a.dept_id --같은 부모를 공유하는 형제 노드들 간의 정렬 기준을 지정.
;

  select a.dept_id
       , lpad('  ', 4 * (level-1)) || a.dept_nm as dept_nm
       , substr(sys_connect_by_path(a.dept_nm, '>'), 2) as dept_nm_pass
       , a.up_dept_id
       , level
       , b.cnt
    from ted_dept a
       , (select a.root_dept_id
               , sum(a.cnt) as cnt
            from (select connect_by_root a.dept_id as root_dept_id
                       , 1 as cnt
                    from ted_dept a
                 connect by prior a.dept_id = up_dept_id
                 --start with 미 사용시 하위가 있는 모든 부서의 계층 조회
                 ) a
           group by a.root_dept_id
         ) b
   where a.dept_id = b.root_dept_id
   start with a.dept_id = 1
 connect by prior a.dept_id = a.up_dept_id
   order siblings by a.dept_id
;

   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   