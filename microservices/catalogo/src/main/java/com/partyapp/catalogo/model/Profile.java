package com.partyapp.catalogo.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "profile")
public class Profile{

    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    private Long id;
    private String name;
    private String genre;
    private String availability;
    private String rate;
    private String uid;

    //Getters and Setters
    public Long getId(){
        return id;
    }

    public void setId(Long id){
        this.id = id;
    }

    public String getName(){
        return name;
    }

    public void setId(String name){
        this.name = name;
    }

    public String getGenre(){
        return genre;
    }

    public void setGenre(String genre){
        this.genre = genre;
    }

    public String getavAilability(){
        return availability;
    }

    public void setAvailability(String availability){
        this.availability = availability;
    }

    public String getRate(){
        return rate;
    }

    public void setRate(String rate){
        this.rate = rate;
    }

    public String getUid(){
        return uid;
    }

    public void setUid(String uid){
        this.uid = uid;
    }
}