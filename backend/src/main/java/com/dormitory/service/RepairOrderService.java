package com.dormitory.service;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.dormitory.entity.RepairOrder;
import com.dormitory.mapper.RepairOrderMapper;
import org.springframework.stereotype.Service;

@Service
public class RepairOrderService extends ServiceImpl<RepairOrderMapper, RepairOrder> {
}
