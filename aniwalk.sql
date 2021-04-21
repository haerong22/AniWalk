
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
   -- ��Ŀ �ε���
   apply_wk_id varchar2(30) NOT NULL,
   -- walking ���̺� index
   walking_id varchar2(30),
   -- ��û��
   walking_apply_date date,
   PRIMARY KEY (apply_id)
);


CREATE TABLE ANI_Certificate
(
   certificate_id varchar2(30) NOT NULL,
   -- ��Ŀ �ε���
   certificate_wk_id varchar2(30),
   certificate_img varchar2(1000),
   PRIMARY KEY (certificate_id)
);


CREATE TABLE ANI_Dog
(
   dog_id varchar2(30) NOT NULL,
   -- ���̸�
   dog_name varchar2(30),
   -- ����
   dog_type varchar2(30),
   dog_size varchar2(30),
   -- �� ����
   dog_info varchar2(1000),
   dog_birth date,
   -- �ε���
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
   -- �ε���
   manage_id varchar2(30) NOT NULL,
   manager_id varchar2(30) NOT NULL,
   manage_pw varchar2(30) NOT NULL,
   PRIMARY KEY (manage_id)
);


CREATE TABLE ANI_Member
(
   -- �ε���
   mem_id varchar2(30) NOT NULL,
   mem_nickname varchar2(30) NOT NULL UNIQUE,
   kakao_id varchar2(30) NOT NULL UNIQUE,
   -- ����Ʈ
   mem_point number(10,0) DEFAULT 0,
   mem_phone varchar2(30),
   -- ������ ���� 
   mem_profile_img varchar2(1000),
   mem_join_date date DEFAULT sysdate,
   PRIMARY KEY (mem_id)
);


CREATE TABLE ANI_Point
(
   point_id varchar2(30) NOT NULL,
   -- ��Ŀ �ε���
   wk_id varchar2(30),
   -- �ε���
   mem_id varchar2(30),
   -- walking ���̺��� �ε���
   walking_id varchar2(30),
   -- ��Ŀ���� ����Ʈ�� ���°ų� ����Ʈ�� �������� ��ȯ
   send_point number(10,0),
   send_point_date date,
   -- ��Ŀ�� ����Ʈ�� �޾Ұų� ������ ����Ʈ�� �����߰ų�
   receive_point number(10,0),
   receive_point_date date,
   PRIMARY KEY (point_id)
);


CREATE TABLE ANI_Review
(
   review_id varchar2(30) NOT NULL,
   walking_id varchar2(30),
   -- ���� ����
   review_contents varchar2(4000),
   -- ���� ����
   review_score number(3,0),
   review_date date DEFAULT sysdate,
   PRIMARY KEY (review_id)
);


CREATE TABLE ANI_Walker
(
   -- ��Ŀ �ε���
   wk_id varchar2(30) NOT NULL,
   wk_name varchar2(30) NOT NULL,
   -- ��Ŀ ���̵�
   walker_id varchar2(30) UNIQUE,
   -- ��й�ȣ
   wk_pw varchar2(30),
   wk_phone varchar2(20) NOT NULL,
   wk_birth date,
   wk_email varchar2(50),
   wk_addr varchar2(100),
   wk_profile_img1 varchar2(1000),
   wk_profile_img2 varchar2(1000),
   wk_profile_img3 varchar2(1000),
   -- �̺�Ʈ �̸��� ���� �����ߴ���
   -- ����: 1 ���� :0
   wk_event_agree number(3,0),
   -- Ȱ������1
   wk_location1 varchar2(40),
   -- Ȱ������2
   wk_location2 varchar2(40),
   wk_certificate_list  varchar2(1000),
   -- ��Ŀ �ڱ�Ұ�
   wk_intro varchar2(3000),
   -- ��Ŀ ����Ʈ
   wk_point number(10,0) DEFAULT 0,
   -- ��Ŀ ��û ��¥
   apply_date date,
   -- ��û ����
   -- 1. ���� ���� ��
   -- 2. ���� ���
   -- 3. ���� ����
   -- 4. �հ�
   -- 5. ���հ�
   apply_state number(3,0) DEFAULT 1,
   -- Ȱ�� ���� ��¥(id ���� ��¥)
   activity_start_date date,
   -- Ȱ�� �� : 1
   -- Ȱ�� ����: 2 
   activity_state number(3,0) DEFAULT 1,
   PRIMARY KEY (wk_id)
);


