package com.board.demo.service;

import com.board.demo.dao.BoardDAO;
import com.board.demo.model.BoardVO;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BoardService {

    @Autowired
    private BoardDAO boardDAO;

    public void create(BoardVO boardVO) throws  Exception{
        boardDAO.create(boardVO);
    }

    public BoardVO read(int bno) throws Exception {
        return boardDAO.read(bno);
    }

    public void update(BoardVO boardVO) throws Exception {
        boardDAO.update(boardVO);
    }

    public void delete(int bno) throws Exception{
        boardDAO.delete(bno);
    }

    public List<BoardVO> listAll() throws Exception{
        return boardDAO.listAll();
    }

}
