package com.dormitory.controller;

import com.dormitory.dto.Result;
import com.dormitory.entity.User;
import com.dormitory.service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/user")
public class UserController {

    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @PostMapping("/detail")
    public Result<User> detail(HttpServletRequest request) {
        Long userId = (Long) request.getAttribute("userId");
        User user = userService.getById(userId);
        user.setPassword(null);
        return Result.success(user);
    }

    @PostMapping("/edit")
    public Result<Void> edit(HttpServletRequest request, @RequestBody User param) {
        Long userId = (Long) request.getAttribute("userId");
        User user = userService.getById(userId);
        if (param.getRealName() != null) user.setRealName(param.getRealName());
        userService.updateById(user);
        return Result.success();
    }
}
