package com.board.demo.controller;

import com.board.demo.model.BoardVO;
import com.board.demo.service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/board")
public class BoardController {

    @Autowired
    private BoardService service;

    @RequestMapping(value = "/")
    public String index(){
        return "/board/index";
    }

    // Board Register Page
    @RequestMapping(value = "/write", method = RequestMethod.GET)
    public String writeGET(){
        return "/board/write";
    }
    // Board write
    @RequestMapping(value ="/write",method = RequestMethod.POST)
    public String writePOST(BoardVO boardVO, RedirectAttributes redirectAttributes) throws  Exception{
        service.create(boardVO);
        redirectAttributes.addFlashAttribute("msg","regSuccess");
        return "redirect:/board/list";
    }
    // Board List page
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String list(Model model) throws Exception {
        model.addAttribute("list",service.listAll());
        return "/board/list";
    }
    // Board read page
    @RequestMapping(value = "/read",method=RequestMethod.GET)
    public String read(int bno, Model model) throws Exception {
        model.addAttribute("read",service.read(bno));
        return "/board/read";
    }
    // Update page
    @RequestMapping(value = "/update", method=RequestMethod.GET)
    public String updateGET(int bno, Model model) throws Exception {
        model.addAttribute("read",service.read(bno));
        return "/board/update";
    }
    // Board Update
    @RequestMapping(value = "/update",method = RequestMethod.POST)
    public String updatePOST(BoardVO boardVO, RedirectAttributes redirectAttributes) throws Exception {
        service.update(boardVO);
        redirectAttributes.addFlashAttribute("msg","updateSuccess");
        return "redirect:/board/list";
    }
    // Board Delete
    @RequestMapping(value = "/delete",method = RequestMethod.POST)
    public String delete(int bno, RedirectAttributes redirectAttributes) throws Exception {
        service.delete(bno);
        redirectAttributes.addFlashAttribute("msg","delSuccess");
        return "redirect:/board/list";
    }



}
