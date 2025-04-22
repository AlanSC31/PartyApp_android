package com.partyapp.catalogo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.partyapp.catalogo.model.Profile;
import com.partyapp.catalogo.service.ProfileService;

@RestController
@RequestMapping("/profiles")
public class ProfileController {

    @Autowired
    private ProfileService profileServ;

    // create profile
    @PostMapping("/profile-create")
    public ResponseEntity<String> registerUser(@RequestBody Profile profile) {
        try {
            profileServ.registerProfile(profile);
            return ResponseEntity.ok("profile creado con exito");
        } catch (Exception e) {
            return ResponseEntity
                    .status(HttpStatus.BAD_REQUEST)
                    .body("Error en el registro: " + e.getMessage());
        }
    }

    // retrieve profile
    @GetMapping("/profile-retrieve")
    public ResponseEntity<?> retrieveProfile() {
        try {
            List<Profile> perfiles = profileServ.retrieveProfile();
            return ResponseEntity.ok(perfiles);
        } catch (Exception e) {
            return ResponseEntity
                    .status(HttpStatus.BAD_REQUEST)
                    .body("Error en el registro: " + e.getMessage());
        }
    }

    // retrieve profile by uid
    // @GetMapping("/profile-retrieve-by-uid")
    // public ResponseEntity<?> retrieveProfileByUid(@RequestParam String uid) {
    //     try {
    //         Profile perfil = profileServ.retrieveProfileByUid(uid); // Llamar al servicio para obtener el perfil por uid
    //         return ResponseEntity.ok(perfil);
    //     } catch (Exception e) {
    //         return ResponseEntity
    //                 .status(HttpStatus.BAD_REQUEST)
    //                 .body("Error en la búsqueda del perfil: " + e.getMessage());
    //     }
    // }
    @GetMapping("/profile-retrieve-by-uid")
    public Profile retrieveProfileByUid(@RequestParam String uid) throws Exception {
        return profileServ.retrieveProfileByUid(uid);
    }

}
