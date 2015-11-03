package com.springoauth2rest.controller;

import java.util.Iterator;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.springoauth2rest.domain.Employee;
import com.springoauth2rest.service.EmployeeService;

@Controller
@RequestMapping("/employee")
public class EmployeeController {

	@Autowired
	private EmployeeService employeeService;

	@RequestMapping(value = "/{employeeId}", method = RequestMethod.GET, headers = "Accept=application/json", produces = { "application/json" })
	@ResponseBody
	public Employee getFoobar(@PathVariable int employeeId) {

		List<Employee> el = employeeService.listEmployee();

		if (el.size() > 0) {

			for (Employee e : el) {
				if (e.getId() == employeeId)
					return e;
			}

		}

		return null;
	}

	@RequestMapping(value = "/htmllist", method = RequestMethod.GET, headers = "Accept=text/html", produces = { "text/html" })
	@ResponseBody
	public String getFoobarListHTML() {
		String retVal = "<html><body><table border=1>";

		List<Employee> el = employeeService.listEmployee();

		if (el.size() > 0) {

			for (Employee e : el) {
				retVal += "<tr><td>" + e.getId() + "</td><td>" + e.getName()
						+ "</td><td>" + e.getSalary() + "</td></tr>";

			}

		}

		retVal += "</table></body></html>";

		return retVal;
	}

	@RequestMapping(value = "/list", method = RequestMethod.GET, headers = "Accept=application/json", produces = { "application/json" })
	@ResponseBody
	public List<Employee> getFoobarList() {
		return  employeeService.listEmployee();
	}

	@RequestMapping(method = RequestMethod.GET, headers = "Accept=application/json", produces = { "application/json" })
	@ResponseBody
	public List<Employee> getFoobars() {
		return  employeeService.listEmployee();
	}

	@RequestMapping(value = "/{employeeId}", method = RequestMethod.PUT, headers = "Accept=application/json", produces = { "application/json" }, consumes = { "application/json" })
	@ResponseBody
	public Employee editFoobar(@RequestBody Employee foobar,
			@PathVariable int employeeId) {
		
		List<Employee> el = employeeService.listEmployee();

		if (el.size() > 0) {

			for (Employee e : el) {
				if (e.getId() == employeeId)
					e.setId(foobar.getId());
				e.setName(foobar.getName());
				return e;
			}

		}

		
		 
		return null;
	}

	@RequestMapping(value = "/{employeeId}", method = RequestMethod.DELETE, headers = "Accept=application/json", produces = { "application/json" })
	@ResponseBody
	public boolean deleteFoobar(@PathVariable int employeeId) {
		System.out.println("Delete call.");
		
		List<Employee> el = employeeService.listEmployee();

		if (el.size() > 0) {

			for (Employee e : el) {
				if (e.getId() == employeeId)
					return true;
			}

		}
		
		
//		while (fooIterator.hasNext()) {
//			Employee foobar = (Employee) fooIterator.next();
//			System.out.println(foobar);
//			if (foobar.getId() == employeeId) {
//				fooIterator.remove();
//				return true;
//			}
//		}
		return false;
	}

	@RequestMapping(method = RequestMethod.POST, headers = "Accept=application/json", produces = { "application/json" }, consumes = { "application/json" })
	@ResponseBody
	public Employee createFoobar(@RequestBody Employee employee) {
		return employeeService.addEmployee(employee);
	}

}
