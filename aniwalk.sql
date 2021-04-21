
/*drop seq*/

DROP SEQUENCE seq_review;
DROP SEQUENCE seq_dog;
DROP SEQUENCE seq_dog_img ;
DROP SEQUENCE seq_walking_mission ;
DROP SEQUENCE seq_walking ;
DROP SEQUENCE seq_member ;
DROP SEQUENCE seq_apply ;
DROP SEQUENCE seq_point ;
DROP SEQUENCE seq_walker ;
DROP SEQUENCE seq_certificate ;
DROP SEQUENCE seq_manage ;


/* Drop Tables */

DROP TABLE ANI_Apply CASCADE CONSTRAINTS;
DROP TABLE ANI_Certificate CASCADE CONSTRAINTS;
DROP TABLE ANI_Dog_Img CASCADE CONSTRAINTS;
DROP TABLE ANI_Review CASCADE CONSTRAINTS;
DROP TABLE ANI_Walking_Mission CASCADE CONSTRAINTS;
DROP TABLE ANI_Walking CASCADE CONSTRAINTS;
DROP TABLE ANI_Dog CASCADE CONSTRAINTS;
DROP TABLE ANI_Manage CASCADE CONSTRAINTS;
DROP TABLE ANI_Point CASCADE CONSTRAINTS;
DROP TABLE ANI_Member CASCADE CONSTRAINTS;
DROP TABLE ANI_Walker CASCADE CONSTRAINTS;



/*create seq*/
create SEQUENCE seq_dog start with 1 increment by 1;
create SEQUENCE seq_dog_img start with 1 increment by 1;
create SEQUENCE seq_walking_mission start with 1 increment by 1;
create SEQUENCE seq_walking start with 1 increment by 1;
create SEQUENCE seq_member start with 1 increment by 1;
create SEQUENCE seq_apply start with 1 increment by 1;
create SEQUENCE seq_point start with 1 increment by 1;
create SEQUENCE seq_walker start with 1 increment by 1;
create SEQUENCE seq_certificate start with 1 increment by 1;
create SEQUENCE seq_manage start with 1 increment by 1;
create SEQUENCE seq_review start with 1 increment by 1;

/* Create Tables */

CREATE TABLE ANI_Apply
(
   apply_id varchar2(30) NOT NULL,
   -- 워커 인덱스
   apply_wk_id varchar2(30) NOT NULL,
   -- walking 테이블 index
   walking_id varchar2(30),
   -- 신청일
   walking_apply_date date,
   PRIMARY KEY (apply_id)
);


CREATE TABLE ANI_Certificate
(
   certificate_id varchar2(30) NOT NULL,
   -- 워커 인덱스
   certificate_wk_id varchar2(30),
   certificate_img varchar2(1000),
   PRIMARY KEY (certificate_id)
);


CREATE TABLE ANI_Dog
(
   dog_id varchar2(30) NOT NULL,
   -- 개이름
   dog_name varchar2(30),
   -- 견종
   dog_type varchar2(30),
   dog_size varchar2(30),
   -- 개 정보
   dog_info varchar2(1000),
   dog_birth date,
   -- 인덱스
   mem_id varchar2(30),
   PRIMARY KEY (dog_id)
);


CREATE TABLE ANI_Dog_Img
(
   dog_img_id varchar2(30) NOT NULL,
   dog_image varchar2(1000),
   dog_id varchar2(30),
   PRIMARY KEY (dog_img_id)
);


CREATE TABLE ANI_Manage
(
   -- 인덱스
   manage_id varchar2(30) NOT NULL,
   manager_id varchar2(30) NOT NULL,
   manage_pw varchar2(30) NOT NULL,
   PRIMARY KEY (manage_id)
);


CREATE TABLE ANI_Member
(
   -- 인덱스
   mem_id varchar2(30) NOT NULL,
   mem_nickname varchar2(30) NOT NULL UNIQUE,
   kakao_id varchar2(30) NOT NULL UNIQUE,
   -- 포인트
   mem_point number(10,0) DEFAULT 0,
   mem_phone varchar2(30),
   -- 프로필 사진 
   mem_profile_img varchar2(1000),
   mem_join_date date DEFAULT sysdate,
   PRIMARY KEY (mem_id)
);


