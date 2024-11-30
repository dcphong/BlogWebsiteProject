package com.ASS.model;

import jakarta.persistence.*;
import lombok.*;

import java.util.Date;


@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
@Entity
public class Share {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "UserId", nullable = false)
    private Users user;

    @ManyToOne
    @JoinColumn(name = "VideoId", nullable = false)
    private Videos video;

    @Lob
    private String emails;
    @Temporal(TemporalType.DATE)
    private Date shareDate;

}

