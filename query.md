create table board(
bno int primary key,
title varchar2(100) not null ,
content varchar2(2000) not null ,
author  varchar2(100) not null,
createdAt DATE default SYSDATE
);
alter table board add userID int not null;


create sequence board_seq start with 1 increment by 1;


create table user_info(
id int primary key ,
userID varchar(50) not null ,
userPassword varchar(100) not null ,
userName    varchar2(40)    not null,
userEmail varchar(50) not null ,
sessionKey    varchar(50) default 'none',
sessionLimit TIMESTAMP,
userJoinDate TIMESTAMP default SYSDATE,
userLoginDate TIMESTAMP default SYSDATE
);

create table board_reply(
rno int primary key ,
bno int default 0,
parentRno int default 0,
depth int,
content varchar(1000) not null ,
author varchar(50) not null ,
createdAt   TIMESTAMP   default SYSDATE,
updatedAt   timestamp default  sysdate
);

alter table board_reply add constraint FK_BOARD_REPLY FOREIGN KEY(bno) references board(bno);
alter table board add constraint FK_USER_BOARD FOREIGN KEY(userID) references user_info(id);

create sequence reply_seq start with 1 increment by 1;
create sequence user_seq start with 1 increment by 1;

commit;

alter table user_info rename column userPassword to userPW;
commit;


select * from board_reply;