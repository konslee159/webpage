package com.example.broadcasting.entity;

public class Notice {
    private String title;
    private String content;

    public Notice(String title, String content) {
        this.title = title;
        this.content = content;
    }

    public String getTitle() {
        return title;
    }

    public String getContent() {
        return content;
    }
}