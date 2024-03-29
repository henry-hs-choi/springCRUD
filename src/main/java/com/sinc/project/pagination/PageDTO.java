package com.sinc.project.pagination;

public class PageDTO {

    private int startPage;

    private int endPage;

    private boolean prev, next;

    

    private int total;

    private Criteria cri;

    private static final int SIZE = 8;

    public PageDTO(Criteria cri, int total) {
        

        this.cri = cri;

        this.total = total;

        this.endPage = (int)(Math.ceil(cri.getPageNum() / (double)SIZE)) * SIZE;

        this.startPage = this.endPage - (SIZE-1);

        int realEnd = (int)(Math.ceil((double)total / cri.getAmount()));
        

        if(realEnd < this.endPage) {

            this.endPage = realEnd;

        }

        

        this.prev = this.startPage > 1;

        this.next = this.endPage < realEnd;

        

    }



	public int getStartPage() {
		return startPage;
	}



	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}



	public int getEndPage() {
		return endPage;
	}



	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}



	public boolean isPrev() {
		return prev;
	}



	public void setPrev(boolean prev) {
		this.prev = prev;
	}



	public boolean isNext() {
		return next;
	}



	public void setNext(boolean next) {
		this.next = next;
	}



	public int getTotal() {
		return total;
	}



	public void setTotal(int total) {
		this.total = total;
	}



	public Criteria getCri() {
		return cri;
	}



	public void setCri(Criteria cri) {
		this.cri = cri;
	}



	@Override
	public String toString() {
		return "PageDTO [startPage=" + startPage + ", endPage=" + endPage + ", prev=" + prev + ", next=" + next
				+ ", total=" + total + ", cri=" + cri + "]";
	}   


}
