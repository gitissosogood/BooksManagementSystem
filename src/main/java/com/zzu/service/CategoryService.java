package com.zzu.service;

import com.zzu.entity.Category;
import com.zzu.entity.CategoryTreeNode;

import java.util.List;
import java.util.Map;

public interface CategoryService {
    /**
     * 查询所有类别
     *
     * @return
     */
    Map queryAll(int page, int rows, String queryCategoryName, Integer categoryType);

    /**
     * 添加一个类别
     *
     * @param categoryName     类别名称
     * @param parentCategoryId 父类类别id
     */
    void addCategory(String categoryName, String parentCategoryId);

    /**
     * 删除一个类别
     * @param categoryId 类别id
     */
    //void deleteOneCategory(Integer categoryId);

    /**
     * 查询一个类别
     *
     * @param categoryId 类别id
     * @return
     */
    Category queryOne(Integer categoryId);

    /**
     * 修改一个类别
     *
     * @param category 修改的类别内容
     */
    void updateCategory(Category category);

    /**
     * 查询所有类别（以树的形式，不包括顶级父类）
     *
     * @return
     */
    List<CategoryTreeNode> queryAllTreeNode();

}
