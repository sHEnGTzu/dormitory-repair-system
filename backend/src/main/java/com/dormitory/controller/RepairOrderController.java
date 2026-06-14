package com.dormitory.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.dormitory.dto.PageDTO;
import com.dormitory.dto.PageVO;
import com.dormitory.dto.RepairOrderVO;
import com.dormitory.dto.Result;
import com.dormitory.entity.Dormitory;
import com.dormitory.entity.RepairOrder;
import com.dormitory.entity.User;
import com.dormitory.service.DormitoryService;
import com.dormitory.service.RepairOrderService;
import com.dormitory.service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/repair-order")
public class RepairOrderController {

    private final RepairOrderService repairOrderService;
    private final UserService userService;
    private final DormitoryService dormitoryService;

    public RepairOrderController(RepairOrderService repairOrderService, UserService userService, DormitoryService dormitoryService) {
        this.repairOrderService = repairOrderService;
        this.userService = userService;
        this.dormitoryService = dormitoryService;
    }

    @PostMapping("/add")
    public Result<Void> add(HttpServletRequest request, @RequestBody RepairOrder order) {
        Long userId = (Long) request.getAttribute("userId");
        if (order.getTitle() == null || order.getTitle().trim().isEmpty()) {
            throw new RuntimeException("报修标题不能为空");
        }
        if (order.getDormitoryId() == null) {
            throw new RuntimeException("请选择所属宿舍");
        }
        order.setUserId(userId);
        order.setStatus("待处理");
        order.setCreateTime(LocalDateTime.now());
        repairOrderService.save(order);
        return Result.success();
    }

    @PostMapping("/edit")
    public Result<Void> edit(HttpServletRequest request, @RequestBody RepairOrder order) {
        Long userId = (Long) request.getAttribute("userId");
        RepairOrder exist = repairOrderService.getById(order.getId());
        if (exist == null) {
            throw new RuntimeException("记录不存在");
        }
        // 学生只能修改自己的报修单，管理员可修改所有
        if (!"管理员".equals(getRole(userId)) && !exist.getUserId().equals(userId)) {
            throw new RuntimeException("无权操作该记录");
        }
        if (!"待处理".equals(exist.getStatus())) {
            throw new RuntimeException("只能修改待处理的报修单");
        }
        if (order.getTitle() != null) exist.setTitle(order.getTitle());
        if (order.getRepairType() != null) exist.setRepairType(order.getRepairType());
        if (order.getDescription() != null) exist.setDescription(order.getDescription());
        repairOrderService.updateById(exist);
        return Result.success();
    }

    @PostMapping("/delete")
    public Result<Void> delete(HttpServletRequest request, @RequestBody RepairOrder param) {
        Long userId = (Long) request.getAttribute("userId");
        RepairOrder exist = repairOrderService.getById(param.getId());
        if (exist == null) {
            throw new RuntimeException("记录不存在");
        }
        // 学生只能删除自己的报修单，管理员可删除所有
        if (!"管理员".equals(getRole(userId)) && !exist.getUserId().equals(userId)) {
            throw new RuntimeException("无权操作该记录");
        }
        if (!"待处理".equals(exist.getStatus())) {
            throw new RuntimeException("只能删除待处理的报修单");
        }
        repairOrderService.removeById(param.getId());
        return Result.success();
    }

    /** 更新报修状态（管理员专用） */
    @PostMapping("/update-status")
    public Result<Void> updateStatus(HttpServletRequest request, @RequestBody RepairOrder param) {
        Long userId = (Long) request.getAttribute("userId");
        if (!"管理员".equals(getRole(userId))) {
            throw new RuntimeException("无权操作，仅管理员可修改报修状态");
        }
        RepairOrder exist = repairOrderService.getById(param.getId());
        if (exist == null) {
            throw new RuntimeException("记录不存在");
        }
        if (param.getStatus() == null) {
            throw new RuntimeException("状态不能为空");
        }
        exist.setStatus(param.getStatus());
        repairOrderService.updateById(exist);
        return Result.success();
    }

    @PostMapping("/list/page")
    public Result<PageVO<RepairOrderVO>> pageList(HttpServletRequest request, @RequestBody PageDTO pageDTO) {
        Long userId = (Long) request.getAttribute("userId");
        String role = getRole(userId);

        LambdaQueryWrapper<RepairOrder> wrapper = new LambdaQueryWrapper<RepairOrder>()
                .orderByDesc(RepairOrder::getId);
        // 学生只能看自己的报修单，管理员看所有
        if (!"管理员".equals(role)) {
            wrapper.eq(RepairOrder::getUserId, userId);
        }

        com.baomidou.mybatisplus.extension.plugins.pagination.Page<RepairOrder> page =
                repairOrderService.page(
                        new com.baomidou.mybatisplus.extension.plugins.pagination.Page<>(pageDTO.getCurrent(), pageDTO.getSize()),
                        wrapper
                );

        // 转换为VO，填充学生姓名和宿舍信息
        List<RepairOrderVO> voList = buildVOList(page.getRecords());
        PageVO<RepairOrderVO> vo = new PageVO<>(page.getCurrent(), page.getSize(), page.getTotal(), voList);
        return Result.success(vo);
    }

    /** 获取报修单数量统计 */
    @PostMapping("/count")
    public Result<java.util.Map<String, Long>> count(HttpServletRequest request) {
        Long userId = (Long) request.getAttribute("userId");
        String role = getRole(userId);

        LambdaQueryWrapper<RepairOrder> wrapper = new LambdaQueryWrapper<>();
        if (!"管理员".equals(role)) {
            wrapper.eq(RepairOrder::getUserId, userId);
        }
        long total = repairOrderService.count(wrapper);

        LambdaQueryWrapper<RepairOrder> pendingWrapper = new LambdaQueryWrapper<>();
        pendingWrapper.eq(RepairOrder::getStatus, "待处理");
        if (!"管理员".equals(role)) {
            pendingWrapper.eq(RepairOrder::getUserId, userId);
        }
        long pending = repairOrderService.count(pendingWrapper);

        java.util.Map<String, Long> map = new java.util.HashMap<>();
        map.put("total", total);
        map.put("pending", pending);
        return Result.success(map);
    }

    private String getRole(Long userId) {
        User user = userService.getById(userId);
        return user != null ? user.getRole() : "学生";
    }

    private List<RepairOrderVO> buildVOList(List<RepairOrder> records) {
        if (records == null || records.isEmpty()) return new ArrayList<>();

        // 批量查询用户和宿舍信息
        List<Long> userIds = records.stream().map(RepairOrder::getUserId).distinct().collect(Collectors.toList());
        List<Long> dormIds = records.stream().map(RepairOrder::getDormitoryId).distinct().collect(Collectors.toList());

        Map<Long, User> userMap = userService.listByIds(userIds).stream().collect(Collectors.toMap(User::getId, u -> u));
        Map<Long, Dormitory> dormMap = dormitoryService.listByIds(dormIds).stream().collect(Collectors.toMap(Dormitory::getId, d -> d));

        return records.stream().map(order -> {
            RepairOrderVO vo = new RepairOrderVO(order);
            User u = userMap.get(order.getUserId());
            if (u != null) {
                vo.setStudentName(u.getRealName());
            }
            Dormitory d = dormMap.get(order.getDormitoryId());
            if (d != null) {
                vo.setBuilding(d.getBuilding());
                vo.setFloorNum(d.getFloorNum());
                vo.setRoomNum(d.getRoomNum());
            }
            return vo;
        }).collect(Collectors.toList());
    }
}
