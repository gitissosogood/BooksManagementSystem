package com.zzu.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zzu.dao.CategoryDao;
import com.zzu.entity.Category;
import com.zzu.entity.CategoryTreeNode;
import com.zzu.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Transactional
@Service
public class CategoryServiceImpl implements CategoryService {

    @Autowired
    private CategoryDao categoryDao;

    @Transactional(readOnly = true)
    @Override
    public Map queryAll(int page, int rows, String queryCategoryName, Integer categoryType) {
        Map map = new HashMap<>();
        PageHelper.startPage(page, rows);
        if (queryCategoryName != null && !"".equals(queryCategoryName)) {
            queryCategoryName = "%" + queryCategoryName + "%";
        } else {
            queryCategoryName = null;
        }
        PageInfo<Category> pageInfo = new PageInfo<>(categoryDao.queryAll(queryCategoryName, categoryType));
        List<Category> categoryList = pageInfo.getList();
        long total = pageInfo.getTotal();
        map.put("rows", categoryList);
        map.put("total", total);
        return map;
    }

    @Override
    public void addCategory(String categoryName, String parentCategoryId) {
        Category category = new Category();
        category.setCategoryName(categoryName);
        Category parentCategory = new Category();
        Integer newParentCategoryId = Integer.parseInt(parentCategoryId);
        parentCategory.setCategoryId(newParentCategoryId);
        category.setParentCategory(parentCategory);
        category.setBookCount(0);
        categoryDao.addOneCategory(category);
    }

    @Override
    public Category queryOne(Integer categoryId) {
        Category category = categoryDao.queryOne(categoryId);
        return category;
    }

    @Override
    public void updateCategory(Category category) {
        categoryDao.updateCategory(category);
    }

    @Override
    public List<CategoryTreeNode> queryAllTreeNode() {
        List<CategoryTreeNode> categoryTreeNodes = categoryDao.queryAllTreeNode();
        return categoryTreeNodes;
    }

}
