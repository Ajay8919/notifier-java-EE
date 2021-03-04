package com.notify.service;

import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.notify.model.User;
import com.notify.repository.UserRepository;

@Service
@Transactional
public class UserService {
	
	private final UserRepository userRepository;
	public UserService(UserRepository userRepository) {
		this.userRepository=userRepository;
	}
	public User getUserByMail(String email) {
		return userRepository.findByEmail(email);
	}
	public void saveUser(User user) {
		userRepository.save(user);
	}
	public Optional<User> getUserById(int id) {
		return userRepository.findById(id);
	}
}
