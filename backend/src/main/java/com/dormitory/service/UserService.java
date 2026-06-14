package com.dormitory.service;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.dormitory.dto.LoginDTO;
import com.dormitory.dto.LoginVO;
import com.dormitory.entity.User;
import com.dormitory.mapper.UserMapper;
import com.dormitory.util.JwtUtil;
import org.springframework.stereotype.Service;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

@Service
public class UserService extends ServiceImpl<UserMapper, User> {

    private final JwtUtil jwtUtil;

    public UserService(JwtUtil jwtUtil) {
        this.jwtUtil = jwtUtil;
    }

    public void register(LoginDTO dto) {
        if (dto.getUsername() == null || dto.getUsername().trim().isEmpty()) {
            throw new RuntimeException("用户名不能为空");
        }
        if (dto.getPassword() == null || dto.getPassword().trim().isEmpty()) {
            throw new RuntimeException("密码不能为空");
        }
        User exist = lambdaQuery().eq(User::getUsername, dto.getUsername()).one();
        if (exist != null) {
            throw new RuntimeException("用户名已存在");
        }
        User user = new User();
        user.setUsername(dto.getUsername().trim());
        user.setPassword(encryptPassword(dto.getPassword().trim()));
        user.setRealName(dto.getRealName() != null ? dto.getRealName().trim() : dto.getUsername().trim());
        user.setRole("学生");
        save(user);
    }

    public LoginVO login(LoginDTO dto) {
        if (dto.getUsername() == null || dto.getUsername().trim().isEmpty()) {
            throw new RuntimeException("用户名不能为空");
        }
        if (dto.getPassword() == null || dto.getPassword().trim().isEmpty()) {
            throw new RuntimeException("密码不能为空");
        }
        User user = lambdaQuery().eq(User::getUsername, dto.getUsername().trim()).one();
        if (user == null) {
            throw new RuntimeException("用户名或密码错误");
        }
        if (!user.getPassword().equals(encryptPassword(dto.getPassword().trim()))) {
            throw new RuntimeException("用户名或密码错误");
        }
        String token = jwtUtil.generateToken(user.getId(), user.getUsername());
        return new LoginVO(token, user.getRole());
    }

    private String encryptPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] digest = md.digest(password.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : digest) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("加密失败");
        }
    }
}
