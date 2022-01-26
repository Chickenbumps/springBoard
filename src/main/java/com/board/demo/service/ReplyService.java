package com.board.demo.service;

import com.board.demo.dao.ReplyDAO;
import com.board.demo.model.ReplyVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReplyService {

    @Autowired
    private ReplyDAO replyDAO;

    public List<ReplyVO> list(int bno) throws Exception {
        return replyDAO.list(bno);
    }

    public void create(ReplyVO replyVO) throws Exception {
        replyDAO.create(replyVO);
    }

    public void update(ReplyVO replyVO) throws Exception {
        replyDAO.update(replyVO);
    }

    public void delete(int rno) throws Exception {
        replyDAO.delete(rno);
    }
}
