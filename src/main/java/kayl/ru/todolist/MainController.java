package kayl.ru.todolist;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.sql.Date;
import java.util.ArrayList;

@Controller
public class MainController {
    private static final int PAGE_SIZE = 3;
    private NotesRepository notesRepository;


    public MainController(NotesRepository notesRepository) {
        this.notesRepository = notesRepository;
    }

    @RequestMapping(value = { "/", "/index" }, method = RequestMethod.GET)
    public String index(@RequestParam(required = false, defaultValue = "*") String isDone,
                        @RequestParam(required = false, defaultValue = "id") String sortColumn,
                        @RequestParam(required = false, defaultValue = "ASC") String sortDirection,
                        @RequestParam(required = false, defaultValue = "1") int pageNumber,
                        Model model) {

        // настройка сортировки
        Sort sort = new Sort(Sort.Direction.valueOf(sortDirection), sortColumn);
        PageRequest request = new PageRequest(pageNumber - 1, PAGE_SIZE, sort);

        boolean filter = Boolean.parseBoolean(isDone);
        Page<Note> page;
        if(!"*".equals(isDone)) {
            page = notesRepository.findByDone(filter, request);
        } else {
            page = notesRepository.findAll(request);
        }
        //Список задач для страницы, из page почему-то не читает
        ArrayList<Note> notes = new ArrayList<>();
        page.forEach(notes::add);
        //
        int current = page.getNumber() + 1;
        int begin = Math.max(1, current - 5);
        int end = Math.min(begin + 10, page.getTotalPages());
        int totalPages = page.getTotalPages();
        //
        model.addAttribute("beginIndex", begin);
        model.addAttribute("endIndex", end);
        model.addAttribute("currentIndex", current);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("notes", notes);
        model.addAttribute("isDone", isDone);
        model.addAttribute("sortColumn", sortColumn);
        model.addAttribute("sortDirection", sortDirection);
        return "notes";
    }

    @RequestMapping(value="/notes/add", method = RequestMethod.POST)
    public String addNote(@ModelAttribute("note") Note note) {
        notesRepository.save(note);
        return "redirect:/";
    }

    @RequestMapping(value = "/delete/{id}")
    public String removeNote(@PathVariable("id") long id) {
        notesRepository.delete(id);
        return "redirect:/";
    }

    @RequestMapping(value = "/edit/{id}")
    public ModelAndView editNote(@PathVariable("id") long id) {
        ModelAndView modelAndView = new ModelAndView("edit");
        Note note = notesRepository.findOne(id);
        modelAndView.addObject("note", note);
        return modelAndView;
    }

    @RequestMapping(value="/note/save", method = RequestMethod.POST)
    public String saveNote(@ModelAttribute("note") Note note) {
        notesRepository.save(note);
        return "redirect:/";
    }


}
