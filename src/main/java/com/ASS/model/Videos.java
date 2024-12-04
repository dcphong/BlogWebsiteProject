package com.ASS.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.*;

import java.util.List;
import java.util.Set;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
@Entity
public class Videos {
    @Id
    @Column(name = "Id")
    private String id;

    @Column(name = "Title", nullable = false)
    private String title;

    @Column(name = "Poster")
    private String poster;

    @Column(name = "Views", columnDefinition = "INT DEFAULT 0")
    private int views;

    @Column(name = "Description", nullable = true)
    private String description;

    @Column(name = "Active", columnDefinition = "BIT DEFAULT 1")
    private boolean active;

    @OneToMany(mappedBy = "video", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    @JsonIgnore
    private List<Favorites> favorites;

    @OneToMany(mappedBy = "video", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    @JsonIgnore
    private Set<Share> shares;

}
