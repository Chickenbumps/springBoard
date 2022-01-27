package com.board.demo.controller;

import com.board.demo.model.ReplyVO;
import com.board.demo.service.ReplyService;
import com.sun.org.apache.xpath.internal.operations.String;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/replies")
public class ReplyController {
    @Autowired
    private ReplyService service;

    //  댓글 등록
    @RequestMapping(value = "",method = RequestMethod.POST)
    public ResponseEntity<Object> register(@RequestBody ReplyVO replyVO) {
        ResponseEntity<Object> entity = null;
        System.out.println(replyVO.toString());
        try {
            service.create(replyVO);
            entity = new ResponseEntity<>("regSuccess",HttpStatus.OK);
        }catch(Exception e){
            e.printStackTrace();
            entity = new ResponseEntity<>(e.getMessage(),HttpStatus.BAD_REQUEST);
        }
        return entity;
    }

    // 댓글 조회
    @RequestMapping(value="/all/{bno}",method=RequestMethod.GET)
    public ResponseEntity<List<ReplyVO>> list(@PathVariable("bno") int bno) {
        ResponseEntity<List<ReplyVO>> entity = null;
        try {
            entity = new ResponseEntity<List<ReplyVO>>(service.list(bno),HttpStatus.OK);
        }catch(Exception e){
            e.printStackTrace();
            entity = new ResponseEntity<List<ReplyVO>>(HttpStatus.BAD_REQUEST);
        }
        return entity;
    }

    // 댓글 수정
    @RequestMapping(value="/{rno}", method={RequestMethod.PUT, RequestMethod.PATCH})
    public ResponseEntity<Object> update(@PathVariable("rno") int rno, @RequestBody ReplyVO replyVO) {
        ResponseEntity<Object> entity = null;
        try{
            replyVO.setRno(rno);
            service.update(replyVO);
            entity = new ResponseEntity<>("updateSuccess",HttpStatus.OK);
        } catch(Exception e) {
            e.printStackTrace();
            entity = new ResponseEntity<>(e.getMessage(),HttpStatus.BAD_REQUEST);
        }
        return entity;
    }

    // 댓글 삭제
    @RequestMapping(value = "/{rno}",method=RequestMethod.DELETE)
    public ResponseEntity<Object> delete(@PathVariable("rno") int rno){
        ResponseEntity<Object> entity = null;
        try{
            service.delete(rno);
            entity = new ResponseEntity<>("delSuccess",HttpStatus.OK);
        }catch(Exception e){
            e.printStackTrace();
            entity = new ResponseEntity<>(e.getMessage(),HttpStatus.BAD_REQUEST);
        }
        return entity;
    }
}
