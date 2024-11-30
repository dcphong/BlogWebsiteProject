package com.ASS.DTO;

import lombok.*;

import java.util.Date;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString

public class VideoShareInfoDTO {
    private String videoTitle;
    private long shareCount;
    private Date firstShareDate;
    private Date lastShareDate;
}
