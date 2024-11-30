package com.ASS.interfaces;

import com.ASS.model.Videos;

import java.util.List;

public interface VideoInterface {
    List<Videos> getNextVideosList(int amount);

    List<String> getSuggestionVideo(String title);

    List<Videos> getListVideoByTitle(String title);

    List<Videos> getVideosByPageNumber(int currentPage, int pageSize);

    int getPageNumbersSize(int elementsNumber);

    List<Videos> getTop10VideoList();

    List<Videos> getVideoNoOneLiked();

    List<Videos> getVideoIn2024();

}
