package com.springoauth2rest.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.springoauth2rest.domain.Employee;
import com.springoauth2rest.service.EmployeeService;

@Controller
@RequestMapping("/test")
public class TestOAuth2Controller {

	@Autowired
	private EmployeeService employeeService;

	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String ListEmployee() {
		// return employeeService.listEmployee();
		return "list";
	}

	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String addEmployee(Model model) {
		return "add";
	}

	@RequestMapping(value = "/json", method = RequestMethod.GET)
	public @ResponseBody List<Employee> l() {
		return employeeService.listEmployee();

	}

}
