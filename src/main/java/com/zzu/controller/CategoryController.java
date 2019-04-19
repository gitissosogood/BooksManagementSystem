package com.zzu.controller;

import com.zzu.entity.Category;
import com.zzu.entity.CategoryCombobox;
import com.zzu.entity.CategoryTreeNode;
import com.zzu.service.CategoryComboboxService;
import com.zzu.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("category")
public class CategoryController {

    @Autowired
    private CategoryService categoryService;
    @Autowired
    private CategoryComboboxService categoryComboboxService;

    @RequestMapping("queryAll")
    @ResponseBody
    public Map queryAll(int page, int rows, String queryCategoryName, Integer categoryType) {
        Map map = categoryService.queryAll(page, rows, queryCategoryName, categoryType);
        return map;
    }

    @RequestMapping("addCategory")
    @ResponseBody
    public Map addCategory(String categoryName, String parentCategoryId) {
        Map map = new HashMap();
        try {
            categoryService.addCategory(categoryName, parentCategoryId);
            map.put("flag", 1);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("flag", 2);
        }
        return map;
    }

    @RequestMapping("deleteOneCategory")
    @ResponseBody
    public Map deleteOneCategory() {
        //categoryService
        Map map = new HashMap();
        return map;
    }

    @RequestMapping("queryOne")
    @ResponseBody
    public Map queryOne(Integer categoryId) {
        Map map = new HashMap();
        try {
            Category category = categoryService.queryOne(categoryId);
            List<CategoryCombobox> categoryComboboxList = categoryComboboxService.queryAllParentCategories();
            map.put("category", category);
            map.put("categoryComboboxList", categoryComboboxList);
            map.put("flag", 1);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("flag", 2);
        }
        return map;
    }

    @RequestMapping("updateCategory")
    @ResponseBody
    public Map updateCategory(Category category) {
        Map map = new HashMap();
        System.out.println(category);
        try {
            categoryService.updateCategory(category);
            map.put("flag", 1);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("flag", 2);
        }
        return map;
    }

    @RequestMapping("queryAllTreeNode")
    @ResponseBody
    public List<CategoryTreeNode> queryAllTreeNode() {
        List<CategoryTreeNode> categoryTreeNodes = categoryService.queryAllTreeNode();
        return categoryTreeNodes;
    }

}
