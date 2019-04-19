package com.zzu;

import com.zzu.dao.CategoryDao;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

@RunWith(SpringRunner.class)
@SpringBootTest
public class BmsApplicationTests {

    @Autowired
    private CategoryDao categoryDao;

    @Test
    public void contextLoads() {
        /*List<Category> categoryList = categoryDao.queryAll();
        for (Category category : categoryList) {
            System.out.println(category);
        }*/
    }

}
