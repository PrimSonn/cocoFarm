package cocoFarm.service;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import cocoFarm.dao.Auction_Dao;
import cocoFarm.dto.Auction;
import cocoFarm.dto.Auction_Inquire;
import cocoFarm.util.Auction_Paging;

@Service
public class Auction_ServiceImpl implements Auction_Service {

	@Autowired Auction_Dao auctionDao;
	@Autowired ServletContext context;
	
	@Override
	public void write(Auction auction) {
		
		MultipartFile file = auction.getImg_file();
		if(file != null && !file.isEmpty()) {
			// 파일 업로드
			String path = context.getRealPath("/resources/img/auction_img");
			System.out.println(path);
			String filename = UUID.randomUUID().toString().split("-")[0]+"_"+file.getOriginalFilename();
			File dest = new File(path, filename);

			try {
				file.transferTo(dest);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			// DB 기록
			auction.setItem_img(filename);
			auctionDao.write(auction);
			System.out.println(dest);
//			
//			BoardFile boardFile = new BoardFile();
//			boardFile.setBoardno(board.getBoardno());
//			boardFile.setOriginal_filename(file.getOriginalFilename());
//			boardFile.setStored_filename(filename);
//			
//			boardDao.insertFile(boardFile);
		}
	}

	@Override
	public List getList() {
		return auctionDao.selectAll();
	}

	@Override
	public int getTotal() {
		return auctionDao.countAll();
	}

	@Override
	public int getTotal(Auction_Paging search) {
		return auctionDao.countSearch(search);
	}

	@Override
	public List getPagingList(Auction_Paging paging) {
		return auctionDao.selectPage(paging);
	}

	@Override
	public List getSearchPagingList(Auction_Paging search) {
		return auctionDao.selectPageSearch(search);
	}

	@Override
	public Auction auctionView(Auction viewAuction) {
		
		return auctionDao.selectAuctionByAuctionIDX(viewAuction);
	}

	@Override
	public void insertInquire(Auction_Inquire inquire) {
		auctionDao.insertInquire(inquire);
	}

}
