package com.ASS.interfaces;

import com.ASS.model.Favorites;

public interface FavoritesInterface {
    Favorites getFavByUserLiked(String uId, String vId);
}
