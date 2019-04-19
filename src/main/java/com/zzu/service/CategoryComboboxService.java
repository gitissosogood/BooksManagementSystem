package com.zzu.service;

import com.zzu.entity.CategoryCombobox;

import java.util.List;

public interface CategoryComboboxService {

    /**
     * 查询所有父类类别
     *
     * @return
     */
    List<CategoryCombobox> queryAllParentCategories();

}
