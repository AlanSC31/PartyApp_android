package com.partyapp.catalogo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.partyapp.catalogo.model.Profile;
import com.partyapp.catalogo.repository.ProfileRepository;

@Service
public class ProfileService {

    @Autowired
    private ProfileRepository profileRep;

    // create profile
    public Profile registerProfile(Profile profile) throws Exception {

        return profileRep.save(profile);
    }

    // retrieve profile
    public List<Profile> retrieveProfile() throws Exception {
        return profileRep.findAll();
    }

    // retrieve profile by uid
    public Profile retrieveProfileByUid(String uid) throws Exception {
      Profile profile = profileRep.findByUid(uid); 
      if (profile == null) {
         throw new Exception("Perfil no encontrado con el UID: " + uid);
      }
      return profile;
   }

}