CREATE TABLE ANI_Walking
(
   walking_id varchar2(30) NOT NULL,
   -- ���� ���� �ø� mem_id
   recruit_mem_id varchar2(30) NOT NULL,
   -- �� �ε��� 
   dog_id varchar2(30),
   -- ���� ����� ��¥
   recruit_date date DEFAULT sysdate,
   -- ��å ��¥
   walk_date date,
   -- �����ۿ� �ִ� ��å ���� �ð�
   walk_start_time varchar2(10),
   -- �����ۿ� �ִ� ��å ������ �ð�
   walk_end_time varchar2(10),
   -- ���ǻ���
   recruit_notices varchar2(1000),
   -- ������ �ø� �� ��ġ 
   recruit_location varchar2(1000),
   -- ��å�� ���� ���
   walking_point number(10,0),
   -- ���� ��:0 / ���� ����: 1
   recruit_close_yn number(3,0) DEFAULT 0,
   -- ��Ī�� ��Ŀ id
   match_wk_id varchar2(30),
   -- �̵� ���
   walking_map_path varchar2(4000),
   -- ��å ��� ĸó �̹���
   map_capture_img varchar2(2000),
   -- ���� ��å ���� �ð�
   real_walk_start_time date,
   -- ���� ��å ������ �ð�
   real_walk_end_time date,
   PRIMARY KEY (walking_id)
);


CREATE TABLE ANI_Walking_Mission
(
   mission_id varchar2(30) NOT NULL,
   -- ���� ����
   mission_contents varchar2(1000),
   mission_img varchar2(2000),
   -- �̼� ���� ��ǥ
   mission_perform_location varchar2(4000),
   -- �̼� ���� �ð�
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
        where m.mem_nickname='�ظ����η�'
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


 SELECT TO_CHAR(TO_DATE('20200324 12:59:55', 'YYYYMMDDHH24MISS'), 'YYYY-MM-DD HH24:MI:SS') AS TO_DATE_����1
     , TO_CHAR(TO_DATE('20200324', 'YYYYMMDDHH24MISS'), 'YYYY/MM/DD HH24:MI:SS') AS TO_DATE_����2
     , TO_CHAR(TO_DATE('20200324', 'YYYYMMDDHH24MISS'), 'DD/MM/YYYY HH24:MI:SS') AS TO_DATE_����3
  FROM DUAL;

select * from ani_walker where wk_id ='walker00002';
select to_char(to_date('20210209', 'YYYYMMDDHH24MISS'), 'YYYY-MM-DD HH24:MI:SS') from dual;
select WK_PHONE from ANI_WALKER where WK_PHONE='01026519476';
select count(*) from ani_walker where wk_email='whtpqkfl@naver.com';

select * from ani_dog d left outer join ani_member m
		on m.mem_id=d.mem_id
		left outer join ani_dog_img i
		on d.dog_id=i.dog_id
		where m.mem_nickname = '�ظ�����';

select * from ani_walking w left outer join ani_member m
			on w.recruit_mem_id = m.mem_id
			left outer join ani_walker f
			on f.wk_id = w.match_wk_id 
			left outer join ani_dog d
			on d.dog_id = w.dog_id
			where m.mem_nickname = '�ظ�����'
			and walk_date = to_date(sysdate,'YYYY-MM-DD')
			and recruit_close_yn=1
			and match_wk_id is not null;

select * from ani_dog d 
		left outer join ani_member m
		on d.mem_id = m.mem_id
		left outer join ani_dog_img i
		on i.dog_id = d.dog_id
		where mem_nickname='�ظ�����';
        
select * from ani_dog d left outer join ani_member m
		on m.mem_id=d.mem_id
		left outer join ani_dog_img i
		on d.dog_id=i.dog_id
		where m.mem_nickname = '�ظ�����';

select count(*) from ani_member where mem_nickname='�ظ���';
select mem_phone from ani_member where mem_phone='01026519476';

update ani_dog set dog_name='���ŷ' where dog_id='dog00001';
update ani_dog set dog_name=null, dog_birth=null, dog_type=null where dog_id='dog00001';


select count(*) from ani_manage where manager_id = 'super';

select * from ANI_Walking_Mission where walking_id='walking00041' 
		order by mission_perform_time;
        
select * from ani_dog d 
		left outer join ani_member m
		on d.mem_id = m.mem_id
		left outer join ani_dog_img i
		on i.dog_id = d.dog_id
		where mem_nickname='�ظ�����';

commit;