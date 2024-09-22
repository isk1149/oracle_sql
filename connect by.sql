 select *
   from ted_dept
;

 select a.dept_id
      , lpad(' ', 2 * (level-1)) || a.dept_nm as dept_nm
      , substr(sys_connect_by_path(a.dept_nm, '>'), 2) as dept_nm_pass --sys_connect_by_path: ������ �������� �� ���� ��ü ��θ� ���ڿ��� ��ȯ. substr(..., 2): ������ ����� ù ��° > ��ȣ�� �����Ͽ� ����� ��θ� ���.
      , a.up_dept_id
      , connect_by_root a.dept_id as root_dept_id --���� ����� �ֻ���(root) �μ� ID�� ��ȯ. ���� ������ �ֻ��� ��忡�� ���۵� ��Ʈ �μ��� ID�� ǥ��.
      , level --���� ���� ���� ����. 1���� ����.
      , connect_by_isleaf as isleaf --���� 1�̸� ���� ����̰�, 0�̸� �ڽ��� �ִ� ���.
   from ted_dept a
  start with a.dept_id = 1 --���� ������ ������(��Ʈ)�� ����
connect by prior a.dept_id = a.up_dept_id --������� ���� ������ ����. prior �������� ������ �߿���. prior a.dept_id�� �θ� ����. �θ� a.dept_id�� a.up_dept_id�� ���� ������. PRIOR Ű����� �θ� ��带 �����ϴ� �� ���.
  order siblings by a.dept_id --���� �θ� �����ϴ� ���� ���� ���� ���� ������ ����.
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
                 --start with �� ���� ������ �ִ� ��� �μ��� ���� ��ȸ
                 ) a
           group by a.root_dept_id
         ) b
   where a.dept_id = b.root_dept_id
   start with a.dept_id = 1
 connect by prior a.dept_id = a.up_dept_id
   order siblings by a.dept_id
;

   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   