package com.dormitory.dto;

import com.dormitory.entity.RepairOrder;
import java.time.LocalDateTime;

public class RepairOrderVO {
    private Long id;
    private Long userId;
    private Long dormitoryId;
    private String title;
    private String repairType;
    private String description;
    private String status;
    private LocalDateTime createTime;
    // 扩展显示字段
    private String studentName;
    private String building;
    private Integer floorNum;
    private String roomNum;

    public RepairOrderVO() {}

    public RepairOrderVO(RepairOrder order) {
        this.id = order.getId();
        this.userId = order.getUserId();
        this.dormitoryId = order.getDormitoryId();
        this.title = order.getTitle();
        this.repairType = order.getRepairType();
        this.description = order.getDescription();
        this.status = order.getStatus();
        this.createTime = order.getCreateTime();
    }

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
    public String getStudentName() { return studentName; }
    public void setStudentName(String studentName) { this.studentName = studentName; }
    public String getBuilding() { return building; }
    public void setBuilding(String building) { this.building = building; }
    public Integer getFloorNum() { return floorNum; }
    public void setFloorNum(Integer floorNum) { this.floorNum = floorNum; }
    public String getRoomNum() { return roomNum; }
    public void setRoomNum(String roomNum) { this.roomNum = roomNum; }
}
