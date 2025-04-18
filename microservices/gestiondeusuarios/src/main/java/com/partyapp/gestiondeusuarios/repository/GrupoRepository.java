package com.partyapp.gestiondeusuarios.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.partyapp.gestiondeusuarios.model.Grupo;

@Repository
public interface GrupoRepository extends JpaRepository<Grupo, Long>{
    Grupo findByEmail(String email);
    Grupo findByUid(String uid);

}