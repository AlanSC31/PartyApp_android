package com.partyapp.catalogo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.partyapp.catalogo.model.Profile;

@Repository
public interface ProfileRepository extends JpaRepository<Profile, Long>{
    Profile findById(int id);
    Profile findByUid(String uid);

    }

