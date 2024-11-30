package com.ASS.model;

import jakarta.persistence.*;
import lombok.*;

import java.util.Date;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Builder
@Entity
public class Favorites {
    @Id
    @Column(name="Id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "UserId", nullable = false)
    private Users user;

    @ManyToOne
    @JoinColumn(name = "VideoId", nullable = false)
    private Videos video;

    @Column(name="LikeDate")
    @Temporal(TemporalType.DATE)
    private Date likeDate;
}
