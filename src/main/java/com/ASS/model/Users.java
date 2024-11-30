package com.ASS.model;

import jakarta.persistence.*;
import lombok.*;

import java.util.List;
import java.util.Set;

@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@Builder
@Entity
public class Users {
    @Id
    private String id;

    @Column(nullable = false)
    private String password;

    @Column(nullable = false, unique = true)
    private String email;

    private String fullname;

    @Column(columnDefinition = "BIT DEFAULT 0")
    private boolean admin;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    private List<Favorites> favorites;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    private Set<Share> shares;

    @Override
    public String toString() {
        return "Users{" +
                "admin=" + admin +
                ", id='" + id + '\'' +
                ", password='" + password + '\'' +
                ", email='" + email + '\'' +
                ", fullname='" + fullname + '\'' +
                ", favorites=" + favorites +
                '}';
    }
}
