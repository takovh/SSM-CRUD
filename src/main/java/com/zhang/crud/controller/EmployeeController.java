package com.zhang.crud.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageInfo;
import com.zhang.crud.bean.Employee;
import com.zhang.crud.pojo.BroadcastResult;
import com.zhang.crud.service.EmployeeService;

@Controller
public class EmployeeController {
	@Autowired
	EmployeeService employeeService;
	
	/**
	 * 检查姓名是否已存在
	 * @param empName 要检查的姓名
	 * @return 为空代表通过，不为空则代表错误
	 */
	@RequestMapping(value="/checkUser", method=RequestMethod.POST)
	@ResponseBody
	public String checkUser(String empName){
		if(employeeService.checkUser(empName)) return "already exist!";
		else return "";
	}
	
	/**
	 * 根据id查询员工
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/emp/{id}",method=RequestMethod.GET)
	@ResponseBody public BroadcastResult getEmp(@PathVariable("id") Integer id){
		Employee employee = employeeService.getEmpById(id);
		return BroadcastResult.ok(employee);
	}
	
	/**
	 * 根据id删除员工
	 * @param id 如果有多个id，用逗号拼接
	 * @return
	 */
	@RequestMapping(value="/emp/{ids}",method=RequestMethod.DELETE)
	@ResponseBody public BroadcastResult deletEmp(@PathVariable("ids") String ids){
		String[] idArr = ids.split(",");
		List<Integer> idList = new ArrayList<Integer>();
		for (String string : idArr) {
			idList.add(Integer.parseInt(string));
		}
		employeeService.deleteBatch(idList);
		System.out.println("删除id:" + idList.toString());
		return BroadcastResult.ok("操作成功");
	}
	
	/**
	 * 保存更新员工
	 * 我们要能支持直接发送PUT之类的请求还要封装请求体中的数据
	 * 1.配置上HttpPutFormContentFilter；
	 * 2.他的作用：将请求体中的数据解析包装成一个map。
	 * 3.request被重新包装，request.getParameter（）被重写，就会从自己封装的map中取数据
	 * @param employee
	 * @return
	 */
	@RequestMapping(value="/emp", method=RequestMethod.PUT)
	@ResponseBody
	public BroadcastResult updateEmp(Employee employee){
		System.out.println("保存更新:" + employee);
		employeeService.updateEmp(employee);
		return BroadcastResult.ok("保存成功");
	}
	
	/**
	 * 保存新增员工
	 * @param employee
	 * @return
	 */
	@RequestMapping(value="/emp", method=RequestMethod.POST)
	@ResponseBody
	public BroadcastResult saveEmp(Employee employee){
		System.out.println("保存新增:" + employee);
//		if(employeeService.saveEmp(employee)>0) return BroadcastResult.ok("保存成功");
//		else return BroadcastResult.fail("保存失败");
		employeeService.saveEmp(employee);
		return BroadcastResult.ok("保存成功");
	}
	
	/**
	 * 查询所有员工
	 * @param pageNum
	 * @param pageSize
	 * @param sortOrder
	 * @param searchText
	 * @param sortName
	 * @return
	 */
	@RequestMapping(value="/emp", method=RequestMethod.GET)
	@ResponseBody
	public BroadcastResult getEmpList(
			@RequestParam(defaultValue="1", required = false) Integer pageNum,
			@RequestParam(defaultValue="5", required = false) Integer pageSize,
    		@RequestParam(defaultValue = "desc", required = false) String sortOrder,
    		@RequestParam(defaultValue = "", required = false) String searchText,
    		@RequestParam(defaultValue = "", required = false) String sortName){
		Map<String, Object> paramMap = new HashMap<>();
    	paramMap.put("pageNumber", pageNum);
    	paramMap.put("pageSize", pageSize);
    	paramMap.put("searchText", searchText);
    	paramMap.put("sortOrder", sortOrder);
    	PageInfo<Employee> empList = employeeService.getEmpList(paramMap);
		return BroadcastResult.ok(empList);
	}
}
