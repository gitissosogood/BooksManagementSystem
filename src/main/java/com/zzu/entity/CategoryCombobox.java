package com.zzu.entity;

import lombok.Data;

@Data
public class CategoryCombobox {

    /**
     * 下拉框option的value值（父类别）
     */
    private String id;
    /**
     * 下拉框option的内容（父类别）
     */
    private String text;

}