CREATE TABLE ANI_Point
(
   point_id varchar2(30) NOT NULL,
   -- 워커 인덱스
   wk_id varchar2(30),
   -- 인덱스
   mem_id varchar2(30),
   -- walking 테이블의 인덱스
   walking_id varchar2(30),
   -- 워커에게 포인트를 보냈거나 포인트를 현금으로 전환
   send_point number(10,0),
   send_point_date date,
   -- 워커가 포인트를 받았거나 유저가 포인트를 충전했거나
   receive_point number(10,0),
   receive_point_date date,
   PRIMARY KEY (point_id)
);


CREATE TABLE ANI_Review
(
   review_id varchar2(30) NOT NULL,
   walking_id varchar2(30),
   -- 리뷰 내용
   review_contents varchar2(4000),
   -- 리뷰 별점
   review_score number(3,0),
   review_date date DEFAULT sysdate,
   PRIMARY KEY (review_id)
);


CREATE TABLE ANI_Walker
(
   -- 워커 인덱스
   wk_id varchar2(30) NOT NULL,
   wk_name varchar2(30) NOT NULL,
   -- 워커 아이디
   walker_id varchar2(30) UNIQUE,
   -- 비밀번호
   wk_pw varchar2(30),
   wk_phone varchar2(20) NOT NULL,
   wk_birth date,
   wk_email varchar2(50),
   wk_addr varchar2(100),
   wk_profile_img1 varchar2(1000),
   wk_profile_img2 varchar2(1000),
   wk_profile_img3 varchar2(1000),
   -- 이벤트 이메일 수집 동의했는지
   -- 동의: 1 비동의 :0
   wk_event_agree number(3,0),
   -- 활동지역1
   wk_location1 varchar2(40),
   -- 활동지역2
   wk_location2 varchar2(40),
   wk_certificate_list  varchar2(1000),
   -- 워커 자기소개
   wk_intro varchar2(3000),
   -- 워커 포인트
   wk_point number(10,0) DEFAULT 0,
   -- 워커 신청 날짜
   apply_date date,
   -- 신청 상태
   -- 1. 서류 검토 중
   -- 2. 교육 대기
   -- 3. 교육 수료
   -- 4. 합격
   -- 5. 불합격
   apply_state number(3,0) DEFAULT 1,
   -- 활동 시작 날짜(id 생성 날짜)
   activity_start_date date,
   -- 활동 중 : 1
   -- 활동 중지: 2 
   activity_state number(3,0) DEFAULT 1,
   PRIMARY KEY (wk_id)
);


CREATE TABLE ANI_Walking
(
   walking_id varchar2(30) NOT NULL,
   -- 모집 공고를 올린 mem_id
   recruit_mem_id varchar2(30) NOT NULL,
   -- 개 인덱스 
   dog_id varchar2(30),
   -- 모집 등록한 날짜
   recruit_date date DEFAULT sysdate,
   -- 산책 날짜
   walk_date date,
   -- 모집글에 있는 산책 시작 시간
   walk_start_time varchar2(10),
   -- 모집글에 있는 산책 끝나는 시간
   walk_end_time varchar2(10),
   -- 유의사항
   recruit_notices varchar2(1000),
   -- 모집글 올릴 때 위치 
   recruit_location varchar2(1000),
   -- 산책시 지불 비용
   walking_point number(10,0),
   -- 모집 중:0 / 모집 종료: 1
   recruit_close_yn number(3,0) DEFAULT 0,
   -- 매칭된 워커 id
   match_wk_id varchar2(30),
   -- 이동 경로
   walking_map_path varchar2(4000),
   -- 산책 경로 캡처 이미지
   map_capture_img varchar2(2000),
   -- 실제 산책 시작 시간
   real_walk_start_time date,
   -- 실제 산책 끝나는 시간
   real_walk_end_time date,
   PRIMARY KEY (walking_id)
);


