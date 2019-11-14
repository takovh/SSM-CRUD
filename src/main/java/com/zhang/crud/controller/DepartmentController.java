package com.zhang.crud.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zhang.crud.pojo.BroadcastResult;
import com.zhang.crud.service.DepartmentServive;

@Controller
public class DepartmentController {
	@Autowired
	DepartmentServive departmentServive;
	
	@RequestMapping(value = "/getDeptList", method = RequestMethod.GET)
	@ResponseBody
	public BroadcastResult getDeptList(){
		return BroadcastResult.ok(departmentServive.getAllDepartments());
	}
}
