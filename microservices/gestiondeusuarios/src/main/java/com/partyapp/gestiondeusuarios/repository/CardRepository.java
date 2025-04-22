package com.partyapp.gestiondeusuarios.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.partyapp.gestiondeusuarios.model.Card;

@Repository
public interface CardRepository extends JpaRepository<Card, Long>{
    Card findByUid(String uid);
    boolean existsByNumber(String number);
    Card findByNumber(String number);

}