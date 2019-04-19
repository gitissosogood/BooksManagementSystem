package com.zzu.entity;

import lombok.Data;
import tk.mybatis.mapper.annotation.KeySql;

import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;
import java.util.List;

@Data
@Table(name = "t_category")
public class Category {
    /**
     * 类别编号
     */
    @Id
    @KeySql(useGeneratedKeys = true)
    private Integer categoryId;
    /**
     * 类别名称
     */
    private String categoryName;
    /**
     * 该类别下的图书数量
     */
    private Integer bookCount;
    /**
     * 该类别的父类别
     */
    @Transient
    private Category parentCategory;
    /**
     * 父级类别下的子类别
     */
    @Transient
    private List<Category> childrenCategoriesList;

}
