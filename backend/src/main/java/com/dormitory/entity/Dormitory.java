package com.dormitory.entity;

import com.baomidou.mybatisplus.annotation.TableName;

@TableName("dormitory")
public class Dormitory {
    private Long id;
    private String building;
    private Integer floorNum;
    private String roomNum;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getBuilding() { return building; }
    public void setBuilding(String building) { this.building = building; }
    public Integer getFloorNum() { return floorNum; }
    public void setFloorNum(Integer floorNum) { this.floorNum = floorNum; }
    public String getRoomNum() { return roomNum; }
    public void setRoomNum(String roomNum) { this.roomNum = roomNum; }
}
