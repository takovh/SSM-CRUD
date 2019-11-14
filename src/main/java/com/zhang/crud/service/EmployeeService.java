package com.zhang.crud.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zhang.crud.bean.Employee;
import com.zhang.crud.bean.EmployeeExample;
import com.zhang.crud.bean.EmployeeExample.Criteria;
import com.zhang.crud.dao.EmployeeMapper;

@Service
public class EmployeeService {
	@Autowired
	EmployeeMapper employeeMapper;
	
	/**
	 * 检查姓名是否已存在
	 * @param empName 要检查的姓名
	 * @return 存在为true，不存在为false
	 */
	public Boolean checkUser(String empName){
		EmployeeExample example = new EmployeeExample();
		example.createCriteria().andEmpNameEqualTo(empName);
		long count = employeeMapper.countByExample(example);
		if(count>0) return true;
		else return false;
	}
	
	/**
	 * 查询所有员工
	 * @return
	 */
	public PageInfo<Employee> getEmpList(Map<String, Object> paramMap) {
		//分页查询
		PageHelper.startPage((Integer) paramMap.get("pageNumber"), (Integer) paramMap.get("pageSize"));
		//startPage后面紧跟的这个查询就是一个分页查询
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		if(paramMap.get("searchText")!=null&&!((String) paramMap.get("searchText")).equals("")) 
			criteria.andEmpNameLike("%" + (String) paramMap.get("searchText") + "%");
		example.setOrderByClause("emp_id asc");
		List<Employee> list = employeeMapper.selectByExampleWithDept(example);
		return new PageInfo<>(list);
	}

	public int saveEmp(Employee employee) {
		int insertSelective = employeeMapper.insertSelective(employee);
		return insertSelective;
	}

	public Employee getEmpById(Integer id) {
		EmployeeExample example = new EmployeeExample();
		example.createCriteria().andEmpIdEqualTo(id);
		List<Employee> selectByExample = employeeMapper.selectByExampleWithDept(example);
		return selectByExample.get(0);
	}

	public int updateEmp(Employee employee) {
		int num = employeeMapper.updateByPrimaryKey(employee);
		return num;
	}

	public int deleteEmpById(Integer id) {
		int num = employeeMapper.deleteByPrimaryKey(id);
		return num;
	}

	public void deleteBatch(List<Integer> idList) {
		EmployeeExample example = new EmployeeExample();
		example.createCriteria().andEmpIdIn(idList);
		employeeMapper.deleteByExample(example);
	}

}
