--syntac
/*
윈도우함수([파라미터1,파라미터2...])over(
    [partition by {컬럼1 | 표현식}, 컬럼2...]
    [order by {컬럼1 | 표현식} [{asc | desc}], 컬럼2...]
    [{rows | range}
        between {행 | unbounded preceding | preceding | current row}
            and {행 | unbounded following | current row}
    ]
)
over 절은 행 그룹을 정의하고, 각 그룹당 윈도우 함수 적용 결과 값을 구함
Window가 결정되면 partition by, order by를 통해 조절
분석 함수는 select, order by 절만 사용 가능

행 그룹의 범위를 Window라고 함
rows: 물리적인 행의 집합을 지정
range: 논리적인 행의 집합을 지정
between ~ and: 윈도우의 시작과 끝 위치를 지정
unbounded preceding: 윈도우의 시작 위치는 첫 번째 행
unbounded following: 윈도우의 끝 위치는 마지막 행
current row: 윈도우의 현재 행
*/

--전체 행 대상 집계
  select a.student_no
       , a.student_nm
       , a.total
       , a.avg
       , round(avg(a.total) over()) as score_avg
       , round(avg(a.total) over() / 3) as all_avg
    from ved_score a
   where a.year_mon = '2017/07'
;

--행 누적 집계
  select a.student_no
       , a.student_nm
       , a.total
       , a.avg
       , round(avg(a.total) over(order by a.student_no), 1) as score_avg
       , round(avg(a.total) over(order by a.student_no) / 3, 1) as all_avg
    from ved_score a
   where year_mon = '2017/07'
;

--총점 순으로 순위 조회
  select a.student_no
       , a.student_nm
       , a.grade_class_no
       , a.total
       , a.avg
       , rank() over(partition by a.grade_class_no order by a.total desc) as rank --동 순위시 중복 값 누적 수만큼 증가. ex) 1,2,2,4
       , dense_rank() over(partition by a.grade_class_no order by a.total desc) as dense_rank --동 순위시 중복 값 누적하지 않고 증가. ex) 1,2,2,3
       , row_number() over(partition by a.grade_class_no order by a.total desc) as row_num --동 순위 관계없이 증가 ex) 1,2,3,4
    from ved_score a
   where year_mon = '2017/07'
;

--학년 반별 집계
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

--학년 반별 집계와 누적 집계
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

--window 절을 이용한 전체 행 대상 집계와 누적 집계
--전체 행 대상 집계
  select a.student_no
       , a.student_nm
       , a.total
       , a.avg
       , round(avg(a.total) over(order by a.student_no
                                 rows between unbounded preceding and unbounded following), 1) as  score_avg
    from ved_score a
   where year_mon = '2017/07'
;

--행 누적 집계
  select a.student_no
       , a.student_nm
       , a.total
       , a.avg
       , round(avg(a.total) over(order by a.student_no
                                 rows between unbounded preceding and current row), 1) as score_avg
    from ved_score a
   where year_mon = '2017/07'
;

--행 누적 집계
  select a.student_no
       , a.student_nm
       , a.total
       , a.avg
       , round(avg(a.total) over(order by a.student_no
                                 rows between unbounded preceding and current row), 1) as score_avg
    from ved_score a
   where a.year_mon = '2017/07'
;

--총점이 반에서 차지하는 비율과 최고, 최저 점수, 인원
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


