package com.zzu.dao;

import com.zzu.entity.Category;
import com.zzu.entity.CategoryTreeNode;
import org.apache.ibatis.annotations.Param;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

public interface CategoryDao extends Mapper<Category> {

    /**
     * 查询所有类别（不包括顶级父类）
     * 条件加分页
     *
     * @return
     */
    List<Category> queryAll(@Param("queryCategoryName") String queryCategoryName, @Param("categoryType") Integer categoryType);

    /**
     * 添加一个类别
     *
     * @param category 类别
     */
    void addOneCategory(Category category);

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
     * @param category 修改类别的内容
     */
    void updateCategory(Category category);

    /**
     * 查询所有类别（以树的形式，不包括顶级父类）
     *
     * @return
     */
    List<CategoryTreeNode> queryAllTreeNode();

}
