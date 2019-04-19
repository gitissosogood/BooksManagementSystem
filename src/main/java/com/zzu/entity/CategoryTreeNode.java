package com.zzu.entity;

import lombok.Data;

import java.util.List;

@Data
public class CategoryTreeNode {

    /**
     * 节点id
     */
    private Integer id;
    /**
     * 节点文本
     */
    private String text;
    /**
     * 一个节点数组声明了若干子节点
     */
    private List<CategoryTreeNode> children;
    /**
     *自定义属性（判断是不是父节点）
     */
    //private Integer attributes;

}
