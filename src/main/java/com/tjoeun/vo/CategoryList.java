package com.tjoeun.vo;
//	카테고리 목록을 기억하는 클래스

import java.util.ArrayList;

public class CategoryList {
	
	private ArrayList<CategoryVO> list = new ArrayList<>();
	
	public ArrayList<CategoryVO> getList(){
		return list;
	}
	public void setList(ArrayList<CategoryVO> list) {
		this.list= list;
	}
	@Override
	public String toString() {
		return "CategoryList [list=" + list + "]";
	}
}
