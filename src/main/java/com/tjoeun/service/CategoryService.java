package com.tjoeun.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;

import com.tjoeun.dao.CategoryDAO;
import com.tjoeun.mybatis.MySession;
import com.tjoeun.vo.CategoryList;
import com.tjoeun.vo.CategoryVO;

public class CategoryService {
	private static CategoryService instance = new CategoryService();
	private CategoryService(){}
	public static CategoryService getInstance() {
		return instance;
	}
	
//	insert.jsp에서 호출되는 테이블에 저장할 메인 카테고리 정보가 저장된 객체를 넘겨받고 mapper를 얻어온 후
//	CategoryDAO클래스의 메인 카테고리를 저장하는 insert sql 명령을 실행하는 메소드를 호출하는 메소드
	public void insert(CategoryVO vo) {
		System.out.println("CategoryService의 insert()메소드");
//		mapper를 얻어온다
		SqlSession mapper = MySession.getSession();
//		System.out.println("연결 성공 : " + mapper);
		
//		CategoryDAO 클래스의 insert sql 명령을 실행하는 메소드를 호출한다.
		CategoryDAO.getInstance().insert(mapper, vo);

//		실행한 sql 명령이 테이블을 변경하는 insert, delete, update sql 명령일 경우 작업 결과를 테이블에
//		반영시키기 위해 작업이 완료되면 반드시 commit() 메소드를 실행해야 한다.
//		테이블이 변경되지 않는 select sql 명령은 commit() 메소드를 실행하지 않아도 상관없다.
		mapper.commit();
		
//		mapper를 사용한 데이터베이스 작업이 완료되면 반드시 mapper를 닫아야 한다.
		mapper.close(); //	필수
	}
//	list.jsp에서 호출되는 mapper를 얻어온 후 CategoryDAO클래스의 테이블에 저장된 전체 카테고리 목록을 얻어오는
//	select sql 명령을 실행하는 메소드를 호출하는 메소드
	public CategoryList selectList() {
		System.out.println("CategoryService의 selectList()메소드");
		SqlSession mapper = MySession.getSession();
		
//		전체 카테고리 목록을 저장해서 리터시킬 객체를 선언한다.
		CategoryList categoryList = new CategoryList();
//		테이블에서 얻어온 전체 카테고리 모록을 CategoryList 클래스의 ArrayList에 저장한다.
		categoryList.setList(CategoryDAO.getInstance().selectList(mapper));
//		System.out.println(categoryList);
		
		mapper.close();
		return categoryList;
	}
//	reply.jsp에서 호출되는 테이블에 저장할 서브 카테고리 정보가 저장된 개겣를 넘겨받고 mapper를 얻어온 후
//	CategoryDAO 클래스의 서브 카테고리를 저장하는 insert sql 명령을 실행하는 메소드를 호출하는 메소드
	public void reply(CategoryVO vo) {
		System.out.println("CategoryService의 selectList()메소드");
		SqlSession mapper = MySession.getSession();
		CategoryDAO dao = CategoryDAO.getInstance();
		
		//	서브 카테고리가 삽입될 위치를 결정하기 위해서 lev와 seq를 각각 1씩 증가시킨다.
		//	서브 카테고리의 레벨은 부모 카테고리 레벨보다 1크다.
		vo.setLev(vo.getLev() + 1);
		//	서브 카테고리가 부모 카테고리 바로 아래 나와야 하므로 출력 순서는 부모 카테고리보다 1커야 한다.
		vo.setSeq(vo.getSeq() + 1);
		
		//	서브 카테고리를 위치에 맞게 삽입하기 위해서 같은 카테고리 그룹(gup)의 카테고리 출력 순서(seq)를
		//	조정하는 메소드를 실행한다.update
		HashMap<String, Integer> hmap = new HashMap<>();
		hmap.put("gup", vo.getGup());
		hmap.put("seq", vo.getSeq());
		dao.increment(mapper,hmap); // update
		
		// 서브 카테고리를 테이블에 저장하는 메소드를 호출한다.
		dao.reply(mapper,vo); //insert
		
		//	서브 카테고리를 테이블에 저장하는 메소드를 호출한다. insert
		
		mapper.commit();
		mapper.close();
	}
	
//	delete.jsp 에서 호출되는 삭제할 카테고리 번호를 넘겨받고 mapper를 얻어온 후 CategoryDAO 클래스의
//	카테고리 1건을 얻어오는 select sql 명령을 실행하는 메소드를 호출하는 메소드
	public CategoryVO selectByIdx(int idx) {
		System.out.println("CategoryService의 selectByIdx()메소드");
		SqlSession mapper = MySession.getSession();
		CategoryVO vo = CategoryDAO.getInstance().selectByIdx(mapper,idx);
		mapper.close();
		return vo;
	}
	
//	delete.jsp 에서 호출되는 삭제할 카테고리 번호를 넘겨받고 mapper를 얻어온 후 CategoryDAO 클래스의
//	카테고리 1건을 삭제하는 select sql 명령을 실행하는 메소드를 호출하는 메소드
	public void delete(int idx) {
		System.out.println("CategoryService의 delete()메소드");
		SqlSession mapper = MySession.getSession();
		
		CategoryDAO dao = CategoryDAO.getInstance();
//		CategoryVO vo = dao.selectByIdx(mapper, idx);
//		
//		HashMap<String, Integer>hmap = new HashMap<>();
//		hmap.put("gup",vo.getGup());
//		hmap.put("seq",vo.getSeq());
//		dao.decrement(mapper,hmap);
		
		CategoryDAO.getInstance().delete(mapper,idx);

		mapper.commit();
		mapper.close();
	}
	
	
//	delete.jsp에서 호출되는 수정할 카테고리 번호를 넘겨받고 mapper를 얻어온 후 CategoryDAO 클래스의
//	카테고리 1건을 "삭제된 카테고리입니다" 로 수정하는 update sql 명령을 실행하는 메소드를 호출하는 메소드
	public void deletedCategory(int idx) {
		System.out.println("CategoryService의 deletedCategory() 메소드");
		SqlSession mapper = MySession.getSession();
		
		CategoryDAO.getInstance().deletedCategory(mapper,idx);
		mapper.commit();
		mapper.close();
	}
	
//	delete.jsp에서 호출되는 수정할 카테고리 번호를 넘겨받고 mapper를 얻어온 후 CategoryDAO 클래스의
//	카테고리 1건의 deleteCheck 필드의 값을 "YES"로 수정하는 update sql 명령을 실행하는 메소드를 호출하는 메소드
	public void deleteCheck(int idx) {
		System.out.println("CategoryService의 deleteCheck()메소드");
		SqlSession mapper = MySession.getSession();
		
		CategoryDAO.getInstance().deleteCheck(mapper,idx);
		
		mapper.commit();
		mapper.close();
	}
	
//	restore.jsp에서 호출되는 수정할 카테고리 번호를 넘겨받고 mapper를 얻어온 후 CategoryDAO클래스의
//	카테고리 1건의 deleteCheck의 필드 값을 "NO"로 수정하는 update sql 명령을 실행하는 메소드를 호출하는 메소드
	public void restore(int idx) {
		System.out.println("CategoryService의 restore()메소드");
		SqlSession mapper = MySession.getSession();
		
		CategoryDAO.getInstance().restore(mapper,idx);
		
		mapper.commit();
		mapper.close();
	}
	
//	update.jsp 에서 호출되는 수정할 카테고리정보가 저장된 객체를 넘겨받고 mapper를 얻어온 후
//	CategoryDAO 클래스의 카테고리 1건을 수정하는 update sql 명령을 실행하는 메소드를 호출하는 메소드
	public void update(CategoryVO vo) {
		System.out.println("CategoryService의 update()메소드");
		SqlSession mapper = MySession.getSession();
		
		CategoryDAO.getInstance().update(mapper,vo);
		
		mapper.commit();
		mapper.close();
		
	}
	
//	report.jsp에서 호출되는 신고할 카테고리 번호를 넘겨받고 mapper를 얻어온 후 CategoryDAO 클래스의 
//	카테고리 1건의 report 필드의 값을 1증가(수정) 시키는 update sql 명령을 실행하는 메소드를
//	호출하는 메소드
	public void report(int idx) {
		System.out.println("CategoryService의 report()메소드");
		SqlSession mapper = MySession.getSession();
		
		CategoryDAO.getInstance().report(mapper,idx);
		
		mapper.commit();
		mapper.close();
	}
	
//	delete.jsp에서 호출되는 삭제할 카테고리 정보가 저장된 객체를 넘겨받고 mapper를 얻어온 후
//	CategoryDAO 클래스의 삭제할 카테고리 목록을 얻어오는 select sql 명령을 실행하는 메소드를
//	호출하는 메소드
	public ArrayList<CategoryVO> deleteList(CategoryVO vo){
		System.out.println("CategoryService의 seleteList()메소드");
		SqlSession mapper = MySession.getSession();
		
		ArrayList<CategoryVO> deleteList = CategoryDAO.getInstance().deleteList(mapper,vo);
		
		mapper.close();
		return deleteList;
	}
	
//	delete.jsp에서 호출되는 seq를 다시 부여할 카테고리 그룹(gup)을 넘겨받고 mapper를 얻어온 후
//	CategoryDAO 클래스의 삭제한 카테고리 그룹에 seq를 0부터 1씩 증가하게 다시 부여하는 update sql 명령을
//	실행하는 메소드를 호출하는 메소드
	public void reSeq(int gup) {
		System.out.println("CategoryService의 reSeq()메소드");
		SqlSession mapper = MySession.getSession();
		CategoryDAO dao = CategoryDAO.getInstance();
		
		//	seq를 다시 부여할 카테고리 그룹만 얻어와서 ArrayList에 저장한다.
		ArrayList<CategoryVO> gupList = dao.selectGup(mapper, gup);
		//	ArrayList로 얻어온 카테고리 그룹의 카테고리 개수만큼 반복하며 seq를 0부터 다시 부여한다.
		for ( int i=0; i<gupList.size();i++) {
			HashMap<String,Integer> hmap = new HashMap<>();
			hmap.put("idx", gupList.get(i).getIdx());
			hmap.put("i",i);
			dao.reSeq(mapper,hmap);
		}
		mapper.commit();
		mapper.close();
	}
	
}
