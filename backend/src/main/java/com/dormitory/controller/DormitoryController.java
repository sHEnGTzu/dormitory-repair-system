package com.dormitory.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.dormitory.dto.PageDTO;
import com.dormitory.dto.PageVO;
import com.dormitory.dto.Result;
import com.dormitory.entity.Dormitory;
import com.dormitory.entity.User;
import com.dormitory.service.DormitoryService;
import com.dormitory.service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/dormitory")
public class DormitoryController {

    private final DormitoryService dormitoryService;
    private final UserService userService;

    public DormitoryController(DormitoryService dormitoryService, UserService userService) {
        this.dormitoryService = dormitoryService;
        this.userService = userService;
    }

    private void checkAdmin(HttpServletRequest request) {
        Long userId = (Long) request.getAttribute("userId");
        User user = userService.getById(userId);
        if (!"管理员".equals(user.getRole())) {
            throw new RuntimeException("无权操作，仅管理员可管理宿舍信息");
        }
    }

    @PostMapping("/add")
    public Result<Void> add(HttpServletRequest request, @RequestBody Dormitory dormitory) {
        checkAdmin(request);
        dormitoryService.save(dormitory);
        return Result.success();
    }

    @PostMapping("/edit")
    public Result<Void> edit(HttpServletRequest request, @RequestBody Dormitory dormitory) {
        checkAdmin(request);
        Dormitory exist = dormitoryService.getById(dormitory.getId());
        if (exist == null) {
            throw new RuntimeException("记录不存在");
        }
        dormitoryService.updateById(dormitory);
        return Result.success();
    }

    @PostMapping("/delete")
    public Result<Void> delete(HttpServletRequest request, @RequestBody Dormitory param) {
        checkAdmin(request);
        Dormitory exist = dormitoryService.getById(param.getId());
        if (exist == null) {
            throw new RuntimeException("记录不存在");
        }
        dormitoryService.removeById(param.getId());
        return Result.success();
    }

    @PostMapping("/list/page")
    public Result<PageVO<Dormitory>> pageList(HttpServletRequest request, @RequestBody PageDTO pageDTO) {
        checkAdmin(request);
        com.baomidou.mybatisplus.extension.plugins.pagination.Page<Dormitory> page =
                dormitoryService.page(
                        new com.baomidou.mybatisplus.extension.plugins.pagination.Page<>(pageDTO.getCurrent(), pageDTO.getSize()),
                        new LambdaQueryWrapper<Dormitory>().orderByDesc(Dormitory::getId)
                );
        PageVO<Dormitory> vo = new PageVO<>(page.getCurrent(), page.getSize(), page.getTotal(), page.getRecords());
        return Result.success(vo);
    }

    /** 学生获取所有宿舍列表（用于报修时选择宿舍） */
    @PostMapping("/list/all")
    public Result<java.util.List<Dormitory>> listAll(HttpServletRequest request) {
        java.util.List<Dormitory> list = dormitoryService.list(
                new LambdaQueryWrapper<Dormitory>().orderByAsc(Dormitory::getBuilding).orderByAsc(Dormitory::getFloorNum).orderByAsc(Dormitory::getRoomNum)
        );
        return Result.success(list);
    }

    /** 获取宿舍总数 */
    @PostMapping("/count")
    public Result<Long> count() {
        return Result.success(dormitoryService.count());
    }
}
