package com.dormitory.service;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.dormitory.entity.Dormitory;
import com.dormitory.mapper.DormitoryMapper;
import org.springframework.stereotype.Service;

@Service
public class DormitoryService extends ServiceImpl<DormitoryMapper, Dormitory> {
}
