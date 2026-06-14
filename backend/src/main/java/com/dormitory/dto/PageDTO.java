package com.dormitory.dto;

public class PageDTO {
    private int current = 1;
    private int size = 10;

    public int getCurrent() { return current; }
    public void setCurrent(int current) { this.current = current; }
    public int getSize() { return size; }
    public void setSize(int size) { this.size = size; }
}
