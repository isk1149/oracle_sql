--syntac
/*
�������Լ�([�Ķ����1,�Ķ����2...])over(
    [partition by {�÷�1 | ǥ����}, �÷�2...]
    [order by {�÷�1 | ǥ����} [{asc | desc}], �÷�2...]
    [{rows | range}
        between {�� | unbounded preceding | preceding | current row}
            and {�� | unbounded following | current row}
    ]
)
over ���� �� �׷��� �����ϰ�, �� �׷�� ������ �Լ� ���� ��� ���� ����
Window�� �����Ǹ� partition by, order by�� ���� ����
�м� �Լ��� select, order by ���� ��� ����

�� �׷��� ������ Window��� ��
rows: �������� ���� ������ ����
range: ������ ���� ������ ����
between ~ and: �������� ���۰� �� ��ġ�� ����
unbounded preceding: �������� ���� ��ġ�� ù ��° ��
unbounded following: �������� �� ��ġ�� ������ ��
current row: �������� ���� ��
*/

--��ü �� ��� ����
  select a.student_no
       , a.student_nm
       , a.total
       , a.avg
       , round(avg(a.total) over()) as score_avg
       , round(avg(a.total) over() / 3) as all_avg
    from ved_score a
   where a.year_mon = '2017/07'
;

--�� ���� ����
  select a.student_no
       , a.student_nm
       , a.total
       , a.avg
       , round(avg(a.total) over(order by a.student_no), 1) as score_avg
       , round(avg(a.total) over(order by a.student_no) / 3, 1) as all_avg
    from ved_score a
   where year_mon = '2017/07'
;

--���� ������ ���� ��ȸ
  select a.student_no
       , a.student_nm
       , a.grade_class_no
       , a.total
       , a.avg
       , rank() over(partition by a.grade_class_no order by a.total desc) as rank --�� ������ �ߺ� �� ���� ����ŭ ����. ex) 1,2,2,4
       , dense_rank() over(partition by a.grade_class_no order by a.total desc) as dense_rank --�� ������ �ߺ� �� �������� �ʰ� ����. ex) 1,2,2,3
       , row_number() over(partition by a.grade_class_no order by a.total desc) as row_num --�� ���� ������� ���� ex) 1,2,3,4
    from ved_score a
   where year_mon = '2017/07'
;

--�г� �ݺ� ����
  select a.student_no
       , a.student_nm
       , a.grade_class_no
       , a.total
       , a.avg
       , round(avg(a.total) over(partition by a.grade_class_no)) as score_avg
       , round(avg(a.total) over(partition by a.grade_class_no) / 3) as all_avg
    from ved_score a
   where year_mon = '2017/07'
;

--�г� �ݺ� ����� ���� ����
  select a.student_no
       , a.student_nm
       , a.grade_class_no
       , a.total
       , a.avg
       , round(avg(a.total) over(partition by a.grade_class_no order by a.student_no)) as score_avg
       , round(avg(a.total) over(partition by a.grade_class_no) / 3) as all_avg
    from ved_score a
   where year_mon = '2017/07'
;

--window ���� �̿��� ��ü �� ��� ����� ���� ����
--��ü �� ��� ����
  select a.student_no
       , a.student_nm
       , a.total
       , a.avg
       , round(avg(a.total) over(order by a.student_no
                                 rows between unbounded preceding and unbounded following), 1) as  score_avg
    from ved_score a
   where year_mon = '2017/07'
;

--�� ���� ����
  select a.student_no
       , a.student_nm
       , a.total
       , a.avg
       , round(avg(a.total) over(order by a.student_no
                                 rows between unbounded preceding and current row), 1) as score_avg
    from ved_score a
   where year_mon = '2017/07'
;

--�� ���� ����
  select a.student_no
       , a.student_nm
       , a.total
       , a.avg
       , round(avg(a.total) over(order by a.student_no
                                 rows between unbounded preceding and current row), 1) as score_avg
    from ved_score a
   where a.year_mon = '2017/07'
;

--������ �ݿ��� �����ϴ� ������ �ְ�, ���� ����, �ο�
  select a.student_no
       , a.student_nm
       , a.grade_class_no
       , a.total
       , a.avg
       , round(ratio_to_report(a.total) over(partition by a.grade_class_no) * 100, 2) as rate
       , max(a.total) over(partition by a.grade_class_no) as max_score
       , min(a.total) over(partition by a.grade_class_no) as min_score
       , count(*) over(partition by a.grade_class_no) as grade_student_cnt
    from ved_score a
   where a.year_mon = '2017/07'
;


