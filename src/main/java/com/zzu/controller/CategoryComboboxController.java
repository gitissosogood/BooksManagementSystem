package com.zzu.controller;

import com.zzu.entity.CategoryCombobox;
import com.zzu.service.CategoryComboboxService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("categoryCombobox")
public class CategoryComboboxController {

    @Autowired
    private CategoryComboboxService categoryComboboxService;

    @RequestMapping("queryAllParentCategories")
    @ResponseBody
    public Map queryAllParentCategories() {
        Map map = new HashMap();
        try {
            List<CategoryCombobox> categoryComboboxList = categoryComboboxService.queryAllParentCategories();
            map.put("categoryComboboxList", categoryComboboxList);
            map.put("flag", 1);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("flag", 2);
        }
        return map;
    }

}
