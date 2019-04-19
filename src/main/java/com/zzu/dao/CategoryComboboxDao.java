package com.zzu.dao;

import com.zzu.entity.CategoryCombobox;

import java.util.List;

public interface CategoryComboboxDao {

    /**
     * 查询所有父类类别
     *
     * @return
     */
    List<CategoryCombobox> queryAllParentCategories();

}
