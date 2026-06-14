package com.dormitory.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import java.time.LocalDateTime;

@TableName("repair_order")
public class RepairOrder {
    private Long id;
    private Long userId;
    private Long dormitoryId;
    private String title;
    private String repairType;
    private String description;
    private String status;
    private LocalDateTime createTime;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Long getUserId() { return userId; }
    public void setUserId(Long userId) { this.userId = userId; }
    public Long getDormitoryId() { return dormitoryId; }
    public void setDormitoryId(Long dormitoryId) { this.dormitoryId = dormitoryId; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getRepairType() { return repairType; }
    public void setRepairType(String repairType) { this.repairType = repairType; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public LocalDateTime getCreateTime() { return createTime; }
    public void setCreateTime(LocalDateTime createTime) { this.createTime = createTime; }
}
