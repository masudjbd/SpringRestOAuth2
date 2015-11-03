package com.springoauth2rest.domain;

 
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

import org.codehaus.jackson.annotate.JsonAutoDetect;

@JsonAutoDetect
@Entity
public class Employee {
	
	@Id
	@GeneratedValue
    private int id;
    private String name;
    private double salary;

    public Employee() {
		super();
	}

    
	public Employee(String name, double salary) {
		super();
		this.name = name;
		this.salary = salary;
	}


	public Employee(int id, String name, double salary) {
        this.id = id;
        this.name = name;
        this.salary = salary;
    }

	
    public double getSalary() {
        return salary;
    }

    public void setSalary(double salary) {
        this.salary = salary;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

}
