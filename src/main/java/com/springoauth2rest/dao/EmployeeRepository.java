package com.springoauth2rest.dao;

import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.springoauth2rest.domain.Employee;

@Repository
@Transactional
public class EmployeeRepository {

	@Autowired
	private SessionFactory sessionFactory;

	private static List<Employee> el;

	static {
		el = new ArrayList<Employee>();
		for (int i = 0; i < 10; i++) {
			double sal = new SecureRandom().nextInt(400) * 500;
			Employee e = new Employee("Employee " + i, sal);
			el.add(e);

		}
	}

	@SuppressWarnings("unchecked")
	public List<Employee> listEmployee() {
		
		List<Employee> lE = sessionFactory.getCurrentSession()
				.createQuery("from Employee Order By id DESC").list();
		
		if(lE == null || lE.size()==0)
		{
			for (Employee e : el) {
				sessionFactory.getCurrentSession().save(e);
			}
		}

		return lE;
	}

	public Employee addEmployee(Employee empl) {
		sessionFactory.getCurrentSession().persist(empl);
		return empl;
	}
}
