package com.notify.repository;

import org.springframework.data.repository.CrudRepository;

import com.notify.model.User;

public interface UserRepository extends CrudRepository<User, Integer> {
	public User findByEmail(String email);
}
