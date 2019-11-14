package com.zhang.crud.test;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.github.pagehelper.PageInfo;
import com.zhang.crud.bean.Employee;

/**
 * 使用springTest提供的测试请求功能
 * @author tako_
 *
 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations={"classpath:applicationContext.xml",
		"file:src/main/webapp/WEB-INF/dispatcherServlet-servlet.xml"})
public class MVCTest {
	//传入springVC的ioc
	@Autowired
	WebApplicationContext context;
	//虚拟mvc请求，获取到处理结果
	MockMvc mockMvc;
	
	@Before
	public void initMockMvc(){
		mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
	}
	
	@Test
	public void testPage() throws Exception{
		//模拟请求，拿到返回值
		MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pageNum", "1"))
				.andReturn();
		//请求成功后，请求域中会有pageInfo，可以取出验证
		MockHttpServletRequest request = result.getRequest();
		@SuppressWarnings("unchecked")
		PageInfo<Employee> pi = (PageInfo<Employee>) request.getAttribute("pageInfo");
		System.out.println("当前页码：" + pi.getPageNum());
		System.out.println("总共页码：" + pi.getPages());
		System.out.println("总记录数：" + pi.getTotal());
		
		//获取员工数据
		List<Employee> list = pi.getList();
		for (Employee employee : list) {
			System.out.println(employee);
		}
	}
}