CREATE TABLE ANI_Walking_Mission
(
   mission_id varchar2(30) NOT NULL,
   -- 수행 내용
   mission_contents varchar2(1000),
   mission_img varchar2(2000),
   -- 미션 수행 좌표
   mission_perform_location varchar2(4000),
   -- 미션 수행 시간
   mission_perform_time date DEFAULT sysdate,
   walking_id varchar2(30),
   PRIMARY KEY (mission_id)
);



/* Create Foreign Keys */

ALTER TABLE ANI_Dog_Img
   ADD FOREIGN KEY (dog_id)
   REFERENCES ANI_Dog (dog_id)
;


ALTER TABLE ANI_Walking
   ADD FOREIGN KEY (dog_id)
   REFERENCES ANI_Dog (dog_id)
;


ALTER TABLE ANI_Dog
   ADD FOREIGN KEY (mem_id)
   REFERENCES ANI_Member (mem_id)
;


ALTER TABLE ANI_Point
   ADD FOREIGN KEY (mem_id)
   REFERENCES ANI_Member (mem_id)
;


ALTER TABLE ANI_Walking
   ADD FOREIGN KEY (recruit_mem_id)
   REFERENCES ANI_Member (mem_id)
;


ALTER TABLE ANI_Apply
   ADD FOREIGN KEY (apply_wk_id)
   REFERENCES ANI_Walker (wk_id)
;


ALTER TABLE ANI_Certificate
   ADD FOREIGN KEY (certificate_wk_id)
   REFERENCES ANI_Walker (wk_id)
;


ALTER TABLE ANI_Point
   ADD FOREIGN KEY (wk_id)
   REFERENCES ANI_Walker (wk_id)
;


ALTER TABLE ANI_Walking
   ADD FOREIGN KEY (match_wk_id)
   REFERENCES ANI_Walker (wk_id)
;


ALTER TABLE ANI_Apply
   ADD FOREIGN KEY (walking_id)
   REFERENCES ANI_Walking (walking_id)
;


ALTER TABLE ANI_Point
   ADD FOREIGN KEY (walking_id)
   REFERENCES ANI_Walking (walking_id)
;


ALTER TABLE ANI_Review
   ADD FOREIGN KEY (walking_id)
   REFERENCES ANI_Walking (walking_id)
;


ALTER TABLE ANI_Walking_Mission
   ADD FOREIGN KEY (walking_id)
   REFERENCES ANI_Walking (walking_id)
;

insert into ani_manage(manage_id, manager_id, manage_pw) values('1', 'super', '1234');
commit;







select * from ani_member;   
select * from ani_dog;
select * from ani_dog_img;
select * from ANI_Manage;
select * from ani_walker;
select * from ani_certificate;
select * from ani_walking;
select * from ani_point;
select * from ANI_Walking_Mission;
select * from ani_review;
select * from ani_apply;


select count(*) from ani_apply where walking_id = 'walking00023'
		and apply_wk_id = 'akejdgks@naver.com'; 

 select * from ani_walking w left outer join ani_dog d
        on d.dog_id = w.dog_id
        left outer join ani_dog_img i
        on d.dog_id = i.dog_id
        where w.recruit_close_yn=0;
       
select wk_id from ani_walker where walker_id = 'whtpwls@naver.com';

select to_char(w.recruit_date,'YYYY-MM-DD') as recruit_date,d.dog_type,w.recruit_location,
        w.walk_start_time, w.walk_end_time, i.dog_image, w.walk_date, w.walking_point,w.walking_id
        from ani_walking w left outer join ani_dog d
		on w.dog_id=d.dog_id
		left outer join ani_dog_img i
		on i.dog_id=d.dog_id
        left outer join ani_member m
        on m.mem_id=w.recruit_mem_id
        where m.mem_nickname='해리보로로'
        and w.recruit_close_yn=0
        order by w.recruit_date desc;


select w.*, m.mem_nickname, d.dog_name from ani_walking w 
		left outer join ani_member m
		on w.recruit_mem_id=m.mem_id 
		left outer join ani_dog d
		on w.dog_id = d.dog_id
		where match_wk_id=(select wk_id from ani_walker where walker_id='whtpwls@naver.com');

