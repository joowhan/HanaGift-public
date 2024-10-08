package com.kopo.hanagift.service;

import com.kopo.hanagift.dto.Gift;
import com.kopo.hanagift.dto.JoinedGift;
import com.kopo.hanagift.mapper.GiftMapper;
import com.kopo.hanagift.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.flyway.FlywayDataSource;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

@Service
public class GiftService {

    @Autowired
    private GiftMapper giftMapper;

    @Autowired
    private UserMapper userMapper;

    public void saveGift(
            String productID, String senderID, String productCategory,
            String receiverID, double amount, String currencyUnit) {
        Gift gift = new Gift();
        gift.setGiftID(UUID.randomUUID().toString());
        gift.setProductID(productID);
        gift.setSenderID(senderID);
        gift.setStatus("SENT"); // 기본 상태를 'SENT'로 설정
        gift.setProductCategory(productCategory);
        gift.setReceiverID(receiverID);
        gift.setAmount(amount);
        gift.setCurrencyUnit(currencyUnit);
        giftMapper.insertGift(gift);
    }

    public List<JoinedGift> getReceivedGifts(String userId) {
        return giftMapper.getReceivedGifts(userId);
    }

    public List<JoinedGift> getSentGifts(String userId) {
        return giftMapper.getSentGifts(userId);
    }

    public void updateGiftStatusToReceived(String giftId, String userId){
        giftMapper.updateGiftStatusToReceived(giftId,userId);
    }
}
