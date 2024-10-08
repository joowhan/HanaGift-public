package com.kopo.hanagift.service;

import com.kopo.hanagift.dto.Reviews;
import com.kopo.hanagift.mapper.ReviewMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReviewService {
    @Autowired
    private ReviewMapper reviewMapper;

    public List<Reviews> findAllReviewsById(String productId){
        return reviewMapper.findAllReviewById(productId);
    }
    public void saveReview(Reviews review){
        reviewMapper.insertReview(review);
    }

}