select * from ANI_Walker where wk_id='walker00001';
select count(*) from ani_walker where walker_id='walker00002' and wk_pw='8ra6ws';

select * from ani_review r 
		left outer join ani_walking wk
		on r.walking_id = wk.walking_id
		left outer join ani_member m
		on wk.recruit_mem_id = m.mem_id
		left outer join ani_dog_img di
		on wk.dog_id = di.dog_id
		where wk.match_wk_id='walker00002';


select w.*, total, starcnt from ani_walker w left outer join
		(select wk.match_wk_id, round(sum(to_number(review_score))/count(review_score), 1) total, 
   		round((sum(to_number(review_score))/count(review_score) * 2)) starcnt
		from ani_review r left outer join ani_walking wk
		on r.walking_id = wk.walking_id
		group by wk.match_wk_id) t
		on w.wk_id = t.match_wk_id
		where apply_state=4 and activity_state=1;
        
select wk.match_wk_id, round(sum(to_number(review_score))/count(review_score), 1) total, 
round((sum(to_number(review_score))/count(review_score) * 2)) starcnt
from ani_review r left outer join ani_walking wk
on r.walking_id = wk.walking_id
group by wk.match_wk_id;


 SELECT TO_CHAR(TO_DATE('20200324 12:59:55', 'YYYYMMDDHH24MISS'), 'YYYY-MM-DD HH24:MI:SS') AS TO_DATE_형식1
     , TO_CHAR(TO_DATE('20200324', 'YYYYMMDDHH24MISS'), 'YYYY/MM/DD HH24:MI:SS') AS TO_DATE_형식2
     , TO_CHAR(TO_DATE('20200324', 'YYYYMMDDHH24MISS'), 'DD/MM/YYYY HH24:MI:SS') AS TO_DATE_형식3
  FROM DUAL;

select * from ani_walker where wk_id ='walker00002';
select to_char(to_date('20210209', 'YYYYMMDDHH24MISS'), 'YYYY-MM-DD HH24:MI:SS') from dual;
select WK_PHONE from ANI_WALKER where WK_PHONE='01026519476';
select count(*) from ani_walker where wk_email='whtpqkfl@naver.com';

select * from ani_dog d left outer join ani_member m
		on m.mem_id=d.mem_id
		left outer join ani_dog_img i
		on d.dog_id=i.dog_id
		where m.mem_nickname = '해리보로';

select * from ani_walking w left outer join ani_member m
			on w.recruit_mem_id = m.mem_id
			left outer join ani_walker f
			on f.wk_id = w.match_wk_id 
			left outer join ani_dog d
			on d.dog_id = w.dog_id
			where m.mem_nickname = '해리보로'
			and walk_date = to_date(sysdate,'YYYY-MM-DD')
			and recruit_close_yn=1
			and match_wk_id is not null;

select * from ani_dog d 
		left outer join ani_member m
		on d.mem_id = m.mem_id
		left outer join ani_dog_img i
		on i.dog_id = d.dog_id
		where mem_nickname='해리보로';
        
select * from ani_dog d left outer join ani_member m
		on m.mem_id=d.mem_id
		left outer join ani_dog_img i
		on d.dog_id=i.dog_id
		where m.mem_nickname = '해리보로';

select count(*) from ani_member where mem_nickname='해리로';
select mem_phone from ani_member where mem_phone='01026519476';

update ani_dog set dog_name='댕댕킹' where dog_id='dog00001';
update ani_dog set dog_name=null, dog_birth=null, dog_type=null where dog_id='dog00001';


select count(*) from ani_manage where manager_id = 'super';

select * from ANI_Walking_Mission where walking_id='walking00041' 
		order by mission_perform_time;
        
select * from ani_dog d 
		left outer join ani_member m
		on d.mem_id = m.mem_id
		left outer join ani_dog_img i
		on i.dog_id = d.dog_id
		where mem_nickname='해리보로';

commit;