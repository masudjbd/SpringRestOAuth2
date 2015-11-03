package com.springoauth2rest.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.springoauth2rest.dao.EmployeeRepository;
import com.springoauth2rest.domain.Employee;


@Service
@Transactional
public class EmployeeService {

	@Autowired
	private EmployeeRepository employeeRepository;
	
	
	public List<Employee> listEmployee(){
		return employeeRepository.listEmployee();
	}
	
	
	
	public Employee addEmployee(Employee empl){
		return employeeRepository.addEmployee(empl);
	}
}
