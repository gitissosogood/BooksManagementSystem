package com.zzu.service.impl;

import com.zzu.dao.CategoryComboboxDao;
import com.zzu.entity.CategoryCombobox;
import com.zzu.service.CategoryComboboxService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Transactional
@Service
public class CategoryComboboxServiceImpl implements CategoryComboboxService {

    @Autowired
    private CategoryComboboxDao categoryComboboxDao;

    @Transactional(readOnly = true)
    @Override
    public List<CategoryCombobox> queryAllParentCategories() {
        List<CategoryCombobox> categoryComboboxList = categoryComboboxDao.queryAllParentCategories();
        return categoryComboboxList;
    }

}
